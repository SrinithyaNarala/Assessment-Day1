--==========================Assessments Day2=====================
/*7) Create a trigger to updates the Stock (quantity) table whenever new order placed in orders tables*/

use BikeStores
create trigger trgUpdateStockOnNewOrderPlaced
on sales.order_items
after insert
as
begin
	declare @store_id int, @product_id int, @quantity int;
    select	@store_id = o.store_id,
			@product_id = i.product_id,
			@quantity = i.quantity
    from inserted i
    inner join sales.orders o
        on i.order_id = o.order_id;

    update production.stocks
    set quantity = quantity - @quantity
    where store_id = @store_id and product_id = @product_id;
end

select * from production.stocks
select * from sales.order_items

insert into sales.orders(customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
values(23,4,'2024-10-23','2024-10-30','2024-10-25',1,5)


--8) Create a trigger to that prevents deletion of a customer if they have existing orders.
CREATE VIEW vWCustomerDetails
as
select 
    customer_id,
    first_name,
    last_name,
    phone,
    email,
    street,
    city,
    state,
    zip_code
from 
    sales.customers


create trigger trgPreventCustomerDeletion
on vWCustomerDetails
instead of delete
as
begin
		declare @customerID int
        select @customerID = o.customer_id
        from sales.orders o
        where o.customer_id in (select customer_id from deleted)
	if(@customerID is not null)
    begin
        raiserror('cannot delete customer with existing orders.', 16, 1);
        rollback;
    end
    else
    begin
        delete from sales.customers
        where customer_id in (select customer_id from deleted);
    end
end

select * from vWCustomerDetails
select * from sales.orders
delete from vWCustomerDetails
where customer_id = 1212


exec sp_tables 'dbo.Employee'

 
--9) Create Employee,Employee_Audit insert some test data

--	b) Create a Trigger that logs changes to the Employee Table into an Employee_Audit Table
create table Employee_Audit  (    
	ID int identity(1,1),
	empID int,
	audit_action varchar(255),
	audit_date   Date Default GETDATE()
)  

select * from Employee
select * from Employee_Audit

create trigger trgEmployeeInsert
on dbo.Employee
for insert	
as
begin
    insert into Employee_Audit(empID,audit_action,audit_date)
    select ID ,'INSERT',GETDATE() from inserted
end

insert into Employee values('Nithya','F','2002-09-14',3)

create trigger trgEmployeeUpdate
on Employee
after update
as
begin
    insert into Employee_Audit(empID,audit_action,audit_date)
    select ID ,'UPDATE',GETDATE() from inserted
end

update Employee set DeptID = 3 where ID = 3
 
/*10) create Room Table with below columns
RoomID,RoomType,Availability
create Bookins Table with below columns
BookingID,RoomID,CustomerName,CheckInDate,CheckInDate
 
Insert some test data with both  the tables
Ensure both the tables are having Entity relationship
Write a transaction that books a room for a customer, ensuring the room is marked as unavailable.
*/

create table room (
    roomid int primary key not null,
    roomtype varchar(255) not null,
    [availability] varchar(20) check (availability in ('available', 'unavailable')) not null
)

--create Bookins Table with below columns

--BookingID,RoomID,CustomerName,CheckInDate,CheckInDate
 create table bookings (
    bookingid int primary key not null,
    roomid int not null,
    customername varchar(255) not null,
    checkindate date not null,
    checkoutdate date not null,
    foreign key (roomid) references room(roomid) on delete cascade
)
--Insert some test data with both  the tables
insert into room (roomid, roomtype, [availability]) values
(1, 'single', 'available'),
(2, 'double', 'available'),
(3, 'suite', 'available'),
(4, 'deluxe', 'unavailable')

insert into bookings (bookingid, roomid, customername, checkindate, checkoutdate) values
(1, 1, 'Ram', '2024-10-20', '2024-10-24'),
(2, 2, 'Lakshman', '2024-10-23', '2024-10-26')
--Ensure both the tables are having Entity relationship
select * from room
select * from bookings

--Write a transaction that books a room for a customer, ensuring the room is marked as unavailable

begin transaction
if exists (select roomid from room where roomid = 3 and availability = 'available')
begin
	insert into bookings (bookingid, roomid, customername, checkindate, checkoutdate)
    values (4, 3,'Kalyan','2024-10-25','2024-11-05');
	update room
    set availability = 'unavailable'
    where roomid = 3;

	print 'room booked successfully.'
end
else
begin
rollback transaction
print 'Room is unavailable'
end
commit transaction