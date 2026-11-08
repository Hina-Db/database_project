
USE crownfield_eye_hospital;

-- QUERY 1: Find clinicians with two or more appointments

SELECT
    c.clinician_id,
    c.clinician_name,
    COUNT(a.appointment_id) AS total_appointments
FROM CLINICIAN c
INNER JOIN APPOINTMENT a
    ON c.clinician_id = a.clinician_id
GROUP BY
    c.clinician_id,
    c.clinician_name
HAVING COUNT(a.appointment_id) >= 2
ORDER BY total_appointments DESC;




-- QUERY 2: INNER JOIN across four related tables
-- Display appointment, patient, clinician and clinic details

SELECT
    a.appointment_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    c.clinician_name,
    cl.clinic_name,
    a.appointment_date,
    a.appointment_time
FROM APPOINTMENT a
INNER JOIN PATIENT p
    ON a.patient_id = p.patient_id
INNER JOIN CLINICIAN c
    ON a.clinician_id = c.clinician_id
INNER JOIN CLINIC cl
    ON a.clinic_id = cl.clinic_id
ORDER BY a.appointment_id;



-- QUERY 3: LEFT JOIN
-- Display all appointments, including those without prescriptions

SELECT
    a.appointment_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    pr.prescription_id,
    CASE
        WHEN pr.prescription_id IS NULL
        THEN 'No prescription recorded'
        ELSE 'Prescription recorded'
    END AS prescription_status
FROM APPOINTMENT a
INNER JOIN PATIENT p
    ON a.patient_id = p.patient_id
LEFT JOIN PRESCRIPTION pr
    ON a.appointment_id = pr.appointment_id
ORDER BY a.appointment_id;



-- QUERY 4: Correlated subquery
-- Find patients who have attended more than one appointment

SELECT
    p.patient_id,
    p.first_name,
    p.last_name
FROM PATIENT p
WHERE (
    SELECT COUNT(*)
    FROM APPOINTMENT a
    WHERE a.patient_id = p.patient_id
) > 1;
