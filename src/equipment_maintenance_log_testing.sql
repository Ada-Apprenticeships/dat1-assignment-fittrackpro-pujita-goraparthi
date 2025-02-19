-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid maintenance log entry
INSERT INTO equipment_maintenance_log (equipment_id, maintenance_date, description, staff_id)
VALUES (11, DATE('now', '-2 days'), 'General maintenance and tuning', 3);
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a maintenance log with a future maintenance date
INSERT INTO equipment_maintenance_log (equipment_id, maintenance_date, description, staff_id)
VALUES (12, DATE('now', '+1 day'), 'Unexpected future maintenance', 4);
-- EXPECTED OUTPUT: Error due to CHECK(maintenance_date <= CURRENT_DATE).

-- BOUNDARY TEST: Insert a maintenance entry with maintenance date as today
INSERT INTO equipment_maintenance_log (equipment_id, maintenance_date, description, staff_id)
VALUES (13, DATE('now'), 'Todays routine check', 5);
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert a maintenance log with an empty description 
INSERT INTO equipment_maintenance_log (equipment_id, maintenance_date, description, staff_id)
VALUES (14, DATE('now', '-1 day'),NULL, 6);
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on description.

-- ABSENT DATA TEST: Insert a maintenance log with a NULL staff_id
INSERT INTO equipment_maintenance_log (equipment_id, maintenance_date, description)
VALUES (15, DATE('now', '-3 days'), 'Console recalibration');
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on staff_id.