CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `net_sales` AS
    SELECT 
        `post_invoice_discount`.`date` AS `date`,
        `post_invoice_discount`.`customer_code` AS `customer_code`,
        `post_invoice_discount`.`customer` AS `customer`,
        `post_invoice_discount`.`market` AS `market`,
        `post_invoice_discount`.`product_code` AS `product_code`,
        `post_invoice_discount`.`product` AS `product`,
        `post_invoice_discount`.`variant` AS `variant`,
        `post_invoice_discount`.`sold_quantity` AS `sold_quantity`,
        `post_invoice_discount`.`gross_price` AS `gross_price`,
        `post_invoice_discount`.`total_gross_price` AS `total_gross_price`,
        `post_invoice_discount`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        `post_invoice_discount`.`net_invoice_sales` AS `net_invoice_sales`,
        `post_invoice_discount`.`post_invoice_discount` AS `post_invoice_discount`,
        ROUND(((1 - `post_invoice_discount`.`post_invoice_discount`) * `post_invoice_discount`.`net_invoice_sales`),
                2) AS `net_sales`
    FROM
        `post_invoice_discount`