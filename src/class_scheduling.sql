-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors
-- Uses the `class_schedule` table to associate classes with staff members.

SELECT 
    c.class_id,
    c.name AS class_name,
    s.first_name || ' ' || s.last_name AS instructor_name
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN staff s ON cs.staff_id = s.staff_id;


-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date
-- LEFT JOIN ensures all scheduled classes appear, even if no one is registered yet.
-- `HAVING available_spots > 0` ensures full classes are excluded.

SELECT 
    c.class_id,
    c.name,  
    cs.start_time,
    cs.end_time,
    c.capacity - COUNT(ca.member_id) AS available_spots
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
LEFT JOIN class_attendance ca 
    ON cs.schedule_id = ca.schedule_id 
    AND ca.attendance_status = 'Registered'
WHERE cs.start_time BETWEEN '2025-02-01 00:00:00' AND '2025-02-01 23:59:59'
GROUP BY c.class_id, cs.start_time, cs.end_time, c.capacity
HAVING available_spots > 0
ORDER BY cs.start_time;


-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class
-- Ensures the member isn't already registered for the class using `NOT EXISTS`.
-- Uses `LIMIT 1` to register the member for only one matching class instance.

INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
SELECT schedule_id, 11, 'Registered'
FROM class_schedule
WHERE class_id = 3 
AND start_time BETWEEN '2025-02-01 00:00:00' AND '2025-02-01 23:59:59'
AND NOT EXISTS (
    SELECT 1 FROM class_attendance 
    WHERE member_id = 11 
    AND schedule_id = (
        SELECT schedule_id 
        FROM class_schedule 
        WHERE class_id = 3 
        AND start_time BETWEEN '2025-02-01 00:00:00' AND '2025-02-01 23:59:59'
    )
)
LIMIT 1;



-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration

DELETE FROM class_attendance
WHERE member_id = 2 AND schedule_id = 7;


-- 5. List top 3 most popular classes
-- TODO: Write a query to list top 3 most popular classes
-- Uses `ORDER BY registration_count DESC` to rank classes by popularity.

SELECT 
    cs.class_id,
    c.name AS class_name,
    COUNT(ca.member_id) AS registration_count
FROM class_schedule cs
JOIN classes c ON cs.class_id = c.class_id
JOIN class_attendance ca 
    ON cs.schedule_id = ca.schedule_id
    AND ca.attendance_status = 'Registered'
GROUP BY cs.class_id, c.name
ORDER BY registration_count DESC
LIMIT 3;



-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member
-- Uses `CAST()` to ensure float division rather than integer division.

SELECT 
    CAST(COUNT(ca.member_id) AS FLOAT) / (SELECT COUNT(*) FROM members) AS avg_classes_per_member
FROM class_attendance ca;
