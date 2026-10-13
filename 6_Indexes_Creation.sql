/*========================================================================================================
											6. INDEXES CREATION
==========================================================================================================
Author : Kgothatso Masha
Date: 22 August 2026
Purpose: This script will create the following indexes:
    i
Instructions: This should be ran after 5_Triggers_Creation
=========================================================================================================*/

--   ------------------------------------  0. Using edulaunchDB  ------------------------------------------
USE edulaunchDB; -- ensuring that these indexes are created into Edulaunch database
-- --------------------------------------------------------------------------------------------------------

--   ----------------  1. Creating Index on Student Account Status and Access Expiry Date  ----------------
CREATE INDEX idx_Student_AccountStatus_AccessExpDate
    ON student (stuAccountStatus, stuAccessExpDate);
-- --------------------------------------------------------------------------------------------------------

--   ----------------  2. Creating Index on Career Programme and its Category -----------------------------
CREATE INDEX idx_CareerProgramme_Title_Category
    ON career_programme (carProgrammeTitle, carProgrammeCategory);
-- -------------------------------------------------------------------------------------------------------

--   ----------------  3. Creating Index on Career Programme and its Enrolled Students  ------------------
CREATE INDEX idx_Student_ProgrammeEnrolment
    ON programme_enrolment (studentID, carProgrammeID);
-- ========================================================================================================