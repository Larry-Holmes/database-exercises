SHOW DATABASES;

USE employees;

SHOW tables;

SHOW CREATE DATABASE employees;

SELECT database();
 
SELECT * FROM employees.departments;
SELECT * FROM employees.dept_emp;
SELECT * FROM employees.dept_manager;
SELECT * FROM employees.employees;
SELECT * FROM employees.salaries;
SELECT * FROM employees.titles;

SELECT * FROM employees;
 
DESCRIBE employees.departments;
DESCRIBE employees.dept_emp;
DESCRIBE employees.dept_manager;
DESCRIBE employees.employees;
-- The different data types found on the employees table are:
-- int, date, varchar, and enum
DESCRIBE employees.salaries;
DESCRIBE employees.titles;

-- 6. Which table(s) do you think contain a numeric type column? 
-- Every table except for the departments table.
-- 7. Which table(s) do you think contain a string type column?
-- Every table except for the salaries table.
-- 8. Which table(s) do you think contain a date type column?
-- Every table except for the department table.
-- 9. What is the relationship between the employees and the departments tables?
-- The dept_emp and dept_manager tables have information from both tables which link them together if need be.
-- 10. Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
SHOW CREATE TABLE dept_manager;

  
