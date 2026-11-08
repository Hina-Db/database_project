-- QUERY 6: TRIGGER
-- Prevent a follow-up date before the appointment date
USE crownfield_eye_hospital;

DROP TRIGGER IF EXISTS trg_validate_followup_date_insert;
DROP TRIGGER IF EXISTS trg_validate_followup_date_update;


CREATE TRIGGER trg_validate_followup_date_insert
BEFORE INSERT ON FOLLOW_UP_PLAN
FOR EACH ROW
SET NEW.due_date = IF(
    NEW.due_date < (
        SELECT appointment_date
        FROM APPOINTMENT
        WHERE appointment_id = NEW.appointment_id
    ),
    NULL,
    NEW.due_date
);

-- TRIGGER2 

CREATE TRIGGER trg_validate_followup_date_update
BEFORE UPDATE ON FOLLOW_UP_PLAN
FOR EACH ROW
SET NEW.due_date = IF(
    NEW.due_date < (
        SELECT appointment_date
        FROM APPOINTMENT
        WHERE appointment_id = NEW.appointment_id
    ),
    NULL,
    NEW.due_date
);

SHOW TRIGGERS FROM crownfield_eye_hospital;

-- QUERY 6: TRIGGER TESTING
-- STEP 1: Create a temporary appointment

USE crownfield_eye_hospital;

INSERT INTO APPOINTMENT
(patient_id, clinician_id, clinic_id,
 appointment_date, appointment_time, notes)
VALUES
('SYN011', 1, 1, '2026-11-12', '15:00:00',
 'Q6 TEMPORARY TRIGGER TEST');

-- Save the generated appointment ID
SET @test_appointment_id = LAST_INSERT_ID();

SELECT @test_appointment_id;

-- STEP 2: Test INSERT trigger with an invalid date

INSERT INTO FOLLOW_UP_PLAN
(appointment_id, due_date, priority, status)
VALUES
(@test_appointment_id, '2026-11-11', 'Routine', 'Planned');

-- verify that invalid record was not created

SELECT *
FROM FOLLOW_UP_PLAN
WHERE appointment_id = @test_appointment_id;

-- STEP 4: Insert a valid follow-up record

INSERT INTO FOLLOW_UP_PLAN
(appointment_id, due_date, priority, status)
VALUES
(@test_appointment_id, '2026-11-13', 'Routine', 'Planned');

-- STEP 5: Test UPDATE trigger

UPDATE FOLLOW_UP_PLAN
SET due_date = '2026-11-10'
WHERE appointment_id = @test_appointment_id;

-- verify the original date remains 
SELECT
    appointment_id,
    due_date,
    priority,
    status
FROM FOLLOW_UP_PLAN
WHERE appointment_id = @test_appointment_id;

-- QUERY 6: CLEAN UP TEMPORARY TEST RECORDS

DELETE FROM FOLLOW_UP_PLAN
WHERE appointment_id = @test_appointment_id;

DELETE FROM APPOINTMENT
WHERE appointment_id = @test_appointment_id;

-- Confirm cleanup
SELECT *
FROM APPOINTMENT
WHERE appointment_id = @test_appointment_id;