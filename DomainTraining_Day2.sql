Create database DomainTraining_Day2
use DomainTraining_Day2;
CREATE TABLE Employee
(
Id INT,
Name VARCHAR(50),
Salary INT,
Gender VARCHAR(10),
City VARCHAR(50),
Dept VARCHAR(50)
)

INSERT INTO Employee VALUES (3, 'Pranaya', 4500, 'Male', 'New York', 'IT')
INSERT INTO Employee VALUES (1, 'Anurag', 2500, 'Male', 'London', 'IT')
INSERT INTO Employee VALUES (4, 'Priyanka', 5500, 'Female', 'Tokiyo', 'HR')
INSERT INTO Employee VALUES (5, 'Sambit', 3000, 'Male', 'Toronto', 'IT')
INSERT INTO Employee VALUES (7, 'Preety', 6500, 'Female', 'Mumbai', 'HR')
INSERT INTO Employee VALUES (6, 'Tarun', 4000, 'Male', 'Delhi', 'IT')
INSERT INTO Employee VALUES (2, 'Hina', 500, 'Female', 'Sydney', 'HR')
INSERT INTO Employee VALUES (8, 'John', 6500, 'Male', 'Mumbai', 'HR')
INSERT INTO Employee VALUES (10, 'Pam', 4000, 'Female', 'Delhi', 'IT')
INSERT INTO Employee VALUES (9, 'Sara', 500, 'Female', 'London', 'IT')

select * from Employee---data will be shown as inserted(random Id number)
select * from Employee where Id=8

CREATE INDEX IX_EMPLOYEE_ID 
ON EMPLOYEE (ID ASC)

CREATE CLUSTERED INDEX IX_EMPLOYEE_ID1 
ON EMPLOYEE(ID ASC)

 
CREATE TABLE Employee1
(
Id INT primary key, 
Name VARCHAR(50), 
Salary INT, 
Gender VARCHAR(10), 
City VARCHAR(50), 
Dept VARCHAR(50)
)
INSERT INTO Employee1 VALUES (3, 'Pranaya', 4500, 'Male', 'New York', 'IT')
INSERT INTO Employee1 VALUES (1, 'Anurag', 2500, 'Male', 'London', 'IT')
INSERT INTO Employee1 VALUES (4, 'Priyanka', 5500, 'Female', 'Tokiyo', 'HR')
INSERT INTO Employee1 VALUES (5, 'Sambit', 3000, 'Male', 'Toronto', 'IT')
INSERT INTO Employee1 VALUES (7, 'Preety', 6500, 'Female', 'Mumbai', 'HR')
INSERT INTO Employee1 VALUES (6, 'Tarun', 4000, 'Male', 'Delhi', 'IT')
INSERT INTO Employee1 VALUES (2, 'Hina', 500, 'Female', 'Sydney', 'HR')
INSERT INTO Employee1 VALUES (8, 'John', 6500, 'Male', 'Mumbai', 'HR')
INSERT INTO Employee1 VALUES (10, 'Pam', 4000, 'Female', 'Delhi', 'IT')
INSERT INTO Employee1 VALUES (9, 'Sara', 500, 'Female', 'London', 'IT')

select* from Employee1 --id will be shown in asc order(id)

--============================Types of indexes================================

--as we don't have unique constraint in present db use sales.customers table with unique email column in Bikestores
use BikeStores  
SELECT * FROM sales.customers
--Example for Unique Index
CREATE UNIQUE INDEX idx_unique_email 
ON sales.customers(email)

--Example for Clustered Index
--We can create only one clustered index per table
--if we have primary key in a table automatically it will create clustered index for that table
--suppose when table is not having primary key then only we can create clustered index.while creating clustere
--if we have duplicate values exists it will sort and store the data
use DomainTraining_Day2
CREATE CLUSTERED INDEX IX_EMPLOYEE_ID1
ON EMPLOYEE (ID ASC)
--Non-clustered index
-- we can create upto 999 non clustered index per table
use BikeStores  
CREATE NONCLUSTERED INDEX idx_name 
ON sales.customers (first_name ,last_name) 
/*(or)
CREATE INDEX idx_name1
ON sales.customers(first_name,last_name)
*/

create table Department (
Id int, Name Varchar(100) )
insert into Department values (1, 'HR'), (1, 'Admin') -- accepts duplicates
select * from Department
CREATE CLUSTERED INDEX idx_dept_id 
ON Department (Id)
insert into Department values (2, 'IT'), (3, 'Transport'), (2, 'Information Tech')
insert into Department (Name) values ('Insurance') --accepts null

--=======================Views====================================
CREATE TABLE tblEmployee
(
Id int Primary Key, 
Name nvarchar(30), 
Salary int, 
Gender nvarchar(10), 
DepartmentId int
)
--SQL Script to create tblDepartment table:
CREATE TABLE tblDepartment
(
DeptId int Primary Key, 
DeptName nvarchar(20)
)
--Insert data into tblDepartment table
Insert into tblDepartment values (1, 'IT')
Insert into tblDepartment values (2, 'Payroll')
Insert into tblDepartment values (3, 'HR') 
Insert into tblDepartment values (4, 'Admin')
--Insert data into tblEmployee table 
Insert into tblEmployee values (1, 'John', 1400, 'Male', 3)
Insert into tblEmployee values (2, 'Mike', 3400, 'Male', 2)
Insert into tblEmployee values (3, 'Pam', 6000, 'Female', 1) 
Insert into tblEmployee values (4, 'Todd', 4800, 'Male', 4)
Insert into tblEmployee values (5, 'Sara', 3200, 'Female', 1)
Insert into tblEmployee values (6, 'Ben', 4800, 'Male', 3)
Select Id, Name, Salary, Gender, DeptName
from tblEmployee 
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId

--Now let's create a view, using the JOINS query, we have just written.
Create View vWEmployeesByDepartment
AS
Select Id, Name, Salary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId
select * from vWEmployeesByDepartment
select * from tblEmployee
update vWEmployeesByDepartment set Name = 'Geetha' where Id=3

--below query will give error as the view is not updatable because modification affects multiple base tables
insert into vWEmployeesByDepartment values (7, 'Ron', 9000, 'Male', 'IT')

--View that returns only IT department employees:
Create View vWITDepartment_Employees
as 
Select Id, Name, Salary, Gender, DeptName 
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId 
where tblDepartment.DeptName = 'IT'
select * from vWITDepartment_Employees
--View that returns all columns except Salary column:
Create View vWEmployeesNonConfidentialData
as
Select Id, Name, Gender, DeptName 
from tblEmployee
join tblDepartment 
on tblEmployee.DepartmentId = tblDepartment.DeptId

Create View vWEmployeesCountByDepartment
as
Select DeptName, COUNT (Id) as TotalEmployees
from tblEmployee
Join tblDepartment
on tblEmployee.DepartmentId = tblDepartment. DeptId
Group By DeptName
select * from vWEmployeesCountByDepartment
sp_helptext vWEmployeesCountByDepartment --- displays text of query line by line


--==============================Triggers===========================================

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE
);
CREATE TABLE order_audit (
audit_id INT IDENTITY PRIMARY KEY,
order_id INT,
customer_id INT,
order_date DATE,
audit_date DATETIME DEFAULT GETDATE()
);
ALTER TABLE Order_Audit ADD audit_information varchar(max)
--Example for After or For Trigger with insert
select * from Orders
Select * from order_audit

CREATE TRIGGER trgAfterInsertOrder
ON Orders
AFTER INSERT
AS
BEGIN
DECLARE @auditInfo nvarchar(1000)
SET @auditInfo='Data Inserted'
INSERT INTO order_audit (order_id, customer_id, order_date, audit_information)
SELECT order_id, customer_id, order_date, @auditInfo
FROM inserted
END
insert into orders values (1001, 31, '8-10-2024')
insert into orders values (1002,41, '8-8-2024')
--update orders set customer_id=32 where order_id=1
update orders set customer_id=32 where order_id=1001

--Example for After or For Trigger with update
Create TRIGGER trgAfterUpdateOrder
ON Orders
FOR UPDATE
AS
BEGIN
DECLARE @auditInfo nvarchar(1000)
SET @auditInfo='Data changed'
INSERT INTO order_audit (order_id,customer_id, order_date, audit_information)
SELECT order_id, customer_id, order_date, @auditInfo
FROM inserted
END

UPDATE orders SET customer_id=33, order_date='10-10-2020' 
WHERE order_id=1001
UPDATE Orders SET customer_id=32, order_date='10-10-2024' 
WHERE ORDER_ID=1002

select * from tblEmployee
select * from tblDepartment

--Example for "Instead of" trigger
--let's create view and work on this trigger

CREATE VIEW vwEmployeeDetails
AS
SELECT Id,Name,Gender,DeptName from tblEmployee e
join tblDepartment d
on e.DepartmentId=d.DeptId

select * from vwEmployeeDetails

Insert vwEmployeeDetails values(7,'Tina','Female','HR')

CREATE TRIGGER tr_vwEmployeeDetails_InsteadOfInsert
ON vwEmployeeDetails
INSTEAD OF INSERT
AS
BEGIN
DECLARE @deptId int
SELECT @deptId = DeptId from tblDepartment
Join inserted
ON inserted.DeptName=tblDepartment.DeptName
if(@deptId is null)
BEGIN
Raiserror('Invalid Department Name Statement Terminated', 16,1)
return
END
Insert into tblEmployee (Id, Name, Gender, DepartmentId)
Select Id, Name, Gender, @deptId
FROM inserted
END
INSERT vwEmployeeDetails values (7, 'Tina', 'Female', 'HR')
INSERT vwEmployeeDetails values (8, 'Yash', 'Male', 'IT')
INSERT vwEmployeeDetails values (9, 'Yasheswi', 'Female', 'Banking')-- there is no department as banking

--=========================Transactions==================================
use BikeStores;
BEGIN TRANSACTION
INSERT INTO sales.orders
(customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id) 
VALUES (49, 4, '20170228', '20170301', '20170302',2,6);

INSERT INTO sales.order_items (order_id, item_id, 
product_id, quantity, list_price, discount) 
VALUES (93,6,8,2,269.99,0.07);
IF @@ERROR = 0
BEGIN
COMMIT TRANSACTION
PRINT 'Insertion Successful!...'
END
ELSE
BEGIN
ROLLBACK TRANSACTION
PRINT 'Something went wrong while insertion'
END

select * from sales.order_items


--Transaction DeadLock
CREATE TABLE CUSTOMERS
(customer_id int primary key,
Name varchar(100),
active bit)
CREATE TABLE Torders
(order_id int primary key, 
customer_id int foreign key references Customers (customer_id), 
order_status varchar(100)
)
insert into CUSTOMERS values
(1, 'Pam', 1),
(2, 'Kim',1)

insert into Torders values
(101,1, 'Pending'),
(102,2, 'Pending')

select * from Customers
select * from Torders

/*If we run both transactions at a time then we will get the transaction deadlock
as the transaction is already in run
NOTE: 2 transactions must run in two different tabs separately
--i.e., transaction A in one tab
transaction B in one tab
*/
--Transaction A
BEGIN TRANSACTION
UPDATE CUSTOMERS SET Name='John'
WHERE customer_id=1
WAITFOR DELAY '00:00:05';
UPDATE Torders SET order_status='Processed'
WHERE order_id=101
COMMIT TRANSACTION

--Transaction B
I
BEGIN TRANSACTION
UPDATE Torders SET order_status='Shipped'
WHERE order_id=101
WAITFOR DELAY '00:00:05';
UPDATE CUSTOMERS SET Name='Geetha'
WHERE customer_id=1
COMMIT TRANSACTION