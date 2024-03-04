---total revenue--
select sum (total_price) As Total_Revenue from pizza_sales

----- average order values---
select SUM(total_price)/COUNT(DISTINCT order_id) AS Avg_Order_Value from pizza_sales

---total pizza sold---
select SUM(quantity) as Total_Pizza_sold from pizza_sales

---- total  number of  orders---
select COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales

----average pizza Per order--
select CAST (CAST(SUM(quantity) AS decimal(10,2))/ 
CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS decimal(10,2)) as avg_per_pizza_order from pizza_sales  

select * from pizza_sales WHERE order_date IS NULL

--daily trend for total orders--
select DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) AS Total_orders from pizza_sales
GROUP BY DATENAME(DW,  order_date)

TRUNCATE table pizza_sales

DROP TABLE pizza_sales

select * from pizza_sales

----Hourly trend orders--
select DATEPART(HOUR, order_time) as Order_hours, COUNT(DISTINCT order_id) AS Total_orders from pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)


---Percentage of sales by Pizza category--
select pizza_category, sum(total_price) as total_sales, sum(total_price) * 100 / (select sum(total_price) from pizza_sales WHERE MONTH(order_date) = 1)
 AS PCT from pizza_sales
 WHERE MONTH(order_date) = 1
GROUP BY pizza_category

----percentage of sales by pizza size---
SELECT pizza_size, SUM(total_price) as total_sales, CAST(SUM(total_price)* 100 / (select sum(total_price) from pizza_sales WHERE DATEPART(quarter,order_date)= 1) AS DECIMAL (10,2)) AS PCT
from pizza_sales
 WHERE DATEPART(quarter,order_date)= 1
GROUP BY pizza_size
ORDER BY PCT DESC

SELECT * FROM pizza_sales

----Total pizza sold by pizza category--zza

select pizza_category, sum(quantity) as Total_pizza_sold 
from pizza_sales 
GROUP BY pizza_category
----Top 5 Best sellres by total pizza sold--
select TOP 5 pizza_name, sum(quantity) as pizza_sold from pizza_sales 
GROUP BY pizza_name
ORDER BY sum(quantity)DESC

------bottom 5 Worst sellers by total pizza sold-- 

select sum(quantity) as pizza_sold from pizza_sales 