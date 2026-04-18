INSERT INTO Department (dep_name, dep_description) VALUES 
('IT', 'Handles software development and system maintenance'),
('HR', 'Manages recruitment and employee relations'),
('Finance', 'Handles salary, billing and company accounts');

INSERT INTO Users (name, email, password, role) VALUES 
('John Doe', 'john@gmail.com', '$2b$10$hashedpassword', 'employee'),
('Sara Smith', 'sara@gmail.com', '$2b$10$hashedpassword', 'employee');

INSERT INTO Employees 
(user_id, employeeId, dob, gender, maritialStatus, department, designation, salary)
VALUES 
(1, 'emp001', '1998-05-12', 'male', 'single', 1, 'Software Developer', 50000.00),
(2, 'emp002', '1997-09-20', 'female', 'married', 2, 'HR Executive', 40000.00);

INSERT INTO leaves VALUES
(NULL,'emp001','Sick Leave','2025-06-06','2025-06-07','Fever','Pending',NOW(),NOW()),
(NULL,'emp002','Casual Leave','2025-06-10','2025-06-12','Personal Work','Approved',NOW(),NOW());

INSERT INTO Salary VALUES
(NULL,'emp001',50000,5000,2000,53000,'2025-06-30',NOW(),NOW()),
(NULL,'emp002',40000,4000,1500,42500,'2025-06-30',NOW(),NOW());