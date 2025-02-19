-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid attendance record
INSERT INTO attendance (member_id, location_id, check_in_time, check_out_time)
VALUES (11, 1, '2025-02-19 09:00:00', '2025-02-19 10:30:00');
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert an attendance record with a check-in time in the future
-- Since 'check_in_time' must be less than or equal to CURRENT_TIMESTAMP, this should fail.
INSERT INTO attendance (member_id, location_id, check_in_time, check_out_time)
VALUES (12, 2, DATE('now', '+2 days') || ' 10:00:00', DATE('now', '+2 days') || ' 11:30:00');
-- EXPECTED OUTPUT: Error due to CHECK(check_in_time <= CURRENT_TIMESTAMP).

-- BOUNDARY TEST: Insert an attendance record with a NULL check-out time (still checked in)
INSERT INTO attendance (member_id, location_id, check_in_time, check_out_time)
VALUES (13, 1, '2025-02-18 08:00:00', NULL);
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert an attendance record where check-out is before check-in
INSERT INTO attendance (member_id, location_id, check_in_time, check_out_time)
VALUES (14, 2, '2025-02-19 18:00:00', '2025-02-19 17:30:00');
-- EXPECTED OUTPUT: Error due to CHECK(check_out_time > check_in_time).

-- ABSENT DATA TEST: Insert an attendance record without specifying a location_id
INSERT INTO attendance (member_id, check_in_time, check_out_time)
VALUES (15, '2025-02-19 14:00:00', '2025-02-19 15:30:00');
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on location_id.