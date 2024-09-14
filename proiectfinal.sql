-- creating the database
create database my_company;
-- create table employees
create table employees (
employeeId int not null auto_increment,
firstName varchar(25) not null,
lastName varchar(25) not null,
emailaddress varchar(20) not null,
dateOfBirth date not null,
age int(3) not null,
address varchar(40), 
phoneNumber int(10) not null, 
salary float(10) not null, 
bonusfor2023  float(10, 2),
bonusfor2022 float(10, 2),
primary key(employeeId)
);
 -- create project table
 create table project(
projectId int not null auto_increment,
projectName varchar(25) not null,
deadlineDate date,
primary key (projectId),
employeeId int,
foreign key (employeeId) references employees (employeeId));
-- create departments table
 create table departments(
departmentId int not null auto_increment,
departmentName varchar(25),
primary key(departmentId),
employeeId int,
foreign key (employeeId) references employees (employeeId));
-- create table locations
create table locations(
locationId int not null auto_increment,
city varchar(25),
country varchar(25),
postalCode int,
primary key(locationId)
);

-- rename project table
alter table project rename projects;

-- define and add locationId to departments table
alter table departments add locationId int;
alter table departments
add foreign key (locationId) references locations (locationId);

-- add FK to departments table
alter table departments add employeeId int;
alter table departments
add foreign key (employeeId) references employees (employeeId);

-- create contact_person table
create table contact_person(
contactPersonId int not null auto_increment,
firstName varchar(25),
lastName varchar(25),
phoneNumber int(10),
primary key(contactPersonId),
employeeId int,
foreign key(employeeId) references employees (employeeId)
);

-- delete column from projects table and add 2 new columns
alter table projects
drop column deadlineDate;

alter table projects
add startDate date;

alter table projects 
add endDate date;

-- delete columns from employees table
alter table employees
drop bonusfor2023;

alter table employees
drop bonusfor2022;

-- add values into the employees table
insert into employees  values ("2", "John", "Doe", "john.doe@example.com", "1990-01-15", "34", "123 Elm St, City, ST", "123456790", "60.0000");

-- changing column properties
alter table employees
modify emailaddress varchar(40);

alter table employees
modify phoneNumber int;

-- adding values into employees table
insert into employees values("3", "Jane",	"Smith",	"jane.smith@outlook.com",	"1985-03-22",	"39",	"456 Oak Ave, City, ST",	"234568901",	"75.000"),
("4","Michael",	"Johnson",	"michael.j@yahoo.com",	"1978-06-10",	"46",	"789 Pine Dr, City, ST",	"345678912",	"80.000"),
("5",	"Emily",	"Davis",	"emily.davis@gmail.com",	"1993-11-05",	"30",	"321 Maple Ln, City, ST",	"457890123"	,"55.000"),
("6",	"David",	"Wilson",	"david.w@example.com",	"1982-09-30",	"41",	"654 Birch Blvd, City, ST",	"567801234",	"70.000");

-- adding values into the projects table
insert into projects (projectName, startDate, endDate)
values ("Project Alpha", "2024-01-01",	"2024-03-31"),
(	"Project Beta",	"2024-02-15",	"2024-04-30"),
(	"Project Gamma", "2024-03-01",	"2024-06-30"),
(	"Project Delta", "2024-04-10",	"2024-07-15"),
("Project Epsilon", "2024-05-20",	"2024-08-30");

-- add values into the contact_person table
insert into contact_person (firstName, lastName, phoneNumber, relationship) values (	"Jane",	"Doe",	"555123457", "wife");
insert into contact_person (firstName, lastName, phoneNumber, relationship) 
values ("John",	"Smith","555234568", "best friend"),
("Alice",	"Johnson",	"555345678",	"sister"),
("Bob",	"Brown",	"555456789", 	"dad"),
("Jackson",	"Miles",	"666905106", 	"Son");

insert into contact_person (firstName, lastName, phoneNumber, relationship, employeeId) values (	"Jane",	"Doe",	"555123457", "wife", "2");

-- add new column to contact_person table
alter table contact_person add relationship varchar (25);

alter table contact_person add relationship varchar(30);

-- change property of the phoneNumber column
alter table contact_person modify phoneNumber int;

-- add info to the departments table
insert into departments (departmentId, departmentName) values ("1",	"New York");
insert into departments (departmentId, departmentName) values ("2",	"HR"),
("3",	"Sales"),
("4",	"Marketing"),
("5",	"IT");

-- add values into the locations table
insert into locations (city, country, postalCode) values ("New York", "United States",	"10001"),
("London",	"United Kingdom",	"12778"),
("Sydney",	"Australia",	"2000"),
("Tokyo",	"Japan",	"1000001"),
("Toronto",	"Canada",	"12345");

select * from locations;
insert into departments (employeeId) values ("1");
update departments 
set employeeId = "1";


SET SQL_SAFE_UPDATES=0; 

-- update salary as I entered them wrong, instead of 60000 put 60
update employees 
set salary = "60000" where employeeId="2";

update employees 
set salary = "75000" where employeeId="3";

update employees 
set salary = "80000" where employeeId="4";

update employees 
set salary = "55000" where employeeId="5";

update employees 
set salary = "70000" where employeeId="6";

desc departments;

-- show the departmentname and employeeId from a table
select departmentName, employeeId from departments;

-- delete all the projects where the enddate was in march
delete from projects where endDate like "%03%";

-- add new row to employees table
insert into employees values("8","Michael",	"Johnson",	"michael.j@yahoo.com",	"1988-09-23",	"36",	"789 San Francisco Road, Austin, TX",	"345678912",	"101000");

-- where: searched for the people in the employees table whose first name is "Michael"
select * from employees where firstName = "Michael";

-- like: checking in the departments table if there are names that contain letter e
select * from departments where departmentName like "%e%";

-- and: select postalcode from the locations table where the country are United States and the city is Los Angeles
select postalCode from locations where country = "United States" and city = "New York";

insert into locations (city, country, postalCode) values ("Los Angeles", "United States",	"10045");

-- or: select employeeId, locationId for the rows where the departmane name is either HR or Marketing
select employeeId, locationId from departments where departmentName = "HR" or departmentName ="Marketing";

select * from employees;
select * from projects;
select * from departments;
select * from locations;
SET SQL_SAFE_UPDATES=0; 

-- aggregate functions

-- calculate average age of the employees in the employees table
select avg(age) from employees;

-- show the lowest salary in the employees table
select min(salary) from employees;

-- delete foreign key
ALTER TABLE departments DROP FOREIGN KEY employeeId;

ALTER TABLE departments DROP FOREIGN KEY departments_ibfk_1;

-- update table departments
update departments 
set departmentName = "Accounting" 
where departmentName = "New York";

select * from departments;
select * from locations;

-- add foreign key to departments
alter table departments add locationId int;
alter table departments
add foreign key (locationId) references locations (locationId);

-- populate locationId
UPDATE `my_company`.`departments` SET `locationId` = '3' WHERE (`departmentId` = '1');
UPDATE `my_company`.`departments` SET `locationId` = '1' WHERE (`departmentId` = '2');
UPDATE `my_company`.`departments` SET `locationId` = '2' WHERE (`departmentId` = '3');
UPDATE `my_company`.`departments` SET `locationId` = '4' WHERE (`departmentId` = '4');
UPDATE `my_company`.`departments` SET `locationId` = '5' WHERE (`departmentId` = '5');



select * from contact_person;
select * from departments;
select * from locations;
select * from employees;
select * from projects;

-- filter aggregate functions

-- count how many employees have a bigger salary than 70000
select count(*) from employees where salary>=70000;
-- select first name and last name for the employees who are older than 40
select firstName, lastName from employees where age<40;
-- show all the info for the locations other than the United States
select * from locations where country<>"United States";
-- show the projects which end later than the current date
select * from projects where endDate>curdate();
-- show the projects which end later than the current date but before 2025
select * from projects where endDate>curdate() AND extract(year from endDate) < 2025;

-- add values into the projects table
insert into projects (projectName, startDate, endDate)
values ("Project X", "2024-01-01",	"2024-12-31"),
("Project Z", "2024-06-01",	"2025-01-23");

-- cross join: matches all rows from the departments table with all rows from locations table
select * from departments cross join locations;

-- cross join: show the department name and employeeId where the locationid is the same in the departments and 
-- locations tables
SELECT departments.departmentName, employeeId
FROM departments
CROSS JOIN locations
WHERE departments.locationId=locations.locationId;


-- add a new row into the employees table 
insert into employees (firstName, lastName, emailaddress, dateOfBirth, age, address,phoneNumber, salary) values( "Antonia",	"Smorregad",	"antoniash@outlook.com",	"1985-03-22",	"39",	"456 Oak Ave, City, ST",	"555123457",	"57500"),
("Tim",	"Morrisson",	"morrison.tim23@yahoo.com",	"1978-06-10",	"46",	"789 Pine Dr, City, ST",	"555345678",	"86000");

-- inner join: shows employeeid, firstname, lastName and departmentName the people who have associated a departments to their name
SELECT employees.employeeId, employees.firstName, employees.lastName, departments.departmentName
FROM employees
INNER JOIN departments ON employees.employeeId=departments.employeeId;

select * from departments;

-- delete an entry as I inserted the same value twice
delete from employees where employeeId="11";
delete from employees where employeeId="8";
delete from employees where employeeId="9";
delete from employees where employeeId="10";

# left join: shows the people from contact person table who have the same lastname as the people from the employee table
 select * from employees left join contact_person on employees.lastName=contact_person.lastName;

-- right join: show which employee is working on which project
SELECT employeeId, firstName, projectName
FROM employees
Right JOIN projects USING (employeeId);
  
select * from projects;
select * from employees;

-- add employeeid to the project table
UPDATE `my_company`.`projects` SET `employeeId` = '1' WHERE (`projectId` = '1');


UPDATE `my_company`.`projects` SET `employeeId` = '2' WHERE (`projectId` = '2');
UPDATE `my_company`.`projects` SET `employeeId` = '2' WHERE (`projectId` = '5');
UPDATE `my_company`.`projects` SET `employeeId` = '3' WHERE (`projectId` = '6');
UPDATE `my_company`.`projects` SET `employeeId` = '8' WHERE (`projectId` = '7');

-- limit: show the first 3 data entry in the departments table
 SELECT * FROM departments LIMIT 3;
 
 -- limit: show the first 7 data entry in the employees table
 select * from employees limit 7;
 
 -- order by: order the employees by their age in acending order
 SELECT * FROM employees ORDER BY age ASC; 
 
-- add values into the locations table
insert into locations (city, country, postalCode) values ("Osaka", "Japan",	"1012311"),
("Vancouver", "Canada",	"3451"),
("Melbourne", "Australia",	"35551"),
("Kent", "United Kingdom",	"121151"),
("Manchester", "United Kingdom", "35551"),
("Liverpool", "United Kingdom", "6751");
-- group by counting how many cities are from the same country
select count(locationId) as Number_of_cities_from_the_same_country from locations group by country;

-- add new row into the departments table
insert into departments (departmentName, locationId) values ("Customer Success", "2");

-- add an employeeId to the csutomer success team
update departments 
set employeeId="10"
where departmentId = "8";

-- add new column to employees
alter table employees 
add country varchar(20);

-- give info to the new column country in the employees table
update employees
set country="United States"
where employeeId = "2";

update employees
set country="United States"
where employeeId = "4";

update employees
set country="United States"
where employeeId = "6";

update employees
set country="United States"
where employeeId = "9";

update employees
set country="Poland"
where employeeId = "3";

update employees
set country="Poland"
where employeeId = "5";

update employees
set country="Australia"
where employeeId = "12";

update employees
set country="South Koreea"
where employeeId = "7";

-- having: select the employeeId and country columns form employees table, group by country, exept the countries with 
-- only one employee
SELECT count(employeeId), Country
FROM employees
GROUP BY Country
HAVING COUNT(employeeId) > 1;

-- add employeeids to department table
UPDATE `my_company`.`departments` SET `employeeId` = '2' WHERE (`departmentId` = '1');
UPDATE `my_company`.`departments` SET `employeeId` = '3' WHERE (`departmentId` = '2');
UPDATE `my_company`.`departments` SET `employeeId` = '4' WHERE (`departmentId` = '3');
UPDATE `my_company`.`departments` SET `employeeId` = '5' WHERE (`departmentId` = '4');
UPDATE `my_company`.`departments` SET `employeeId` = '6' WHERE (`departmentId` = '5');
UPDATE `my_company`.`departments` SET `employeeId` = '12' WHERE (`departmentId` = '7');
select * from employees;

select * from employees;
select * from contact_person;
delete from contact_person where employeeId is null;

-- subquery: will only show the salaries which are below the average salary in the employee table and will show also the 
-- difference between them in a column called salaryDifference
SELECT employeeId, firstName, lastName, salary, 
       (salary - (SELECT AVG(salary) FROM employees)) AS salaryDifference
FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees);

-- subquery: Find employees who are working in a department located in New York
SELECT employeeId, firstName, lastName
FROM employees
WHERE employeeId IN (
    SELECT employeeId 
    FROM departments
    WHERE locationId = (SELECT locationId FROM locations WHERE city = 'New York')
);

-- subquery: list the projects that are associated with employees in Australia
SELECT projectId, projectName
FROM projects
WHERE employeeId IN (
    SELECT employeeId
    FROM employees
    WHERE country = 'Australia'
);

-- subquery: Get contact persons related to employees working on the Aplha and X projects
SELECT contactPersonId, firstName, lastName, phoneNumber, relationship
FROM contact_person
WHERE employeeId IN (
    SELECT employeeId 
    FROM projects
    WHERE projectName = 'Project Alpha' or projectName = 'Project X'
);
