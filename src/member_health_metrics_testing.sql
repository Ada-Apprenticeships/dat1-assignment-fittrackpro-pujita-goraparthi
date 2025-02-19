-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid health metric entry
INSERT INTO member_health_metrics (member_id, measurement_date, weight, body_fat_percentage, muscle_mass, bmi)
VALUES (11, DATE('now', '-1 day'), 70.5, 22.0, 35.0, 23.5);
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a measurement where the date is in the future
INSERT INTO member_health_metrics (member_id, measurement_date, weight, body_fat_percentage, muscle_mass, bmi)
VALUES (12, DATE('now', '+1 day'), 75.0, 20.0, 38.0, 24.0);
-- EXPECTED OUTPUT: Error due to CHECK(measurement_date <= CURRENT_DATE).

-- BOUNDARY TEST: Insert a measurement rounded to one decimal place
INSERT INTO member_health_metrics (member_id, measurement_date, weight, body_fat_percentage, muscle_mass, bmi)
VALUES (13, DATE('now'), 70.5, 22.0, 35.0, 23.5);
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert a measurement with a non-rounded weight
INSERT INTO member_health_metrics (member_id, measurement_date, weight, body_fat_percentage, muscle_mass, bmi)
VALUES (14, DATE('now', '-1 day'), 70.555, 22.0, 35.0, 23.5);
-- EXPECTED OUTPUT: Error due to CHECK(weight = ROUND(weight,1)).

-- ABSENT DATA TEST: Insert a measurement with NULL muscle_mass
INSERT INTO member_health_metrics (member_id, measurement_date, weight, body_fat_percentage, bmi)
VALUES (15, DATE('now', '-1 day'), 72.0, 21.0, 23.0);
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on muscle_mass.