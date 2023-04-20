--Q1--Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped on time and "Late" if the order shipped late.
--Order by employee last_name, then by first_name, and then descending by number of orders.

select employees.first_name,employees.last_name,count(*) as num_orders,(case when orders.required_date>orders.shipped_date then "On Time" else "Late" End) as shipped
from employees
inner join orders on employees.employee_id=orders.employee_id 
group by first_name,last_name,shipped
order by employees.last_name,employees.first_name,num_orders desc