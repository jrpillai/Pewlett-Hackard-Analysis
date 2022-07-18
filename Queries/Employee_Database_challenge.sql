-- Deliverable 1

-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
-- Retrieve the title, from_date, and to_date columns from the Titles table.
-- Create a new table using the INTO clause.
-- Join both tables on the primary key.
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
-- Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

SELECT em.emp_no, 
	em.first_name, 
	em.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as em
JOIN titles as ti
ON em.emp_no = ti.emp_no
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no;

-- Use Distinct with Order By to remove duplicate rows
-- Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'.
-- Create a Unique Titles table using the INTO clause.
-- Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e., to_date) of the most recent title.
-- Export the Unique Titles table as unique_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
SELECT DISTINCT ON (emp_no) 
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
-- First, retrieve the number of titles from the Unique Titles table.
-- Then, create a Retiring Titles table to hold the required information.
-- Group the table by title, then sort the count column in descending order.
-- Export the Retiring Titles table as retiring_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(*) DESC;

--Deliverable 2

-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
-- Retrieve the from_date and to_date columns from the Department Employee table.
-- Retrieve the title column from the Titles table.
-- Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
-- Create a new table using the INTO clause.
-- Join the Employees and the Department Employee tables on the primary key.
-- Join the Employees and the Titles tables on the primary key.
-- Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
-- Order the table by the employee number.
-- Export the Mentorship Eligibility table as mentorship_eligibilty.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

SELECT DISTINCT ON(em.emp_no)
	em.emp_no,
	em.first_name, 
	em.last_name, 
	em.birth_date,
	de.from_date,
	de.to_date,
	ti.title
-- INTO mentorship_eligibility
FROM employees as em
JOIN dept_emp as de
ON em.emp_no = de.emp_no
JOIN titles as ti
ON de.emp_no = ti.emp_no
WHERE de.to_date = '9999-01-01'
AND em.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY em.emp_no;

--Additional Queries for Readme

--Number of Employees
SELECT COUNT(*) emp_no
FROM employees

--Number of Retiring Employees
SELECT SUM(count) 
FROM retiring_titles

--Number of Retiring Employees, Senior and Junior
SELECT SUM(Count) 
FROM retiring_titles
GROUP BY title LIKE '%Senior%';

-- Get departments for mentorship eligible employees
SELECT me.emp_no,
	me.title,
	de.dept_no,
	dp.dept_name
INTO dept_mentorable
FROM mentorship_eligibility as me
JOIN dept_emp as de
ON me.emp_no = de.emp_no
JOIN departments as dp
ON dp.dept_no = de.dept_no

-- Count Departments for Mentorable Employees
SELECT COUNT(title), dept_name
INTO dept_mentorable_count
FROM dept_mentorable
GROUP BY dept_name
ORDER BY COUNT(*) DESC;

-- Get departments for retiring employees
SELECT ut.emp_no,
	ut.title,
	de.dept_no,
	dp.dept_name
INTO retiring_departments
FROM unique_titles as ut
JOIN dept_emp as de
ON ut.emp_no = de.emp_no
JOIN departments as dp
ON dp.dept_no = de.dept_no

-- Count Departments for Retiring Employees
SELECT COUNT(title), dept_name
FROM retiring_departments
GROUP BY dept_name
ORDER BY COUNT(*) DESC;


-- Copy retiring departments table
CREATE TABLE retiring_departments_count_1 AS 
TABLE retiring_departments_count;

-- Copy dept_mentorable table
CREATE TABLE dept_mentorable_count_1 AS 
TABLE dept_mentorable_count;

-- Rename Columns
ALTER TABLE retiring_departments_count_1 RENAME COLUMN count TO retiring
ALTER TABLE dept_mentorable_count_1 RENAME COLUMN count TO mentorship_eligible

SELECT a.retiring / b.mentorship_eligible as ratio,
a.dept_name,
a.retiring,
b.mentorship_eligible
-- INTO mentorship_ratio
FROM retiring_departments_count_1 as a
JOIN dept_mentorable_count_1 as b
ON a.dept_name = b.dept_name


