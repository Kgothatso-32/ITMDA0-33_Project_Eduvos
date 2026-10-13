-- Active: 1784809457307@@127.0.0.1@3306@edulaunchdb
/*=====================================================================================================-===
                                1. DATABASE & TABLE CREATION
===========================================================================================================
Author : Kgothatso Masha
Date: 15 August 2026
Purpose: This script creates the Database and its tables from ERD for Edulauch
Instructions: This should be ran first
=========================================================================================================*/

--  -----------------------------------  0. Creating The Database  ----------------------------------------
DROP DATABASE IF EXISTS edulaunchDB; -- deleting edulaunch database if it exists already
CREATE DATABASE edulaunchDB; -- creating the database
USE edulaunchDB; -- ensuring the tables will be created inside edulaunchDB database
-- --------------------------------------------------------------------------------------------------------

--   ----------------------------------  1. Creating STUDENT table  ---------------------------------------
CREATE TABLE STUDENT ( 
    studentID INT AUTO_INCREMENT PRIMARY KEY, 
    stuNumber VARCHAR(8) NOT NULL UNIQUE,
    stuAccountPassword VARCHAR(12) NOT NULL UNIQUE, -- uniquely saves as hashpass
    stuName VARCHAR(32) NOT NULL, 
    stuSurname VARCHAR(32) NOT NULL, 
    stuAccountStatus ENUM('Active', 'Blocked') NOT NULL DEFAULT 'Active', 
    stuAccessExpDate DATE NOT NULL, 
    stuStorageLimit_mb DECIMAL(8, 2) NOT NULL DEFAULT 500.00 -- in megabytes hence mb  
            CHECK(stuStorageLimit_mb >= 0) -- ensuring it is always positive
);
-- --------------------------------------------------------------------------------------------------------

--   -------------------------------  2. Creating CAREER ADVISOR Table  -----------------------------------
CREATE TABLE CAREER_ADVISOR ( 
    carAdvisorID INT AUTO_INCREMENT PRIMARY KEY, 
    carAdvisorName VARCHAR(32) NOT NULL, 
    carAdvisorSurname VARCHAR(32) NOT NULL, 
    carAdvisorEmail VARCHAR(65) NOT NULL UNIQUE, 
    carAdvisorSpecialisation VARCHAR(65) NOT NULL 
); 
-- --------------------------------------------------------------------------------------------------------

--   ------------------------------  3. Creating CAREER PROGRAMME Table  ----------------------------------
CREATE TABLE  CAREER_PROGRAMME ( 
    carProgrammeID INT AUTO_INCREMENT PRIMARY KEY, 
    carAdvisorID INT NOT NULL, 
    carProgrammeTitle VARCHAR(65) NOT NULL, 
    carProgrammeCategory VARCHAR(65) NOT NULL, 
    carProgrammeLevel ENUM('Foundation', 'Intermediate', 'Advanced') NOT NULL, -- enum is choices that are allowed
    carProgrammeCapacityLimit INT NOT NULL 
            CHECK (carProgrammeCapacityLimit > 0), -- ensuring its always positive 
    -- Adding the foreign key specification 
    CONSTRAINT fk_programme_advisorID -- for Advisor 
        FOREIGN KEY (carAdvisorID) REFERENCES CAREER_ADVISOR(carAdvisorID) 
        -- ensuring a career advisor can't be deleted from CAREER_ADVISOR if they are facilitating a career programme 
        ON DELETE RESTRICT ON UPDATE CASCADE 
); 
-- ---------------------------------------------------------------------------------------------------------

--   -------------------------------  4. Creating PROGRAMME ENROLMENT Table  -------------------------------
CREATE TABLE PROGRAMME_ENROLMENT ( 
    prgmEnrolmentID INT AUTO_INCREMENT PRIMARY KEY, 
    studentID INT NOT NULL, 
    carProgrammeID INT NOT NULL, 
    prgmEnrolmentDate DATE NOT NULL DEFAULT (CURRENT_DATE), 
    -- Adding foreign key specifications: 
    CONSTRAINT fk_enrolment_studendID -- for Student 
        FOREIGN KEY (studentID) REFERENCES STUDENT(studentID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_enrolment_programmeID -- for Career Programme 
        FOREIGN KEY (carProgrammeID) REFERENCES CAREER_PROGRAMME(carProgrammeID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    -- ensuring a single student and programme does not have dublicate enrolments 
    CONSTRAINT uq_student_career_programme UNIQUE (studentID, carProgrammeID) 
); 
-- ---------------------------------------------------------------------------------------------------------

--   -----------------------------  5. Creating LEARNING ACTIVITY Table  -----------------------------------
CREATE TABLE LEARNING_ACTIVITY ( 
    lrngActivityID INT AUTO_INCREMENT PRIMARY KEY, 
    carProgrammeID INT NOT NULL, 
    lrngActivityTitle VARCHAR(65) NOT NULL, 
    -- Adding foreign key specifications 
    CONSTRAINT fk_activity_programmeID -- for Career Programme 
        FOREIGN KEY (carProgrammeID) REFERENCES CAREER_PROGRAMME(carProgrammeID) 
        ON DELETE CASCADE ON UPDATE CASCADE 
); 
-- ---------------------------------------------------------------------------------------------------------

--   --------------------------  6. Creating LEARING ACTIVITY PROGRESS Table  ------------------------------
CREATE TABLE LEARNING_ACTIVITY_PROGRESS ( 
    lrngActivityProgressID INT AUTO_INCREMENT PRIMARY KEY, 
    lrngActivityID INT NOT NULL,
    studentID INT NOT NULL,
    lrngActCompletionStatus ENUM('Not Started', 'In Progress', 'Completed') 
                        NOT NULL DEFAULT 'Not Started', 
    lrngActProgressPercentage TINYINT UNSIGNED NOT NULL DEFAULT 0 -- tinyint is a small integer 
            CHECK (lrngActProgressPercentage BETWEEN 0 AND 100), -- ensuring its between 0 and 1000
    carReadinessPointsEarned INT NOT NULL DEFAULT 0    
            CHECK(carReadinessPointsEarned >= 0), -- ensuring they are always positive
    -- Adding foreign key specifications 
    CONSTRAINT fk_progress_studentID  -- for Student  
        FOREIGN KEY (studentID) REFERENCES STUDENT(studentID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_lrngActivityID -- for Learning Activity 
        FOREIGN KEY (lrngActivityID) REFERENCES LEARNING_ACTIVITY(lrngActivityID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    -- ensuring there are no dublicate learning activities for single student 
    CONSTRAINT uq_student_learning_activity UNIQUE (studentID, lrngActivityID) 
); 
-- ---------------------------------------------------------------------------------------------------------

--    -------------------------------  7. Creating ASSESSMENT Table  ---------------------------------------
CREATE TABLE ASSESSMENT ( 
    assessmentID INT AUTO_INCREMENT PRIMARY KEY, 
    carProgrammeID INT NOT NULL, 
    assessmentTitle VARCHAR(65) NOT NULL, 
    assessmentType VARCHAR(65) NOT NULL, 
    -- Adding foreign key specification 
    CONSTRAINT fk_assessment_programmeID -- for Career Programme 
        FOREIGN KEY (carProgrammeID) REFERENCES CAREER_PROGRAMME(carProgrammeID) 
        ON DELETE CASCADE ON UPDATE CASCADE 
); 
-- ---------------------------------------------------------------------------------------------------------

--   ----------------------------  8. Creating ASSESSMENT RESULT Table -------------------------------------
CREATE TABLE ASSESSMENT_RESULT ( 
    assessmentResultID INT AUTO_INCREMENT PRIMARY KEY, 
    studentID INT NOT NULL, 
    assessmentID INT NOT NULL, 
    assMarksObtained DECIMAL(8, 2) NOT NULL 
            CHECK(assMarksObtained BETWEEN 0 AND 100), -- ensuring they are between 0 and 100
    carReadinessScoreGained DECIMAL(8, 2) NOT NULL DEFAULT 0 
            CHECK (carReadinessScoreGained >= 0), -- ensuring it is always positive
    -- Adding foreign key specifications 
    CONSTRAINT fk_studentID -- for Student 
        FOREIGN KEY (studentID) REFERENCES STUDENT(studentID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_result_programmeID -- for Career Programme 
        FOREIGN KEY (assessmentID) REFERENCES ASSESSMENT(assessmentID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    -- ensuring there is no dublication 
    CONSTRAINT uq_student_assessment UNIQUE (studentID, assessmentID) 
); 
-- ----------------------------------------------------------------------------------------------------------

--   -----------------------------  9. Creating DIGITAL CAREER RESOURCE Table  ------------------------------
CREATE TABLE CAREER_RESOURCE ( 
    carResourceID INT AUTO_INCREMENT PRIMARY KEY, 
    carResourceTitle VARCHAR(65) NOT NULL,
    carResourceType varchar(65) NOT NULL, 
    carResourceSize_mb DECIMAL(8, 2) NOT NULL -- in megabytes hence mb 
            CHECK(carResourceSize_mb >= 0), -- ensuring it is never negative 
    carResourceNumDownloads INT NOT NULL DEFAULT 0 
            CHECK (carResourceNumDownloads >= 0) -- never negative 
); 
-- ----------------------------------------------------------------------------------------------------------

--   -----------------------------  10. Creating STUDENT RESOURCE Table  ------------------------------------
CREATE TABLE STUDENT_RESOURCE ( 
    stuResourceID INT AUTO_INCREMENT PRIMARY KEY, 
    carResourceID INT NOT NULL, 
    studentID INT NOT NULL, 
    -- Adding foreign key specifications 
    CONSTRAINT fk_resource_studentID -- for Student 
        FOREIGN KEY (studentID) REFERENCES STUDENT(studentID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_carResourceID -- for Career Resource 
        FOREIGN KEY (carResourceID) REFERENCES CAREER_RESOURCE(carResourceID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    -- ensuring that there is no dublication 
    CONSTRAINT uq_student_resource UNIQUE (studentID, carResourceID) 
); 
-- ---------------------------------------------------------------------------------------------------------

--   ------------------------------  11. Creating ERROR EVENT LOG Table  -----------------------------------
CREATE TABLE ERROR_EVENT_LOG ( 
    errEventLogID INT AUTO_INCREMENT PRIMARY KEY, 
    studentID INT NULL DEFAULT NULL, 
    errEventCategory VARCHAR(232) NOT NULL, 
    errEventMessage VARCHAR(232), 
    errEventTimestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    -- Adding foreign key specifications 
    CONSTRAINT fk_error_studentID -- for studentID 
        FOREIGN KEY (studentID) REFERENCES STUDENT(studentID) 
        -- ensuring that when studentID is deleted on STUDENT table, it will be set NULL(no value) here 
        ON DELETE SET NULL ON UPDATE CASCADE 
);
-- ==========================================================================================================