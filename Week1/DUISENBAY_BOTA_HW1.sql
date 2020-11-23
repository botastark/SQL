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
    Contractor_ID       int         NOT NULL IDENTITY(2,1)
    , COMPANY_NAME      varchar(30) NOT NULL
    , CATEGORY          varchar(30) NOT NULL PRIMARY KEY
    , CONTACT_NUMBER    int         NOT NULL
    , EMAIL             varchar(64)
    , WEBSITE           varchar(64)
    , CONTRACT_DUE      date        NOT NULL
)

CREATE TABLE PRODUCTS (
    Product_ID      int                     PRIMARY KEY
    , TITLE         varchar(64) NOT NULL
    , CATEGORY      varchar(30) NOT NULL    FOREIGN KEY REFERENCES CONTRACTOR(CATEGORY)
    , DESCRIPTION   text
    , MANUFACTURER  varchar(64)
)

CREATE TABLE PRICES(
    Product_ID      int             NOT NULL   FOREIGN KEY REFERENCES PRODUCTS(Product_ID)
    , COST          decimal(6,2)    NOT NULL
    , SELLING_PRICE decimal(6,2)    NOT NULL
)



INSERT INTO PRICES
VALUES (12352, 100.10,  110.10)
    ,  (76543, 2334.22, 2999.99)
    ,  (34683, 1005.40, 1500.00)
    ,  (37023, 500,     799.99)
    ,  (39611, 1480.09, 1999.99)

INSERT INTO CONTRACTOR
VALUES ('XIAOMI', 'phone', 1403409,   'company1@gmail.com',   'company1.com', '2020.10.01')
    , ('ASUS', 'laptop', 4321400,   'com2@yahoo.com',       'com2.com',     '2021.01.22')
    , ('APPLE', 'ipad',   5678904,   'comkfrd@yahoo.com',    'comkf3d.ru',   '2021.11.02')
    , ('SAMSUNG', 'tablet',  5432534,   'com24@gmail.com',      'com44.com',    '2020.12.22')
    , ('UNKNOWN', 'charger', 1178905,   'comp3455nfd@gmail.com','comkf5.ru',    '2022.09.09')

INSERT INTO PRODUCTS (Product_ID, TITLE, CATEGORY, DESCRIPTION, MANUFACTURER )
VALUES (12352, 'G6',            'phone',    '4K@30fps, 1080p@30/60fps, HDR, 24-bit/192kHz stereo sound rec. Selfie camera, Single, 5 MP, f/2.2, 18mm.',      'LG')
    ,  (76543, 'MACBOOK PRO',   'laptop',   '2.5- or 2.9-GHz chip, 2.3 GHz quad-core Intel Core i7', 'APPLE')
    ,  (34683, 'IPHONE 11',     'phone',    'uses Apples A13 Bionic processor, which contains a third-generation neural engine.',             'APPLE')
    ,  (37023, 'GALAXY S6',     'phone',    '5.1-inch Super AMOLED Display, 1440 x 2560 pixels (577 ppi)',                  'SAMSUNG')
    ,  (39611, 'MACBOOK AIR',   'laptop',   ' MQD32 Intel 1800 MHz 128 GB 8192 MB Flash Har',    'APPLE')




SELECT * FROM PRICES
SELECT * FROM PRODUCTS
SELECT * FROM CONTRACTOR
SELECT * FROM EMPLOYEES


ALTER TABLE EMPLOYEES 
ALTER COLUMN SURNAME varchar(64);


UPDATE EMPLOYEES
SET SALARY += 1
WHERE BIRTHDAY < '1990.01.01'

UPDATE EMPLOYEES
SET SALARY = 0
WHERE POSITION='fired' OR BIRTHDAY < '1989.01.01'


UPDATE PRICES
SET SELLING_PRICE = 1.2 * COST
WHERE COST < 100

UPDATE PRICES
SET SELLING_PRICE += 10.10
WHERE COST < 100 AND SELLING_PRICE<100

UPDATE CONTRACTOR
SET CONTRACT_DUE = DATEADD(YEAR, 1, CONTRACT_DUE)
-- FROM PRODUCTS
WHERE DATEDIFF(MONTH, CONTRACT_DUE, GETDATE())>2

UPDATE CONTRACTOR
SET CONTRACT_DUE = DATEADD(YEAR, 1, CONTRACT_DUE)
FROM PRODUCTS
WHERE PRODUCTS.MANUFACTURER = CONTRACTOR.COMPANY_NAME


DROP TABLE EMPLOYEES
DROP TABLE PRICES
DROP TABLE PRODUCTS
DROP TABLE CONTRACTOR

