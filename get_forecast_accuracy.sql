CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_accuracy`(
	in_fiscal_year INT
)
BEGIN
WITH error_table AS (SELECT customer_code,
		SUM(sold_quantity) AS total_sold_quantity,
        SUM(forecast_quantity) AS total_forecast_quantity,
		SUM(forecast_quantity-sold_quantity) AS net_error,
        SUM(ABS(forecast_quantity-sold_quantity)) AS abs_error,
        ROUND(SUM((forecast_quantity-sold_quantity))*100/SUM(forecast_quantity),2) AS net_err_pct,
        ROUND(SUM(ABS(forecast_quantity-sold_quantity))*100 /SUM(forecast_quantity),2) AS abs_err_pct
FROM gdb0041.fact_act_est
WHERE fiscal_year = in_fiscal_year
GROUP BY customer_code
)
SELECT e.customer_code,
		c.customer,
        c.market,
        e.total_sold_quantity,
        e.total_forecast_quantity,
        e.net_error,
        e.abs_error,
        e.net_err_pct,
        e.abs_err_pct,
		IF(abs_err_pct>100, 0, (100-abs_err_pct)) AS forecast_accuracy_pct
FROM error_table e
JOIN dim_customer c
ON c.customer_code = e.customer_code
ORDER BY forecast_accuracy_pct DESC;
END