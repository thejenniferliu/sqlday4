--1. Create a Stored Procedure that will insert a new film into the film table with the
--following arguments: title, description, release_year, language_id, rental_duration,
--rental_rate, length, replace_cost, rating

select * from film;

create or replace procedure add_film(title VARCHAR, description VARCHAR, release_year year, language_id integer, rental_duration integer,
rental_rate numeric(4,2), length integer, replacement_cost numeric(5,2), rating mpaa_rating) 
language plpgsql 
as 
$$
begin 
	insert into film(title, description, release_year, language_id, rental_duration,
rental_rate, length, replacement_cost, rating)
	values(title, description, release_year, language_id, rental_duration,
rental_rate, length, replacement_cost, rating);	
end;
$$;

call add_film('blah', 'blahblah', 2006, 1, 90, 50.49, 1, 111.11, 'R');

select * from film f
where title = 'blah';

--2. Create a Stored Function that will take in a category_id and return the number of films in that category

select * from category;

create or replace function get_number_films(cat_id integer)
returns integer
language plpgsql
as $$
	declare category_count integer;
begin
	select count(*) into category_count
	from film_category
	where category_id = cat_id
	group by category_id; 
	return category_count;
end;
$$;

select get_number_films(14);
