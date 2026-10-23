SELECT date,
	   f.fiscal_year,
       f.customer_code,
	   c.customer,
       c.market,
       f.product_code,
       p.product,
       p.variant,
       f.sold_quantity,
       g.gross_price,
       ROUND(f.sold_quantity*g.gross_price,2) AS total_gross_price
	
 FROM gdb0041.fact_sales_monthly f
 JOIN dim_product p
 ON p.product_code = f.product_code
 JOIN dim_customer c
 ON c.customer_code = f.customer_code
 JOIN fact_gross_price g
 ON g.product_code = f.product_code AND
    g.fiscal_year = f.fiscal_year
 ;