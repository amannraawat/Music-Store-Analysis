-- Ques: Who is the youngest employee based on job title?
-- (If two are more employees are youngest then sort them according to their first name)

SELECT * FROM employee
ORDER BY levels,first_name
LIMIT 1;

-- Ques: Which country has the most invoices?

SELECT billing_country,COUNT(invoice_id) AS invoices_count
FROM invoice
GROUP BY billing_country
ORDER BY invoices_count DESC
LIMIT 1;

-- Ques 3: What are top 5 values of total invoice?

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 5;

-- Ques: Which city has the best customers? We would like to throw a promotional 
-- music festival in the city we made the most money. Write a SQL query that returns 
-- the highest sum of invoices totals. Return both the city name and sum of all 
-- invoices totals.

SELECT billing_city,SUM(total) AS total_money
FROM invoice
GROUP BY billing_city
ORDER BY total_money DESC;

-- Ques: Who is the best customer? The customer who spent the most money will be 
-- declared the best customer. Write a query that returns the person who spent the 
-- most money.

SELECT C.customer_id, C.first_name, C.last_name,
SUM(O.total) AS total
FROM customer C 
JOIN invoice O ON C.customer_id=O.customer_id
GROUP BY C.customer_id
ORDER BY total DESC
LIMIT 1;

-- Ques: Write query to return the first name, last name, email & genre of all rock
-- music listeners. Return your list alphabetically by email starting with A.

SELECT C.first_name, C.last_name, C.email
FROM customer C
JOIN invoice I ON C.customer_id=I.customer_id
JOIN invoice_line IL ON I.invoice_id=IL.invoice_id
WHERE track_id IN (
	SELECT track_id
    FROM track T
    JOIN genre G ON T.genre_id=G.genre_id
    WHERE G.name LIKE 'Rock')
ORDER BY C.email;

-- Ques: Let's invite the artist who have written the most rock music in our dataset.
-- Write a query that returns the artist name and total track count of the top 10 rock
-- brands.

SELECT A.name,COUNT(T.track_id) AS track_count
FROM artist A
JOIN album AL ON A.artist_id=AL.artist_id
JOIN track T ON T.album_id=AL.album_id
JOIN genre G ON G.genre_id=T.genre_id
WHERE G.name LIKE 'Rock'
GROUP BY A.name
ORDER BY track_count DESC;

-- Ques: Return all the track names that have a song length greater than the average
-- song length. Return the name and miliseconds for each track. Order by the song length 
-- with the longest songs listed first.

SELECT name,milliseconds
FROM track 
WHERE milliseconds >
    (SELECT AVG(milliseconds) AS average_length
     FROM track)
ORDER BY milliseconds DESC
