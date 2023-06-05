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
