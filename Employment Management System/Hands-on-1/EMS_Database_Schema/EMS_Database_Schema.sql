CREATE TABLE [Department] (
  [DepartmentID] int PRIMARY KEY,
  [DepartmentName] varchar(100)
)
GO

CREATE TABLE [JobTitle] (
  [JobTitleID] int PRIMARY KEY,
  [JobTitleName] varchar(100) UNIQUE
)
GO

CREATE TABLE [Employee] (
  [EmployeeID] int PRIMARY KEY,
  [FirstName] varchar(100),
  [LastName] varchar(100),
  [DateOfBirth] date,
  [Gender] varchar(10),
  [PhoneNumber] varchar(15) UNIQUE,
  [Email] varchar(100) UNIQUE,
  [HireDate] date,
  [DepartmentID] int,
  [JobTitleID] int,
  [ManagerID] int
)
GO

CREATE TABLE [Attendance] (
  [AttendanceID] int PRIMARY KEY,
  [EmployeeID] int,
  [Date] date,
  [Status] varchar(10)
)
GO

CREATE TABLE [Salary] (
  [SalaryID] int PRIMARY KEY,
  [EmployeeID] int,
  [BaseSalary] decimal(10,2),
  [Bonus] decimal(10,2) DEFAULT (0),
  [Deductions] decimal(10,2) DEFAULT (0),
  [PaymentDate] date
)
GO

CREATE TABLE [Project] (
  [ProjectID] int PRIMARY KEY,
  [ProjectName] varchar(100),
  [StartDate] date,
  [EndDate] date,
  [ProjectManagerID] int
)
GO

CREATE TABLE [ProjectAllocation] (
  [AllocationID] int PRIMARY KEY,
  [EmployeeID] int,
  [ProjectID] int,
  [AllocationDate] date
)
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'Present, Absent, Leave',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table',  @level1name = 'Attendance',
@level2type = N'Column', @level2name = 'Status';
GO

ALTER TABLE [Employee] ADD FOREIGN KEY ([DepartmentID]) REFERENCES [Department] ([DepartmentID])
GO

ALTER TABLE [Employee] ADD FOREIGN KEY ([JobTitleID]) REFERENCES [JobTitle] ([JobTitleID])
GO

ALTER TABLE [Employee] ADD FOREIGN KEY ([ManagerID]) REFERENCES [Employee] ([EmployeeID])
GO

ALTER TABLE [Attendance] ADD FOREIGN KEY ([EmployeeID]) REFERENCES [Employee] ([EmployeeID])
GO

ALTER TABLE [Salary] ADD FOREIGN KEY ([EmployeeID]) REFERENCES [Employee] ([EmployeeID])
GO

ALTER TABLE [Project] ADD FOREIGN KEY ([ProjectManagerID]) REFERENCES [Employee] ([EmployeeID])
GO

ALTER TABLE [ProjectAllocation] ADD FOREIGN KEY ([EmployeeID]) REFERENCES [Employee] ([EmployeeID])
GO

ALTER TABLE [ProjectAllocation] ADD FOREIGN KEY ([ProjectID]) REFERENCES [Project] ([ProjectID])
GO
