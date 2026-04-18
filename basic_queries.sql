-- Employees with department
SELECT e.employeeId, d.dep_name
FROM Employees e
JOIN Department d ON d.dept_id = e.department;

-- Users details
SELECT name, email, role FROM Users;

-- Employees in IT
SELECT e.employeeId
FROM Employees e
JOIN Department d ON e.department = d.dept_id
WHERE d.dep_name = 'IT';

-- Leaves of emp001
SELECT * FROM leaves WHERE employeeId = 'emp001';

-- Salary > 40000
SELECT employeeId, salary FROM Employees WHERE salary > 40000;

-- Employee leave status
SELECT e.employeeId, l.status
FROM Employees e
LEFT JOIN leaves l ON e.employeeId = l.employeeId;

-- Count employees per department
SELECT d.dep_name, COUNT(e.employeeId)
FROM Department d
LEFT JOIN Employees e ON d.dept_id = e.department
GROUP BY d.dep_name;

-- Total salary
SELECT SUM(salary) FROM Employees;