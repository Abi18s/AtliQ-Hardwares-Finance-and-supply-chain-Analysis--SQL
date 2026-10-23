CREATE DEFINER=`root`@`localhost` PROCEDURE `Market_badge`(
IN in_market VARCHAR(45),
IN in_fiscal_year YEAR,
OUT out_market_badge VARCHAR(45)
)
BEGIN
	DECLARE total_quantity INT DEFAULT 0;
    IF in_market ="" THEN
		SET in_market = "India";
	END IF;
SELECT
	SUM(sold_quantity) INTO total_quantity
	
FROM fact_sales_monthly f
JOIN dim_customer c
ON c.customer_code = f.customer_code
WHERE get_fiscal_year(f.date) = in_fiscal_year AND 
		market  = in_market
GROUP BY Market;
IF  total_quantity > 5000000 THEN
	SET out_market_badge = "Gold";
ELSE 
	SET out_market_badge = "Silver";
END IF;
END