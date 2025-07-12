WITH total_costs AS --total purchase per person
(
	SELECT 
		DISTINCT customer_id
		, SUM(list_price) OVER(PARTITION BY customer_id) AS sum_costs
	FROM sales
) 

, avg_invoice AS --average list price per person
(
	SELECT 
		DISTINCT customer_id
		, ROUND(AVG(list_price) OVER(PARTITION BY customer_id),2) as average_invoice
	FROM sales
)

, trans_count AS --transactions count per person
(
	SELECT 	
		DISTINCT customer_id
		, COUNT(*) OVER(PARTITION BY customer_id) as transaction_count
	FROM sales
)

, first_and_last_transaction AS --earliest and latest transactions per person
(
	SELECT 
		DISTINCT customer_id
		,MIN(transaction_date) OVER(PARTITION BY customer_id) AS min_transaction_date
		,MAX(transaction_date) OVER(PARTITION BY customer_id) AS max_transaction_date
	FROM sales
)

, avg_profit_by_month AS --AVG profit from one customer by month 
(
SELECT 
	DISTINCT customer_id
	, ROUND(AVG(profit) OVER(PARTITION BY customer_id),2) as average_profit_by_month
	, ROW_NUMBER() OVER(PARTITION BY customer_id) AS filter
FROM sales
ORDER BY 1, 3
)

, interval AS --interval between purchases one person
(
SELECT 
	customer_id
	, transaction_date
	, COALESCE(
		lag(transaction_date) OVER(
			PARTITION BY customer_id 
			ORDER BY transaction_date ASC)
	 	,transaction_date
	) AS previous_date
	, transaction_date - 
	  lag(transaction_date) OVER(
		PARTITION BY customer_id 
		ORDER BY transaction_date ASC
	) AS day_diff
FROM sales
order by 1, 2
)

SELECT 
	 Distinct tc.customer_id
	, c.first_name
	, c.last_name
	, tc.sum_costs
	, ai.average_invoice AS avg_invoice
	, trc.transaction_count 
	, flt.min_transaction_date
	, flt.max_transaction_date
	, apbm.average_profit_by_month
	, SUM(i.day_diff) OVER(PARTITION BY tc.customer_id)/trc.transaction_count AS avg_day_diff
FROM customers c
JOIN total_costs tc   			     USING(customer_id)
JOIN avg_invoice ai   		 		 USING(customer_id)
JOIN trans_count trc    	 		 USING(customer_id)
JOIN first_and_last_transaction flt  USING(customer_id)
JOIN avg_profit_by_month apbm 		 USING(customer_id)
JOIN interval i 			 		 USING(customer_id)
WHERE apbm.filter=1;



