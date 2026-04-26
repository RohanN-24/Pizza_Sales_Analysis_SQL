create database PIZZA_SALES;
use pizza_sales;
SHOW TABLES;

select count(*) FROM PIZZA_TYPES;





select * from pizzas;

create table Orders(
	order_id int primary key,
    order_date date not null,
    order_time time not null
);

create table Order_details (
	order_details_id int primary key,
	order_id int not null,
    pizza_id text not null,
    quantity int not null
);
