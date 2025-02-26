-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- Enable foreign key support

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships

SELECT 
    m.member_id,
    m.first_name,
    m.last_name,
    mem.type AS membership_type,
    m.join_date
FROM memberships mem
JOIN members m ON mem.member_id = m.member_id
WHERE mem.status = 'Active';


-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type
-- `strftime('%s', check_out_time) - strftime('%s', check_in_time)` converts timestamps to seconds and finds the duration.
-- Division by 60 converts the result into minutes.

SELECT 
    mem.type AS membership_type,
    AVG(strftime('%s', a.check_out_time) - strftime('%s', a.check_in_time)) / 60.0 AS avg_visit_duration_minutes
FROM attendance a
JOIN members m ON a.member_id = m.member_id
JOIN memberships mem ON m.member_id = mem.member_id
GROUP BY mem.type;


-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year
-- Retrieves all members whose memberships are set to expire before the end of the current year.
-- Uses `strftime('%Y', 'now') || '-12-31'` to dynamically get December 31 of the current year.

SELECT 
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    mem.end_date
FROM memberships mem
JOIN members m ON mem.member_id = m.member_id
WHERE mem.status = 'Active'  
AND mem.end_date BETWEEN date('now') AND date(strftime('%Y', 'now') || '-12-31');
