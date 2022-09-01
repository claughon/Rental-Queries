--Question 1: List all cutomers who live in Texas (use Joins).
--Answer: 5 people live in Texas
SELECT last_name, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

--Question 2: Get all payments above $6.99 with the customer's full name.
--Answer: There were 1406 payments above $6.99
SELECT first_name, last_name, amount
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

--Question 3: Show all cusotmers names who have made payments over $175 (use subquries).
--Answer: Six customers have made payments over $175
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

--Question 4: List all customers tha live in Nepal.
--Answer: One customer, Kevin Schuler lives in Nepal.
select first_name, last_name, email, country
from customer
full join address
on customer.address_id = address.address_id
full join city
on address.city_id = city.city_id
full join country
on city.country_id = country.country_id
where country = 'Nepal';

--Question 5: Which staff member had the most transactions?
--Answer: Jon Stephens with 7304 transactions.
select first_name, last_name, count(payment_id)
from staff
inner join payment
on staff.staff_id = payment.staff_id
group by first_name, last_name;

--Question 6: How many movies of each rating are there?
--Answer: G: 178, PG: 194, PG-13: 223, R: 195, NC-17: 210.
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating;

--Question 7: Show all customers who have made a single payment above $6.99.
--Answer: 130 customers have made a single payemnt above $6.99
SELECT first_name, last_name
FROM customer 
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(amount) = 1
);
	
--Question 8: How many free rentals did our store give away?
--Answer: 24 free rentals
SELECT amount
from payment
where amount = 0