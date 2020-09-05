CREATE TABLE departments (
    dept_no varchar(4) NOT NULL,
    dept_name varchar(250) NOT NULL,
    PRIMARY KEY (dept_no)
);

CREATE TABLE salaries (
    emp_no int NOT NULL,
    salary int NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
    title_id varchar(5) NOT NULL,
    title varchar(250) NOT NULL,
    PRIMARY KEY (title_id)
);

CREATE TABLE employees (
    emp_no int NOT NULL,
    emp_title_id varchar(5) NOT NULL,
    birth_date date NOT NULL,
    first_name varchar(250) NOT NULL,
    last_name varchar(250) NOT NULL,
    sex char(1) NOT NULL,
    hire_date date NOT NULL,
    PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES salaries(emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

CREATE TABLE dept_manager (
    dept_no varchar(4) NOT NULL,
    emp_no int NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
    emp_no int NOT NULL,
    dept_no varchar(4) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);


--List the following details of each employee: employee number, last name, first name, sex, and salary
CREATE VIEW employee AS
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, s.salary 
FROM employees as emp
JOIN salaries as s
ON emp.emp_no=s.emp_no;

SELECT * FROM employee;

--List first name, last name, and hire date for employees who were hired in 1986.
CREATE VIEW employee_1986 AS
SELECT emp.first_name, emp.last_name, emp.hire_date
FROM employees as emp
WHERE emp.hire_date >= '1986-01-01' AND emp.hire_date <=  '1986-12-31';

SELECT * FROM employee_1986;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
CREATE VIEW manager AS
SELECT dept.dept_no, dept.dept_name, dept_m.emp_no, emp.last_name, emp.first_name
FROM dept_manager as dept_m
JOIN departments as dept
ON dept_m.dept_no = dept.dept_no
join employees as emp
on dept_m.emp_no = emp.emp_no;

SELECT * FROM manager;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
CREATE VIEW department AS
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees as emp
JOIN dept_emp as dept_e
ON emp.emp_no = dept_e.emp_no
JOIN departments as dept
on dept_e.dept_no = dept.dept_no;

SELECT * FROM department;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
CREATE VIEW name_hercules AS
SELECT emp.first_name, emp.last_name, emp.sex
FROM employees as emp
WHERE emp.first_name = 'Hercules' AND emp.last_name LIKE 'B%';

SELECT * FROM name_hercules;

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
CREATE VIEW sales_dept AS
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees as emp
JOIN dept_emp as dept_e
ON emp.emp_no = dept_e.emp_no
JOIN departments as dept
on dept_e.dept_no = dept.dept_no
WHERE dept.dept_name = 'Sales';

SELECT * FROM sales_dept;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
CREATE VIEW sales_development_dept AS
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees as emp
JOIN dept_emp as dept_e
ON emp.emp_no = dept_e.emp_no
JOIN departments as dept
on dept_e.dept_no = dept.dept_no
WHERE dept.dept_name = 'Sales' OR dept.dept_name = 'Development';

SELECT * FROM sales_development_dept;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
CREATE VIEW last_name_frequency AS
SELECT emp.last_name, COUNT(emp.last_name)
FROM employees as emp
GROUP BY emp.last_name
ORDER BY COUNT(emp.last_name) DESC;

SELECT * FROM last_name_frequency;

