-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support

-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role
-- Retrieves all staff members and their positions, ordered by role.
-- Sorting by position ensures trainers, managers, receptionists, and maintenance staff are grouped together.

SELECT 
    staff_id, 
    first_name, 
    last_name, 
    position AS role
FROM staff
ORDER BY position;


-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days
-- Uses `date('now') AND date('now', '+30 days')` to limit results to future sessions.
-- `HAVING session_count > 0` ensures only trainers with scheduled sessions appear.

SELECT 
    s.staff_id AS trainer_id,
    s.first_name || ' ' || s.last_name AS trainer_name,
    COUNT(pt.session_id) AS session_count
FROM personal_training_sessions pt
JOIN staff s ON pt.staff_id = s.staff_id
WHERE s.position = 'Trainer'
AND pt.session_date BETWEEN date('now') AND date('now', '+30 days')
GROUP BY s.staff_id, trainer_name
HAVING session_count > 0
ORDER BY session_count DESC;