-- Select Database
use EMS;

select * from Employee;
select * from Department;
select * from Attendance;
select * from JobTitle;
select * from Project;
select * from Attendance;
select * from ProjectAllocation;


-- Q1:- Add a new department called "Operation" with DepartmentID = 6.
insert into Department(DepartmentID, DepartmentName)
values (6, 'Operation');


-- Q2:- Add a new job title "Data Engineer" with JobTitleID = 101.
select * from JobTitle
insert into JobTitle (JobTitleID, JobTitleName)
values (101, 'Data Engineer');


-- Q3:- Retrieve the list of all departments.
select * from Department;


-- Q4:- Get the details of employees hired in 2015.
select * from Employee
where 
	year(HireDate) = 2015;


-- Q5:- Find the email and phone numbers of all employees.
select 
	Email, 
	PhoneNumber 
from 
	Employee;


-- Q6:- Update the department name with DepartmentID = 1 to "Human Resource".
update 
	Department 
set 
	DepartmentName = 'Human Resource'
where 
	DepartmentID = 1;


-- Q7:- Change the job title of EmployeeID = 2 to "Senior Software Engineer."
select * from JobTitle;
update 
	JobTitle
set 
	JobTitleName = 'Senior Software Engineer'
where
	JobTitleID = 2;


-- Q8:- Write a query to fetch all employees along with their department names.
SELECT 
    E.FirstName, 
    E.LastName, 
    D.DepartmentName
FROM 
    Employee E
join 
    Department D 
ON 
    E.DepartmentID = D.DepartmentID;


-- Q9:- List all employees with their job titles and manager names.
select 
	CONCAT(M.FirstName,' ', M.LastName) as 'Manager Name',
	CONCAT(E.FirstName,' ', E.LastName) as 'Employee Name',
	J.JobTitleName as 'Job Title'
from 
	Employee E
inner join 
	Employee M
on 
	E.EmployeeID= M.ManagerID
inner join 
	JobTitle J
on 
	J.JobTitleID = E.EmployeeID;



-- Q10:- Retrieve employees who are working on a project named "Alpha."
select 
	FirstName, 
	LastName, 
	P.ProjectName 
from 
	Employee E
inner join 
	ProjectAllocation PA
on 
	PA.EmployeeID = E.EmployeeID
inner join 
	Project P
on 
	P.ProjectID = PA.ProjectID
where 
	ProjectName = 'Project Alpha';
