

select * from CUSTOMERS_TABLE;
SELECT * FROM PRODUCTS;
SELECT * FROM ORDERS;

select upper(customer_name) from customers_table;

select left(customer_name,2) from customers_table;

select instr(customer_name, 'a') as position_of_a from customers_table
where customer_name = 'Emma Brown';

select distinct length(customer_name) as length
from customers_table;

select replace(customer_name, 'a', 'A') from customers_table;

select concat(customer_id,' ', customer_name) as full_name
from customers_table;


-- converted order date column to date datatype from text datatype
''' alter table orders
modify order_date date; '''
-- the date format in your column doesn't match the expected format for the DATE data type in MySQL.
-- so converted in below way
ALTER TABLE orders ADD order_date_new DATE;
set sql_safe_updates = 0;
UPDATE orders 
SET order_date_new = STR_TO_DATE(order_date, '%d-%m-%Y');
ALTER TABLE orders DROP COLUMN order_date;
alter table orders
rename column order_date_new to order_date;

-- -- Find Customers Who Purchased Exactly Two Different Products in a Single Month
select customer_id, month(order_date) as omonth
from orders
group by customer_id, omonth
having count(product_id) > 1;


-- Identify Customers Who Haven’t Made Any Purchase in the Last 6 Months
select customer_id from orders
group by customer_id
having max(order_date) < date_sub(curdate(), interval 6 month);


-- List the Top 3 Products per Category Based on Revenue
-- Tables: Products (product_id, category), Sales (sale_id, product_id, amount)

with cte as (
select p.product_id,p. category,
dense_rank() over (partition by category order by amount desc) as sal_rank
from products p
join sales s on p.product_id = s.product_id)
select product_id, category from cte
where sal_rank <= 3
order by category;