/* 
    CREATED BY BOTA DUISENBAY 
    11 AUG 2020
    HOMEWORK 1
*/
--CREATING NEW DATABASE, WHERE ALL TABLES WILL BE STORED
CREATE DATABASE MY_SECOND_DB
USE MY_SECOND_DB

CREATE TABLE EMPLOYEES(
    ID int NOT NULL IDENTITY(1,1) PRIMARY KEY
    , NAME varchar(30) NOT NULL
    , SURNAME varchar(30) NOT NULL
    , POSITION varchar(30) NOT NULL
    , BIRTHDAY DATE NOT NULL
    , SALARY decimal(6,2) NOT NULL
)


INSERT INTO EMPLOYEES (NAME, SURNAME, POSITION, BIRTHDAY, SALARY)
VALUES ('John','Doe','manager','1991.01.01', '1500.03')
    ,  ('Max','Johns','cashier','1993.02.01', '500.13')
    ,  ('Kate','Keys','cashier','1995.09.01', '500.13')
    ,  ('Alicia','Robins','consultant','1992.10.22', '543.73')
    ,  ('Sam','Smith','security','1989.03.30', '400.99')


CREATE TABLE CONTRACTOR(
    Contractor_ID       int         NOT NULL IDENTITY(2,1) --why you start from 2? do you have logic explanation?
    , COMPANY_NAME      varchar(30) NOT NULL
    , CATEGORY          varchar(30) NOT NULL PRIMARY KEY
    , CONTACT_NUMBER    int         NOT NULL
    , EMAIL             varchar(64)
    , WEBSITE           varchar(64)
    , CONTRACT_DUE      date        NOT NULL
)

CREATE TABLE PRODUCTS (
    Product_ID      int         NOT NULL    PRIMARY KEY -- if you use primary key, please use also not null 
	, TITLE         varchar(64) NOT NULL
    , DESCRIPTION   text
    , MANUFACTURER  varchar(64)
    , CATEGORY      varchar(30) NOT NULL    FOREIGN KEY REFERENCES CONTRACTOR(CATEGORY)
)

CREATE TABLE PRICES(
    COST            decimal(6,2)    NOT NULL
    , SELLING_PRICE decimal(6,2)    NOT NULL
    ,  Product_ID   int             NOT NULL   FOREIGN KEY REFERENCES PRODUCTS(Product_ID) --logically will be better if foreign key'll be in the end of script 
)

--FIRST INSERT
--you need to insert for fist table that have the PK and only after that you can insert other tables which have FK from this table

/*  <RESPONCE> 
(CONTRACTOR--category-->PRODUCTS--Product_ID-->PRICES)
CONTRACTOR table has only PK category(no FK), that goes as FK to PRODUCTS table. 
PRODUCTS table has PK Product_ID that goes as FK to PRICES table. 
PRICES table has no PK, only FK Product_ID

I understood my error, I didn't notice it.
I've changed this the last minute as I saw related discussion in the chat.
In my previous version product_id was PK in Prices and it went as FK to PRODUCTS table.

*/

INSERT INTO CONTRACTOR
VALUES ('XIAOMI', 'phone', 1403409,   'company1@gmail.com',   'company1.com', '2020.10.01')
    , ('ASUS', 'laptop', 4321400,   'com2@yahoo.com',       'com2.com',     '2021.01.22')
    , ('APPLE', 'ipad',   5678904,   'comkfrd@yahoo.com',    'comkf3d.ru',   '2021.11.02')
    , ('SAMSUNG', 'tablet',  5432534,   'com24@gmail.com',      'com44.com',    '2020.12.22')
    , ('UNKNOWN', 'charger', 1178905,   'comp3455nfd@gmail.com','comkf5.ru',    '2022.09.09')



--SECOND INSERT
INSERT INTO PRODUCTS (Product_ID, TITLE, CATEGORY, DESCRIPTION, MANUFACTURER )
VALUES (12352, 'G6',            'phone',    '4K@30fps, 1080p@30/60fps, HDR, 24-bit/192kHz stereo sound rec. Selfie camera, Single, 5 MP, f/2.2, 18mm.',      'LG')
    ,  (76543, 'MACBOOK PRO',   'laptop',   '2.5- or 2.9-GHz chip, 2.3 GHz quad-core Intel Core i7', 'APPLE')
    ,  (34683, 'IPHONE 11',     'phone',    'uses Apples A13 Bionic processor, which contains a third-generation neural engine.',             'APPLE')
    ,  (37023, 'GALAXY S6',     'phone',    '5.1-inch Super AMOLED Display, 1440 x 2560 pixels (577 ppi)',                  'SAMSUNG')
    ,  (39611, 'MACBOOK AIR',   'laptop',   ' MQD32 Intel 1800 MHz 128 GB 8192 MB Flash Har',    'APPLE')


--THIRD INSERT

/* in this script you have error 'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__PRICES__Product___3C69FB99". 
The conflict occurred in database "MY_SECOND_DB", table "dbo.PRODUCTS", column 'Product_ID'.
The statement has been terminated.'
When you insert values to the table, please look that table PRICES have Foreign key (PRODUCT_ID),
this means that firstly you need  to insert values the main table in you case it is PRODUCTS, 
only after that you can insert the table which have foreign key

*/
INSERT INTO PRICES
VALUES (100.00,  110.00,    12352)
    ,  (2334.22, 2999.99,   76543)
    ,  (1005.40, 1500.00,   34683)
    ,  (500,     799.99,    37023)
    ,  (1480.09, 1999.99,   39611)


--good
ALTER TABLE EMPLOYEES 
ALTER COLUMN SURNAME varchar(64);


--good
/* <RESPONCE>  Yes, '+=' means incrementing previous value by given amount and storing instead the previous one.
In this case it raises salary by one
*/
UPDATE EMPLOYEES
SET SALARY += 1 --can you explain why r use +=? do you know what is mean?
WHERE BIRTHDAY < '1990.01.01'
SELECT * FROM EMPLOYEES

--not updated (��������� �����: 0)
/* <RESPONCE> 
Ousp ! I overlooked that there is no one born earlier than '1989.01.01' in the table. 
Updates to '1990.01.01'. Works
*/
UPDATE EMPLOYEES
SET SALARY = 0
WHERE POSITION = 'fired' OR BIRTHDAY < '1990.01.01'
SELECT * FROM EMPLOYEES


--no update (��������� �����: 0)
/* <RESPONCE> updates the condition from cost<100 to cost<=101 and inserted data */
UPDATE PRICES
SET SELLING_PRICE = 1.2 * COST
WHERE COST <= 101
SELECT * FROM PRICES


--no update 
--(��������� �����: 0)
/* <RESPONCE> updates the condition from SELLING_PRICE < 100 to SELLING_PRICE<=150 */
UPDATE PRICES
SET SELLING_PRICE += 10.10
WHERE COST <= 100 AND SELLING_PRICE <= 150
SELECT * FROM PRICES


--no update (��������� �����: 0)
/* <RESPONCE> 
prolongs due date of contracts by 1 year, if it will expire in less than 3 month, compares with today
*/
UPDATE CONTRACTOR
SET CONTRACT_DUE = DATEADD(YEAR, 1, CONTRACT_DUE)
WHERE DATEDIFF(MONTH, CONTRACT_DUE, GETDATE()) < 3
SELECT * FROM CONTRACTOR

--good
/* <RESPONCE> 
increaments selected time-type (year/month/day) of 3rd input date (contract_due)
by the amount inserted as 2nd input and stores into date type variable 
in this case contratcs are prolonged by 1 year
*/
UPDATE CONTRACTOR
SET CONTRACT_DUE = DATEADD(YEAR, 1, CONTRACT_DUE) --do you know what do the dateadd? could you please explain?
FROM PRODUCTS
WHERE PRODUCTS.MANUFACTURER = CONTRACTOR.COMPANY_NAME

SELECT * FROM PRODUCTS
SELECT * FROM CONTRACTOR

-- you don't need to drop all these tables
DROP TABLE EMPLOYEES
DROP TABLE PRICES
DROP TABLE PRODUCTS
DROP TABLE CONTRACTOR