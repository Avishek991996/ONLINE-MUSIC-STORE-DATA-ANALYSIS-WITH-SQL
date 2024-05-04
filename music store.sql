--Q1. Who is the senior most employee based on job title?

SELECT first_name,last_name,levels FROM employee
ORDER BY levels desc
LIMIT 1

--Q2. Which countries have the most invoices?

SELECT COUNT(*) AS C,billing_country
FROM invoice
GROUP BY billing_country
ORDER BY C desc

--Q3. What are the top 3 values of total invoices?

SELECT total FROM invoice
ORDER BY total desc
LIMIT 3

--Q4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.Write a query that returns one city that has the highest sum of invoice totals. Return both the city names & sum of all invoice totals.

SELECT SUM(total) as invoice_total, billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total desc
LIMIT 1

--Q5. Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money.

SELECT customer.customer_id,customer.first_name,customer.last_name,SUM(invoice.total) as total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total desc
LIMIT 1

--Q6. Write query to return the email, first name, last name & genre of all rock music listeners. Return your list ordered alphabetically by email starting with A

SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoiceline.invoice_id
WHERE track_id IN(
      SELECT track_id FROM track
      JOIN genre ON track.genre_id = genre.genre_id
      WHERE genre.name LIKE "ROCK"
)
ORDER BY email;

--Q7. Let's invite the artist who have written the most rock music in our dataset. Write a query that returns the artist nameand total track count of the top 10 rock bands.

SELECT artist.artist_id, artist.name, COUNT (artist.artist_id) as number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'ROCK'
GROUP BY artist.artist_id
ORDER BY number_of_songs desc
limit 10

--Q3: Return all the track names that have a song length longer than the average song length. 
--Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name,miliseconds
FROM track
WHERE miliseconds > (
	SELECT AVG(miliseconds) AS avg_track_length
	FROM track )
ORDER BY miliseconds DESC;