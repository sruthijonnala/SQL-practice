--##Reactions Type table##

select * from reactions_type
Alter Table reactions_type
Alter column serial_no type int using serial_no::int; 
-- facing issues while converting serial_no datatype varchar to int due to null values or consist of non numeric datatype
--to fetch non numeric or null values in serial_no column
SELECT serial_no
FROM reactions_type
WHERE serial_no ~ '[^0-9]'

-- deleting non numeric data
DELETE FROM REACTIONS_TYPE WHERE SERIAL_NO =
(
SELECT serial_no
FROM reactions_type
WHERE serial_no ~ '[^0-9]'
);

select score 
from reactions_type
where score ~ '[^0-9]'

alter table reactions_type
alter column score type int using score:: int;

select * from reactions_type
where score > 50

select serial_no, type,sentiment, score,count(*) from reactions_type
group by serial_no, type,sentiment, score
having count(*) > 1;
---------------------------------------------------------------------------------------------------
--##Reaction table##

select * from reaction
select serial_no,content_id,user_id,type,datetime, count(*)
from reaction
group by serial_no,content_id,user_id,type,datetime
having count(*) > 1

alter table reaction
alter column serial_no type int using serial_no::int;

delete from reaction where serial_no = (select serial_no from reaction
where serial_no ~'[^0-9]')

alter table reaction
alter column datetime type date using datetime::date;

select * from reaction
where serial_no is null

delete from reaction where user_id is null
select * from reaction
order by datetime desc

select *,
case
	when datetime > '2021-01-01' then 'Recent'
    else 'old'
end as date_status
from reaction

SELECT USER_ID, COUNT(*) FROM REACTION
GROUP BY USER_ID

CREATE INDEX SERIAL_NO_INDEX ON REACTION (SERIAL_NO)

select * from reaction
where serial_no between 100 and 200

-----------------------------------------------------------------------------------------------------
--##Content table##

select * from content
-- creating views
create view photos_table as
select * from content
where type = 'photo'
select * from photos_table

update content
set serial_no = 0
where serial_no = '1' and category = 'healthy eating'

select * from content
where serial_no = '0'

select distinct type from content

select * from content
where
case
	when type = 'audio' then 'A'
	when type = 'photo' then 'P'
	when type = 'gif' then 'G'
	else 'V'
end = 'A'
	
--------------------------------------------------------------------------------------------------------------------------
--Write a query to determine which Category in Content.csv has the highest number of reactions in Reactions.csv.
select category, count(category) as count_category from content
group by category
order by count_category desc

create view  new_table as
select c.*, r.reaction_type,r.datetime from content c
join reaction r on c.content_id = r.content_id 
	
select * from new_table
select category, count(reaction_type) as reaction_count from new_table
group by category
order by reaction_count desc

SELECT c.Category, COUNT(r.Content_ID) AS Total_Reactions
FROM Content c
JOIN Reaction r ON c.Content_ID = r.Content_ID
GROUP BY c.Category
ORDER BY Total_Reactions DESC

--Write a query to find the total number of reactions a specific user (e.g., User_ID = '92b87fa5-f271-43e0-af66-84fac21052e6') has made.

select  count(*) from reaction
where user_id = '92b87fa5-f271-43e0-af66-84fac21052e6'

--Write a query to find content from Content.csv that has not received any reactions in Reactions.csv.
SELECT c.Content_ID, c.content_Type, c.Category
FROM Content c
WHERE c.Content_ID NOT IN (
    SELECT DISTINCT r.content_id
    FROM Reaction r);
-------------------------------------------------------------------------------------------------------------


	





