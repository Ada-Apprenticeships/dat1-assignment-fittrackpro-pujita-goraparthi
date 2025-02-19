-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit
-- Check-out time is NULL, indicating the member is currently at the gym

INSERT INTO attendance (member_id, location_id, check_in_time, check_out_time)
VALUES (7, 1, CURRENT_TIMESTAMP, NULL);

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history
-- Orders by check-in time in descending order to show the most recent visits first.

SELECT 
    DATE(check_in_time) AS visit_date,  
    check_in_time,
    check_out_time
FROM attendance
WHERE member_id = 5
ORDER BY check_in_time DESC;  


-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits
-- `strftime('%w', check_in_time)` extracts the day of the week (0 = Sunday, 6 = Saturday).
-- `CASE` converts numeric values to their corresponding weekday names.

SELECT 
    CASE strftime('%w', check_in_time)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS day_of_week,
    COUNT(*) AS visit_count
FROM attendance
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1;


-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location
-- Uses a subquery to first count the number of visits per day (`daily_visits`).
-- The outer query calculates the average daily visits per location.

SELECT 
    l.name AS location_name,
    AVG(daily_visits) AS avg_daily_attendance
FROM locations l
JOIN (
    SELECT 
        a.location_id,
        DATE(a.check_in_time) AS visit_date,
        COUNT(*) AS daily_visits
    FROM attendance a
    GROUP BY a.location_id, visit_date
) AS daily_attendance ON l.location_id = daily_attendance.location_id
GROUP BY l.name;
