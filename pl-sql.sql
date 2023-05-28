set serveroutput on
declare 
product_id2 product.product_id%type;
product_type product.product_type%type;
price product.price%type;
begin
select product_id,product_type,price into product_id2,product_type,price from product where product_id=1;
dbms_output.put_line('product_id: '||product_id2|| ' product_type: '||product_type || ' price: '||price);
end;
/

--insert and set default value
set serveroutput on
declare 
product_id product.product_id%type:=11;
branch_id product.branch_id%type:=8;
product_type product.product_type%type:='pant';
product_size product.product_size%type:='33';
price product.price%type:=1599.99;
begin
insert into product values(product_id,branch_id,product_type,product_size,price);
end;
/


--row type
set serveroutput on
declare 
product_row product%rowtype;
begin
select product_id,product_type,price into product_row.product_id,product_row.product_type,product_row.price from product where product_id=1;
dbms_output.put_line('product_id: '||product_row.product_id|| ' product_type: '||product_row.product_type || ' price: '||product_row.price);
end;
/


--cursor and row count
set serveroutput on
declare 
cursor product_cursor is select * from product;
product_row product%rowtype;
begin
open product_cursor;
fetch product_cursor into product_row.product_id,product_row.branch_id,product_row.product_type,product_row.product_size,product_row.price;
while product_cursor%found loop
dbms_output.put_line('product_id: '||product_row.product_id|| ' product_type: '||product_row.product_type || ' price: '||product_row.price);
dbms_output.put_line('Row count: '|| product_cursor%rowcount);
fetch product_cursor into product_row.product_id,product_row.branch_id,product_row.product_type,product_row.product_size,product_row.price;
end loop;
close product_cursor;
end;
/


--for while loop ,array
set serveroutput on
declare 
  counter number;
  name customer.name%type;
  TYPE NAMEARRAY IS VARRAY(8) OF customer.name%type; 
  A_NAME NAMEARRAY:=NAMEARRAY();
begin
  counter:=2;
  A_NAME.EXTEND();
  for x in 2..8  
  loop
    select name into name from customer where customer_id=x;
    A_NAME.EXTEND();
    A_NAME(counter):=name;
    counter:=counter+1;
  end loop;
  counter:=2;
  while counter<=A_NAME.COUNT 
    loop 
    dbms_output.put_line(A_NAME(counter)); 
    counter:=counter+1;
  end loop;
end;
/


--for while loop ,array without extend
set serveroutput on
declare 
  counter number;
  name customer.name%type;
  TYPE NAMEARRAY IS VARRAY(8) OF customer.name%type; 
  A_NAME NAMEARRAY:=NAMEARRAY('name1','name1','name1','name1','name1','name1','name1','name1');
begin
  counter:=1;
  for x in 2..8  
  loop
    select name into name from customer where customer_id=x;
    A_NAME(counter):=name;
    counter:=counter+1;
  end loop;
  counter:=1;
  while counter<=7 
    loop 
    dbms_output.put_line(A_NAME(counter)); 
    counter:=counter+1;
  end loop;
end;
/



--if else
set serveroutput on
declare 
  counter number;
  name employee.name%type;
  salary employee.salary%type;
begin
  for x in 2..8  
  loop
    select name,salary into name,salary from employee where employee_id=x;
    if salary>=30000
	then
	dbms_output.put_line(name||' is a manager');
    elsif salary>=20000
	then
	dbms_output.put_line(name||' is a cashier');
    else
	dbms_output.put_line(name||' is a salesman');
	end if;
  end loop;
end;
/



create or replace procedure proc2(
  var1 in number,
  var2 out VARCHAR2
)
AS
  t_show CHAR(30);
begin
  t_show := 'From procedure: ';
  select name into var2 from customer where customer_id IN (select customer_id from orders where product_id = var1);
  dbms_output.put_line(t_show || var2 || ' ordered product with id: ' || var1);
end;
/

set serveroutput on
declare 
product_id product.product_id%type:=9;
name customer.name%type;
begin
proc2(product_id,name);
end;
/

drop procedure proc2;



set serveroutput on
create or replace function fun(var1 in varchar) return varchar AS
value customer.name%type;
begin
  select name into value from customer where customer_id=var1; 
   return value;
end;
/

set serveroutput on
declare 
value varchar(40);
begin
value:=fun(2);
dbms_output.put_line(value);
end;
/

drop function fun;
