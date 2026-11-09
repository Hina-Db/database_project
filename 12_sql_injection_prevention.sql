
USE crownfield_eye_hospital;

PREPARE secure_query FROM
'SELECT appointment_id, patient_id, appointment_date
 FROM APPOINTMENT
 WHERE patient_id = ?';

-- Test 1: Normal patient ID
SET @patient_input = 'OP001';
EXECUTE secure_query USING @patient_input;

-- Test 2: SQL injection attempt supplied as data
SET @patient_input = 'OP001'' OR ''1''=''1';
EXECUTE secure_query USING @patient_input;

DEALLOCATE PREPARE secure_query;
