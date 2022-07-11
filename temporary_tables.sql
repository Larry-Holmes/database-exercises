SHOW DATABASES;

USE leavitt_1863;

-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains 
-- first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. 
-- If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.


CREATE TEMPORARY TABLE employees_with_departments AS
	SELECT first_name, last_name, dept_name
	FROM employees.employees
	JOIN employees.dept_emp USING (emp_no)
	JOIN employees.departments USING (dept_no)
	where to_date > curdate();
;

SELECT * FROM employees_with_departments LIMIT 25;

-- a. Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

ALTER TABLE employees_with_departments ADD full_name VARCHAR(50);

SELECT * FROM employees_with_departments LIMIT 25;

-- b.  Update the table so that full name column contains the correct data

UPDATE  employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

-- c. Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- d. What is another way you could have ended up with this same table
-- During the initial creation of the table I could have CONCAT the first name and last name fields from the start
-- instead of pulling them separately

-- 2. Create a temporary table based on the payment table from the sakila database.

CREATE TEMPORARY TABLE payment_copy (
SELECT * FROM sakila.payment);

SELECT * FROM payment_copy;
DESCRIBE payment_copy;

DROP TEMPORARY TABLE payment_copy;
-- a. Write the SQL necessary to transform the amount column such that it is stored as an integer 
-- representing the number of cents of the payment. For example, 1.99 should become 199.

UPDATE payment_copy SET amount = FLOOR(amount);

-- 3. Find out how the current average pay in each department compares to the overall current pay 
-- for everyone at the company.  In order to make the comparison easier, you should use the Z-score for salaries. 
-- In terms of salary, what is the best department right now to work for? The worst?

SELECT avg(salary), std(salary) from employees.salaries where to_date > now();

CREATE TEMPORARY TABLE copy_avg as (
	SELECT avg(salary) as avg_salary, std(salary) as std_salary
    FROM employees.salaries
    WHERE to_date > now()
    )
;

SELECT * from copy_avg;

DROP TEMPORARY TABLE copy_avg;


CREATE TEMPORARY TABLE pay_departments  as (
SELECT dept_name, avg(salary)
FROM employees.salaries
JOIN employees.dept_emp
USING (emp_no)
JOIN employees.departments
USING (dept_no)
WHERE employees.salaries.to_date > NOW()
AND employees.dept_emp.to_date > NOW()
GROUP BY dept_name
); 

SELECT * FROM pay_departments;

SELECT salary,
	(salary - (SELECT AVG(salary) FROM pay_departments))
    /
    (SELECT stddev(salary) FROM pay_departments) AS zscore
FROM pay_departments;

-- I keep recieving an Error Code: 1137. Can't reopen table: 'pay_departments' despite re creating the temporary table.