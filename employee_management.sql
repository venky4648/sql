create database Employee_Managament_system;
use Employee_Managament_system;
show tables ;

-- show the tables data 
select * from Users;
select * from Department;
select * from leaves;
select * from Salary;
select * from Employees;


-- delete tables 
-- drop table Department;
-- drop table Employees;
-- drop table leaves;
-- drop table Users;
-- drop table Salary;

create table Department(dept_id INT primary key auto_increment,
dep_name varchar(255) NOT NULL,
dep_description varchar(255) NOT NULL);

CREATE TABLE Users(
user_id int primary key auto_increment,
name varchar(255) not null ,
email varchar(100) not null unique,
password varchar(255) not null,
role  enum ('admin','employee') not null,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

create table Employees(
emp_id int unique auto_increment,
user_id int not null,
employeeId varchar(255) primary key ,
dob datetime not null,
gender enum('male','female','other'),
maritialStatus enum('single','married'),
department int,
designation varchar(255),
salary decimal(10,2),
foreign key (user_id) references Users(user_id),
foreign key (department) references Department(dept_id),

created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);



CREATE TABLE leaves (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,

    employeeId varchar(255) NOT NULL,

    leave_type VARCHAR(50) NOT NULL,

    start_date DATE NOT NULL,
    end_date DATE NOT NULL,

    reason TEXT,

    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (employeeId) REFERENCES Employees(employeeId)
);

CREATE TABLE Salary (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,

	employeeId varchar(255) NOT NULL,


    basic_salary DECIMAL(10,2) NOT NULL,
    allowances DECIMAL(10,2) DEFAULT 0,
    deductions DECIMAL(10,2) DEFAULT 0,

    net_salary DECIMAL(10,2),

    pay_date DATE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (employeeId) REFERENCES Employees(employeeId)
);




INSERT INTO Department (dep_name, dep_description)
VALUES 
('IT', 'Handles software development and system maintenance'),
('HR', 'Manages recruitment and employee relations'),
('Finance', 'Handles salary, billing and company accounts');



INSERT INTO Users (name, email, password, role)
VALUES 

('John Doe', 'john@gmail.com', '$2b$10$hashedpassword', 'employee'),
('Sara Smith', 'sara@gmail.com', '$2b$10$hashedpassword', 'employee');

INSERT INTO Employees 
(user_id ,employeeId,dob, gender, maritialStatus, department, designation, salary)
VALUES 
(1, "emp001", '1998-05-12', 'male', 'single', 1, 'Software Developer', 50000.00),
(2, "emp002", '1997-09-20', 'female', 'married', 2, 'HR Executive', 40000.00);

select * from Employees;

-- delete the data in the table
delete  from  Employees
where employeeId is null;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM Employees
WHERE employeeId IS NULL;

SET SQL_SAFE_UPDATES = 1;


-- delete the duplicates in the table 
DELETE e1
FROM Employees e1
JOIN Employees e2
ON e1.employeeId = e2.employeeId
AND e1.emp_id > e2.emp_id;

INSERT INTO leaves (
    employeeId,
    leave_type,
    start_date,
    end_date,
    reason,
    status
)
VALUES 
('emp001', 'Sick Leave', '2025-06-06', '2025-06-07', 'Fever', 'Pending'),
('emp002', 'Casual Leave', '2025-06-10', '2025-06-12', 'Personal Work', 'Approved');




INSERT INTO Salary (
    employeeId,
    basic_salary,
    allowances,
    deductions,
    net_salary,
    pay_date
)
VALUES
('emp001', 50000, 5000, 2000, 53000, '2025-06-30'),
('emp002', 40000, 4000, 1500, 42500, '2025-06-30');


-- Retrieve all employees along with their department names.
select e.employeeId,d.dep_name from Employees e join Department d on d.dept_id=e.department;

-- Display employee name, email, and role
select name, email, role from Users;


-- Get all employees who belong to the 'IT' department.
select e.employeeId from Employees e join Department d on e.department=d.dept_id 
where d.dep_name='IT';


-- Fetch all leave records for a specific employee (e.g., emp001)
select * from leaves where employeeId='emp001';

-- Find all employees with a salary greater than 40,000.
select employeeId,salary from Employees where salary >40000;


-- Retrieve employee details along with their leave status.
select e.employeeId, l.status from Employees e join leaves l on e.employeeId = l.employeeId;


-- Count the number of employees in each department.
select d.dep_name,count(employeeId) as employee_count from Department d left join  Employees e on  d.dept_id=e.department
group by dep_name;

-- Calculate the total salary paid to all employees.
select sum(salary) as total from Employees ;

-- Find employees who are currently on leave (based on current date).
SELECT e.employeeId, u.name, l.leave_type, l.start_date, l.end_date
FROM Employees e
JOIN leaves l ON e.employeeId = l.employeeId
JOIN Users u ON e.user_id = u.user_id
WHERE CURDATE() BETWEEN l.start_date AND l.end_date And l.status='Approved';


-- List employees who have not taken any leave. 
select e.employeeId from Employees e join leaves l on e.employeeId=l.employeeId
where l.employeeId  is null;

## 🔹 Advanced Queries

-- 11. Find the highest paid employee.
select u.name ,e.salary from Users u join Employees e on u.user_id=e.user_id
order by e.salary DESC
limit 1;

-- 12. Retrieve the second highest salary.
select u.name ,e.salary from Users u join Employees e on u.user_id=e.user_id
order by e.salary DESC
limit 1 offset 1;

select * from Department;
select * from Employees;
-- 13. Identify the department with the highest number of employees.
select dep_name from Department d  join Employees e on e.department = d.dept_id
group by dep_name
order by count(employeeId) desc
limit 1;

-- 14. Get employee details along with their most recent leave record.
SELECT e.employeeId, u.name, l.leave_type, l.start_date, l.end_date
FROM Employees e
JOIN Users u ON e.user_id = u.user_id
JOIN leaves l ON e.employeeId = l.employeeId
WHERE l.end_date = (
    SELECT MAX(l2.end_date)
    FROM leaves l2
    WHERE l2.employeeId = e.employeeId
);
select * from salary;
-- 15. Calculate net salary using (basic_salary + allowances - deductions).

select * from leaves;
-- 16. Find employees who have taken more than 2 leaves.
select employeeId from leaves 
WHERE status ='Approved'
group by employeeId
having count(*)>2;

select *  from salary;
select * from  Employees;
-- 17. List employees whose salary is above the average salary of their department.
select e.employeeId,u.name,u.role from Employees e join Users u on e.user_id=u.user_id
where e.salary > (select avg(e2.salary) from Employees e2 where e2.department=e.department);


-- 18. Calculate the total monthly salary expense.
SELECT MONTH(pay_date) AS month, SUM(net_salary) AS total_expense
FROM Salary
GROUP BY MONTH(pay_date);

-- 19. Retrieve employee details with their role and department name.
select e.* ,u.role,d.dep_name from Employees e join Users u on u.user_id=e.user_id
join Department d on e.department = d.dept_id;

-- 20. Detect duplicate employee records based on employeeId.

select Employees.* from Employees 
group by employeeId
having count(*) >1;


-- ---

-- ## 🔹 Real-World Scenario Queries
select * from leaves;
-- 21. Identify the employee who has taken the most leaves.
select employeeId,count(*) as total  from leaves group by employeeId order by total desc limit 1;


-- 22. Determine which department has the highest salary expense.
select * from salary;
select * from Employees;
select * from  Users;
-- 23. List employees who have not received any salary records.
select employeeId from Employees where employeeId not in (select employeeId from salary);
-- 24. Retrieve employees who joined in the last 30 days.
SELECT *
FROM Employees
WHERE created_at >= CURDATE() - INTERVAL 30 DAY;


-- 25. Calculate leave approval statistics (Approved vs Rejected).
SELECT status, COUNT(*) AS total
FROM leaves
GROUP BY status;

-- ---

## 🔹 Dashboard Queries

-- 26. Get total number of employees.
select distinct count(*) from Employees;

-- 27. Get total number of departments.
select count(*) from Department;
-- 28. Get total number of leaves.
select count(*) from leaves;



-- 29. Get total salary paid.

select sum(salary) from Employees;



-- 30. Build a full employee profile combining Users, Employees, Department, Salary, and Leaves tables.
SELECT e.employeeId, u.name, u.email, d.dep_name,
       s.net_salary, l.leave_type, l.status
FROM Employees e
JOIN Users u ON e.user_id = u.user_id
JOIN Department d ON e.department = d.dept_id
LEFT JOIN Salary s ON e.employeeId = s.employeeId
LEFT JOIN leaves l ON e.employeeId = l.employeeId;