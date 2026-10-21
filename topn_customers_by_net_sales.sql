CREATE DEFINER=`root`@`localhost` PROCEDURE `get_topn_customers_by_netsales`(
in_fiscal_year INT,
in_top_n INT
)
BEGIN
SELECT 
	customer,
    ROUND(SUM(net_sales)/1000000,2) AS net_sales_mln
 FROM gdb0041.net_sales
 WHERE fiscal_year = in_fiscal_year
 GROUP BY customer
 ORDER BY net_sales_mln DESC
 LIMIT in_top_n;
END