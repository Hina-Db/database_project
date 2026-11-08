SELECT VERSION();
USE crownfield_eye_hospital;

DROP PROCEDURE IF EXISTS sp_patient_appointments;

DELIMITER //

CREATE PROCEDURE sp_patient_appointments(
    IN p_patient_id VARCHAR(10)
)
BEGIN
    SELECT
        a.appointment_id,
        p.patient_id,
        CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
        c.clinician_name,
        cl.clinic_name,
        a.appointment_date,
        a.appointment_time,
        a.notes
    FROM PATIENT AS p
    INNER JOIN APPOINTMENT AS a
        ON p.patient_id = a.patient_id
    INNER JOIN CLINICIAN AS c
        ON a.clinician_id = c.clinician_id
    INNER JOIN CLINIC AS cl
        ON a.clinic_id = cl.clinic_id
    WHERE p.patient_id = p_patient_id
    ORDER BY a.appointment_date;
END //

DELIMITER ;
