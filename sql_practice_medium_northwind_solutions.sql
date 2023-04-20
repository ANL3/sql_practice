--Q1--Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table
select products.product_name,suppliers.company_name,categories.category_name from products
inner join categories on products.category_id=categories.category_id
inner join suppliers on suppliers.supplier_id=products.supplier_id;

--Q2--Show the category_name and the average product unit price for each category rounded to 2 decimal places.
select categories.category_name,Round(AVG(products.unit_price),2) from products
inner join categories on categories.category_id=products.category_id group by categories.category_name;

SELECT c.category_name, round(avg(p.unit_price),2) as average_unit_price
FROM products p
JOIN categories c On c.category_id = p.Category_id
GROUP BY c.category_name

--Q3--Show the city, company_name, contact_name from the customers and suppliers table merged together.
--Create a column which contains 'customers' or 'suppliers' depending on the table it came from.
select city, company_name, contact_name,"customers" from customers
union
select city, company_name, contact_name,"suppliers" from suppliers