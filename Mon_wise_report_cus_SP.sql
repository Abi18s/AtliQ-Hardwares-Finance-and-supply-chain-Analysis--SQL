CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_total_GP_for_customers`(
 cus_code TEXT
)
BEGIN
SELECT
	f.date,
    ROUND(SUM(g.gross_price*f.sold_quantity),2) AS gross_price_total
FROM fact_sales_monthly f
JOIN fact_gross_price g
ON g.product_code = f.product_code AND
g.fiscal_year = get_fiscal_year(f.date)
WHERE FIND_IN_SET(customer_code, cus_code ) > 0
GROUP BY f.date
ORDER BY f.date;
END