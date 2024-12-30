select * from empp;
select * from dept;
select * from salgrade;

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



