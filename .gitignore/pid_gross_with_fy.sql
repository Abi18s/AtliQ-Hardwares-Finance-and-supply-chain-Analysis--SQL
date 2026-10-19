
SELECT  f.fiscal_year,
		f.customer_code,
        c.market,
        f.product_code,
		p.product,
        p.variant,
       sold_quantity,
       g.gross_price,
       ROUND(g.gross_price*sold_quantity, 2) AS total_gross_price,
       pre.pre_invoice_discount_pct
FROM fact_sales_monthly f
JOIN dim_product p
ON p.product_code = f.product_code
JOIN dim_customer c
ON c.customer_code = f.customer_code 
JOIN fact_gross_price g
ON g.product_code = f.product_code AND 
   g.fiscal_year = f.fiscal_year
JOIN fact_pre_invoice_deductions pre
ON pre.customer_code = f.customer_code AND
   pre.fiscal_year = f.fiscal_year
 ;