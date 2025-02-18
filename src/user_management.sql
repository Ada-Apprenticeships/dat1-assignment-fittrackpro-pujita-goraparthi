-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members

SELECT 
    member_id,
    first_name,
    last_name,
    email,
    join_date
FROM members;


-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information

UPDATE members
SET email = 'emily.jones.updated@email.com', phone_number = '555-9876'
WHERE member_id = 5;

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members

SELECT 
    COUNT(*) AS total_members 
FROM members;

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations

WITH registration_counts AS (
    SELECT 
        m.member_id,
        m.first_name,
        m.last_name,
        COUNT(ca.schedule_id) AS registration_count
    FROM members m
    JOIN class_attendance ca 
        ON m.member_id = ca.member_id
    WHERE ca.attendance_status = 'Registered'  
    GROUP BY m.member_id
)
SELECT *
FROM registration_counts
WHERE registration_count = (SELECT MAX(registration_count) FROM registration_counts);

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

SELECT 
    m.member_id,
    m.first_name,
    m.last_name,
    COUNT(ca.schedule_id) AS registration_count
FROM members m
JOIN class_attendance ca 
    ON m.member_id = ca.member_id
WHERE ca.attendance_status = 'Registered'
GROUP BY m.member_id
HAVING registration_count = (
    SELECT MIN(class_count)
    FROM (
        SELECT COUNT(schedule_id) AS class_count
        FROM class_attendance
        WHERE attendance_status = 'Registered'
        GROUP BY member_id
    )
);


-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class

SELECT 
    (COUNT(DISTINCT member_id) * 100.0 / (SELECT COUNT(*) FROM members)) AS attendance_percentage
FROM class_attendance
WHERE attendance_status = 'Attended';