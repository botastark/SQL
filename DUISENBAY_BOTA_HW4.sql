/*
HW 4 BOTA DUISENBAY
30TH OF AUGUST
*/

use SECOND_WEEK
/* task 1 
concat to join varchar column values into single varchar column
left join to get departments names from departments table by id
convert to chnage datatype of start date from date to varchar
substring to cut only first 4 characters (year) from varchar type date
concat to join obtained 4 char varchar with another string 'year'
*/
SELECT CONCAT(LAST_NAME,' ',FIRST_NAME,' ',TITLE) AS EMPLOYEE, 
    D.NAME AS DEPT_NAME, 
    CONCAT(SUBSTRING(CONVERT(varchar,E.START_DATE,102),1, 4), ' year') AS START_YEAR

FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D
ON E.DEPT_ID=D.DEPT_ID

/* task 2
left join to join 2 tables to get address of the accounts
datediff to get difference between 2 date type columns in years
*/

SELECT A.ACCOUNT_ID, C.ADDRESS  FROM ACCOUNT A
LEFT JOIN CUSTOMER C
ON A.CUST_ID=C.CUST_ID
WHERE DATEDIFF(YEAR,A.OPEN_DATE, A.LAST_ACTIVITY_DATE)>=1


/* task 3
LEFT JOIN TO GET ADDRESS AND CITY OF ACCOUNTS
LEN TO GET LENGHT=NUMBER OF CHCARACTES IN VARCHAR, THEN SOME LEN OF CITY AND ADDRESS 
WHERE TO FILTER OUT THOSE WITH RESULTANT LENGTH LESS THAN 222
*/
SELECT * FROM ACCOUNT A
LEFT JOIN CUSTOMER C
ON A.CUST_ID=C.CUST_ID
WHERE LEN(C.ADDRESS)+LEN(CITY)>22



/* task 4
    first find max salary for each department through max and group by
    then using left join add employee information to whom these salary and dept match

*/


SELECT E.FIRST_NAME,E.LAST_NAME FROM
    (SELECT MAX(M.SALARY) AS MAX_SALARY, M.DEPT_ID FROM EMPLOYEE AS M
    GROUP BY DEPT_ID) AS F
LEFT JOIN EMPLOYEE E
ON E.SALARY = F.MAX_SALARY AND E.DEPT_ID=F.DEPT_ID



/* TASK 5
CONCAT TO CONCATENATE ADDRESS AND CITY INTO A SINGLE VARCHAR AS A COLUMN
SWITCH TO REPLACE POSTAL CODE (INT) WITH VARCHARS 'ONE','TWO' AND 'OTHER' ACCORDING TO ITS BEGINNING 
*/
SELECT CONCAT(C.ADDRESS,' ',C.CITY)  AS ADDRESS,  
CASE
WHEN POSTAL_CODE LIKE '01%' THEN 'ONE'
WHEN POSTAL_CODE LIKE '02%' THEN 'TWO'
ELSE 'OTHER'
END POSTAL_CODE
FROM CUSTOMER C
/*
TASK 6
DIDN'T GET THE TASK
*/

SELECT * FROM EMPLOYEE

SELECT TOP 1 D.NAME, F.TOTAL_SALARY FROM
    (SELECT SUM(M.SALARY) AS TOTAL_SALARY, M.DEPT_ID FROM EMPLOYEE AS M
    GROUP BY DEPT_ID) AS F
LEFT JOIN DEPARTMENT D
ON D.DEPT_ID = F.DEPT_ID
ORDER BY F.TOTAL_SALARY DESC

/* TASK 7
 in innermost nest it finds customers who has at least 2 accounts (use count) with min 500 available balance(where) uses account table data
 this table is joined with customder information to get address of each customer wh satidsfiied above mentioned conditions
 third subquery is to find dept id where  accounts of these customers where opened
 and in final nest  department name is added to the corresponding dept id found earlier and returns cust address and department name
*/
SELECT  J.CUST_ADDRESS, D.NAME  FROM
    (SELECT DISTINCT A.OPEN_BRANCH_ID AS DEP_ID, P.CUST_ID, P.ADDRESS_CUST AS CUST_ADDRESS  FROM ACCOUNT A
    LEFT JOIN 
        (SELECT  C.ADDRESS AS ADDRESS_CUST, C.CUST_ID AS CUST_ID FROM CUSTOMER C
        RIGHT JOIN (
            SELECT COUNT(A.ACCOUNT_ID) AS COUNT, A.CUST_ID AS CUST_ID FROM ACCOUNT A
            WHERE A.AVAIL_BALANCE>500
            GROUP BY A.CUST_ID
            HAVING COUNT(A.ACCOUNT_ID)>=2
            ) AS M
        ON C.CUST_ID=M.CUST_ID) AS P
    ON P.CUST_ID=A.CUST_ID) AS J
RIGHT JOIN DEPARTMENT D
ON J.DEP_ID=D.DEPT_ID
WHERE CUST_ADDRESS IS NOT NULL
