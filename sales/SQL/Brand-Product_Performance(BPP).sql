WITH cte AS         -- CTE with total sales and total profit,  	  
( 	   	    -- avg price and avg profit,
	SELECT      -- count online orders by brands plus product class
		brand
		, product_class
		, DATE_TRUNC ('month', transaction_date)::DATE 			AS month
		, SUM(list_price) 						AS total_sales
		, SUM(profit) 							AS total_profit
		, ROUND(AVG(list_price),2) 					AS avg_price
		, ROUND(AVG(profit),2)						AS avg_profit
		, SUM(CASE
				WHEN online_order = 'true'
				THEN 1
				ELSE 0 
			  END) 							AS count_of_online_orders
	FROM sales
	GROUP BY 1,2, DATE_TRUNC ('month', transaction_date)
) 

SELECT 		-- select all from cte, add sales difference by month
	c.brand
	, c.product_class
	, c.total_sales
	, c.total_profit
	, c.avg_price
	, c.avg_profit
	, c.count_of_online_orders
	, c.total_sales - COALESCE(LAG(c.total_sales) OVER(
		    PARTITION BY c.brand, c.product_class
   	 		ORDER BY c.month),0)
									AS monthly_sales_diff
FROM cte c
ORDER BY c.brand, c.product_class, c.month;

