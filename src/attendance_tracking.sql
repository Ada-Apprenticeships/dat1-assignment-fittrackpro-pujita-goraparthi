-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit

INSERT INTO attendance (member_id, location_id, check_in_time, check_out_time)
VALUES 
(7, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history

SELECT 
    a.check_in_time,
    a.check_out_time
FROM attendance a
WHERE a.member_id = 5;

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits

SELECT 
    strftime('%w', check_in_time) AS day_of_week,
    COUNT(*) AS visit_count
FROM attendance
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1;

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location
SELECT 
    l.name AS location_name,
    AVG(daily_visits) AS avg_daily_attendance
FROM locations l
JOIN attendance a ON l.location_id = a.location_id
JOIN (
    SELECT 
        location_id,
        strftime('%Y-%m-%d', check_in_time) AS visit_date,
        COUNT(*) AS daily_visits
    FROM attendance
    GROUP BY location_id, visit_date
) AS daily_attendance ON l.location_id = daily_attendance.location_id
GROUP BY l.location_id;
