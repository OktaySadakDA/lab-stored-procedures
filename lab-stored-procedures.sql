use sakila;

# 1. In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. 
# Convert the query into a simple stored procedure. Use the following query:

select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = "Action"
group by first_name, last_name, email;
  
DELIMITER //
create procedure actioncategory ()
begin
select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name ='Action'
group by first_name, last_name, email;
end //
DELIMITER ;

call actioncategory();

# 2.Now keep working on the previous stored procedure to make it more dynamic. 
# Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.

DELIMITER //
create procedure customersbycategory(in categoryname char(20))
begin
select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name =categoryname
group by first_name, last_name, email;
end //
DELIMITER ;

call customersbycategory('Action');

# 3.Write a query to check the number of movies released in each movie category. 
# Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. 
# Pass that number as an argument in the stored procedure.

select cat.name,count(*) as film_count
from category as cat
join film_category as film_cat on film_cat.category_id=cat.category_id
group by film_cat.category_id
having cat.name='Action' and film_count>6
order by film_count desc;

DELIMITER //
create procedure catcount (in numb int)
begin
select cat.name,count(*) as film_count
from category as cat
join film_category as film_cat on film_cat.category_id=cat.category_id
group by film_cat.category_id
having film_count>numb
order by film_count desc;
end
//
DELIMITER ;

call catcount(60);
