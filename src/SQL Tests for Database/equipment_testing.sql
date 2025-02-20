-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid equipment entry
INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES ('Rowing Machine 3', 'Cardio', '2024-10-01', '2024-11-01', '2025-02-01', 1);
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert equipment with a purchase date in the future
INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES ('Future Equipment', 'Cardio', DATE('now', '+1 day'), '2025-01-01', '2025-04-01', 1);
-- EXPECTED OUTPUT: Error due to CHECK(purchase_date <= CURRENT_DATE).

-- BOUNDARY TEST: Insert equipment where the next maintenance date is exactly one day after last maintenance
INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES ('Boundary Equipment', 'Strength', '2024-11-01', '2024-12-01', '2024-12-02', 2);
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert equipment with an invalid type
INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date, location_id)
VALUES ('Invalid Type Equipment', 'Aerobic', '2024-10-15', '2024-11-15', '2025-03-15', 1);
-- EXPECTED OUTPUT: Error due to CHECK(type IN ('Cardio', 'Strength')).

-- ABSENT DATA TEST: Insert equipment without specifying a location_id
INSERT INTO equipment (name, type, purchase_date, last_maintenance_date, next_maintenance_date)
VALUES ('Missing Location Equipment', 'Strength', '2024-09-01', '2024-11-01', '2025-02-01');
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on location_id.