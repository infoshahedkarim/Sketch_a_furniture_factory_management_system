--create database sketch
use sketch

--table 01--wood accuracy table



create table WoodAccuracy
(
w_serialNo int identity(1000001,1) primary key not null,
height decimal(12,4)  not null, --inch
width decimal(12,4)  not null, --inch
lenth decimal(12,4)  not null, --inch
NAO_CFT decimal(12,4) not null
-- (height*width*lenth)/1728
);

INSERT INTO WoodAccuracy
VALUES ('50','40', '60','69.45'),
('40','40', '70','69.45'),
('40','20', '35','16.203')

select * from  WoodAccuracy

drop table WoodAccuracy

--table 02--wood reservation table



create table WoodReservation
(
w_serialNo int not null foreign key references WoodAccuracy(w_serialNo) ,
wreserve_No int identity(2000001,1) primary key not null ,
woodType varchar(50) not null,
s_period int not null,
ppp decimal(12,4)  not null,
NAO_CFT decimal(12,4) not null 
);

INSERT INTO WoodReservation
VALUES (1000001,'Segun','6', '60000','69.45'),
(1000002,'Mehegoni','10', '100000','69.45'),
(1000003,'China pech','15', '200000','16.203')

select*from WoodReservation



--table 03--order table



create table orders
(
orderNo int identity(3000001,1) primary key not null ,
orderDate date not null,
deliveryDate  date not null,
orderDetails varchar(200) not null,
deliveryAddress varchar(100) not null,
orderSupervisor varchar(50) not null
);

INSERT INTO orders
VALUES ('2022-12-31','2023-01-10','burnish properly','821 east shewrapara','aminul'),
('2022-11-29','2022-12-31','burnish properly','2 townhall','arisha'),
('2023-01-22','2023-02-10','burnish properly','14 uttora','daliya')

select*from orders


--table 04--order equipment table



create table orderEquipment
(
orderNo int not null foreign key references orders(orderNo) ,
equipment_serialNo int identity(4000001,1) primary key not null ,
chair int  null,
tabel int  null,
almira int  null,
sofasets int  null,
bookshelf int  null,
others varchar(80) null,
CFT_approx int not null
);
INSERT INTO orderEquipment
VALUES (3000001,4,1,0,0,1,'Segun',60),
(3000002,6,1,0,0,0,'Mehegoni',75),
(3000003,0,0,1,6,0,'Segun',62)

drop table orderEquipment

select * from orderEquipment

--table 05--net wood per product table



create table NWPP
(
NWPP_No int identity(5000001,1) primary key not null ,
equipment_serialNo int not null foreign key references orderEquipment(equipment_serialNo) ,
net_wood int not null,
woodType varchar(50) not null ,
NWPrice decimal(10,3) not null
);

INSERT INTO NWPP
VALUES (4000001,6,'Segun',36000),
(4000002,8,'Mehegoni',150000),
(4000003,7,'Segun',37200)

select * from NWPP

--table 06--Color Cost table



create table colorCost
(
color_code int identity(6000001,1) primary key not null ,
colorName varchar(50) not null ,
c_netAmount decimal(10,4) not null,
c_unitPrice decimal(10,4) not null,
requiredBurnish varchar(50)
);

INSERT INTO colorCost
VALUES ('chocolate','3','70.55','extra volt'),
('water','5','55.92','volt'),
('segun brash','8','82.22','extra volt')

select*from colorCost

--table 07--accessories Cost table



create table AccessoriesCost
(
a_code int identity(7000001,1) primary key not null ,
a_Name varchar(100) not null ,
a_netAmount decimal(10,3) not null,
a_unitPrice decimal(10,3) not null
);
INSERT INTO AccessoriesCost
VALUES ('Handle','420','00'),
('glue','4000','25'),
('pin','8000','2'),
('lock','150','00')


select*from AccessoriesCost
--table 08--sub total expense table



create table SubTotalExpense
(
serialNo int identity(8000001,1) primary key not null ,
equipment_serialNo int not null foreign key references orderEquipment(equipment_serialNo),
color_code int not null foreign key references colorCost(color_code) ,
color_amount decimal(10,3) not null,
a_code int not null foreign key references AccessoriesCost(a_code) ,
accessories_amount decimal(10,3) not null,
sub_total decimal(10,3) not null
);

INSERT INTO SubTotalExpense
VALUES (4000001,6000001,'8000',7000002,'1500','9500'),
(4000001,6000001,'0',7000003,'1200','1200'), -- accessories can need double cause all the varities is here
(4000002,6000002,'7000',7000001,'1700','8700'),
(4000002,6000002,'0',7000004,'2200','2200'),
(4000003,6000001,'10000',7000001,'2000','12000'),
(4000003,6000001,'0',7000004,'2500','2500')


select*from SubTotalExpense

--table 09--total expense table



create table TotalExpense
(
expenseNo int identity(9000001,1) primary key not null ,
orderNo int not null foreign key references orders(orderNo),
serialNo int not null foreign key references SubTotalExpense(serialNo),
NWPP_No int not null foreign key references NWPP(NWPP_No),
worker_cost decimal(10,3) not null,
hidden_cost decimal(10,3) not null,
total_cost decimal(10,3) not null
);
INSERT INTO TotalExpense
VALUES (3000001,8000001,5000001,'10000','2500','55000'),
(3000002,8000003,5000002,'9000','2200','75000'),
(3000003,8000005,5000003,'12000','2150','65200')

select*from TotalExpense
drop table TotalExpense

--table 10--control panel table



create table controlPanel
(
cp_id int identity(1,1) primary key not null ,
designation varchar(20) not null,
user_id int not null unique,
user_name varchar(50) not null,
user_contact int not null unique,
user_password varchar(32) not null ,
user_NID int not null unique,
user_mail varchar(80) not null 

);


INSERT INTO controlPanel
VALUES ('owner', 1, 'ali',01847777811,'123abc',919945678 ,'ali@gmail.com'),
 ('manager', 2, 'jamal',01999144444 ,'abc12',672765678 ,'jamal@gmail.com'),
 ('assistanat manager', 3, 'mili', 01623889909,'12345',231995678 ,'mili@gmail.com')
 

 select*from controlPanel


 
select OrderDate, DeliveryDate from orders where orderNo like 3000001


select NWPrice from NWPP where NWPP_No like 5000001


select sub_total from SubTotalExpense where serialNo like 8000001 


 
select orders.orderSupervisor, orders.orderDetails from orders where orderNo=3000003

select WoodAccuracy.NAO_CFT from WoodAccuracy join WoodReservation on  WoodAccuracy.w_serialNo=WoodReservation.w_serialNo where WoodAccuracy.w_serialNo like 1000001


select * from orders join TotalExpense on orders.orderNo = totalexpense.orderno where orders.deliveryDate like '2023-01-10'

 select orders.orderSupervisor, orders.orderNo from orders join (select orderNo ,sum(total_cost) as product_price from TotalExpense group by orderNo ) as orderExp on orders.orderNo = orderExp.orderNo