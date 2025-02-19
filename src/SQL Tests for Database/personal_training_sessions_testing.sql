-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid personal training session
INSERT INTO personal_training_sessions (member_id, staff_id, session_date, start_time, end_time, notes)
VALUES (14, 2, '2025-02-25', '09:00:00', '10:00:00', 'Strength training session');
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a session where end_time is before start_time
INSERT INTO personal_training_sessions (member_id, staff_id, session_date, start_time, end_time, notes)
VALUES (15, 3, '2025-02-26', '18:00:00', '17:30:00', 'Incorrect timing session');
-- EXPECTED OUTPUT: Error due to CHECK(end_time > start_time).

-- BOUNDARY TEST: Insert a session with a 1-minute duration
INSERT INTO personal_training_sessions (member_id, staff_id, session_date, start_time, end_time, notes)
VALUES (16, 4, '2025-02-27', '07:00:00', '07:01:00', 'Short session');
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert a session with a wrongly formatted date
INSERT INTO personal_training_sessions (member_id, staff_id, session_date, start_time, end_time, notes)
VALUES (17, 5, 'NotADate', '10:00:00', '11:00:00', 'Incorrect date type test');
-- EXPECTED OUTPUT: Error due to CHECK(CHECK(session_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]').

-- ABSENT DATA TEST: Insert a session without specifying a notes field
INSERT INTO personal_training_sessions (member_id, staff_id, session_date, start_time, end_time)
VALUES (18, 6, '2025-02-28', '12:00:00', '13:00:00');
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on notes.