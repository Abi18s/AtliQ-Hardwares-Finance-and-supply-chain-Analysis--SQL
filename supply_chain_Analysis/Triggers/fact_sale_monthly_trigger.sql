CREATE DEFINER = CURRENT_USER TRIGGER `gdb0041`.`fact_sales_monthly_AFTER_INSERT` AFTER INSERT ON `fact_sales_monthly` FOR EACH ROW
BEGIN
INSERT INTO fact_act_est (date,product_code,customer_code,sold_quantity)
VALUES (NEW.date,
		NEW.product_code,
        NEW.customer_code,
        NEW.sold_quantity
        )
ON DUPLICATE KEY UPDATE
sold_quantity = VALUES (sold_quantity);
END
