-- Initial SQLite setup
.open fittrackpro.sqlite
.mode column

-- Enable foreign key support

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships

SELECT 
    m.member_id,
    m.first_name,
    m.last_name,
    mem.type AS membership_type,
    mem.start_date,
    mem.end_date
FROM memberships mem
JOIN members m ON mem.member_id = m.member_id
WHERE mem.status = 'Active';

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type

SELECT 
    mem.type AS membership_type,
    AVG(
        (strftime('%s', a.check_out_time) - strftime('%s', a.check_in_time)) / 3600.0
    ) AS avg_visit_duration_hours
FROM memberships mem
JOIN members m ON mem.member_id = m.member_id
JOIN attendance a ON m.member_id = a.member_id
GROUP BY mem.type;


-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year

SELECT 
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    mem.end_date
FROM memberships mem
JOIN members m ON mem.member_id = m.member_id
WHERE strftime('%Y', mem.end_date) = strftime('%Y', 'now')
AND mem.status = 'Active';