-- if total_sold_quantity > 5M then market badge -gold else silver
-- input
-- market
-- fiscal year
-- output
-- martket badge

select 
	market,
	SUM(sold_quantity) AS total_quantity,
    CASE 
		WHEN SUM(sold_quantity) > 5000000 THEN "Gold"
        ELSE "Silver"
	END AS market_badge
        
	
FROM fact_sales_monthly f
JOIN dim_customer c
ON c.customer_code = f.customer_code
WHERE get_fiscal_year(f.date) = 2021
GROUP BY market;
