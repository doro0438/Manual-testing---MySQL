# Database Project for Oregon Inc.

The scope of this project is to use all the SQL knowledge gained throught the Software Testing course and apply them in practice.

**Application under test:** Oregon Inc. company database

**Tool used:** MySQL Workbench. To see the whole codesheet please click on the following [link](./proiectfinal.sql).

**Database description:** The purpose of the database I created was to get an overview of a fictional company called Oregon Inc. The company provides Telecommunication services all over the world. They have different departments working in different locations. The database will store informations about the employees, such as name, address and other personal info, their contact person in case of emergency, the departments they work for and the project they are working on. Moreover these departments will be tied to different locations.

## Database Schema
You can find below the database schema that was generated through Reverse Engineer and which contains all the tables and the relationships between them.

<img width="615" alt="reverse engineer" src="https://github.com/user-attachments/assets/4550f022-c5f6-4718-9c7b-66f54086d823">

### Tables

#### Employee table: 
- **employeeId:** primary key, auto-increment = automatically generates a sequential integer, cannot be left empty, integer
- **firstName**: first name of the employee, string of up to 25 characters, cannot be left empty
- **lastName**: last name of employee, string of 2up to 5 characters, cannot be left empty
- **emailaddress**: email address, string of up to 30 characters, cannot be left empty
- **dateOfBirth**: date of birth, data type date, cannot be left empty
- **age**: age, integer, cannot be left empty
- **address**: address, string of up to 40 characters
- **phoneNumber**: phone number of the employee, integer, cannot be left empty
- **salary**: salary amount, decimal number up to 10 decimal digits, cannot be left empty

#### Contact person table:
- **contactPersonId**: primary key, auto_increment = automatically generates a sequential integer, datatype: integer
- **firstName**: first name of contact person, datatype: string of up to 25 characterse: first name of the employee, datatype: string of 25 characters
- **lastName**: last name of employee, datatype: string of up to 25 characters
- **phoneNumber**: phone number of the contact person, datatype: integer
- **employeeId**: foreign key references employees tables, datatype: integer

#### Departments table:
- **departmentId**: primary key, auto_increment = automatically generates a sequential integer, datatype: integer, cannot be left empty
- **departmentName**: name of the department, datatype: string of up to 25 characters
- **employeeId**: foreign key,references employees table, datatype: integer
- **locationId**: foreign key, references location table, datatype: integer

#### Locations table:
- **locationId**: primary key, auto_increment = automatically generates a sequential integer, datatype: integer, cannot be left empty
- **city**: name of the city, datatype: string of 25 characters
- **country**: name of the city, datatype: string of 25 characters
- **postalCode**: postal code of the city, datatype: integer

#### Projects table:
- **projectId**: primary key, auto increment = automatically generates a sequential integer, datatype: integer, cannot be left empty
- **projectName**: name of the project, datatype: string of 25 characters, cannot be left empty
- **deadlineDate**: date - deadline of the project, datatype: date
- **employeeId**: foreign key, references employee table, datatype: integer

#### Primary key
Primary key is a field in a table that uniquely identifies each row or record in a table. A primary key column cannot have a null value, it must contain s value for every row. MySQL automatically creates a unique index for the primary key, which helps in efficiently retrieving records.

#### Foreign key
Foreign key in MySQL is a column (or a set of columns) in one table that refers to the primary key in another table. It is used to establish and enforce a link between the data in two tables, ensuring referential integrity. This means that the foreign key ensures that the values in the foreign key column match the values in the referenced table's primary key, or are NULL.

### Table Relationships
1. 1:1 relationship
- The _employees_ table and the _contact_person_ tables has a _1:1_ relationship. This means that the employee can only have one contact person and the conatct person is an emergency contact only to one person.

2. n:1 relationship

- _Departments_ table  is connected with _employees_ table through a _n:1_ relationship which mean that departments can have multiple employees.

- _Departments_ table is connected with _locations_ table through a _n:1_ relationship. This relationship shows that one location can have multiple departments but one department is only found in one location.

- _Projects_ table is connected with _employees_ table through a _n:1_ relationship which was implemented through _projects.projetcId_ as a primary key and _employees.employeeId_ as a foreign key. One employee can have multiple projects.

## Database Queries

### 1. DDL (Data Definition Language)

The following instructions were written in the scope of creating the structure of the database. Here the CREATE instructions will be listed.
 
First the database was created using the following query:

```
create database my_company;
```

Next step will be to create the tables for the database, namely: employees, project, departments, locations and contac_person:

```
create table employees( 
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
```
```
create table project(
projectId int not null auto_increment,
projectName varchar(25) not null,
deadlineDate date,
primary key (projectId),
employeeId int,
foreign key (employeeId) references employees (employeeId)
);
```
```
create table departments(
departmentId int not null auto_increment,
departmentName varchar(25),
primary key(departmentId),
employeeId int,
foreign key (employeeId) references employees (employeeId)
);
```
```
create table locations(
locationId int not null auto_increment,
city varchar(25),
country varchar(25),
postalCode int,
primary key(locationId)
);
```
```
create table contact_person(
contactPersonId int not null auto_increment,
firstName varchar(25),
lastName varchar(25),
phoneNumber int(10),
primary key(contactPersonId),
employeeId int,
foreign key(employeeId) references employees (employeeId)
);
```

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
- delete unnecessary columns: <code>ALTER TABLE projects CROP column deadlineDate;</code>
- delete the info in the supervisers table: <code>DELETE FROM supervisers;</code>  
- deleted some entries as I inserted the data twice: <code>delete from employees where employeeId="11";</code>
- delete FK as the connection did not work: <code>ALTER TABLE departments DROP FOREIGN KEY departments_ibfk_1;</code>

### 2. DML (Data Manipulation Language)

In order to be able to use the database I populated the tables with various data necessary in order to perform queries and manipulate the data.
In the testing process, this necessary data is identified in the Test Design phase and created in the Test Implementation phase.

Below you can find all the insert instructions that were created in the scope of this project:

- insert made for certain columns:<br>
```
INSERT INTO locations
(city, country, postalCode) values ("New York","United States","10001"),
("London","United Kingdom","12778"),
("Sydney","Australia","2000"),
("Tokyo","Japan","1000001"),
("Toronto","Canada","12345");
```
- insert into all the columns-one row only:<br>
```
INSERT INTO employees values
("8","Michael","Johnson","michael.j@yahoo.com","1988-09-23","36","789 San Francisco Road, Austin, TX","345678912","101000");
```

- insert into certain columns-one row only:<br>
```
INSERT INTO departments (departmentId, departmentName) values ("1","New York");
```

- insert into all the columns-multiple rows:<br>
```
INSERT INTO employees values
("3","Jane","Smith","jane.smith@outlook.com","1985-03-22","39","456 Oak Ave, City, ST","234568901",	"75.000"),
("4","Michael","Johnson","michael.j@yahoo.com","1978-06-10","46","789 Pine Dr, City, ST","345678912","80.000"),
("5","Emily","Davis","emily.davis@gmail.com","1993-11-05","30","321 Maple Ln, City, ST","457890123"	,"55.000"),
("6","David","Wilson","david.w@example.com","1982-09-30","41","654 Birch Blvd, City, ST","567801234","70.000");
```

- insert data into the projects table multiple rows at the same time:<br>
```
INSERT INTO projects (projectName, startDate, endDate) values
("Project Alpha","2024-01-01","2024-03-31"),
("Project Beta","2024-02-15","2024-04-30"),
("Project Gamma","2024-03-01","2024-06-30"),
("Project Delta","2024-04-10","2024-07-15"),
("Project Epsilon","2024-05-20","2024-08-30");
```
  
  
- insert data into departments table multiple rows at the same time:<br>
```
INSERT INTO departments (departmentId, departmentName) values 
("2","HR"),
("3","Sales"),
("4","Marketing"),
("5","IT");
```

After the insert, in order to prepare the data to be better suited for the testing process, I updated some data in the following way:
  
- update a certain cell:
```
UPDATE employees SET salary = "60000" WHERE employeeId="2";
```

- update a cell since I entered the wrong information to it:
```
UPDATE departments 
SET departmentName = "Accounting" 
WHERE departmentName = "New York";
```

- added values to the foreign key:
```
UPDATE `my_company`.`departments` SET `locationId` = '3' WHERE (`departmentId` = '1');
UPDATE `my_company`.`departments` SET `locationId` = '1' WHERE (`departmentId` = '2');
UPDATE `my_company`.`departments` SET `locationId` = '2' WHERE (`departmentId` = '3');
UPDATE `my_company`.`departments` SET `locationId` = '4' WHERE (`departmentId` = '4');
UPDATE `my_company`.`departments` SET `locationId` = '5' WHERE (`departmentId` = '5');
```

- tied the Customer Success department with an employee:
```
UPDATE departments 
SET employeeId="10"
WHERE departmentId = "8";
```

- after adding a new column in the employee table, populated those cells with new value:
```
UPDATE employees
SET country="United States"
WHERE employeeId = "2";
```
```
UPDATE employees
SET country="United States"
WHERE employeeId = "4";(there were multiple rows entered, but the syntax is the same, so will not show every row)
```

### 3. DQL (Data Query Language)

In order to simulate various scenarios that might happen in real life I created the following queries that would cover multiple potential real-life situations:

- **WHERE** - searched for the people in the employees table whose first name is "Michael"<br>
```
SELECT * FROM employees WHERE firstName = "Michael";
```

- **AND** - select postalcode from the locations table where the country are United States and the city is New York<br>
```
SELECT postalCode FROM locations WHERE country = "United States" and city = "New York";
```

- **OR** - select employeeId, locationId for the rows where the departmane name is either HR or Marketing<br>
```
SELECT employeeId, locationId FROM departments WHERE departmentName = "HR" OR departmentName ="Marketing";
```

- **LIKE** - checking in the departments table if there are names that contain letter "e"<br>
```
SELECT * FROM departments WHERE departmentName LIKE "%e%";
```

#### Joins
_INNER JOIN - shows employeeid, firstname, lastName and departmentName the people who have associated a departments to their name_
```
SELECT employees.employeeId, employees.firstName, employees.lastName, departments.departmentName
FROM employees
INNER JOIN departments ON employees.employeeId=departments.employeeId;
```

_LEFT JOIN -  shows the people from contact person table who have the same lastname as the people from the employee table_
```
SELECT * FROM employees LEFT JOIN contact_person ON employees.lastName=contact_person.lastName;
```

_RIGHT JOIN - show which employee is working on which project_
```
SELECT employeeId, firstName, projectName
FROM employees
RIGHT JOIN projects USING (employeeId);
```

#### Aggregate functions<br>
**AVG** - calculate average age of the employees in the employees table
```
SELECT avg(age) FROM employees;
```

**MIN** - show the lowest salary in the employees table
```
SELECT min(salary) FROM employees;
```


**ORDER BY** - order the employees by their age in acending order
```
SELECT * FROM employees ORDER BY age ASC;
```
**GROUP BY** - counting how many cities are from the same country
```
SELECT count(locationId) AS Number_of_cities_from_the_same_country FROM locations GROUP BY country;
```
**HAVING** - select the employeeId and country columns form employees table, group by country, except the countries with only one employee
```
SELECT COUNT(employeeId), Country 
FROM employees
GROUP BY Country
HAVING COUNT(employeeId) > 1;
```

**LIMIT** - show the first 3 data entry in the departments table
```
SELECT * FROM departments LIMIT 3;
```
 
**LIMIT** - show the first 7 data entry in the employees table
```
SELECT * FROM employees limit 7;
```

#### Subqueries
**subquery** - will only show the salaries which are below the average salary in the employee table and will show also the difference between them in a column called salaryDifference
```
SELECT employeeId, firstName, lastName, salary, 
       (salary - (SELECT AVG(salary) FROM employees)) AS salaryDifference
FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees);
```

**subquery** - Find employees who are working in a department located in New York
```
SELECT employeeId, firstName, lastName
FROM employees
WHERE employeeId IN (
    SELECT employeeId 
    FROM departments
    WHERE locationId = (SELECT locationId FROM locations WHERE city = 'New York'));
```

**subquery**- list the projects that are associated with employees in Australia
```
SELECT projectId, projectName
FROM projects
WHERE employeeId IN (
    SELECT employeeId
    FROM employees
    WHERE country = 'Australia');
```

**subquery** - Get contact persons related to employees working the Alpha and X projects
```
SELECT contactPersonId, firstName, lastName, phoneNumber, relationship
FROM contact_person
WHERE employeeId IN (
    SELECT employeeId 
    FROM projects
    WHERE projectName = 'Project Alpha' or projectName = 'Project X');
```

## Conclusions

In completing this SQL project, I was able to transform my theoretical knowledge of database management into practical skills. I learned how to create efficient database structures, query data across multiple tables, and solve problems that could arise in the real-world. A crucial part of this project was testing—both during the query-building phase and after implementing the database. By using manual testing techniques, I validated the accuracy of the data, ensured proper relationships between tables, and identified areas where optimization was necessary.

Testing played a key role in maintaining data integrity and consistency. By manually verifying each query's output, I was able to catch logical errors early, such as missing joins or incorrect aggregate functions. This hands-on testing experience has reinforced the importance of a thorough, detail-oriented approach to database development, and helped me realize how crucial testing is to the overall software development process.

Going forward, I am excited to continue building on this foundation. With the rise of big data and data-driven decision-making, mastering SQL and incorporating rigorous testing opens the door to exploring more advanced data systems and tools. This project marks the beginning of my journey into database management, and I look forward to using these skills in larger, more complex systems, ensuring both functionality and reliability through robust testing practices.

