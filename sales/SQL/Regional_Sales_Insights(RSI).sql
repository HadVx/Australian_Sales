WITH total_info AS --CTE with sum of list_price, profit, unique customers and AVG_invoice by states
(
	SELECT  
		a.state
		, SUM(s.list_price) 					AS total_sales
		, SUM(s.profit) 						AS total_profit
		, COUNT(DISTINCT customer_id) 			AS unique_customers
		, ROUND(AVG(list_price),2) 				AS avg_invoice
	FROM address a
	JOIN sales s USING(customer_id)
	GROUP BY 1
)

, top_brands AS  -- CTE with top brands by number of transactions by states
(
	SELECT 
		a.state
		, s.brand 								AS top_brands_in_state
		, count(*) 								AS count_of_sales_by_brands
		, ROW_NUMBER() OVER (
			PARTITION BY state 
			ORDER BY count(*) DESC
			) 									AS filter
	FROM sales s
	JOIN address a USING(customer_id)
	GROUP BY 1,2
)

SELECT -- Merging data from two CTE`s
	tb.state
	, tb.top_brands_in_state
	, ti.total_sales
	, ti.total_profit
	, ti.avg_invoice
	, ti.unique_customers
FROM total_info ti
JOIN top_brands tb USING (state)
WHERE tb.filter = 1
ORDER BY tb.state;


