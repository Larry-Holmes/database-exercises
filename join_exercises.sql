-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT *
FROM users;

SELECT *
FROM roles;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.
SELECT *
FROM users
JOIN roles
ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles
ON users.role_id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles
ON users.role_id = roles.id;
-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query
SELECT roles.name role_type,
COUNT(users.role_id) as num_users
FROM users
RIGHT JOIN roles
ON users.role_id = roles.id
GROUP BY roles.name
ORDER BY roles.name;

-- EMPLOYEES DATABASE

-- 1. Use the employees database.
USE employees;

SHOW tables;

DESCRIBE departments;
DESCRIBE dept_manager;
DESCRIBE dept_emp;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;
-- 2. Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.

-- Tables: departments, dept_manager
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM employees;

SELECT dept_name, CONCAT(first_name, ' ', last_name)
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date like '9999-01-01'
GROUP BY dept_name, CONCAT(first_name, ' ', last_name)
ORDER BY dept_name;

-- 3. Find the name of all departments currently managed by women.
SELECT dept_name, CONCAT(first_name, ' ', last_name)
FROM departments
JOIN titles
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date like '9999-01-01'
AND gender like '%F%'
GROUP BY dept_name, CONCAT(first_name, ' ', last_name)
ORDER BY dept_name;

-- 4. Find the current titles of employees currently working in the Customer Service department.
DESCRIBE dept_emp;
DESCRIBE employees;
DESCRIBE departments;
DESCRIBE titles;
SELECT dept_name from departments;

SELECT DISTINCT title, COUNT(dept_emp.emp_no)
FROM titles
JOIN employees
ON titles.emp_no = employees.emp_no
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE dept_name like '%Customer Service%'
AND dept_emp.to_date like '9999-01-01'
AND titles.to_date like '9999-01-01'
GROUP BY title
ORDER BY title;

-- 5. Find the current salary of all current managers.
SHOW TABLES;
DESCRIBE dept_manager;
DESCRIBE departments;
DESCRIBE employees;
DESCRIBE salaries;

SELECT DISTINCT dept_name, CONCAT(first_name, ' ', last_name), salary
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no
JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE dept_manager.to_date like '9999-01-01'
AND salaries.to_date like '9999-01-01'
GROUP BY dept_name, CONCAT(first_name, ' ', last_name), salary
ORDER BY dept_name;

-- 6. Find the number of current employees in each department.
DESCRIBE dept_emp;
DESCRIBE departments;

SELECT departments.dept_no, dept_name, COUNT(emp_no) as num_employees
FROM departments
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
WHERE to_date like '9999-01-01'
GROUP BY departments.dept_no, dept_name
ORDER BY departments.dept_no; 

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE salaries;

SELECT dept_name, AVG(salary) as average_salary
FROM departments
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
JOIN salaries
ON dept_emp.emp_no = salaries.emp_no
WHERE dept_emp.to_date like '9999-01-01'
AND salaries.to_date like '9999-01-01'
GROUP BY dept_name
ORDER BY AVG(salary) DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name
FROM departments 
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE salaries.to_date like '9999-01-01'
AND dept_name like '%marketing%'
GROUP BY first_name, last_name, salary
ORDER BY salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?
DESCRIBE dept_manager;

SELECT first_name, last_name, salary, dept_name
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no
JOIN dept_manager
ON salaries.emp_no = dept_manager.emp_no
JOIN departments
ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date like '9999-01-01'
GROUP BY first_name, last_name, salary, dept_name
ORDER BY salary DESC
LIMIT 1;

-- 10. Determine the average salary for each department. Use all salary information and round your results
SELECT dept_name, ROUND(AVG(salary)) 
FROM departments
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
JOIN salaries
ON dept_emp.emp_no = salaries.emp_no
GROUP BY dept_name
ORDER BY ROUND(AVG(salary)) DESC;

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.
DESCRIBE employees;
DESCRIBE dept_manager;

SELECT CONCAT(employees.first_name, ' ', employees.last_name) as employee_name, dept_name, CONCAT(e.first_name, ' ', e.last_name) as manager_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees as e
ON dept_manager.emp_no = e.emp_no
WHERE dept_manager.to_date like '9999-01-01'
AND dept_emp.to_date like '9999-01-01'
-- GROUP BY CONCAT(employees.first_name, ' ', employees.last_name), dept_name, CONCAT(e.first_name, ' ', e.last_name)
-- ORDER BY dept_name
;

DESCRIBE salaries;
DESCRIBE dept_emp;
-- 12. Bonus Who is the highest paid employee within each department.
SELECT DISTINCT dept_name, CONCAT(first_name, ' ', last_name) as Employee_Name, salary
FROM departments as d
LEFT JOIN dept_emp as de
ON d.dept_no = de.dept_no
LEFT JOIN salaries as s
ON de.emp_no = s.emp_no
LEFT JOIN employees as e
ON s.emp_no = e.emp_no
WHERE de.to_date like '9999-01-01'
AND s.to_date like '9999-01-01'
GROUP BY dept_name
ORDER BY dept_name, salary DESC
LIMIT 10
;




