/*=====================================================================================================-===
                                            3. VIEWS CREATION
===========================================================================================================
Author : Kgothatso Masha
Date: 15 August 2026
Purpose: This script will create the following views:
    vwBlockedStudents, which shows all the students with Blocked access;
    vwTopCareerReadyStudents, which shows the top 20 students' career readiness points;
    vwMostDownloadedResources, which shows the top 20 most downloaded career resource;
    vwPopularCareerProgrammes, which shows the top 5 most popular career programmes
Instructions: This should be ran after 2_Sample_Data_Insertion
=========================================================================================================*/

--   ---------------------------------  0. Using edulaunchDB  --------------------------------------------
USE edulaunchDB; -- ensuring that these views are created into edulauch table
-- --------------------------------------------------------------------------------------------------------

--   ----------------------------  1. Creating View vwBlockedStudents  ------------------------------------
CREATE OR REPLACE VIEW vwBlockedStudents AS
SELECT s.studentID, s.stuNumber, 
    CONCAT(s.stuName, ' ', s.stuSurname) AS StudentName, 
    s.stuAccountStatus, s.stuAccessExpDate
FROM student AS s -- an alias
WHERE s.stuAccountStatus = 'Blocked' -- = is equals to
    AND s.stuAccessExpDate < CURRENT_DATE -- both conditions need to be true
                                          -- < is less than
ORDER BY s.stuAccessExpDate ASC; -- means ordering the output by ascending order of expiry date
-- --------------------------------------------------------------------------------------------------------

--   ------------------------  2. Creating View vwTopCareerReadyStudents  ---------------------------------- 
CREATE OR REPLACE VIEW vwTopCareerReadyStudents AS
SELECT s.studentID, s.stuNumber, 
    CONCAT(s.stuName, ' ', s.stuSurname) AS StudentName, -- adding name and surname together
    -- Adding carReadinessPointsEarned and carReadinessScoreGained as the total readiness score
    COALESCE(ar.TotalAssessmentScore, 0) +
    COALESCE(lap.TotalActivityPoints, 0) AS TotalCarReadinessScore
FROM student AS s
-- Left joining where on where studentID is the same on both tables
LEFT JOIN (
    SELECT studentID, SUM(carReadinessScoreGained) AS TotalAssessmentScore
    FROM assessment_result
    GROUP BY studentID
) AS ar ON s.studentID = ar.studentID -- for assessment result table
LEFT JOIN (
    SELECT studentID, SUM(carReadinessPointsEarned) AS TotalActivityPoints
    FROM learning_activity_progress
    GROUP BY studentID 
) AS lap ON s.studentID = lap.studentID -- for learning activity table
ORDER BY TotalCarReadinessScore DESC -- in descending order
LIMIT 20; -- returns first 20
--------------------------------------------------------------------------------------------------------------- 

--   -------------------------- 3. Creating View vwMostDownloadedResources ------------------------------------
CREATE OR REPLACE VIEW vwMostDownloadedResources AS
SELECT cr.carResourceID, cr.carResourceTitle, cr.carResourceType, cr.carResourceSize_mb, 
		cr.carResourceNumDownloads AS DownloadCount
FROM career_resource AS cr
ORDER BY DownloadCount DESC
LIMIT 20;
---------------------------------------------------------------------------------------------------------------

--   ------------------------  4. Creating View vwPopularCareerProgrammes  -----------------------------------
CREATE OR REPLACE VIEW vwPopularCareerProgrammes AS
SELECT cp.carProgrammeID, cp.carProgrammeTitle, cp.carProgrammeCategory, cp.carProgrammeLevel, cp.carProgrammeCapacityLimit,
    COALESCE(COUNT(pe.prgmEnrolmentID), 0) AS EnrolmentCount
FROM career_programme AS cp
LEFT JOIN programme_enrolment AS pe ON cp.carProgrammeID = pe.carProgrammeID
GROUP BY cp.carProgrammeID, cp.carProgrammeTitle, cp.carProgrammeCategory, cp.carProgrammeLevel, cp.carProgrammeCapacityLimit
ORDER BY EnrolmentCount DESC
LIMIT 5;
-- =============================================================================================================vwmostdownloadedresources