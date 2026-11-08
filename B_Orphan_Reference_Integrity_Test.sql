-- Check appointments have valid patient,
-- clinician and clinic references
use crownfield_eye_hospital;
SELECT a.appointment_id FROM APPOINTMENT AS a
LEFT JOIN PATIENT AS p
    ON p.patient_id = a.patient_id
LEFT JOIN CLINICIAN AS c
    ON c.clinician_id = a.clinician_id
LEFT JOIN CLINIC AS cl
    ON cl.clinic_id = a.clinic_id
WHERE
    p.patient_id IS NULL
    OR c.clinician_id IS NULL
    OR cl.clinic_id IS NULL;