SHOW DATABASES;

USE employees;

SHOW tables;
DESCRIBE titles;
-- string: title (PK)
-- numerical values: emp_no (PK)
-- date: from_date (PK), to_date 

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title
FROM titles;
-- There are 7 unique titles

-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
DESCRIBE employees;
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name
LIMIT 10;

-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name, last_name 
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY first_name, last_name
LIMIT 10;

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT DISTINCT last_name 
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name
LIMIT 10;
-- The names returned were Chleq, Lindqvist, and Qiwen.

-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT DISTINCT last_name,
COUNT(*) as count 
FROM employees
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%'
GROUP BY last_name
LIMIT 10;

-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
-- Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT first_name, gender,
COUNT(*)
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name;

-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. 
-- Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
SELECT DISTINCT(
LOWER (
CONCAT (
SUBSTR(first_name, 1, 1), 
SUBSTR(last_name, 1, 4), 
'_', 
SUBSTR(birth_date, 6, 2), 
SUBSTR(birth_date, 3, 2)
)
)
) AS username,
COUNT(*) as count
FROM employees
GROUP BY username
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC;

-- There are duplicate usernames.  There are 13251 duplicated usernames.

-- 9. Bonus Practice

-- a. Determine the historic average salary for each employee. 
-- When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
DESCRIBE salaries;
-- numeric values: emp_no, salary
-- date: from_date, to_date
SELECT * 
FROM salaries
LIMIT 10;

SELECT DISTINCT emp_no,
AVG(salary) as historical_salary
FROM salaries
GROUP BY emp_no
ORDER BY emp_no
LIMIT 10;

-- b. Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.
DESCRIBE dept_emp;
-- numeric value: emp_no
-- strings: dept_no
-- date: from_date, to_date

SELECT dept_no,
COUNT(emp_no) as employee_count
FROM dept_emp
GROUP BY dept_no
ORDER BY dept_no
LIMIT 10;

-- c. Determine how many different salaries each employee has had. This includes both historic and current.
SELECT DISTINCT emp_no,
COUNT(DISTINCT salary) as number_of_unique_pay 
FROM salaries
GROUP BY emp_no
ORDER BY emp_no
LIMIT 10;

-- d. Find the maximum salary for each employee.
SELECT DISTINCT emp_no,
MAX(salary) as max_salary
FROM salaries
GROUP BY emp_no
ORDER BY emp_no
LIMIT 10;

-- e. Find the minimum salary for each employee.
SELECT DISTINCT emp_no,
MIN(salary) as minimum_salary
FROM salaries
GROUP BY emp_no
ORDER BY emp_no
LIMIT 10;

-- f. Find the standard deviation of salaries for each employee.
SELECT DISTINCT emp_no,
stddev(salary) as standard_deviation_salary
FROM salaries
GROUP BY emp_no
ORDER BY emp_no
LIMIT 10;


