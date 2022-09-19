USE sakila;
-- Drop column picture from staff

SELECT * FROM staff;
ALTER TABLE staff
DROP COLUMN picture;

SELECT * FROM staff;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer;
SELECT * FROM staff;
SELECT * FROM sakila.customer
WHERE first_name = 'TAMMY' and last_name = 'SANDERS';
####################################
-- staff_id; first_name, last_name, address_id, email, store_id; active, username, password; last_update
INSERT INTO staff (first_name, last_name, address_id, email, store_id, active, username, password, last_update)
SELECT first_name, last_name, address_id, email, store_id, active, first_name, NULL, last_update
FROM customer
WHERE first_name = 'TAMMY' and last_name = 'SANDERS';

-- Here I was just checking sth.
-- DELETE FROM staff WHERE staff_id = 3;

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date
-- column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there.
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well.
-- To get that you can use the following query:
SELECT * FROM inventory;    -- from here we obtain inventory_id, store_id, film_id
SELECT * FROM store;
SELECT * FROM customer;
SELECT * FROM rental
order by rental_id DESC;    -- rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update
SELECT * FROM staff;

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (curdate(),
(SELECT inventory_id as inventory_id
    FROM (select inventory_id as inventory_id from sakila.inventory
where film_id in (
SELECT film_id as film_id FROM film
where title = "Academy Dinosaur" and store_id = 1))inv_dino limit 1), 
(SELECT customer_id as customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'),
NULL,
(SELECT store_id as store_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'),
(SELECT last_update as last_update from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'), 
curdate());

-- select customer_id as customer_id_ex, last_update as last_update_ex, store_id AS staff_id_ex from sakila.customer      -- here we get (4) customer_id, (7) last_update
-- where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

-- Select inventory_id AS inventory_id_ex
--    FROM (select inventory_id from sakila.inventory
-- where film_id in (
-- SELECT film_id FROM film
-- where title = "Academy Dinosaur" and store_id = 1))inv_dino limit 1;

-- INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
-- VALUES (current_date(), (inventory_id_ex AS inventory_id), customer_id_ex AS customer_id, NULL, staff_id_ex AS staff_id, current_date());