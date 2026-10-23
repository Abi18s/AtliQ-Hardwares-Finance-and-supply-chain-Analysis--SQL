WITH forecast_acc_2020_2021 AS (SELECT a.customer_code,
		c.customer,
        c.market,
		ROUND(100- 100*SUM(CASE WHEN fiscal_year = 2020 THEN ABS(forecast_quantity - sold_quantity) ELSE 0 END)
        / NULLIF(SUM(CASE WHEN fiscal_year = 2020 THEN forecast_quantity ELSE 0 END),0) ,2) 
	
		AS forecast_accuracy_2020,
		ROUND(100- 100*SUM(CASE WHEN fiscal_year = 2021 THEN ABS(forecast_quantity - sold_quantity) ELSE 0 END)
        / NULLIF(SUM(CASE WHEN fiscal_year = 2021 THEN forecast_quantity ELSE 0 END),0) ,2) 
	
		AS forecast_accuracy_2021
 FROM gdb0041.fact_act_est a
 JOIN dim_customer c
 ON c.customer_code = a.customer_code
 GROUP BY a.customer_code),
 forecast_acc AS (
 SELECT customer_code,
		customer,
        market,
        IF( forecast_accuracy_2020 > 0 , forecast_accuracy_2020 , 0) AS forecast_acc_2020,
        IF( forecast_accuracy_2021 > 0 , forecast_accuracy_2021 , 0) AS forecast_acc_2021
        
 FROM forecast_acc_2020_2021)
 SELECT * ,
		(forecast_acc_2021-forecast_acc_2020) AS YOY_acc
 
 FROM forecast_acc
 WHERE (forecast_acc_2021-forecast_acc_2020) < 0
 ORDER BY YOY_acc ASC
 ;