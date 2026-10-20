CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `post_invoice_discount` AS
    SELECT 
        `pre`.`date` AS `date`,
        `pre`.`customer_code` AS `customer_code`,
        `pre`.`customer` AS `customer`,
        `pre`.`market` AS `market`,
        `pre`.`product_code` AS `product_code`,
        `pre`.`product` AS `product`,
        `pre`.`variant` AS `variant`,
        `pre`.`sold_quantity` AS `sold_quantity`,
        `pre`.`gross_price` AS `gross_price`,
        `pre`.`total_gross_price` AS `total_gross_price`,
        `pre`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        ROUND(((1 - `pre`.`pre_invoice_discount_pct`) * `pre`.`total_gross_price`),
                2) AS `net_invoice_sales`,
        (`po`.`other_deductions_pct` + `po`.`discounts_pct`) AS `post_invoice_discount`
    FROM
        (`sales_pre_invoice_dct` `pre`
        JOIN `fact_post_invoice_deductions` `po` ON (((`po`.`customer_code` = `pre`.`customer_code`)
            AND (`po`.`product_code` = `pre`.`product_code`)
            AND (`po`.`date` = `pre`.`date`))))