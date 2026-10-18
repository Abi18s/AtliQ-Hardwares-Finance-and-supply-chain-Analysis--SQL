-- Generate a yearly report for Croma India where there are two columns
-- 1. Fiscal Year
-- 2. Total Gross Sales amount In that year from Croma

SELECT 
	get_fiscal_year(f.date) AS fiscal_year,
    ROUND(SUM(g.gross_price*f.sold_quantity),2) AS gross_price_total
FROM fact_sales_monthly f
JOIN fact_gross_price g
ON g.product_code = f.product_code AND
g.fiscal_year = get_fiscal_year(f.date)
WHERE f.customer_code = '90002002'
GROUP BY get_fiscal_year(f.date);