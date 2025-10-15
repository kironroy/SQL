

-- inner join: only the records that match 
-- left join: all the records from the left table
  -- and all the matching records from the right
-- right join: all the records from the right table
  -- and all the matching records from the left table

-- Custom column = e.FirstName + ' ' + e.LastName as 'Full Name'
-- Custom column = w.Description as 'Explanation of Work' 

select c.CompanyName
	, j.JobName
	, e.LastName + ', ' + e.FirstName as 'Employee Name'
	, w.Description as 'Explanation of Work'
    , w.HoursWorked
	, l.City + ' ' + l.StreetAddress + ', ' + l.State as 'Location'

from dbo.WorkDone w
inner join dbo.Employees e on w.EmployeeId = e.id
inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Locations l on w.LocationId = l.id
inner join dbo.Customers c on j.CustomerId = c.id
where c.CompanyName = 'ACME Inc.'
order by l.City


select * 
from dbo.Customers