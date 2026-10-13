/*=====================================================================================================-===
									4. STORED PROCEDURES CREATION
===========================================================================================================
Author : Kgothatso Masha
Date: 19 August 2026
Purpose: This script will create the following stored procedures:
    spRegisterStudent, which registers new students;
    spRenewAccess, which adds days to a student's Edulaunch access;
    spEnrolStudent, which enrols a student into a career programme;
    spAddCareerResource, which adds a digital career resource to a studen's personal storage;
    spSendAcessNotice, which sends the remaining Edulaunch access time for students
Instructions: This should be ran after 3_Views_Creation
=========================================================================================================*/

--   ----------------------------  0. Using EdulaunchDB and setting Delimiter  ------------------------------
USE edulaunchDB; -- amking sure thse are created inside edulaunchDB
DELIMITER // -- Changing the delimiter
-- -------------------------------------------------------------------------------------------------------

--   ------------------------  1. Creating Stored Procedure spRegisterStudent  ----------------------------
CREATE PROCEDURE spRegisterStudent (
    IN p_studentNumber VARCHAR(8),
    IN p_studentPassword VARCHAR(12),
    IN p_studentName VARCHAR(32),
    IN p_studentSurname VARCHAR(32),
    IN p_studentAcessExpDate DATE,
    IN p_studentStorageLimit_mb DECIMAL(8, 2),
    OUT p_message VARCHAR (160)
)
BEGIN 
    DECLARE v_existingStuNumber INT DEFAULT 0;
    DECLARE v_existingStuPassword INT DEFAULT 0;

    SELECT COUNT(*) INTO v_existingStuNumber 
    FROM student WHERE stuNumber = p_studentNumber;

    SELECT COUNT(*) INTO v_existingStuPassword
    FROM student WHERE stuAccountPassword = p_studentPassword;

    -- checking if student already exists
    IF v_existingStuNumber > 0 THEN
        INSERT INTO error_event_log (errEventCategory, errEventMessage)
        VALUES ('Registration Failure', 
            CONCAT('Failed to register student, the student number ', 
            p_studentNumber, ' already exists in the system.'));

        SET p_Message = CONCAT('Failed to register student, the student number  ', 
                        p_studentNumber, ' already exists in the system.');

    -- checking if student's password holder already exists
    ELSEIF v_existingStuPassword > 0 THEN
        INSERT INTO error_event_log (errEventCategory, errEventMessage)
        VALUES ('Registration Failure', 
            CONCAT('Failed to register student, the password place holder ', 
            p_studentPassword, ' already exists in the system.'));

        SET p_Message = CONCAT('Failed to register student, the password place holder ', 
                        p_studentPassword, ' already exists in the system.');

    -- registering the student into student table
    ELSE 
        INSERT INTO student (stuNumber, stuAccountPassword, stuName, stuSurname, 
                            stuAccessExpDate, stuStorageLimit_mb)
        VALUES (p_studentNumber, p_studentPassword, p_studentName, 
                p_studentSurname, p_studentAcessExpDate, p_studentStorageLimit_mb);
        SET p_message = CONCAT(p_studentNumber, ', has been Registered Successfully.');

    END IF;
END //
-- ------------------------------------------------------------------------------------------------------

--   -------------------------  2. Creating Stored Procedure spRenewAccess  ------------------------------
CREATE PROCEDURE spRenewAccess (
    IN p_studentNumber VARCHAR(8),
    IN p_numDaysToAdd INT,
    OUT p_message VARCHAR(160)
)
BEGIN
    DECLARE v_studentID INT;
    
    SELECT studentID INTO v_studentID
    FROM student WHERE stuNumber = p_studentNumber;

    -- checking if student exists
    IF v_studentID IS NULL THEN
        SET p_message = CONCAT('Renewing Access Failed, the student number: ', 
                            p_studentNumber, ', does not exist.');

    -- checking if the number of days to add is positive
    ELSEIF p_numDaysToAdd <= 0 THEN
        SET p_message = 'Renewing Access Failed, number of days to add needs to be higher than 0.';

    -- renewing the student's access
    ELSE
        UPDATE student
        SET stuAccessExpDate = DATE_ADD(GREATEST(stuAccessExpDate, CURRENT_DATE()),
                                         INTERVAL p_numDaysToAdd DAY),
            stuAccountStatus = 'Active'
        WHERE studentID = v_studentID;
        SET p_message = CONCAT(p_studentnumber, '''s Edulaunch access has been renewed for ',
                             p_numDaysToAdd, ' days.'); 

    END IF;
END //  
-- ----------------------------------------------------------------------------------------------------------

--   --------------------------  3. Creating Stored Procedure spEnrolStudent  --------------------------------
CREATE PROCEDURE spEnrolStudent (
    IN p_studentNumber VARCHAR(8),
    IN p_careerProgrammeID INT,
    OUT p_message VARCHAR (160)
)
BEGIN 
    -- declaring my variables
    DECLARE v_prgmCapacityLimit INT; -- programme capacity limit
    DECLARE v_carProgrammeTitle VARCHAR(32); -- career programme name
    DECLARE v_currentlyEnrolled INT; -- currently enrolled students
    DECLARE v_accountStatus VARCHAR(8); -- student account status
    DECLARE v_alreadyEnrolled INT; -- checks if student is enrolled already
    DECLARE v_studentID INT; -- student's ID
    

    SELECT carProgrammeCapacityLimit, carProgrammeTitle
    INTO v_prgmCapacityLimit, v_carProgrammeTitle
    FROM career_programme WHERE carProgrammeID = p_careerProgrammeID;

    SELECT COUNT(*) INTO v_currentlyEnrolled
    FROM programme_enrolment WHERE carProgrammeID = p_careerProgrammeID;

    SELECT stuAccountStatus, studentID
    INTO v_accountStatus, v_studentID
    FROM student WHERE stuNumber = p_studentNumber;    

    SELECT COUNT(*) INTO v_alreadyEnrolled
    FROM programme_enrolment WHERE studentID = v_studentID AND carProgrammeID = p_careerProgrammeID;

    -- checking if the student number of programme ID entered exists
    IF v_StudentID IS NULL OR v_prgmCapacityLimit IS NULL THEN
        SET p_message = CONCAT('Enrolling ', p_studentNumber, ' failed, the career programme: ',
                         v_carProgrammeTitle, ', or student number: ', p_studentNumber, ' does not exist.');
    
    -- checking if the programme is not full
    ELSEIF v_currentlyEnrolled >= v_prgmCapacityLimit THEN
        INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage)
        VALUES (v_studentID, 'Enrolment Failure', 
                CONCAT('Enrolling ', p_studentNumber, ' failed, the career programme: ',
                         v_carProgrammeTitle, ', is full.'));

        SET p_message = CONCAT('Enrolling ', p_studentNumber, ' failed, the career programme: ', 
                                v_carProgrammeTitle, ', is full.');
    
    -- checking if the student is not enrolled already
    ELSEIF v_alreadyEnrolled > 0 THEN
        INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage)
        VALUES (v_studentID, 'Enrolment Failure', 
                CONCAT('Enrolling ', p_studentNumber,' failed, ', p_studentNumber, 
                ' is already enrolled in the career programme.'));
        SET p_message = CONCAT('Enrolling ', p_studentNumber, ' failed, ', p_studentNumber, 
                        ' is already enrolled in the career programme: ', v_carProgrammeTitle);

    -- checking if the student's account is active
    ELSEIF v_accountStatus != 'Active' THEN
        INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage)
        VALUES (v_studentID, 'Enrolment Failure', CONCAT('Enrolling ', p_studentNumber, ' failed, ', 
                    p_studentNumber,'''s account status is not active.'));

        SET p_message = CONCAT('Enrolling ', p_studentNumber, ' failed, ', 
                                p_studentNumber,'''s account status is not active.');

    -- enrolling the student into the career programme
    ELSE
        INSERT INTO programme_enrolment (studentID, carProgrammeID)
        VALUES (v_studentID, p_careerProgrammeID);

        SET p_message = CONCAT(p_studentNumber, ' has been enrolled successfully into career programme: ', 
                        v_carProgrammeTitle);

    END IF;
END //
-- ------------------------------------------------------------------------------------------------------------

--   ------------------------  4. Creating Stored Procedure spAddCareerResource  ------------------------------
CREATE PROCEDURE spAddCareerResource (
    IN p_studentNumber VARCHAR(8),
    IN p_careerResourceID INT,
    OUT p_message VARCHAR(160)
)
BEGIN
    DECLARE v_stuStorageLimit_mb DECIMAL(8, 2); 
    DECLARE v_stuUsedStorage_mb DECIMAL(8, 2);
    DECLARE v_studentID INT;
    DECLARE v_newCarResourceSize_mb DECIMAL(8, 2);
    DECLARE v_carResourceTitle VARCHAR(32);

    SELECT stuStorageLimit_mb, studentID
    INTO v_stuStorageLimit_mb, v_studentID
    FROM student WHERE stuNumber = p_studentNumber;

    SELECT COALESCE(SUM(cr.carResourceSize_mb), 0) INTO v_stuUsedStorage_mb
    FROM student_resource AS sr
    JOIN career_resource AS cr ON sr.carResourceID = cr.carResourceID
    WHERE sr.studentID = v_studentID;

    SELECT carResourceSize_mb, carResourceTitle
    INTO v_newCarResourceSize_mb, v_carResourceTitle
    FROM career_resource
    WHERE carResourceID = p_careerResourceID;

    -- checking if the student has enough storage left to add the career resource
    IF (v_newCarResourceSize_mb + v_stuUsedStorage_mb) > v_stuStorageLimit_mb THEN   
        INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage)
        VALUES (v_studentID, 'Resource Storage', 
                CONCAT('Failed to add career resource: ', v_carResourceTitle, 
                ', ', p_studentNumber, ' does not enough storage to download this resource.'));

        SET p_message = CONCAT('Failed to Add career resource: ', v_carResourceTitle, 
                        ', ', p_studentNumber, ' does not enough storage to download this resource.');

    -- downloading the career resource into the student's storage
    ELSE 
        INSERT INTO student_resource (studentID, carResourceID)
        VALUES (v_studentID, p_careerResourceID);

        SET p_message = CONCAT('The career resource: ', v_carResourceTitle,
                                ', has been added successfully into ', p_studentNumber, '''s career resource storage');

    END IF;
END //
-- ----------------------------------------------------------------------------------------------------------------

--   ---------------------------  5. Creating Stored Procedure spSendAccessNotice  --------------------------------
CREATE PROCEDURE spSendAccessNotice (
    IN p_studentNumber VARCHAR(8)
)
BEGIN
    SELECT 
        p_studentNumber AS StudentNumber,
        CONCAT(stuName, ' ', stuSurname) AS StudentName,
        stuAccessExpDate AS AccessExpDate,
        DATEDIFF(stuAccessExpDate, CURRENT_DATE()) AS RemainingDays,
        CASE
            WHEN stuAccountStatus = 'Blocked'
                THEN CONCAT(stuName, ' ', stuSurname, '''s Edulaunch access has expired ',
                        DATEDIFF(stuAccessExpDate, CURRENT_DATE()), ' days ago.')
            WHEN DATEDIFF(stuAccessExpDate, CURRENT_DATE()) <= 30
                THEN CONCAT(stuName, ' ', stuSurname, '''s Edulaunch access is expiring in ', 
                        DATEDIFF(stuAccessExpDate, CURRENT_DATE()), ' days.')
            ELSE 
                CONCAT (stuName, ' ', stuSurname, ' has ', DATEDIFF(stuAccessExpDate, CURRENT_DATE()),
                         ' days of Edulaunch access remaining.')
        END AS AccessNoticeMessage
    FROM student
    WHERE (p_studentNumber IS NULL OR stuNumber = p_studentNumber)
    ORDER BY RemainingDays ASC;
END //
DELIMITER ;
-- =================================================================================================================
