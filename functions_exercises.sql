SHOW DATABASES;

USE employees;

SHOW tables;

SELECT * FROM employees;

-- 2. Find all current or previous employees with first names 
-- 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
-- 709 rows returned

-- 3. Find all current or previous employees with first names 
-- 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
-- Enter a comment with the number of records returned. Does it match number of rows from Q2?
SELECT * 
FROM employees 
WHERE first_name = 'Irena' 
OR first_name = 'Vidya' 
OR first_name ='Maya';
-- The number of records returned match the number from Q2 only if you use the above syntax when using only OR

-- 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', 
-- using OR, and who is male. Enter a comment with the number of records returned.
SELECT * 
FROM employees 
WHERE (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
AND gender = 'M';
-- Number of records returned = 441

-- Find all current or previous employees whose last name starts with 'E'. 
-- Enter a comment with the number of employees whose last name starts with E.
SELECT *
FROM employees
WHERE last_name LIKE 'E%';
-- There are 7330 employees whose last name starts with E. 

-- 6. Find all current or previous employees whose last name starts or ends with 'E'. 
-- Enter a comment with the number of employees whose last name starts or ends with E. 
-- How many employees have a last name that ends with E, but does not start with E?
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
OR last_name LIKE '%E';
-- There are 30723 employees whose last name starts or ends with E.
SELECT *
FROM employees
WHERE last_name LIKE '%E'
AND first_name NOT LIKE 'E%';
-- There are 23793 employees whose last name ends with an E but does not start with an E.

-- 7. Find all current or previous employees employees whose last name starts and ends with 'E'. 
-- Enter a comment with the number of employees whose last name starts and ends with E. 
-- How many employees' last names end with E, regardless of whether they start with E?
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E';
-- There are 899 employees whos last name starts and ends with E.
SELECT *
FROM employees
WHERE last_name LIKE '%E';
-- 24292 ends with an E but doesn't necessarily start with an E.

-- 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
SELECT *
FROM employees
WHERE hire_date LIKE '199%';
-- 135214 employees was returned

-- 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25';
-- 842 employees was returned

-- 10. Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with the number of employees returned.
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25';
-- 362 employees was returned

-- 11. Find all current or previous employees with a 'q' in their last name. 
-- Enter a comment with the number of records returned.
SELECT *
FROM employees
WHERE last_name LIKE '%q%';
-- 1873 records were returned

-- 12.  Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
SELECT *
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%';
-- 547 employees was returned



-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
Order By first_name;
-- Irena Reutenauer
-- Vidya Awdeh

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name 
-- and then last name. In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
Order By first_name, last_name;
-- Irena Acton
-- Vidya Zweizig

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
Order By last_name, first_name;
-- Irena Acton

-- 5. Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number 
-- and their first and last name, and the last employee number with their first and last name.
SELECT *
FROM employees 
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
ORDER BY emp_no;
-- 899 employees returned
-- First Row = 10021 Ramzi Erde
-- Last Row = 499648 Tadahiro Erde

-- 6. Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
SELECT *
FROM employees 
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
ORDER BY hire_date DESC;
-- 899 employees returned. Newest employee = Teiji Eldridge Oldest employe = Sergi Erde

-- 7. Find all employees hired in the 90s and born on Christmas. 
-- Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, 
-- and the name of the youngest employee who was hired first.
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25'
ORDER BY birth_date DESC, hire_date ASC;
-- 362 employees were returned.  The oldest employee who was hired last was Khun Bernini
-- The youngest employee who was hired first was Douadi Pettis


-- 2. Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT (first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';

-- 3. Convert the names produced in your last query to all uppercase.
SELECT UPPER (CONCAT (first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';

-- 4. Find all employees hired in the 90s and born on Christmas. 
-- Use datediff() function to find how many days they have been working at the company 
-- (Hint: You will also need to use NOW() or CURDATE()),
SELECT DATEDIFF (NOW(), hire_date)
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25';

-- 5. Find the smallest and largest current salary from the salaries table.
SHOW tables;
SELECT MIN(salary), MAX(salary)
FROM salaries
where to_date = '9999-01-01';

-- 6. Use your knowledge of built in SQL functions to generate a username for all of the employees. 
-- A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the 
-- employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. 
SELECT LOWER (CONCAT (SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))) AS username
FROM employees;

