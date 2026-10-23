CREATE DEFINER=`root`@`localhost` FUNCTION `get_fiscal_quarters`(
calendar_date DATE
) RETURNS varchar(2) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
DECLARE fiscal_quarters VARCHAR(2);
DECLARE m INT ;
SET m = MONTH(calendar_date);

IF m IN (9,10,11) THEN
	SET fiscal_quarters = 'Q1';
ELSEIF m IN (12,1,2) THEN
	SET fiscal_quarters = 'Q2';
ELSEIF m IN (3,4,5) THEN
	SET fiscal_quarters = 'Q3';
ELSEIF m IN (6,7,8) THEN
	SET fiscal_quarters = 'Q4';
END IF ;
RETURN fiscal_quarters;
END