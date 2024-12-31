CREATE TABLE emp (
  empno    INTEGER,
  ename    VARCHAR(10),
  job      VARCHAR(9),
  mgr      INTEGER,
  hiredate DATE,
  sal      DECIMAL(7,2),
  comm     DECIMAL(7,2),
  deptno   INTEGER,
  CONSTRAINT pk_emp PRIMARY KEY (empno),
  CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES dept (deptno)
);

NSERT INTO emp VALUES (7839, 'KING'  , 'PRESIDENT', NULL, STR_TO_DATE('17-11-1981', '%d-%m-%Y'), 5000, NULL, 10);
INSERT INTO emp VALUES (7698, 'BLAKE' , 'MANAGER'  , 7839, STR_TO_DATE('1-5-1981'  , '%d-%m-%Y'), 2850, NULL, 30);
INSERT INTO emp VALUES (7782, 'CLARK' , 'MANAGER'  , 7839, STR_TO_DATE('9-6-1981'  , '%d-%m-%Y'), 2450, NULL, 10);
INSERT INTO emp VALUES (7566, 'JONES' , 'MANAGER'  , 7839, STR_TO_DATE('2-4-1981'  , '%d-%m-%Y'), 2975, NULL, 20);
INSERT INTO emp VALUES (7788, 'SCOTT' , 'ANALYST'  , 7566, STR_TO_DATE('13-6-1987' , '%d-%m-%Y'), 3000, NULL, 20);
INSERT INTO emp VALUES (7902, 'FORD'  , 'ANALYST'  , 7566, STR_TO_DATE('3-12-1981' , '%d-%m-%Y'), 3000, NULL, 20);
INSERT INTO emp VALUES (7369, 'SMITH' , 'CLERK'    , 7902, STR_TO_DATE('17-12-1980', '%d-%m-%Y'),  800, NULL, 20);
INSERT INTO emp VALUES (7499, 'ALLEN' , 'SALESMAN' , 7698, STR_TO_DATE('20-2-1981' , '%d-%m-%Y'), 1600,  300, 30);
INSERT INTO emp VALUES (7521, 'WARD'  , 'SALESMAN' , 7698, STR_TO_DATE('22-2-1981' , '%d-%m-%Y'), 1250,  500, 30);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN' , 7698, STR_TO_DATE('28-9-1981' , '%d-%m-%Y'), 1250, 1400, 30);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN' , 7698, STR_TO_DATE('8-9-1981'  , '%d-%m-%Y'), 1500,    0, 30);
INSERT INTO emp VALUES (7876, 'ADAMS' , 'CLERK'    , 7788, STR_TO_DATE('13-6-1987' , '%d-%m-%Y'), 1100, NULL, 20);
INSERT INTO emp VALUES (7900, 'JAMES' , 'CLERK'    , 7698, STR_TO_DATE('3-12-1981' , '%d-%m-%Y'),  950, NULL, 30);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK'    , 7782, STR_TO_DATE('23-1-1982' , '%d-%m-%Y'), 1300, NULL, 10);

select * from empp;

-- Assign a unique rnk to each employee by salary within each department.
select ename, sal,
row_number() over(partition by deptno order by sal desc) as sal_rank
from empp;

-- Find the top 3 highest-paid employees in each department.
select * from (
select ename, sal, deptno,
row_number() over(partition by deptno order by sal) as sal_rank
from empp) sub where sal_rank = 3;

'''select ename, sal, deptno,
rank() over(partition by deptno) as sal_rank
from empp;'''

-- List employees in order of hire date within each department.
select ename, hiredate, deptno,
row_number() over( partition by deptno order by hiredate) as rn
from empp;

-- Rank employees by salary, allowing ties, within each department.
select ename, sal, deptno,
rank() over ( partition by deptno order by sal desc) as sal_rank
from empp;

-- Find employees with the second highest salary in each department.
select ename, sal, deptno
from (
select ename, sal,deptno,
rank () over( partition by deptno order by sal desc) as sal_rank
from empp) sub where sal_rank = 2;

-- Dense rnk employees by salary within the entire company.

select ename, sal,
dense_rank() over(order by sal desc) as sal_rank
from empp;

-- Find the salary rnk for each employee within their department (allow ties).
select ename, sal, deptno,
dense_rank() over(partition by deptno order by sal desc) as sal_rank
from empp;

-- Find the salary rnk for each employee within their department (allow ties).
select ename, sal, deptno,
dense_rank() over(partition by deptno order by sal desc) as sal_rank
from empp;

-- Calculate the average salary of employees in each department.
select ename, sal, deptno,
avg(sal) over(partition by deptno) as avg_Sal
from empp;

-- Compare each employee&#39;s salary to the average salary in their department.

select ename, sal, deptno,
sal-avg(sal) over(partition by deptno) as Sal_difference
from empp;

-- Find employees earning above the department average salary.
select ename, sal, deptno, avg_sal
from (
select ename, sal, deptno,
avg(sal) over(partition by deptno) as avg_sal
from empp) sub where sal > avg_sal;

-- Calculate the total salary in each department.
select ename, sal, deptno,
sum(sal) over(partition by deptno) as total_sal
from empp;

-- Find the cumulative salary in each department.
SELECT empno, ename, deptno, sal,
SUM(sal) OVER (PARTITION BY deptno ORDER BY sal DESC) AS cumulative_salary
FROM empp;

-- Calculate the company&#39;s total salary for comparison.

SELECT empno, ename, sal,
SUM(sal) OVER () AS company_total_salary
FROM empp;

-- Count the number of employees in each department.
SELECT empno, ename, sal,
count(*) OVER (partition by deptno) AS total_count
FROM empp;

-- Find the running total of employees in each department by hire date.
SELECT empno, ename, deptno, hiredate,
COUNT(*) OVER (PARTITION BY deptno ORDER BY hiredate) AS running_total
FROM empp;

-- Find the highest salary in each department.
select empno, ename, sal, deptno,
max(sal) over (partition by deptno) as max_sal
from empp;

-- List employees who earn the highest salary in their department.

select empno, ename, sal, deptno
from (select empno, ename, sal, deptno,
max(sal) over (partition by deptno) as max_sal
from empp) sub where sal =  max_sal;

-- Find the hire date of the earliest employee in each department.

select ename, sal, hiredate,deptno 
from ( select ename, sal, hiredate, deptno,
min(hiredate) over(partition by deptno) as earliest_date
from empp) sub where hiredate = earliest_date;





