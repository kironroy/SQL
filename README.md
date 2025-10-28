# SQL

## Links

🔗 [SQL Server Management Studio](https://learn.microsoft.com/en-us/ssms/)

## Notes

Log File: Data goes here before going into actual database.

- Log file acts as a backup
- Over time, the file expands
- Needs to be maintained

For development, keep Recovery Model set to simple.

- Makes the application perform better, keep the file size down.

`Ctrl + R` = open a run box

`Ctrl + N` = query window

`Alt + X` = run a script

## Three Concepts

- **Tables**
- **Views**
- **Stored Procedures**

---

- **Tables**: <u>Store information. Tables are where the data lives.</u>

  - Everything else involves:
    - displaying data
    - combining data
    - updating data
    - securing data

- **Views**: Combine information, easier to consume.

- **Stored Procedures**: Access and update information. Much more secure.

## Table Creation

`Right click Tables > New > Table...`

Start with an id, make it an `int`.

Set `id` to **primary key**.

The primary key is how SQL server identify each **individual** row. It is unique, <u>no duplicate values.</u>

Set Identity Specification to Yes,

- Identity Increment: 1 (increments each row by 1).
- Identity Seed: 1 (Starts at number 1).

FirstName: varchar(100): save space, get all employees.

## Relationships

`Jobs table` needs a certain `id` from &#x2192; `Customers table`

For example if _Acme_ company has 3 jobs and the id is 6, there will be 3 jobs in the `Jobs table`.

We duplicated a number, not all the information.

✔️

1. This is called a **one-to-many** relationship. One record in the `customers table` can link to many jobs (1 to more) records in the `jobs table`.

2. Or one company can have multiple locations. `customers table` &#x2192; `address table`.

⚠️ Don't add too many columns. Creates problems.

## Inserting Data into Tables

📝 Note: Ids can get out of order if you make failed attempts at an entry. For example if you leave a field blank when no `Nulls` are allowed, SSM won't let you create a record.

**<u>However</u>**, the record is still created. Don't worry about skipped numbers.

Insert with Query window 1 entry:

```

INSERT INTO dbo.Customers (
    CompanyName,
    PhoneNumber,
    EmailAddress
)
VALUES (
    'XYZ Corp',
    '(512) 121-2121',
    'hr2@xyz.org'
);

```

Insert with Query window multiple entries:

```

INSERT INTO dbo.Customers (CompanyName, PhoneNumber, EmailAddress)
VALUES
  ('ACME Inc.', '215-3224', 'bugz8@acme.org'),
  ('ABZ LLC.', '313-2333', 'abz@yahoo.com');

```

Insert with \*

```

insert into dbo.WorkDone
(EmployeeId, JobId, LocationId, HoursWorked, Description, DatePerformed)

values(8, 1, 2, 7, 'Created front-end in React', '2/22/2025'),
(9, 3, 3, 11, 'Mowed Lawn', '2/22/2024'),
(7, 3, 2, 9, 'Mowed Lawn', '11/2/2023');

-- * lookup, give me EVERY record from the Employees table and every column

select * from dbo.Employees;
select * from dbo.Jobs;
select * from dbo.Locations;

```

## Queries

Select \*

```
-- * displays all columns
-- don't try to rely on *
select *
from dbo.Employees


```

Asking for four columns

```

select FirstName, LastName, PayRate, BillRate
from dbo.Employees

```

Order by

```

select FirstName, LastName, PayRate, BillRate
from dbo.Employees

-- order by, allows sorting data
-- desc: descending -> z to a
-- asc: ascending -> a to z, default

order by LastName asc

```

Where clause

```
select FirstName, LastName, PayRate, BillRate
from dbo.Employees

where PayRate > 200

order by LastName desc, FirstName desc

```

Wild Card %

```


select FirstName, LastName, PayRate, BillRate
from dbo.Employees

-- S and characters after S
where LastName like'S%'

order by LastName desc, FirstName desc

```

Like

```
select FirstName, LastName, PayRate, BillRate, EmailAddress
from dbo.Employees

where EmailAddress like'%.net'

order by LastName desc, FirstName desc

```

Join: Inner, Left, Right

```



-- c is used as an alias for  renaming  Customers table
-- l is used as an alias for renaming Locations table

select c.CompanyName, l.City
from dbo.Customers c

-- c.id = primary key = l.CustomerId

inner join dbo.Locations l on c.id = l.CustomerId

-- inner join: only the records that match
-- left join: all the records from the left table
  -- and all the matching records from the right
-- right join: all the records from the right table
  -- and all the matching records from the left table

```

as

```

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


```

## Advanced Queries 

```
-- grouping data
-- WorkedDone table is linked to the Jobs table by ids

select w.*, c.CompanyName
from dbo.WorkDone w

-- joined Jobs table to the Workdone table
-- inner join mean two tables have to have same entry to match

inner join dbo.Jobs j on w.JobId = j.id
inner join dbo.Customers c on j.CustomerId = c.id

```

| id  | EmployeeId | JobId | LocationId | HoursWorked | Description               | DatePerformed | CreateDate                  | LastUpdated                  | CompanyName          |
|-----|------------|-------|------------|-------------|---------------------------|---------------|-----------------------------|------------------------------|----------------------|
| 1   | 8          | 1     | 2          | 7           | Created front-end in React| 2025-02-22    | 2025-10-14 18:37:10.6866667 | 2025-10-14 18:37:10.6866667  | ACME Inc.            |
| 2   | 9          | 3     | 3          | 5           | Mowed Lawn                | 2024-02-22    | 2025-10-14 18:37:10.6866667 | 2025-10-14 18:37:10.6866667  | Kiron Roy            |
| 3   | 7          | 2     | 2          | 9           | Built first floor         | 2023-11-02    | 2025-10-14 18:37:10.6866667 | 2025-10-14 18:37:10.6866667  | ABZ LLC.             |
| 8   | 10         | 4     | 4          | 1           | Gave Vini flu shot        | 2025-03-12    | 2025-10-14 18:57:06.5833333 | 2025-10-14 18:57:06.5833333  | Vini Gora LLC.       |
| 14  | 11         | 5     | 7          | 5           | Sitar tuning              | 2022-05-06    | 2025-10-15 12:02:02.3666667 | 2025-10-15 12:02:02.3666667  | Chan & Daughters  |

