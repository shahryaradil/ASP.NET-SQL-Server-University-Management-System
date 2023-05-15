CREATE DATABASE DBPROJECT;

USE DBPROJECT;

DROP DATABASE DBPROJECT

CREATE TABLE SECTIONS
(
	sectionID INT PRIMARY KEY,
	sectionName VARCHAR(1)
)

CREATE TABLE USERS (
    userID VARCHAR(10) PRIMARY KEY,
    name VARCHAR(20),
    CNIC VARCHAR(20),
    DOB DATE,
    gender VARCHAR(6),
	email VARCHAR(20),
	phone VARCHAR(20),
	address VARCHAR(30),
	campus VARCHAR(10)
)

CREATE TABLE STUDENTS (
    userID VARCHAR(10) PRIMARY KEY,
	degreeProgram VARCHAR(10),
    parentSectionID INT REFERENCES SECTIONS(sectionID),
	program VARCHAR(10),
    FOREIGN KEY (userID) REFERENCES USERS(userID)
)

CREATE TABLE FACULTY (
    userID VARCHAR(10) PRIMARY KEY,
    qualification VARCHAR(30),
    FOREIGN KEY (userID) REFERENCES USERS(userID)
)

CREATE TABLE ACADEMICOFFICERS (
    userID VARCHAR(10) PRIMARY KEY,
    FOREIGN KEY (userID) REFERENCES USERS(userID)
)

CREATE TABLE COURSES
(
	courseCode VARCHAR(6) PRIMARY KEY,
	courseName VARCHAR(20),
	creditHrs INT,
	prerequisite VARCHAR(20),
	electiveAssigned VARCHAR(10),
	semester INT,
	courseCoordinator VARCHAR(20)
)

CREATE TABLE AUDITTRAIL
(
	dateTime DATETIME,
	operation VARCHAR(50),
)

CREATE TABLE FEEDBACK
(
	feedbackID INT PRIMARY KEY,
	studentID VARCHAR(10),
	teacherID VARCHAR(10),
	dateAndTime DATETIME,
	feedbackElement VARCHAR(40),
	elementValue VARCHAR(25),
	FOREIGN KEY (studentID) REFERENCES STUDENTS(userID),
	FOREIGN KEY (teacherID) REFERENCES FACULTY(userID)
)

CREATE TABLE MARKS
(
	studentID VARCHAR(10),
	courseCode VARCHAR(6),
	semester INT,
	obtainedMarks INT,
	totalMarks INT,
	assesmentType VARCHAR(10),

	FOREIGN KEY (studentID) REFERENCES STUDENTS(userID),
	FOREIGN KEY (courseCode) REFERENCES COURSES(courseCode)
)

CREATE TABLE GRADES
(
	grade VARCHAR(2),
	courseCode VARCHAR(6),
	studentID VARCHAR(10),
	FOREIGN KEY (studentID) REFERENCES STUDENTS(userID),
	FOREIGN KEY (courseCode) REFERENCES COURSES(courseCode)
)

CREATE TABLE STUDENTRECORD
(
	studentID VARCHAR(10),
	currentSemester INT,
	creditHrs INT,
	warningCount INT,
	degreeStartYear INT,
	FOREIGN KEY (studentID) REFERENCES STUDENTS(userID)
)

CREATE TABLE COURSETEACHING
(
	courseCode VARCHAR(6),
	teacherID VARCHAR(10),
	sectionID INT,
	FOREIGN KEY (teacherID) REFERENCES FACULTY(userID),
	FOREIGN KEY (courseCode) REFERENCES COURSES(courseCode),
	FOREIGN KEY (sectionID) REFERENCES SECTIONS(sectionID)
)

CREATE TABLE COURSEMARKSDISTRIBUTION
(
    courseCode VARCHAR(6),
    teacherID VARCHAR(10),
    projectWeightage INT,
    quizCount INT,
    quizWeightage INT,
    assignmentCount INT,
    assignmentWeightage INT,
    mid1Weightage INT,
    mid2Weightage INT,
    finalWeightage INT,
    FOREIGN KEY (teacherID) REFERENCES FACULTY(userID),
    FOREIGN KEY (courseCode) REFERENCES COURSES(courseCode),
)

CREATE TABLE LOGINDETAILS
(
	userID VARCHAR(10),
	password varchar(10),
	FOREIGN KEY (userID) REFERENCES USERS(userID)
)

CREATE TABLE ATTENDANCE
(
	lectureNum int,
	studentID VARCHAR(10),
	subjectCode VARCHAR(6),
	statusAttendance VARCHAR(1), /*A FOR ABSENT, P FOR PRESENT, L FOR LATE*/
	duration FLOAT,
	dateAndTime DATETIME
)

CREATE TABLE COURSETAKING
(
	studentID VARCHAR(10),
	courseCode VARCHAR(6),
	sectionID INT,
	active VARCHAR(1),
	semester INT,
    FOREIGN KEY (studentID) REFERENCES STUDENTS(userID),
    FOREIGN KEY (courseCode) REFERENCES COURSES(courseCode)
)

DROP TABLE STUDENTRECORD
DROP TABLE GRADES
DROP TABLE FEEDBACK
DROP table ACADEMICOFFICERS
DROP TABLE ATTENDANCE
DROP TABLE AUDITTRAIL
DROP TABLE COURSEMARKSDISTRIBUTION
DROP TABLE COURSETAKING
DROP TABLE COURSETEACHING
DROP TABLE FACULTY
DROP TABLE LOGINDETAILS
DROP TABLE MARKS
DROP TABLE STUDENTS
DROP TABLE SECTIONS
DROP TABLE USERS
DROP TABLE COURSES

CREATE TRIGGER AuditInsertTriggerSECTIONS
ON SECTIONS
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE SECTIONS'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerSECTIONS
ON SECTIONS
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE SECTIONS'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerUSERS 
ON USERS 
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL  (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE USERS'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerUSERS
ON USERS
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE USERS'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerSTUDENTS
ON STUDENTS
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE STUDENTS'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerSTUDENTS
ON STUDENTS
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE STUDENTS'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerFACULTY
ON FACULTY
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE FACULTY'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerFACULTY
ON FACULTY
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE FACULTY'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerACADEMICOFFICERS 
ON ACADEMICOFFICERS 
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE ACADEMICOFFICERS'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerACADEMICOFFICERS
ON ACADEMICOFFICERS
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE ACADEMICOFFICERS'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerCOURSES
ON COURSES
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE COURSES'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerCOURSES
ON COURSES
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE COURSES'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerFEEDBACK
ON FEEDBACK
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE FEEDBACK'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerFEEDBACK
ON FEEDBACK
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE FEEDBACK'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerMARKS
ON MARKS
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE MARKS'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerMARKS
ON MARKS
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE MARKS'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerGRADES
ON GRADES
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE GRADES'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerGRADES
ON GRADES
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE GRADES'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerSTUDENTRECORD
ON STUDENTRECORD
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE STUDENTRECORD'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerSTUDENTRECORD
ON STUDENTRECORD
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE STUDENTRECORD'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerCOURSETEACHING
ON COURSETEACHING
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE COURSETEACHING'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerCOURSETEACHING
ON COURSETEACHING
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE COURSETEACHING'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerCOURSEMARKSDISTRIBUTION
ON COURSEMARKSDISTRIBUTION
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE COURSEMARKSDISTRIBUTION'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerCOURSEMARKSDISTRIBUTION
ON COURSEMARKSDISTRIBUTION
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE COURSEMARKSDISTRIBUTION'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerLOGINDETAILS
ON LOGINDETAILS
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE LOGINDETAILS'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerLOGINDETAILS
ON LOGINDETAILS
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE LOGINDETAILS'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerATTENDANCE
ON ATTENDANCE
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE ATTENDANCE'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerATTENDANCE
ON ATTENDANCE
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE ATTENDANCE'
    FROM deleted
END
GO

CREATE TRIGGER AuditInsertTriggerCOURSETAKING
ON COURSETAKING
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'INSERT INTO TABLE COURSETAKING'
    FROM inserted
END
GO

CREATE TRIGGER AuditDeleteTriggerCOURSETAKING
ON COURSETAKING
AFTER DELETE
AS
BEGIN
    INSERT INTO AUDITTRAIL (dateTime, operation)
    SELECT GETDATE(), 'DELET FROM TABLE COURSETAKING'
    FROM deleted
END
GO

INSERT INTO SECTIONS (sections.sectionID, sectionName) VALUES (1, 'Y')

INSERT INTO USERS (userID, name, CNIC, DOB, GENDER, EMAIL, PHONE, ADDRESS, CAMPUS) VALUES ('i210771', 'shahryar', '61101-20262090-4', '2002-07-29', 'male', 'shahryar@gmail.com', '0335-0945539', 'Islamabad', 'Islamabad')
INSERT INTO USERS (userID, name, CNIC, DOB, GENDER, EMAIL, PHONE, ADDRESS, CAMPUS) VALUES (2396, 'ejaz', '61101-20262090-4', '2002-07-29', 'male', 'ejaz@gmail.com', '0335-0945539', 'Islamabad', 'Islamabad')
INSERT INTO USERS (userID, name, CNIC, DOB, GENDER, EMAIL, PHONE, ADDRESS, CAMPUS) VALUES (2425, 'amir', '61101-20262090-4', '2002-07-29', 'male', 'amir@gmail.com', '0335-0945539', 'Islamabad', 'Islamabad')
INSERT INTO USERS (userID, name, CNIC, DOB, GENDER, EMAIL, PHONE, ADDRESS, CAMPUS) VALUES (4, 'Shujaat Hussain', '61101-20262090-4', '2002-07-29', 'male', '@gmail.com', '0335-0945539', 'Karachi', 'Karachi')

INSERT INTO STUDENTS (parentSectionID, degreeProgram, userID) VALUES (1, 'Bachelor''s', 'i210771')
INSERT INTO FACULTY(qualification, userID) VALUES ('saudia', 2396)
INSERT INTO ACADEMICOFFICERS(userID) VALUES (2425)

INSERT INTO STUDENTRECORD (studentID, currentSemester, creditHrs, warningCount, degreeStartYear) VALUES ('i210771', 1, 0, 0, 2021)

INSERT INTO LOGINDETAILS (userID, password) VALUES ('i210771', '1')
INSERT INTO LOGINDETAILS (userID, password) VALUES (2396, '1');
INSERT INTO LOGINDETAILS (userID, password) VALUES (2425, '1');

INSERT INTO COURSES (courseCode, courseName, creditHrs, prerequisite, electiveAssigned, semester, courseCoordinator) VALUES ('C001', 'Comm & Pres', 3, 'None', 'No', 1, 'Shujat');
INSERT INTO COURSES (courseCode, courseName, creditHrs, prerequisite, electiveAssigned, semester, courseCoordinator) VALUES ('C002', 'OOP', 4, 'None', 'No', 2, 'Shujat');
INSERT INTO COURSES (courseCode, courseName, creditHrs, prerequisite, electiveAssigned, semester, courseCoordinator) VALUES ('C003', 'DLD', 3, 'C001', 'No', 3, 'Shujat');

INSERT INTO FEEDBACK (feedbackID, studentID, teacherID, dateAndTime, feedbackElement, elementValue) VALUES (1, 'i210771', 2399, '2023-05-12 14:00:00', 'Teaching', 'Good');
INSERT INTO FEEDBACK (feedbackID, studentID, teacherID, dateAndTime, feedbackElement, elementValue) VALUES (2, 'i210771', 2396, '2023-05-12 14:00:00', 'Appearance and Personal Presentation', '5');
INSERT INTO FEEDBACK (feedbackID, studentID, teacherID, dateAndTime, feedbackElement, elementValue) VALUES (3, 'i210771', 2396, '2023-05-12 14:00:00', 'Professional Practices', '5');

INSERT INTO MARKS (studentID, courseCode, obtainedMarks, totalMarks, assesmentType, semester) VALUES ('i210771', 'C001', 80, 100, 'Midterm', 1);
INSERT INTO MARKS (studentID, courseCode, obtainedMarks, totalMarks, assesmentType, semester) VALUES ('i210771', 'C002', 90, 100, 'Midterm', 2);
INSERT INTO MARKS (studentID, courseCode, obtainedMarks, totalMarks, assesmentType, semester) VALUES ('i210771', 'C003', 75, 100, 'Midterm', 3);

INSERT INTO GRADES (grade, courseCode, studentID) VALUES ('A', 'C001', 'i210771');
INSERT INTO GRADES (grade, courseCode, studentID) VALUES ('B', 'C002', 'i210771');
INSERT INTO GRADES (grade, courseCode, studentID) VALUES ('C-', 'C003', 'i210771');

INSERT INTO COURSETEACHING (courseCode, teacherID, sectionID) VALUES ('C001', '2', 'i210771');
INSERT INTO COURSETEACHING (courseCode, teacherID, sectionID) VALUES ('C002', '2', 'i210771');
INSERT INTO COURSETEACHING (courseCode, teacherID, sectionID) VALUES ('C003', '2', 'i210771');

INSERT INTO COURSEMARKSDISTRIBUTION (courseCode, teacherID, projectWeightage, quizCount, quizWeightage, assignmentCount, assignmentWeightage, mid1Weightage, mid2Weightage, finalWeightage) VALUES ('C001', '2', 20, 4, 10, 2, 10, 20, 20, 40);
INSERT INTO COURSEMARKSDISTRIBUTION (courseCode, teacherID, projectWeightage, quizCount, quizWeightage, assignmentCount, assignmentWeightage, mid1Weightage, mid2Weightage, finalWeightage) VALUES ('C002', '2', 15, 3, 8, 3, 15, 15, 20, 40);
INSERT INTO COURSEMARKSDISTRIBUTION (courseCode, teacherID, projectWeightage, quizCount, quizWeightage, assignmentCount, assignmentWeightage, mid1Weightage, mid2Weightage, finalWeightage) VALUES ('C003', '2', 10, 2, 5, 4, 20, 10, 15, 30);

INSERT INTO ATTENDANCE (lectureNum, studentID, subjectCode, statusAttendance, duration, dateAndTime) VALUES (1, 'i210771', 'C001', 'P', 1.5, '2023-05-12 09:00:00');
INSERT INTO ATTENDANCE (lectureNum, studentID, subjectCode, statusAttendance, duration, dateAndTime) VALUES (1, 'i210771', 'C002', 'A', 1.5, '2023-05-13 10:00:00');
INSERT INTO ATTENDANCE (lectureNum, studentID, subjectCode, statusAttendance, duration, dateAndTime) VALUES (1, 'i210771', 'C003', 'L', 1.5, '2023-05-14 11:00:00');

--INSERT INTO COURSETAKING (studentID, courseCode, sectionID, active, semester) VALUES ('1', 'C001', 1, 'Y', 3);
--INSERT INTO COURSETAKING (studentID, courseCode, sectionID, active, semester) VALUES ('1', 'C002', 1, 'Y', 4);
--INSERT INTO COURSETAKING (studentID, courseCode, sectionID, active, semester) VALUES ('1', 'C003', 1, 'Y', 2);

-- View Audit Trail

SELECT * FROM AUDITTRAIL