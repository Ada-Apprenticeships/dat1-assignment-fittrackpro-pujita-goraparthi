-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer
-- Joins `personal_training_sessions` with `staff` to get trainer details.
-- Joins `members` to retrieve the name of the member attending the session.
-- Uses `WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin'` to filter sessions for the specific trainer.

SELECT 
    pt.session_id,
    m.first_name || ' ' || m.last_name AS member_name,
    pt.session_date,
    pt.start_time,
    pt.end_time
FROM personal_training_sessions pt
JOIN staff s ON pt.staff_id = s.staff_id
JOIN members m ON pt.member_id = m.member_id
WHERE s.first_name = 'Ivy' AND s.last_name = 'Irwin';
