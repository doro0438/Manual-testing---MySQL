# Database Project for Oregon Inc.

The scope of this project is to use all the SQL knowledge gained throught the Software Testing course and apply them in practice.

Application under test: Oregon Inc. company database

Tool used: MySQL Workbench. To see the whole codesheet please click on the following [link].(./proiectfinal.sql)

Database description: The purpose of the database I created was to get an overview of a fictional company called Oregon Inc. The company provides Telecommunication services all over the world. They have different departments working in different locations. The database will store informations about the employees, such as name, address and other personal info, their contact person in case of emergency, the departments they work for and the project they are working on. Moreover these departments will be tied to different locations.

## Database Schema
You can find below the database schema that was generated through Reverse Engineer and which contains all the tables and the relationships between them.

<img width="615" alt="reverse engineer" src="https://github.com/user-attachments/assets/4550f022-c5f6-4718-9c7b-66f54086d823">

### Tables

#### Employee table: 
employeeId: primary key, auto-increment = automatically generates a sequential integer, cannot be left empty, integer
firstName: first name of the employee, string of up to 25 characters, cannot be left empty
lastName: last name of employee, string of 2up to 5 characters, cannot be left empty
emailaddress: email address, string of up to 30 characters, cannot be left empty
dateOfBirth: date of birth, data type date, cannot be left empty
age: age, integer, cannot be left empty
address: address, string of up to 40 characters
phoneNumber: phone number of the employee, integer, cannot be left empty
salary: salary amount, decimal number up to 10 decimal digits, cannot be left empty

#### Contact person table:
contactPersonId: primary key, auto_increment = automatically generates a sequential integer, datatype: integer
firstName; first name of contact person, datatype: string of up to 25 characterse: first name of the employee, datatype: string of 25 characters
lastName: last name of employee, datatype: string of up to 25 characters
phoneNumber: phone number of the contact person, datatype: integer
employeeId: foreign key references employees tables, datatype: integer

#### Departments table:
departmentId primary key, auto_increment = automatically generates a sequential integer, datatype: integer, cannot be left empty
departmentName: name of the department, datatype: string of up to 25 characters
employeeId: foreign key,references employees table, datatype: integer
locationId: foreign key, references location table, datatype: integer

#### Locations table:
locationId: primary key, auto_increment = automatically generates a sequential integer, datatype: integer, cannot be left empty
city: name of the city, datatype: string of 25 characters
country: name of the city, datatype: string of 25 characters
postalCode: postal code of the city, datatype: integer

#### Projects table:
projectId primary key, auto increment = automatically generates a sequential integer, datatype: integer, cannot be left empty
projectName: name of the project, datatype: string of 25 characters, cannot be left empty
deadlineDate: date - deadline of the project, datatype: date
employeeId: foreign key, references employee table, datatype: integer

#### Primary key
Primary key is a field in a table that uniquely identifies each row or record in a table. A primary key column cannot have a null value, it must contain s value for every row. MySQL automatically creates a unique index for the primary key, which helps in efficiently retrieving records.

#### Foreign key
Foreign key in MySQL is a column (or a set of columns) in one table that refers to the primary key in another table. It is used to establish and enforce a link between the data in two tables, ensuring referential integrity. This means that the foreign key ensures that the values in the foreign key column match the values in the referenced table's primary key, or are NULL.

### Table Relationships
1. 1:1 relationship
- The employees table and the contact_person tables has a 1:1 relationship. This means that the employee can only have one contact person and the conatct person is an emergency contact only to one person.

2. n:1 relationship

- Departments table  is connected with employees through a n:1 relationship which mean that departments can have multiple emmployees.

- Departments  is connected with locationss through a n:1 relationship. this relationship shows that one location can have multiple departments but one department is only found in one location.

- Projects  is connected with employees through a n:1 relationship which was implemented through projects.projetcId as a primary key and employees.employeeId as a foreign key. One employee can have multiple projects.

## Database Queries

1. DDL (Data Definition Language)

The following instructions were written in the scope of creating the structure of the database. Here the CREATE instructions will be listed.
 
First the database was created using the following query:

<code>create database my_company;</code>

Next step will be to create the tables for the database, namely: employees, project, departments, locations:

<code>create table employees( 
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
);</code>

<code>create table project(
projectId int not null auto_increment,
projectName varchar(25) not null,
deadlineDate date,
primary key (projectId),
employeeId int,
foreign key (employeeId) references employees (employeeId)
);</code>

<code>create table departments(
departmentId int not null auto_increment,
departmentName varchar(25),
primary key(departmentId),
employeeId int,
foreign key (employeeId) references employees (employeeId)
);</code>


<code>create table locations(
locationId int not null auto_increment,
city varchar(25),
country varchar(25),
postalCode int,
primary key(locationId)
);</code>

<code>reate table contact_person(
contactPersonId int not null auto_increment,
firstName varchar(25),
lastName varchar(25),
phoneNumber int(10),
primary key(contactPersonId),
employeeId int,
foreign key(employeeId) references employees (employeeId)
);</code>

After the database and the tables have been created, a few ALTER instructions were written in order to update the structure of the database, as described below:

- changing table name: <code>ALTER TABLE project RENAME projects;</code>
- define a new column: <code>ALTER TABLE departments ADD locationId int;</code>
- add a column as a foreign key: <code>ALTER TABLE departments ADD foreign key (locationId) references locations (locationId);</code>
- change column property: <code>ALTER TABLE employees modify emailaddress varchar(40);</code>
- delete a table column: <code>ALTER TABLE projects DROP COLUMN deadlineDate;</code>
- adding a new table column: <code>ALTER TABLE projects ADD startDate date;</code>
- delete a foreign key: <code>ALTER TABLE departments DROP FOREIGN KEY departments_ibfk_1;</code>
- add autoincrement to an id: <code>ALTER TABLE supervisers MODIFY supervisorId INT NOT NULL AUTO_INCREMENT;</code>
- delete a duplicate entry: <code>delete from contact_person where employeeId is null;</code>


2. DML (Data Manipulation Language)

In order to be able to use the database I populated the tables with various data necessary in order to perform queries and manipulate the data.
In the testing process, this necessary data is identified in the Test Design phase and created in the Test Implementation phase.

Below you can find all the insert instructions that were created in the scope of this project:

- insert made for certain columns:
<code>INSERT INTO locations (city, country, postalCode) values ("New York","United States","10001"),
("London","United Kingdom","12778"),
("Sydney","Australia","2000"),
("Tokyo","Japan","1000001"),
("Toronto","Canada","12345");</code>
  
- insert into all the columns-one row only:
<code>INSERT INTO employees values
("8","Michael","Johnson","michael.j@yahoo.com","1988-09-23","36","789 San Francisco Road, Austin, TX","345678912","101000");</code>

<code>INSERT INTO departments (departmentId, departmentName) values ("1","New York");</code>

- insert into all the columns-multiple rows:
<code>INSERT INTO employees values
("3","Jane","Smith","jane.smith@outlook.com","1985-03-22","39","456 Oak Ave, City, ST","234568901",	"75.000"),
("4","Michael","Johnson","michael.j@yahoo.com","1978-06-10","46","789 Pine Dr, City, ST","345678912","80.000"),
("5","Emily","Davis","emily.davis@gmail.com","1993-11-05","30","321 Maple Ln, City, ST","457890123"	,"55.000"),
("6","David","Wilson","david.w@example.com","1982-09-30","41","654 Birch Blvd, City, ST","567801234","70.000");</code>

<code>INSERT INTO projects (projectName, startDate, endDate) values
("Project Alpha","2024-01-01","2024-03-31"),
("Project Beta","2024-02-15","2024-04-30"),
("Project Gamma","2024-03-01","2024-06-30"),
("Project Delta","2024-04-10","2024-07-15"),
("Project Epsilon","2024-05-20","2024-08-30");</code>
  
  
<code>INSERT INTO departments (departmentId, departmentName) values 
("2","HR"),
("3","Sales"),
("4","Marketing"),
("5","IT");</code>

After the insert, in order to prepare the data to be better suited for the testing process, I updated some data in the following way:
  
- update a certain cell:
<code>UPDATE employees SET salary = "60000" WHERE employeeId="2";</code>

- update a cell since I entered the wrong information to it:
<code>UPDATE departments 
SET departmentName = "Accounting" 
WHERE departmentName = "New York";</code>

- added values to the foreign key:
<code>UPDATE `my_company`.`departments` SET `locationId` = '3' WHERE (`departmentId` = '1');</code>
<code>UPDATE `my_company`.`departments` SET `locationId` = '1' WHERE (`departmentId` = '2');</code>
<code>UPDATE `my_company`.`departments` SET `locationId` = '2' WHERE (`departmentId` = '3');</code>
<code>UPDATE `my_company`.`departments` SET `locationId` = '4' WHERE (`departmentId` = '4');</code>
<code>UPDATE `my_company`.`departments` SET `locationId` = '5' WHERE (`departmentId` = '5');</code>

- tied the Customer Success department with an employee:
<code>UPDATE departments 
SET employeeId="10"
WHERE departmentId = "8";</code>

- after adding a new column in the employee table, populated those cells with new value:
<code>UPDATE employees
SET country="United States"
WHERE employeeId = "2";</code>

<code>UPDATE employees
SET country="United States"
WHERE employeeId = "4";</code>(there were multiple rows entered, but the syntax is the same, so will not show every row)

3. DQL (Data Query Language)

After the testing process, I deleted the data that was no longer relevant in order to preserve the database clean:

<code>ALTER TABLE departments DROP FOREIGN KEY departments_ibfk_1;</code>
I did this step before adding the foreign key manually, because the first time connecting the two tables did not work. Thereofre, I deleted the foreign key relatinship which was set when creating the tables and after that did a connection manually, with the <code>UPDATE `my_company`.`departments` SET `locationId` = '5' WHERE (`departmentId` = '5');</code> explained earlier.

- delete unnecessary columns:
<code>ALTER TABLE projects CROP column deadlineDate;</code>

- delete the info in the supervisers table: 
<code>DELETE FROM supervisers;</code>  - this table was not used in the end that is why I did not put it in the beginning, hence it is not part of the database anymore

- deleted some entries as I inserted the data twice:
<code>delete from employees where employeeId="11";</code>

In order to simulate various scenarios that might happen in real life I created the following queries that would cover multiple potential real-life situations:

WHERE - searched for the people in the employees table whose first name is "Michael"
<code>SELECT * FROM employees WHERE firstName = "Michael";</code>

AND - select postalcode from the locations table where the country are United States and the city is New York
<code>SELECT postalCode FROM locations WHERE country = "United States" and city = "New York";</code>

OR - select employeeId, locationId for the rows where the departmane name is either HR or Marketing
<code>SELECT employeeId, locationId FROM departments WHERE departmentName = "HR" OR departmentName ="Marketing";</code>

LIKE - checking in the departments table if there are names that contain letter "e"
<code>SELECT * FROM departments WHERE departmentName LIKE "%e%";</code>

INNER JOIN - shows employeeid, firstname, lastName and departmentName the people who have associated a departments to their name
<code>SELECT employees.employeeId, employees.firstName, employees.lastName, departments.departmentName
FROM employees
INNER JOIN departments ON employees.employeeId=departments.employeeId;</code>

LEFT JOIN -  shows the people from contact person table who have the same lastname as the people from the employee table
<code>SELECT * FROM employees LEFT JOIN contact_person ON employees.lastName=contact_person.lastName;

CROSS JOIN - the locations tables row will be matched with the rows from the departmets table
<code>SELECT * FROM locations CROSS JOIN departments;</code>

RIGHT JOIN - show which employee is working on which project
<code>SELECT employeeId, firstName, projectName
FROM employees
RIGHT JOIN projects USING (employeeId);</code>

aggregate functions:
AVG - calculate average age of the employees in the employees table:
<code>SELECT avg(age) FROM employees;</code>

MIN - show the lowest salary in the employees table:
<code>SELECT min(salary) FROM employees;</code>

ORDER BY - order the employees by their age in acending order:
<code>SELECT * FROM employees ORDER BY age ASC;</code>

GROUP BY - counting how many cities are from the same country
<code>SELECT count(locationId) AS Number_of_cities_from_the_same_country FROM locations GROUP BY country;</code> 

HAVING - select the employeeId and country columns form employees table, group by country, exept the countries with only one employee
<code>SELECT COUNT(employeeId), Country 
FROM employees
GROUP BY Country
HAVING COUNT(employeeId) > 1;</code> 

LIMIT - show the first 3 data entry in the departments table:
<code>SELECT * FROM departments LIMIT 3;</code> 
 
LIMIT - show the first 7 data entry in the employees table:
<code>SELECT * FROM employees limit 7;</code> 

subquery - will only show the salaries which are below the average salary in the employee table and will show also the 
 difference between them in a column called salaryDifference
<code>SELECT employeeId, firstName, lastName, salary, 
       (salary - (SELECT AVG(salary) FROM employees)) AS salaryDifference
FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees);</code>

subquery - Find employees who are working in a department located in New York
<code>SELECT employeeId, firstName, lastName
FROM employees
WHERE employeeId IN (
    SELECT employeeId 
    FROM departments
    WHERE locationId = (SELECT locationId FROM locations WHERE city = 'New York')
);</code>

subquery- list the projects that are associated with employees in Australia
<code>SELECT projectId, projectName
FROM projects
WHERE employeeId IN (
    SELECT employeeId
    FROM employees
    WHERE country = 'Australia'
);</code>

subquery - Get contact persons related to employees working the Aplha and X projects
<code>SELECT contactPersonId, firstName, lastName, phoneNumber, relationship
FROM contact_person
WHERE employeeId IN (
    SELECT employeeId 
    FROM projects
    WHERE projectName = 'Project Alpha' or projectName = 'Project X'
);</code>


## Conclusions

In conclusion I got to see and dive deeper into how our company database could be looking like and how a possible HR website would store our personal info just as in the employees table. Besides, I learned how to manage the child-parent issues and how I can edit the info in those tables, as I got multiple conflicts regarding that I cannot edit foreign keys and had to find other ways to edit them using other sytanxes I knew up until now.

