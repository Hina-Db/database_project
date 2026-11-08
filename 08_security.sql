
-- CROWNFIELD EYE HOSPITAL
-- PART D: SECURITY AND ACCESS CONTROL
-- STEP 1: CREATE ROLES AND ASSIGN PRIVILEGES

USE crownfield_eye_hospital;

-- Create four database roles
CREATE ROLE IF NOT EXISTS
    'hospital_admin_role',
    'doctor_role',
    'receptionist_role',
    'patient_role';

-- =====================================
-- 1. ADMINISTRATOR: FULL DATABASE ACCESS
-- =====================================

GRANT ALL PRIVILEGES
ON crownfield_eye_hospital.*
TO 'hospital_admin_role';

-- =====================================
-- 2. DOCTOR: CLINICAL ACCESS
-- =====================================

-- Read reference and clinical information
GRANT SELECT ON crownfield_eye_hospital.PATIENT
TO 'doctor_role';

GRANT SELECT ON crownfield_eye_hospital.SPECIALTY
TO 'doctor_role';

GRANT SELECT ON crownfield_eye_hospital.CLINICIAN
TO 'doctor_role';

GRANT SELECT ON crownfield_eye_hospital.CLINIC
TO 'doctor_role';

GRANT SELECT ON crownfield_eye_hospital.DIAGNOSIS
TO 'doctor_role';

GRANT SELECT ON crownfield_eye_hospital.MEDICINE
TO 'doctor_role';

-- Manage appointments and clinical records
GRANT SELECT, INSERT, UPDATE
ON crownfield_eye_hospital.APPOINTMENT
TO 'doctor_role';

GRANT SELECT, INSERT, UPDATE
ON crownfield_eye_hospital.APPOINTMENT_DIAGNOSIS
TO 'doctor_role';

GRANT SELECT, INSERT, UPDATE
ON crownfield_eye_hospital.PRESCRIPTION
TO 'doctor_role';

GRANT SELECT, INSERT, UPDATE
ON crownfield_eye_hospital.PRESCRIPTION_ITEM
TO 'doctor_role';

GRANT SELECT, INSERT, UPDATE
ON crownfield_eye_hospital.FOLLOW_UP_PLAN
TO 'doctor_role';

-- =====================================
-- 3. RECEPTIONIST: ADMINISTRATIVE ACCESS
-- =====================================

GRANT SELECT, INSERT, UPDATE
ON crownfield_eye_hospital.PATIENT
TO 'receptionist_role';

GRANT SELECT
ON crownfield_eye_hospital.CLINICIAN
TO 'receptionist_role';

GRANT SELECT
ON crownfield_eye_hospital.CLINIC
TO 'receptionist_role';

GRANT SELECT, INSERT, UPDATE
ON crownfield_eye_hospital.APPOINTMENT
TO 'receptionist_role';

GRANT SELECT
ON crownfield_eye_hospital.FOLLOW_UP_PLAN
TO 'receptionist_role';

-- =====================================
-- 4. PATIENT: LIMITED ACCESS
-- View access will be granted after
-- creating the patient-specific view.
-- =====================================

-- No direct table access is granted
-- to patient_role at this stage.

-- =====================================
-- VERIFY ROLE PERMISSIONS
-- =====================================

SHOW GRANTS FOR 'hospital_admin_role';

SHOW GRANTS FOR 'doctor_role';

SHOW GRANTS FOR 'receptionist_role';

SHOW GRANTS FOR 'patient_role';


-- PART D: PATIENT-SPECIFIC ACCESS
-- STEP 1: Create patient login mapping table

USE crownfield_eye_hospital;

CREATE TABLE IF NOT EXISTS PATIENT_DB_ACCOUNT (
    db_username VARCHAR(32) NOT NULL,
    patient_id VARCHAR(10) NOT NULL,

    PRIMARY KEY (db_username),
    UNIQUE (patient_id),

    CONSTRAINT fk_patient_db_account_patient
        FOREIGN KEY (patient_id)
        REFERENCES PATIENT(patient_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE = InnoDB;

-- Verify table creation

DESCRIBE PATIENT_DB_ACCOUNT;


-- STEP 2: Link patient login accounts to patient records

USE crownfield_eye_hospital;

INSERT INTO PATIENT_DB_ACCOUNT
(db_username, patient_id)
VALUES
('patient_op001', 'OP001'),
('patient_op002', 'OP002'),
('patient_op003', 'OP003'),
('patient_op004', 'OP004');

-- Check the mappings

SELECT
    db_username,
    patient_id
FROM PATIENT_DB_ACCOUNT;


-- STEP 3: CREATE SECURE PATIENT APPOINTMENT VIEW

USE crownfield_eye_hospital;

CREATE OR REPLACE
SQL SECURITY DEFINER
VIEW v_patient_appointments AS

SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    a.appointment_id,
    a.appointment_date,
    a.appointment_time,
    c.clinician_name,
    cl.clinic_name

FROM PATIENT_DB_ACCOUNT AS account_map

INNER JOIN PATIENT AS p
    ON account_map.patient_id = p.patient_id

INNER JOIN APPOINTMENT AS a
    ON p.patient_id = a.patient_id

INNER JOIN CLINICIAN AS c
    ON a.clinician_id = c.clinician_id

INNER JOIN CLINIC AS cl
    ON a.clinic_id = cl.clinic_id

WHERE account_map.db_username =
    SUBSTRING_INDEX(USER(), '@', 1);


-- Give the Patient role access to this view only

GRANT SELECT
ON crownfield_eye_hospital.v_patient_appointments
TO 'patient_role';


-- Check the view definition

SHOW CREATE VIEW v_patient_appointments;

-- Check patient role permissions

SHOW GRANTS FOR 'patient_role';



-- STEP 4: CREATE PATIENT LOGIN ACCOUNTS

USE crownfield_eye_hospital;

CREATE USER IF NOT EXISTS 'patient_op001'@'localhost'
IDENTIFIED BY 'Temp_OP001#Change26!';

CREATE USER IF NOT EXISTS 'patient_op002'@'localhost'
IDENTIFIED BY 'Temp_OP002#Change26!';

CREATE USER IF NOT EXISTS 'patient_op003'@'localhost'
IDENTIFIED BY 'Temp_OP003#Change26!';

CREATE USER IF NOT EXISTS 'patient_op004'@'localhost'
IDENTIFIED BY 'Temp_OP004#Change26!';

-- Assign Patient role to each account

GRANT 'patient_role' TO 'patient_op001'@'localhost';
GRANT 'patient_role' TO 'patient_op002'@'localhost';
GRANT 'patient_role' TO 'patient_op003'@'localhost';
GRANT 'patient_role' TO 'patient_op004'@'localhost';

-- Make Patient role active automatically at login

SET DEFAULT ROLE 'patient_role'
TO 'patient_op001'@'localhost';

SET DEFAULT ROLE 'patient_role'
TO 'patient_op002'@'localhost';

SET DEFAULT ROLE 'patient_role'
TO 'patient_op003'@'localhost';

SET DEFAULT ROLE 'patient_role'
TO 'patient_op004'@'localhost';

-- Verify account permissions

SHOW GRANTS FOR 'patient_op001'@'localhost';
SHOW GRANTS FOR 'patient_op002'@'localhost';
SHOW GRANTS FOR 'patient_op003'@'localhost';
SHOW GRANTS FOR 'patient_op004'@'localhost';
