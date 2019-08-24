
-- query script for SQL challenge UC Davis bootcamp by G Bigham 8.12.19

--list of employee number, last name, first name, gender, and salary
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees e join salaries s on
  e.emp_no = s.emp_no;

--list of employees hired in 1986
select first_name, last_name, hire_date 
from employees 
where hire_date in (date '1985-01-01', date '1985-12-31')

--list of managers with dept no, dept name, emp no, first name
--last name, start, and end dates
select d.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name, dm.from_date, dm.to_date
from dept_manager dm join departments d 
    on dm.dept_no = d.dept_no
	join employees e 
	on e.emp_no = dm.emp_no;

--list of employees with department
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e join dept_emp de
  on e.emp_no = de.emp_no
  join departments d
  on de.dept_no = d.dept_no;

--list employees with first name Hercules and begins with "B"
select * from employees
where first_name = 'Hercules' and last_name = 'B%'

--list of employees in Sales with emp no, last name, 
-- first name, and dept name
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e join dept_emp de
  on e.emp_no = de.emp_no
  join departments d
  on de.dept_no = d.dept_no
where d.dept_name = 'Sales';

--list of employees in Sales and Development with emp no, last name, 
-- first name, and dept name
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e join dept_emp de
  on e.emp_no = de.emp_no
  join departments d
  on de.dept_no = d.dept_no
where d.dept_name = 'Sales' or d.dept_name = 'Development';

-- list of last name frequency in descending order
select last_name, count(emp_no) as number_of_same_name
from employees
group by last_name
order by number_of_same_name DESC;

