use pizza_sales;

-- Total numbers of order
SELECT count(order_id) as total_orders 
FROM orders;



-- Calculate the total revenue generated from pizza sales.
SELECT round(sum( od.quantity * p.price),2) AS Total_revenue
FROM order_details AS od 
	JOIN pizzas AS p
ON od.pizza_id = p.pizza_id;




-- Identify the highest-priced pizza.
select pt.name, (p.price)
from pizzas as p
	 join pizza_types as pt
on p.pizza_type_id = pt.pizza_type_id
order by p.price desc
limit 1;



-- Identify the most common pizza size ordered.
select size,count(p.size) as ordered_pizza
from order_details as od
	join pizzas as p
on od.pizza_id = p.pizza_id
group by p.size
order by count(p.size) desc;



-- List the top 5 most ordered pizza types 
-- along with their quantities.
select pt.name,sum(od.quantity) as quantity
from order_details as od
	join pizzas as p
on od.pizza_id = p.pizza_id
	join pizza_types as pt
on p.pizza_type_id = pt.pizza_type_id
group by pt.name
order by sum(od.quantity)  desc
limit 5 ;



-- To find the total ordered quantity of each pizza category .
select pt.category, sum(od.quantity) as ordered_quantity
from order_details as od
	join pizzas as p
on od.pizza_id = p.pizza_id
	join pizza_types as pt
on p.pizza_type_id = pt.pizza_type_id
group by pt.category order by sum(od.quantity) desc;



-- Calculate the average number of pizzas ordered per day.
select ceil(avg(quantity)) as average_order
from
	(select o.order_date, sum(od.quantity) as Quantity
	from orders as o
		join order_details as od
	on o.order_id = od.order_id
	group by o.order_date) as ordered_quantity;




-- Highest Price Pizza in Each Category
SELECT category, name, price
	FROM(
		SELECT pt.category, pt.name, p.price,
		   RANK()
           OVER (PARTITION BY pt.category ORDER BY p.price DESC)
           AS rank_in_category
		FROM pizzas as p
		JOIN pizza_types as pt 
	ON p.pizza_type_id = pt.pizza_type_id) as t
WHERE rank_in_category = 1
ORDER BY price desc; 




-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT pt.category ,
       -- SUM(od.quantity * p.price) AS revenue,
       ROUND(SUM(od.quantity * p.price) * 100 
           / SUM(SUM(od.quantity * p.price)) OVER (), 2) AS percentage
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY percentage DESC;


select o.order_date, sum(od.quantity) as Quantity
	from orders as o
		join order_details as od
	on o.order_id = od.order_id
	group by o.order_date;
    
    
SELECT pt.category, pt.name, p.price,
		   RANK()
           OVER (PARTITION BY pt.category ORDER BY p.price DESC)
           AS rank_in_category
		FROM pizzas as p
		JOIN pizza_types as pt 
	ON p.pizza_type_id = pt.pizza_type_id;