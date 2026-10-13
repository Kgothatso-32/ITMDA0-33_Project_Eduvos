/*========================================================================================================
										5. TRIGGRERS CREATION
==========================================================================================================
Author : Kgothatso Masha
Date: 22 August 2026
Purpose: This script will create the following triggers:
    trg_BeforeInsert_Student, which autoblocks students with expired access before insert on student table;
    trg_BeforeUpdate_Student, which autoblocks students with expired access before update on student table;
    trg_AfterInsert_Resource, which autologs an error/event when a student cannot add a career resouce.
Instructions: This should be ran after 4_Stored_Procedures_Creation
=========================================================================================================*/

--   ---------------------------  0. Using Edulaunch and setting Delimiter  -------------------------------
USE edulaunchDB;
DELIMITER //
--   -------------------  1. Creating Trigger Before Insert on Student Table AutoBlock  -------------------
CREATE TRIGGER trg_BFI_AutoBlock_Student
BEFORE INSERT ON student
FOR EACH ROW
BEGIN 
    IF NEW.stuAccessExpDate < CURRENT_DATE() THEN
        SET new.stuAccountStatus = 'Blocked';
    END IF;
END //
-- --------------------------------------------------------------------------------------------------------

--   ------------------  2. Creating Trigger Before Update on Student Table Autoblock  --------------------
CREATE TRIGGER trg_BFU_Autoblock_Student
BEFORE UPDATE ON student
FOR EACH ROW
BEGIN
    IF NEW.stuAccessExpDate < CURRENT_DATE() THEN
        SET NEW.stuAccountStatus = 'Blocked';
    END IF;
END //
-- --------------------------------------------------------------------------------------------------------

--   ---------------  3. Creating Trigger After Insert on student Resource Table LogError  ----------------
CREATE TRIGGER trg_AFI_LogError_StudentResource
AFTER INSERT ON student_resource
FOR EACH ROW
BEGIN
    DECLARE v_stuStorageLimit_mb DECIMAL(8, 2); 
    DECLARE v_stuUsedStorage_mb DECIMAL(8, 2);
    DECLARE v_newCarResourceSize_mb DECIMAL(8, 2);
    DECLARE v_carResourceTitle VARCHAR(32);

    SELECT stuStorageLimit_mb INTO v_stuStorageLimit_mb
    FROM student WHERE studentID = NEW.studentID;

    SELECT COALESCE(SUM(cr.carResourceSize_mb), 0) INTO v_stuUsedStorage_mb
    FROM student_resource AS sr
    JOIN career_resource AS cr ON sr.carResourceID = cr.carResourceID
    WHERE sr.studentID = NEW.studentID;

    SELECT carResourceSize_mb, carResourceTitle
    INTO v_newCarResourceSize_mb, v_carResourceTitle
    FROM career_resource
    WHERE carResourceID = NEW.carResourceID;

    -- logging error if the student does not have enough storage left to add the career resource
    IF (v_newCarResourceSize_mb + v_stuUsedStorage_mb) > v_stuStorageLimit_mb THEN   
        INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage)
        VALUES (NEW.studentID, 'Resource Storage', 
                CONCAT('Failed to add career resource: ', v_carResourceTitle, 
                ' student does not enough storage to download this resource.'));
    END IF;
END //
DELIMITER ;
-- ==========================================================================================================