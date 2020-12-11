-- Q1. Are there any pay_details records lacking both a local_account_no and iban number?

SELECT *
FROM pay_details
WHERE local_account_no IS NULL AND iban IS NULL

-- Q2.*Get a table of employees first_name, last_name and country, ordered alphabetically first by country and then by last_name (put any NULLs last).

SELECT
first_name,
last_name,
country
FROM employees
ORDER BY country, last_name ASC NULLS LAST




-- Q3.*Find the details of the top ten highest paid employees in the corporation.

SELECT
first_name,
last_name, 
salary
FROM employees
ORDER BY salary DESC NULLS LAST
LIMIT 10


-- Q4.*Find the first_name, last_name and salary of the lowest paid employee in Hungary.
SELECT
first_name,
last_name, 
salary
WHERE country = "Hungary"
FROM employees
ORDER BY salary ASC NULLS LAST
LIMIT 1


-- Q5.*Find all the details of any employees with a ‘yahoo’ email address?

SELECT *
FROM employees
WHERE email LIKE '%yahoo%'


-- Q6.*Provide a breakdown of the numbers of employees enrolled, not enrolled, and with unknown enrollment status in the corporation pension scheme.

SELECT
pension_enrol,
COUNT(id) AS num_employees
FROM employees
GROUP BY pension_enrol







-- Q7.*What is the maximum salary among those employees in the ‘Engineering’ department who work 1.0 full-time equivalent hours (fte_hours)?

SELECT 
MAX(salary) AS max_salary_engineering_1_ftehours
FROM employees
WHERE department = 'Engineering' AND fte_hours = 1



-- Q8.*Get a table of country, number of employees in that country, and the average salary of employees in that country for any countries in which more 
--  than 30 employees are based. Order the table by average salary descending.

SELECT 
country,
COUNT(id) AS num_employees,
AVG(salary) AS average_salary
FROM employees
GROUP BY country
HAVING COUNT(id) > 30
ORDER BY average_salary DESC


-- Q9 Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), salary, and a new column 
--effective_yearly_salary which should contain fte_hours multiplied by salary.


SELECT 
first_name,
last_name,
fte_hours,
salary,
fte_hours * salary AS effective_yearly_salary
FROM employees
ORDER BY effective_yearly_salary

-- Q10 Find the first name and last name of all employees who lack a local_tax_code.

SELECT 
e.first_name,
e.last_name,
P.local_tax_code
FROM employees AS e INNER JOIN pay_details AS p
ON e.id = p.id
WHERE p.local_tax_code IS NULL


--Q11 The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours, 
--where charge_cost depends upon the team to which the employee belongs. Get a table showing expected_profit for each employee.


SELECT 
e.first_name,
e.last_name,
e.salary,
e.fte_hours,
e.team_id,
t.charge_cost,
(48 * 35 * CAST(t.charge_cost AS INT) - e.salary) *  e.fte_hours AS individuals_profit
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id


--Q12 Return a table of those employee first_names shared by more than one employee, together 
--with a count of the number of times each first_name occurs. Omit employees without a stored 
--first_name from the table. Order the table descending by count, and then alphabetically by first_name.

SELECT
first_name,
COUNT(id)
FROM employees
WHERE first_name IS NOT NULL
GROUP BY first_name
HAVING COUNT(id) >= 2
ORDER BY COUNT DESC, first_name

-----EXTENSIONS------------------

-- Q1 Get a list of the id, first_name, last_name, salary and fte_hours of employees in the largest department.
 --Add two extra columns showing the ratio of each employee’s salary to that department’s average salary, 
 --and each employee’s fte_hours to that department’s average fte_hours.

WITH biggest_dept_details(name, avg_salary, avg_fte_hours) AS (
  SELECT 
     department,
     AVG(salary),
     AVG(fte_hours)
  FROM employees
  GROUP BY department
  ORDER BY COUNT(id) DESC NULLS LAST
  LIMIT 1
)
SELECT
  e.id,
  e.first_name,
  e.last_name,
  e.department,
  e.salary,
  e.fte_hours,
  e.salary / bdd.avg_salary AS salary_over_dept_avg,
  e.fte_hours / bdd.avg_fte_hours AS fte_hours_over_dept_avg
FROM employees AS e CROSS JOIN biggest_dept_details AS bdd
WHERE department = bdd.name








