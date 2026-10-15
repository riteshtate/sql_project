-- import a database
-- understand data

-- 1: Display all records from the employees table.
select * from employees;

-- 2: Display only the first name, last name, and gender of all employees.
select first_name,last_name,gender
from employees;

-- 3: Display the first 10 records from the employees table.
select * from employees limit 10;

-- 4: Count the total number of employees.
select count(*)
from employees;

-- 5: Find the number of male and female employees.
select gender,count(emp_no) as count_emp
from employees
group by gender;

-- 6: Display employees hired after January 1, 2000.
select * from employees 
where hire_date = ('2000-01-01') ;

-- 7: Display employees in alphabetical order by first name.
select * 
from employees
order by first_name asc;

-- 8: Find the earliest hire date in the company.
select * 
from employees
order by hire_date asc;

-- 9: Find the latest hire date in the company.
select * 
from employees
order by hire_date desc
limit 1;

-- 10: Find the number of employees hired in each year.
SELECT YEAR(hire_date) AS hire_year,COUNT(emp_no) AS total_employees
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year;


-- bussiness analysis
--  1. Find the total number of employees in each department.
select d.dept_name , count(de.emp_no) as total_employee_each_dept
from dept_emp de inner join departments d on de.dept_no=d.dept_no
group by d.dept_name;

--  2. Find the average salary of employees.
select emp_no,avg(salary) as avg_salary
from salaries
group by emp_no;

--  3. Find the minimum and maximum salary.
SELECT MIN(salary) AS minimum_salary, MAX(salary) AS maximum_salary
FROM salaries;

--  4. Find the total salary paid to employees in each department.
SELECT d.dept_name,SUM(s.salary) AS total_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no
GROUP BY d.dept_name;

--  5. Find the number of male and female employees.
select gender , count(emp_no) as number_of_employee
from employees
group by gender;

--  6. Find departments having more than 50,000 employee assignments.
SELECT
    d.dept_name,
    COUNT(*) AS total_assignments
FROM departments d
JOIN dept_emp de
    ON d.dept_no = de.dept_no
GROUP BY d.dept_name
HAVING COUNT(*) > 50000;

--  7. Find the average salary for each job title.
select t.title,avg(s.salary) as avg_salary
from salaries s join titles t on s.emp_no=t.emp_no
group by t.title;

--  8. Find the top 5 departments with the highest average salary.
select d.dept_name,avg(s.salary) as avg_salary
from dept_emp de join departments d on de.dept_no=d.dept_no
join salaries s on s.emp_no=de.emp_no
group by d.dept_name
order by avg_salary desc
limit 5;



-- advanced
-- 1. Use CASE to classify employees by salary.
select emp_no,salary,
CASE
when salary < 50000 then "low_salary"
when salary < 100000 then "medium_salary"
else "high_salary"
END as Salary_Category
from salaries;

-- 2. Rank employees by salary.
select emp_no,salary,rank() over(order by salary desc) as salary_rank
from salaries;

-- 3. Find the average salary of each department using a CTE.
with avg_salary_dept as 
(select d.dept_name , avg(s.salary) as avg_salary 
from salaries s join dept_emp de on s.emp_no=de.emp_no
join departments d on d.dept_no=de.dept_no
group by d.dept_name) 
select dept_name,avg_salary
from avg_salary_dept;



-- data export to csv

SELECT e.emp_no,e.first_name,e.last_name,e.gender,e.hire_date,d.dept_name,s.salary
FROM employees e JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01'
  AND s.to_date = '9999-01-01'
ORDER BY e.emp_no;