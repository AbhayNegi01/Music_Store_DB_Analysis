-- Q1. Who is the senior most employee based on job title?

-- SELECT *
-- FROM employee
-- ORDER BY levels DESC
-- LIMIT 1;

-- Q2. Which countries have the most Invoices?

-- SELECT billing_country, COUNT(*) AS invoice_count
-- FROM invoice
-- GROUP BY billing_country
-- ORDER BY invoice_count DESC;

-- Q3. What are top 3 values of total invoice?

-- SELECT *
-- FROM invoice
-- ORDER BY total DESC
-- LIMIT 3;

-- Q4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--     Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.

-- SELECT billing_city, SUM(total) AS invoice_total
-- FROM invoice
-- GROUP BY billing_city
-- ORDER BY invoice_total DESC
-- LIMIT 1;

-- Q5. Who is the best customer? The customer who has spent the most money will be declared the best customer. 
--     Write a query that returns the person who has spent the most money.

-- SELECT 
-- 	c.id, 
--     c.first_name, 
--     c.last_name, 
--     SUM(i.total) AS money_spent
-- FROM customer c
-- JOIN invoice i
-- 	ON c.id = i.customer_id
-- GROUP BY c.id
-- ORDER BY money_spent DESC
-- LIMIT 1;

-- Q6. Write a query to return the email, first name, last name, & Genre of all Rock Music listeners. 
--     Return your list ordered alphabetically by email starting with A 

-- SELECT 
-- 	DISTINCT c.email, 
--     c.first_name, 
--     c.last_name,
--     g.name AS genre
-- FROM customer c
-- JOIN invoice i
-- 	ON c.id = i.customer_id
-- JOIN invoice_line il
-- 	ON i.id = il.invoice_id
-- JOIN track t
-- 	ON il.track_id = t.id
-- JOIN genre g
-- 	ON t.genre_id = g.id
-- WHERE g.name = "Rock"
-- ORDER BY email;

-- Q7. Let's invite the artists who have written the most rock music in our dataset. 
--     Write a query that returns the Artist name and total track count of the top 10 rock bands.

-- SELECT 
-- 	ar.id, 
--     ar.name, 
--     COUNT(t.id) AS total_track
-- FROM artist ar
-- JOIN album al
-- 	ON ar.id = al.artist_id
-- JOIN track t
-- 	ON al.id = t.album_id
-- JOIN genre g
--     ON t.genre_id = g.id
-- WHERE g.name = "Rock"
-- GROUP BY ar.id, ar.name
-- ORDER BY total_track DESC, name
-- LIMIT 10;

-- Q8. Return all the track names that have a song length longer than the average song length. 
--     Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

-- SELECT name, milliseconds
-- FROM track
-- WHERE milliseconds > (
-- 	SELECT AVG(milliseconds)
-- 	FROM track
-- )
-- ORDER BY milliseconds DESC;

-- Q9. Find how much amount spent by each customer on artists. Write a query to return the customer name, artist name, and total spent.

-- SELECT 
-- 	c.id AS customer_id, 
-- 	c.first_name AS first_name,
--     c.last_name AS last_name,
-- 	ar.name AS artist_name, 
-- 	SUM(il.unit_price * il.quantity) AS total_spent
-- FROM invoice i
-- JOIN customer c 
-- 	ON c.id = i.customer_id
-- JOIN invoice_line il 
-- 	ON il.invoice_id = i.id
-- JOIN track t 
-- 	ON t.id = il.track_id
-- JOIN album al 
-- 	ON al.id = t.album_id
-- JOIN artist ar 
-- 	ON ar.id = al.artist_id
-- GROUP BY c.id, c.first_name, c.last_name, ar.name
-- ORDER BY total_spent DESC;

-- Q10. We want to find out the most popular music Genre for each country. 
--      We determine the most popular genre as the genre with the highest amount of purchases. 
--      Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres.

-- WITH popular_genre AS (
-- 	SELECT 
-- 		c.country, 
-- 		g.name AS genre_name, 
-- 		COUNT(il.id) AS total_purchases, 
-- 		RANK() OVER(PARTITION BY c.country ORDER BY COUNT(il.id) DESC) as rn
-- 	FROM customer c
-- 	JOIN invoice i 
-- 		ON i.customer_id = c.id
-- 	JOIN invoice_line il 
-- 		ON il.invoice_id = i.id
-- 	JOIN track t 
-- 		ON t.id = il.track_id
-- 	JOIN genre g 
-- 		ON g.id = t.genre_id
-- 	GROUP BY c.country, g.name
-- )

-- SELECT 
-- 	country, 
-- 	genre_name, 
--     total_purchases
-- FROM popular_genre
-- WHERE rn = 1
-- ORDER BY country, genre_name;

-- Q11. Write a query that determines the customer that has spent the most on music for each country. 
--      Write a query that returns the country along with the top customer and how much they spent. 
--      For countries where the top amount spent is shared, provide all customers who spent this amount.

-- WITH customer_country AS (
-- 	SELECT 
-- 		c.id, 
-- 		c.first_name, 
-- 		c.last_name,
-- 		i.billing_country,
-- 		SUM(i.total) AS total_spent,
-- 		RANK() OVER(PARTITION BY i.billing_country ORDER BY SUM(i.total) DESC) AS rn
-- 	FROM customer c
-- 	JOIN invoice i 
-- 		ON i.customer_id = c.id
-- 	GROUP BY c.id, c.first_name, c.last_name, i.billing_country
-- )

-- SELECT 
-- 	id, 
--     first_name, 
--     last_name, 
--     billing_country, 
--     total_spent
-- FROM customer_country
-- WHERE rn = 1
-- ORDER BY billing_country, total_spent DESC;

-- Q12. Who are the most popular artists?

-- SELECT
-- 	ar.name AS artist_name,
-- 	SUM(il.quantity) AS purchase_count
-- FROM invoice_line il
-- JOIN track tr 
-- 	ON tr.id = il.track_id
-- JOIN album al 
-- 	ON al.id = tr.album_id
-- JOIN artist ar 
-- 	ON ar.id = al.artist_id
-- GROUP BY ar.name
-- ORDER BY purchase_count DESC

-- Q13. Which are the most popular songs?

-- SELECT
-- 	il.track_id,
--     tr.name AS song_name,
-- 	SUM(il.quantity) AS purchase_count
-- FROM invoice_line il
-- JOIN track tr 
-- 	ON tr.id = il.track_id
-- GROUP BY il.track_id, tr.name
-- ORDER BY purchase_count DESC

-- Q14. What are the average prices of different types of music?

-- SELECT 
--     g.name AS genre_name,
--     ROUND(SUM(t.unit_price), 2) AS total_price,
--     COUNT(t.id) AS track_count,
--     ROUND(AVG(t.unit_price), 2) AS avg_price
-- FROM track t
-- JOIN genre g 
--     ON t.genre_id = g.id
-- GROUP BY g.name
-- ORDER BY avg_price DESC, total_price DESC, track_count DESC;

-- Q15. What are the most popular countries for music purchases?

-- SELECT 
-- 	i.billing_country,
-- 	COUNT(il.quantity) AS purchases
-- FROM invoice_line il
-- JOIN invoice i ON i.id = il.invoice_id
-- GROUP BY i.billing_country
-- ORDER BY purchases DESC;
