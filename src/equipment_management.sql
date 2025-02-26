-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support

-- Equipment Management Queries

-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance

SELECT equipment_id,
    name,
    next_maintenance_date
    FROM equipment
    WHERE next_maintenance_date <= date('now', +'+30 days');

-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock

SELECT 
    type AS equipment_type,
    COUNT(*) AS count
FROM equipment
GROUP BY type;    

-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)
-- Calculates the average age of equipment using the difference between the purchase date and the current date.
-- `strftime('%s', 'now')` and `strftime('%s', purchase_date)` convert dates to seconds.
-- Division by 86400 converts seconds into days.

SELECT 
    type AS equipment_type,
    AVG((strftime('%s', 'now') - strftime('%s', purchase_date)) / 86400.0) AS avg_age_days
FROM equipment
GROUP BY type;