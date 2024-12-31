-- creating new database
create database magicbricks_db;

-- setting the dataset to be default
use magicbricks_db;

-- Viewing the full table 
select * 
from magicbricks;

select distinct city, count(*) as cnt
from magicbricks
group by city;



set sql_safe_updates = 0;

delete 
from magicbricks
where city != "Pune";

select * 
from magicbricks;



-- select house_type, substring_index(house_type, " ",2) as room_type
-- from magicbricks;


-- adds new column 'room_type'
alter table magicbricks
add room_type varchar(100);

-- veiwing the full table
select * 
from magicbricks;

-- inserting data in the column 'room_type'
update magicbricks
set room_type = substring_index(house_type, " ",2); 

-- viewing the full table
select * 
from magicbricks;


-- updating house_type
update magicbricks
set house_type = substring_index(substring_index(house_type, " ",3), " ", -1);

-- viewing full table
select * 
from magicbricks;




-- Q1. Percentage of various types of houses for rent in Pune
set @total:= (select count(*) from magicbricks);
select @total;

select house_type, (count(*)/@total)*100 as percent
from magicbricks
group by house_type;



-- Q2. Top 5 popular places in Pune according to listing
select locality, count(locality) as cnt
from magicbricks
group by locality 
order by count(locality) desc
limit 5;




-- Q3. Localities with most listings for different room types

with c as (
select room_type, locality, count(*) as cnt, max(count(*)) over (partition by room_type) as maxm
from magicbricks
group by room_type, locality
order by room_type, count(*) desc)

select * from c
where cnt = maxm;







-- Q4. room_type percentage

select room_type, (count(*)/@total)*100 as percent
from magicbricks
group by room_type;



-- Q5 percentage of listings with different furnishing 
select furnishing, (count(furnishing)/@total)*100 as percent
from magicbricks
group by furnishing
order by count(furnishing) desc;



-- Q5.1 bhk vs. avg (area correl)



-- Q6. min, max and avg rent in pune
select min(rent) as min_rent, max(rent) as max_rent, avg(rent) as avg_rent
from magicbricks;



-- Q7 max bhk rent and min bhk rent, avg bhk rent
select room_type, min(rent) as min_rent, max(rent) as max_rent, avg(rent) as avg_rent
from magicbricks
group by room_type;




-- Q8 top 6 localities with highest avg rent
select locality, avg(rent) as avg_rent
from magicbricks
group by locality
order by avg(rent) desc
limit 6;



-- Q9 min, max and avg rent depending on furnishing
select furnishing, min(rent) min_rent, max(rent) as max_rent, avg(rent) as avg_rent
from magicbricks
group by furnishing;





