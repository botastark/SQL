DROP TABLE WORLD ;
CREATE TABLE WORLD(
    name varchar(64),
    continent varchar(64),
    AREA int,
    POPULATION int, 
    gdp int
);
SELECT * FROM WORLD

select name, (POPULATION)/(AREA) as density from WORLD

INSERT INTO World 
VALUES ('Afganistan', 'Asia', 652230, 25500100, 203430000),
        ('Albania', 'Europe', 28748, 2831741, 12960000),
        ('Andorra', 'Europe', 468, 1741, 960000);


Select count(name),continent, sum(area) from WORLD
where area>=2034
group by continent
Select count(name), continent, sum(area) from World
group by continent
having sum(area)>10000

select name,(max_pop)/(area) as density from 
(
    select top 1 name,max(population) as max_pop, area from World
    group by name, area
) as temp;

DROP TABLE EMP_INFO;
DROP TABLE EMP;

CREATE TABLE DEP(
    id_dep int NOT NULL PRIMARY KEY,
    name_dep varchar(64), 
)
CREATE TABLE EMP(
    id_emp int NOT NULL PRIMARY KEY,
    id_dep int FOREIGN KEY REFERENCES DEP(id_dep),
    age int,
    name varchar(64),
    salary int,
    position varchar(64),
   
);

CREATE TABLE EMP_INFO(
    id_emp int FOREIGN KEY REFERENCES EMP(id_emp),
    address varchar(64), 
    birthday DATE
)

INSERT into DEP
VALUES (1,'Dev'),
        (2, 'Support');
INSERT INTO EMP 
VALUES (1,1,20,'Ale',200,'Chief'),
        (2,1,21,'Larisa',100,'Manager'),
        (7,null,26,'Kistina',30,'Specialist');

INSERT into EMP_INFO
VALUES (1,'fsd', '01.01.1980'),
    (2,'fsd', '01.01.1975');


INSERT INTO EMP 
VALUES 
        (3,1,21,'L',100,'Manager');

INSERT into EMP_INFO
VALUES (3,'fsd', NULL);
SELECT * FROM EMP
SELECT * FROM EMP_INFO

SELECT name, age FROM EMP
LEFT JOIN EMP_INFO
ON EMP.id_emp=EMP_INFO.id_emp
WHERE birthday IS NULL AND age>22

SELECT E.name, D.name_dep, I.birthday from EMP as E
left join EMP_INFO as I
ON E.id_emp=I.id_emp
left join DEP as D
on D.id_dep=E.id_dep
WHERE position='Chief' or  position='Manager'

declare @interval varchar(60)
-- SET @interval = '20-21' and '22-23' ;

SELECT E.name, I.address,
CASE
    WHEN E.age>=20 and E.age<=21 THEN '20-21'
    WHEN E.age>=22 and E.age<=23 THEN '22-23'
    WHEN E.age>=24 and E.age<=25 THEN '24-25'
    ELSE '>25'
END AS interval  
from EMP as E
left join EMP_INFO as I
ON E.id_emp=I.id_emp

SELECT  CASE 
    WHEN D.name_dep = 'Dev' and E.salary=max(E.salary) THEN E.salary 
    ELSE 0
END AS sal
from EMP as E
left join DEP as D
on D.id_dep=E.id_dep 



-- SELECT  from EMP as E
-- left join DEP as D
-- on D.id_dep=E.id_dep 
-- where (( )) or

SELECT
(SELECT top 1 max(E.salary) as max_dev   from EMP as E
left join DEP as D
on D.id_dep=E.id_dep
where D.name_dep = 'Dev') -
(SELECT top 1 min(E.salary) as min_supp  from EMP as E
left join DEP as D
on D.id_dep=E.id_dep
where D.name_dep = 'Support')

