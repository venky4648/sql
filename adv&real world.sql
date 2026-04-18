-- Current leave employees
SELECT e.employeeId, u.name
FROM Employees e
JOIN Users u ON e.user_id = u.user_id
JOIN leaves l ON e.employeeId = l.employeeId
WHERE CURDATE() BETWEEN l.start_date AND l.end_date
AND l.status = 'Approved';

-- Employees without leave
SELECT e.employeeId
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1 FROM leaves l WHERE l.employeeId = e.employeeId
);

-- Highest salary
SELECT u.name, e.salary
FROM Users u
JOIN Employees e ON u.user_id = e.user_id
ORDER BY e.salary DESC LIMIT 1;

-- Department with max employees
SELECT d.dep_name
FROM Department d
JOIN Employees e ON e.department = d.dept_id
GROUP BY d.dep_name
ORDER BY COUNT(*) DESC LIMIT 1;

-- Most recent leave
SELECT e.employeeId, l.leave_type, l.end_date
FROM Employees e
JOIN leaves l ON e.employeeId = l.employeeId
WHERE l.end_date = (
    SELECT MAX(l2.end_date)
    FROM leaves l2
    WHERE l2.employeeId = e.employeeId
);

-- Employees above avg salary
SELECT e.employeeId, u.name
FROM Employees e
JOIN Users u ON e.user_id = u.user_id
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM Employees e2
    WHERE e2.department = e.department
);

-- Monthly expense
SELECT MONTH(pay_date), SUM(net_salary)
FROM Salary
GROUP BY MONTH(pay_date);

-- Employees without salary
SELECT e.employeeId
FROM Employees e
LEFT JOIN Salary s ON e.employeeId = s.employeeId
WHERE s.employeeId IS NULL;

-- Most leaves
SELECT employeeId, COUNT(*) total
FROM leaves
GROUP BY employeeId
ORDER BY total DESC LIMIT 1;

-- Full profile
SELECT e.employeeId, u.name, d.dep_name, s.net_salary, l.status
FROM Employees e
JOIN Users u ON e.user_id = u.user_id
JOIN Department d ON e.department = d.dept_id
LEFT JOIN Salary s ON e.employeeId = s.employeeId
LEFT JOIN leaves l ON e.employeeId = l.employeeId;