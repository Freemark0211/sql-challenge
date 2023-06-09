--Used to drop table if necessary

--DROP TABLE IF EXISTS Salaries;
--DROP TABLE IF EXISTS Dept_Manager;
--DROP TABLE IF EXISTS Dept_Emp;
--DROP TABLE IF EXISTS Employees;
--DROP TABLE IF EXISTS Departments;
--DROP TABLE IF EXISTS Titles;

--NOTE--CSVs should be added in same order as table creation

--Creat Titles Table
CREATE TABLE Titles (
    title_id VARCHAR(40) PRIMARY KEY,
    title VARCHAR(40) NOT NULL
);

--Creat Employees Table
CREATE TABLE Employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(40) NOT NULL,
    birth_date VARCHAR(40) NOT NULL,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    sex VARCHAR(40) NOT NULL,
    hire_date VARCHAR(40) NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES Titles(title_id)
);

--Creat Salaries Table
CREATE TABLE Salaries (
    emp_no INT PRIMARY KEY,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

--Creat Departments Table
CREATE TABLE Departments (
    dept_no VARCHAR(40) PRIMARY KEY,
    dept_name VARCHAR(40) NOT NULL
);

--Creat Dept_Manager Table
CREATE TABLE Dept_Manager (
    dept_no VARCHAR(40) NOT NULL,
    emp_no INT PRIMARY KEY,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

--Creat Dept_Emp Table
CREATE TABLE Dept_Emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(40) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

--List the employee number, last name, first name, sex,
--and salary of each employee
SELECT E.emp_no, E.last_name, E.first_name, E.sex, S.salary
FROM Employees E
LEFT JOIN Salaries S
ON E.emp_no = S.emp_no
;

--List the first name, last name, and hire date
--for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM Employees
WHERE hire_date LIKE '%1986'
;

--List the manager of each department along with their department number, 
--department name, employee number, last name, and first name
SELECT DM.dept_no, D.dept_name, DM.emp_no, E.last_name, E.first_name
FROM Dept_Manager DM
LEFT JOIN Departments D
ON DM.dept_no = D.dept_no
LEFT JOIN Employees E
ON DM.emp_no = E.emp_no
;

--List the department number for each employee along with that employee’s 
--employee number, last name, first name, and department name
SELECT DE.dept_no, DE.emp_no, E.last_name, E.first_name, D.dept_name
FROM Dept_Emp DE
LEFT JOIN Employees E
ON DE.emp_no = E. emp_no
LEFT JOIN Departments D 
ON DE.dept_no = D.dept_no
;
--List first name, last name, and sex of each employee whose first name
--is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
;

--List each employee in the Sales department, including their 
--employee number, last name, and first name
SELECT emp_no, last_name, first_name
FROM Employees 
WHERE emp_no IN
	(
	 SELECT emp_no
	 FROM Dept_emp
	 WHERE dept_no IN
		(
		 SELECT dept_no
		 FROM Departments
		 WHERE dept_name = 'Sales'
		)
	)
;

--List each employee in the Sales and Development departments, including 
--their employee number,last name, first name, and department name
SELECT E.emp_no, E.last_name, E.first_name, D.dept_name
FROM Employees E
LEFT JOIN Dept_Emp DE
ON E.emp_no = DE.emp_no
LEFT JOIN Departments D
ON DE.dept_no = D.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
;

--List the frequency counts, in descending order, of all the 
--employee last names (that is, how many employees share each last name)
SELECT last_name,
	COUNT (last_name)
FROM Employees	
GROUP BY
	last_name
ORDER BY count DESC
;


