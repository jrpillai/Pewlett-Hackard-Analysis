# Pewlett-Hackard-Analysis: Preparing a Mentorship  Program

## Overview

As Hewlett Packard prepares for the retirement of many senior employees (the "silver tsunami") you've asked me to prepare a report using SQL to help guide the creation of a mentorship program for new employees. In this report, I will determine the number of retiing employees per job title, identify employees who are eligibile to participate in a mentorship program.

## Results

### Method
Using SQL, I was able to join and filter tables to provide a list of the the job titles that are set to retire soon. In addition, I was able to provide a list of employees that are set to retire. See examples of data output below: 

![Retiring Titles](Images/retiring_titles_dataoutput.png)

Similarly. I was able to provide a list of younger employees who are eligible for mentorship.

![Eligible for Mentorship](Images/mentorship_eligibility_dataoutput.png)

### Conclusions
* As you can see from the retiring titles table, employees from a wide set of job titles are set to retire soon. This same wide range can also provide a broad base for of mentors.
* Almost 25% of the Hewlett Packard workforce is set to retire soon (72,458 of 300,024). This is a very high ratio of employees and experience that will be leaving the company, and suggests recruitment needs to intensify
* The eligible for mentorship table provides detailed identifying information about each employee which can be used to recruit them into the mentorship program, building capacity and sharing the experience of outgoing employees.
* More than half of the employees who are retiring are senior employees, who should be specifically targeted to act as mentors given their experience. 


## Summary

_How many roles will need to be filled as the "silver tsunami" begins to make an impact?_

Based on the retiring titles table, 72,458 of 300,024 employees are set to retire soon. This is almost 25% of the company, a massive amount of roles. This indicates a serious need for recruitment and mentorship.

These sums can be calculated using the following queries:

```
--Number of Employees
SELECT COUNT(*) emp_no
FROM employees

--Number of Retiring Employees
SELECT SUM(count) 
FROM retiring_titles
```
_Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?_

As previously noted, more than half of the retiring employees are in senior roles, and the company should leverage this experience and the natural inclination to mentor to maintain the knowledge base of the company. The additional query below breaks down the titles by senior and junior:

```
--Number of Retiring Employees, Senior and Junior
SELECT SUM(Count) 
FROM retiring_titles
GROUP BY title LIKE '%Senior%';
```

I created two additional tables to determine if each department had enough close to retirement employees available to mentor the next generation. The first table shows retiring employees by department; the second shows mentorship eligible employees by department. 







