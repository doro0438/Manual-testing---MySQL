<h1>Database Project for Oregon Inc.</h1>

<p>The scope of this project is to use all the SQL knowledge gained throught the Software Testing course and apply them in practice.</p>

<p>Application under test: Oregon Inc. company database</p>

<p>Tools used: MySQL Workbench</p>

<p>Database description: The purpose of the database I created was to get an overview of a fictional company called Oregon Inc. The company provides Telecommunication services all over the world. They have different departments working in different locations. The database will store informations about the employees, such as name, address and other personal info, their contact person in case of emergency, the departments they work for and the project they are working on. Moreover these departments will be tied to different locations.</p>

<ol>
<li>Database Schema </li>
<br>
<p>You can find below the database schema that was generated through Reverse Engineer and which contains all the tables and the relationships between them.</p>
  
<p>The tables are connected in the following way:</p>

<ul>
  <li> contact_person  is connected with employees through a 1:n relationship which was implemented through contactPersonId as a primary key and employees.locationId as a foreign key</li>
  <li> department  is connected with employees through a 1:1 relationship which was implemented through departments.departmentId as a primary key and employees.departmentId as a foreign key</li>
  <li> departments  is connected with locationss through a n:1 relationship which was implemented through departments.departmentId as a primary key and locations.locationId as a foreign key</li>
  <li> projects  is connected with employees through a n:1 relationship which was implemented through projects.projetcId as a primary key and employees.employeeId as a foreign key</li>
</ul><br>

<li>Database Queries</li><br>

<ol type="a">
  <li>DDL (Data Definition Language)</li>

 <p>The following instructions were written in the scope of CREATING the structure of the database (CREATE INSTRUCTIONS)</p>

<code>create database my_company;<br></code>

<code>create table employees ( <br>
employeeId int not null auto_increment,<br>
firstName varchar(25) not null,<br>
lastName varchar(25) not null,<br>
emailaddress varchar(30) not null,<br>
dateOfBirth date not null,<br>
age int not null,<br>
address varchar(40), <br>
phoneNumber int not null, <br>
salary float(10) not null, <br>
primary key(employeeId)<br>
);</code>
<br>

<code>create table project(<br>
projectId int not null auto_increment,<br>
projectName varchar(25) not null,<br>
deadlineDate date,<br>
primary key (projectId),<br>
employeeId int,<br>
foreign key (employeeId) references employees (employeeId)<br>
);</code><br>

<code>create table departments(<br>
departmentId int not null auto_increment,<br>
departmentName varchar(25),<br>
primary key(departmentId),<br>
employeeId int,<br>
foreign key (employeeId) references employees (employeeId)<br>
);</code><br>

<code>create table locations(<br>
locationId int not null auto_increment,<br>
city varchar(25),<br>
country varchar(25),<br>
postalCode int,<br>
primary key(locationId)<br>
);</code><br>
  

<p>After the database and the tables have been created, a few ALTER instructions were written in order to update the structure of the database, as described below:</p>


<ul>
  <li>changing table name: <code>alter table project rename projects;</code></li>
<li>define a new column: <code>alter table departments add locationId int;</code></li>
<li>add a column as a foreign key: <code>alter table departments add foreign key (locationId) references locations (locationId);</code></li>
<li>change column property: <code>alter table employees modify emailaddress varchar(40);</code></li>
<li>delete a table column: <code>alter table projects drop column deadlineDate;</code></li>
<li>adding a new table column: <code>alter table projects add startDate date;</code></li>
<li>delete a foreign key: <code>ALTER TABLE departments DROP FOREIGN KEY departments_ibfk_1;</code></li>
<li>add autoincrement to an id: <code>ALTER TABLE supervisers modify supervisorId INT NOT NULL AUTO_INCREMENT;</code></li>
</ul><br>

  <li>DML (Data Manipulation Language)</li>

<p>In order to be able to use the database I populated the tables with various data necessary in order to perform queries and manipulate the data.</p>
<p>In the testing process, this necessary data is identified in the Test Design phase and created in the Test Implementation phase.</p>

<p>Below you can find all the insert instructions that were created in the scope of this project:</p>
insert made for certain columns:<br>
<code>INSERT INTO locations (city, country, postalCode) values ("New York", "United States",	"10001"),<br>
  ("London",	"United Kingdom",	"12778"),<br>
  ("Sydney",	"Australia",	"2000"),<br>
  ("Tokyo",	"Japan",	"1000001"),<br>
  ("Toronto",	"Canada",	"12345");</code><br>
  <br>

insert into all the columns-one row only:<br>
<code>INSERT INTO employees values<br>
("8","Michael",	"Johnson",	"michael.j@yahoo.com",	"1988-09-23",	"36",	"789 San Francisco Road, Austin, TX",	"345678912",	"101000");</code><br>

insert into all the columns-multiple rows:<br>
<code>INSERT INTO employees values<br>
  ("3", "Jane",	"Smith",	"jane.smith@outlook.com",	"1985-03-22",	"39",	"456 Oak Ave, City, ST",	"234568901",	"75.000"),<br>
  ("4","Michael",	"Johnson",	"michael.j@yahoo.com",	"1978-06-10",	"46",	"789 Pine Dr, City, ST",	"345678912",	"80.000"),<br>
  ("5",	"Emily",	"Davis",	"emily.davis@gmail.com",	"1993-11-05",	"30",	"321 Maple Ln, City, ST",	"457890123"	,"55.000"),<br>
  ("6",	"David",	"Wilson",	"david.w@example.com",	"1982-09-30",	"41",	"654 Birch Blvd, City, ST",	"567801234",	"70.000");</code><br>

<code>INSERT INTO projects (projectName, startDate, endDate) values<br>
  ("Project Alpha", "2024-01-01",	"2024-03-31"),<br>
  (	"Project Beta",	"2024-02-15",	"2024-04-30"),<br>
  (	"Project Gamma", "2024-03-01",	"2024-06-30"),<br>
  (	"Project Delta", "2024-04-10",	"2024-07-15"),<br>
  ("Project Epsilon", "2024-05-20",	"2024-08-30");</code>
  <br>

  <code>INSERT INTO departments (departmentId, departmentName) values ("1",	"New York");</code>
  
  <code>INSERT INTO departments (departmentId, departmentName) values <br>
  ("2",	"HR"),<br>
  ("3",	"Sales"),<br>
  ("4",	"Marketing"),<br>
  ("5",	"IT");</code><br>

  <p>After the insert, in order to prepare the data to be better suited for the testing process, I updated some data in the following way:</p>

  <ul>
  <li>update a certain cell:<br>
  <code>UPDATE employees SET salary = "60000" WHERE employeeId="2";</code></li>

  <li>update a cell since I entered the wrong information to it:<br>
  <code>UPDATE departments 
  SET departmentName = "Accounting" 
  WHERE departmentName = "New York";</code></li>

  <li>added values to the foreign key:<br>
  <code>UPDATE `my_company`.`departments` SET `locationId` = '3' WHERE (`departmentId` = '1');</code>><br>
  <code>UPDATE `my_company`.`departments` SET `locationId` = '1' WHERE (`departmentId` = '2');</code><br>
  <code>UPDATE `my_company`.`departments` SET `locationId` = '2' WHERE (`departmentId` = '3');</code><br>
  <code>UPDATE `my_company`.`departments` SET `locationId` = '4' WHERE (`departmentId` = '4');</code><br>
  <code>UPDATE `my_company`.`departments` SET `locationId` = '5' WHERE (`departmentId` = '5');</code></li>

   <li>tied the Customer Success department with an employee:<br>
<code>UPDATE departments 
SET employeeId="10"
WHERE departmentId = "8";</code></li>

   <li>after adding a new column in the employee table, populated those cells with new value:<br>
<code>UPDATE employees<br>
SET country="United States"<br>
WHERE employeeId = "2";</code><br>

<code>UPDATE employees<br>
SET country="United States"<br>
WHERE employeeId = "4";</code>(there were multiple rows entered, but the syntax is the same, so will not show every row)</li>
</ul><br>


  <li>DQL (Data Query Language)</li>

<p>After the testing process, I deleted the data that was no longer relevant in order to preserve the database clean:</p>
  <ul>
 <li><code>ALTER TABLE departments DROP FOREIGN KEY departments_ibfk_1;</code></li>

 <li>delete unnecessary columns:
<code>ALTER TABLE projects CROP column deadlineDate;</code></li>

 <li>delete the info in the supervisers table:
<code>DELETE FROM supervisers;</code>  - this table was not used in the end that is why i did not put it in the beginning, hence it is not part of the database anymore</li>
</ul><br>

<p>In order to simulate various scenarios that might happen in real life I created the following queries that would cover multiple potential real-life situations:</p><br>

where - searched for the people in the employees table whose first name is "Michael"<br>
<code>SELECT * FROM employees WHERE firstName = "Michael";</code>

AND - select postalcode from the locations table where the country are United States and the city is New York<br>
<code>SELECT postalCode FROM locations WHERE country = "United States" and city = "New York";</code>

OR - select employeeId, locationId for the rows where the departmane name is either HR or Marketing<br>
<code>SELECT employeeId, locationId FROM departments WHERE departmentName = "HR" OR departmentName ="Marketing";</code>
<br>

like - checking in the departments table if there are names that contain letter "e"<br>
<code>SELECT * FROM departments WHERE departmentName LIKE "%e%";</code>

inner join - shows employeeid, firstname, lastName and departmentName the people who have associated a departments to their name<br>
<code>SELECT employees.employeeId, employees.firstName, employees.lastName, departments.departmentName<br>
FROM employees<br>
INNER JOIN departments ON employees.employeeId=departments.employeeId;</code><br>

left join<br>
<code>SELECT * FROM employees LEFT JOIN contact_person ON employees.lastName=contact_person.lastName;

cross join - the locations tables row will be matched with the rows from the departmnets table:<br>
<code>SELECT * FROM locations CROSS JOIN departments;</code>

right join - show which employee is working on which project<br>
<code>SELECT employeeId, firstName, projectName
FROM employees
RIGHT JOIN projects USING (employeeId);</code>

agregate functions<br>
avg - calculate average age of the employees in the employees table:<br>
<code>SELECT avg(age) FROM employees;</code><br>

min - show the lowest salary in the employees table:<br>
<code>SELECT min(salary) FROM employees;</code><br>

order by - order the employees by their age in acending order:<br>
<code>SELECT * FROM employees ORDER BY age ASC;</code>

group by - counting how many cities are from the same country<br>
<code>SELECT count(locationId) AS Number_of_cities_from_the_same_country FROM locations GROUP BY country;</code> 

having<br>
<code>SELECT COUNT(employeeId), Country <br>
FROM employees<br>
GROUP BY Country<br>
HAVING COUNT(employeeId) > 1;</code> 

limit - show the first 3 data entry in the departments table:<br>
<code>SELECT * FROM departments LIMIT 3;</code> 
 
limit - show the first 7 data entry in the employees table:<br>
<code>SELECT * FROM employees limit 7;</code> </ol>

<li>Conclusions</li>

In conclusion I got to see and dive deeper into how our company database could be looking like and how a possible HR website would store our personal info just as in the employees table. Besides, I learned how to manage the child-parent issues and how I can edit the info in those tables, as I got multiple conflicts regarding that I cannot edit foreign keys and had to find other ways to edit them using other sytanxes I knew up until now. 

</ol>
