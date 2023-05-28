DROP TABLE orders;
DROP TABLE customer;
DROP TABLE product;
DROP TABLE employee;
DROP TABLE branch;


create table branch(
branch_id int not null,
street varchar(40),
city varchar(40),
contact_no varchar(20),
primary key (branch_id)
);

create table employee(
employee_id int not null,
branch_id int not null,
name varchar(40),
employee_type varchar(40),
salary int,
address varchar(40),
phone varchar(20),
primary key (employee_id),
foreign key (branch_id) references branch
);

create table customer(
customer_id int not null,
name varchar(40),
address varchar(40),
phone varchar(20),
primary key (customer_id)
);

create table product(
product_id int not null,
branch_id int not null,
product_type varchar(40),
product_size varchar(20),
price decimal(10,2),
primary key (product_id),
foreign key (branch_id) references branch
);

create table orders(
order_id int not null,
customer_id int not null,
product_id int not null,
order_date varchar(40),
delivary_location varchar(40),
primary key(order_id),
foreign key(customer_id) references customer,
foreign key(product_id) references product
);

set pagesize 100
set linesize 200

--show all created table
select table_name from user_tables;

--delete a column from table
alter table orders drop column order_date;

--add a column in the table
alter table orders add order_date varchar(40);

--rename column
alter table product rename column price to product_price;
alter table product rename column product_price to price;

--change column data type
alter table product modify product_size varchar(40);

alter table employee modify employee_type varchar(20);
alter table employee modify name varchar(20);
alter table employee modify address varchar(20);
