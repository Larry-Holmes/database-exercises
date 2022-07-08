USE employees;

DESCRIBE employees;
DESCRIBE dept_emp;
-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT emp_no
FROM employees
JOIN dept_emp
USING (emp_no)
WHERE hire_date IN ((SELECT hire_date
						FROM employees
						WHERE emp_no = 101010))
AND to_date > NOW()
;

-- 2. Find all the titles ever held by all current employees with the first name Aamod. 
DESCRIBE titles;
DESCRIBE employees;

SELECT title
FROM titles t
JOIN employees e
USING (emp_no)
JOIN dept_emp de
USING (emp_no)
WHERE first_name IN (SELECT first_name
FROM employees
WHERE first_name like 'Aamod')
AND de.to_date > NOW()
;

/*SELECT first_name
FROM employees
WHERE first_name like 'Aamod';
*/
-- 3.  How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
/*SELECT emp_no
FROM salaries s
WHERE to_date < NOW();
*/

/*SELECT COUNT(e.emp_no)
FROM employees e
JOIN salaries s 
ON e.emp_no = s.emp_no
WHERE e.emp_no IN (SELECT s.emp_no
FROM salaries s
WHERE to_date < NOW())
;
*/

select count(*)
from employees
where emp_no not in (
	select emp_no
    from dept_emp
    where to_date > NOW()
    )
;

-- There are 59900

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
DESCRIBE dept_manager;

SELECT emp_no, CONCAT(first_name, ' ', last_name), gender
FROM employees
WHERE gender like 'F';


SELECT nnm 
FROM  
(SELECT emp_no, CONCAT(first_name, ' ', last_name) as nnm 
FROM employees
WHERE gender like 'F'
) as e
JOIN dept_manager d
ON e.emp_no = d.emp_no
WHERE d.emp_no like e.emp_no
AND d.to_date > NOW()
;

-- The current female department managers are Isamu Legleitner, Karsten Sigstam, Leon DasSarma, and Hilary Kambil

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT emp_no, salary
FROM salaries
WHERE salary >
(SELECT AVG(salary)
FROM salaries) 
AND to_date > NOW()
;

SELECT *
FROM employees
JOIN salaries
USING (emp_no)
WHERE to_date > NOW()
AND salary > (SELECT AVG(salary)
FROM salaries)
;
SELECT AVG(salary)
FROM salaries;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
SELECT STDDEV(salary)
FROM salaries
WHERE to_date > NOW();

SELECT MAX(salary)
FROM salaries
WHERE to_date > NOW();

SELECT COUNT(salary)
FROM salaries
WHERE to_date > NOW();

SELECT COUNT(salary)
FROM salaries
WHERE salary > (
(SELECT MAX(salary) as mxs
FROM salaries
WHERE to_date > NOW()) - 
(SELECT STDDEV(salary) devsal
FROM salaries
WHERE to_date > NOW())
)
AND to_date > NOW()
; 

SELECT (
(
SELECT COUNT(salary)
FROM salaries
WHERE salary > (
(SELECT MAX(salary) as mxs
FROM salaries
WHERE to_date > NOW()) - 
(SELECT STDDEV(salary) devsal
FROM salaries
WHERE to_date > NOW())
)
AND to_date > NOW()
) /
(
SELECT COUNT(salary)
FROM salaries
WHERE to_date > NOW()
)
);

-- 1. Find all the department names that currently have female managers.
SELECT dept_name, nnm 
FROM  
(SELECT emp_no, CONCAT(first_name, ' ', last_name) as nnm 
FROM employees
WHERE gender like 'F'
) as e
JOIN dept_manager d
ON e.emp_no = d.emp_no
JOIN departments
USING (dept_no)
WHERE d.emp_no like e.emp_no
AND d.to_date > NOW()
;

-- 2. Find the first and last name of the employee with the highest salary.
SELECT MAX(salary)
FROM salaries;

SELECT emp_no, salary
FROM salaries
WHERE salary = (
SELECT MAX(salary)
FROM salaries
);

SELECT CONCAT(first_name, ' ', last_name)
FROM employees e
WHERE e.emp_no IN (
SELECT emp_no
FROM salaries
WHERE salary = (
SELECT MAX(salary)
FROM salaries
)
)
;

-- 3. Find the department name that the employee with the highest salary works in.

SELECT dept_name, CONCAT(first_name, ' ', last_name)
FROM employees e
JOIN dept_emp d
ON e.emp_no = d.emp_no
JOIN departments
USING (dept_no)
WHERE e.emp_no IN (
SELECT emp_no
FROM salaries
WHERE salary = (
SELECT MAX(salary)
FROM salaries
)
)
;