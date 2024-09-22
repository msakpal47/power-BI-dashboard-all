select * from pizza_sales;

USE Pizzasalesdb;
SELECT *
FROM pizza_sales;

#: Total Revenue #
select sum(total_price) from pizza_sales;
# create column Total_Revenue as alies #
select sum(total_price)  as Total_Revenue  from pizza_sales;

#Average Order Values #
select SUM(total_price) / COUNT(Distinct(order_id)) from pizza_sales;
#mention name to column#
select SUM(total_price) / COUNT(Distinct(order_id)) as Average_order_value from pizza_sales;

# Total Pizzas sold #
select Sum(quantity) from pizza_sales;
#mention name to column#
select Sum(quantity) as Total_pizzas_sold from pizza_sales;

# Total Orders #
select SUM(DISTINCT(order_id)) as Total_order from pizza_sales;

# Average Pizzas Per orders ##
select Sum(quantity) / Count(Distinct order_id) as Average_Pizzas_Per_orders  from pizza_sales;
select Cast(Sum(quantity) as decimal(10,2)) / cast(Count(Distinct order_id) as decimal(10,2)) AS average_pizzas_per_order from pizza_sales;
or
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10, 2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS DECIMAL(10, 2)) AS average_pizzas_per_order FROM pizza_sales;

select * from pizza_sales;
#daily trend#
select DATENAME(DW, order_date) as order_day, count(distinct order_id) as Total_Orders from pizza_sales 
group by DATENAME(DW, order_date) ;

# monthly trend for total orders #
select DATENAME(MONTH, order_date) as month_name, count(distinct order_id) as Total_orders from pizza_sales
group by DATENAME(MONTH,order_date);
or
select DATENAME(MONTH, order_date) as month_name, count(distinct order_id) as Total_orders from pizza_sales
group by DATENAME(MONTH,order_date)
order by Total_orders desc;

#percentage of sales by pizzas catagory# Ration we want

select pizza_category ,sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as total_sales
from pizza_sales 
group by pizza_category;
or

SELECT pizza_category,SUM(total_price) AS TSale,SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS percentage_of_total_sales FROM pizza_sales
GROUP BY pizza_category;

# filter By Month #
SELECT pizza_category,SUM(total_price) AS TSale,SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS percentage_of_total_sales
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

# percenatge of sales by pizzas size #
SELECT pizza_size,SUM(total_price) AS TSale,SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales ) AS PCT
FROM pizza_sales
GROUP BY pizza_size;

# check in desding order

SELECT pizza_size,SUM(total_price) AS TSale,SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

# check in decimal format #

SELECT pizza_size,SUM(total_price) AS TSale,Cast(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) as decimal(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

# need to 2 decimal output#
SELECT 
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10, 2)) AS TSale,
    CAST(SUM(total_price) * 100 / 
         (SELECT SUM(total_price) 
          FROM pizza_sales 
          WHERE DATEPART(quarter, order_date) = 1) 
         AS DECIMAL(10, 2)) AS PCT
FROM 
    pizza_sales
WHERE 
    DATEPART(quarter, order_date) = 1
GROUP BY 
    pizza_size
ORDER BY 
    PCT DESC;

	# top 5 best sellers by revenues #
	select * from pizza_sales;

	select pizza_name, SUM(total_price) AS Total_REvenues FROM pizza_sales
	Group BY pizza_name;

	select pizza_name, SUM(total_price) AS Total_Revenues FROM pizza_sales
	Group BY pizza_name
	ORDER BY Total_Revenues desc;

	select top 5 pizza_name, SUM(total_price) AS Total_Revenues FROM pizza_sales
	Group BY pizza_name
	ORDER BY Total_Revenues desc;

	select top 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales
	Group BY pizza_name
	ORDER BY Total_Quantity desc;

	select top 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_Order FROM pizza_sales
	Group BY pizza_name
	ORDER BY  Total_Order  desc;

	# Bottum  5 best sellers by revenues #
	select top 5 pizza_name, SUM(total_price) AS Total_Revenues FROM pizza_sales
	Group BY pizza_name
	ORDER BY Total_Revenues asc;

	select top 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales
	Group BY pizza_name
	ORDER BY Total_Quantity asc;

	select top 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_Order FROM pizza_sales
	Group BY pizza_name
	ORDER BY  Total_Order  asc;