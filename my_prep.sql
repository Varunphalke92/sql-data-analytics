create database My_Practice;
use My_Practice;

CREATE TABLE employees (
  emp_id      INT PRIMARY KEY,
  name        VARCHAR(100),
  dept        VARCHAR(50),
  salary      DECIMAL(10,2),
  hire_date   DATE,
  manager_id  INT REFERENCES employees(emp_id)
);

INSERT INTO employees VALUES
(1,'Aarav Shah','Engineering',92000,'2016-03-15',NULL),
(2,'Priya Nair','Engineering',78000,'2019-07-01',1),
(3,'Rohan Mehta','Engineering',45000,'2022-11-10',1),
(4,'Sneha Kulkarni','HR',55000,'2017-05-20',NULL),
(5,'Karan Joshi','HR',38000,'2023-01-15',4),
(6,'Meera Iyer','Marketing',67000,'2018-08-08',NULL),
(7,'Vikram Rao','Marketing',82000,'2015-02-28',6),
(8,'Anita Desai','Marketing',41000,'2021-04-05',6),
(9,'Suresh Pillai','Engineering',95000,'2014-09-12',1),
(10,'Divya Menon','HR',61000,'2020-06-30',4);

select * from employees;

-- Label each employee's salary as "Low" (< 40k), "Mid" (40k–80k), 
-- or "High" (> 80k) using a CASE expression. Show emp_id, name, salary, and the label.
 select *,
 case
 when salary<40000 then "Low"
 when salary between 40000 and 80000 then "Mid"
 else "High"
 end as label
from employees;

 
-- Count how many employees fall in each salary band (Low / Mid / High) per department. Output: dept, salary_band, count. 
 create View TT as
 select *,
 case
 when salary<40000 then "Low"
 when salary between 40000 and 80000 then "Mid"
 else "High"
 end as label
from employees;

(select label, count(emp_id) as Count from TT group by label);


-- Assign a bonus rate with CASE: 15% for employees hired before 2018, 10% for 2018–2021,
-- and 5% for after 2021. Return name, salary, bonus_rate, and computed bonus_amount.
select * from employees;
select *,
case
when hire_date<"2018-01-01" then "15%"
when hire_date between "2018-01-01" and "2021-12-31" then "10%"
else "5%"
end as Bonus
from employees;


-- List departments where the average salary exceeds 60,000. Use HAVING.
select dept,avg(salary) as avg_sal 
from employees 
group by dept 
having avg_sal>60000;

select * from employees;

-- Find all employees whose salary is above the company-wide average salary
select * from employees 
where salary>(
select avg(salary) 
from employees);

-- Find the employee(s) with the highest salary in each department using a correlated subquery (without window functions)
select * from employees where salary=(
select max(salary) from employees 
);

-- Add a row number to each employee ordered by salary descending. Use ROW_NUMBER().
select *,
row_number() over( order by salary desc) as rownumber
from employees;

-- Rank employees within each department by salary (highest first). Use RANK() so ties get the same rank.
select *,
rank() over (partition by dept order by salary asc) as salary_rank from employees;

-- For each employee, show their salary and the average salary of their department in the same row using AVG() as a window function.
select emp_id,name,dept,salary,
avg(salary) over(partition by dept ) as avg_salary_dept from employees;