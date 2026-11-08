
-- ==========================================
-- CROWNFIELD EYE HOSPITAL
-- PART D2: DATA PROTECTION
-- FILE: 10_data_protection.sql
-- STEP 1: CREATE ENCRYPTED NOTES TABLE
-- ==========================================

USE crownfield_eye_hospital;

CREATE TABLE IF NOT EXISTS ENCRYPTED_NOTE_DEMO (
    appointment_id INT NOT NULL,
    encrypted_note VARBINARY(1024) NOT NULL,
    encryption_iv BINARY(16) NOT NULL,
    encryption_salt BINARY(16) NOT NULL,

    PRIMARY KEY (appointment_id),

    CONSTRAINT fk_encrypted_note_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES APPOINTMENT(appointment_id)
) ENGINE = InnoDB;

-- Verify table creation

DESCRIBE ENCRYPTED_NOTE_DEMO;



-- ==========================================
-- STEP 2: GENERATE ENCRYPTION VALUES
-- ==========================================

-- Set AES encryption to 256-bit CBC mode
SET SESSION block_encryption_mode = 'aes-256-cbc';

-- Generate a temporary random encryption key
SET @demo_key = RANDOM_BYTES(32);

-- Generate a random initialisation vector
SET @demo_iv = RANDOM_BYTES(16);

-- Generate a random encryption salt
SET @demo_salt = RANDOM_BYTES(16);

-- Verify the generated values without displaying secrets

SELECT
    OCTET_LENGTH(@demo_key) AS key_length,
    OCTET_LENGTH(@demo_iv) AS iv_length,
    OCTET_LENGTH(@demo_salt) AS salt_length;



-- ==========================================
-- STEP 3: ENCRYPT THE SYNTHETIC NOTE
-- ==========================================

USE crownfield_eye_hospital;

-- Encrypt a synthetic confidential note
-- Appointment 6 is a synthetic test appointment

INSERT INTO ENCRYPTED_NOTE_DEMO
(appointment_id,encrypted_note,encryption_iv,encryption_salt)
VALUES
(6,AES_ENCRYPT('SYNTHETIC CONFIDENTIAL TEST NOTE',@demo_key,@demo_iv,'hkdf',@demo_salt,'crownfield-note-demo'), @demo_iv,@demo_salt)
ON DUPLICATE KEY UPDATE
    encrypted_note = AES_ENCRYPT(
        'SYNTHETIC CONFIDENTIAL TEST NOTE',
        @demo_key,
        @demo_iv,
        'hkdf',
        @demo_salt,
        'crownfield-note-demo'
    ),
    encryption_iv = @demo_iv,
    encryption_salt = @demo_salt;

-- Check the encrypted information

SELECT
    appointment_id,HEX(encrypted_note) AS encrypted_note FROM ENCRYPTED_NOTE_DEMO WHERE appointment_id = 6;




-- ==========================================
-- STEP 4: DECRYPT AND VERIFY THE TEST NOTE
-- ==========================================

-- Maintain AES-256-CBC encryption mode
SET SESSION block_encryption_mode = 'aes-256-cbc';

-- Decrypt the stored encrypted note

SELECT
    appointment_id,

    HEX(encrypted_note) AS encrypted_value,

    CAST(
        AES_DECRYPT(
            encrypted_note,
            @demo_key,
            encryption_iv,
            'hkdf',
            encryption_salt,
            'crownfield-note-demo'
        ) AS CHAR(255)
    ) AS decrypted_note

FROM ENCRYPTED_NOTE_DEMO
WHERE appointment_id = 6;

