create database EMS;

use EMS;

-- Creating Department Table
CREATE TABLE Department (
	DepartmentID INT PRIMARY KEY,
	DepartmentName VARCHAR(100) NOT NULL
);

-- Creating JobTitle Table
CREATE TABLE JobTitle(
    JobTitleID INT PRIMARY KEY,
    JobTitleName VARCHAR(100) NOT NULL UNIQUE,
);

-- Creating Employee Table (self referencing foreign key)
CREATE TABLE Employee(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Gender VARCHAR(10),
    PhoneNumber VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    HireDate DATE NOT NULL,
    DepartmentID int FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
    JobTitleID int,
    ManagerID int,
    FOREIGN KEY (JobTitleID) REFERENCES JobTitle (JobTitleID),
    FOREIGN KEY (ManagerID) REFERENCES Employee (EmployeeID)
);

-- Creating Attendance Table 
CREATE TABLE Attendance(
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    Date DATE NOT NULL,
    Status VARCHAR(10) CHECK (Status in ('Present', 'Absent', 'Leave')),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
);

-- Creating Salary Table 
CREATE TABLE Salary(
    SalaryID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    BaseSalary DECIMAL(10, 2) NOT NULL,
    Bonus DECIMAL(10, 2) DEFAULT 0.00,
    Deductions DECIMAL(10, 2) DEFAULT 0.00,
    PaymentDate DATE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
);

-- Creating Project Table
CREATE TABLE Project(
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    ProjectManagerID INT,
    FOREIGN KEY (ProjectManagerID) REFERENCES Employee (EmployeeID)
);

-- Creating Project Allocation Table
CREATE TABLE ProjectAllocation(
    AllocationID INT PRIMARY KEY,
    EmployeeID INT,
    ProjectID INT,
    AllocationDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project (ProjectID),
    CONSTRAINT UC_Employee_Project UNIQUE(EmployeeID, ProjectID)
);

