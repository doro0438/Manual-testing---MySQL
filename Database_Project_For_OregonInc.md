<h1>Database Project for Oregon Inc.</h1>

The scope of this project is to use all the SQL knowledge gained throught the Software Testing course and apply them in practice.

Application under test: Oregon Inc. company database

Tools used: MySQL Workbench

Database description: The purpose of the database I created was to get an overview of a fictional company called Oregon Inc. The company provides Telecommunication services all over the world. They have different departments working in different locations. The database will store informations about the employees, such as name, address and other personal info, their contact person in case of emergency, the departments they work for and the project they are working on. Moreover these departments will be tied to different locations.

<ol>
<li>Database Schema </li>
<br>
You can find below the database schema that was generated through Reverse Engineer and which contains all the tables and the relationships between them.

The tables are connected in the following way:

<ul>
  <li> contact_person  is connected with employees through a 1:n relationship which was implemented through contactPersonId as a primary key and employees.locationId as a foreign key</li>
  <li> department  is connected with employees through a 1:1 relationship which was implemented through departments.departmentId as a primary key and employees.departmentId as a foreign key</li>
  <li> departments  is connected with locationss through a n:1 relationship which was implemented through departments.departmentId as a primary key and locations.locationId as a foreign key</li>
  <li> projects  is connected with employees through a n:1 relationship which was implemented through projects.projetcId as a primary key and employees.employeeId as a foreign key</li>
</ul><br>

<li>Database Queries</li><br>

<ol type="a">
  <li>DDL (Data Definition Language)</li>

  The following instructions were written in the scope of CREATING the structure of the database (CREATE INSTRUCTIONS)

  create database my_company;

  create table employees (
    employeeId int not null auto_increment,
    firstName varchar(25) not null,
    lastName varchar(25) not null,
    emailaddress varchar(30) not null,
    dateOfBirth date not null,
    age int not null,
    address varchar(40), 
    phoneNumber int not null, 
    salary float(10) not null, 
    primary key(employeeId)
  );
   create table project(
    projectId int not null auto_increment,
    projectName varchar(25) not null,
    deadlineDate date,
    primary key (projectId),
    employeeId int,
    foreign key (employeeId) references employees (employeeId)
  );

  create table departments(
    departmentId int not null auto_increment,
    departmentName varchar(25),
    primary key(departmentId),
    employeeId int,
    foreign key (employeeId) references employees (employeeId)
  );
  create table locations(
    locationId int not null auto_increment,
    city varchar(25),
    country varchar(25),
    postalCode int,
    primary key(locationId)
  );
  

After the database and the tables have been created, a few ALTER instructions were written in order to update the structure of the database, as described below:


<ul>
  <li>changing table name: alter table project rename projects;</li>
<li>define a new column: alter table departments add locationId int;</li>
<li>add a column as a foreign key: alter table departments add foreign key (locationId) references locations (locationId);</li>
<li>change column property: alter table employees modify emailaddress varchar(40);</li>
<li>delete a table column: alter table projects drop column deadlineDate;</li>
<li>adding a new table column: alter table projects add startDate date;</li>
<li>delete a foreign key: ALTER TABLE departments DROP FOREIGN KEY departments_ibfk_1;</li>
<li>add autoincrement to an id: ALTER TABLE supervisers modify supervisorId INT NOT NULL AUTO_INCREMENT;</li>
</ul><br>

  <li>DML (Data Manipulation Language)</li>

  In order to be able to use the database I populated the tables with various data necessary in order to perform queries and manipulate the data. 
  In the testing process, this necessary data is identified in the Test Design phase and created in the Test Implementation phase. 

  Below you can find all the insert instructions that were created in the scope of this project:

  insert made for certain columns:
  INSERT INTO locations (city, country, postalCode) values ("New York", "United States",	"10001"),
  ("London",	"United Kingdom",	"12778"),
  ("Sydney",	"Australia",	"2000"),
  ("Tokyo",	"Japan",	"1000001"),
  ("Toronto",	"Canada",	"12345");

  insert into all the columns-one row only:
  INSERT INTO employees values
  ("8","Michael",	"Johnson",	"michael.j@yahoo.com",	"1988-09-23",	"36",	"789 San Francisco Road, Austin, TX",	"345678912",	"101000");

  insert into all the columns-multiple rows:
  INSERT INTO employees values
  ("3", "Jane",	"Smith",	"jane.smith@outlook.com",	"1985-03-22",	"39",	"456 Oak Ave, City, ST",	"234568901",	"75.000"),
  ("4","Michael",	"Johnson",	"michael.j@yahoo.com",	"1978-06-10",	"46",	"789 Pine Dr, City, ST",	"345678912",	"80.000"),
  ("5",	"Emily",	"Davis",	"emily.davis@gmail.com",	"1993-11-05",	"30",	"321 Maple Ln, City, ST",	"457890123"	,"55.000"),
  ("6",	"David",	"Wilson",	"david.w@example.com",	"1982-09-30",	"41",	"654 Birch Blvd, City, ST",	"567801234",	"70.000");

  INSERT INTO projects (projectName, startDate, endDate) values
  ("Project Alpha", "2024-01-01",	"2024-03-31"),
  (	"Project Beta",	"2024-02-15",	"2024-04-30"),
  (	"Project Gamma", "2024-03-01",	"2024-06-30"),
  (	"Project Delta", "2024-04-10",	"2024-07-15"),
  ("Project Epsilon", "2024-05-20",	"2024-08-30");

  INSERT INTO departments (departmentId, departmentName) values ("1",	"New York");
  
  INSERT INTO departments (departmentId, departmentName) values 
  ("2",	"HR"),
  ("3",	"Sales"),
  ("4",	"Marketing"),
  ("5",	"IT");

  After the insert, in order to prepare the data to be better suited for the testing process, I updated some data in the following way:

  <ul>
  <li>update a certain cell:
  UPDATE employees SET salary = "60000" WHERE employeeId="2";</li>

   <li>update a cell since I entered the wrong information to it:
  UPDATE departments 
  SET departmentName = "Accounting" 
  WHERE departmentName = "New York";</li>

   <li>added values to the foreign key:
  UPDATE `my_company`.`departments` SET `locationId` = '3' WHERE (`departmentId` = '1');
  UPDATE `my_company`.`departments` SET `locationId` = '1' WHERE (`departmentId` = '2');
  UPDATE `my_company`.`departments` SET `locationId` = '2' WHERE (`departmentId` = '3');
  UPDATE `my_company`.`departments` SET `locationId` = '4' WHERE (`departmentId` = '4');
  UPDATE `my_company`.`departments` SET `locationId` = '5' WHERE (`departmentId` = '5');</li>

   <li>tied the Customer Success department with an employee:
  UPDATE departments 
  SET employeeId="10"
  WHERE departmentId = "8";</li>

   <li>after adding a new column in the employee table, populated those cells with new value:
  UPDATE employees
  SET country="United States"
  WHERE employeeId = "2";

  UPDATE employees
  SET country="United States"
  WHERE employeeId = "4"; (there were multiple rows entered, but the syntax is the same, so will not show every row)</li>
</ul><br>


  <li>DQL (Data Query Language)</li>

After the testing process, I deleted the data that was no longer relevant in order to preserve the database clean: 
  <ul>
 <li>ALTER TABLE departments DROP FOREIGN KEY departments_ibfk_1;</li>

 <li>delete unnecessary columns:
ALTER TABLE projects
CROP column deadlineDate;</li>

 <li>delete the info in the supervisers table:
DELETE FROM supervisers;  - this table was not used in the end that is why i did not put it in the beginning, hence it is not part of the database anymore</li>
</ul><br>

In order to simulate various scenarios that might happen in real life I created the following queries that would cover multiple potential real-life situations:

where - searched for the people in the employees table whose first name is "Michael"<br>
SELECT * FROM employees WHERE firstName = "Michael";

AND - select postalcode from the locations table where the country are United States and the city is New York<br>
SELECT postalCode FROM locations WHERE country = "United States" and city = "New York";

OR - select employeeId, locationId for the rows where the departmane name is either HR or Marketing<br>
SELECT employeeId, locationId FROM departments WHERE departmentName = "HR" OR departmentName ="Marketing";
NOT<br>

like - checking in the departments table if there are names that contain letter "e"<br>
SELECT * FROM departments WHERE departmentName LIKE "%e%";

inner join - shows employeeid, firstname, lastName and departmentName the people who have associated a departments to their name<br>
SELECT employees.employeeId, employees.firstName, employees.lastName, departments.departmentName
FROM employees
INNER JOIN departments ON employees.employeeId=departments.employeeId;

left join<br>
SELECT * FROM employees LEFT JOIN contact_person ON employees.lastName=contact_person.lastName;

cross join - the locations tables row will be matched with the rows from the departmnets table:<br>
SELECT * FROM locations CROSS JOIN departments;

right join - show which employee is working on which project<br>
SELECT employeeId, firstName, projectName
FROM employees
RIGHT JOIN projects USING (employeeId);

agregate functions<br>
avg - calculate average age of the employees in the employees table:
SELECT avg(age) FROM employees;
min - show the lowest salary in the employees table:
SELECT min(salary) FROM employees;

order by - order the employees by their age in acending order:
SELECT * FROM employees ORDER BY age ASC; 

- group by - counting how many cities are from the same country<br>
SELECT count(locationId) AS Number_of_cities_from_the_same_country FROM locations GROUP BY country;

- having<br>
SELECT COUNT(employeeId), Country
FROM employees
GROUP BY Country
HAVING COUNT(employeeId) > 1;

limit - show the first 3 data entry in the departments table:
SELECT * FROM departments LIMIT 3;
 
limit - show the first 7 data entry in the employees table:
SELECT * FROM employees limit 7;

</ol>

<li>Conclusions</li>

In conclusion I got to see and dive deeper into how our company database is looking like and how a possible HR website would store our personal info just as in the employees table. Besides, I learned how to manage the child-parent issues and how I can edit the info in those tables, as I got multiple conflicts regarding that I cannot edit foreign keys and had to find other ways to edit them using other sytanxes I knew up until now. 

</ol>
