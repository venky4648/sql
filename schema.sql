CREATE DATABASE Employee_Managament_system;
USE Employee_Managament_system;

CREATE TABLE Department(
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dep_name VARCHAR(255) NOT NULL,
    dep_description VARCHAR(255) NOT NULL
);

CREATE TABLE Users(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin','employee') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Employees(
    emp_id INT UNIQUE AUTO_INCREMENT,
    user_id INT NOT NULL,
    employeeId VARCHAR(255) PRIMARY KEY,
    dob DATETIME NOT NULL,
    gender ENUM('male','female','other'),
    maritialStatus ENUM('single','married'),
    department INT,
    designation VARCHAR(255),
    salary DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (department) REFERENCES Department(dept_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE leaves (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    employeeId VARCHAR(255) NOT NULL,
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
    employeeId VARCHAR(255) NOT NULL,
    basic_salary DECIMAL(10,2) NOT NULL,
    allowances DECIMAL(10,2) DEFAULT 0,
    deductions DECIMAL(10,2) DEFAULT 0,
    net_salary DECIMAL(10,2),
    pay_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employeeId) REFERENCES Employees(employeeId)
);