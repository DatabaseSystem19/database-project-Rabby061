insert into branch values(1,'shib bari','khulna','01*********');
insert into branch values(2,'shonadanga','khulna','01*********');
insert into branch values(3,'new market','dhaka','01*********');
insert into branch values(4,'new market','khulna','01*********');
insert into branch values(5,'daulotpur','khulna','01*********');
insert into branch values(6,'bhanga','faridpur','01*********');
insert into branch values(7,'mirpur-10','dhaka','01*********');
insert into branch values(8,'gulshan-12','dhaka','01*********');
insert into branch values(9,'shahabag','dhaka','01*********');
insert into branch values(10,'fulbariget','khulna','01*********');


insert into employee values(1,1,'sadi','manager',30000,'khulna','01*********');
insert into employee values(2,1,'asif','salesman',10000,'khulna','01*********');
insert into employee values(3,2,'atik','salesman',10000,'khulna','01*********');
insert into employee values(4,3,'salman','cashier',20000,'dhaka','01*********');
insert into employee values(5,2,'rahim','manager',30000,'khulna','01*********');
insert into employee values(6,3,'sabbir','salesman',10000,'dhaka','01*********');
insert into employee values(7,4,'abrar','manager',30000,'khulna','01*********');
insert into employee values(8,10,'safwan','cashier',20000,'khulna','01*********');
insert into employee values(9,4,'shuvro','salesman',10000,'khulna','01*********');
insert into employee values(10,4,'naieem','salesman',10000,'khulna','01*********');


insert into customer values(1,'sadi','daulotpur,khulna','01*********');
insert into customer values(2,'asif','fulbariget,khulna','01*********');
insert into customer values(3,'atik','banani,dhaka','01*********');
insert into customer values(4,'shafiqul','boyra,khulna','01*********');
insert into customer values(5,'hadi','bhanga,faridpur','01*********');
insert into customer values(6,'zunnun','fultala,khulna','01*********');
insert into customer values(7,'shonjoy','shibbari,khulna','01*********');
insert into customer values(8,'ashfaq','cumilla','01*********');
insert into customer values(9,'hasib','varamara,kushtia','01*********');
insert into customer values(10,'naieem','daulotpur,khulna','01*********');


insert into product values(1,1,'shirt','L',1299.99);
insert into product values(2,1,'pant','34',1099.99);
insert into product values(3,1,'shirt','xL',1599.99);
insert into product values(4,1,'t-shirt','M',699.99);
insert into product values(5,4,'shirt','L',1299.99);
insert into product values(6,4,'t-shirt','S',599.99);
insert into product values(7,4,'jacket','xL',2299.99);
insert into product values(8,4,'shirt','xxL',1899.99);
insert into product values(9,3,'shirt','L',1299.99);
insert into product values(10,3,'pant','32',1599.99);


insert into orders values(1,1,1,'01-01-2023','daulotpur,khulna');
insert into orders values(2,1,2,'01-01-2023','daulotpur,khulna');
insert into orders values(3,2,1,'01-01-2023','daulotpur,khulna');
insert into orders values(4,2,4,'01-01-2023','daulotpur,khulna');
insert into orders values(5,2,3,'01-01-2023','daulotpur,khulna');
insert into orders values(6,3,9,'01-01-2023','daulotpur,khulna');
insert into orders values(7,3,10,'01-01-2023','daulotpur,khulna');
insert into orders values(8,3,1,'01-01-2023','daulotpur,khulna');
insert into orders values(9,4,7,'01-01-2023','daulotpur,khulna');
insert into orders values(10,4,6,'01-01-2023','daulotpur,khulna');


select * from branch;
select * from employee;
select * from customer;
select * from product;
select * from orders;

--all order made by sadi
select * from orders where customer_id=(select customer_id from customer where name='sadi');

--all order placed in shib bari branch
select * from orders where product_id IN(select product_id from product where branch_id=(select branch_id from branch where street='shib bari'));

--update salary of salesman
update employee set salary=15000 where employee_type='salesman';
select * from employee;

--all shirt and tshirt
select product_type,product_size,price from product where product_type like 's%' or product_type like 't%';

--all shirt 
select product_type,product_size,price from product where product_type like 's%' and product_type like 't%';


--avarage price of shirt,t-shirt,pant,jacket
select product_type,avg(price) from product group by product_type;

--avarage price greater than 1000;
select product_type,avg(price) from product group by product_type having avg(price)>1000;

--product with maximum price
with max_price(price) as (select max(price) from product)
select * from product,max_price where product.price=max_price.price;

--product with second maximum price
with max_price(price) as (select max(price) from product where price<(select max(price) from product))
select * from product,max_price where product.price=max_price.price;

--number of ordered product
select count(distinct product_id) as no_of_product_ordered from orders;

--number of shirt ordered
select count(product_id) from orders where product_id IN(select product_id from product where product_type='shirt');

--join product and order table
select order_id,product_id,product_type from orders join product using (product_id)
order by order_id;

--total price of all product ordered
select sum(price) from orders join product using (product_id);


