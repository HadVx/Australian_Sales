SELECT * FROM sales ORDER BY customer_id;

WITH first_block AS --more info soon
(
	SELECT 
		  s.customer_id AS id
		, COALESCE(c.first_name,'')
		|| ' ' || COALESCE(c.last_name,'') AS name
 		, a.state
		, a.postcode
		, a.property_valuation 			AS property_val
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

, second_block AS --more info soon
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

, third_block AS --more info soon
(
	SELECT
		customer_id
		,STRING_AGG(DISTINCT brand, ',') AS brands_list
	FROM sales
	GROUP BY 1
)

, fourth_block AS --more info soon
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

, fifth_block AS --need a remake 7
(
	SELECT 
		customer_id
		, DATE_TRUNC('month', transaction_date)::DATE 	AS fifth_block_filter_one
		, ROUND(AVG(list_price),2) 						AS AVG_number_of_expenses
		, ROW_number() OVER (
				PARTITION BY customer_id,DATE_TRUNC(
					'month', transaction_date)
				) 										AS fifth_block_filter_two
	FROM sales
	GROUP BY customer_id, DATE_TRUNC('month', transaction_date)
)

, sixth_block AS --need a remake 7
(
	SELECT 
		 customer_id
		,fifth_block_filter_one
		, LAG(AVG_number_of_expenses) OVER(
				PARTITION BY customer_id  
			) / AVG_number_of_expenses 		AS percent_diff
		, (COUNT(*) OVER(
			PARTITION BY customer_id)-1
		  ) 								AS sixth_block_filter
	FROM fifth_block
	WHERE fifth_block_filter_two = 1
)

, seventh_block AS --need a remake 7
(
	SELECT 
		customer_id
		,ROUND(SUM(percent_diff) OVER(
			PARTITION BY customer_id
			)/sixth_block_filter*100,2) AS percentage_growth_of_costs
	FROM sixth_block
	WHERE percent_diff NOTNULL
)

, eighth_block AS --for nineth_block
(
	SELECT 
		customer_id	
		,'2017-12-31'::DATE - MAX(transaction_date) AS R_raw
		, COUNT(*) 			AS F_raw
		, SUM(list_price) 	AS M_raw
	FROM sales
	GROUP BY 1
)

, nineth_block AS --more info soon
(
	SELECT 
		customer_id
	    ,NTILE(5) OVER (ORDER BY R_raw ASC) AS R
		,NTILE(5) OVER (ORDER BY F_raw ASC) AS F
		,NTILE(5) OVER (ORDER BY M_raw ASC) AS M
	FROM eighth_block
)

SELECT 
	fb.id
	, fb.name
	, fb.state
	, fb.property_val
	, fb.age
	, fb.tenure
	, fb.wealth_segment
	, fb.owns_car
	, fb.total_cost
	, fb.total_profit
	, fb.avg_invoice_price
	, fb.count_of_transac
--	, sixb.percentage_growth_of_costs
	, fb.first_transac
	, fb.last_transac
	, fb.year_of_first_purchase
	, sb.favorite_brand
	, sb.brands_count
	, thirdb.brands_list
	, fourthb.sales_by_state
	, fourthb.profit_by_state
	, nb.R
	, nb.F
	, nb.M
FROM first_block fb
LEFT JOIN second_block sb ON fb.id=sb.customer_id
LEFT JOIN third_block thirdb ON fb.id=thirdb.customer_id
LEFT JOIN fourth_block fourthb ON fb.id=fourthb.customer_id
LEFT JOIN nineth_block nb ON fb.id=nb.customer_id
WHERE sb.second_filter_part=1;
