 -- 1 - How many actors are there with the last name 'Wahlberg'
select count(last_name) 
from actor 
where last_name = 'Wahlberg'; 
 
-- 2 - How many payments were made between $3.99 and $5.99?
select count(amount) 
from payment 
where amount >= 3.99 and amount <= 5.99;

-- 3 - What film does the store have the most of?

select film_id, count(film_id)
from inventory
group by film_id
having count(film_id) = 
	-- get the maximum count of any film_id
	(select max(num)
	from(
		select count(film_id) as num
		from inventory
		group by film_id
		) film_counts
	)

-- 4 - How many customers have the last name 'Williams'?
select count(last_name) 
from customers 
where last_name like 'Williams';

-- 5 - What store employee (get the id) sold the most rentals?

--method 1: simpler but only returns one value
select staff_id, count(staff_id)
from rental
group by staff_id 
order by count(staff_id) desc
limit 1

--method 2: more complex, returns multiple values in case of a tie
select staff_id, count(staff_id)
from rental
group by staff_id
having count(staff_id) = 
	-- get the maximum count of any staff_id
	(select max(num)
	from(
		select count(staff_id) as num
		from rental
		group by staff_id
		) staff_counts
	)

-- 6 - How many different district names are there?
select count(distinct district)
from address

-- 7 - What film has the most actors in it? (use film_actor table and get film_id)
select film_id, count(film_id)
from film_actor
group by film_id
order by count(film_id) desc

select film_id, count(film_id)
from film_actor
group by film_id
having count(film_id) = 
	-- get the maximum count of any film_id
	(select max(num)
	from(
		select count(film_id) as num
		from film_actor
		group by film_id
		) cast_counts
	)

-- 8 - From store_id 1, how many customers have a last name ending with 'es'? (use customer table)
select count(customer_id)
from customer
where store_id = 1 and last_name like '%es'

-- 9 - How many payment amounts ($4.99, $5.99, etc.) had a number of rentals above 250 for customers with ids between 380 and 430? (use group by and having > 250)
select count(amount) 
from(
	select amount, count(amount)
	from payment
	where customer_id >= 380 and customer_id <= 430
	group by amount
	having count(amount) > 250
) matching_amounts

--10 - Within the film table, how many rating categories are there? And what rating has the most movies total?

--number of ratings
select count(distinct rating) from film

--most common rating
select rating, count(rating)
from film
group by rating
having count(rating) = 
	-- get the maximum count of any film_id
	(select max(num)
	from(
		select count(rating) as num
		from film
		group by rating
		) counts
	)
