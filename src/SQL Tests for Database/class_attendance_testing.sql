-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid class attendance record
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (5, 6, 'Registered');
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a class attendance record with an invalid attendance status
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (6, 7, 'Late');
-- EXPECTED OUTPUT: Error due to CHECK(attendance_status IN ('Registered', 'Attended', 'Unattended')).

-- BOUNDARY TEST: Insert a class attendance record where a member has attended multiple sessions
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (3, 1, 'Attended');
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert a class attendance record with an invalid attendance status
INSERT INTO class_attendance (schedule_id, member_id, attendance_status)
VALUES (1, 5, 'Late');
-- EXPECTED OUTPUT: Error due to CHECK(attendance_status IN ('Registered', 'Attended', 'Unattended')).

-- ABSENT DATA TEST: Insert a class attendance record without specifying an attendance_status
INSERT INTO class_attendance (schedule_id, member_id)
VALUES (4, 6);
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on attendance_status.