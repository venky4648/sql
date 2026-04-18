-- Remove NULL employeeId
DELETE FROM Employees WHERE employeeId IS NULL;

-- Remove duplicates
DELETE e1
FROM Employees e1
JOIN Employees e2
ON e1.employeeId = e2.employeeId
AND e1.emp_id > e2.emp_id;