select * from [Pizza DB]..pizza_sales
SELECT SUM(total_price) AS Total_Revenue FROM [Pizza DB]..pizza_sales;
SELECT (SUM(total_price) / COUNT(DISTINCT(order_id))) AS Avg_order_Value FROM [Pizza DB]..pizza_sales;
SELECT SUM(quantity) AS Total_Pizza_Sold FROM [Pizza DB]..pizza_sales;
SELECT COUNT(DISTINCT(order_id)) AS Total_Orders FROM [Pizza DB]..pizza_sales;


--Hourly Trend for Total Pizzas Sold
SELECT DATEPART(HOUR, order_time) as order_hours, SUM(quantity) as total_pizzas_sold
from [Pizza DB]..pizza_sales
group by DATEPART(HOUR, order_time)
order by SUM(quantity) 
--order by SUM(quantity) DESC
--order by DATEPART(HOUR, order_time)


--Weekly Trend for Orders
SELECT DATEPART(ISO_WEEK,order_date) AS WeekNumber,
YEAR(order_date) AS YEAR,
COUNT(DISTINCT(order_id)) AS Total_Orders 
FROM [Pizza DB]..pizza_sales

GROUP BY DATEPART(ISO_WEEK,order_date), YEAR(order_date)
ORDER BY Total_Orders DESC
--ORDER BY YEAR,WeekNumber
select * from [Pizza DB]..pizza_sales
SELECT SUM(total_price) AS Total_Revenue FROM [Pizza DB]..pizza_sales;
SELECT (SUM(total_price) / COUNT(DISTINCT(order_id))) AS Avg_order_Value FROM [Pizza DB]..pizza_sales;
SELECT SUM(quantity) AS Total_Pizza_Sold FROM [Pizza DB]..pizza_sales;
SELECT COUNT(DISTINCT(order_id)) AS Total_Orders FROM [Pizza DB]..pizza_sales;


--Hourly Trend for Total Pizzas Sold
SELECT DATEPART(HOUR, order_time) as order_hours, SUM(quantity) as total_pizzas_sold
from [Pizza DB]..pizza_sales
group by DATEPART(HOUR, order_time)
order by SUM(quantity) 
--order by SUM(quantity) DESC
--order by DATEPART(HOUR, order_time)


--Weekly Trend for Orders
SELECT DATEPART(ISO_WEEK,order_date) AS WeekNumber,
YEAR(order_date) AS YEAR,
COUNT(DISTINCT(order_id)) AS Total_Orders 
FROM [Pizza DB]..pizza_sales

GROUP BY DATEPART(ISO_WEEK,order_date), YEAR(order_date)
ORDER BY Total_Orders DESC
--ORDER BY YEAR,WeekNumber



-- percentage of Sales by Pizza Category
--divide the total sales of an individual item by the total sales of all products for a specific period and multiply it by 100.

SELECT pizza_category,
CAST(SUM(total_price) AS decimal(10,2)) AS Total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from [Pizza DB]..pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM [Pizza DB]..pizza_sales
GROUP BY pizza_category
ORDER BY Total_revenue DESC


-- percentage of Sales by Pizza Category for a specific month
SELECT pizza_category,
CAST(SUM(total_price) AS decimal(10,2)) AS Total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from [Pizza DB]..pizza_sales WHERE MONTH(order_date) = 9) AS DECIMAL(10,2)) AS PCT
FROM [Pizza DB]..pizza_sales
WHERE MONTH(order_date) = 9
GROUP BY pizza_category

-- percentage of Sales by Pizza Category for a specific quarter
SELECT pizza_category,
CAST(SUM(total_price) AS decimal(10,2)) AS Total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from [Pizza DB]..pizza_sales WHERE DATEPART(QUARTER,order_date) = 3) AS DECIMAL(10,2)) AS PCT
FROM [Pizza DB]..pizza_sales
WHERE DATEPART(QUARTER,order_date) = 3
GROUP BY pizza_category




--percentage of Sales by Pizza Size
SELECT DISTINCT(pizza_size) , CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM [Pizza DB]..pizza_sales ) AS DECIMAL(10,2))  AS PCT
FROM [Pizza DB]..pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC


--Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue 
FROM [Pizza DB]..pizza_sales
GROUP BY pizza_name
--note to get the best 5 pizzas sellers ORDER BY  (DESC)
ORDER BY total_revenue DESC




--Bottom 5 Pizzas by Revenue
SELECT top 5 pizza_name,
CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM [Pizza DB]..pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC



--Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name,
SUM(quantity)  AS Total_Quantity
FROM [Pizza DB]..pizza_sales
Group BY pizza_name
ORDER BY Total_Quantity DESC



--Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name,
SUM(quantity) as Total_Quantity
FROM [Pizza DB]..pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC


--Top 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name,
COUNT(DISTINCT(order_id)) AS Total_Orders
FROM [Pizza DB]..pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC


--Bottom 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name,
COUNT(DISTINCT(order_id)) AS Total_Orders
FROM [Pizza DB]..pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC


SELECT TOP 5 pizza_category,
COUNT(DISTINCT(order_id)) AS Total_Orders 
FROM [Pizza DB]..pizza_sales

GROUP BY pizza_category
ORDER BY Total_Orders DESC


--If you want to apply the pizza_category or pizza_size filters 
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM [Pizza DB]..pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC