--select * from dbo.Customers

--select * from dbo.Jobs



select c.CompanyName as 'Company', j.JobName as 'Job'

from dbo.Customers c


inner join dbo.Jobs j on c.id = j.id
