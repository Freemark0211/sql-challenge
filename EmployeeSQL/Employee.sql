

DROP TABLE IF EXISTS Salaries;
DROP TABLE IF EXISTS Dept_Manager;
DROP TABLE IF EXISTS Dept_Emp;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Titles;


CREATE TABLE Titles (
    title_id VARCHAR(40) PRIMARY KEY,
    title VARCHAR(40) NOT NULL
);

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

CREATE TABLE Salaries (
    emp_no INT PRIMARY KEY,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

CREATE TABLE Departments (
    dept_no VARCHAR(40) PRIMARY KEY,
    dept_name VARCHAR(40) NOT NULL
);

CREATE TABLE Dept_Manager (
    dept_no VARCHAR(40) NOT NULL,
    emp_no INT PRIMARY KEY,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

CREATE TABLE Dept_Emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(40) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

SELECT E.emp_no, E.last_name, E.first_name, E.sex, S.salary
FROM Employees E
LEFT JOIN Salaries S
ON E.emp_no = S.emp_no
;
