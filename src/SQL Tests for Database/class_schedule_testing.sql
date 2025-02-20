-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid class schedule entry
INSERT INTO class_schedule (class_id, staff_id, start_time, end_time)
VALUES (1, 1, '2025-03-10 10:00:00', '2025-03-10 11:00:00');
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a schedule where end_time is before start_time
INSERT INTO class_schedule (class_id, staff_id, start_time, end_time)
VALUES (2, 2, '2025-03-15 18:00:00', '2025-03-15 17:45:00');
-- EXPECTED OUTPUT: Error due to CHECK(end_time > start_time).

-- BOUNDARY TEST: Insert a class with a 1-minute duration
INSERT INTO class_schedule (class_id, staff_id, start_time, end_time)
VALUES (3, 6, '2025-03-20 07:00:00', '2025-03-20 07:01:00');
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert a schedule with an invalid date format
INSERT INTO class_schedule (class_id, staff_id, start_time, end_time)
VALUES (4, 4, 'INVALID_DATE', 'INVALID_DATE');
-- Since 'INVALID_DATE' does not represent a valid DATETIME, SQLite treats it as NULL, 
-- and the constraint check fails because NULL > NULL is not valid.
-- EXPECTED OUTPUT: Error due to incorrect DATETIME format and CHECK constraint failing (NULL > NULL is invalid).

-- ABSENT DATA TEST: Insert a schedule without specifying an end_time
INSERT INTO class_schedule (class_id, staff_id, start_time)
VALUES (5, 8, '2025-04-01 19:00:00');
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on end_time.