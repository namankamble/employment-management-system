-- Select Database
use EMS;

select * from Employee;
select * from Department;
select * from Attendance;
select * from JobTitle;
select * from Project;
select * from Attendance;
select * from ProjectAllocation;



-- Q11:- Find the total number of employees in each department.
select 
	D.DepartmentName, 
	count(*) as 'total number of employees' 
from 
	Employee E
inner join 
	Department D
on
	E.DepartmentID = D.DepartmentID
group by 
	DepartmentName;



-- Q12:- Calculate the average base salary for each department.
SELECT 
    D.DepartmentName, 
    AVG(BaseSalary) AS AverageBaseSalary
FROM 
    Salary S
JOIN 
    Employee E 
ON 
    S.EmployeeID = E.EmployeeID
JOIN 
    Department D 
ON 
    E.DepartmentID = D.DepartmentID
GROUP BY 
    D.DepartmentName
ORDER BY 
    AverageBaseSalary DESC;



-- Q13:- List the total bonus given to all employees so far.
select 
	count(E.EmployeeID) as 'Employees' , 
	sum(S.Bonus) as 'Total bonus' 
from 
	Employee E
inner join 
	Salary S
on 
	S.EmployeeID = E.EmployeeID;


-- Q14:- Retrieve the names of employees who are project managers.
select 
	CONCAT( E.FirstName,' ',E.LastName ) as 'Names of Employees who are project managers' 
from 
	Employee E
inner join 
	Project P
on 
	E.EmployeeID = P.ProjectManagerID



-- Q15:- Find departments that have more than 5 employees
select 
	D.DepartmentName, 
	count(E.EmployeeID) as TotalEmployees 
from 
	Department D
inner join 
	Employee E
on 
	E.DepartmentID = D.DepartmentID 
group by 
	D.DepartmentName
HAVING 
	COUNT(E.EmployeeID) > 5;


-- Q16:- Get the names of employees who are allocated to more than 2 projects.
select 
	FirstName, 
	LastName, 
	count(PA.ProjectID) as ProjectCount 
from 
	Employee E
inner join 
	ProjectAllocation PA
on 
	E.EmployeeID = PA.EmployeeID
group by 
	FirstName, LastName
HAVING 
	COUNT(PA.ProjectID) > 2;


-- Q17:- List all employees with their department, job title, and project names.
SELECT 
	E.FirstName, 
	E.LastName, 
	D.DepartmentName, 
	JT.JobTitleName, 
	P.ProjectName
FROM 
	Employee E
inner join 
	Department D 
ON 
	E.DepartmentID = D.DepartmentID
inner join 
	JobTitle JT 
ON 
	E.JobTitleID = JT.JobTitleID
LEFT JOIN 
	ProjectAllocation PA 
ON 
	E.EmployeeID = PA.EmployeeID
LEFT join 
	Project P 
ON 
	PA.ProjectID = P.ProjectID;


-- Q18:- Retrieve employees who have been allocated to projects managed by their direct manager
SELECT 
    E.FirstName AS EmployeeFirstName, 
    E.LastName AS EmployeeLastName, 
    M.FirstName AS ManagerFirstName, 
    M.LastName AS ManagerLastName, 
    P.ProjectName
FROM 
    Project P
JOIN 
    ProjectAllocation PA 
ON 
    P.ProjectID = PA.ProjectID
JOIN 
    Employee E 
ON 
    PA.EmployeeID = E.EmployeeID
JOIN 
    Employee M 
ON 
    P.ProjectManagerID = M.EmployeeID
WHERE 
    E.ManagerID = P.ProjectManagerID;



-- Q19:- Find employees who have taken leave more than 3 times in the last month.

SELECT 
    E.FirstName, 
    E.LastName, 
    COUNT(A.AttendanceID) AS 'Leave Count'
FROM 
    Employee E
JOIN 
    Attendance A 
ON 
    E.EmployeeID = A.EmployeeID
WHERE 
    A.Status = 'Leave'
    AND A.Date >= DATEADD(MONTH, -1, GETDATE())
    AND A.Date < GETDATE()
GROUP BY 
    E.EmployeeID, E.FirstName, E.LastName
HAVING 
    COUNT(A.AttendanceID) > 3;

-- Q20:- Rank employees based on their total salary (base + bonus - deductions) within each department.
SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    D.DepartmentName,
    S.BaseSalary,
    S.Bonus,
    S.Deductions,
    (S.BaseSalary + ISNULL(S.Bonus, 0) - ISNULL(S.Deductions, 0)) AS TotalSalary,
    RANK() OVER (PARTITION BY E.DepartmentID ORDER BY (S.BaseSalary + ISNULL(S.Bonus, 0) - ISNULL(S.Deductions, 0)) DESC) AS SalaryRank
FROM 
    Employee E
JOIN 
    Department D ON E.DepartmentID = D.DepartmentID
JOIN 
    Salary S ON E.EmployeeID = S.EmployeeID
ORDER BY 
    D.DepartmentName, SalaryRank;