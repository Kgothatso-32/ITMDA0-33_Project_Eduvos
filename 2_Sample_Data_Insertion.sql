/*===============================================================================================================================
                                2. SAMPLE DATA INSERTION
=================================================================================================================================
Author : Kgothatso Masha
Date: 15 August 2026
Purpose: This script inserts values/data into the tables created inside edulauchDB
Instructions: This should be ran after 1_Database_Table_Creation.sql
===============================================================================================================================*/

--   ------------------------------------  0. Using edulaunchDB  ---------------------------------------------------------------
USE edulaunchDB; -- ensuring that these are inserted into edulauch table
-- ------------------------------------------------------------------------------------------------------------------------------

--   ------------------------------------  1. Inserting into STUDENT Table  -----------------------------------------------------
INSERT INTO student (stuNumber, stuAccountPassword, stuName, stuSurname, stuAccountStatus, stuAccessExpDate, stuStorageLimit_mb)
VALUES
    ('EDUL5678', 'hashpass1682', 'Emma', 'Pillay', 'Active', '2026-11-04', 500.00),
    ('EDUL8946', 'hashpass8761', 'Tashreeq', 'Valentine', 'Blocked', '2026-04-30', 300.00),
    ('EDUL4098', 'hashpass3236', 'Kaymore', 'Masha', 'Active', '2026-09-30', 500.00),
    ('EDUL7295', 'hashpass2658', 'Ishmael', 'Richards', 'Active', '2027-03-30', 500.00),
    ('EDUL6823', 'hashpass6581', 'Jacob', 'Kwete', 'Active', '2026-12-31', 300.00),
    ('EDUL2316', 'hashpass8959', 'Lionell', 'Chiko', 'Blocked', '2026-06-30', 100.00),
    ('EDUL4656', 'hashpass0462', 'Marlene', 'April', 'Blocked', '2026-06-30', 400.00),
    ('EDUL6512', 'hashpass1237', 'Carla', 'Miller', 'Active', '2027-02-28', 400.00);
-- -------------------------------------------------------------------------------------------------------------------------------

--   ----------------------------------   2. Inserting into CAREER ADVISOR Table  ------------------------------------------------
INSERT INTO career_advisor (carAdvisorName, carAdvisorSurname, carAdvisorEmail, carAdvisorSpecialisation)
VALUES
    ('Chantel', 'Mororo', 'Chantel.Mororo@EDULAUNCH.COM', 'Interview Preparation'),
    ('Lesego', 'Rangoaga-Masha', 'Lesego.Rangoaga-Masha@EDULAUNCH.COM', 'Career Guidance'),
    ('Palesa', 'Matlala', 'Palesa.Matlala@EDULAUNCH.COM', 'CV Support'),
    ('Jeremiah', 'Williams', 'Jeremiah.Williams@EDULAUNCH.COM', 'Entreprenuership Guidance');
----------------------------------------------------------------------------------------------------------------------------------

--   ----------------------------------  3. Inserting into CAREER PROGRAMME Table  -----------------------------------------------
INSERT INTO career_programme (carAdvisorID, carProgrammeTitle, carProgrammeCategory, carProgrammeLevel, carProgrammeCapacityLimit)
VALUES 
    (4, 'Personal Branding Concepts', 'Entreprenuership Guidance', 'Advanced', 4),
    (2, 'Career Guidance Foundations', 'Career Guidance', 'Foundation', 16),
    (3, 'CV Design Concepts', 'CV Support', 'Foundation', 8),
    (3, 'CV Writing', 'CV Support', 'Intermediate', 12),
    (1, 'Interview Practice', 'Interview Preparation', 'Advanced', 8);
-- --------------------------------------------------------------------------------------------------------------------------------

--   ----------------------------------  4. Inserting into PROGRAMME ENROLMENT Table ----------------------------------------------
INSERT INTO programme_enrolment (studentID, carProgrammeID, prgmEnrolmentDate)
VALUES 
    (1, 5, '2026-02-14'), 
    (1, 4, '2026-03-01'),
    (5, 4, '2026-01-20'),
    (5, 3, '2026-02-10'),
    (3, 1, '2026-03-15'),
    (8, 1, '2026-04-05'), 
    (4, 2, '2026-03-22');
-- ----------------------------------------------------------------------------------------------------------------------------------

--   ------------------=--------------  5. Inserting into LEARINIG ACTIVITY Table  --------------------------------------------------
INSERT INTO learning_activity (carProgrammeID, lrngActivityTitle)
VALUES
    (1, 'LinkedIn for Personal Branding'),
    (1, 'Professional Networking Events'),
    (2, 'Possible Career Pathways'),
    (5, 'Interview Practice'),
    (5, 'Interview Practice Feedback'),
    (4, 'Professional CV Writing'),
    (4, 'Drafting your Bio'),
    (4, 'Compiling Work Experience or Education'),
    (3, 'Working with CV Templates');
-- ------------------------------------------------------------------------------------------------------------------------------------

--   --------------------------------  6. Inserting into LEARING ACTIVITY PROGRESS Table  ---------------------------------------------
INSERT INTO learning_activity_progress (studentID, lrngActivityID, lrngActCompletionStatus, lrngActProgressPercentage, carReadinessPointsEarned)
VALUES 
    (3, 1, 'Completed', 100, 20),
    (3, 2, 'In Progress', 40, 8), 
    (8, 1, 'In Progress', 20, 4),
    (8, 2, 'Not Started', 0, 0),
    (1, 4, 'In Progress', 0, 0),
    (1, 5, 'Not Started', 0, 0),
    (1, 6, 'Completed', 100, 20),
    (1, 7, 'Completed', 100, 20),
    (1, 8, 'In progress', 80, 16),
    (5, 6, 'In progress', 40, 8),
    (5, 7, 'Completed', 100, 20), 
    (5, 8, 'Completed', 100, 20), 
    (5, 9, 'Completed', 100, 20),
    (4, 3, 'In Progress', 60, 12);
-- ---------------------------------------------------------------------------------------------------------------------------------------

--   -------------------------------  7. Inserting into ASSESSMENT Table  ----------------------------------------------------------------
INSERT INTO assessment (carProgrammeID, assessmentTitle, assessmentType)
VALUES 
    (1, 'LinkedIn Workshop', 'Practical Workshop Tasks'),
    (1, 'Marketing', 'Quiz'),
    (4, 'CV Writing', 'Creative Writing Exam'),
    (4, 'Peer-To-Peer CV Review', 'CV Review'),
    (4, 'CV Writing Best Practices', 'Quiz'),
    (3, 'CV Design Best Practices', 'Quiz'),
    (5, 'Mock Interview', 'Practical'),
    (5, 'Higher Order Mock Interview', 'Practical'),
    (2, 'Career Pathway Mapping', 'Practical Task');
-- --------------------------------------------------------------------------------------------------------------------------------------

--    ------------------------------  8. Inserting into ASSESSMENT RESULT Table  --------------------------------------------------------
INSERT INTO assessment_result (studentID, assessmentID, assMarksObtained, carReadinessScoreGained)
VALUES 
    (1, 3, 92.00, 36),
    (1, 4, 88.50, 36),
    (1, 5, 81.00, 32), 
    (5, 4, 65.00, 26),
    (5, 5, 89.00, 36),
    (5, 6, 95.00, 38),
    (3, 1, 94.00, 38),
    (3, 2, 58.00, 24),
    (8, 1, 42.00, 16),
    (4, 9, 68.00, 28);
-- ---------------------------------------------------------------------------------------------------------------------------------------

--   -----------------------------  9. Inserting into CAREER RESOURCE Table  -------------------------------------------------------------
INSERT INTO career_resource (carResourceTitle, carResourceType, carResourceSize_mb, carResourceNumDownloads)
VALUES
    ('Professional CV Templates', 'CV Template', 5.4, 23),
    ('Marketing Student Guide', 'PDF Guide', 25.67, 17),
    ('Personal Branding Concepts', 'Slides', 4.34, 2),
    ('CV Design Foundations', 'Slides', 12.46, 19),
    ('How to Write a CV Series', 'Videos', 232.16, 10),
    ('How to Prepare for an Interview', 'Video', 50.76, 26),
    ('Workplace Readiness Guide', 'PDF Guide', 13.33, 8),
    ('Career Guidance Workbook', 'Career Planning', 4.65, 12), 
    ('English Dictionary', 'PDF', 10.78, 14); 
-- ----------------------------------------------------------------------------------------------------------------------------------------

--   ----------------------------  10. Inserting into STUDENT RESOURCE  -------------------------------------------------------------------
INSERT INTO student_resource (studentID, carResourceID)
VALUES 
    (5, 1), (5, 4), (5, 5),
    (1, 6), (1, 5),
    (8, 2), (8, 3),
    (3, 2),
    (4, 8),
    (2, 9);
-- ------------------------------------------------------------------------------------------------------------------------------------------

--   ---------------------------  11. Inserting into ERROR EVENT LOG Table  -----------------------------------------------------------------
INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage, errEventTimestamp)
VALUES
    (NULL, 'Programme Enrolment', 'The programme is full', '2026-02-15 11:46:00'),
    (5, 'Assessment Submission', 'Submission failed, The only acceptable formats are PDF, DOCX and TEXT', '2026-04-17 09:38:00'),
    (2, 'Login Failure', 'Your Access has expired', '2026-05-01 09:04:00'),
    (NULL, 'Login Failure', 'Please enter a valid student number', '2026-06-16 13:59:00'),
    (3, 'Resource Storage', 'Your storage is full', '2026-07-25 18:23:00');
-- ===========================================================================================================================================