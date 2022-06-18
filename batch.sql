insert into person(user, email) values
('john', 'john@test.com'),
('james', 'james@test.com'),
('jordan', 'jordan@test.com'),
('jamal', 'jamal@test.com'),
('alex', 'alex@test.com'),
('peter', 'peter@test.com'),
('bayley', 'bayley@test.com'),
('kris', 'kris@test.com'),
('pat', 'pat@test.com'),
('lebron', 'lebron@test.com');

alter table person
add age int;

alter table person
add sex varchar(1);

update person 
set sex = 'f', age = 22
where user = 'bayley';

update person
set user = "alecia"
where email = 'bayley@test.com';

update person 
set email = 'alecia@test.com'
where user = 'alecia';

delete from person;

insert into person(user, email, age, sex) values
('alecia','alecia@test.com', 22, 'f'),
('john','john@test.com', 19, 'm'),
('alexandra','alexandra@test.com', 24,'f'),
('james','james@test.com', 18,'m'),
('jordan','jordan@test.com', 23,'m'),
('terry','terry@test.com', 24,'m'),
('brenda','brenda@test.com', 22,'f'),
('kris','kris@test.com', 27, 'm'),
('pat','pat@test.com', 24,'m'),
('layla', 'layla@test.com', 25,'f');


update person
set user = 'jonanthanjones'
where email = 'john@test.com';
task 2:
-- find average age of users
select round(avg(age),1)
from person;

--find average per sex
select round(avg(age)) as 'avg age', sex
from person
group by sex;

--find min and max age of all
select * from person
where age IN (
select min(age)
from person);

select a.* from person a
join (
select min(age) as age
from person) b on a.age = b.age
;

with b as 
(select min(age) as age from person)
select * from person
where age in (select age from b);



select max(age)
from person;

--find min and max age per sex group
select min(age), max(age), sex
from person
group by sex;

select max(age), sex
from person
group by sex;

--find user with longest email address
/* select user, age
from person
order by age desc
limit 1; */

select user, email
from person
order by length(email) desc
limit 1;

--find user with longest email address and username (single string)
select user, email
from person
order by length(email) desc, length(user) desc
;

select user
from person
order by length(email) desc
limit 1;

select user
from person
order by length(user) desc
limit 1;

select concat(user,email)
from person
order by length(concat(user,email)) desc;

select user || email
from person;

--get users ordered by age, sex
select user, sex, age
from person
order by sex,age;

(select 'user', 'sex', 'age') 
union (select user, sex, age from person order by sex,age) 
into outfile '/opt/data_export/person9.csv' 
FIELDS ENCLOSED BY '' TERMINATED BY ',' 
ESCAPED BY '' LINES TERMINATED BY '\r\n';

/* create new table (address)
columns (
    -addressid (primary key),
    -city
    -street
    -street_number
    )
    */


create table address(
    address_id int auto_increment primary key,
    city varchar (256),
    street_name varchar(256),
    street_number int
);

alter table person
add person_address_id int unique;

/*
alter table person
drop person_address_id;
*/
alter table person
drop foreign key person_ibfk_1;


alter table address
add foreign key(address_id) 
references person(person_address_id)
on delete cascade
;

insert into address(city, street_name, street_number) values
('melbourne', 'chapel st', '447'),
('melbourne', 'smith st', '310'),
('melbourne', 'sydney road', '6'),
('melbourne', 'dandenong road', '11'),
('melbourne', 'earl st', '19'),
('melbourne', 'mulgrave road', '18'),
('melbourne', 'ocean road', '600'),
('melbourne', 'wellington road', '447'),
('melbourne', 'tennesse drive', '33')
;

insert into address values(7,'melbourne', 'mulgrave road', '18');


select user, city, street_name, street_number
from person 
join
address 
on person_address_id = address_id;

with a as (select * from person), b as (select * from address)
select a.user, b.city, b.street_name, b.street_number
from a a
left outer join 
b b
on a.person_address_id = b.address_id
where b.address_id is null
;

select user, city, street_name, street_number
from person 
right outer join
address 
on person_address_id = address_id;

delete from address
where address_id = 7;   

insert into person values('kris', 'kris@test.com', 24, 'm', null);

delete from person where user = 'kris';



