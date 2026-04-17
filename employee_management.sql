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



-- create Department table

create table Department(dept_id INT primary key auto_increment,
dep_name varchar(255) NOT NULL,
dep_description varchar(255) NOT NULL);

-- create Users table

CREATE TABLE Users(
user_id int primary key auto_increment,
name varchar(255) not null ,
email varchar(100) not null unique,
password varchar(255) not null,
role  enum ('admin','employee') not null,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

-- create Employees table

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


-- create leaves table
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

-- create Salary table

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


--insert data into the tables

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



-- delete the data in the table
delete  from  Employees
where employeeId is null;


-- delete the null values in the table
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


--insert data into leaves table and Salary table
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