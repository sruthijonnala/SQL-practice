select * from empp;

-- using dense rank
select * from 
(select sal, 
dense_rank() over ( order by sal desc) as rnk
from empp) ranked
where rnk = 4;

-- using limit offset
select distinct sal from empp
order by sal desc
limit 3,1;              -- limit n-1 


select e1.*, e2.empno, e2.ename from empp e1
join empp e2 on e1.empno = e2.mgr
