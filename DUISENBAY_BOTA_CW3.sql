USE SECOND_WEEK
SELECT * FROM ACCOUNT

SELECT COUNT(PRODUCT_CD) AS COUNT_PR_CD, SUM(AVAIL_BALANCE) AS SUM_AV_BALANCE, PRODUCT_CD
FROM ACCOUNT
WHERE PRODUCT_CD LIKE 'C%'
GROUP BY PRODUCT_CD
HAVING COUNT(PRODUCT_CD)>3

SELECT COUNT(CUST_ID) AS CUST_ID , SUM(PENDING_BALANCE) AS PENDING_BALANCE, CUST_ID
FROM ACCOUNT
WHERE PRODUCT_CD LIKE 'C%'
GROUP BY CUST_ID
HAVING COUNT(CUST_ID)>1 AND SUM(PENDING_BALANCE) > 5000

SELECT * FROM EMPLOYEE
SELECT * FROM DEPARTMENT

SELECT COUNT(E.DEPT_ID) AS COUNT, E.DEPT_ID, D.NAME FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID
WHERE START_DATE>'2003-01-01'
GROUP BY D.NAME, E.DEPT_ID
HAVING COUNT(E.DEPT_ID)>1
ORDER BY D.NAME

SELECT COUNT(D.DEPT_ID) AS COUNT, D.DEPT_ID, D.NAME  FROM DEPARTMENT D
RIGHT JOIN EMPLOYEE E
ON  E.DEPT_ID = D.DEPT_ID
GROUP BY D.DEPT_ID, D.NAME
SELECT * from CUSTOMER
SELECT * from ACCOUNT

Select ACCOUNT.ACCOUNT_ID, CUSTOMER.CUST_TYPE_CD
from ACCOUNT
inner JOIN CUSTOMER
ON ACCOUNT.CUST_ID = CUSTOMER.CUST_ID

