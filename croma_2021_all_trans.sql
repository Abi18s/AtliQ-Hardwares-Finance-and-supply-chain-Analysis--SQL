-- Croma India product wise sales report for fiscal_year 2021
-- Month
-- product name
-- Variant
-- Sold Quantity
-- Gross Price per item
-- Gross price total

 SELECT date,
		p.product,
        p.variant,
       sold_quantity,
       g.gross_price,
       ROUND(g.gross_price*sold_quantity, 2) AS total_gross_price
FROM fact_sales_monthly f
JOIN dim_product p
ON p.product_code = f.product_code
JOIN fact_gross_price g
ON g.product_code = f.product_code and g.fiscal_year = get_fiscal_year(f.date)
WHERE customer_code = '90002002' AND get_fiscal_year(f.date) = 2021
ORDER BY date 
 ;