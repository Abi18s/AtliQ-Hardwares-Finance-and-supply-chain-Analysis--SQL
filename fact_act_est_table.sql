CREATE TABLE fact_act_est (
SELECT 
	s.date as date,
    s.customer_code as customer_code,
    s.product_code as product_code,
    s.sold_quantity as sold_quantity,
	f.forecast_quantity as forecast_quantity
FROM fact_sales_monthly s
LEFT JOIN fact_forecast_monthly f
USING(date,customer_code,product_code)

UNION

SELECT 
	f.date as date,
    f.customer_code as customer_code,
    f.product_code as product_code,
    s.sold_quantity as sold_quantity,
	f.forecast_quantity as forecast_quantity
FROM fact_forecast_monthly f
LEFT JOIN fact_sales_monthly s
USING(date,customer_code,product_code)
);