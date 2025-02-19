-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid membership
INSERT INTO memberships (member_id, type, start_date, end_date, status)
VALUES (16, 'Premium', '2024-10-01', '2025-10-01', 'Active');
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a membership where the start date is in the future
INSERT INTO memberships (member_id, type, start_date, end_date, status)
VALUES (17, 'Basic', DATE('now', '+1 year'), DATE('now', '+2 years'), 'Active');
-- EXPECTED OUTPUT: Error due to CHECK(start_date <= CURRENT_DATE).

-- BOUNDARY TEST: Insert a membership where the start date is exactly today
INSERT INTO memberships (member_id, type, start_date, end_date, status)
VALUES (18, 'Basic', DATE('now'), DATE('now', '+1 year'), 'Active');
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert a membership with an invalid type
INSERT INTO memberships (member_id, type, start_date, end_date, status)
VALUES (19, 'Gold', '2024-10-01', '2025-10-01', 'Active');
-- EXPECTED OUTPUT: Error due to CHECK(type IN ('Premium', 'Basic')).

-- ABSENT DATA TEST: Insert a membership with NULL status
INSERT INTO memberships (member_id, type, start_date, end_date)
VALUES (20, 'Premium', '2024-10-01', '2025-10-01');
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on status.