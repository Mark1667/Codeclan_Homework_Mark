--MVP

-- Q1 Find all the employees who work in the ‘Human Resources’ department.

SELECT *
FROM employees
WHERE department = 'Human Resources'


-- Q2 Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.

SELECT
first_name, last_name, country, department
FROM employees
WHERE department = 'Legal'


--Q3 Count the number of employees based in Portugal.

SELECT
COUNT(*) AS employee_count
FROM employees
WHERE country = 'Portugal'



--Q4 Count the number of employees based in either Portugal or Spain.

SELECT
Country,
COUNT(*) AS employee_count
FROM employees
WHERE country = 'Portugal' OR country = 'Spain'
GROUP BY country

--Q5 Count the number of pay_details records lacking a local_account_no

SELECT
COUNT(*) AS missing_accnt
FROM pay_details
WHERE local_account_no IS NULL

--Q6 Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).

SELECT 
first_name, last_name 
FROM employees
ORDER BY last_name NULLS LAST, first_name NULLS LAST

--Q7 How many employees have a first_name beginning with ‘F’?

SELECT
COUNT(id) AS employee_begins_f
FROM employees
WHERE first_name ILIKE 'F%'



--Q8 Count the number of pension enrolled employees not based in either France or Germany.

SELECT 
COUNT(id) AS pension_count_not_France_Germany
FROM employees
WHERE pension_enrol = TRUE AND (country != 'Germany' AND country != 'France')



--Q9 Obtain a count by department of the employees who started work with the corporation in 2003.



SELECT
department,
COUNT(*) total_startcount_2003
FROM employees
WHERE start_date >'2002-12-31' BETWEEN start_date <'2004-01-01' 
GROUP BY department


--Q10 Obtain a table showing department, fte_hours and the number of employees in each department who work each fte_hours pattern.
   -- Order the table alphabetically by department, and then in ascending order of fte_hours.


SELECT
department, fte_hours,
COUNT(*) AS total_num
FROM employees
GROUP BY fte_hours, department
ORDER BY department , fte_hours ASC




--Q11 Obtain a table showing any departments in which there are two or more employees lacking a stored first name. Order the table
   -- in descending order of the number of employees lacking a first name, and then in alphabetical order by department.

SELECT
department,
COUNT(id) AS missing_count
FROM employees
WHERE first_name IS NULL 
GROUP BY department
HAVING COUNT(id) >= 2
ORDER BY missing_count DESC, department ASC



--Q12 Find the proportion of employees in each department who are grade 1


SELECT 
department,
COUNT(*) AS total_dept_count
FROM employees
WHERE grade != 1
GROUP BY department



SELECT
department,
COUNT(*) AS grade1_count
FROM employees
WHERE Grade = 1
GROUP BY department



SELECT
department, 
COUNT(*) IS grade_count/total_dept_count
FROM employees
GROUP BY department;

SELECT *
FROM employees
WHERE grade = 1 
GROUP BY department

-- ANSWER Q12

SELECT 
  department, 
  SUM(CAST(grade = '1' AS INT)) / CAST(COUNT(id) AS REAL) AS prop_grade_1 
FROM employees 
GROUP BY department




