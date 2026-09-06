


/*
SQL Execution Flow
------------------
1. From
2. Join
3. Where
4. Group by
5. Having
6. Select
7. Order by
8. Limit (MySQL / PgSQL) / Top (SQL Server) / Offset Fetch (SQL Server/ Orcale)


*/

-- offset -> number of rows to skip
-- fetch -> extract number of rows after skipping
  --eg:
  -------------
/*
select 
	customer_id, first_name, last_name,phone,email,street,city,state,zip_code
from sales.customers
order by city
offset 100 rows fetch next 50 rows only;
*/
-------------

select top 10
	customer_id, first_name, last_name,phone,email,street,city,state,zip_code
from sales.customers
order by city


-----------
--AND,OR,Between, IN, Like

----Find order details of 2016 January
select * from sales.orders where order_date between '2016-01-01' and '2016-01-31'



-- Find product details where the price is between 200 to 800
select 
* from production.products 
where list_price > 200 and list_price < 800;  --faster
where list_price between 200 and 800;   --slower

--Find product details of brand 2 and 6
select
* from production.products
where brand_id = 2 or brand_id = 6;		--faster
where brand_id in (2,6)			--Slower




--Like (Used for searching)
--Wildcards (%, _)
select * from production.products;

--Find product details whose name starts with letter 'T'
select * from production.products where product_name like 'T%';

--Find product details whose name ends with 2018
select * from production.products where product_name like '%2018';

--Find product details whose name has 'l' as the second letter
select * from production.products where product_name like '_l%';

--Find product details whose name has 4 letters
select * from sales.customers where first_name like '____';



-- Concat Function and Concatenation Operator (+) -- In oracle (||)
select 
	CONCAT(first_name,' ', last_name) as full_name
from sales.customers
order by full_name desc;

--or

select 
	(first_name + ' ' + last_name) as full_name
from sales.customers
order by full_name asc;

-- Find Debra Burks customer details
select * from sales.customers where CONCAT(first_name,last_name) = 'DebraBurks'

-----------------------------------

-- substring
--substring(column_name, start_length, number_of_letters)


select first_name, SUBSTRING(first_name , 2 , 3) as mid_letters
from sales.customers


--left and right

select first_name, LEFT(first_name,3) as first_3
from sales.customers

select first_name, RIGHT(first_name,3) as last_3
from sales.customers

------------------------------------------------

--making a unique customer id using all the details
select 
CONCAT(
customer_id, '-' ,SUBSTRING(first_name,3,2),'-' ,RIGHT(last_name,4),'-',SUBSTRING(email,5,6),'-' , LEFT(street,2),'-' ,state, SUBSTRING(zip_code,2,3)
) as customer_id, first_name, last_name
from sales.customers

------------------------------------------

-- Why concat not concatination(+)


select
CONCAT(first_name, '___________' , phone) as p_data
--(first_name + '___________' + phone) as p_data
from sales.customers


-- Concatination (+) cannot add different types of data types but concat can.
-- This types of problem is not possible in oracle only in SQL

-----------------------------------------

--Time Series Analysis/ Cohort Analysis
select
	order_date,
	Year(order_date) as o_year,
	Month(order_date) as o_month,
	Day(order_date) as o_day,
	DATENAME(MONTH, order_date) as or_month,
	DATENAME(WEEKDAY, order_date) as or_day,
	DATEPART(WEEKDAY, order_date) as dp_day,
	DATEPART(WEEK, order_date) as dp_wk,
	DATEPART(QUARTER, order_date) as dp_qt,
	FORMAT(order_date, 'MMMM') as order_month,
	FORMAT(order_date, 'dddd') as order_day
from sales.orders


--IsNull   
--Coalesce	

select 
	shipped_date,
	ISNULL(shipped_date, GETDATE())
	Coalesce(shipped_date, GetDate())
from sales.orders;

------------------------------
select 
	order_date, shipped_date,
	DATEDIFF(DAY, order_date, isnull(shipped_date, getdate())) as day_diff,
	DATEDIFF(MONTH, order_date, isnull(shipped_date, getdate())) as month_diff,
	DATEADD(day, 3, order_date) as add_day
from sales.orders;


-- SQL CASE
 /* 
	select 
		case	
			when condition then value
			when condition then value
		end
	from table_name;
 */


 select
	product_id, product_name, model_year, list_price,
	case
		when list_price <= 1000 then 'Low Price Product'
		when list_price between 1000 and 2500 then 'Average Price Product'
		when list_price >2500 then'High Price Product'
		Else 'Invalid Data'
	End as product_label
from production.products
order by list_price asc;




------------------------

select
*,
DATEDIFF(day,required_date, ISNULL(shipped_date, GETDATE())) as day_diff,
case
	when DATEDIFF(day,required_date, ISNULL(shipped_date, GETDATE()))  < 0 then 'Completed'
	when DATEDIFF(day,required_date, ISNULL(shipped_date, GETDATE()))  = 0 then 'Processing'
	when DATEDIFF(day,required_date, ISNULL(shipped_date, GETDATE()))  > 0 then 'Pending'
	End as order_status_label
from sales.orders
----------------------------------------------------

select 
	order_id, item_id, product_id,quantity, list_price,discount,
	(list_price * quantity)-(0.20*(list_price * quantity)) as after_discount,
	((list_price * quantity)-(0.20*(list_price * quantity)))*1.3 as taxable_amount,
	((list_price * quantity)-(0.20*(list_price * quantity)) + ((list_price * quantity)-(0.20*(list_price * quantity)))*1.3 ) as grand_total,
case
	when ((list_price * quantity)-(0.20*(list_price * quantity)) + ((list_price * quantity)-(0.20*(list_price * quantity)))*1.3 ) < 3000 then 'Low Price Purchase'
	when ((list_price * quantity)-(0.20*(list_price * quantity)) + ((list_price * quantity)-(0.20*(list_price * quantity)))*1.3 ) between 3000 and 8000 then 'Average Price Purchase'
	when ((list_price * quantity)-(0.20*(list_price * quantity)) + ((list_price * quantity)-(0.20*(list_price * quantity)))*1.3 )	> 8000 then 'High Price Purchase'
	else 'Invalid Data'
end as price_label
from sales.order_items
-------------------------------------------------


/*
group by and having
--------------------
1. Aggerate Columns
2. Non-Aggerate Columns

*/

-- Find total customers from each state

select
 state, city , count(customer_id) as total_customers
 from sales.customers
 group by state, city
 having state = 'NY'

 -------------------

 -- Find total orders in order status Pending, Processing, Rejected and Completed

 select
 case 
	when order_status = 1 then 'Pending'
	when order_status = 2 then 'Processing'
	when order_status = 3 then 'Rejected'
	when order_status = 4 then 'Completed'
end as status_label,
count(order_id) as total_orders
 from sales.orders
 group by order_status;




 /*
 --SQL Join
 
 1. Inner Join
 2. Left Join
 3. Right Join
 4. Outer Join
 5. Natural Join
 6.
 7. Cross Join

 syntax
 _________
 ---------

 select
	t1.col1, t2.col2, t1.col3, t2.col4
from table1 t1
join table2 t2
on t1.pk = t2.fk;

ambigious column col1

 */

 select
  CONCAT(sc.first_name, ' ', sc.last_name) as customer_name,
  sc.email, sc.street, sc.city, sc.state, sc.zip_code,
  so.order_status, so.customer_id, so.order_date,so.required_date, so.shipped_date
  from sales.customers sc
  join sales.orders so
  on sc.customer_id = so.customer_id;


----------------

select 
 CONCAT(sc.first_name, ' ', sc.last_name) as customer_name,
 so.customer_id,
soi.list_price,
sum((soi.quantity * soi.list_price)*(1-soi.discount)) as total_price
 from sales.customers sc
 join sales.orders so
 on sc.customer_id = so.customer_id
 join sales.order_items soi
 on so.order_id = soi.order_id
 GROUP BY 
 CONCAT(sc.first_name, ' ', sc.last_name),
 so.customer_id,
 soi.list_price;
 --------------------------------------------------------------------------------------------------------------
 
 
 
 --Self join
 -----------
 -----------


 select 
  CONCAT(s1.first_name, ' ' , s1.last_name) as manager_name,
  CONCAT(s2.first_name, ' ' , s2.last_name) as staff_name
  from sales.staffs s1
  join sales.staffs s2
  on s1.staff_id = s2.manager_id


   select 
  CONCAT(s1.first_name, ' ' , s1.last_name) as manager_name,
 count(s2.staff_id) as total_staffs
  from sales.staffs s1
  join sales.staffs s2
  on s1.staff_id = s2.manager_id
  group by CONCAT(s1.first_name, ' ' , s1.last_name);
  -----------------------------------------------------------------


select
     CONCAT(s1.first_name,' ', s1.last_name) as manager_name,
	 count(distinct s2.staff_id) as total_staffs,
	 count(distinct sc.customer_id) as total_customers
  from sales.staffs s1
  join sales.staffs s2
  on s1.staff_id = s2.manager_id
  join sales.orders so
  on s1.staff_id = so.staff_id
  join sales.customers sc
  on sc.customer_id = so.customer_id
  group by CONCAT(s1.first_name,' ', s1.last_name)
---------------------------------------------------------------------

--Left Join

select
*
from sales.customers sc
left join sales.orders so
on sc.customer_id = so.customer_id

select
*
from sales.staffs s1
left join sales.staffs s2
on s1.staff_id = s2.manager_id

--------------------------------------------------------------------------------------


/*
 SubQuery
 --------

1. Single Row Subquery
- If inner query provides with single row and single column data
- Comparison Operator -> =, !=, <, >, <=, >=

2. Multi Row Subquery
- If inner query provides with multiple row and single column data
- In, (Any, All -> Comparision Operator)



  select * from table_name where col_name < (select col_name from table_name)
*/


-- Find all product details whose price is less than its average list price


select AVG(list_price) as avg_price from production.products

select * from production.products
where list_price < 1520.591401


select *
from production.products where  list_price < (
select avg(list_price) from production.products
);


--Find second highest list price from product details
select * from production.products where list_price =(
select max(list_price) from production.products where list_price < (
select MAX(list_price) from production.products))
;

-- Find the details of customers whose order status is rejected
select *
from sales.customers sc
join sales.orders so
on sc.customer_id = so.customer_id
where order_status = 3

select
*
from sales.customers where customer_id in(
select customer_id from sales.orders where order_status = 3);



/*
 ANY -> OR
 ALL -> AND
*/

-- Find all products whose list price is less than 209.99 / 250.99

select * from production.products
where list_price < any (
select list_price from production.products where list_price in (209.99,250.99)
);

-- Find all products whose list price is less than 209.99 / 250.99

select first_name, last_name, email, state , city, street from sales.customers
	where customer_id in(
		select customer_id from sales.orders where order_id in (
			select order_id from production.products
				where list_price < all(
					select list_price from production.products 
						where list_price in (209.99,250.99)
				)
			)
		);


-- Find staff details who have managed orders which was rejected and sold products 
-- whose price is more than 1000 whose model year is 2017
select * from sales.staffs where store_id in (
	select store_id from production.stocks where product_id in (
		select list_price from production.products where model_year = 2017 and list_price > 1000
	)
);


/*
Common Table Expression (CTE)
---------------------------
Temporary data tabe

with cte_name as (
			query...........
			)
	select * from cte_name;
*/
WITH   product_price
AS     (SELECT product_id,
               list_price
        FROM   production.products
        WHERE  list_price < ALL (SELECT list_price
                                 FROM   production.products
                                 WHERE  list_price IN (209.99, 250.99)))
SELECT DISTINCT sc.first_name,
                sc.last_name,
                pp.product_id
FROM   product_price AS pp
       INNER JOIN
       sales.order_items AS soi
       ON pp.product_id = soi.product_id
       INNER JOIN
       sales.orders AS so
       ON soi.order_id = so.order_id
       INNER JOIN
       sales.customers AS sc
       ON so.customer_id = sc.customer_id
       WHERE order_status =4;

--Find total amount spent by customers  from each state. Display state and Total Amount.
with customer_spent as(
select concat(first_name,' ',last_name) as customer_name,sc.state,((soi.list_price*soi.quantity)*(1-soi.discount)) as total_spent
from sales.customers sc
join sales.orders so
on sc.customer_id = so.customer_id
join sales.order_items as soi
on so.order_id=soi.order_id
where order_status=4
)
select state,SUM(total_spent) as total_price from customer_spent
group by state;
