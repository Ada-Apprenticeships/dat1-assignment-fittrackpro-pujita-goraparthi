-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support

-- Payment Management Queries

-- 1. Record a payment for a membership
-- TODO: Write a query to record a payment for a membership

INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (11, 50, CURRENT_TIMESTAMP, 'Credit Card', 'Monthly membership fee');

-- 2. Calculate total revenue from membership fees for each month of the last year
-- TODO: Write a query to calculate total revenue from membership fees for each month of the current year

WITH months AS (
    SELECT 'January' AS month_name, '01' AS month_number UNION ALL
    SELECT 'February', '02' UNION ALL
    SELECT 'March', '03' UNION ALL
    SELECT 'April', '04' UNION ALL
    SELECT 'May', '05' UNION ALL
    SELECT 'June', '06' UNION ALL
    SELECT 'July', '07' UNION ALL
    SELECT 'August', '08' UNION ALL
    SELECT 'September', '09' UNION ALL
    SELECT 'October', '10' UNION ALL
    SELECT 'November', '11' UNION ALL
    SELECT 'December', '12'
)
SELECT 
    m.month_name,
    IFNULL(SUM(p.amount), 0) AS total_revenue  
FROM months m
LEFT JOIN payments p 
    ON strftime('%m', p.payment_date) = m.month_number 
    AND strftime('%Y', p.payment_date) = strftime('%Y', date('now', '-1 year'))  
GROUP BY m.month_name, m.month_number  
ORDER BY m.month_number;  

-- 3. Find all day pass purchases
-- TODO: Write a query to find all day pass purchases

SELECT  
    payment_id,
    amount,
    payment_date,
    payment_method
    FROM payments
    WHERE payment_type = 'Day pass';
