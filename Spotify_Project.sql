SELECT * FROM practice.employee;
select * from invoice;
select * from track;
-- 1. Who is the senior most employee based on job title?

select concat (first_name,' ',last_name) title, hire_date from employee
order by hire_date asc;

-- 2. Which countries have the most Invoices?

select billing_country, count(*) as count_of_invoices
from invoice
group by billing_country
limit 1;

-- 3. What are top 3 values of total invoice?
select total from invoice
order by total desc
limit 3;

-- 4. Which city has the best customers? We would like to throw a promotional Music.
select c.city, c.first_name, i.total 
from customer c
join invoice i on c.customer_id = i.invoice_id
order by i.total desc
limit 1;

-- 5. Who is the best customer? 
-- The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.

select c.first_name, c.last_name, i.total 
from customer c
join invoice i on c.customer_id = i.invoice_id
order by i.total desc
limit 1;

-- 1. Write query to return the email, first name, last name, &amp; Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A.

select email, first_name, last_name, name as genre_name
from customer
join genre on customer.customer_id = genre.genre_id
order by email;

-- 2. Let&#39;s invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.

select a.name as artist_name, count(t.name) as track_count, g.name as genre_name
from artist a
join album2 al on a.artist_id = al.artist_id
join track t on t.album_id = al.album_id
join genre g on g.genre_id= t.genre_id
where g.name = 'rock'
group by artist_name, genre_name
order by track_count desc;

-- 3. Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

select name as track_name, milliseconds from track
where milliseconds >
(select avg(milliseconds) as avg_song_length 
from track)
order by milliseconds desc;

-- 1. Find how much amount spent by each customer on artists? 
-- Write a query to return customer name, artist name and total spent.

select c.first_name as customer_name, a.name as artist_name, i.total
from customer c
join invoice i on c.customer_id = i.customer_id
join artist a on i.invoice_id = a.artist_id
order by i.total desc;

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name,ar.name AS artist_name,
            SUM(il.unit_price * il.quantity) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN artist ar ON ar.artist_id = alb.artist_id
GROUP BY customer_name,ar.name
ORDER BY total_spent DESC;

