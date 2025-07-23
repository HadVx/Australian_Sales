----  General info about customers  --------------------------------------------------------------------
WITH first_block AS
(
	SELECT 
		  s.customer_id AS id
		, COALESCE(c.first_name,'')
		|| ' ' || COALESCE(c.last_name,'') AS name
 		, a.state
		, a.postcode
		, a.property_valuation 		 AS property_val
		, CASE 
			WHEN s.age_clean BETWEEN 18 AND 25
				THEN '18-25'
			WHEN s.age_clean BETWEEN 26 AND 35
				THEN '26-35'
			WHEN s.age_clean BETWEEN 36 AND 45
				THEN '36-45'
			WHEN s.age_clean BETWEEN 46 AND 55
				THEN '46-55'
			WHEN s.age_clean BETWEEN 56 AND 65
				THEN '56-65'
			ELSE '65-99' 
		   END 						 AS age
		, c.tenure
		, c.wealth_segment
		, c.owns_car
		, ROUND(SUM(s.list_price),2) AS total_cost
		, ROUND(SUM(s.profit),2) 	 AS total_profit
		, ROUND(AVG(s.list_price),2) AS avg_invoice_price
		, COUNT(*) AS count_of_transac
		, MIN(transaction_date) 	 AS first_transac
		, MAX(transaction_date) 	 AS last_transac 
		, EXTRACT(YEAR FROM MIN(product_first_sold_date)) AS year_of_first_purchase
	FROM customers c
	LEFT JOIN sales s USING (customer_id)
	LEFT JOIN address a USING (customer_id)
	GROUP BY 1,2,3,4,5,6,7,8,9
)
----  Favorite brand, count of brands per person  ------------------------------------------------------
, second_block AS 
(
	SELECT 
		customer_id
		, brand 					AS favorite_brand									   
		, COUNT(*) 					AS first_filter_part
		, ROW_number() OVER(
				PARTITION BY customer_id 
				ORDER BY COUNT(*) DESC
				) 									   AS second_filter_part
		, COUNT(brand) OVER (PARTITION BY customer_id) AS brands_count
	FROM sales 
	GROUP BY 1,2
)
----  Brand list  --------------------------------------------------------------------------------------
, third_block AS 
(
	SELECT
		customer_id
		,STRING_AGG(DISTINCT brand, ',') AS brands_list
	FROM sales
	GROUP BY 1
)
----  General info by states  --------------------------------------------------------------------------
, fourth_block AS
(
	SELECT 
		s.customer_id
		, a.state
		, SUM(s.list_price) OVER(
			PARTITION BY state
			) 					AS sales_by_state
		, SUM(s.profit) OVER(
			PARTITION BY state
			) 					AS profit_by_state
	FROM sales s
	LEFT JOIN address a USING(customer_id)
)
----  First filter for eighth block  -------------------------------------------------------------------
, fifth_block AS
(
	SELECT 
		customer_id
		, DATE_TRUNC('month', transaction_date)::DATE AS month
		, ROUND(AVG(list_price),2) AS month_avgListPrice
	FROM sales
	GROUP BY 1,2
	ORDER BY 1,2 
)
----  Second filter for eighth block  ------------------------------------------------------------------
, sixth_block AS
(
	SELECT 
		customer_id
		, month
		, month_avgListPrice
		, LAG(month_avgListPrice) OVER(
				PARTITION BY customer_id
				) AS prev_month_avgListPrice
	FROM fifth_block
)
----  Third filter for eighth block  -------------------------------------------------------------------
, seventh_block AS
(
	SELECT 
		customer_id
		, month
		, COUNT(*) OVER(
			partition by customer_id
			)-1 AS filter_seventh_block
		, (month_avgListPrice/prev_month_avgListPrice-1)*100 AS percentage_by_month
	FROM sixth_block
)
----  Montly percentage growth of costs per person  ----------------------------------------------------
, eighth_block AS
(
	SELECT 
		customer_id
		, ROUND((SUM(percentage_by_month) /
			filter_seventh_block),2) AS percentage_growth_of_costs 
	FROM seventh_block
	WHERE percentage_by_month NOTNULL
	GROUP BY 1, filter_seventh_block
)
----  Filter for tenth block  --------------------------------------------------------------------------
, nineth_block AS 
(
	SELECT 
		customer_id	
		,'2017-12-31'::DATE - MAX(transaction_date) AS R_raw
		, COUNT(*) 			AS F_raw
		, SUM(list_price) 	AS M_raw
	FROM sales
	GROUP BY 1
)
----  RFM statistic per person from 1 to 5. R-recency; F-frequency; M-monetary  ------------------------
, tenth_block AS 
(
	SELECT 
		customer_id
	    ,NTILE(5) OVER (ORDER BY R_raw ASC) AS R
		,NTILE(5) OVER (ORDER BY F_raw ASC) AS F
		,NTILE(5) OVER (ORDER BY M_raw ASC) AS M
	FROM nineth_block
)
----  Favorite bike line  ------------------------------------------------------------------------------
, eleventh_block AS
(
	SELECT customer_id
		, product_line 						AS favorite_line
		, Count(*) 							AS eleventh_block_filter
		, row_number() OVER( PARTITION BY customer_id
			ORDER BY count(*) DESC) 		AS second_eleventh_block_filter
	FROM sales
	GROUP BY 1,2
)

----  Grouping all blocks into one table  --------------------------------------------------------------
SELECT 
	DISTINCT firstb.id
	, firstb.name
	, firstb.state
	, fourthb.sales_by_state
	, fourthb.profit_by_state
	, firstb.age
	, firstb.property_val
	, firstb.tenure
	, firstb.total_cost
	, firstb.total_profit
	, firstb.avg_invoice_price
	, eleventhb.favorite_line
	, firstb.count_of_transac
	, einghthb.percentage_growth_of_costs
	, firstb.first_transac
	, firstb.last_transac
	, firstb.year_of_first_purchase
	, secondb.favorite_brand
	, thirdb.brands_list
	, secondb.brands_count
	, firstb.wealth_segment
	, firstb.owns_car
	, tenthb.R
	, tenthb.F
	, tenthb.M
FROM first_block firstb
LEFT JOIN second_block secondb ON firstb.id=secondb.customer_id
LEFT JOIN third_block thirdb ON firstb.id=thirdb.customer_id
LEFT JOIN fourth_block fourthb ON firstb.id=fourthb.customer_id
LEFT JOIN eighth_block einghthb ON firstb.id=einghthb.customer_id
LEFT JOIN tenth_block tenthb ON firstb.id=tenthb.customer_id
LEFT JOIN eleventh_block eleventhb ON firstb.id=eleventhb.customer_id
WHERE secondb.second_filter_part=1
	AND eleventhb.second_eleventh_block_filter=1;