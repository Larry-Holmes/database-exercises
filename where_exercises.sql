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
-- The number of records returned match the number from Q2 only if you use the above syntax when using only OR.

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
