-- Croma India MOnth-wise total gross price
-- date
-- gross_price_total


SELECT
	f.date,
    ROUND(SUM(g.gross_price*f.sold_quantity),2) AS gross_price_total
FROM fact_sales_monthly f
JOIN fact_gross_price g
ON g.product_code = f.product_code AND
g.fiscal_year = get_fiscal_year(f.date)
WHERE customer_code = '90002002'
GROUP BY f.date
ORDER BY f.date;