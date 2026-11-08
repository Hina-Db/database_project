
USE crownfield_eye_hospital;

-- =================================
-- TEST 1: UPDATE
-- =================================

-- Check original value
SELECT appointment_id, notes
FROM APPOINTMENT
WHERE appointment_id = 6;

-- Update synthetic appointment
UPDATE APPOINTMENT
SET notes = 'SYNTHETIC TEST RECORD - UPDATED'
WHERE appointment_id = 6;

-- Check updated value
SELECT appointment_id, notes
FROM APPOINTMENT
WHERE appointment_id = 6;


-- =================================
-- TEST 2: DELETE
-- =================================

-- Check temporary patient
SELECT *
FROM PATIENT
WHERE patient_id = 'TST_DELETE';

-- Delete temporary patient
DELETE FROM PATIENT
WHERE patient_id = 'TST_DELETE';

-- Confirm deletion
SELECT *
FROM PATIENT
WHERE patient_id = 'TST_DELETE';


-- =================================
-- TEST 3: REFERENTIAL INTEGRITY
-- =================================

SELECT
    a.appointment_id,
    a.patient_id
FROM APPOINTMENT a
LEFT JOIN PATIENT p
    ON a.patient_id = p.patient_id
WHERE p.patient_id IS NULL;
