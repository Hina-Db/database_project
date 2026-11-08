
-- ==========================================
-- CROWNFIELD EYE HOSPITAL
-- PART D1: PATIENT VIEW SECURITY TESTING
-- FILE: 06_testing.sql
-- ==========================================

USE crownfield_eye_hospital;


-- TEST 1: VIEW PATIENT LOGIN MAPPINGS
-- Execute using ADMINISTRATOR connection

SELECT
    db_username,
    patient_id
FROM PATIENT_DB_ACCOUNT
ORDER BY db_username;


-- TEST 2: CHECK LOGGED-IN PATIENT
-- Execute using PATIENT OP001 connection

SELECT USER();


-- TEST 3: VIEW OWN APPOINTMENTS
-- Execute using PATIENT OP001 connection
-- Expected: Amina's two appointments

SELECT *
FROM v_patient_appointments;


-- TEST 4: ATTEMPT TO VIEW ANOTHER PATIENT
-- Execute using PATIENT OP001 connection
-- Expected: 0 rows

SELECT *
FROM v_patient_appointments
WHERE patient_id = 'OP002';


-- TEST 5: ATTEMPT DIRECT ACCESS TO PATIENT TABLE
-- Execute using PATIENT OP001 connection
-- Expected: ACCESS DENIED

SELECT *
FROM PATIENT;


-- TEST 6: ATTEMPT DIRECT ACCESS TO APPOINTMENT TABLE
-- Execute using PATIENT OP001 connection
-- Expected: ACCESS DENIED

SELECT *
FROM APPOINTMENT;

-- ==========================================
-- END OF PART D1 TESTING
-- ==========================================
