
-- Find highest sal in each dept
with highsal as (
	select max(sal),deptno
    from empp
    group by deptno
    )
    select *  from highsal;


-- find emp earning more than 3000
with empearnings as(
	select ename, sal
    from empp
    where sal > 3000
    )
    select * from empearnings;

-- find all emp in research dept and their managers name
select e.ename as empname,
m.ename as mgrname,
d.dname as deptname
from empp e
left join empp m on e.mgr = m.empno
inner join dept d on e.deptno = d.deptno
where d.dname = 'research';


-- list emp sal greter than their dept avg sal
with highsal as (	
    select ename,sal
	from empp e
	where sal > (select avg(sal) from empp WHERE deptno = e.deptno)
)
	select * from highsal;
    
-- find emp with comm greater than 500 and their deptname
-- find dept avg sal and resuse the result

-- find emp with sal between 1000 and 3000 and emp with > 2000 sal using cte
with salary as(
	select ename, sal
    from empp
    where sal between 1000 and 3000
)
	select * from salary
    where sal > 2000
