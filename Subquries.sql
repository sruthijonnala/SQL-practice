use newdb;
select empno,ename from empp
where deptno = (select deptno from dept
where dname = 'research');
-- Find Employees with Salary Greater than the Average Salary
select ename from empp where sal >(select avg(Sal) from empp);

-- Find Departments with More Than 5 Employees
select deptno,count(*) from empp
group by deptno
having count(*) > 5;

-- Find Managers Earning More Than the Average Salary of Their Department
select ename from empp where mgr in (select mgr from empp e1
where (empno,sal) > (select empno,avg(sal) from empp e2
where e1.deptno = e2.deptno
and e1.mgr = e2.empno));

-- Find Employees in the Same Department as 'KING'
select ename from empp where deptno in (select e.deptno from dept d
join empp e on  d.deptno = e.deptno where ename = 'king');

-- Find Departments Without Employees
select deptno from dept
where deptno not in (select deptno from empp);

-- Find the Highest Paid Employee in Each Department
select empp.deptno,ename from empp 
join 
(select deptno,max(sal) as highsal from empp
group by deptno) as maxsal
on empp.deptno = maxsal.deptno
and empp.sal = maxsal.highsal;

select ename from empp e1 where (deptno,sal) = (select deptno,max(Sal) from empp e2
where e1.deptno = e2.deptno);

-- Find Employees Who Earn More Than Their Manager
select distinct m.sal as mgrsal
from empp e
join empp m
on e.mgr = m.empno
where e.sal > m.sal;


