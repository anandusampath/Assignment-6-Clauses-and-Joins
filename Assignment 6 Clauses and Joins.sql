-- =====================================================================
-- MySQL Assignment 2 - Querying Data (Solution)
-- Based on the Assignment 1 schema: database "employee" with tables
-- departments, location, employees (with all constraints).
-- =====================================================================
-- PART 0 recreates the Assignment 1 schema and loads the official
-- Employee Data. Run the whole file from top to bottom.
-- =====================================================================


-- =====================================================================
-- PART 0: SETUP (database, tables with constraints, official data)
-- =====================================================================
DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

-- departments: PRIMARY KEY = unique id; NOT NULL + UNIQUE = no null/duplicate names
CREATE TABLE departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- location: AUTO_INCREMENT = ids generated automatically (1, 2, 3...)
CREATE TABLE location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location    VARCHAR(30) NOT NULL UNIQUE
);

-- employees: all the constraints from Assignment 1
CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    gender        ENUM('M','F'),
    age           INT CHECK (age >= 18),
    hire_date     DATE DEFAULT (CURRENT_DATE),
    designation   VARCHAR(100),
    department_id INT,
    location_id   INT,
    salary        DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (location_id)   REFERENCES location(location_id)
);

-- Official Employee Data provided with the assignment
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Software Development'),
(2, 'Marketing'),
(3, 'Data Science'),
(4, 'Human Resources'),
(5, 'Product Management'),
(6, 'Content Creation'),
(7, 'Finance'),
(8, 'Design'),
(9, 'Research and Development'),
(10, 'Customer Support'),
(11, 'Business Development'),
(12, 'IT'),
(13, 'Operations');

INSERT INTO location (location) VALUES
('Chennai'),
('Bangalore'),
('Hyderabad'),
('Pune');

INSERT INTO employees (employee_id, employee_name, gender, age, hire_date, designation, department_id, location_id, salary) VALUES
(5001, 'Vihaan Singh', 'M', 27, '2015-01-20', 'Data Analyst', 3, 4, 60000),
(5002, 'Reyansh Singh', 'M', 31, '2015-03-10', 'Network Engineer', 12, 1, 80000),
(5003, 'Aaradhya Iyer', 'F', 26, '2015-05-20', 'Customer Support Executive', 10, 2, 45000),
(5004, 'Kiara Malhotra', 'F', 29, '2015-07-05', NULL, 8, 3, 70000),
(5005, 'Anvi Chaudhary', 'F', 25, '2015-09-11', 'Business Development Executive', 11, 1, 55000),
(5006, 'Dhruv Shetty', 'M', 28, '2015-11-20', 'UI Developer', 8, 2, 65000),
(5007, 'Anushka Singh', 'F', 32, '2016-01-15', 'Marketing Manager', 2, 3, 90000),
(5008, 'Diya Jha', 'F', 27, '2016-03-05', 'Graphic Designer', 8, 4, 70000),
(5009, 'Kiaan Desai', 'M', 30, '2016-05-20', 'Sales Executive', 11, 3, 55000),
(5010, 'Atharv Yadav', 'M', 29, '2016-07-10', 'Systems Administrator', 12, 4, 80000),
(5011, 'Saanvi Patel', 'F', 28, '2016-09-20', 'Marketing Analyst', 2, 1, 60000),
(5012, 'Myra Verma', 'F', 26, '2016-11-05', 'Operations Manager', 13, 2, 95000),
(5013, 'Arnav Rao', 'M', 33, '2017-01-20', 'Customer Success Manager', 10, 3, 75000),
(5014, 'Vihaan Mohan', 'M', 30, '2017-03-10', 'Supply Chain Analyst', 10, 2, 60000),
(5015, 'Ishaan Kumar', 'M', 27, '2017-05-20', 'Financial Analyst', 7, 1, 85000),
(5016, 'Zoya Khan', 'F', 31, '2017-07-05', 'Legal Counsel', 4, 4, 100000),
(5017, 'Kabir Nair', 'M', 28, '2017-09-11', 'IT Support Specialist', 12, 2, 80000),
(5018, 'Ishan Mishra', 'M', 25, '2017-11-20', 'Research Scientist', 9, 3, 75000),
(5019, 'Ishika Patel', 'F', 29, '2018-01-15', 'Talent Acquisition Specialist', 4, 4, 55000),
(5020, 'Aarav Nair', 'M', 32, '2018-03-05', 'Software Engineer', 1, 1, 90000),
(5021, 'Advik Kapoor', 'M', 26, '2018-05-20', 'Finance Analyst', 7, 3, 85000),
(5022, 'Aadhya Iyengar', 'F', 28, '2018-07-10', 'HR Specialist', 4, 4, 60000),
(5023, 'Anika Paul', 'F', 30, '2018-09-20', 'Public Relations Specialist', 2, 2, 70000),
(5024, 'Aryan Shetty', 'M', 27, '2018-11-05', 'Product Manager', 5, 1, 95000),
(5025, 'Avni Iyengar', 'F', 31, '2019-01-20', 'Data Scientist', 3, 4, 100000),
(5026, 'Vivaan Singh', 'M', 29, '2019-03-10', 'Business Analyst', 3, 2, 75000),
(5027, 'Ananya Paul', 'F', 32, '2019-05-20', 'Content Writer', 6, 3, 60000),
(5028, 'Anaya Kapoor', 'F', 26, '2019-07-05', 'Event Coordinator', 6, 1, 60000),
(5029, 'Arjun Kumar', 'M', 33, '2019-09-11', 'Quality Assurance Analyst', 12, 2, 80000),
(5030, 'Sara Iyer', 'F', 28, '2019-11-20', 'Project Manager', 5, 1, 90000);

-- Quick check that data is loaded
SELECT * FROM employees;


-- =====================================================================
-- PART 1: BASIC QUERIES
-- =====================================================================

-- 1. DISTINCT VALUES
-- DISTINCT removes duplicate rows from the result.
SELECT DISTINCT salary
FROM employees;

-- 2. ALIAS (AS)
-- AS gives a column a temporary, friendlier name in the output.
SELECT employee_name,
       age    AS Employee_Age,
       salary AS Employee_Salary
FROM employees;

-- 3. WHERE CLAUSE & OPERATORS
-- 3a. Salary greater than 50000 AND hired before 2016-01-01
-- AND means both conditions must be true.
SELECT *
FROM employees
WHERE salary > 50000
  AND hire_date < '2016-01-01';

-- 3b. Find the employee whose designation is missing (NULL)
-- NULL can't be compared with "=", so we use IS NULL.
SELECT *
FROM employees
WHERE designation IS NULL;

-- ...and fill it with 'Data Scientist' using UPDATE.
-- (MySQL Workbench "safe mode" blocks UPDATE without a key column,
--  so we turn it off for this session.)
SET SQL_SAFE_UPDATES = 0;

UPDATE employees
SET designation = 'Data Scientist'
WHERE designation IS NULL;

SET SQL_SAFE_UPDATES = 1;

-- Verify the update
SELECT employee_id, employee_name, designation
FROM employees
WHERE designation = 'Data Scientist';


-- =====================================================================
-- PART 2: SORTING AND GROUPING DATA
-- =====================================================================

-- 1. ORDER BY
-- Department ID ascending (smallest first); inside each department,
-- salary descending (highest first).
SELECT *
FROM employees
ORDER BY department_id ASC, salary DESC;

-- 2. LIMIT
-- Filter to 2018 hires, sort by hire date (earliest first), take first 5.
SELECT *
FROM employees
WHERE YEAR(hire_date) = 2018
ORDER BY hire_date ASC
LIMIT 5;

-- 3. AGGREGATE FUNCTIONS
-- 3a. Sum of all salaries in the Finance department
-- JOIN is needed because the department NAME lives in the departments table.
SELECT SUM(e.salary) AS Total_Finance_Salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

-- 3b. Minimum age among all employees
SELECT MIN(age) AS Minimum_Age
FROM employees;

-- 4. GROUP BY
-- 4a. Maximum salary for each location
SELECT l.location,
       MAX(e.salary) AS Max_Salary
FROM employees e
JOIN location l ON e.location_id = l.location_id
GROUP BY l.location;

-- 4b. Average salary for each designation containing the word 'Analyst'
-- LIKE '%Analyst%' means: any text, then "Analyst", then any text.
SELECT designation,
       AVG(salary) AS Average_Salary
FROM employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;

-- 5. HAVING (filters AFTER grouping; WHERE filters BEFORE grouping)
-- 5a. Departments with less than 3 employees
-- (Departments with zero employees don't appear here because they have no
--  rows to group. See the LEFT JOIN query below to include them.)
SELECT d.department_name,
       COUNT(e.employee_id) AS Employee_Count
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) < 3;

-- 5b. Locations with female employees whose average age is below 30
SELECT l.location,
       AVG(e.age) AS Average_Age
FROM employees e
JOIN location l ON e.location_id = l.location_id
WHERE e.gender = 'F'
GROUP BY l.location
HAVING AVG(e.age) < 30;


-- =====================================================================
-- PART 3: JOINS
-- =====================================================================

-- 1. INNER JOIN
-- Only rows that have a match in BOTH tables are returned.
SELECT e.employee_name,
       e.designation,
       d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- 2. LEFT JOIN
-- ALL rows from the left table (departments) are kept, even with no match.
-- COUNT(e.employee_id) counts only real employees, so empty departments show 0.
SELECT d.department_name,
       COUNT(e.employee_id) AS Total_Employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 3. RIGHT JOIN
-- ALL rows from the right table (location) are kept. If no employee is
-- assigned, employee_name is shown as NULL.
SELECT l.location,
       e.employee_name
FROM employees e
RIGHT JOIN location l ON e.location_id = l.location_id;

-- =========================== END OF FILE ==============================
