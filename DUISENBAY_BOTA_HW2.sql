USE SECOND_WEEK
--TASK 1
SELECT MIN(AVAIL_BALANCE) AS 'MIN', MAX(AVAIL_BALANCE) AS 'MAX' FROM ACCOUNT
WHERE LAST_ACTIVITY_DATE BETWEEN '2004-01-01 00:00:00.000' AND '2004-12-31 23:59:59.000'

--TASK 2
--NEED TO CLEARIFY ABOUT 
SELECT  COUNT( DISTINCT CUST_ID) AS '#ACTIVE_CUSTOMERS' FROM ACCOUNT
WHERE STATUS = 'ACTIVE'

SELECT COUNT(CUST_ID) AS '#ACTIVE_CUSTOMERS' FROM OFFICER

--TASK 3
SELECT * FROM ACCOUNT
WHERE LAST_ACTIVITY_DATE >= '2004-04-01 00:00:00.000' OR OPEN_DATE >= '2004-01-01 00:00:00.000'

--TASK 4
SELECT * FROM ACCOUNT
WHERE LAST_ACTIVITY_DATE BETWEEN '2004-11-01 00:00:00.000' AND '2004-12-31 23:59:59.000'
AND NOT OPEN_DATE BETWEEN '2004-01-01 00:00:00.000' AND '2004-06-30 23:59:59.000'

--TASK 5
SELECT COUNT(EMP_ID) AS 'QUANTITY', TITLE, DEPT_ID FROM EMPLOYEE
GROUP BY TITLE, DEPT_ID

--TASK 6
SELECT ACCOUNT_ID, OPEN_DATE, AVAIL_BALANCE FROM ACCOUNT
WHERE OPEN_DATE BETWEEN '2004-06-01 00:00:00.000' AND '2004-12-31 23:59:59.000'
AND AVAIL_BALANCE >= 3000
ORDER BY AVAIL_BALANCE DESC

--TASK 7
SELECT AVG(AVAIL_BALANCE) AS 'AVG BALANCE', PRODUCT_CD FROM ACCOUNT
WHERE PRODUCT_CD = 'CD' OR PRODUCT_CD = 'CHK'
GROUP BY PRODUCT_CD

--TASK 8
SELECT SUM(AVAIL_BALANCE) AS 'TOTAL BALANCE', CUST_ID FROM ACCOUNT
GROUP BY CUST_ID
ORDER BY SUM(AVAIL_BALANCE) ASC

--TASK 9
SELECT DISTINCT TITLE FROM EMPLOYEE
WHERE START_DATE < '2003-10-01 00:00:00.000'

--TASK 10
SELECT CUST_ID, ADDRESS, CITY FROM CUSTOMER
WHERE STATE = 'MA' AND POSTAL_CODE LIKE '01%' AND NOT CITY = 'Woburn'

--ADDITIONAL TASK