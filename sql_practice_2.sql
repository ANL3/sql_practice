--1.Soru--Show the category_name and description from the categories table sorted by category_name.
select category_name,description from categories order by category_name;

--2.Soru--Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'
select contact_name, address, city from customers where country not IN ("Germany","Mexico","Spain");

--3.Soru--Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26
select order_date, shipped_date, customer_id, freight from orders where order_date="2018-02-26";

--4.Soru--Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date
select employee_id,order_id,customer_id,required_date,shipped_date from orders where shipped_date>required_date;

--5.Soru--Show all the even numbered Order_id from the orders table
select order_id from orders where order_id%2=0;

--6.Soru--Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name,
--sorted by contact_name
select city,company_name,contact_name from customers where city like "%l%" order by contact_name; 

--7.Soru--Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)
select company_name,contact_name,fax from customers where fax is not null;

--8.Soru--Show the first_name, last_name of the most recently hired employee.
select first_name,last_name,hire_date from employees order by hire_date desc limit 1;
--8.Soru--Show the first_name, last_name of the most recently hired employee.
select first_name,last_name,max(hire_date) as hire_datefrom employees

--9.Soru--Show the average unit price rounded to 2 decimal places, the total units in stock,
--total discontinued products from the products table.
select Round(avg(unit_price),2),sum(units_in_stock),Sum(discontinued) from products;
SELECT round(avg(Unit_Price), 2) AS average_price,SUM(units_in_stock) AS total_stock,SUM(discontinued) as total_discontinued FROM products;