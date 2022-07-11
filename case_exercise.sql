-- 1. Write a query that returns all employees, their department number, their start date, their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.


USE leavitt_1863;

CREATE TEMPORARY TABLE employees_copy AS
SELECT * 
FROM employees.employees
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
;

SELECT * FROM employees_copy LIMIT 25;

SELECT emp_no, CONCAT(first_name, ' ', last_name), dept_no, from_date, to_date,
	CASE 
		WHEN to_date > NOW() THEN 1
        ELSE 0
	END AS is_current_employee
FROM employees_copy;

-- 2. Write a query that returns all employee names (previous and current), and a new column 
-- 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
USE employees;

SELECT CONCAT(first_name, ' ', last_name),
	CASE
		WHEN last_name LIKE 'A%' OR last_name LIKE 'B%' OR last_name LIKE 'C%' OR last_name LIKE 'D%'
        OR last_name LIKE 'E%' OR last_name LIKE 'F%' OR last_name LIKE 'G%' OR last_name LIKE 'H%' THEN 'A-H'
        WHEN last_name LIKE 'I%' OR last_name LIKE 'J%' OR last_name LIKE 'K%' OR last_name LIKE 'L%'
        OR last_name LIKE 'M%' OR last_name LIKE 'N%' OR last_name LIKE 'O%' OR last_name LIKE 'P%'
        OR last_name LIKE 'Q%' THEN 'I-Q'
        ELSE 'R-Z'
	END AS alpha_group
    FROM employees;
    
SELECT
    first_name, 
    last_name, 
    LEFT(last_name, 1) AS first_letter_of_last_name,
    CASE
		WHEN LEFT(last_name, 1) <= 'H' THEN 'A-H'
        WHEN SUBSTR(last_name, 1, 1) <= 'Q' THEN 'I-Q'
        WHEN LEFT(last_name, 1) <= 'Z' THEN 'R-Z'
	END AS alpha_group
FROM employees;

    
    -- 3. How many employees (current or previous) were born in each decade?
    SELECT
		COUNT(CASE 
			WHEN birth_date BETWEEN '1900-01-01' and '1910-01-01' THEN 1 ELSE NULL END) AS '1900s',
		COUNT(CASE
			WHEN birth_date BETWEEN '1910-01-02' and '1920-01-01' Then 2 ELSE NULL END) AS '1910s',
		COUNT(CASE
			WHEN birth_date BETWEEN '1920-01-02' and '1930-01-01' Then 3 ELSE NULL END) AS '1920s',
		COUNT(CASE
			WHEN birth_date BETWEEN '1930-01-02' and '1940-01-01' Then 4 ELSE NULL END) AS '1930s',
		COUNT(CASE
			WHEN birth_date BETWEEN '1940-01-02' and '1950-01-01' Then 5 ELSE NULL END) AS '1940s',
		COUNT(CASE
			WHEN birth_date BETWEEN '1950-01-02' and '1960-01-01' Then 6 ELSE NULL END) AS '1950s',
		COUNT(CASE
			WHEN birth_date BETWEEN '1960-01-02' and '1970-01-01' Then 7 ELSE NULL END) AS '1960s',
		COUNT(CASE
			WHEN birth_date BETWEEN '1970-01-02' and '1980-01-01' Then 8 ELSE NULL END) AS '1970s',
		COUNT(CASE
			WHEN birth_date BETWEEN '1980-01-02' and '1990-01-01' Then 9 ELSE NULL END) AS '1980s',
		COUNT(CASE
			WHEN birth_date BETWEEN '1990-01-02' and '2000-01-01' Then 10 ELSE NULL END) AS '1990s'
	FROM employees;
    
SELECT
	CONCAT(SUBSTR(birth_date, 1, 3), '0') as decade,
    COUNT(*)
FROM employees
GROUP BY decade;

-- 4. What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
    
SELECT
	CASE
		WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
        ELSE dept_name
	END AS dept_group, AVG(salary)
FROM departments
JOIN dept_emp USING (dept_no)
JOIN salaries USING (emp_no)
WHERE salaries.to_date > NOW()
AND dept_emp.to_date > NOW()
GROUP BY dept_group
;