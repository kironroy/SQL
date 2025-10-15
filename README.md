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

```Ctrl + R``` = open a run box

```Ctrl + N``` = query window

```Alt + X``` = run a script

## Three Concepts 
- **Tables**
- **Views**
- **Stored Procedures**

---

- **Tables**: <u>Store information. Tables are where the data lives.</u>
  - Everything else involves:  
    - displaying data
    - combing data 
    - updating data 
    - securing data

- **Views**: Combine information, easier to consume.

- **Stored Procedures**: Access and update information. Much more secure. 

## Table Creation

```Right click Tables > New > Table...```

Start with an id, make it an ```int```.

Set ```id``` to **primary key**.

The primary key is how SQL server identify each **individual** row. It is unique, <u>no duplicate values.</u>

Set Identity Specification to Yes, 
  
  - Identity Increment: 1 (increments each row by 1).
  - Identity Seed: 1 (Starts at number 1).

  FirstName: varchar(100): save space, get all employees.

## Relationships

```Jobs table``` needs a certain ```id``` from  &#x2192; ```Customers table```

For example if *Acme* company has 3 jobs and there id is 6, there will be 3 jobs in the ```Jobs table```. 

We duplicated a number, not all the information.

✔️ 
1. This is called a **one-to-many** relationship. One record in the ```customers table``` can link to many jobs (0 to more) records in the ```jobs table```. 

2. Or one company can have multiple locations. ```customers table``` &#x2192; ```address table```. 

⚠️ Don't add too many columns. Creates problems. 

## Inserting Data into Tables

📝 Note: Ids can get out of order if you makr failed attempts at an entry. For example if you leave a field blank when no ```Nulls``` are allowed, SSM won't let you create a record.  

**<u>However</u>**, the record is still created.  Don't worry about skipped numbers.  

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

Insert with Query window  multiple entries:
```

INSERT INTO dbo.Customers (CompanyName, PhoneNumber, EmailAddress)
VALUES 
  ('ACME Inc.', '215-3224', 'bugz8@acme.org'),
  ('ABZ LLC.', '313-2333', 'abz@yahoo.com');

```

Insert with *
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