Use BikeStores;
/*Assignment 1 Classwork

You need to create a stored procedure that retrieves a list of all customers who have purchased a specific product.
consider below tables Customers, Orders,Order_items and Products
Create a stored procedure,it should return a list of all customers who have purchased the specified product, 
including customer details like CustomerID, CustomerName, and PurchaseDate.
The procedure should take a ProductID as an input parameter.
*/
create procedure GetCustomersByProducts @product_id int
as
begin
select C.customer_id,C.first_name,C.last_name,O.order_date as purchasedate
from sales.customers c 
inner join  sales.orders O on C.customer_id=O.customer_id
inner join sales.order_items OI on O.order_id=OI.order_id
where OI.product_id=@product_id
end
exec GetCustomersByProducts @product_id=69

/* Assignment 2 Classwork

CREATE TABLE Department with the below columns
  ID,Name
populate with test data
 
CREATE TABLE Employee with the below columns
  ID,Name,Gender,DOB,DeptId
populate with test data
 
a) Create a procedure to update the Employee details in the Employee table based on the Employee id.
b) Create a Procedure to get the employee information bypassing the employee gender and department id from the Employee table
c) Create a Procedure to get the Count of Employee based on Gender(input)
*/
CREATE TABLE Department (
    ID INT IDENTITY (1, 1) PRIMARY KEY,
    Name VARCHAR(50)
);

-- Populate with test data
INSERT INTO Department (Name) VALUES ('HR');
INSERT INTO Department (Name) VALUES ('IT');
INSERT INTO Department (Name) VALUES ('Finance');

select *from Department

CREATE TABLE Employee (
    ID INT IDENTITY (1, 1)PRIMARY KEY,
    Name VARCHAR(100),
    Gender CHAR(1),
    DOB DATE,
    DeptId INT,
    FOREIGN KEY (DeptId) REFERENCES Department(ID)
);

-- Populate with test data
INSERT INTO Employee (Name, Gender, DOB, DeptId) 
VALUES ('Ram', 'M', '1990-01-15', 2);
INSERT INTO Employee (Name, Gender, DOB, DeptId) 
VALUES ('Jai Krishna', 'M', '1985-07-22', 1);
INSERT INTO Employee (Name, Gender, DOB, DeptId) 
VALUES ('Srinithya', 'F', '1992-03-30', 3);


select *from Employee
CREATE PROCEDURE UpdateEmployeeDetails
(@EmpID INT,@NewName VARCHAR(100),@NewGender CHAR(1),@NewDOB DATE,@NewDeptId INT)
AS
BEGIN
UPDATE Employee
SET Name = @NewName,
Gender = @NewGender,
DOB = @NewDOB,
DeptId = @NewDeptId
WHERE ID = @EmpID;
END;

EXEC UpdateEmployeeDetails 1, 'Sita Ram', 'M', '1988-06-10', 2;

CREATE PROCEDURE GetEmployeeByGenderAndDept (@Gender CHAR(1),@DeptId INT)
AS
BEGIN
SELECT ID, Name, Gender, DOB, DeptId
FROM Employee
WHERE Gender = @Gender AND DeptId = @DeptId;
END;

EXEC GetEmployeeByGenderAndDept 'F', 3;


CREATE PROCEDURE GetEmployeeCountByGender
@Gender CHAR(1)
AS
BEGIN
SELECT COUNT(*) AS EmployeeCount
FROM Employee
WHERE Gender = @Gender;
END;

EXEC GetEmployeeCountByGender 'M';


/*Assignment 3
Create a user Defined function to calculate the TotalPrice based on productid and Quantity Products Table
*/
CREATE TABLE Products (
    ProductID INT IDENTITY (1, 1)PRIMARY KEY,
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(10, 2),
);

-- Populate with test data
INSERT INTO Products (ProductName, UnitPrice)
VALUES ('Laptop', 20000.00),
       ('Mouse', 2500.00),
       ('Keyboard', 4500.00);

CREATE FUNCTION CalculateTotalPrice
(
    @ProductID INT,
    @Quantity INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @UnitPrice DECIMAL(10, 2);
    DECLARE @TotalPrice DECIMAL(10, 2);

    -- Fetch the UnitPrice from Products table
    SELECT @UnitPrice = UnitPrice
    FROM Products
    WHERE ProductID = @ProductID;

    -- Calculate the TotalPrice
    SET @TotalPrice = @UnitPrice * @Quantity;

    -- Return the TotalPrice
    RETURN @TotalPrice;
END;
-- Call the function with ProductID and Quantity
SELECT dbo.CalculateTotalPrice(1, 5) AS TotalPrice;


/*Assignment 4 
create a function that returns all orders for a specific customer, including details such as OrderID, OrderDate, and the total amount of each order.
*/
CREATE TABLE Customers (
    CustomerID INT Identity(101,1) PRIMARY KEY,
    CustomerName VARCHAR(100)
);
select * from Customers
-- Insert sample data into Customers table
INSERT INTO Customers VALUES ('Nithya');
INSERT INTO Customers VALUES ('Bobby');
INSERT INTO Customers VALUES ('Vinay');

-- Orders Table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert some test data into Orders table
INSERT INTO Orders VALUES (101, '2024-01-10');
INSERT INTO Orders VALUES (102, '2024-02-12');
INSERT INTO Orders VALUES (101, '2024-03-15');

-- Insert some test data into OrderDetails table
INSERT INTO OrderDetails VALUES (1, 1, 2, 500.00);  
INSERT INTO OrderDetails VALUES (1, 2, 1, 150.00);  
INSERT INTO OrderDetails VALUES (2, 1, 1, 500.00);  
INSERT INTO OrderDetails VALUES (3, 3, 3, 200.00);  

select * from OrderDetails
CREATE FUNCTION GetOrdersByCustomer (@CustomerID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        O.OrderID,
        O.OrderDate,
        SUM(OD.Quantity * OD.UnitPrice) AS TotalAmount
    FROM Orders O
    INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
    WHERE O.CustomerID = @CustomerID
    GROUP BY O.OrderID, O.OrderDate
);
-- Get orders for Customer 101
SELECT * FROM dbo.GetOrdersByCustomer(101);

/*ASSIGNMENT 5
create a Multistatement table valued function that calculates the total sales for each product, considering quantity and price.
*/
CREATE FUNCTION MSTVF_GetTotalSalesByProduct()
RETURNS @TotalSalesTable TABLE
(
    ProductID INT,
    TotalSales DECIMAL(15, 2)
)
AS
BEGIN
-- Insert the calculated total sales for each product into the return table
INSERT INTO @TotalSalesTable (ProductID, TotalSales)
SELECT 
ProductID, SUM(Quantity * UnitPrice) AS TotalSales
FROM OrderDetails
GROUP BY ProductID;
RETURN;

END;

-- Call the function to get total sales for each product
SELECT * FROM dbo.MSTVF_GetTotalSalesByProduct();

/*ASSIGNMENT 6 
create a  multi-statement table-valued function that lists all customers along with the total amount they have spent on orders.
*/

CREATE FUNCTION MSTVF_GetTotalSpentByCustomer()
RETURNS @CustomerTotalSpent TABLE
(
    CustomerID INT,
    CustomerName VARCHAR(100),
    TotalAmountSpent DECIMAL(15, 2)
)
AS
BEGIN
    -- Insert the total amount spent by each customer
    INSERT INTO @CustomerTotalSpent (CustomerID, CustomerName, TotalAmountSpent)
    SELECT 
        C.CustomerID,
        C.CustomerName,
        SUM(OD.Quantity * OD.UnitPrice) AS TotalAmountSpent
    FROM Customers C
    INNER JOIN Orders O ON C.CustomerID = O.CustomerID
    INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
    GROUP BY C.CustomerID, C.CustomerName;

    -- Return the table with results
    RETURN;
END;
-- Call the function to get the total amount spent by each customer
SELECT * FROM dbo.MSTVF_GetTotalSpentByCustomer();

