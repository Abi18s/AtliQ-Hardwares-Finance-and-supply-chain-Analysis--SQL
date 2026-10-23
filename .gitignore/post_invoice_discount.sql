SELECT pre.date,
	   pre.customer_code,
       pre.market,
       pre.product_code,
       pre.product,
       pre.variant,
       pre.sold_quantity,
       pre.gross_price,
       pre.total_gross_price,
       pre.pre_invoice_discount_pct,
	   ROUND((1-pre_invoice_discount_pct)*total_gross_price, 2) AS net_invoice_sales,
       po.other_deductions_pct+ po.discounts_pct AS post_invoice_discount
       
FROM sales_pre_invoice_dct pre
JOIN fact_post_invoice_deductions po
ON po.customer_code = pre.customer_code AND 
   po.product_code = pre.product_code AND
   po.date = pre.date;