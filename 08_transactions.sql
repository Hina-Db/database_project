
-- ==========================================
-- CROWNFIELD EYE HOSPITAL
-- PART D3: TRANSACTION MANAGEMENT
-- ==========================================

USE crownfield_eye_hospital;

-- ==========================================
-- TEST 1: CHECK ORIGINAL RECORDS
-- ==========================================

SELECT
    appointment_id,
    patient_id,
    notes
FROM APPOINTMENT
WHERE appointment_id IN (7, 8);


-- ==========================================
-- TEST 2: ROLLBACK TRANSACTION
-- ==========================================

-- Start transaction

START TRANSACTION;

-- Make a temporary change to appointment 7

UPDATE APPOINTMENT
SET notes = 'ROLLBACK TEST - TEMPORARY CHANGE'
WHERE appointment_id = 7;

-- View the temporary change

SELECT appointment_id, notes
FROM APPOINTMENT
WHERE appointment_id = 7;

-- Cancel the transaction

ROLLBACK;

-- Confirm that the original value has returned

SELECT appointment_id, notes
FROM APPOINTMENT
WHERE appointment_id = 7;


-- ==========================================
-- TEST 3: COMMIT TRANSACTION
-- ==========================================

START TRANSACTION;

-- Change synthetic appointment 8

UPDATE APPOINTMENT
SET notes = 'COMMIT TEST - CHANGE SAVED'
WHERE appointment_id = 8;

-- View the change before committing

SELECT appointment_id, notes
FROM APPOINTMENT
WHERE appointment_id = 8;

-- Permanently save the change

COMMIT;

-- Confirm that the change was saved

SELECT appointment_id, notes
FROM APPOINTMENT
WHERE appointment_id = 8;


-- ==========================================
-- TEST 4: CLEAN UP SYNTHETIC TEST DATA
-- Execute after taking your screenshots
-- ==========================================

START TRANSACTION;

UPDATE APPOINTMENT
SET notes = 'SYNTHETIC TEST RECORD'
WHERE appointment_id = 8;

COMMIT;

-- Confirm original synthetic note restored

SELECT appointment_id, notes
FROM APPOINTMENT
WHERE appointment_id = 8;

-- END OF TRANSACTION TESTING
