select * from empp;

-- 1-10: Employee and Salary Aggregations  
-- 1. Total Salary by Job 
 select  sum(sal),job
 from empp
 group by job;
 
-- 2. Average Salary by Department
select avg(sal), deptno
from empp
group by deptno;
  
-- 3. Minimum Salary by Manager 
select mgr,
min(sal) as min_Sal,
COUNT(*) AS employee_count
from empp
group by mgr;
 
-- 4. Maximum Salary by Job
select job, min(sal)
from empp
group by job;

-- 5. Count of Employees by Department 
select deptno,count(ename)
from empp
group by deptno;

-- 6. Total Commission by Job
select job,sum(comm)
from empp
group by job;
 
-- 7. Employee Count by Manager
select mgr, count(ename) from empp
group by mgr;
  
-- 8. Departments with Total Salary Greater Than 5000
select deptno, sum(sal) as sum_Sal
from empp
group by deptno
having sum_sal > '5000';
  
-- 9. Jobs with Average Salary Between 1000 and 3000 

select job, avg(sal)
from empp
group by job
having avg(Sal) between 1000 and 3000;
 
-- 10. Employees with Null Commissions Grouped by Job 
select job, count(*)
from empp
where comm is null
group by job;

-- 11-20: Employee and Hire Date  
-- 11. Earliest Hire Date by Department
select max(hiredate), deptno
from empp
group by deptno; 
 
-- 12. Latest Hire Date by Job 
select deptno, min(hiredate) as latest_hiredate
from empp
group by deptno;
 
-- 13. Total Employees Hired After 1981 Grouped by Manager 
select mgr, count(*)
from empp
where hiredate > 1981
group by mgr;


-- 14. Average Salary of Employees Hired After 1981 
select mgr, avg(sal)
from empp
where year(hiredate) > 1981
group by mgr;

-- 15. Number of Employees Hired Per Job 
select job, count(hiredate) as count_of_emp_per_job
from empp
group by job;

-- 16. Departments with Maximum Hire Date Before 1983 
select deptno, max(hiredate)
from empp
where year(hiredate) < 1983
group by deptno;

-- 17. Managers with Employees Hired After 1982
select deptno, max(hiredate)
from empp
where year(hiredate) < 1983
group by deptno;

-- 18. Jobs with Total Salary Above 10000 
select job, sum(sal)
from empp
group by job;

-- 19. Departments with Average Commission Above 500
select deptno, avg(comm)
from empp
group by deptno
having avg(comm) > 500;
 
-- 20. Jobs with at Least 3 Employees
select job, count(*)
from empp
group by job;

