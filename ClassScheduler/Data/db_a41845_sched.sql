-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 15, 2019 at 10:06 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_a41845_sched`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `checkForExistingSection` (IN `i_academicsemesterID` INT, IN `i_courseID` INT, IN `i_sectionnumber` INT)  BEGIN
	SELECT * FROM Sections
	WHERE AcademicSemesterID = i_academicsemesterID
	AND CourseID = i_courseID 
	AND Number = i_sectionnumber;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteAcademicSemester` (IN `i_academicsemesterID` INT)  BEGIN
  DELETE FROM AcademicSemesters WHERE AcademicSemesterID = i_academicsemesterID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteBuilding` (IN `i_BuildingID` INT)  BEGIN
  DELETE FROM Buildings WHERE BuildingID = i_BuildingID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteCampus` (IN `i_CampusID` INT)  BEGIN
  DELETE FROM Campuses WHERE CampusID = i_CampusID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteCourse` (IN `i_CourseID` INT)  BEGIN
  DELETE FROM Courses WHERE CourseID = i_CourseID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteDay` (IN `i_DayID` INT)  BEGIN
  DELETE FROM Days WHERE DayID = i_DayID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteDepartment` (IN `i_DepartmentID` INT)  BEGIN
  DELETE FROM Departments WHERE DepartmentID = i_DepartmentID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteFee` (IN `i_FeeID` INT)  BEGIN
  DELETE FROM Fees WHERE FeeID = i_FeeID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteInstructor` (IN `i_InstructorID` INT)  BEGIN
  DELETE FROM Instructors WHERE InstructorID = i_InstructorID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteInstructorToSection` (IN `i_instructortosectionID` INT)  BEGIN
  DELETE FROM InstructorToSections WHERE InstructorToSectionID = i_instructortosectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deletePartOfTerm` (IN `i_PartOfTermID` INT)  BEGIN
  DELETE FROM PartOfTerm WHERE PartOfTermID = i_PartOfTermID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteRole` (IN `i_RoleID` INT)  BEGIN
  DELETE FROM Roles WHERE RoleID = i_RoleID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteRoom` (IN `i_RoomID` INT)  BEGIN
  DELETE FROM Rooms WHERE RoomID = i_RoomID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteScheduleType` (IN `i_ScheduleTypeID` INT)  BEGIN
  DELETE FROM ScheduleTypes WHERE ScheduleTypeID = i_ScheduleTypeID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteSection` (IN `i_SectionID` INT)  BEGIN
  DELETE FROM Sections WHERE SectionID = i_SectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteSectionFee` (IN `i_SectionFeeID` INT)  BEGIN
    DELETE FROM SectionFees WHERE SectionFeeID = i_SectionFeeID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteSemester` (IN `i_SemesterID` INT)  BEGIN
    DELETE FROM Semesters WHERE SemesterID = i_SemesterID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteSpreadsheetVariable` (IN `i_spreadsheetvariableID` INT)  BEGIN
  DELETE FROM SpreadsheetVariables WHERE SpreadsheetVariableID = i_spreadsheetvariableID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteSubject` (IN `i_subject_id` INT)  BEGIN
  DELETE FROM Subjects WHERE SubjectID = i_subject_id;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `deleteUser` (IN `i_UserID` INT)  BEGIN
    DELETE FROM Users WHERE UserID = i_UserID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getAcademicSemesterByID` (IN `i_AcademicSemesterID` INT)  BEGIN
  SELECT * FROM AcademicSemesters WHERE AcademicSemesterID = i_AcademicSemesterID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getAcademicSemesters` ()  BEGIN
  SELECT * FROM AcademicSemesters;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getAcademicYearByID` (IN `i_academicyear_id` INT)  BEGIN
  SELECT * FROM AcademicYears WHERE AcademicYearID = i_academicyear_id;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getAcademicYears` ()  BEGIN
  SELECT * FROM AcademicYears;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getBuildingByID` (IN `i_BuildingID` INT)  BEGIN
  SELECT * FROM Buildings WHERE BuildingID = i_BuildingID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getBuildings` ()  BEGIN
  SELECT * FROM Buildings;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getCampusByID` (IN `i_CampusID` INT)  BEGIN
  SELECT * FROM Campuses WHERE CampusID = i_CampusID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getCampuses` ()  BEGIN
  SELECT * FROM Campuses;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getChangeLogBySectionID` (IN `i_SectionID` INT)  BEGIN
  SELECT * FROM changelogs WHERE SectionID = i_SectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getCourseByID` (IN `i_CourseID` INT)  BEGIN
  SELECT * FROM Courses WHERE CourseID = i_CourseID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getCourses` ()  BEGIN
  SELECT * FROM Courses;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getCourseByDepartmentNumberAndTitle`(IN `i_DepartmentAbbreviation` varchar(255), IN `i_Number` int, IN `i_Title` varchar(255))
BEGIN
  SELECT * FROM Courses c
	JOIN Departments d ON c.DepartmentID = d.DepartmentID
    WHERE d.Abbreviation = i_DepartmentAbbreviation AND c.Number = i_Number AND c.Title = i_Title;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getDayByAbbreviation` (IN `abbreviation` VARCHAR(255))  BEGIN
  SELECT * FROM Days WHERE Abbreviation = abbreviation;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getDayByID` (IN `i_DayID` INT)  BEGIN
  SELECT * FROM Days WHERE DayID = i_DayID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getDays` ()  BEGIN
  SELECT * FROM Days;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getDaysBySectionID` (IN `i_sectionID` INT, IN `i_DateToCheck` DATETIME)  BEGIN
  SELECT * FROM Days AS d
  JOIN SectionDays AS sd ON sd.DayID = d.DayID
  JOIN Sections AS s ON s.SectionID = sd.SectionID
  WHERE s.SectionID = i_sectionID AND sd.DateArchived > i_DateToCheck
  ORDER BY d.DayID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getDepartmentByAbbreviation` (IN `abbreviation` VARCHAR(255))  BEGIN
  SELECT * FROM Departments WHERE Abbreviation = abbreviation;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getDepartmentByID` (IN `i_DepartmentID` INT)  BEGIN
  SELECT * FROM Departments WHERE DepartmentID = i_DepartmentID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getDepartments` ()  BEGIN
  SELECT * FROM Departments;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getFeeByDetailCode` (IN `detailcode` VARCHAR(255))  BEGIN
  SELECT * FROM Fees WHERE DetailCode = detailcode;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getFeeByID` (IN `i_FeeID` INT)  BEGIN
  SELECT * FROM Fees WHERE FeeID = i_FeeID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getFees` ()  BEGIN
  SELECT * FROM Fees;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getFeesBySectionID` (IN `i_sectionID` INT)  BEGIN
  SELECT f.FeeID, f.DetailCode FROM Fees AS f 
  JOIN SectionFees AS sf ON sf.FeeID = f.FeeID
  JOIN Sections AS s ON s.SectionID = sf.SectionID
  WHERE s.SectionID = i_sectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getInstructorByFirstAndLastName` (IN `i_firstname` VARCHAR(255), IN `i_lastname` VARCHAR(255))  BEGIN
  SELECT * FROM Instructors WHERE FirstName LIKE i_firstname AND LastName LIKE i_lastname;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getInstructorByID` (IN `i_InstructorID` INT)  BEGIN
  SELECT * FROM Instructors WHERE InstructorID = i_InstructorID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getInstructors` ()  BEGIN
  SELECT * FROM Instructors;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getInstructorsBySectionID` (IN `i_sectionID` INT, IN `i_DateToCheck` DATETIME)  BEGIN
  SELECT * FROM InstructorToSections
  WHERE SectionID = i_SectionID AND DateArchived > i_DateToCheck
  ORDER BY IsPrimary DESC;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getInstructorsToSectionByInstructorIDAndSectionID` (IN `i_instructorID` INT, IN `i_sectionID` INT)  BEGIN
  SELECT * FROM InstructorToSections WHERE InstructorID = i_instructorID AND SectionID = i_sectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getInstructorToSectionByID` (IN `i_instructortosectionID` INT)  BEGIN
  SELECT * FROM InstructorToSections WHERE InstructorToSectionID = i_instructortosectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getInstructorToSections` ()  BEGIN
  SELECT * FROM InstructorToSections WHERE DateArchived > NOW();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getInstructorToSectionsBySectionID` (IN `i_SectionID` INT)  BEGIN
	SELECT i.InstructorToSectionID, i.TeachingPercentage, i.InstructorID, i.SectionID FROM InstructorToSections as i
	JOIN Sections as s ON s.SectionID = i.SectionID
	WHERE s.SectionID = i_SectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getInstructorToSectionsByAcademicSemesterID`(IN `i_AcademicSemesterID` INT)
BEGIN
SELECT InstSec.InstructorToSectionID, InstSec.IsPrimary, InstSec.TeachingPercentage, InstSec.DateArchived, InstSec.InstructorID, InstSec.SectionID FROM InstructorToSections as InstSec
	JOIN Sections ON InstSec.SectionID = Sections.SectionID
    JOIN AcademicSemesters ON AcademicSemesters.AcademicSemesterID = Sections.AcademicSemesterID
    WHERE AcademicSemesters.AcademicSemesterID = i_AcademicSemesterID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getPartOfTerm` ()  BEGIN
  SELECT * FROM PartOfTerm;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getPartOfTermByAbbreviation` (IN `abbreviation` VARCHAR(255))  BEGIN
  SELECT * FROM PartOfTerm WHERE Abbreviation = abbreviation;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getPartOfTermByID` (IN `i_PartOfTermID` INT)  BEGIN
  SELECT * FROM PartOfTerm WHERE PartOfTermID = i_PartOfTermID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getPartOfTerms` ()  BEGIN
  SELECT * FROM PartOfTerm;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getRoleByID` (IN `i_RoleID` INT)  BEGIN
  SELECT * FROM Roles WHERE RoleID = i_RoleID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getRoles` ()  BEGIN
  SELECT * FROM Roles;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getRoomByID` (IN `i_RoomID` INT)  BEGIN
  SELECT * FROM Rooms WHERE RoomID = i_RoomID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getRoomByNumberAndBuildingAbbreviation` (IN `i_Number` INT, IN `i_Abbreviation` VARCHAR(255))  BEGIN
  SELECT * FROM Rooms AS r JOIN Buildings AS b on r.BuildingID = b.BuildingID WHERE r.Number = i_Number AND b.Abbreviation = i_Abbreviation;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getRooms` ()  BEGIN
  SELECT * FROM Rooms;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getScheduleTypeByAbbreviation` (IN `i_Abbreviation` VARCHAR(255))  BEGIN
  SELECT * FROM ScheduleTypes WHERE Abbreviation = i_Abbreviation;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getScheduleTypeByID` (IN `i_ScheduleTypeID` INT)  BEGIN
  SELECT * FROM ScheduleTypes WHERE ScheduleTypeID = i_ScheduleTypeID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getScheduleTypes` ()  BEGIN
  SELECT * FROM ScheduleTypes;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSectionByID` (IN `i_sectionID` INT)  BEGIN
  SELECT * FROM Sections WHERE SectionID = i_sectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSectionDayByDayIDAndSectionID` (IN `i_DayID` INT, IN `i_SectionID` INT)  BEGIN
  SELECT * FROM SectionDays WHERE DayID = i_DayID AND SectionID = i_SectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSectionDayByID` (IN `i_SectionDayID` INT)  BEGIN
  SELECT * FROM SectionDays WHERE SectionDayID = i_SectionDayID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSectionDays` ()  BEGIN
	SELECT * FROM SectionDays;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSectionDaysBySectionID` (IN `i_sectionID` INT, IN `i_DateToCheck` DATETIME)  BEGIN
  SELECT * FROM SectionDays
  WHERE SectionID = i_SectionID AND DateArchived > i_DateToCheck
  ORDER BY DayID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSectionFeeByID` (IN `i_SectionFeeID` INT)  BEGIN
	SELECT * FROM SectionFees WHERE SectionFeeID = i_SectionFeeID; 
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSectionFees` ()  BEGIN
	SELECT * FROM SectionFees;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSectionFeesByFeeID` (IN `i_FeeID` INT)  BEGIN
	SELECT * FROM SectionFees WHERE FeeID = i_FeeID; 
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSectionFeesBySectionID` (IN `i_SectionID` INT)  BEGIN
	SELECT * FROM SectionFees WHERE SectionID = i_SectionID; 
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSections` ()  BEGIN
  SELECT * FROM Sections;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSectionsByAcademicSemesterID` (IN `i_academicsemesterID` INT, IN `i_GetDeleted` BIT)  BEGIN
IF i_GetDeleted THEN
  SELECT * FROM Sections WHERE AcademicSemesterID = i_academicsemesterID AND DateArchived > NOW();
  END IF;
  IF NOT i_GetDeleted THEN
	SELECT * FROM Sections WHERE AcademicSemesterID = i_academicsemesterID AND DateArchived > NOW() AND DateDeleted > NOW();
	END IF;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSemesterByID` (IN `i_SemesterID` INT)  BEGIN
	SELECT * FROM Semesters WHERE SemesterID = i_SemesterID; 
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSemesters` ()  BEGIN
	SELECT * FROM Semesters;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSpreadsheetVariableByID` (IN `i_spreadsheetvariableID` INT)  BEGIN
  SELECT * FROM SpreadsheetVariables WHERE SpreadsheetVariableID = i_spreadsheetvariableID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getSpreadsheetVariables` ()  BEGIN
  SELECT * FROM SpreadsheetVariables;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getUserByID` (IN `i_UserID` INT)  BEGIN
	SELECT * FROM Users WHERE UserID = i_UserID; 
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `getUsers` ()  BEGIN
	SELECT * FROM Users;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertAcademicSemester` (IN `i_AcademicYear` INT, IN `i_SemesterID` INT, OUT `i_AcademicSemesterID` INT)  BEGIN
  INSERT INTO AcademicSemesters (AcademicYear, SemesterID) VALUES (i_AcademicYear, i_SemesterID);
  SET i_AcademicSemesterID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertBuilding` (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), IN `i_CampusID` INT, OUT `i_BuildingID` INT)  BEGIN
  INSERT INTO Buildings (Name, Abbreviation, CampusID) VALUES (i_Name, i_Abbreviation, i_CampusID);
  SET i_BuildingID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertCampus` (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_CampusID` INT)  BEGIN
  INSERT INTO Campuses (Name, Abbreviation) VALUES (i_Name, i_Abbreviation);
  SET i_CampusID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertChangeLog` (IN `i_sectionID` INT, IN `i_changedDepartment` BIT, IN `i_changedcoursenumber` BIT, IN `i_changedsectionnumber` BIT, IN `i_changedtitle` BIT, IN `i_changedcampus` BIT, IN `i_changedscheduletype` BIT, IN `i_changedrequiresmoodle` BIT, IN `i_changedrequirespermission` BIT, IN `i_changedpartofterm` BIT, IN `i_changedstudentlimit` BIT, IN `i_changedcreditmax` BIT, IN `i_changedcreditmin` BIT, IN `i_changedfixedcredit` BIT, IN `i_changedmonday` BIT, IN `i_changedtuesday` BIT, IN `i_changedwednesday` BIT, IN `i_changedthursday` BIT, IN `i_changedfriday` BIT, IN `i_changedsaturday` BIT, IN `i_changedsunday` BIT, IN `i_changedstarttime` BIT, IN `i_changedendtime` BIT, IN `i_changedbuilding` BIT, IN `i_changedroom` BIT, IN `i_changedprimeinstructor` BIT, IN `i_changedprimeinstructorpercent` BIT, IN `i_changedsecondinstructor` BIT, IN `i_changedsecondinstructorpercent` BIT, IN `i_changedfeedetailcode` BIT, IN `i_changedfeeamount` BIT, IN `i_changedsectionnotes` BIT, IN `i_changedcrosslistedDepartment` BIT, IN `i_changedcrosslistedsection` BIT, IN `i_changeddepartmentcomments` BIT, OUT `i_ChangeLogID` INT, IN `i_DateImported` DATETIME, IN `i_DateCreated` DATETIME, IN `i_DateDeleted` DATETIME)  BEGIN
	INSERT INTO ChangeLogs (SectionID, ChangedDepartment, ChangedCourseNumber, ChangedSectionNumber, ChangedTitle, 
	ChangedCampus, ChangedScheduleType, ChangedRequiresMoodle, ChangedRequiresPermission, ChangedPartOfTerm, 
	ChangedStudentLimit, ChangedCreditMax, ChangedCreditMin, ChangedFixedCredit, ChangedMonday, ChangedTuesday, 
	ChangedWednesday, ChangedThursday, ChangedFriday, ChangedSaturday, ChangedSunday, ChangedStartTime, ChangedEndTime, 
	ChangedBuilding, ChangedRoom, ChangedPrimeInstructor, ChangedPrimeInstructorPercent, ChangedSecondInstructor, 
	ChangedSecondInstructorPercent, ChangedFeeDetailCode, ChangedFeeAmount, ChangedSectionNotes, ChangedCrossListedDepartment, 
	ChangedCrossListedSection, ChangedDepartmentComments, DateImported, DateCreated, DateDeleted) 
	VALUES (i_sectionID, i_changedDepartment, i_changedcoursenumber, i_changedsectionnumber, i_changedtitle, i_changedcampus, 
	i_changedscheduletype, i_changedrequiresmoodle, i_changedrequirespermission, i_changedpartofterm, i_changedstudentlimit, 
	i_changedcreditmax, i_changedcreditmin, i_changedfixedcredit, i_changedmonday, i_changedtuesday, i_changedwednesday, 
	i_changedthursday, i_changedfriday, i_changedsaturday, i_changedsunday, i_changedstarttime, i_changedendtime, 
	i_changedbuilding, i_changedroom, i_changedprimeinstructor, i_changedprimeinstructorpercent, i_changedsecondinstructor, 
	i_changedsecondinstructorpercent, i_changedfeedetailcode, i_changedfeeamount, i_changedsectionnotes, i_changedcrosslistedDepartment, 
	i_changedcrosslistedsection, i_changeddepartmentcomments, i_DateImported, i_DateCreated, i_DateDeleted);
	SET i_ChangeLogID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertCourse` (IN `i_number` INT, IN `i_title` VARCHAR(255), IN `i_minimumcredits` INT, IN `i_maximumcredits` INT, IN `i_fixedcredits` INT, IN `i_isfixedcredit` BIT, IN `i_DepartmentID` INT, IN `i_Description` VARCHAR(255), OUT `i_CourseID` INT)  BEGIN
	INSERT INTO Courses (Number, Title, MinimumCredits, MaximumCredits, FixedCredits, IsFixedCredit, DepartmentID, Description) VALUES (i_number, i_title, i_minimumcredits, i_maximumcredits, i_fixedcredits, i_isfixedcredit, i_DepartmentID, i_Description);
	SET i_CourseID = last_insert_id();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertDay` (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_DayID` INT)  BEGIN
  INSERT INTO Days (Name, Abbreviation) VALUES (i_Name, i_Abbreviation);
  SET i_DayID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertDepartment` (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_DepartmentID` INT)  BEGIN
  INSERT INTO Departments (Name, Abbreviation) VALUES (i_Name, i_Abbreviation);
  SET i_DepartmentID = last_insert_id();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertFee` (IN `i_DetailCode` VARCHAR(255), OUT `i_FeeID` INT)  BEGIN
  INSERT INTO Fees (DetailCode) VALUES (i_DetailCode);
  SET i_FeeID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertInstructor` (IN `i_FirstName` VARCHAR(255), IN `i_MiddleName` VARCHAR(255), IN `i_LastName` VARCHAR(255), IN `i_Number` INT, IN `i_CourseLoad` INT, OUT `i_InstructorID` INT)  BEGIN
  INSERT INTO Instructors (FirstName, MiddleName, LastName, Number, CourseLoad) VALUES (i_FirstName, i_MiddleName, i_LastName, i_Number, i_CourseLoad);
  SET i_InstructorID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertInstructorToSection` (IN `i_isprimary` INT, IN `i_teachingpercentage` INT, IN `i_datearchived` DATETIME, IN `i_instructorID` INT, IN `i_sectionID` INT, OUT `i_InstructorToSectionID` INT)  BEGIN
  INSERT INTO InstructorToSections (IsPrimary, TeachingPercentage, DateArchived, InstructorID, SectionID) VALUES (i_isprimary, i_teachingpercentage, i_datearchived, i_instructorID, i_sectionID);
  SET i_InstructorToSectionID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertPartOfTerm` (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_PartOfTermID` INT)  BEGIN
  INSERT INTO PartOfTerm (Name, Abbreviation) VALUES (i_Name, i_Abbreviation);
  SET i_PartOfTermID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertRole` (IN `i_Name` VARCHAR(255), IN `i_IsAdmin` BIT, `i_Sections` BIT(4), `i_Courses` BIT(4), `i_Buildings` BIT(4), `i_Campuses` BIT(4), `i_Roles` BIT(4), `i_Users` BIT(4), `i_Departments` BIT(4), `i_Fees` BIT(4), `i_Instructors` BIT(4), `i_Days` BIT(4), `i_Rooms` BIT(4), `i_ScheduleTypes` BIT(4), `i_Spreadsheets` BIT(4))  BEGIN
  INSERT INTO Days (Name, IsAdmin, Sections, Courses, Buildings, Campuses, Roles, Users, Departments, Fees, Instructors, Days, Rooms, ScheduleTypes, Spreadsheets) VALUES (i_Name, i_IsAdmin, i_Sections, i_Courses, i_Buildings, i_Campuses, i_Roles, i_Users, i_Departments, i_Fees, i_Instructors, i_Days, i_Rooms, i_ScheduleTypes, i_Spreadsheets);
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertRoom` (IN `i_Number` VARCHAR(255), IN `i_SeatsAvailable` INT, IN `i_Details` VARCHAR(255), IN `i_BuildingID` INT, OUT `i_RoomID` INT)  BEGIN
  INSERT INTO Rooms (Number, SeatsAvailable, Details, BuildingID) VALUES (i_Number, i_SeatsAvailable, i_Details, i_BuildingID);
  SET i_RoomID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertScheduleType` (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_ScheduleTypeID` INT)  BEGIN
  INSERT INTO ScheduleTypes (Name, Abbreviation) VALUES (i_Name, i_Abbreviation);
  SET i_ScheduleTypeID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertSection` (IN `i_crn` INT, IN `i_requiresmoodle` BIT, IN `i_requirespermission` BIT, IN `i_notes` VARCHAR(255), IN `i_departmentcomments` VARCHAR(255), IN `i_studentlimit` INT, IN `i_datecreated` DATETIME, IN `i_datearchived` DATETIME, IN `i_number` INT, IN `i_starttime` DATETIME, IN `i_endtime` DATETIME, IN `i_courseID` INT, IN `i_roomID` INT, IN `i_scheduletypeID` INT, IN `i_academicsemesterID` INT, IN `i_partoftermID` INT, OUT `i_SectionID` INT, IN `i_DateDeleted` DATETIME, IN `i_XListID` VARCHAR(255))  BEGIN
  INSERT INTO Sections (CRN, RequiresMoodle, RequiresPermission, Notes, DepartmentComments, StudentLimit, DateCreated, DateArchived, DateDeleted, Number, StartTime, EndTime, CourseID, RoomID, ScheduleTypeID, AcademicSemesterID, PartOfTermID, XListID) VALUES (i_crn, i_requiresmoodle, i_requirespermission, i_notes, i_departmentcomments, i_studentlimit, i_datecreated, i_datearchived, i_DateDeleted, i_number, i_starttime, i_endtime, i_courseID, i_roomID, i_scheduletypeID, i_academicsemesterID, i_partoftermID, i_XListID);
  SET i_SectionID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertSectionDay` (IN `i_DayID` INT, IN `i_SectionID` INT, IN `i_DateArchived` DATETIME, OUT `i_SectionDayID` INT)  BEGIN
    INSERT INTO SectionDays (SectionID, DayID, DateArchived) VALUES (i_SectionID, i_DayID, i_DateArchived);
    SET i_SectionDayID = last_insert_id();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertSectionFee` (IN `i_Amount` DECIMAL(13,4), IN `i_SectionID` INT, IN `i_FeeID` INT, OUT `i_SectionFeeID` INT)  BEGIN
    INSERT INTO SectionFees ( SectionID, FeeID, Amount) VALUES (i_SectionID, i_FeeID, i_Amount);
    SET i_SectionFeeID = last_insert_id();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertSemester` (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_SemesterID` INT)  BEGIN
    INSERT INTO Semesters (Name, Abbreviation) VALUES (i_Name, i_Abbreviation);
    SET i_SemesterID = last_insert_id();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertSpreadsheetVariable` (IN `i_spreadsheet` BLOB, IN `i_startrownumber` INT, IN `i_defaultfontsize` INT, IN `i_academicsemester` VARCHAR(255), IN `i_addchangedelete` VARCHAR(255), IN `i_sectioncrn` VARCHAR(255), IN `i_subjectname` VARCHAR(255), IN `i_coursenumber` VARCHAR(255), IN `i_sectionnumber` VARCHAR(255), IN `i_crosslistid` VARCHAR(255), IN `i_coursetitle` VARCHAR(255), IN `i_campus` VARCHAR(255), IN `i_scheduletype` VARCHAR(255), IN `i_moodlerequired` VARCHAR(255), IN `i_instructorapprovalrequired` VARCHAR(255), IN `i_partofterm` VARCHAR(255), IN `i_fixedcredit` VARCHAR(255), IN `i_minimumcredits` VARCHAR(255), IN `i_maximumcredits` VARCHAR(255), IN `i_classlimit` VARCHAR(255), IN `i_monday` VARCHAR(255), IN `i_tuesday` VARCHAR(255), IN `i_wednesday` VARCHAR(255), IN `i_thursday` VARCHAR(255), IN `i_friday` VARCHAR(255), IN `i_saturday` VARCHAR(255), IN `i_sunday` VARCHAR(255), IN `i_starttime` VARCHAR(255), IN `i_endtime` VARCHAR(255), IN `i_building` VARCHAR(255), IN `i_room` VARCHAR(255), IN `i_primaryinstructorfirstname` VARCHAR(255), IN `i_primaryinstructorlastname` VARCHAR(255), IN `i_primaryinstructornumber` VARCHAR(255), IN `i_primaryinstructorteachingpercentage` VARCHAR(255), IN `i_secondaryinstructorfirstname` VARCHAR(255), IN `i_secondaryinstructorlastname` VARCHAR(255), IN `i_secondaryinstructornumber` VARCHAR(255), IN `i_secondaryinstructorteachingpercentage` VARCHAR(255), IN `i_classfeedetailcode` VARCHAR(255), IN `i_classfeeamount` VARCHAR(255), IN `i_sectionnotes` VARCHAR(255), IN `i_crosslistsubject` VARCHAR(255), IN `i_crosslistcoursenumber` VARCHAR(255), IN `i_departmentcomments` VARCHAR(255))  BEGIN
  INSERT INTO SpreadsheetVariables (Spreadsheet, StartRowNumber, DefaultFontSize, AcademicSemester, AddChangeDelete, SectionCRN, SubjectName, CourseNumber, SectionNumber, CrossListID, CourseTitle, Campus, ScheduleType, MoodleRequired, InstructorApprovalRequired, PartOfTerm, FixedCredit, MinimumCredits, MaximumCredits, ClassLimit, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday, StartTime, EndTime, Building, Room, PrimaryInstructorFirstName, PrimaryInstructorLastName, PrimaryInstructorNumber, PrimaryInstructorTeachingPercentage, SecondaryInstructorFirstName, SecondaryInstructorLastName, SecondaryInstructorNumber, SecondaryInstructorTeachingPercentage, ClassFeeDetailCode, ClassFeeAmount, SectionNotes, CrossListSubject, CrossListCourseNumber, DepartmentComments) VALUES (i_spreadsheet, i_startrownumber, i_defaultfontsize, i_academicsemester, i_addchangedelete, i_sectioncrn, i_subjectname, i_coursenumber, i_sectionnumber, i_crosslistid, i_coursetitle, i_campus, i_scheduletype, i_moodlerequired, i_instructorapprovalrequired, i_partofterm, i_fixedcredit, i_minimumcredits, i_maximumcredits, i_classlimit, i_monday, i_tuesday, i_wednesday, i_thursday, i_friday, i_saturday, i_sunday, i_starttime, i_endtime, i_building, i_room, i_primaryinstructorfirstname, i_primaryinstructorlastname, i_primaryinstructornumber, i_primaryinstructorteachingpercentage, i_secondaryinstructorfirstname, i_secondaryinstructorlastname, i_secondaryinstructornumber, i_secondaryinstructorteachingpercentage, i_classfeedetailcode, i_classfeeamount, i_sectionnotes, i_sectionnotes, i_crosslistsubject, i_crosslistcoursenumber, i_departmentcomments);
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `insertUser` (IN `i_RoleID` INT, IN `i_Username` VARCHAR(255), IN `i_Password` VARCHAR(255), OUT `i_UserID` INT)  BEGIN
    INSERT INTO Users (Username, Password, RoleID) VALUES (i_Username, i_Password, i_RoleID);
    SET i_UserID = last_insert_id();
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateAcademicSemester` (IN `i_academicsemesterID` INT, IN `i_semesterID` INT, IN `i_academicyear` INT)  BEGIN
  UPDATE AcademicSemesters SET SemesterID = i_semesterID, AcademicYear = i_academicyear WHERE AcademicSemesterID = i_academicsemesterID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateBuilding` (IN `i_BuildingID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), IN `i_CampusID` INT)  BEGIN
  UPDATE Buildings SET Name = i_Name, Abbreviation = i_Abbreviation, CampusID = i_CampusID WHERE BuildingID = i_BuildingID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateCampus` (IN `i_CampusID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  BEGIN
  UPDATE Campuses SET Name = i_Name, Abbreviation = i_Abbreviation WHERE CampusID = i_CampusID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateChangeLog` (IN `i_changelogID` INT, IN `i_sectionID` INT, IN `i_changedcoursenumber` BIT, IN `i_changedsectionnumber` BIT, IN `i_changedtitle` BIT, IN `i_changedcampus` BIT, IN `i_changedscheduletype` BIT, IN `i_changedrequiresmoodle` BIT, IN `i_changedrequirespermission` BIT, IN `i_changedpartofterm` BIT, IN `i_changedstudentlimit` BIT, IN `i_changedcreditmax` BIT, IN `i_changedcreditmin` BIT, IN `i_changedfixedcredit` BIT, IN `i_changedmonday` BIT, IN `i_changedtuesday` BIT, IN `i_changedwednesday` BIT, IN `i_changedthursday` BIT, IN `i_changedfriday` BIT, IN `i_changedsaturday` BIT, IN `i_changedsunday` BIT, IN `i_changedstarttime` BIT, IN `i_changedendtime` BIT, IN `i_changedbuilding` BIT, IN `i_changedroom` BIT, IN `i_changedprimeinstructor` BIT, IN `i_changedprimeinstructorpercent` BIT, IN `i_changedsecondinstructor` BIT, IN `i_changedsecondinstructorpercent` BIT, IN `i_changedfeedetailcode` BIT, IN `i_changedfeeamount` BIT, IN `i_changedsectionnotes` BIT, IN `i_changedcrosslistedDepartment` BIT, IN `i_changedcrosslistedsection` BIT, IN `i_changeddepartmentcomments` BIT, IN `i_DateCreated` DATETIME, IN `i_DateImported` DATETIME, IN `i_DateDeleted` DATETIME)  BEGIN
	UPDATE ChangeLogs SET SectionID = i_sectionID, ChangedCourseNumber = i_changedcoursenumber,
	ChangedSectionNumber = i_changedsectionnumber,  ChangedTitle = i_changedtitle, ChangedCampus = i_changedcampus,
	ChangedScheduleType = i_changedscheduletype, ChangedRequiresMoodle = i_changedrequiresmoodle,
	ChangedRequiresPermission = i_changedrequirespermission, ChangedPartOfTerm = i_changedpartofterm,
	ChangedStudentLimit = i_changedstudentlimit, ChangedCreditMax = i_changedcreditmax, ChangedCreditMin = i_changedcreditmin,
	ChangedFixedCredit = i_changedfixedcredit, ChangedMonday = i_changedmonday, ChangedTuesday = i_changedtuesday,
	ChangedWednesday = i_changedwednesday, ChangedThursday = i_changedthursday, ChangedFriday = i_changedfriday,
	ChangedSaturday = i_changedsaturday, ChangedSunday = i_changedsunday, ChangedStartTime = i_changedstarttime,
	ChangedEndTime = i_changedendtime, ChangedBuilding = i_changedbuilding, ChangedRoom = i_changedroom,
	ChangedPrimeInstructor = i_changedprimeinstructor, ChangedPrimeInstructorPercent = i_changedprimeinstructorpercent,
	ChangedSecondInstructor = i_changedsecondinstructor, ChangedSecondInstructorPercent = i_changedsecondinstructorpercent,
	ChangedFeeDetailCode = i_changedfeedetailcode, ChangedFeeAmount = i_changedfeeamount, ChangedSectionNotes = i_changedsectionnotes,
	ChangedCrossListedDepartment = i_changedcrosslistedDepartment, ChangedCrossListedSection = i_changedcrosslistedsection,
	ChangedDepartmentComments = i_changeddepartmentcomments, DateImported = i_DateImported, DateCreated = i_DateCreated, DateDeleted = i_DateDeleted WHERE ChangeLogID = i_changelogID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateCourse` (IN `i_CourseID` INT, IN `i_number` INT, IN `i_title` VARCHAR(255), IN `i_minimumcredits` INT, IN `i_maximumcredits` INT, IN `i_fixedcredits` INT, IN `i_isfixedcredit` BIT, IN `i_departmentID` INT, IN `i_Description` VARCHAR(255))  BEGIN
  UPDATE Courses SET Number = i_number, Title = i_title, MinimumCredits = i_minimumcredits, MaximumCredits = i_maximumcredits, FixedCredits = i_fixedcredits, IsFixedCredit = i_isfixedcredit, DepartmentID = i_departmentID, Description = i_Description WHERE CourseID = i_courseID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateDay` (IN `i_DayID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  BEGIN
  UPDATE Days SET Name = i_Name, Abbreviation = i_Abbreviation WHERE DayID = i_DayID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateDepartment` (IN `i_DepartmentID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  BEGIN
  UPDATE Departments SET Name = i_Name, Abbreviation = i_Abbreviation WHERE DepartmentID = i_DepartmentID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateFee` (IN `i_FeeID` INT, IN `i_DetailCode` VARCHAR(255))  BEGIN

  UPDATE Fees SET DetailCode = i_DetailCode WHERE FeeID = i_FeeID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateInstructor` (IN `i_InstructorID` INT, IN `i_FirstName` VARCHAR(255), IN `i_MiddleName` VARCHAR(255), IN `i_LastName` VARCHAR(255), IN `i_Number` INT, IN `i_CourseLoad` INT)  BEGIN
  UPDATE Instructors SET FirstName = i_FirstName, MiddleName = i_MiddleName, LastName = i_LastName, Number = i_Number, CourseLoad = i_CourseLoad WHERE InstructorID = i_InstructorID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateInstructorToSection` (IN `i_instructortosectionID` INT, IN `i_isprimary` INT, IN `i_teachingpercentage` INT, IN `i_datearchived` DATETIME, IN `i_instructorID` INT, IN `i_sectionID` INT)  BEGIN
  UPDATE InstructorToSections SET IsPrimary = i_isprimary, TeachingPercentage = i_teachingpercentage, DateArchived = i_datearchived, InstructorID = i_instructorID, SectionID = i_sectionID WHERE InstructorToSectionID = i_instructortosectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updatePartOfTerm` (IN `i_PartOfTermID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  BEGIN
  UPDATE PartOfTerm SET Name = i_Name, Abbreviation = i_Abbreviation WHERE PartOfTermID = i_PartOfTermID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateRoom` (IN `i_RoomID` INT, IN `i_Number` VARCHAR(255), IN `i_SeatsAvailable` INT, IN `i_Details` VARCHAR(255), IN `i_BuildingID` INT)  BEGIN
  UPDATE Rooms SET Number = i_Number, SeatsAvailable = i_SeatsAvailable, Details = i_Details, BuildingID = i_BuildingID WHERE RoomID = i_RoomID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateScheduleType` (IN `i_ScheduleTypeID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  BEGIN
  UPDATE ScheduleTypes SET Name = i_Name, Abbreviation = i_Abbreviation WHERE ScheduleTypeID = i_ScheduleTypeID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateSection` (IN `i_sectionID` INT, IN `i_crn` INT, IN `i_requiresmoodle` BIT, IN `i_requirespermission` BIT, IN `i_notes` VARCHAR(255), IN `i_departmentcomments` VARCHAR(255), IN `i_studentlimit` INT, IN `i_datecreated` DATETIME, IN `i_datearchived` DATETIME, IN `i_number` INT, IN `i_starttime` DATETIME, IN `i_endtime` DATETIME, IN `i_courseID` INT, IN `i_roomID` INT, IN `i_scheduletypeID` INT, IN `i_academicsemesterID` INT, IN `i_partoftermID` INT, IN `i_DateDeleted` DATETIME)  BEGIN
  UPDATE Sections SET CRN = i_crn, RequiresMoodle = i_requiresmoodle, RequiresPermission = i_requirespermission, Notes = i_notes, DepartmentComments = i_departmentcomments, StudentLimit = i_studentlimit, DateCreated = i_datecreated, DateArchived = i_datearchived, Number = i_number, StartTime = i_starttime, EndTime = i_endtime, CourseID = i_courseID, RoomID = i_roomID, ScheduleTypeID = i_scheduletypeID, AcademicSemesterID = i_academicsemesterID, PartOfTermID = i_partoftermID, DateDeleted = i_DateDeleted WHERE SectionID = i_sectionID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateSectionDay` (IN `i_DayID` INT, IN `i_SectionID` INT, IN `i_DateArchived` DATETIME, IN `i_SectionDayID` INT)  BEGIN
    UPDATE SectionDays SET SectionID = i_SectionID, DayID = i_DayID, DateArchived = i_DateArchived WHERE SectionDayID = i_SectionDayID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateSectionFee` (IN `i_SectionFeeID` INT, IN `i_Amount` DECIMAL(13,4), IN `i_SectionID` INT, IN `i_FeeID` INT)  BEGIN
    UPDATE SectionFees SET SectionID = i_SectionID, FeeID = i_FeeID, Amount = i_Amount WHERE SectionFeeID = i_SectionFeeID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateSemester` (IN `i_SemesterID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  BEGIN
    UPDATE Semesters SET Name = i_Name, Abbreviation = i_Abbreviation WHERE SemesterID = i_SemesterID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateSpreadsheetVariable` (IN `i_spreadsheetvariableID` INT, IN `i_spreadsheet` BLOB, IN `i_startrownumber` INT, IN `i_defaultfontsize` INT, IN `i_academicsemester` VARCHAR(255), IN `i_addchangedelete` VARCHAR(255), IN `i_sectioncrn` VARCHAR(255), IN `i_subjectname` VARCHAR(255), IN `i_coursenumber` VARCHAR(255), IN `i_sectionnumber` VARCHAR(255), IN `i_crosslistid` VARCHAR(255), IN `i_coursetitle` VARCHAR(255), IN `i_campus` VARCHAR(255), IN `i_scheduletype` VARCHAR(255), IN `i_moodlerequired` VARCHAR(255), IN `i_instructorapprovalrequired` VARCHAR(255), IN `i_partofterm` VARCHAR(255), IN `i_fixedcredit` VARCHAR(255), IN `i_minimumcredits` VARCHAR(255), IN `i_maximumcredits` VARCHAR(255), IN `i_classlimit` VARCHAR(255), IN `i_monday` VARCHAR(255), IN `i_tuesday` VARCHAR(255), IN `i_wednesday` VARCHAR(255), IN `i_thursday` VARCHAR(255), IN `i_friday` VARCHAR(255), IN `i_saturday` VARCHAR(255), IN `i_sunday` VARCHAR(255), IN `i_starttime` VARCHAR(255), IN `i_endtime` VARCHAR(255), IN `i_building` VARCHAR(255), IN `i_room` VARCHAR(255), IN `i_primaryinstructorfirstname` VARCHAR(255), IN `i_primaryinstructorlastname` VARCHAR(255), IN `i_primaryinstructornumber` VARCHAR(255), IN `i_primaryinstructorteachingpercentage` VARCHAR(255), IN `i_secondaryinstructorfirstname` VARCHAR(255), IN `i_secondaryinstructorlastname` VARCHAR(255), IN `i_secondaryinstructornumber` VARCHAR(255), IN `i_secondaryinstructorteachingpercentage` VARCHAR(255), IN `i_classfeedetailcode` VARCHAR(255), IN `i_classfeeamount` VARCHAR(255), IN `i_sectionnotes` VARCHAR(255), IN `i_crosslistsubject` VARCHAR(255), IN `i_crosslistcoursenumber` VARCHAR(255), IN `i_departmentcomments` VARCHAR(255))  BEGIN
  UPDATE SpreadsheetVariables SET Spreadsheet = i_spreadsheet, StartRowNumber = i_startrownumber, DefaultFontSize = i_defaultfontsize, AcademicSemester = i_academicsemester, AddChangeDelete = i_addchangedelete, SectionCRN = i_sectioncrn, SubjectName = i_subjectname, CourseNumber = i_coursenumber, SectionNumber = i_sectionnumber, CrossListID = i_crosslistid, CourseTitle = i_coursetitle, Campus = i_campus, ScheduleType = i_scheduletype, MoodleRequired = i_moodlerequired, InstructorApprovalRequired = i_instructorapprovalrequired, PartOfTerm = i_partofterm, FixedCredit = i_fixedcredit, MinimumCredits = i_minimumcredits, MaximumCredits = i_maximumcredits, ClassLimit = i_classlimit, Monday = i_monday, Tuesday = i_tuesday, Wednesday = i_wednesday, Thursday = i_thursday, Friday = i_friday, Saturday = i_saturday, Sunday = i_sunday, StartTime = i_starttime, EndTime = i_endtime, Building = i_building, Room = i_room, PrimaryInstructorFirstName = i_primaryinstructorfirstname, PrimaryInstructorLastName = i_primaryinstructorlastname, PrimaryInstructorNumber = i_primaryinstructornumber, PrimaryInstructorTeachingPercentage = i_primaryinstructorteachingpercentage, SecondaryInstructorFirstName = i_secondaryinstructorfirstname, SecondaryInstructorLastName = i_secondaryinstructorlastname, SecondaryInstructorNumber = i_secondaryinstructornumber, SecondaryInstructorTeachingPercentage = i_secondaryinstructorteachingpercentage, ClassFeeDetailCode = i_classfeedetailcode, ClassFeeAmount = i_classfeeamount, SectionNotes = i_sectionnotes, CrossListSubject = i_crosslistsubject, CrossListCourseNumber = i_crosslistcoursenumber, DepartmentComments = i_departmentcomments WHERE SpreadsheetVariableID = i_spreadsheetvariableID;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateSubject` (IN `i_subject_id` INT, IN `i_number` INT, IN `i_title` VARCHAR(255), IN `i_minimumcredits` INT, IN `i_maximumcredits` INT, IN `i_fixedcredits` INT, IN `i_isfixedcredit` BIT, IN `i_department_id` INT)  BEGIN
  UPDATE Subjects SET Number = i_number, Title = i_title, MinimumCredits = i_minimumcredits, MaximumCredits = i_maximumcredits, FixedCredits = i_fixedcredits, IsFixedCredit = i_isfixedcredit, DepartmentID = i_department_id WHERE SubjectID = i_course_id;
END$$

CREATE DEFINER=`a41845_sched`@`%` PROCEDURE `updateUser` (IN `i_RoleID` INT, IN `i_Username` VARCHAR(255), IN `i_Password` VARCHAR(255), IN `i_UserID` INT)  BEGIN
    UPDATE Users SET Username = i_Username, Password = i_Password, RoleID = i_RoleID WHERE UserID = i_UserID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `academicsemesters`
--

CREATE TABLE `academicsemesters` (
  `AcademicSemesterID` int(11) NOT NULL,
  `SemesterID` int(11) NOT NULL,
  `AcademicYear` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `academicsemesters`
--

INSERT INTO `academicsemesters` (`AcademicSemesterID`, `SemesterID`, `AcademicYear`) VALUES
(1, 1, 2019),
(2, 3, 2019),
(3, 2, 2019),
(4, 3, 2018);

-- --------------------------------------------------------

--
-- Table structure for table `buildings`
--

CREATE TABLE `buildings` (
  `BuildingID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Abbreviation` varchar(255) NOT NULL,
  `CampusID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `buildings`
--

INSERT INTO `buildings` (`BuildingID`, `Name`, `Abbreviation`, `CampusID`) VALUES
(1, 'Business Administration', 'BA', 1),
(2, 'Rendevous', 'REND', 1),
(3, 'Center for Higher Education', 'CHE', 2),
(4, '', 'TA', 2),
(5, '', 'WEB', 1);

-- --------------------------------------------------------

--
-- Table structure for table `campuses`
--

CREATE TABLE `campuses` (
  `CampusID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Abbreviation` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `campuses`
--

INSERT INTO `campuses` (`CampusID`, `Name`, `Abbreviation`) VALUES
(1, 'Pocatello', 'PC'),
(2, 'Idaho Falls', 'IF'),
(3, 'Meridian', 'MD');

-- --------------------------------------------------------

--
-- Table structure for table `changelogs`
--

CREATE TABLE `changelogs` (
  `ChangeLogID` int(11) NOT NULL,
  `SectionID` int(11) NOT NULL,
  `ChangedDepartment` bit(1) NOT NULL,
  `ChangedCourseNumber` bit(1) NOT NULL,
  `ChangedSectionNumber` bit(1) NOT NULL,
  `ChangedTitle` bit(1) NOT NULL,
  `ChangedCampus` bit(1) NOT NULL,
  `ChangedScheduleType` bit(1) NOT NULL,
  `ChangedRequiresMoodle` bit(1) NOT NULL,
  `ChangedRequiresPermission` bit(1) NOT NULL,
  `ChangedPartOfTerm` bit(1) NOT NULL,
  `ChangedStudentLimit` bit(1) NOT NULL,
  `ChangedCreditMax` bit(1) NOT NULL,
  `ChangedCreditMin` bit(1) NOT NULL,
  `ChangedFixedCredit` bit(1) NOT NULL,
  `ChangedMonday` bit(1) NOT NULL,
  `ChangedTuesday` bit(1) NOT NULL,
  `ChangedWednesday` bit(1) NOT NULL,
  `ChangedThursday` bit(1) NOT NULL,
  `ChangedFriday` bit(1) NOT NULL,
  `ChangedSaturday` bit(1) NOT NULL,
  `ChangedSunday` bit(1) NOT NULL,
  `ChangedStartTime` bit(1) NOT NULL,
  `ChangedEndTime` bit(1) NOT NULL,
  `ChangedBuilding` bit(1) NOT NULL,
  `ChangedRoom` bit(1) NOT NULL,
  `ChangedPrimeInstructor` bit(1) NOT NULL,
  `ChangedPrimeInstructorPercent` bit(1) NOT NULL,
  `ChangedSecondInstructor` bit(1) NOT NULL,
  `ChangedSecondInstructorPercent` bit(1) NOT NULL,
  `ChangedFeeDetailCode` bit(1) NOT NULL,
  `ChangedFeeAmount` bit(1) NOT NULL,
  `ChangedSectionNotes` bit(1) NOT NULL,
  `ChangedCrossListedDepartment` bit(1) NOT NULL,
  `ChangedCrossListedSection` bit(1) NOT NULL,
  `ChangedDepartmentComments` bit(1) NOT NULL,
  `DateImported` datetime NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateDeleted` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `changelogs`
--

INSERT INTO `changelogs` (`ChangeLogID`, `SectionID`, `ChangedDepartment`, `ChangedCourseNumber`, `ChangedSectionNumber`, `ChangedTitle`, `ChangedCampus`, `ChangedScheduleType`, `ChangedRequiresMoodle`, `ChangedRequiresPermission`, `ChangedPartOfTerm`, `ChangedStudentLimit`, `ChangedCreditMax`, `ChangedCreditMin`, `ChangedFixedCredit`, `ChangedMonday`, `ChangedTuesday`, `ChangedWednesday`, `ChangedThursday`, `ChangedFriday`, `ChangedSaturday`, `ChangedSunday`, `ChangedStartTime`, `ChangedEndTime`, `ChangedBuilding`, `ChangedRoom`, `ChangedPrimeInstructor`, `ChangedPrimeInstructorPercent`, `ChangedSecondInstructor`, `ChangedSecondInstructorPercent`, `ChangedFeeDetailCode`, `ChangedFeeAmount`, `ChangedSectionNotes`, `ChangedCrossListedDepartment`, `ChangedCrossListedSection`, `ChangedDepartmentComments`, `DateImported`, `DateCreated`, `DateDeleted`) VALUES
(331, 331, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:28', '2019-04-15 14:01:28', '9999-12-31 23:59:59'),
(332, 332, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(333, 333, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(334, 334, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(335, 335, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(336, 336, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(337, 337, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(338, 338, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(339, 339, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(340, 340, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(341, 341, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(342, 342, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(343, 343, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(344, 344, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(345, 345, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(346, 346, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(347, 347, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(348, 348, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(349, 349, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(350, 350, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:39', '2019-04-15 14:01:39', '9999-12-31 23:59:59'),
(351, 351, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(352, 352, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(353, 353, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(354, 354, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(355, 355, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(356, 356, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(357, 357, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(358, 358, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(359, 359, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(360, 360, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(361, 361, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(362, 362, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(363, 363, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(364, 364, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(365, 365, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(366, 366, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(367, 367, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(368, 368, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:40', '2019-04-15 14:01:40', '9999-12-31 23:59:59'),
(369, 369, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(370, 370, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(371, 371, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(372, 372, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(373, 373, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(374, 374, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(375, 375, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(376, 376, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(377, 377, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(378, 378, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(379, 379, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(380, 380, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(381, 381, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(382, 382, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:41', '2019-04-15 14:01:41', '9999-12-31 23:59:59'),
(383, 383, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(384, 384, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(385, 385, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(386, 386, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(387, 387, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(388, 388, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(389, 389, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(390, 390, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(391, 391, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(392, 392, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(393, 393, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(394, 394, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:42', '2019-04-15 14:01:42', '9999-12-31 23:59:59'),
(395, 395, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(396, 396, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(397, 397, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(398, 398, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(399, 399, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(400, 400, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(401, 401, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(402, 402, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(403, 403, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(404, 404, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(405, 405, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:43', '2019-04-15 14:01:43', '9999-12-31 23:59:59'),
(406, 406, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:44', '2019-04-15 14:01:44', '9999-12-31 23:59:59'),
(407, 407, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:44', '2019-04-15 14:01:44', '9999-12-31 23:59:59'),
(408, 408, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:44', '2019-04-15 14:01:44', '9999-12-31 23:59:59'),
(409, 409, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:44', '2019-04-15 14:01:44', '9999-12-31 23:59:59'),
(410, 410, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:44', '2019-04-15 14:01:44', '9999-12-31 23:59:59'),
(411, 411, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:44', '2019-04-15 14:01:44', '9999-12-31 23:59:59'),
(412, 412, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:44', '2019-04-15 14:01:44', '9999-12-31 23:59:59'),
(413, 413, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:44', '2019-04-15 14:01:44', '9999-12-31 23:59:59'),
(414, 414, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:44', '2019-04-15 14:01:44', '9999-12-31 23:59:59'),
(415, 415, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:44', '2019-04-15 14:01:44', '9999-12-31 23:59:59'),
(416, 416, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:45', '2019-04-15 14:01:45', '9999-12-31 23:59:59'),
(417, 417, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:45', '2019-04-15 14:01:45', '9999-12-31 23:59:59'),
(418, 418, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:45', '2019-04-15 14:01:45', '9999-12-31 23:59:59'),
(419, 419, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:45', '2019-04-15 14:01:45', '9999-12-31 23:59:59'),
(420, 420, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:45', '2019-04-15 14:01:45', '9999-12-31 23:59:59'),
(421, 421, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:45', '2019-04-15 14:01:45', '9999-12-31 23:59:59'),
(422, 422, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:45', '2019-04-15 14:01:45', '9999-12-31 23:59:59'),
(423, 423, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:45', '2019-04-15 14:01:45', '9999-12-31 23:59:59'),
(424, 424, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:45', '2019-04-15 14:01:45', '9999-12-31 23:59:59'),
(425, 425, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:45', '2019-04-15 14:01:45', '9999-12-31 23:59:59'),
(426, 426, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:46', '2019-04-15 14:01:46', '9999-12-31 23:59:59'),
(427, 427, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:46', '2019-04-15 14:01:46', '9999-12-31 23:59:59'),
(428, 428, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:46', '2019-04-15 14:01:46', '9999-12-31 23:59:59'),
(429, 429, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:46', '2019-04-15 14:01:46', '9999-12-31 23:59:59'),
(430, 430, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:46', '2019-04-15 14:01:46', '9999-12-31 23:59:59'),
(431, 431, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:46', '2019-04-15 14:01:46', '9999-12-31 23:59:59'),
(432, 432, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:46', '2019-04-15 14:01:46', '9999-12-31 23:59:59'),
(433, 433, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:46', '2019-04-15 14:01:46', '9999-12-31 23:59:59'),
(434, 434, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:46', '2019-04-15 14:01:46', '9999-12-31 23:59:59'),
(435, 435, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:47', '2019-04-15 14:01:47', '9999-12-31 23:59:59'),
(436, 436, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:47', '2019-04-15 14:01:47', '9999-12-31 23:59:59'),
(437, 437, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:47', '2019-04-15 14:01:47', '9999-12-31 23:59:59'),
(438, 438, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:47', '2019-04-15 14:01:47', '9999-12-31 23:59:59'),
(439, 439, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:47', '2019-04-15 14:01:47', '9999-12-31 23:59:59'),
(440, 440, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:47', '2019-04-15 14:01:47', '9999-12-31 23:59:59'),
(441, 441, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:47', '2019-04-15 14:01:47', '9999-12-31 23:59:59'),
(442, 442, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:47', '2019-04-15 14:01:47', '9999-12-31 23:59:59'),
(443, 443, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:47', '2019-04-15 14:01:47', '9999-12-31 23:59:59'),
(444, 444, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:48', '2019-04-15 14:01:48', '9999-12-31 23:59:59'),
(445, 445, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:48', '2019-04-15 14:01:48', '9999-12-31 23:59:59'),
(446, 446, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:48', '2019-04-15 14:01:48', '9999-12-31 23:59:59'),
(447, 447, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:48', '2019-04-15 14:01:48', '9999-12-31 23:59:59'),
(448, 448, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:48', '2019-04-15 14:01:48', '9999-12-31 23:59:59'),
(449, 449, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:48', '2019-04-15 14:01:48', '9999-12-31 23:59:59'),
(450, 450, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:48', '2019-04-15 14:01:48', '9999-12-31 23:59:59'),
(451, 451, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:48', '2019-04-15 14:01:48', '9999-12-31 23:59:59'),
(452, 452, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:49', '2019-04-15 14:01:49', '9999-12-31 23:59:59'),
(453, 453, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:49', '2019-04-15 14:01:49', '9999-12-31 23:59:59'),
(454, 454, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:49', '2019-04-15 14:01:49', '9999-12-31 23:59:59'),
(455, 455, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:49', '2019-04-15 14:01:49', '9999-12-31 23:59:59'),
(456, 456, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:49', '2019-04-15 14:01:49', '9999-12-31 23:59:59'),
(457, 457, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:49', '2019-04-15 14:01:49', '9999-12-31 23:59:59'),
(458, 458, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:49', '2019-04-15 14:01:49', '9999-12-31 23:59:59'),
(459, 459, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:49', '2019-04-15 14:01:49', '9999-12-31 23:59:59'),
(460, 460, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:50', '2019-04-15 14:01:50', '9999-12-31 23:59:59'),
(461, 461, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:50', '2019-04-15 14:01:50', '9999-12-31 23:59:59'),
(462, 462, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:50', '2019-04-15 14:01:50', '9999-12-31 23:59:59'),
(463, 463, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:50', '2019-04-15 14:01:50', '9999-12-31 23:59:59'),
(464, 464, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:50', '2019-04-15 14:01:50', '9999-12-31 23:59:59'),
(465, 465, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:50', '2019-04-15 14:01:50', '9999-12-31 23:59:59'),
(466, 466, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:50', '2019-04-15 14:01:50', '9999-12-31 23:59:59'),
(467, 467, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:51', '2019-04-15 14:01:51', '9999-12-31 23:59:59'),
(468, 468, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:51', '2019-04-15 14:01:51', '9999-12-31 23:59:59'),
(469, 469, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:51', '2019-04-15 14:01:51', '9999-12-31 23:59:59'),
(470, 470, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:51', '2019-04-15 14:01:51', '9999-12-31 23:59:59'),
(471, 471, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:51', '2019-04-15 14:01:51', '9999-12-31 23:59:59'),
(472, 472, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:51', '2019-04-15 14:01:51', '9999-12-31 23:59:59'),
(473, 473, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:51', '2019-04-15 14:01:51', '9999-12-31 23:59:59'),
(474, 474, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:52', '2019-04-15 14:01:52', '9999-12-31 23:59:59'),
(475, 475, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:52', '2019-04-15 14:01:52', '9999-12-31 23:59:59'),
(476, 476, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:52', '2019-04-15 14:01:52', '9999-12-31 23:59:59'),
(477, 477, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:52', '2019-04-15 14:01:52', '9999-12-31 23:59:59'),
(478, 478, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:52', '2019-04-15 14:01:52', '9999-12-31 23:59:59'),
(479, 479, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:52', '2019-04-15 14:01:52', '9999-12-31 23:59:59'),
(480, 480, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:52', '2019-04-15 14:01:52', '9999-12-31 23:59:59'),
(481, 481, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:53', '2019-04-15 14:01:53', '9999-12-31 23:59:59'),
(482, 482, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:53', '2019-04-15 14:01:53', '9999-12-31 23:59:59'),
(483, 483, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:53', '2019-04-15 14:01:53', '9999-12-31 23:59:59'),
(484, 484, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:53', '2019-04-15 14:01:53', '9999-12-31 23:59:59'),
(485, 485, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:53', '2019-04-15 14:01:53', '9999-12-31 23:59:59'),
(486, 486, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:53', '2019-04-15 14:01:53', '9999-12-31 23:59:59'),
(487, 487, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:54', '2019-04-15 14:01:54', '9999-12-31 23:59:59'),
(488, 488, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:54', '2019-04-15 14:01:54', '9999-12-31 23:59:59'),
(489, 489, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:54', '2019-04-15 14:01:54', '9999-12-31 23:59:59'),
(490, 490, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:54', '2019-04-15 14:01:54', '9999-12-31 23:59:59'),
(491, 491, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:54', '2019-04-15 14:01:54', '9999-12-31 23:59:59'),
(492, 492, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:54', '2019-04-15 14:01:54', '9999-12-31 23:59:59'),
(493, 493, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:55', '2019-04-15 14:01:55', '9999-12-31 23:59:59'),
(494, 494, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:55', '2019-04-15 14:01:55', '9999-12-31 23:59:59'),
(495, 495, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:55', '2019-04-15 14:01:55', '9999-12-31 23:59:59'),
(496, 496, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:55', '2019-04-15 14:01:55', '9999-12-31 23:59:59'),
(497, 497, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:55', '2019-04-15 14:01:55', '9999-12-31 23:59:59'),
(498, 498, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:55', '2019-04-15 14:01:55', '9999-12-31 23:59:59'),
(499, 499, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:56', '2019-04-15 14:01:56', '9999-12-31 23:59:59'),
(500, 500, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:56', '2019-04-15 14:01:56', '9999-12-31 23:59:59'),
(501, 501, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:56', '2019-04-15 14:01:56', '9999-12-31 23:59:59'),
(502, 502, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:56', '2019-04-15 14:01:56', '9999-12-31 23:59:59'),
(503, 503, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:56', '2019-04-15 14:01:56', '9999-12-31 23:59:59');
INSERT INTO `changelogs` (`ChangeLogID`, `SectionID`, `ChangedDepartment`, `ChangedCourseNumber`, `ChangedSectionNumber`, `ChangedTitle`, `ChangedCampus`, `ChangedScheduleType`, `ChangedRequiresMoodle`, `ChangedRequiresPermission`, `ChangedPartOfTerm`, `ChangedStudentLimit`, `ChangedCreditMax`, `ChangedCreditMin`, `ChangedFixedCredit`, `ChangedMonday`, `ChangedTuesday`, `ChangedWednesday`, `ChangedThursday`, `ChangedFriday`, `ChangedSaturday`, `ChangedSunday`, `ChangedStartTime`, `ChangedEndTime`, `ChangedBuilding`, `ChangedRoom`, `ChangedPrimeInstructor`, `ChangedPrimeInstructorPercent`, `ChangedSecondInstructor`, `ChangedSecondInstructorPercent`, `ChangedFeeDetailCode`, `ChangedFeeAmount`, `ChangedSectionNotes`, `ChangedCrossListedDepartment`, `ChangedCrossListedSection`, `ChangedDepartmentComments`, `DateImported`, `DateCreated`, `DateDeleted`) VALUES
(504, 504, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:56', '2019-04-15 14:01:56', '9999-12-31 23:59:59'),
(505, 505, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:57', '2019-04-15 14:01:57', '9999-12-31 23:59:59'),
(506, 506, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:57', '2019-04-15 14:01:57', '9999-12-31 23:59:59'),
(507, 507, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:57', '2019-04-15 14:01:57', '9999-12-31 23:59:59'),
(508, 508, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:57', '2019-04-15 14:01:57', '9999-12-31 23:59:59'),
(509, 509, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:57', '2019-04-15 14:01:57', '9999-12-31 23:59:59'),
(510, 510, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:57', '2019-04-15 14:01:57', '9999-12-31 23:59:59'),
(511, 511, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:58', '2019-04-15 14:01:58', '9999-12-31 23:59:59'),
(512, 512, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:58', '2019-04-15 14:01:58', '9999-12-31 23:59:59'),
(513, 513, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:58', '2019-04-15 14:01:58', '9999-12-31 23:59:59'),
(514, 514, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:58', '2019-04-15 14:01:58', '9999-12-31 23:59:59'),
(515, 515, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:58', '2019-04-15 14:01:58', '9999-12-31 23:59:59'),
(516, 516, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:58', '2019-04-15 14:01:58', '9999-12-31 23:59:59'),
(517, 517, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:59', '2019-04-15 14:01:59', '9999-12-31 23:59:59'),
(518, 518, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:59', '2019-04-15 14:01:59', '9999-12-31 23:59:59'),
(519, 519, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:59', '2019-04-15 14:01:59', '9999-12-31 23:59:59'),
(520, 520, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:59', '2019-04-15 14:01:59', '9999-12-31 23:59:59'),
(521, 521, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:01:59', '2019-04-15 14:01:59', '9999-12-31 23:59:59'),
(522, 522, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:00', '2019-04-15 14:02:00', '9999-12-31 23:59:59'),
(523, 523, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:00', '2019-04-15 14:02:00', '9999-12-31 23:59:59'),
(524, 524, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:00', '2019-04-15 14:02:00', '9999-12-31 23:59:59'),
(525, 525, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:00', '2019-04-15 14:02:00', '9999-12-31 23:59:59'),
(526, 526, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:00', '2019-04-15 14:02:00', '9999-12-31 23:59:59'),
(527, 527, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:01', '2019-04-15 14:02:01', '9999-12-31 23:59:59'),
(528, 528, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:01', '2019-04-15 14:02:01', '9999-12-31 23:59:59'),
(529, 529, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:01', '2019-04-15 14:02:01', '9999-12-31 23:59:59'),
(530, 530, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:01', '2019-04-15 14:02:01', '9999-12-31 23:59:59'),
(531, 531, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:01', '2019-04-15 14:02:01', '9999-12-31 23:59:59'),
(532, 532, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:01', '2019-04-15 14:02:01', '9999-12-31 23:59:59'),
(533, 533, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:02', '2019-04-15 14:02:02', '9999-12-31 23:59:59'),
(534, 534, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:02', '2019-04-15 14:02:02', '9999-12-31 23:59:59'),
(535, 535, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:02', '2019-04-15 14:02:02', '9999-12-31 23:59:59'),
(536, 536, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:02', '2019-04-15 14:02:02', '9999-12-31 23:59:59'),
(537, 537, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:02', '2019-04-15 14:02:02', '9999-12-31 23:59:59'),
(538, 538, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:03', '2019-04-15 14:02:03', '9999-12-31 23:59:59'),
(539, 539, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:03', '2019-04-15 14:02:03', '9999-12-31 23:59:59'),
(540, 540, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:03', '2019-04-15 14:02:03', '9999-12-31 23:59:59'),
(541, 541, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:03', '2019-04-15 14:02:03', '9999-12-31 23:59:59'),
(542, 542, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:03', '2019-04-15 14:02:03', '9999-12-31 23:59:59'),
(543, 543, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:04', '2019-04-15 14:02:04', '9999-12-31 23:59:59'),
(544, 544, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:04', '2019-04-15 14:02:04', '9999-12-31 23:59:59'),
(545, 545, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:04', '2019-04-15 14:02:04', '9999-12-31 23:59:59'),
(546, 546, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:04', '2019-04-15 14:02:04', '9999-12-31 23:59:59'),
(547, 547, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:04', '2019-04-15 14:02:04', '9999-12-31 23:59:59'),
(548, 548, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:05', '2019-04-15 14:02:05', '9999-12-31 23:59:59'),
(549, 549, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:05', '2019-04-15 14:02:05', '9999-12-31 23:59:59'),
(550, 550, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:05', '2019-04-15 14:02:05', '9999-12-31 23:59:59'),
(551, 551, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:05', '2019-04-15 14:02:05', '9999-12-31 23:59:59'),
(552, 552, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:05', '2019-04-15 14:02:05', '9999-12-31 23:59:59'),
(553, 553, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:06', '2019-04-15 14:02:06', '9999-12-31 23:59:59'),
(554, 554, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:06', '2019-04-15 14:02:06', '9999-12-31 23:59:59'),
(555, 555, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:06', '2019-04-15 14:02:06', '9999-12-31 23:59:59'),
(556, 556, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:06', '2019-04-15 14:02:06', '9999-12-31 23:59:59'),
(557, 557, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:06', '2019-04-15 14:02:06', '9999-12-31 23:59:59'),
(558, 558, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:07', '2019-04-15 14:02:07', '9999-12-31 23:59:59'),
(559, 559, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:07', '2019-04-15 14:02:07', '9999-12-31 23:59:59'),
(560, 560, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:07', '2019-04-15 14:02:07', '9999-12-31 23:59:59'),
(561, 561, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:07', '2019-04-15 14:02:07', '9999-12-31 23:59:59'),
(562, 562, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:07', '2019-04-15 14:02:07', '9999-12-31 23:59:59'),
(563, 563, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:08', '2019-04-15 14:02:08', '9999-12-31 23:59:59'),
(564, 564, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:08', '2019-04-15 14:02:08', '9999-12-31 23:59:59'),
(565, 565, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:08', '2019-04-15 14:02:08', '9999-12-31 23:59:59'),
(566, 566, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:08', '2019-04-15 14:02:08', '9999-12-31 23:59:59'),
(567, 567, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:09', '2019-04-15 14:02:09', '9999-12-31 23:59:59'),
(568, 568, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:09', '2019-04-15 14:02:09', '9999-12-31 23:59:59'),
(569, 569, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:09', '2019-04-15 14:02:09', '9999-12-31 23:59:59'),
(570, 570, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:09', '2019-04-15 14:02:09', '9999-12-31 23:59:59'),
(571, 571, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:09', '2019-04-15 14:02:09', '9999-12-31 23:59:59'),
(572, 572, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:10', '2019-04-15 14:02:10', '9999-12-31 23:59:59'),
(573, 573, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:10', '2019-04-15 14:02:10', '9999-12-31 23:59:59'),
(574, 574, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:10', '2019-04-15 14:02:10', '9999-12-31 23:59:59'),
(575, 575, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:10', '2019-04-15 14:02:10', '9999-12-31 23:59:59'),
(576, 576, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:11', '2019-04-15 14:02:11', '9999-12-31 23:59:59'),
(577, 577, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:11', '2019-04-15 14:02:11', '9999-12-31 23:59:59'),
(578, 578, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:11', '2019-04-15 14:02:11', '9999-12-31 23:59:59'),
(579, 579, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:11', '2019-04-15 14:02:11', '9999-12-31 23:59:59'),
(580, 580, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:11', '2019-04-15 14:02:11', '9999-12-31 23:59:59'),
(581, 581, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:12', '2019-04-15 14:02:12', '9999-12-31 23:59:59'),
(582, 582, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:12', '2019-04-15 14:02:12', '9999-12-31 23:59:59'),
(583, 583, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:12', '2019-04-15 14:02:12', '9999-12-31 23:59:59'),
(584, 584, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:12', '2019-04-15 14:02:12', '9999-12-31 23:59:59'),
(585, 585, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:13', '2019-04-15 14:02:13', '9999-12-31 23:59:59'),
(586, 586, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:13', '2019-04-15 14:02:13', '9999-12-31 23:59:59'),
(587, 587, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:13', '2019-04-15 14:02:13', '9999-12-31 23:59:59'),
(588, 588, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:13', '2019-04-15 14:02:13', '9999-12-31 23:59:59'),
(589, 589, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:13', '2019-04-15 14:02:13', '9999-12-31 23:59:59'),
(590, 590, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:14', '2019-04-15 14:02:14', '9999-12-31 23:59:59'),
(591, 591, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:14', '2019-04-15 14:02:14', '9999-12-31 23:59:59'),
(592, 592, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:14', '2019-04-15 14:02:14', '9999-12-31 23:59:59'),
(593, 593, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:14', '2019-04-15 14:02:14', '9999-12-31 23:59:59'),
(594, 594, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:15', '2019-04-15 14:02:15', '9999-12-31 23:59:59'),
(595, 595, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:15', '2019-04-15 14:02:15', '9999-12-31 23:59:59'),
(596, 596, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:15', '2019-04-15 14:02:15', '9999-12-31 23:59:59'),
(597, 597, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:15', '2019-04-15 14:02:15', '9999-12-31 23:59:59'),
(598, 598, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:16', '2019-04-15 14:02:16', '9999-12-31 23:59:59'),
(599, 599, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:16', '2019-04-15 14:02:16', '9999-12-31 23:59:59'),
(600, 600, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:16', '2019-04-15 14:02:16', '9999-12-31 23:59:59'),
(601, 601, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:16', '2019-04-15 14:02:16', '9999-12-31 23:59:59'),
(602, 602, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:17', '2019-04-15 14:02:17', '9999-12-31 23:59:59'),
(603, 603, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:17', '2019-04-15 14:02:17', '9999-12-31 23:59:59'),
(604, 604, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:17', '2019-04-15 14:02:17', '9999-12-31 23:59:59'),
(605, 605, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:17', '2019-04-15 14:02:17', '9999-12-31 23:59:59'),
(606, 606, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:18', '2019-04-15 14:02:18', '9999-12-31 23:59:59'),
(607, 607, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:18', '2019-04-15 14:02:18', '9999-12-31 23:59:59'),
(608, 608, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:18', '2019-04-15 14:02:18', '9999-12-31 23:59:59'),
(609, 609, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:18', '2019-04-15 14:02:18', '9999-12-31 23:59:59'),
(610, 610, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:19', '2019-04-15 14:02:19', '9999-12-31 23:59:59'),
(611, 611, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:19', '2019-04-15 14:02:19', '9999-12-31 23:59:59'),
(612, 612, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:19', '2019-04-15 14:02:19', '9999-12-31 23:59:59'),
(613, 613, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:19', '2019-04-15 14:02:19', '9999-12-31 23:59:59'),
(614, 614, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:20', '2019-04-15 14:02:20', '9999-12-31 23:59:59'),
(615, 615, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:31', '2019-04-15 14:02:31', '9999-12-31 23:59:59'),
(616, 616, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:31', '2019-04-15 14:02:31', '9999-12-31 23:59:59'),
(617, 617, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:31', '2019-04-15 14:02:31', '9999-12-31 23:59:59'),
(618, 618, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:32', '2019-04-15 14:02:32', '9999-12-31 23:59:59'),
(619, 619, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:32', '2019-04-15 14:02:32', '9999-12-31 23:59:59'),
(620, 620, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:32', '2019-04-15 14:02:32', '9999-12-31 23:59:59'),
(621, 621, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:32', '2019-04-15 14:02:32', '9999-12-31 23:59:59'),
(622, 622, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:33', '2019-04-15 14:02:33', '9999-12-31 23:59:59'),
(623, 623, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:33', '2019-04-15 14:02:33', '9999-12-31 23:59:59'),
(624, 624, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:33', '2019-04-15 14:02:33', '9999-12-31 23:59:59'),
(625, 625, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:33', '2019-04-15 14:02:33', '9999-12-31 23:59:59'),
(626, 626, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:34', '2019-04-15 14:02:34', '9999-12-31 23:59:59'),
(627, 627, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:34', '2019-04-15 14:02:34', '9999-12-31 23:59:59'),
(628, 628, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:34', '2019-04-15 14:02:34', '9999-12-31 23:59:59'),
(629, 629, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:35', '2019-04-15 14:02:35', '9999-12-31 23:59:59'),
(630, 630, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:35', '2019-04-15 14:02:35', '9999-12-31 23:59:59'),
(631, 631, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:35', '2019-04-15 14:02:35', '9999-12-31 23:59:59'),
(632, 632, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:35', '2019-04-15 14:02:35', '9999-12-31 23:59:59'),
(633, 633, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:36', '2019-04-15 14:02:36', '9999-12-31 23:59:59'),
(634, 634, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:36', '2019-04-15 14:02:36', '9999-12-31 23:59:59'),
(635, 635, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:36', '2019-04-15 14:02:36', '9999-12-31 23:59:59'),
(636, 636, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:36', '2019-04-15 14:02:36', '9999-12-31 23:59:59'),
(637, 637, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:37', '2019-04-15 14:02:37', '9999-12-31 23:59:59'),
(638, 638, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:37', '2019-04-15 14:02:37', '9999-12-31 23:59:59'),
(639, 639, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:37', '2019-04-15 14:02:37', '9999-12-31 23:59:59'),
(640, 640, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:37', '2019-04-15 14:02:37', '9999-12-31 23:59:59'),
(641, 641, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:38', '2019-04-15 14:02:38', '9999-12-31 23:59:59'),
(642, 642, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:38', '2019-04-15 14:02:38', '9999-12-31 23:59:59'),
(643, 643, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:38', '2019-04-15 14:02:38', '9999-12-31 23:59:59'),
(644, 644, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:39', '2019-04-15 14:02:39', '9999-12-31 23:59:59'),
(645, 645, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:39', '2019-04-15 14:02:39', '9999-12-31 23:59:59'),
(646, 646, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:39', '2019-04-15 14:02:39', '9999-12-31 23:59:59'),
(647, 647, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:39', '2019-04-15 14:02:39', '9999-12-31 23:59:59'),
(648, 648, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:40', '2019-04-15 14:02:40', '9999-12-31 23:59:59'),
(649, 649, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:40', '2019-04-15 14:02:40', '9999-12-31 23:59:59'),
(650, 650, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:40', '2019-04-15 14:02:40', '9999-12-31 23:59:59'),
(651, 651, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:41', '2019-04-15 14:02:41', '9999-12-31 23:59:59'),
(652, 652, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:41', '2019-04-15 14:02:41', '9999-12-31 23:59:59'),
(653, 653, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:41', '2019-04-15 14:02:41', '9999-12-31 23:59:59'),
(654, 654, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:41', '2019-04-15 14:02:41', '9999-12-31 23:59:59'),
(655, 655, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:42', '2019-04-15 14:02:42', '9999-12-31 23:59:59'),
(656, 656, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:42', '2019-04-15 14:02:42', '9999-12-31 23:59:59'),
(657, 657, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:42', '2019-04-15 14:02:42', '9999-12-31 23:59:59'),
(658, 658, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:43', '2019-04-15 14:02:43', '9999-12-31 23:59:59'),
(659, 659, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:43', '2019-04-15 14:02:43', '9999-12-31 23:59:59'),
(660, 660, b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'0', '2019-04-15 14:02:43', '2019-04-15 14:02:43', '9999-12-31 23:59:59');

-- --------------------------------------------------------

--
-- Table structure for table `colleges`
--

CREATE TABLE `colleges` (
  `CollegeID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `collegetousers`
--

CREATE TABLE `collegetousers` (
  `CollegeToUserID` int(11) NOT NULL,
  `CollegeID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `CourseID` int(11) NOT NULL,
  `Number` int(11) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL DEFAULT '''''',
  `MinimumCredits` int(11) NOT NULL,
  `MaximumCredits` int(11) NOT NULL,
  `FixedCredits` int(11) NOT NULL,
  `IsFixedCredit` bit(1) NOT NULL,
  `DepartmentID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`CourseID`, `Number`, `Title`, `Description`, `MinimumCredits`, `MaximumCredits`, `FixedCredits`, `IsFixedCredit`, `DepartmentID`) VALUES
(1, 2201, 'Principles of Accounting I', '', 0, 0, 3, b'1', 1),
(2, 2202, 'Principles of Accounting II', '', 0, 0, 3, b'1', 1),
(3, 3303, 'Accounting Concepts', '', 0, 0, 3, b'1', 1),
(4, 3323, 'Intermediate Accounting I', '', 0, 0, 3, b'1', 1),
(5, 3324, 'Intermediate Accounting II', '', 0, 0, 3, b'1', 1),
(6, 3331, 'Principles of Taxation', '', 0, 0, 3, b'1', 1),
(7, 3332, 'Principles of Taxation II', '', 0, 0, 3, b'1', 1),
(8, 3341, 'Managerial and Cost Accounting', '', 0, 0, 3, b'1', 1),
(9, 3393, 'Accounting Internship', '', 1, 3, 0, b'0', 1),
(10, 3399, 'Accounting Data Analytics', '', 0, 0, 3, b'1', 1),
(11, 4403, 'Accounting Information Systems', '', 0, 0, 3, b'1', 1),
(12, 4425, 'Intermediate Accounting III', '', 0, 0, 3, b'1', 1),
(13, 4433, 'Legal Environment of Acct', '', 0, 0, 3, b'1', 1),
(14, 4456, 'Auditing', '', 0, 0, 3, b'1', 1),
(15, 4492, 'Special Problems in Accounting', '', 0, 0, 3, b'1', 1),
(16, 4493, 'Advanced Accounting Internship', '', 1, 3, 0, b'0', 1),
(17, 4499, 'Business Advisory Services', '', 0, 0, 3, b'1', 1),
(18, 5503, 'Accounting Information Systems', '', 0, 0, 3, b'1', 1),
(19, 5531, 'Advanced Tax Concepts', '', 0, 0, 3, b'1', 1),
(20, 5533, 'Legal Environment of Acct', '', 0, 0, 3, b'1', 1),
(21, 5556, 'Auditing', '', 0, 0, 3, b'1', 1),
(22, 5561, 'Advanced Accounting', '', 0, 0, 3, b'1', 1),
(23, 5571, 'Accounting Capstone I', '', 0, 0, 1, b'1', 1),
(24, 5572, 'Accounting Capstone 2', '', 0, 0, 1, b'1', 1),
(25, 5573, 'Accounting Capstone 3', '', 0, 0, 1, b'1', 1),
(26, 5574, 'Accounting Capstone 4', '', 0, 0, 1, b'1', 1),
(27, 5592, 'Special Problems Acct', '', 1, 3, 0, b'0', 1),
(28, 5593, 'Accounting Internship', '', 1, 3, 0, b'0', 1),
(29, 5599, 'Business Advisory Services', '', 0, 0, 3, b'1', 1),
(30, 6631, 'Accounting Theory', '', 0, 0, 3, b'1', 1),
(31, 6641, 'Tax Individuals and Property', '', 0, 0, 3, b'1', 1),
(32, 6645, 'Tax Rsrch Planning and Policy', '', 0, 0, 3, b'1', 1),
(33, 1110, 'The World of Business', '', 0, 0, 3, b'1', 5),
(34, 2210, 'Professional Development I', '', 0, 0, 1, b'1', 5),
(35, 3310, 'Professional Development II', '', 0, 0, 1, b'1', 5),
(36, 1181, 'Computer Sci and Programming I', '', 0, 0, 3, b'1', 4),
(37, 1337, 'System Programming and Assembly', '', 0, 0, 3, b'1', 4),
(38, 2235, 'Data Structures and Algorithms', '', 0, 0, 3, b'1', 4),
(39, 3305, 'Intro to Computational Theory', '', 0, 0, 3, b'1', 4),
(40, 3316, 'Soc Iss and Prof Pract in Comp', '', 0, 0, 3, b'1', 4),
(41, 3321, 'Introduction to Software Engineering', '', 0, 0, 3, b'1', 4),
(42, 3393, 'Computer Science Internship', '', 1, 3, 0, b'0', 4),
(43, 4421, 'Software Architecture', '', 0, 0, 3, b'1', 4),
(44, 4458, 'Computer Graphics', '', 0, 0, 3, b'1', 4),
(45, 4470, 'Parallel Processing', '', 0, 0, 3, b'1', 4),
(46, 4471, 'Operating Systems', '', 0, 0, 4, b'1', 4),
(47, 4478, 'Machine Learning', '', 0, 0, 3, b'1', 4),
(48, 4481, 'Compilers', '', 0, 0, 3, b'1', 4),
(49, 4488, 'Capstone Project', '', 0, 0, 3, b'1', 4),
(50, 4499, 'Machine Learning/Data Mining', '', 0, 0, 3, b'1', 4),
(51, 5102, 'Teach and Learn CS I', '', 0, 0, 3, b'1', 4),
(52, 5558, 'Computer Graphics', '', 0, 0, 3, b'1', 4),
(53, 5570, 'Parallel Processing', '', 0, 0, 3, b'1', 4),
(54, 5580, 'Theory of Computation', '', 0, 0, 3, b'1', 4),
(55, 5581, 'Compilers', '', 0, 0, 3, b'1', 4),
(56, 5599, 'Machine Learning/Data Mining', '', 0, 0, 3, b'1', 4),
(57, 1100, 'Economic Issues', '', 0, 0, 3, b'1', 7),
(58, 2201, 'Principles of Macroeconomics', '', 0, 0, 3, b'1', 7),
(59, 2202, 'Principles of Microeconomics', '', 0, 0, 3, b'1', 7),
(60, 3301, 'Macroeconomic Theory', '', 0, 0, 3, b'1', 7),
(61, 4431, 'Money and Banking', '', 0, 0, 3, b'1', 7),
(62, 4438, 'Public Finance', '', 0, 0, 3, b'1', 7),
(63, 4440, 'Healthcare Economics & Policy', '', 0, 0, 3, b'1', 7),
(64, 4485, 'Econometrics', '', 0, 0, 3, b'1', 7),
(65, 4492, 'Spec Prob in Econ', '', 0, 0, 3, b'1', 7),
(66, 4499, 'Behavioral Economics', '', 0, 0, 3, b'1', 7),
(67, 5531, 'Money and Banking', '', 0, 0, 3, b'1', 7),
(68, 5538, 'Public Finance', '', 0, 0, 3, b'1', 7),
(69, 5540, 'Healthcare Economics & Policy', '', 0, 0, 3, b'1', 7),
(70, 5585, 'Econometrics', '', 0, 0, 3, b'1', 7),
(71, 5599, 'Behavioral Economics', '', 0, 0, 3, b'1', 7),
(72, 1115, 'Personal Finance', '', 0, 0, 3, b'1', 2),
(73, 3303, 'Financial Concepts', '', 0, 0, 3, b'1', 2),
(74, 3315, 'Corporate Financial Management', '', 0, 0, 3, b'1', 2),
(75, 3393, 'Finance Internship', '', 1, 3, 0, b'0', 2),
(76, 4405, 'Adv Corp Fin Mgt I', '', 0, 0, 3, b'1', 2),
(77, 4445, 'Real Estate Finance', '', 0, 0, 3, b'1', 2),
(78, 4448, 'Financial Mgt of Deposit Institut', '', 0, 0, 3, b'1', 2),
(79, 4451, 'Student-Managed Invst Fund I', '', 0, 0, 3, b'1', 2),
(80, 4475, 'International Corp Finance', '', 0, 0, 3, b'1', 2),
(81, 4478, 'Investments', '', 0, 0, 3, b'1', 2),
(82, 4492, 'Special Problems in Finance', '', 0, 0, 3, b'1', 2),
(83, 5505, 'Adv Corp Fin Mgt', '', 0, 0, 3, b'1', 2),
(84, 5545, 'Real Estate Finance', '', 0, 0, 3, b'1', 2),
(85, 5548, 'Financial Mgt of Deposit Institut', '', 0, 0, 3, b'1', 2),
(86, 5551, 'Student-Managed Invst Fund I', '', 0, 0, 3, b'1', 2),
(87, 5575, 'International Corp Finance', '', 0, 0, 3, b'1', 2),
(88, 5578, 'Investments', '', 0, 0, 3, b'1', 2),
(89, 1110, 'Intro Allied Hlth Profssns', '', 0, 0, 3, b'1', 10),
(90, 1115, 'US Health System', '', 0, 0, 3, b'1', 10),
(91, 3330, 'Health Information Systems', '', 0, 0, 3, b'1', 10),
(92, 3340, 'Healthcare Policy', '', 0, 0, 3, b'1', 10),
(93, 3384, 'HR Mgt in Healthcare Orgs', '', 0, 0, 3, b'1', 10),
(94, 4410, 'Mgt HCA Providers', '', 0, 0, 3, b'1', 10),
(95, 4417, 'Managerial Epi and Population Health', '', 0, 0, 3, b'1', 10),
(96, 4440, 'Healthcare Econ and Policy', '', 0, 0, 3, b'1', 10),
(97, 4453, 'Healthcare Finance', '', 0, 0, 3, b'1', 10),
(98, 4460, 'HC Quality and PI', '', 0, 0, 3, b'1', 10),
(99, 4475, 'Health Law and Bioethics', '', 0, 0, 3, b'1', 10),
(100, 4489, 'Health Care Info Syst Pract', '', 0, 0, 3, b'1', 10),
(101, 4495, 'Administrative Internship', '', 0, 0, 4, b'1', 10),
(102, 5510, 'Mgt of HC Provider Orgs', '', 0, 0, 3, b'1', 10),
(103, 5517, 'Managerial Epi and Population Health', '', 0, 0, 3, b'1', 10),
(104, 5540, 'Healthcare Econ and Policy', '', 0, 0, 3, b'1', 10),
(105, 5553, 'Healthcare Finance', '', 0, 0, 3, b'1', 10),
(106, 5560, 'HC Quality and PI', '', 0, 0, 3, b'1', 10),
(107, 5575, 'Health Law and Bioethics', '', 0, 0, 3, b'1', 10),
(108, 5595, 'Administrative Internship', '', 0, 0, 4, b'1', 10),
(109, 6650, 'Healthcare Leadership and Governance', '', 0, 0, 3, b'1', 10),
(110, 6695, 'Healthcare Residency', '', 0, 0, 3, b'1', 10),
(111, 1101, 'Digital Information Literacy', '', 0, 0, 3, b'1', 3),
(112, 1150, 'Software and Systems Arch', '', 0, 0, 3, b'1', 3),
(113, 1181, 'Informatics and Programming I', '', 0, 0, 3, b'1', 3),
(114, 1182, 'Informatics and Programming II', '', 0, 0, 3, b'1', 3),
(115, 2220, 'Web Development Client', '', 0, 0, 3, b'1', 3),
(116, 3301, 'Intro Informatics Analytics', '', 0, 0, 3, b'1', 3),
(117, 3303, 'Informatics Concepts', '', 0, 0, 3, b'1', 3),
(118, 3307, 'Systems Analysis and Design', '', 0, 0, 3, b'1', 3),
(119, 3330, 'Health Informatics', '', 0, 0, 3, b'1', 3),
(120, 3380, 'Networking and Virtualization', '', 0, 0, 3, b'1', 3),
(121, 3393, 'Informatics Internship', '', 1, 3, 0, b'0', 3),
(122, 4407, 'Database Design Implementation', '', 0, 0, 3, b'1', 3),
(123, 4411, 'Intermediate Info Assurance', '', 0, 0, 3, b'1', 3),
(124, 4419, 'Advanced Informatics Practicum', '', 1, 3, 0, b'0', 3),
(125, 4424, 'Healthcare Workflow Process', '', 0, 0, 3, b'1', 3),
(126, 4430, 'Web Application Development', '', 0, 0, 3, b'1', 3),
(127, 4484, 'Secure Software Life Cycle Dev', '', 0, 0, 3, b'1', 3),
(128, 4488, 'Informatics Senior Project', '', 0, 0, 3, b'1', 3),
(129, 4491, 'Seminar in Informatics', '', 0, 0, 3, b'1', 3),
(130, 4492, 'Special Problems Informatics', '', 1, 3, 0, b'0', 3),
(131, 4493, 'Advanced Informatics Intern', '', 0, 0, 3, b'1', 3),
(132, 4499, 'Data Visualization', '', 0, 0, 3, b'1', 3),
(133, 5307, 'Intermediate Systems Analysis', '', 0, 0, 3, b'1', 3),
(134, 5507, 'Database Design and Implement', '', 0, 0, 3, b'1', 3),
(135, 5511, 'Intermediate Info Assurance', '', 0, 0, 3, b'1', 3),
(136, 5512, 'Systems Security for Sr Mgt', '', 1, 3, 0, b'0', 3),
(137, 5513, 'Systems Security Admin', '', 0, 0, 1, b'1', 3),
(138, 5514, 'Systems Security Management', '', 1, 3, 0, b'0', 3),
(139, 5519, 'Advanced Informatics Practicum', '', 1, 3, 0, b'0', 3),
(140, 5520, 'Health Informatics', '', 0, 0, 3, b'1', 3),
(141, 5524, 'Healthcare Workflow Process', '', 0, 0, 3, b'1', 3),
(142, 5530, 'Web Application Development', '', 0, 0, 3, b'1', 3),
(143, 5584, 'Secure Software Life Cyc Dev', '', 0, 0, 3, b'1', 3),
(144, 5592, 'Special Problems Informatics', '', 1, 3, 0, b'0', 3),
(145, 5599, 'Data Visualization', '', 0, 0, 3, b'1', 3),
(146, 6528, 'Electronic Health Records', '', 0, 0, 3, b'1', 3),
(147, 6540, 'Health Clinical Practicum', '', 0, 0, 3, b'1', 3),
(148, 6660, 'Informatics Project', '', 1, 3, 0, b'0', 3),
(149, 6611, 'Fin Reporting Managerial Acct', '', 0, 0, 3, b'1', 8),
(150, 6613, 'Marketing', '', 0, 0, 3, b'1', 8),
(151, 6620, 'Quant Info for Bus Decisions', '', 0, 0, 3, b'1', 8),
(152, 6621, 'Managerial Decision-Making', '', 0, 0, 3, b'1', 8),
(153, 6623, 'Marketing Management', '', 0, 0, 3, b'1', 8),
(154, 6626, 'Business Policy and Strategy', '', 0, 0, 3, b'1', 8),
(155, 6628, 'Applied Business Solutions', '', 0, 0, 3, b'1', 8),
(156, 6637, 'Intro to Business Analytics', '', 0, 0, 3, b'1', 8),
(157, 6639, 'MBA Paper', '', 0, 0, 3, b'1', 8),
(158, 6650, 'Thesis', '', 1, 6, 0, b'0', 8),
(159, 6692, 'Special Problems in Bus Admin', '', 0, 0, 3, b'1', 8),
(160, 2210, 'Beg Entrepreneurship', '', 0, 0, 3, b'1', 9),
(161, 2216, 'Business Statistics', '', 0, 0, 3, b'1', 9),
(162, 2217, 'Advanced Business Statistics', '', 0, 0, 3, b'1', 9),
(163, 2261, 'Legal Environment of Orgs', '', 0, 0, 3, b'1', 9),
(164, 3312, 'Indiv and Organizational Behav', '', 0, 0, 3, b'1', 9),
(165, 3329, 'Operations Production Mgt', '', 0, 0, 3, b'1', 9),
(166, 4410, 'Entrepreneurship', '', 0, 0, 3, b'1', 9),
(167, 4411, 'Sm Bus Entrepreneurship Prac', '', 0, 0, 3, b'1', 9),
(168, 4441, 'Leading in Organizations', '', 0, 0, 3, b'1', 9),
(169, 4460, 'Strategic Management', '', 0, 0, 3, b'1', 9),
(170, 4473, 'Human Resource Management', '', 0, 0, 3, b'1', 9),
(171, 4480, 'Labor and Employment Law', '', 0, 0, 3, b'1', 9),
(172, 4482, 'Project Management', '', 0, 0, 3, b'1', 9),
(173, 4492, 'Research Methods in Management', '', 0, 0, 3, b'1', 9),
(174, 4499, 'Data Visualization', '', 0, 0, 3, b'1', 9),
(175, 5541, 'Leading in Organizations', '', 0, 0, 3, b'1', 9),
(176, 5573, 'Human Resource Management', '', 0, 0, 3, b'1', 9),
(177, 5580, 'Labor and Employment Law', '', 0, 0, 3, b'1', 9),
(178, 5582, 'Project Management', '', 0, 0, 3, b'1', 9),
(179, 5592, 'Special Problems in Management', '', 0, 0, 3, b'1', 9),
(180, 5599, 'Business Advisory Services', '', 0, 0, 3, b'1', 9),
(181, 2225, 'Principles of Marketing', '', 0, 0, 3, b'1', 6),
(182, 3393, 'Marketing Internship', '', 1, 3, 0, b'0', 6),
(183, 4410, 'Entrepreneurship', '', 0, 0, 3, b'1', 6),
(184, 4411, 'Sm Bus Entrepreneurship Prac', '', 0, 0, 3, b'1', 6),
(185, 4421, 'Services Marketing', '', 0, 0, 3, b'1', 6),
(186, 4426, 'Marketing Research', '', 0, 0, 3, b'1', 6),
(187, 4427, 'Consumer Behavior', '', 0, 0, 3, b'1', 6),
(188, 4428, 'Integrated Brand Promotion', '', 0, 0, 3, b'1', 6),
(189, 4480, 'Social media marketing', '', 0, 0, 3, b'1', 6),
(190, 4499, 'Data Visualization', '', 0, 0, 3, b'1', 6),
(191, 5521, 'Services Marketing', '', 0, 0, 3, b'1', 6),
(192, 5526, 'Marketing Research', '', 0, 0, 3, b'1', 6),
(193, 5527, 'Consumer Behavior', '', 0, 0, 3, b'1', 6),
(194, 5528, 'Integrated Brand Promotion', '', 0, 0, 3, b'1', 6),
(195, 5580, 'Social media marketing', '', 0, 0, 3, b'1', 6);

-- --------------------------------------------------------

--
-- Table structure for table `days`
--

CREATE TABLE `days` (
  `DayID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Abbreviation` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `days`
--

INSERT INTO `days` (`DayID`, `Name`, `Abbreviation`) VALUES
(1, 'Monday', 'M'),
(2, 'Tuesday', 'T'),
(3, 'Wednesday', 'W'),
(4, 'Thursday', 'R'),
(5, 'Friday', 'F'),
(6, 'Saturday', 'S'),
(7, 'Sunday', 'U');

-- --------------------------------------------------------

--
-- Table structure for table `departmentcolleges`
--

CREATE TABLE `departmentcolleges` (
  `DepartmentCollegeID` int(11) NOT NULL,
  `CollegeID` int(11) NOT NULL,
  `DepartmentID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `DepartmentID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Abbreviation` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`DepartmentID`, `Name`, `Abbreviation`) VALUES
(1, 'Accounting', 'ACCT'),
(2, 'Finance', 'FIN'),
(3, 'Informatics', 'INFO'),
(4, 'Computer Science', 'CS'),
(5, 'Business Admin', 'BA'),
(6, 'Marketing', 'MKTG'),
(7, 'Economics', 'ECON'),
(8, 'Masters of Business Admin', 'MBA'),
(9, 'Management', 'MGT'),
(10, 'Health Care Admin', 'HCA');

-- --------------------------------------------------------

--
-- Table structure for table `fees`
--

CREATE TABLE `fees` (
  `FeeID` int(11) NOT NULL,
  `DetailCode` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fees`
--

INSERT INTO `fees` (`FeeID`, `DetailCode`) VALUES
(1, 'CAC1'),
(2, 'IBU'),
(3, 'CBA2'),
(4, 'CCl1'),
(5, 'CCR0'),
(6, 'CCI1'),
(7, 'CBA0');

-- --------------------------------------------------------

--
-- Table structure for table `instructors`
--

CREATE TABLE `instructors` (
  `InstructorID` int(11) NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `MiddleName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Number` int(11) NOT NULL,
  `CourseLoad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `instructors`
--

INSERT INTO `instructors` (`InstructorID`, `FirstName`, `MiddleName`, `LastName`, `Number`, `CourseLoad`) VALUES
(1, 'Justin', '', 'Wood', 0, 0),
(2, 'Michele', '', 'O Brien-Rose', 0, 0),
(3, 'Robert', '', 'Picard', 0, 0),
(4, 'Jerry', '', 'Leffler', 0, 0),
(5, 'Dawn', '', 'Konicek', 0, 0),
(6, 'Jason', '', 'Chen', 0, 0),
(7, 'Ramon', '', 'Rodriguez', 0, 0),
(8, 'Marcus', '', 'Burger', 0, 0),
(9, 'Dave', '', 'Bagley', 0, 0),
(10, 'Brandon', '', 'Carpenter', 185121, 0),
(11, 'Jonathan', '', 'Holmes', 163604, 0),
(12, 'David', '', 'Beard', 107777, 0),
(13, 'Michael', '', 'McGregor', 215125, 0),
(14, 'Robert', '', 'Howe', 176970, 0),
(15, 'Paul', '', 'Bodily', 926940, 0),
(16, 'Isaac', '', 'Griffith', 927452, 0),
(17, 'Robert', '', 'Houghton', 185121, 0),
(18, 'Iris', '', 'Buder', 0, 0),
(19, 'Karl', '', 'Geisler', 0, 0),
(20, 'Scott', '', 'Benson', 0, 0),
(21, 'Jason', '', 'Hansen', 0, 0),
(22, 'Tesa', '', 'Stegner', 0, 0),
(23, 'Fred', '', 'Parrish', 0, 0),
(24, 'Steven', '', 'Byers', 0, 0),
(25, 'Jeffrey', '', 'Brookman', 0, 0),
(26, 'Ken', '', 'Khang', 0, 0),
(27, 'Joshua', '', 'Thompson', 0, 0),
(28, 'Ruiling', '', 'Guo', 0, 0),
(29, 'Velma', '', 'Payne', 0, 0),
(30, 'Tracy', '', 'Farnsworth', 0, 0),
(31, 'Douglas', '', 'Crabtree', 0, 0),
(32, 'John', '', 'Abreu', 0, 0),
(33, 'CHC1', '', '300', 0, 0),
(34, 'Robert', '', 'Cuoio', 0, 0),
(35, 'Ann', '', 'Nevers', 0, 0),
(36, 'Tony', '', 'Lovgren', 21432, 0),
(37, 'Frankie', '', 'Adams', 75388, 0),
(38, 'Thomas', '', 'Ottaway', 142430, 0),
(39, 'Larry', '', 'Leibrock', 0, 0),
(40, 'Corey', '', 'Schou', 17683, 0),
(41, 'Sandra', '', 'Speck', 0, 0),
(42, 'Alexander', '', 'Bolinger', 0, 0),
(43, 'Gregory', '', 'Murphy', 0, 0),
(44, 'Neil', '', 'tocher', 0, 0),
(45, 'Teri', '', 'Peterson', 0, 0),
(46, 'Kerry', '', 'Casperson', 0, 0),
(47, 'Jeff', '', 'Street', 0, 0),
(48, 'Julie', '', 'Frischmann', 0, 0),
(49, 'Norman', '', 'Smith', 0, 0),
(50, 'Yan', '', 'Chen', 0, 0),
(51, 'Larry', '', 'Cravens', 0, 0),
(52, 'Tyler', '', 'Burch', 0, 0),
(53, 'Dennis', '', 'Krumwiede', 0, 0),
(54, 'Stacy', '', 'Gibson', 0, 0),
(55, 'Stacey', '', 'gibson', 0, 0),
(56, 'Alexander', '', 'Rose', 0, 0),
(57, 'Nicole', '', 'Hanson', 0, 0),
(58, 'John', '', 'Ney', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `instructortosections`
--

CREATE TABLE `instructortosections` (
  `InstructorToSectionID` int(11) NOT NULL,
  `IsPrimary` bit(1) NOT NULL,
  `TeachingPercentage` int(11) NOT NULL,
  `DateArchived` datetime NOT NULL,
  `InstructorID` int(11) NOT NULL,
  `SectionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `instructortosections`
--

INSERT INTO `instructortosections` (`InstructorToSectionID`, `IsPrimary`, `TeachingPercentage`, `DateArchived`, `InstructorID`, `SectionID`) VALUES
(279, b'1', 0, '9999-12-31 23:59:59', 1, 331),
(280, b'1', 0, '9999-12-31 23:59:59', 2, 332),
(281, b'1', 0, '9999-12-31 23:59:59', 1, 333),
(282, b'1', 0, '9999-12-31 23:59:59', 1, 334),
(283, b'1', 0, '9999-12-31 23:59:59', 3, 335),
(284, b'1', 0, '9999-12-31 23:59:59', 4, 336),
(285, b'1', 0, '9999-12-31 23:59:59', 4, 337),
(286, b'1', 0, '9999-12-31 23:59:59', 2, 338),
(287, b'1', 0, '9999-12-31 23:59:59', 2, 339),
(288, b'1', 0, '9999-12-31 23:59:59', 5, 340),
(289, b'1', 0, '9999-12-31 23:59:59', 4, 341),
(290, b'1', 0, '9999-12-31 23:59:59', 6, 342),
(291, b'1', 0, '9999-12-31 23:59:59', 5, 343),
(292, b'1', 0, '9999-12-31 23:59:59', 4, 344),
(293, b'1', 0, '9999-12-31 23:59:59', 4, 345),
(294, b'1', 0, '9999-12-31 23:59:59', 7, 346),
(295, b'1', 0, '9999-12-31 23:59:59', 8, 347),
(296, b'1', 0, '9999-12-31 23:59:59', 9, 349),
(297, b'1', 0, '9999-12-31 23:59:59', 9, 350),
(298, b'1', 0, '9999-12-31 23:59:59', 3, 351),
(299, b'1', 0, '9999-12-31 23:59:59', 7, 352),
(300, b'1', 0, '9999-12-31 23:59:59', 4, 353),
(301, b'1', 0, '9999-12-31 23:59:59', 2, 354),
(302, b'1', 0, '9999-12-31 23:59:59', 8, 355),
(303, b'1', 0, '9999-12-31 23:59:59', 5, 356),
(304, b'1', 0, '9999-12-31 23:59:59', 5, 357),
(305, b'1', 0, '9999-12-31 23:59:59', 9, 358),
(306, b'1', 0, '9999-12-31 23:59:59', 9, 359),
(307, b'1', 0, '9999-12-31 23:59:59', 3, 360),
(308, b'1', 0, '9999-12-31 23:59:59', 6, 361),
(309, b'1', 0, '9999-12-31 23:59:59', 6, 362),
(310, b'1', 0, '9999-12-31 23:59:59', 5, 363),
(311, b'1', 0, '9999-12-31 23:59:59', 4, 364),
(312, b'1', 0, '9999-12-31 23:59:59', 4, 365),
(313, b'1', 0, '9999-12-31 23:59:59', 7, 366),
(314, b'1', 0, '9999-12-31 23:59:59', 7, 367),
(315, b'1', 0, '9999-12-31 23:59:59', 4, 368),
(316, b'1', 0, '9999-12-31 23:59:59', 2, 369),
(317, b'1', 0, '9999-12-31 23:59:59', 8, 370),
(318, b'1', 0, '9999-12-31 23:59:59', 8, 371),
(319, b'1', 0, '9999-12-31 23:59:59', 7, 372),
(320, b'1', 0, '9999-12-31 23:59:59', 9, 373),
(321, b'1', 100, '9999-12-31 23:59:59', 10, 380),
(322, b'1', 100, '9999-12-31 23:59:59', 10, 381),
(323, b'1', 50, '9999-12-31 23:59:59', 11, 382),
(324, b'0', 50, '9999-12-31 23:59:59', 11, 382),
(325, b'1', 50, '9999-12-31 23:59:59', 11, 383),
(326, b'0', 50, '9999-12-31 23:59:59', 11, 383),
(327, b'1', 100, '9999-12-31 23:59:59', 13, 384),
(328, b'1', 100, '9999-12-31 23:59:59', 13, 385),
(329, b'1', 100, '9999-12-31 23:59:59', 14, 386),
(330, b'1', 100, '9999-12-31 23:59:59', 14, 387),
(331, b'1', 100, '9999-12-31 23:59:59', 15, 388),
(332, b'1', 100, '9999-12-31 23:59:59', 15, 389),
(333, b'1', 100, '9999-12-31 23:59:59', 12, 390),
(334, b'1', 100, '9999-12-31 23:59:59', 12, 391),
(335, b'1', 100, '9999-12-31 23:59:59', 16, 392),
(336, b'1', 100, '9999-12-31 23:59:59', 16, 393),
(337, b'1', 100, '9999-12-31 23:59:59', 17, 394),
(338, b'1', 100, '9999-12-31 23:59:59', 16, 395),
(339, b'1', 100, '9999-12-31 23:59:59', 16, 396),
(340, b'1', 100, '9999-12-31 23:59:59', 16, 397),
(341, b'1', 100, '9999-12-31 23:59:59', 16, 398),
(342, b'1', 100, '9999-12-31 23:59:59', 13, 399),
(343, b'1', 100, '9999-12-31 23:59:59', 13, 400),
(344, b'1', 100, '9999-12-31 23:59:59', 15, 403),
(345, b'1', 100, '9999-12-31 23:59:59', 15, 404),
(346, b'1', 100, '9999-12-31 23:59:59', 13, 405),
(347, b'1', 100, '9999-12-31 23:59:59', 13, 406),
(348, b'1', 100, '9999-12-31 23:59:59', 12, 407),
(349, b'1', 50, '9999-12-31 23:59:59', 11, 410),
(350, b'0', 50, '9999-12-31 23:59:59', 11, 410),
(351, b'1', 50, '9999-12-31 23:59:59', 11, 411),
(352, b'0', 50, '9999-12-31 23:59:59', 11, 411),
(353, b'1', 100, '9999-12-31 23:59:59', 16, 412),
(354, b'1', 100, '9999-12-31 23:59:59', 16, 413),
(355, b'1', 100, '9999-12-31 23:59:59', 13, 414),
(356, b'1', 100, '9999-12-31 23:59:59', 13, 415),
(357, b'1', 100, '9999-12-31 23:59:59', 15, 416),
(358, b'1', 100, '9999-12-31 23:59:59', 15, 417),
(359, b'1', 100, '9999-12-31 23:59:59', 13, 418),
(360, b'1', 100, '9999-12-31 23:59:59', 13, 419),
(361, b'1', 100, '9999-12-31 23:59:59', 15, 422),
(362, b'1', 100, '9999-12-31 23:59:59', 15, 423),
(363, b'1', 100, '9999-12-31 23:59:59', 16, 424),
(364, b'1', 100, '9999-12-31 23:59:59', 16, 425),
(365, b'1', 0, '9999-12-31 23:59:59', 18, 426),
(366, b'1', 0, '9999-12-31 23:59:59', 19, 427),
(367, b'1', 0, '9999-12-31 23:59:59', 19, 428),
(368, b'1', 0, '9999-12-31 23:59:59', 20, 429),
(369, b'1', 0, '9999-12-31 23:59:59', 21, 430),
(370, b'1', 0, '9999-12-31 23:59:59', 20, 431),
(371, b'1', 0, '9999-12-31 23:59:59', 22, 432),
(372, b'1', 0, '9999-12-31 23:59:59', 22, 433),
(373, b'1', 0, '9999-12-31 23:59:59', 19, 435),
(374, b'1', 0, '9999-12-31 23:59:59', 22, 437),
(375, b'1', 0, '9999-12-31 23:59:59', 18, 438),
(376, b'1', 0, '9999-12-31 23:59:59', 18, 439),
(377, b'1', 0, '9999-12-31 23:59:59', 22, 443),
(378, b'1', 0, '9999-12-31 23:59:59', 18, 444),
(379, b'1', 0, '9999-12-31 23:59:59', 18, 445),
(380, b'1', 0, '9999-12-31 23:59:59', 23, 452),
(381, b'1', 0, '9999-12-31 23:59:59', 24, 453),
(382, b'1', 0, '9999-12-31 23:59:59', 24, 454),
(383, b'1', 0, '9999-12-31 23:59:59', 25, 455),
(384, b'1', 0, '9999-12-31 23:59:59', 25, 456),
(385, b'1', 0, '9999-12-31 23:59:59', 23, 458),
(386, b'1', 0, '9999-12-31 23:59:59', 24, 459),
(387, b'1', 0, '9999-12-31 23:59:59', 26, 460),
(388, b'1', 0, '9999-12-31 23:59:59', 25, 461),
(389, b'1', 0, '9999-12-31 23:59:59', 26, 462),
(390, b'1', 0, '9999-12-31 23:59:59', 26, 463),
(391, b'1', 0, '9999-12-31 23:59:59', 25, 465),
(392, b'1', 0, '9999-12-31 23:59:59', 23, 467),
(393, b'1', 0, '9999-12-31 23:59:59', 24, 468),
(394, b'1', 0, '9999-12-31 23:59:59', 26, 469),
(395, b'1', 0, '9999-12-31 23:59:59', 25, 470),
(396, b'1', 0, '9999-12-31 23:59:59', 26, 471),
(397, b'1', 0, '9999-12-31 23:59:59', 26, 472),
(398, b'1', 0, '9999-12-31 23:59:59', 27, 473),
(399, b'1', 0, '9999-12-31 23:59:59', 28, 474),
(400, b'1', 0, '9999-12-31 23:59:59', 27, 475),
(401, b'1', 0, '9999-12-31 23:59:59', 28, 476),
(402, b'1', 0, '9999-12-31 23:59:59', 29, 477),
(403, b'1', 0, '9999-12-31 23:59:59', 29, 478),
(404, b'1', 0, '9999-12-31 23:59:59', 30, 481),
(405, b'1', 0, '9999-12-31 23:59:59', 30, 483),
(406, b'1', 0, '9999-12-31 23:59:59', 31, 484),
(407, b'1', 0, '9999-12-31 23:59:59', 31, 485),
(408, b'1', 0, '9999-12-31 23:59:59', 31, 486),
(409, b'1', 0, '9999-12-31 23:59:59', 28, 487),
(410, b'1', 0, '9999-12-31 23:59:59', 18, 488),
(411, b'1', 0, '9999-12-31 23:59:59', 32, 489),
(412, b'1', 0, '9999-12-31 23:59:59', 32, 490),
(413, b'1', 0, '9999-12-31 23:59:59', 32, 491),
(414, b'1', 0, '9999-12-31 23:59:59', 31, 492),
(415, b'1', 0, '9999-12-31 23:59:59', 27, 493),
(416, b'1', 0, '9999-12-31 23:59:59', 27, 494),
(417, b'1', 0, '9999-12-31 23:59:59', 29, 495),
(418, b'0', 0, '9999-12-31 23:59:59', 29, 495),
(419, b'1', 0, '9999-12-31 23:59:59', 34, 496),
(420, b'1', 0, '9999-12-31 23:59:59', 31, 497),
(421, b'1', 0, '9999-12-31 23:59:59', 31, 498),
(422, b'1', 0, '9999-12-31 23:59:59', 31, 499),
(423, b'1', 0, '9999-12-31 23:59:59', 28, 500),
(424, b'1', 0, '9999-12-31 23:59:59', 18, 501),
(425, b'1', 0, '9999-12-31 23:59:59', 32, 502),
(426, b'1', 0, '9999-12-31 23:59:59', 32, 503),
(427, b'1', 0, '9999-12-31 23:59:59', 32, 504),
(428, b'1', 0, '9999-12-31 23:59:59', 31, 505),
(429, b'1', 0, '9999-12-31 23:59:59', 35, 507),
(430, b'1', 0, '9999-12-31 23:59:59', 34, 508),
(431, b'1', 0, '9999-12-31 23:59:59', 30, 509),
(432, b'1', 0, '9999-12-31 23:59:59', 30, 510),
(433, b'1', 100, '9999-12-31 23:59:59', 36, 511),
(434, b'1', 100, '9999-12-31 23:59:59', 37, 512),
(435, b'1', 100, '9999-12-31 23:59:59', 37, 513),
(436, b'1', 100, '9999-12-31 23:59:59', 36, 514),
(437, b'1', 100, '9999-12-31 23:59:59', 17, 515),
(438, b'1', 100, '9999-12-31 23:59:59', 10, 517),
(439, b'1', 100, '9999-12-31 23:59:59', 10, 518),
(440, b'1', 50, '9999-12-31 23:59:59', 11, 519),
(441, b'0', 50, '9999-12-31 23:59:59', 11, 519),
(442, b'1', 50, '9999-12-31 23:59:59', 11, 520),
(443, b'0', 50, '9999-12-31 23:59:59', 11, 520),
(444, b'1', 100, '9999-12-31 23:59:59', 11, 521),
(445, b'1', 100, '9999-12-31 23:59:59', 11, 522),
(446, b'1', 100, '9999-12-31 23:59:59', 11, 523),
(447, b'1', 100, '9999-12-31 23:59:59', 11, 524),
(448, b'1', 100, '9999-12-31 23:59:59', 38, 525),
(449, b'1', 100, '9999-12-31 23:59:59', 38, 526),
(450, b'1', 100, '9999-12-31 23:59:59', 16, 529),
(451, b'1', 100, '9999-12-31 23:59:59', 16, 530),
(452, b'1', 0, '9999-12-31 23:59:59', 29, 531),
(453, b'1', 0, '9999-12-31 23:59:59', 29, 532),
(454, b'1', 0, '9999-12-31 23:59:59', 29, 533),
(455, b'1', 100, '9999-12-31 23:59:59', 38, 537),
(456, b'1', 100, '9999-12-31 23:59:59', 38, 538),
(457, b'1', 0, '9999-12-31 23:59:59', 39, 541),
(458, b'1', 0, '9999-12-31 23:59:59', 29, 543),
(459, b'1', 0, '9999-12-31 23:59:59', 29, 544),
(460, b'1', 100, '9999-12-31 23:59:59', 11, 545),
(461, b'1', 100, '9999-12-31 23:59:59', 11, 546),
(462, b'1', 0, '9999-12-31 23:59:59', 40, 547),
(463, b'1', 100, '9999-12-31 23:59:59', 12, 548),
(464, b'1', 0, '9999-12-31 23:59:59', 39, 553),
(465, b'1', 100, '9999-12-31 23:59:59', 16, 554),
(466, b'1', 100, '9999-12-31 23:59:59', 16, 555),
(467, b'1', 100, '9999-12-31 23:59:59', 38, 556),
(468, b'1', 100, '9999-12-31 23:59:59', 38, 557),
(469, b'1', 0, '9999-12-31 23:59:59', 39, 561),
(470, b'1', 0, '9999-12-31 23:59:59', 40, 562),
(471, b'1', 0, '9999-12-31 23:59:59', 40, 563),
(472, b'1', 0, '9999-12-31 23:59:59', 40, 564),
(473, b'1', 0, '9999-12-31 23:59:59', 40, 565),
(474, b'1', 0, '9999-12-31 23:59:59', 29, 566),
(475, b'1', 0, '9999-12-31 23:59:59', 29, 567),
(476, b'1', 0, '9999-12-31 23:59:59', 29, 568),
(477, b'1', 0, '9999-12-31 23:59:59', 29, 569),
(478, b'1', 0, '9999-12-31 23:59:59', 29, 570),
(479, b'1', 100, '9999-12-31 23:59:59', 11, 571),
(480, b'1', 100, '9999-12-31 23:59:59', 11, 572),
(481, b'1', 0, '9999-12-31 23:59:59', 40, 573),
(482, b'1', 0, '9999-12-31 23:59:59', 40, 574),
(483, b'1', 0, '9999-12-31 23:59:59', 39, 576),
(484, b'1', 0, '9999-12-31 23:59:59', 29, 577),
(485, b'1', 0, '9999-12-31 23:59:59', 29, 578),
(486, b'1', 0, '9999-12-31 23:59:59', 29, 579),
(487, b'1', 0, '9999-12-31 23:59:59', 29, 580),
(488, b'1', 0, '9999-12-31 23:59:59', 3, 581),
(489, b'1', 0, '9999-12-31 23:59:59', 41, 582),
(490, b'1', 0, '9999-12-31 23:59:59', 42, 585),
(491, b'1', 0, '9999-12-31 23:59:59', 42, 586),
(492, b'1', 0, '9999-12-31 23:59:59', 43, 588),
(493, b'1', 0, '9999-12-31 23:59:59', 43, 589),
(494, b'1', 0, '9999-12-31 23:59:59', 43, 590),
(495, b'1', 0, '9999-12-31 23:59:59', 44, 591),
(496, b'1', 0, '9999-12-31 23:59:59', 44, 592),
(497, b'1', 0, '9999-12-31 23:59:59', 45, 593),
(498, b'1', 0, '9999-12-31 23:59:59', 45, 594),
(499, b'1', 0, '9999-12-31 23:59:59', 45, 595),
(500, b'1', 0, '9999-12-31 23:59:59', 45, 596),
(501, b'1', 0, '9999-12-31 23:59:59', 40, 597),
(502, b'1', 0, '9999-12-31 23:59:59', 46, 598),
(503, b'1', 0, '9999-12-31 23:59:59', 47, 600),
(504, b'1', 0, '9999-12-31 23:59:59', 48, 601),
(505, b'1', 0, '9999-12-31 23:59:59', 45, 602),
(506, b'1', 0, '9999-12-31 23:59:59', 48, 603),
(507, b'1', 0, '9999-12-31 23:59:59', 45, 604),
(508, b'1', 0, '9999-12-31 23:59:59', 48, 605),
(509, b'1', 0, '9999-12-31 23:59:59', 48, 606),
(510, b'1', 0, '9999-12-31 23:59:59', 49, 608),
(511, b'1', 0, '9999-12-31 23:59:59', 9, 609),
(512, b'1', 0, '9999-12-31 23:59:59', 50, 610),
(513, b'1', 0, '9999-12-31 23:59:59', 51, 611),
(514, b'1', 0, '9999-12-31 23:59:59', 51, 612),
(515, b'1', 0, '9999-12-31 23:59:59', 52, 613),
(516, b'1', 0, '9999-12-31 23:59:59', 53, 614),
(517, b'1', 0, '9999-12-31 23:59:59', 53, 615),
(518, b'1', 0, '9999-12-31 23:59:59', 43, 616),
(519, b'1', 0, '9999-12-31 23:59:59', 47, 617),
(520, b'1', 0, '9999-12-31 23:59:59', 47, 618),
(521, b'1', 0, '9999-12-31 23:59:59', 52, 619),
(522, b'1', 0, '9999-12-31 23:59:59', 52, 620),
(523, b'1', 0, '9999-12-31 23:59:59', 44, 621),
(524, b'1', 0, '9999-12-31 23:59:59', 44, 622),
(525, b'1', 0, '9999-12-31 23:59:59', 50, 623),
(526, b'1', 0, '9999-12-31 23:59:59', 50, 624),
(527, b'1', 0, '9999-12-31 23:59:59', 54, 625),
(528, b'1', 0, '9999-12-31 23:59:59', 53, 626),
(529, b'1', 0, '9999-12-31 23:59:59', 2, 629),
(530, b'1', 0, '9999-12-31 23:59:59', 42, 630),
(531, b'1', 0, '9999-12-31 23:59:59', 42, 631),
(532, b'1', 0, '9999-12-31 23:59:59', 52, 632),
(533, b'1', 0, '9999-12-31 23:59:59', 50, 633),
(534, b'1', 0, '9999-12-31 23:59:59', 55, 634),
(535, b'1', 0, '9999-12-31 23:59:59', 53, 635),
(536, b'1', 0, '9999-12-31 23:59:59', 2, 639),
(537, b'1', 0, '9999-12-31 23:59:59', 42, 640),
(538, b'1', 0, '9999-12-31 23:59:59', 56, 641),
(539, b'1', 0, '9999-12-31 23:59:59', 57, 642),
(540, b'1', 0, '9999-12-31 23:59:59', 57, 643),
(541, b'1', 0, '9999-12-31 23:59:59', 41, 644),
(542, b'1', 0, '9999-12-31 23:59:59', 58, 646),
(543, b'1', 0, '9999-12-31 23:59:59', 43, 647),
(544, b'1', 0, '9999-12-31 23:59:59', 47, 648),
(545, b'1', 0, '9999-12-31 23:59:59', 47, 649),
(546, b'1', 0, '9999-12-31 23:59:59', 58, 650),
(547, b'1', 0, '9999-12-31 23:59:59', 57, 651),
(548, b'1', 0, '9999-12-31 23:59:59', 41, 652),
(549, b'1', 0, '9999-12-31 23:59:59', 56, 653),
(550, b'1', 0, '9999-12-31 23:59:59', 56, 654),
(551, b'1', 0, '9999-12-31 23:59:59', 58, 655),
(552, b'1', 0, '9999-12-31 23:59:59', 58, 656),
(553, b'1', 0, '9999-12-31 23:59:59', 57, 657),
(554, b'1', 0, '9999-12-31 23:59:59', 41, 658),
(555, b'1', 0, '9999-12-31 23:59:59', 56, 659),
(556, b'1', 0, '9999-12-31 23:59:59', 56, 660);

-- --------------------------------------------------------

--
-- Table structure for table `partofterm`
--

CREATE TABLE `partofterm` (
  `PartOfTermID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Abbreviation` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partofterm`
--

INSERT INTO `partofterm` (`PartOfTermID`, `Name`, `Abbreviation`) VALUES
(1, 'Full', 'Full'),
(2, 'Early 4', 'E4'),
(3, 'Early 6', 'E6'),
(4, 'Early 8', 'E8'),
(5, 'Middle 4', 'M4'),
(6, 'Late 8', 'L8'),
(7, 'Late 6', 'L6'),
(8, 'Late 4', 'L4');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `RoleID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `IsAdmin` bit(1) NOT NULL,
  `Sections` bit(4) NOT NULL,
  `Courses` bit(4) NOT NULL,
  `Buildings` bit(4) NOT NULL,
  `Campuses` bit(4) NOT NULL,
  `Roles` bit(4) NOT NULL,
  `Users` bit(4) NOT NULL,
  `Departments` bit(4) NOT NULL,
  `Fees` bit(4) NOT NULL,
  `Instructors` bit(4) NOT NULL,
  `Days` bit(4) NOT NULL,
  `Rooms` bit(4) NOT NULL,
  `ScheduleTypes` bit(4) NOT NULL,
  `Spreadsheets` bit(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`RoleID`, `Name`, `IsAdmin`, `Sections`, `Courses`, `Buildings`, `Campuses`, `Roles`, `Users`, `Departments`, `Fees`, `Instructors`, `Days`, `Rooms`, `ScheduleTypes`, `Spreadsheets`) VALUES
(1, 'Admin', b'1', b'1111', b'1111', b'1111', b'1111', b'1111', b'1111', b'1111', b'1111', b'1111', b'1111', b'1111', b'1111', b'1111'),
(2, 'Basic', b'0', b'0010', b'0010', b'0010', b'0010', b'0010', b'0010', b'0010', b'0010', b'0010', b'0010', b'0010', b'0010', b'0010');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `RoomID` int(11) NOT NULL,
  `Number` varchar(255) NOT NULL,
  `SeatsAvailable` int(11) NOT NULL,
  `Details` varchar(255) NOT NULL,
  `BuildingID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`RoomID`, `Number`, `SeatsAvailable`, `Details`, `BuildingID`) VALUES
(1, '407', 0, '', 1),
(2, '506', 0, '', 1),
(3, '267', 0, '', 4),
(4, '412', 0, '', 1),
(5, '503', 0, '', 1),
(6, '411', 0, '', 1),
(7, '402', 0, '', 1),
(8, '133', 0, '', 1),
(9, '263', 0, '', 4),
(10, '214', 0, '', 1),
(11, '208', 0, '', 1),
(12, '135', 0, '', 1),
(13, '0', 0, '', 5),
(14, '315', 0, '', 2),
(15, '211', 0, '', 3),
(16, '118', 0, '', 2),
(17, '108', 0, '', 2),
(18, '408', 0, '', 1),
(19, '104', 0, '', 1),
(20, '211', 0, '', 1),
(21, '403', 0, '', 1),
(22, '307', 0, '', 3),
(23, '212', 0, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `ScheduleID` int(11) NOT NULL,
  `StartTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  `NumberOfDays` int(11) NOT NULL,
  `CollegeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `scheduletypes`
--

CREATE TABLE `scheduletypes` (
  `ScheduleTypeID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Abbreviation` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scheduletypes`
--

INSERT INTO `scheduletypes` (`ScheduleTypeID`, `Name`, `Abbreviation`) VALUES
(1, 'Standard Lecture', 'CL'),
(2, 'Labratory', 'LB'),
(3, 'Distance Learning', 'DL'),
(4, 'Thesis, Dissertation, Practicum - Does not require a room/not online', 'OT'),
(5, 'Asynchronous Online available anytime', 'AO'),
(6, 'Synchronous Online available at certain times', 'SO'),
(7, 'Blended Online (reduced seat time with less than 40% online components', 'BL'),
(8, 'Mostly Online (Online with up to five on-campus meetings required)', 'OL'),
(9, '', 'VS');

-- --------------------------------------------------------

--
-- Table structure for table `sectiondays`
--

CREATE TABLE `sectiondays` (
  `SectionDayID` int(11) NOT NULL,
  `SectionID` int(11) NOT NULL,
  `DayID` int(11) NOT NULL,
  `DateArchived` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sectiondays`
--

INSERT INTO `sectiondays` (`SectionDayID`, `SectionID`, `DayID`, `DateArchived`) VALUES
(411, 331, 1, '9999-12-31 23:59:59'),
(412, 331, 3, '9999-12-31 23:59:59'),
(413, 332, 2, '9999-12-31 23:59:59'),
(414, 332, 4, '9999-12-31 23:59:59'),
(415, 333, 1, '9999-12-31 23:59:59'),
(416, 333, 3, '9999-12-31 23:59:59'),
(417, 335, 4, '9999-12-31 23:59:59'),
(418, 336, 2, '9999-12-31 23:59:59'),
(419, 336, 4, '9999-12-31 23:59:59'),
(420, 337, 2, '9999-12-31 23:59:59'),
(421, 337, 4, '9999-12-31 23:59:59'),
(422, 338, 2, '9999-12-31 23:59:59'),
(423, 338, 4, '9999-12-31 23:59:59'),
(424, 339, 1, '9999-12-31 23:59:59'),
(425, 339, 3, '9999-12-31 23:59:59'),
(426, 340, 2, '9999-12-31 23:59:59'),
(427, 340, 4, '9999-12-31 23:59:59'),
(428, 341, 2, '9999-12-31 23:59:59'),
(429, 341, 4, '9999-12-31 23:59:59'),
(430, 342, 1, '9999-12-31 23:59:59'),
(431, 342, 3, '9999-12-31 23:59:59'),
(432, 343, 1, '9999-12-31 23:59:59'),
(433, 343, 3, '9999-12-31 23:59:59'),
(434, 344, 1, '9999-12-31 23:59:59'),
(435, 344, 3, '9999-12-31 23:59:59'),
(436, 346, 1, '9999-12-31 23:59:59'),
(437, 346, 3, '9999-12-31 23:59:59'),
(438, 347, 1, '9999-12-31 23:59:59'),
(439, 347, 3, '9999-12-31 23:59:59'),
(440, 348, 2, '9999-12-31 23:59:59'),
(441, 348, 4, '9999-12-31 23:59:59'),
(442, 349, 1, '9999-12-31 23:59:59'),
(443, 349, 3, '9999-12-31 23:59:59'),
(444, 350, 1, '9999-12-31 23:59:59'),
(445, 350, 3, '9999-12-31 23:59:59'),
(446, 351, 2, '9999-12-31 23:59:59'),
(447, 351, 4, '9999-12-31 23:59:59'),
(448, 354, 3, '9999-12-31 23:59:59'),
(449, 355, 1, '9999-12-31 23:59:59'),
(450, 355, 3, '9999-12-31 23:59:59'),
(451, 356, 2, '9999-12-31 23:59:59'),
(452, 356, 4, '9999-12-31 23:59:59'),
(453, 357, 2, '9999-12-31 23:59:59'),
(454, 357, 4, '9999-12-31 23:59:59'),
(455, 358, 1, '9999-12-31 23:59:59'),
(456, 358, 3, '9999-12-31 23:59:59'),
(457, 359, 1, '9999-12-31 23:59:59'),
(458, 359, 3, '9999-12-31 23:59:59'),
(459, 360, 2, '9999-12-31 23:59:59'),
(460, 360, 4, '9999-12-31 23:59:59'),
(461, 361, 1, '9999-12-31 23:59:59'),
(462, 361, 3, '9999-12-31 23:59:59'),
(463, 362, 1, '9999-12-31 23:59:59'),
(464, 362, 3, '9999-12-31 23:59:59'),
(465, 369, 3, '9999-12-31 23:59:59'),
(466, 370, 2, '9999-12-31 23:59:59'),
(467, 370, 4, '9999-12-31 23:59:59'),
(468, 371, 2, '9999-12-31 23:59:59'),
(469, 371, 4, '9999-12-31 23:59:59'),
(470, 372, 2, '9999-12-31 23:59:59'),
(471, 372, 4, '9999-12-31 23:59:59'),
(472, 373, 2, '9999-12-31 23:59:59'),
(473, 373, 4, '9999-12-31 23:59:59'),
(474, 374, 1, '9999-12-31 23:59:59'),
(475, 374, 3, '9999-12-31 23:59:59'),
(476, 374, 5, '9999-12-31 23:59:59'),
(477, 375, 1, '9999-12-31 23:59:59'),
(478, 376, 1, '9999-12-31 23:59:59'),
(479, 378, 1, '9999-12-31 23:59:59'),
(480, 380, 1, '9999-12-31 23:59:59'),
(481, 380, 3, '9999-12-31 23:59:59'),
(482, 380, 5, '9999-12-31 23:59:59'),
(483, 381, 1, '9999-12-31 23:59:59'),
(484, 381, 3, '9999-12-31 23:59:59'),
(485, 381, 5, '9999-12-31 23:59:59'),
(486, 382, 2, '9999-12-31 23:59:59'),
(487, 382, 4, '9999-12-31 23:59:59'),
(488, 383, 2, '9999-12-31 23:59:59'),
(489, 383, 4, '9999-12-31 23:59:59'),
(490, 384, 2, '9999-12-31 23:59:59'),
(491, 384, 4, '9999-12-31 23:59:59'),
(492, 385, 2, '9999-12-31 23:59:59'),
(493, 385, 4, '9999-12-31 23:59:59'),
(494, 386, 2, '9999-12-31 23:59:59'),
(495, 386, 4, '9999-12-31 23:59:59'),
(496, 387, 2, '9999-12-31 23:59:59'),
(497, 387, 4, '9999-12-31 23:59:59'),
(498, 388, 2, '9999-12-31 23:59:59'),
(499, 388, 4, '9999-12-31 23:59:59'),
(500, 389, 2, '9999-12-31 23:59:59'),
(501, 389, 4, '9999-12-31 23:59:59'),
(502, 390, 2, '9999-12-31 23:59:59'),
(503, 390, 4, '9999-12-31 23:59:59'),
(504, 391, 2, '9999-12-31 23:59:59'),
(505, 391, 4, '9999-12-31 23:59:59'),
(506, 392, 2, '9999-12-31 23:59:59'),
(507, 392, 4, '9999-12-31 23:59:59'),
(508, 393, 2, '9999-12-31 23:59:59'),
(509, 393, 4, '9999-12-31 23:59:59'),
(510, 395, 2, '9999-12-31 23:59:59'),
(511, 395, 4, '9999-12-31 23:59:59'),
(512, 396, 2, '9999-12-31 23:59:59'),
(513, 396, 4, '9999-12-31 23:59:59'),
(514, 397, 2, '9999-12-31 23:59:59'),
(515, 397, 4, '9999-12-31 23:59:59'),
(516, 398, 2, '9999-12-31 23:59:59'),
(517, 398, 4, '9999-12-31 23:59:59'),
(518, 399, 2, '9999-12-31 23:59:59'),
(519, 399, 4, '9999-12-31 23:59:59'),
(520, 400, 2, '9999-12-31 23:59:59'),
(521, 400, 4, '9999-12-31 23:59:59'),
(522, 401, 2, '9999-12-31 23:59:59'),
(523, 401, 4, '9999-12-31 23:59:59'),
(524, 402, 2, '9999-12-31 23:59:59'),
(525, 402, 4, '9999-12-31 23:59:59'),
(526, 403, 2, '9999-12-31 23:59:59'),
(527, 403, 4, '9999-12-31 23:59:59'),
(528, 404, 2, '9999-12-31 23:59:59'),
(529, 404, 4, '9999-12-31 23:59:59'),
(530, 405, 2, '9999-12-31 23:59:59'),
(531, 405, 4, '9999-12-31 23:59:59'),
(532, 406, 2, '9999-12-31 23:59:59'),
(533, 406, 4, '9999-12-31 23:59:59'),
(534, 407, 1, '9999-12-31 23:59:59'),
(535, 407, 3, '9999-12-31 23:59:59'),
(536, 407, 5, '9999-12-31 23:59:59'),
(537, 408, 2, '9999-12-31 23:59:59'),
(538, 408, 4, '9999-12-31 23:59:59'),
(539, 409, 2, '9999-12-31 23:59:59'),
(540, 409, 4, '9999-12-31 23:59:59'),
(541, 410, 2, '9999-12-31 23:59:59'),
(542, 411, 2, '9999-12-31 23:59:59'),
(543, 412, 2, '9999-12-31 23:59:59'),
(544, 412, 4, '9999-12-31 23:59:59'),
(545, 413, 2, '9999-12-31 23:59:59'),
(546, 413, 4, '9999-12-31 23:59:59'),
(547, 414, 2, '9999-12-31 23:59:59'),
(548, 414, 4, '9999-12-31 23:59:59'),
(549, 415, 2, '9999-12-31 23:59:59'),
(550, 415, 4, '9999-12-31 23:59:59'),
(551, 416, 2, '9999-12-31 23:59:59'),
(552, 416, 4, '9999-12-31 23:59:59'),
(553, 417, 2, '9999-12-31 23:59:59'),
(554, 417, 4, '9999-12-31 23:59:59'),
(555, 418, 2, '9999-12-31 23:59:59'),
(556, 418, 4, '9999-12-31 23:59:59'),
(557, 419, 2, '9999-12-31 23:59:59'),
(558, 419, 4, '9999-12-31 23:59:59'),
(559, 420, 2, '9999-12-31 23:59:59'),
(560, 420, 4, '9999-12-31 23:59:59'),
(561, 421, 2, '9999-12-31 23:59:59'),
(562, 421, 4, '9999-12-31 23:59:59'),
(563, 422, 2, '9999-12-31 23:59:59'),
(564, 422, 4, '9999-12-31 23:59:59'),
(565, 423, 2, '9999-12-31 23:59:59'),
(566, 423, 4, '9999-12-31 23:59:59'),
(567, 424, 2, '9999-12-31 23:59:59'),
(568, 424, 4, '9999-12-31 23:59:59'),
(569, 425, 2, '9999-12-31 23:59:59'),
(570, 425, 4, '9999-12-31 23:59:59'),
(571, 427, 2, '9999-12-31 23:59:59'),
(572, 427, 4, '9999-12-31 23:59:59'),
(573, 428, 2, '9999-12-31 23:59:59'),
(574, 428, 4, '9999-12-31 23:59:59'),
(575, 430, 2, '9999-12-31 23:59:59'),
(576, 432, 2, '9999-12-31 23:59:59'),
(577, 432, 4, '9999-12-31 23:59:59'),
(578, 433, 2, '9999-12-31 23:59:59'),
(579, 433, 4, '9999-12-31 23:59:59'),
(580, 435, 2, '9999-12-31 23:59:59'),
(581, 435, 4, '9999-12-31 23:59:59'),
(582, 437, 2, '9999-12-31 23:59:59'),
(583, 437, 4, '9999-12-31 23:59:59'),
(584, 439, 1, '9999-12-31 23:59:59'),
(585, 443, 2, '9999-12-31 23:59:59'),
(586, 443, 4, '9999-12-31 23:59:59'),
(587, 445, 1, '9999-12-31 23:59:59'),
(588, 447, 2, '9999-12-31 23:59:59'),
(589, 447, 4, '9999-12-31 23:59:59'),
(590, 448, 3, '9999-12-31 23:59:59'),
(591, 451, 1, '9999-12-31 23:59:59'),
(592, 452, 2, '9999-12-31 23:59:59'),
(593, 452, 4, '9999-12-31 23:59:59'),
(594, 453, 1, '9999-12-31 23:59:59'),
(595, 453, 3, '9999-12-31 23:59:59'),
(596, 454, 1, '9999-12-31 23:59:59'),
(597, 454, 3, '9999-12-31 23:59:59'),
(598, 456, 2, '9999-12-31 23:59:59'),
(599, 456, 4, '9999-12-31 23:59:59'),
(600, 458, 3, '9999-12-31 23:59:59'),
(601, 459, 1, '9999-12-31 23:59:59'),
(602, 459, 3, '9999-12-31 23:59:59'),
(603, 460, 2, '9999-12-31 23:59:59'),
(604, 460, 4, '9999-12-31 23:59:59'),
(605, 462, 2, '9999-12-31 23:59:59'),
(606, 462, 4, '9999-12-31 23:59:59'),
(607, 465, 2, '9999-12-31 23:59:59'),
(608, 465, 4, '9999-12-31 23:59:59'),
(609, 467, 3, '9999-12-31 23:59:59'),
(610, 468, 1, '9999-12-31 23:59:59'),
(611, 468, 3, '9999-12-31 23:59:59'),
(612, 469, 2, '9999-12-31 23:59:59'),
(613, 469, 4, '9999-12-31 23:59:59'),
(614, 471, 2, '9999-12-31 23:59:59'),
(615, 471, 4, '9999-12-31 23:59:59'),
(616, 476, 2, '9999-12-31 23:59:59'),
(617, 476, 4, '9999-12-31 23:59:59'),
(618, 477, 1, '9999-12-31 23:59:59'),
(619, 480, 2, '9999-12-31 23:59:59'),
(620, 480, 4, '9999-12-31 23:59:59'),
(621, 481, 2, '9999-12-31 23:59:59'),
(622, 481, 4, '9999-12-31 23:59:59'),
(623, 482, 2, '9999-12-31 23:59:59'),
(624, 482, 4, '9999-12-31 23:59:59'),
(625, 483, 2, '9999-12-31 23:59:59'),
(626, 483, 4, '9999-12-31 23:59:59'),
(627, 484, 3, '9999-12-31 23:59:59'),
(628, 485, 3, '9999-12-31 23:59:59'),
(629, 486, 3, '9999-12-31 23:59:59'),
(630, 489, 4, '9999-12-31 23:59:59'),
(631, 490, 4, '9999-12-31 23:59:59'),
(632, 491, 4, '9999-12-31 23:59:59'),
(633, 493, 1, '9999-12-31 23:59:59'),
(634, 493, 3, '9999-12-31 23:59:59'),
(635, 497, 3, '9999-12-31 23:59:59'),
(636, 498, 3, '9999-12-31 23:59:59'),
(637, 499, 3, '9999-12-31 23:59:59'),
(638, 502, 4, '9999-12-31 23:59:59'),
(639, 503, 4, '9999-12-31 23:59:59'),
(640, 504, 4, '9999-12-31 23:59:59'),
(641, 511, 2, '9999-12-31 23:59:59'),
(642, 511, 4, '9999-12-31 23:59:59'),
(643, 513, 2, '9999-12-31 23:59:59'),
(644, 514, 3, '9999-12-31 23:59:59'),
(645, 515, 1, '9999-12-31 23:59:59'),
(646, 515, 3, '9999-12-31 23:59:59'),
(647, 516, 2, '9999-12-31 23:59:59'),
(648, 516, 4, '9999-12-31 23:59:59'),
(649, 517, 1, '9999-12-31 23:59:59'),
(650, 517, 3, '9999-12-31 23:59:59'),
(651, 517, 5, '9999-12-31 23:59:59'),
(652, 518, 1, '9999-12-31 23:59:59'),
(653, 518, 3, '9999-12-31 23:59:59'),
(654, 518, 5, '9999-12-31 23:59:59'),
(655, 519, 2, '9999-12-31 23:59:59'),
(656, 519, 4, '9999-12-31 23:59:59'),
(657, 520, 2, '9999-12-31 23:59:59'),
(658, 520, 4, '9999-12-31 23:59:59'),
(659, 521, 2, '9999-12-31 23:59:59'),
(660, 521, 4, '9999-12-31 23:59:59'),
(661, 522, 2, '9999-12-31 23:59:59'),
(662, 522, 4, '9999-12-31 23:59:59'),
(663, 523, 2, '9999-12-31 23:59:59'),
(664, 523, 4, '9999-12-31 23:59:59'),
(665, 524, 2, '9999-12-31 23:59:59'),
(666, 524, 4, '9999-12-31 23:59:59'),
(667, 525, 1, '9999-12-31 23:59:59'),
(668, 525, 3, '9999-12-31 23:59:59'),
(669, 527, 1, '9999-12-31 23:59:59'),
(670, 527, 3, '9999-12-31 23:59:59'),
(671, 529, 2, '9999-12-31 23:59:59'),
(672, 529, 4, '9999-12-31 23:59:59'),
(673, 530, 2, '9999-12-31 23:59:59'),
(674, 530, 4, '9999-12-31 23:59:59'),
(675, 531, 1, '9999-12-31 23:59:59'),
(676, 532, 1, '9999-12-31 23:59:59'),
(677, 534, 2, '9999-12-31 23:59:59'),
(678, 534, 4, '9999-12-31 23:59:59'),
(679, 535, 2, '9999-12-31 23:59:59'),
(680, 535, 4, '9999-12-31 23:59:59'),
(681, 537, 1, '9999-12-31 23:59:59'),
(682, 537, 3, '9999-12-31 23:59:59'),
(683, 538, 1, '9999-12-31 23:59:59'),
(684, 538, 3, '9999-12-31 23:59:59'),
(685, 539, 4, '9999-12-31 23:59:59'),
(686, 540, 4, '9999-12-31 23:59:59'),
(687, 543, 2, '9999-12-31 23:59:59'),
(688, 544, 2, '9999-12-31 23:59:59'),
(689, 545, 1, '9999-12-31 23:59:59'),
(690, 545, 3, '9999-12-31 23:59:59'),
(691, 546, 1, '9999-12-31 23:59:59'),
(692, 546, 3, '9999-12-31 23:59:59'),
(693, 548, 1, '9999-12-31 23:59:59'),
(694, 548, 3, '9999-12-31 23:59:59'),
(695, 548, 5, '9999-12-31 23:59:59'),
(696, 554, 2, '9999-12-31 23:59:59'),
(697, 554, 4, '9999-12-31 23:59:59'),
(698, 555, 2, '9999-12-31 23:59:59'),
(699, 555, 4, '9999-12-31 23:59:59'),
(700, 556, 1, '9999-12-31 23:59:59'),
(701, 556, 3, '9999-12-31 23:59:59'),
(702, 557, 1, '9999-12-31 23:59:59'),
(703, 557, 3, '9999-12-31 23:59:59'),
(704, 558, 4, '9999-12-31 23:59:59'),
(705, 559, 4, '9999-12-31 23:59:59'),
(706, 560, 4, '9999-12-31 23:59:59'),
(707, 566, 1, '9999-12-31 23:59:59'),
(708, 567, 1, '9999-12-31 23:59:59'),
(709, 569, 2, '9999-12-31 23:59:59'),
(710, 570, 2, '9999-12-31 23:59:59'),
(711, 571, 1, '9999-12-31 23:59:59'),
(712, 571, 3, '9999-12-31 23:59:59'),
(713, 572, 1, '9999-12-31 23:59:59'),
(714, 572, 3, '9999-12-31 23:59:59'),
(715, 577, 3, '9999-12-31 23:59:59'),
(716, 578, 3, '9999-12-31 23:59:59'),
(717, 584, 1, '9999-12-31 23:59:59'),
(718, 585, 3, '9999-12-31 23:59:59'),
(719, 586, 4, '9999-12-31 23:59:59'),
(720, 587, 3, '9999-12-31 23:59:59'),
(721, 588, 4, '9999-12-31 23:59:59'),
(722, 589, 4, '9999-12-31 23:59:59'),
(723, 590, 4, '9999-12-31 23:59:59'),
(724, 591, 2, '9999-12-31 23:59:59'),
(725, 592, 2, '9999-12-31 23:59:59'),
(726, 593, 2, '9999-12-31 23:59:59'),
(727, 594, 2, '9999-12-31 23:59:59'),
(728, 595, 2, '9999-12-31 23:59:59'),
(729, 596, 2, '9999-12-31 23:59:59'),
(730, 600, 2, '9999-12-31 23:59:59'),
(731, 600, 4, '9999-12-31 23:59:59'),
(732, 601, 1, '9999-12-31 23:59:59'),
(733, 601, 3, '9999-12-31 23:59:59'),
(734, 602, 2, '9999-12-31 23:59:59'),
(735, 602, 4, '9999-12-31 23:59:59'),
(736, 603, 1, '9999-12-31 23:59:59'),
(737, 603, 3, '9999-12-31 23:59:59'),
(738, 604, 2, '9999-12-31 23:59:59'),
(739, 604, 4, '9999-12-31 23:59:59'),
(740, 605, 2, '9999-12-31 23:59:59'),
(741, 605, 4, '9999-12-31 23:59:59'),
(742, 606, 2, '9999-12-31 23:59:59'),
(743, 606, 4, '9999-12-31 23:59:59'),
(744, 607, 1, '9999-12-31 23:59:59'),
(745, 608, 1, '9999-12-31 23:59:59'),
(746, 608, 3, '9999-12-31 23:59:59'),
(747, 609, 1, '9999-12-31 23:59:59'),
(748, 609, 3, '9999-12-31 23:59:59'),
(749, 610, 2, '9999-12-31 23:59:59'),
(750, 611, 1, '9999-12-31 23:59:59'),
(751, 611, 3, '9999-12-31 23:59:59'),
(752, 612, 1, '9999-12-31 23:59:59'),
(753, 612, 3, '9999-12-31 23:59:59'),
(754, 613, 1, '9999-12-31 23:59:59'),
(755, 613, 3, '9999-12-31 23:59:59'),
(756, 614, 1, '9999-12-31 23:59:59'),
(757, 614, 3, '9999-12-31 23:59:59'),
(758, 615, 1, '9999-12-31 23:59:59'),
(759, 615, 3, '9999-12-31 23:59:59'),
(760, 616, 2, '9999-12-31 23:59:59'),
(761, 616, 4, '9999-12-31 23:59:59'),
(762, 617, 2, '9999-12-31 23:59:59'),
(763, 617, 4, '9999-12-31 23:59:59'),
(764, 618, 2, '9999-12-31 23:59:59'),
(765, 618, 4, '9999-12-31 23:59:59'),
(766, 619, 1, '9999-12-31 23:59:59'),
(767, 619, 3, '9999-12-31 23:59:59'),
(768, 620, 1, '9999-12-31 23:59:59'),
(769, 620, 3, '9999-12-31 23:59:59'),
(770, 621, 2, '9999-12-31 23:59:59'),
(771, 621, 4, '9999-12-31 23:59:59'),
(772, 622, 2, '9999-12-31 23:59:59'),
(773, 622, 4, '9999-12-31 23:59:59'),
(774, 623, 2, '9999-12-31 23:59:59'),
(775, 623, 4, '9999-12-31 23:59:59'),
(776, 624, 2, '9999-12-31 23:59:59'),
(777, 624, 4, '9999-12-31 23:59:59'),
(778, 625, 1, '9999-12-31 23:59:59'),
(779, 625, 3, '9999-12-31 23:59:59'),
(780, 626, 1, '9999-12-31 23:59:59'),
(781, 629, 3, '9999-12-31 23:59:59'),
(782, 630, 5, '9999-12-31 23:59:59'),
(783, 631, 5, '9999-12-31 23:59:59'),
(784, 632, 1, '9999-12-31 23:59:59'),
(785, 632, 3, '9999-12-31 23:59:59'),
(786, 633, 2, '9999-12-31 23:59:59'),
(787, 633, 4, '9999-12-31 23:59:59'),
(788, 634, 1, '9999-12-31 23:59:59'),
(789, 634, 3, '9999-12-31 23:59:59'),
(790, 635, 1, '9999-12-31 23:59:59'),
(791, 639, 3, '9999-12-31 23:59:59'),
(792, 640, 5, '9999-12-31 23:59:59'),
(793, 641, 1, '9999-12-31 23:59:59'),
(794, 641, 3, '9999-12-31 23:59:59'),
(795, 642, 2, '9999-12-31 23:59:59'),
(796, 642, 4, '9999-12-31 23:59:59'),
(797, 643, 2, '9999-12-31 23:59:59'),
(798, 643, 4, '9999-12-31 23:59:59'),
(799, 645, 1, '9999-12-31 23:59:59'),
(800, 645, 3, '9999-12-31 23:59:59'),
(801, 647, 2, '9999-12-31 23:59:59'),
(802, 647, 4, '9999-12-31 23:59:59'),
(803, 648, 2, '9999-12-31 23:59:59'),
(804, 648, 4, '9999-12-31 23:59:59'),
(805, 649, 2, '9999-12-31 23:59:59'),
(806, 649, 4, '9999-12-31 23:59:59'),
(807, 650, 2, '9999-12-31 23:59:59'),
(808, 650, 4, '9999-12-31 23:59:59'),
(809, 651, 2, '9999-12-31 23:59:59'),
(810, 653, 1, '9999-12-31 23:59:59'),
(811, 653, 3, '9999-12-31 23:59:59'),
(812, 654, 1, '9999-12-31 23:59:59'),
(813, 654, 3, '9999-12-31 23:59:59'),
(814, 656, 2, '9999-12-31 23:59:59'),
(815, 656, 4, '9999-12-31 23:59:59'),
(816, 657, 2, '9999-12-31 23:59:59'),
(817, 659, 1, '9999-12-31 23:59:59'),
(818, 659, 3, '9999-12-31 23:59:59'),
(819, 660, 1, '9999-12-31 23:59:59'),
(820, 660, 3, '9999-12-31 23:59:59');

-- --------------------------------------------------------

--
-- Table structure for table `sectionfees`
--

CREATE TABLE `sectionfees` (
  `SectionFeeID` int(11) NOT NULL,
  `SectionID` int(11) NOT NULL,
  `FeeID` int(11) NOT NULL,
  `Amount` decimal(13,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `SectionID` int(11) NOT NULL,
  `CRN` int(11) NOT NULL,
  `RequiresMoodle` bit(1) NOT NULL,
  `RequiresPermission` bit(1) NOT NULL,
  `Notes` varchar(255) NOT NULL,
  `DepartmentComments` varchar(255) NOT NULL,
  `StudentLimit` int(11) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateArchived` datetime NOT NULL,
  `Number` varchar(255) NOT NULL,
  `StartTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  `CourseID` int(11) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `ScheduleTypeID` int(11) NOT NULL,
  `AcademicSemesterID` int(11) NOT NULL,
  `PartOfTermID` int(11) NOT NULL,
  `XListID` varchar(255) NOT NULL,
  `DateDeleted` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`SectionID`, `CRN`, `RequiresMoodle`, `RequiresPermission`, `Notes`, `DepartmentComments`, `StudentLimit`, `DateCreated`, `DateArchived`, `Number`, `StartTime`, `EndTime`, `CourseID`, `RoomID`, `ScheduleTypeID`, `AcademicSemesterID`, `PartOfTermID`, `XListID`, `DateDeleted`) VALUES
(331, 12062, b'1', b'0', '', '', 38, '2019-04-15 14:01:28', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 1, 1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(332, 12063, b'1', b'0', '', '', 25, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 15:45:00', 1, 2, 1, 2, 4, '', '9999-12-31 23:59:59'),
(333, 11517, b'1', b'0', '', '', 38, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '3', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 1, 1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(334, 12064, b'1', b'0', '', '', 35, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '4', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 1, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(335, 10250, b'1', b'0', '', '', 26, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '5', '2019-04-15 14:30:00', '2019-04-15 17:15:00', 1, 3, 1, 2, 1, '', '9999-12-31 23:59:59'),
(336, 10254, b'1', b'0', '', '', 35, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 2, 4, 1, 2, 1, '', '9999-12-31 23:59:59'),
(337, 11518, b'1', b'0', '', '', 35, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 2, 4, 1, 2, 1, '', '9999-12-31 23:59:59'),
(338, 10256, b'1', b'1', '', '', 25, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '3', '2019-04-15 13:00:00', '2019-04-15 15:45:00', 2, 5, 1, 2, 6, '', '9999-12-31 23:59:59'),
(339, 13833, b'1', b'0', '', '', 38, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 3, 4, 1, 2, 1, '', '9999-12-31 23:59:59'),
(340, 10263, b'1', b'0', '', '', 30, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 4, 5, 1, 2, 1, '', '9999-12-31 23:59:59'),
(341, 10266, b'1', b'0', '', '', 30, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 5, 6, 1, 2, 1, '', '9999-12-31 23:59:59'),
(342, 10267, b'1', b'0', '', '', 30, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 6, 7, 1, 2, 1, '', '9999-12-31 23:59:59'),
(343, 13278, b'1', b'0', '', '', 30, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 7, 8, 1, 2, 1, '', '9999-12-31 23:59:59'),
(344, 10268, b'1', b'0', '', '', 30, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 8, 4, 1, 2, 1, '', '9999-12-31 23:59:59'),
(345, 10269, b'1', b'1', '', '', 5, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 9, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(346, 0, b'1', b'0', '', '', 20, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 10, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(347, 11520, b'1', b'0', '', '', 19, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 11, 5, 1, 2, 1, '', '9999-12-31 23:59:59'),
(348, 10270, b'1', b'0', '', '', 28, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 12, 6, 1, 2, 1, '', '9999-12-31 23:59:59'),
(349, 11519, b'1', b'0', '', '', 10, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 16:15:00', 13, 4, 1, 2, 4, '', '9999-12-31 23:59:59'),
(350, 12065, b'1', b'0', '', '', 6, '2019-04-15 14:01:39', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 13, 9, 1, 2, 4, '', '9999-12-31 23:59:59'),
(351, 10271, b'1', b'0', '', '', 30, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 14, 7, 1, 2, 1, '', '9999-12-31 23:59:59'),
(352, 10272, b'1', b'1', '', '', 5, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 15, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(353, 10273, b'1', b'1', '', '', 15, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 16, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(354, 14251, b'1', b'0', '', '', 10, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 17, 2, 1, 2, 1, 'MGT 4499', '9999-12-31 23:59:59'),
(355, 12186, b'1', b'0', '', '', 5, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 18, 5, 1, 2, 1, '', '9999-12-31 23:59:59'),
(356, 10275, b'1', b'0', '', '', 25, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 15:45:00', 19, 7, 1, 2, 4, '', '9999-12-31 23:59:59'),
(357, 12066, b'1', b'0', '', '', 25, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 19, 9, 1, 2, 4, '', '9999-12-31 23:59:59'),
(358, 11521, b'1', b'0', '', '', 25, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 16:15:00', 20, 4, 1, 2, 4, '', '9999-12-31 23:59:59'),
(359, 12067, b'1', b'0', '', '', 20, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 20, 9, 1, 2, 4, '', '9999-12-31 23:59:59'),
(360, 10276, b'1', b'0', '', '', 4, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 21, 7, 1, 2, 1, '', '9999-12-31 23:59:59'),
(361, 10277, b'1', b'0', '', '', 25, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 16:15:00', 22, 7, 1, 2, 6, '', '9999-12-31 23:59:59'),
(362, 10278, b'1', b'0', '', '', 25, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 22, 9, 1, 2, 6, '', '9999-12-31 23:59:59'),
(363, 13464, b'1', b'0', '', '', 35, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 23, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(364, 0, b'1', b'0', '', '', 38, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 24, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(365, 0, b'1', b'0', '', '', 38, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 25, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(366, 0, b'1', b'0', '', '', 38, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 26, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(367, 11891, b'1', b'0', '', '', 3, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 27, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(368, 12272, b'1', b'1', '', '', 1, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 28, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(369, 13835, b'1', b'0', '', '', 5, '2019-04-15 14:01:40', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 29, 2, 1, 2, 1, 'MGT 5599', '9999-12-31 23:59:59'),
(370, 11522, b'1', b'0', '', '', 24, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 30, 9, 1, 2, 6, '', '9999-12-31 23:59:59'),
(371, 12068, b'1', b'0', '', '', 25, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 15:45:00', 30, 7, 1, 2, 6, '', '9999-12-31 23:59:59'),
(372, 13836, b'1', b'0', '', '', 18, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 16:15:00', 31, 10, 1, 2, 4, '', '9999-12-31 23:59:59'),
(373, 13548, b'1', b'0', '', '', 10, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 16:15:00', 32, 11, 1, 2, 6, '', '9999-12-31 23:59:59'),
(374, 12189, b'1', b'0', '', '', 206, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 11:50:00', 33, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(375, 12248, b'1', b'0', '', '', 50, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 33, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(376, 14362, b'1', b'0', '', '', 40, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 14:20:00', 34, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(377, 14356, b'1', b'0', '', '', 33, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 34, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(378, 14363, b'1', b'0', '', '', 40, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '1', '2019-04-15 14:30:00', '2019-04-15 15:20:00', 35, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(379, 12358, b'1', b'0', '', '', 36, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 35, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(380, 10602, b'1', b'0', '', '', 70, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 08:50:00', 36, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(381, 10604, b'1', b'0', '', '', 27, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '2', '2019-04-15 08:00:00', '2019-04-15 08:50:00', 36, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(382, 10605, b'1', b'0', '', '', 25, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '3', '2019-04-15 16:30:00', '2019-04-15 17:45:00', 36, 2, 9, 2, 1, '', '9999-12-31 23:59:59'),
(383, 0, b'1', b'0', '', '', 0, '2019-04-15 14:01:41', '9999-12-31 23:59:59', '4', '2019-04-15 16:30:00', '2019-04-15 17:45:00', 36, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(384, 0, b'1', b'0', '', '', 50, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 37, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(385, 0, b'1', b'0', '', '', 25, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '2', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 37, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(386, 0, b'1', b'0', '', '', 50, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 38, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(387, 0, b'1', b'0', '', '', 25, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '2', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 38, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(388, 0, b'1', b'0', '', '', 30, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 39, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(389, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '2', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 39, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(390, 0, b'1', b'0', '', '', 30, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 40, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(391, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '2', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 40, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(392, 0, b'1', b'0', '', '', 30, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 41, 12, 9, 2, 1, 'INFO 3307', '9999-12-31 23:59:59'),
(393, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 41, 12, 9, 2, 1, 'INFO 3307', '9999-12-31 23:59:59'),
(394, 13483, b'1', b'1', '', '', 20, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 42, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(395, 0, b'1', b'0', '', '', 30, '2019-04-15 14:01:42', '9999-12-31 23:59:59', '1', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 43, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(396, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '2', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 43, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(397, 0, b'1', b'0', '', '', 30, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '1', '2019-04-15 16:00:00', '2019-04-15 17:15:00', 44, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(398, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '2', '2019-04-15 16:00:00', '2019-04-15 17:15:00', 44, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(399, 0, b'1', b'0', '', '', 30, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 45, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(400, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '2', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 45, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(401, 13339, b'1', b'0', '', '', 30, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:40:00', 46, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(402, 13340, b'1', b'0', '', '', 10, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '2', '2019-04-15 11:00:00', '2019-04-15 12:40:00', 46, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(403, 0, b'1', b'0', '', '', 30, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 47, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(404, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '2', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 47, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(405, 11916, b'1', b'0', '', '', 30, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 48, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(406, 12313, b'1', b'0', '', '', 10, '2019-04-15 14:01:43', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 48, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(407, 12157, b'1', b'0', '', '', 25, '2019-04-15 14:01:44', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 08:50:00', 49, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(408, 14274, b'1', b'1', '', '', 25, '2019-04-15 14:01:44', '9999-12-31 23:59:59', '1', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 50, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(409, 14275, b'1', b'1', '', '', 10, '2019-04-15 14:01:44', '9999-12-31 23:59:59', '2', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 50, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(410, 0, b'1', b'0', '', '', 8, '2019-04-15 14:01:44', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:50:00', 51, 2, 9, 2, 1, '', '9999-12-31 23:59:59'),
(411, 0, b'1', b'0', '', '', 8, '2019-04-15 14:01:44', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:50:00', 51, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(412, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:44', '9999-12-31 23:59:59', '1', '2019-04-15 16:00:00', '2019-04-15 17:15:00', 52, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(413, 0, b'1', b'0', '', '', 5, '2019-04-15 14:01:44', '9999-12-31 23:59:59', '2', '2019-04-15 16:00:00', '2019-04-15 17:15:00', 52, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(414, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:44', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 53, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(415, 0, b'1', b'0', '', '', 5, '2019-04-15 14:01:44', '9999-12-31 23:59:59', '2', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 53, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(416, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:44', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 54, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(417, 0, b'1', b'0', '', '', 5, '2019-04-15 14:01:45', '9999-12-31 23:59:59', '2', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 54, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(418, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:45', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 55, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(419, 0, b'1', b'0', '', '', 5, '2019-04-15 14:01:45', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 55, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(420, 14481, b'1', b'1', '', '', 2, '2019-04-15 14:01:45', '9999-12-31 23:59:59', '1', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 56, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(421, 14482, b'1', b'1', '', '', 2, '2019-04-15 14:01:45', '9999-12-31 23:59:59', '2', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 56, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(422, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:45', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 56, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(423, 0, b'1', b'0', '', '', 5, '2019-04-15 14:01:45', '9999-12-31 23:59:59', '2', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 56, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(424, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:45', '9999-12-31 23:59:59', '3', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 56, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(425, 0, b'1', b'0', '', '', 5, '2019-04-15 14:01:45', '9999-12-31 23:59:59', '4', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 56, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(426, 13133, b'1', b'0', '', '', 50, '2019-04-15 14:01:46', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 57, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(427, 10570, b'1', b'0', '', '', 73, '2019-04-15 14:01:46', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 58, 14, 1, 2, 1, '', '9999-12-31 23:59:59'),
(428, 10571, b'1', b'0', '', '', 73, '2019-04-15 14:01:46', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 58, 14, 1, 2, 1, '', '9999-12-31 23:59:59'),
(429, 11453, b'1', b'0', '', '', 60, '2019-04-15 14:01:46', '9999-12-31 23:59:59', '3', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 58, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(430, 11533, b'1', b'0', '', '', 35, '2019-04-15 14:01:46', '9999-12-31 23:59:59', '4', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 58, 15, 1, 2, 1, '', '9999-12-31 23:59:59'),
(431, 10572, b'1', b'0', '', '', 60, '2019-04-15 14:01:46', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 59, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(432, 10573, b'1', b'0', '', '', 73, '2019-04-15 14:01:46', '9999-12-31 23:59:59', '2', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 59, 16, 1, 2, 1, '', '9999-12-31 23:59:59'),
(433, 12912, b'1', b'0', '', '', 73, '2019-04-15 14:01:46', '9999-12-31 23:59:59', '3', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 59, 16, 1, 2, 1, '', '9999-12-31 23:59:59'),
(434, 13060, b'1', b'0', 'This section is reserved for Honors Program students only.', '', 0, '2019-04-15 14:01:46', '9999-12-31 23:59:59', '0', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 59, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(435, 10574, b'1', b'0', '', '', 35, '2019-04-15 14:01:46', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 60, 17, 1, 2, 1, '', '9999-12-31 23:59:59'),
(436, 12155, b'1', b'0', '', '', 0, '2019-04-15 14:01:47', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 61, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(437, 0, b'1', b'0', '', '', 35, '2019-04-15 14:01:47', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 62, 18, 1, 2, 1, '', '9999-12-31 23:59:59'),
(438, 0, b'1', b'0', '', '', 25, '2019-04-15 14:01:47', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 63, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(439, 10575, b'1', b'0', '', '', 35, '2019-04-15 14:01:47', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 64, 18, 1, 2, 1, '', '9999-12-31 23:59:59'),
(440, 14536, b'1', b'1', '', '', 1, '2019-04-15 14:01:47', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 65, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(441, 13837, b'1', b'0', '', '', 0, '2019-04-15 14:01:47', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 66, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(442, 12156, b'1', b'0', '', '', 0, '2019-04-15 14:01:47', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 67, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(443, 0, b'1', b'0', '', '', 20, '2019-04-15 14:01:47', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 68, 18, 1, 2, 1, '', '9999-12-31 23:59:59'),
(444, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:48', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 69, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(445, 12154, b'1', b'0', '', '', 20, '2019-04-15 14:01:48', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 70, 18, 1, 2, 1, '', '9999-12-31 23:59:59'),
(446, 13838, b'1', b'0', '', '', 0, '2019-04-15 14:01:48', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 71, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(447, 10340, b'1', b'0', '', '', 70, '2019-04-15 14:01:48', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 72, 19, 1, 2, 1, '', '9999-12-31 23:59:59'),
(448, 12359, b'1', b'0', '', '', 40, '2019-04-15 14:01:48', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 72, 12, 1, 2, 1, '', '9999-12-31 23:59:59'),
(449, 10341, b'1', b'0', '', '', 80, '2019-04-15 14:01:48', '9999-12-31 23:59:59', '3', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 72, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(450, 13839, b'1', b'0', '', '', 0, '2019-04-15 14:01:48', '9999-12-31 23:59:59', '4', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 72, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(451, 13061, b'1', b'0', '', '', 30, '2019-04-15 14:01:48', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 73, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(452, 12260, b'1', b'0', '', '', 39, '2019-04-15 14:01:48', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 74, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(453, 10342, b'1', b'0', '', '', 39, '2019-04-15 14:01:49', '9999-12-31 23:59:59', '2', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 74, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(454, 10343, b'1', b'0', '', '', 39, '2019-04-15 14:01:49', '9999-12-31 23:59:59', '3', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 74, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(455, 10348, b'1', b'1', '', '', 5, '2019-04-15 14:01:49', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 75, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(456, 10349, b'1', b'0', '', '', 39, '2019-04-15 14:01:49', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 76, 5, 1, 2, 1, '', '9999-12-31 23:59:59'),
(457, 13062, b'1', b'0', '', '', 25, '2019-04-15 14:01:49', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 76, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(458, 12071, b'1', b'0', '', '', 30, '2019-04-15 14:01:49', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 77, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(459, 0, b'1', b'0', '', '', 35, '2019-04-15 14:01:49', '9999-12-31 23:59:59', '0', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 78, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(460, 10350, b'1', b'0', '', '', 25, '2019-04-15 14:01:50', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 79, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(461, 13063, b'1', b'0', '', '', 30, '2019-04-15 14:01:50', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 80, 13, 8, 2, 1, '', '9999-12-31 23:59:59'),
(462, 12360, b'1', b'0', '', '', 35, '2019-04-15 14:01:50', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 81, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(463, 12361, b'1', b'0', '', '', 35, '2019-04-15 14:01:50', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 81, 13, 8, 2, 1, '', '9999-12-31 23:59:59'),
(464, 10351, b'1', b'1', '', '', 5, '2019-04-15 14:01:50', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 82, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(465, 12081, b'1', b'0', '', '', 10, '2019-04-15 14:01:50', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 83, 5, 1, 2, 1, '', '9999-12-31 23:59:59'),
(466, 13064, b'1', b'0', '', '', 6, '2019-04-15 14:01:50', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 83, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(467, 12082, b'1', b'0', '', '', 10, '2019-04-15 14:01:50', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 84, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(468, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:51', '9999-12-31 23:59:59', '0', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 85, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(469, 11448, b'1', b'0', '', '', 4, '2019-04-15 14:01:51', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 86, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(470, 13065, b'1', b'0', '', '', 10, '2019-04-15 14:01:51', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 87, 13, 8, 2, 1, '', '9999-12-31 23:59:59'),
(471, 12362, b'1', b'0', '', '', 10, '2019-04-15 14:01:51', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 88, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(472, 12363, b'1', b'0', '', '', 10, '2019-04-15 14:01:51', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 88, 13, 8, 2, 1, '', '9999-12-31 23:59:59'),
(473, 13159, b'1', b'0', '', '', 65, '2019-04-15 14:01:51', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 89, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(474, 10683, b'1', b'0', '', '', 35, '2019-04-15 14:01:51', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 90, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(475, 13841, b'1', b'0', '', '', 35, '2019-04-15 14:01:52', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 90, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(476, 12918, b'1', b'0', '', '', 35, '2019-04-15 14:01:52', '9999-12-31 23:59:59', '3', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 90, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(477, 12905, b'1', b'0', '', '', 10, '2019-04-15 14:01:52', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 91, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(478, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:52', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 91, -1, 8, 2, 1, '', '9999-12-31 23:59:59'),
(479, 10684, b'1', b'0', '', '', 45, '2019-04-15 14:01:52', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 92, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(480, 12919, b'1', b'0', '', '', 35, '2019-04-15 14:01:52', '9999-12-31 23:59:59', '2', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 92, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(481, 13480, b'1', b'0', '', '', 25, '2019-04-15 14:01:52', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 93, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(482, 14272, b'1', b'0', '', '', 10, '2019-04-15 14:01:53', '9999-12-31 23:59:59', '2', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 93, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(483, 14422, b'1', b'0', '', '', 10, '2019-04-15 14:01:53', '9999-12-31 23:59:59', '3', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 93, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(484, 14323, b'1', b'0', '', '', 10, '2019-04-15 14:01:53', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 94, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(485, 14324, b'1', b'0', '', '', 5, '2019-04-15 14:01:53', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 94, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(486, 14325, b'1', b'0', '', '', 5, '2019-04-15 14:01:53', '9999-12-31 23:59:59', '3', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 94, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(487, 0, b'1', b'0', '', '', 15, '2019-04-15 14:01:53', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 95, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(488, 0, b'1', b'0', '', '', 40, '2019-04-15 14:01:54', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 96, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(489, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:54', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 97, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(490, 0, b'1', b'0', '', '', 5, '2019-04-15 14:01:54', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 97, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(491, 0, b'1', b'0', '', '', 5, '2019-04-15 14:01:54', '9999-12-31 23:59:59', '3', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 97, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(492, 14347, b'1', b'0', '', '', 10, '2019-04-15 14:01:54', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 98, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(493, 11930, b'1', b'0', '', '', 60, '2019-04-15 14:01:54', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 99, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(494, 12920, b'1', b'0', '', '', 25, '2019-04-15 14:01:55', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 99, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(495, 12252, b'1', b'1', '', '', 5, '2019-04-15 14:01:55', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 100, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(496, 11932, b'1', b'1', '', '', 10, '2019-04-15 14:01:55', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 101, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(497, 14326, b'1', b'0', '', '', 10, '2019-04-15 14:01:55', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 102, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(498, 14327, b'1', b'0', '', '', 5, '2019-04-15 14:01:55', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 102, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(499, 14328, b'1', b'0', '', '', 5, '2019-04-15 14:01:55', '9999-12-31 23:59:59', '3', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 102, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(500, 0, b'1', b'0', '', '', 10, '2019-04-15 14:01:56', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 103, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(501, 0, b'1', b'0', '', '', 15, '2019-04-15 14:01:56', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 104, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(502, 14346, b'1', b'0', '', '', 10, '2019-04-15 14:01:56', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 105, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(503, 14346, b'1', b'0', '', '', 5, '2019-04-15 14:01:56', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 105, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(504, 14346, b'1', b'0', '', '', 5, '2019-04-15 14:01:56', '9999-12-31 23:59:59', '3', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 105, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(505, 14348, b'1', b'0', '', '', 10, '2019-04-15 14:01:56', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 106, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(506, 11931, b'1', b'0', '', '', 20, '2019-04-15 14:01:57', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 107, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(507, 13843, b'1', b'0', '', '', 15, '2019-04-15 14:01:57', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 107, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(508, 11933, b'1', b'1', '', '', 10, '2019-04-15 14:01:57', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 108, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(509, 0, b'1', b'0', '', '', 15, '2019-04-15 14:01:57', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 109, -1, 8, 2, 1, '', '9999-12-31 23:59:59'),
(510, 0, b'1', b'1', '', '', 15, '2019-04-15 14:01:57', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 110, -1, 8, 2, 1, '', '9999-12-31 23:59:59'),
(511, 12365, b'1', b'0', '', '', 77, '2019-04-15 14:01:57', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 111, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(512, 12366, b'1', b'0', '', '', 82, '2019-04-15 14:01:58', '9999-12-31 23:59:59', '3', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 111, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(513, 12367, b'1', b'0', '', '', 75, '2019-04-15 14:01:58', '9999-12-31 23:59:59', '4', '2019-04-15 18:00:00', '2019-04-15 20:50:00', 111, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(514, 13066, b'1', b'0', '', '', 40, '2019-04-15 14:01:58', '9999-12-31 23:59:59', '5', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 111, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(515, 13067, b'1', b'0', '', '', 36, '2019-04-15 14:01:58', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 112, 5, 9, 2, 1, '', '9999-12-31 23:59:59'),
(516, 13846, b'1', b'0', '', '', 18, '2019-04-15 14:01:58', '9999-12-31 23:59:59', '2', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 112, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(517, 12742, b'1', b'0', '', '', 12, '2019-04-15 14:01:58', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 08:50:00', 113, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(518, 12743, b'1', b'0', '', '', 3, '2019-04-15 14:01:59', '9999-12-31 23:59:59', '2', '2019-04-15 08:00:00', '2019-04-15 08:50:00', 113, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(519, 12368, b'1', b'0', '', '', 10, '2019-04-15 14:01:59', '9999-12-31 23:59:59', '3', '2019-04-15 16:30:00', '2019-04-15 17:45:00', 113, 2, 9, 2, 1, '', '9999-12-31 23:59:59'),
(520, 0, b'1', b'0', '', '', 0, '2019-04-15 14:01:59', '9999-12-31 23:59:59', '4', '2019-04-15 16:30:00', '2019-04-15 17:45:00', 113, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(521, 12597, b'1', b'0', '', '', 20, '2019-04-15 14:01:59', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 114, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(522, 12598, b'1', b'0', '', '', 20, '2019-04-15 14:01:59', '9999-12-31 23:59:59', '2', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 114, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(523, 13850, b'1', b'0', '', '', 40, '2019-04-15 14:02:00', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 115, 2, 9, 2, 1, '', '9999-12-31 23:59:59'),
(524, 13851, b'1', b'0', '', '', 20, '2019-04-15 14:02:00', '9999-12-31 23:59:59', '2', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 115, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(525, 12369, b'1', b'0', '', '', 40, '2019-04-15 14:02:00', '9999-12-31 23:59:59', '2', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 116, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(526, 13955, b'1', b'0', '', '', 70, '2019-04-15 14:02:00', '9999-12-31 23:59:59', '3', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 116, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(527, 13549, b'1', b'0', '', '', 6, '2019-04-15 14:02:00', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 117, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(528, 13956, b'1', b'0', '', '', 10, '2019-04-15 14:02:01', '9999-12-31 23:59:59', '3', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 117, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(529, 12370, b'1', b'0', '', '', 30, '2019-04-15 14:02:01', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 118, 12, 9, 2, 1, '', '9999-12-31 23:59:59'),
(530, 12371, b'1', b'0', '', '', 10, '2019-04-15 14:02:01', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 118, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(531, 13553, b'1', b'0', '', '', 25, '2019-04-15 14:02:01', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 119, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(532, 0, b'1', b'0', '', '', 10, '2019-04-15 14:02:01', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 119, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(533, 0, b'1', b'0', '', '', 35, '2019-04-15 14:02:01', '9999-12-31 23:59:59', '3', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 119, -1, 8, 2, 1, '', '9999-12-31 23:59:59'),
(534, 12372, b'1', b'0', '', '', 24, '2019-04-15 14:02:02', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 120, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(535, 12744, b'1', b'0', '', '', 20, '2019-04-15 14:02:02', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 120, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(536, 12373, b'1', b'1', '', '', 5, '2019-04-15 14:02:02', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 121, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(537, 12374, b'1', b'0', '', '', 40, '2019-04-15 14:02:02', '9999-12-31 23:59:59', '1', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 122, 2, 9, 2, 1, '', '9999-12-31 23:59:59'),
(538, 13279, b'1', b'0', '', '', 17, '2019-04-15 14:02:02', '9999-12-31 23:59:59', '2', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 122, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(539, 13855, b'1', b'0', '', '', 30, '2019-04-15 14:02:03', '9999-12-31 23:59:59', '3', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 122, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(540, 13856, b'1', b'0', '', '', 10, '2019-04-15 14:02:03', '9999-12-31 23:59:59', '4', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 122, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(541, 12375, b'1', b'0', '', '', 30, '2019-04-15 14:02:03', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 123, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(542, 12376, b'1', b'0', '', '', 8, '2019-04-15 14:02:03', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 124, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(543, 13550, b'1', b'0', '', '', 10, '2019-04-15 14:02:03', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 125, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(544, 0, b'1', b'0', '', '', 10, '2019-04-15 14:02:04', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 125, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(545, 13069, b'1', b'0', '', '', 30, '2019-04-15 14:02:04', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 126, 2, 9, 2, 1, '', '9999-12-31 23:59:59'),
(546, 13859, b'1', b'0', '', '', 8, '2019-04-15 14:02:04', '9999-12-31 23:59:59', '2', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 126, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(547, 12745, b'1', b'0', '', '', 20, '2019-04-15 14:02:04', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 127, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(548, 0, b'1', b'0', '', '', 25, '2019-04-15 14:02:04', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 08:50:00', 128, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(549, 12377, b'1', b'0', '', '', 30, '2019-04-15 14:02:05', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 129, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(550, 12378, b'1', b'1', '', '', 1, '2019-04-15 14:02:05', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 130, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(551, 12379, b'1', b'1', '', '', 8, '2019-04-15 14:02:05', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 131, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(552, 13862, b'1', b'0', '', '', 3, '2019-04-15 14:02:05', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 132, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(553, 14478, b'1', b'0', '', '', 15, '2019-04-15 14:02:05', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 132, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(554, 13281, b'1', b'0', '', '', 5, '2019-04-15 14:02:06', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 133, 2, 9, 2, 1, '', '9999-12-31 23:59:59'),
(555, 13282, b'1', b'0', '', '', 5, '2019-04-15 14:02:06', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 133, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(556, 12380, b'1', b'0', '', '', 8, '2019-04-15 14:02:06', '9999-12-31 23:59:59', '1', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 134, 2, 9, 2, 1, '', '9999-12-31 23:59:59'),
(557, 13283, b'1', b'0', '', '', 5, '2019-04-15 14:02:06', '9999-12-31 23:59:59', '2', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 134, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(558, 13863, b'1', b'0', '', '', 18, '2019-04-15 14:02:06', '9999-12-31 23:59:59', '3', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 134, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(559, 13864, b'1', b'0', '', '', 10, '2019-04-15 14:02:07', '9999-12-31 23:59:59', '4', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 134, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(560, 13865, b'1', b'0', '', '', 10, '2019-04-15 14:02:07', '9999-12-31 23:59:59', '5', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 134, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(561, 12381, b'1', b'0', '', '', 15, '2019-04-15 14:02:07', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 135, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(562, 12382, b'1', b'0', '', '', 7, '2019-04-15 14:02:07', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 136, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(563, 12383, b'1', b'0', '', '', 7, '2019-04-15 14:02:07', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 137, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(564, 12384, b'1', b'0', '', '', 7, '2019-04-15 14:02:08', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 138, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(565, 12385, b'1', b'0', '', '', 20, '2019-04-15 14:02:08', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 139, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(566, 13551, b'1', b'0', '', '', 12, '2019-04-15 14:02:08', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 140, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(567, 13868, b'1', b'0', '', '', 10, '2019-04-15 14:02:08', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 140, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(568, 0, b'1', b'0', '', '', 20, '2019-04-15 14:02:09', '9999-12-31 23:59:59', '3', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 140, -1, 8, 2, 1, '', '9999-12-31 23:59:59'),
(569, 13552, b'1', b'0', '', '', 10, '2019-04-15 14:02:09', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 141, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(570, 13869, b'1', b'0', '', '', 10, '2019-04-15 14:02:09', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 141, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(571, 13070, b'1', b'0', '', '', 5, '2019-04-15 14:02:09', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 142, 2, 9, 2, 1, '', '9999-12-31 23:59:59'),
(572, 13872, b'1', b'0', '', '', 3, '2019-04-15 14:02:09', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 142, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(573, 12746, b'1', b'0', '', '', 20, '2019-04-15 14:02:10', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 143, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(574, 12386, b'1', b'1', '', '', 5, '2019-04-15 14:02:10', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 144, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(575, 13873, b'1', b'0', '', '', 2, '2019-04-15 14:02:10', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 145, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(576, 14479, b'1', b'0', '', '', 15, '2019-04-15 14:02:10', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 145, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(577, 13876, b'1', b'0', '', '', 10, '2019-04-15 14:02:11', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 146, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(578, 13877, b'1', b'0', '', '', 10, '2019-04-15 14:02:11', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 146, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(579, 0, b'1', b'1', '', '', 5, '2019-04-15 14:02:11', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 147, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(580, 14308, b'1', b'1', '', '', 5, '2019-04-15 14:02:11', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 148, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(581, 12187, b'1', b'0', '', '', 30, '2019-04-15 14:02:11', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 149, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(582, 12188, b'1', b'0', '', '', 30, '2019-04-15 14:02:12', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 150, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(583, 13374, b'1', b'0', '', '', 30, '2019-04-15 14:02:12', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 151, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(584, 13071, b'1', b'0', '', '', 30, '2019-04-15 14:02:12', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 151, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(585, 10399, b'1', b'0', '', '', 30, '2019-04-15 14:02:12', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 152, 21, 1, 2, 1, '', '9999-12-31 23:59:59'),
(586, 12427, b'1', b'0', '', '', 30, '2019-04-15 14:02:13', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 152, 22, 6, 2, 1, '', '9999-12-31 23:59:59'),
(587, 11449, b'1', b'0', '', '', 35, '2019-04-15 14:02:13', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 153, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(588, 10354, b'1', b'0', '', '', 30, '2019-04-15 14:02:13', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 154, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(589, 10356, b'1', b'0', '', '', 15, '2019-04-15 14:02:13', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 154, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(590, 0, b'1', b'1', '', '', 15, '2019-04-15 14:02:14', '9999-12-31 23:59:59', '3', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 154, -1, 6, 2, 1, '', '9999-12-31 23:59:59'),
(591, 10358, b'1', b'0', '', '', 10, '2019-04-15 14:02:14', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 155, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(592, 0, b'1', b'1', '', '', 10, '2019-04-15 14:02:14', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 155, -1, 6, 2, 1, '', '9999-12-31 23:59:59'),
(593, 13880, b'1', b'0', '', '', 15, '2019-04-15 14:02:14', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 156, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(594, 12544, b'1', b'0', '', '', 15, '2019-04-15 14:02:14', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 156, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(595, 13881, b'1', b'0', '', '', 15, '2019-04-15 14:02:15', '9999-12-31 23:59:59', '3', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 156, -1, 9, 2, 1, '', '9999-12-31 23:59:59'),
(596, 14578, b'1', b'1', '', '', 5, '2019-04-15 14:02:15', '9999-12-31 23:59:59', '4', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 156, -1, 6, 2, 1, '', '9999-12-31 23:59:59'),
(597, 14571, b'1', b'1', '', '', 10, '2019-04-15 14:02:15', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 157, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(598, 10361, b'1', b'1', '', '', 1, '2019-04-15 14:02:15', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 158, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(599, 14565, b'1', b'1', '', '', 3, '2019-04-15 14:02:16', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 159, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(600, 13284, b'1', b'0', '', '', 36, '2019-04-15 14:02:16', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 160, 16, 1, 2, 1, '', '9999-12-31 23:59:59'),
(601, 10368, b'1', b'0', '', '', 40, '2019-04-15 14:02:16', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 161, 12, 1, 2, 1, '', '9999-12-31 23:59:59'),
(602, 10370, b'1', b'0', '', '', 40, '2019-04-15 14:02:16', '9999-12-31 23:59:59', '2', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 161, 12, 1, 2, 1, '', '9999-12-31 23:59:59'),
(603, 10372, b'1', b'0', '', '', 40, '2019-04-15 14:02:17', '9999-12-31 23:59:59', '3', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 161, 12, 1, 2, 1, '', '9999-12-31 23:59:59'),
(604, 12257, b'1', b'0', '', '', 40, '2019-04-15 14:02:17', '9999-12-31 23:59:59', '4', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 161, 12, 1, 2, 1, '', '9999-12-31 23:59:59'),
(605, 10374, b'1', b'0', '', '', 40, '2019-04-15 14:02:17', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 162, 12, 1, 2, 1, '', '9999-12-31 23:59:59'),
(606, 12601, b'1', b'0', '', '', 42, '2019-04-15 14:02:17', '9999-12-31 23:59:59', '2', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 162, 8, 1, 2, 1, '', '9999-12-31 23:59:59'),
(607, 10376, b'1', b'0', '', '', 40, '2019-04-15 14:02:18', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 163, 10, 1, 2, 1, '', '9999-12-31 23:59:59'),
(608, 10377, b'1', b'0', '', '', 40, '2019-04-15 14:02:18', '9999-12-31 23:59:59', '2', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 163, 10, 1, 2, 1, '', '9999-12-31 23:59:59'),
(609, 10378, b'1', b'0', '', '', 47, '2019-04-15 14:02:18', '9999-12-31 23:59:59', '3', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 163, 10, 1, 2, 1, '', '9999-12-31 23:59:59'),
(610, 10379, b'1', b'0', '', '', 40, '2019-04-15 14:02:18', '9999-12-31 23:59:59', '1', '2019-04-15 16:00:00', '2019-04-15 18:45:00', 164, 1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(611, 13134, b'1', b'0', '', '', 40, '2019-04-15 14:02:19', '9999-12-31 23:59:59', '2', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 164, 12, 1, 2, 1, '', '9999-12-31 23:59:59');
INSERT INTO `sections` (`SectionID`, `CRN`, `RequiresMoodle`, `RequiresPermission`, `Notes`, `DepartmentComments`, `StudentLimit`, `DateCreated`, `DateArchived`, `Number`, `StartTime`, `EndTime`, `CourseID`, `RoomID`, `ScheduleTypeID`, `AcademicSemesterID`, `PartOfTermID`, `XListID`, `DateDeleted`) VALUES
(612, 10380, b'1', b'0', '', '', 40, '2019-04-15 14:02:19', '9999-12-31 23:59:59', '3', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 164, 1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(613, 11867, b'1', b'0', '', '', 40, '2019-04-15 14:02:19', '9999-12-31 23:59:59', '4', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 164, 2, 1, 2, 1, '', '9999-12-31 23:59:59'),
(614, 10381, b'1', b'0', '', '', 40, '2019-04-15 14:02:19', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 165, 8, 1, 2, 1, '', '9999-12-31 23:59:59'),
(615, 10382, b'1', b'0', '', '', 40, '2019-04-15 14:02:31', '9999-12-31 23:59:59', '2', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 165, 8, 1, 2, 1, '', '9999-12-31 23:59:59'),
(616, 10384, b'1', b'0', '', '', 35, '2019-04-15 14:02:31', '9999-12-31 23:59:59', '1', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 166, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(617, 10392, b'1', b'0', '', '', 15, '2019-04-15 14:02:31', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 167, 11, 1, 2, 1, '', '9999-12-31 23:59:59'),
(618, 13892, b'1', b'0', '', '', 15, '2019-04-15 14:02:31', '9999-12-31 23:59:59', '2', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 167, 11, 1, 2, 1, '', '9999-12-31 23:59:59'),
(619, 10399, b'1', b'0', '', '', 25, '2019-04-15 14:02:32', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 168, 1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(620, 13072, b'1', b'0', '', '', 35, '2019-04-15 14:02:32', '9999-12-31 23:59:59', '2', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 168, 1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(621, 10401, b'1', b'0', '', '', 30, '2019-04-15 14:02:32', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 169, 18, 1, 2, 1, '', '9999-12-31 23:59:59'),
(622, 10403, b'1', b'0', '', '', 30, '2019-04-15 14:02:32', '9999-12-31 23:59:59', '2', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 169, 18, 1, 2, 1, '', '9999-12-31 23:59:59'),
(623, 10407, b'1', b'0', '', '', 31, '2019-04-15 14:02:33', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 170, 23, 1, 2, 1, '', '9999-12-31 23:59:59'),
(624, 13894, b'1', b'0', '', '', 30, '2019-04-15 14:02:33', '9999-12-31 23:59:59', '2', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 170, 23, 1, 2, 1, '', '9999-12-31 23:59:59'),
(625, 10417, b'1', b'0', '', '', 37, '2019-04-15 14:02:33', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 171, 12, 1, 2, 1, '', '9999-12-31 23:59:59'),
(626, 10418, b'1', b'0', '', '', 35, '2019-04-15 14:02:33', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 172, 8, 1, 2, 1, '', '9999-12-31 23:59:59'),
(627, 14555, b'1', b'1', '', '', 1, '2019-04-15 14:02:34', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 173, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(628, 12747, b'1', b'0', '', '', 10, '2019-04-15 14:02:34', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 174, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(629, 12748, b'1', b'0', 'This section is reserved for Honors Program students only.', '', 10, '2019-04-15 14:02:34', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 174, 2, 1, 2, 1, 'ACCT 4499', '9999-12-31 23:59:59'),
(630, 0, b'1', b'1', '', '', 5, '2019-04-15 14:02:35', '9999-12-31 23:59:59', '1', '2019-04-15 09:00:00', '2019-04-15 12:00:00', 174, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(631, 0, b'1', b'1', '', '', 5, '2019-04-15 14:02:35', '9999-12-31 23:59:59', '0', '2019-04-15 09:00:00', '2019-04-15 12:00:00', 174, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(632, 13073, b'1', b'0', '', '', 3, '2019-04-15 14:02:35', '9999-12-31 23:59:59', '2', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 175, 1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(633, 10419, b'1', b'0', '', '', 3, '2019-04-15 14:02:35', '9999-12-31 23:59:59', '1', '2019-04-15 08:00:00', '2019-04-15 09:15:00', 176, 23, 1, 2, 1, '', '9999-12-31 23:59:59'),
(634, 10420, b'1', b'0', '', '', 3, '2019-04-15 14:02:36', '9999-12-31 23:59:59', '1', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 177, 12, 1, 2, 1, '', '9999-12-31 23:59:59'),
(635, 10421, b'1', b'0', '', '', 5, '2019-04-15 14:02:36', '9999-12-31 23:59:59', '1', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 178, 8, 1, 2, 1, '', '9999-12-31 23:59:59'),
(636, 13510, b'1', b'1', '', '', 3, '2019-04-15 14:02:36', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 179, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(637, 14611, b'1', b'1', '', '', 1, '2019-04-15 14:02:36', '9999-12-31 23:59:59', '2', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 179, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(638, 12749, b'1', b'0', '', '', 2, '2019-04-15 14:02:37', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 180, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(639, 13896, b'1', b'0', '', '', 5, '2019-04-15 14:02:37', '9999-12-31 23:59:59', '2', '2019-04-15 18:00:00', '2019-04-15 20:45:00', 180, 2, 1, 2, 1, 'ACCT 5599', '9999-12-31 23:59:59'),
(640, 0, b'1', b'1', '', '', 5, '2019-04-15 14:02:37', '9999-12-31 23:59:59', '1', '2019-04-15 09:00:00', '2019-04-15 12:00:00', 180, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(641, 12190, b'1', b'0', '', '', 40, '2019-04-15 14:02:37', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 181, 18, 1, 2, 1, '', '9999-12-31 23:59:59'),
(642, 12191, b'1', b'0', '', '', 40, '2019-04-15 14:02:38', '9999-12-31 23:59:59', '2', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 181, 6, 1, 2, 1, '', '9999-12-31 23:59:59'),
(643, 12750, b'1', b'0', '', '', 40, '2019-04-15 14:02:38', '9999-12-31 23:59:59', '3', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 181, 6, 1, 2, 1, '', '9999-12-31 23:59:59'),
(644, 12387, b'1', b'0', '', '', 40, '2019-04-15 14:02:38', '9999-12-31 23:59:59', '4', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 181, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(645, 13152, b'1', b'0', '', '', 40, '2019-04-15 14:02:39', '9999-12-31 23:59:59', '5', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 181, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(646, 10422, b'1', b'1', '', '', 5, '2019-04-15 14:02:39', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 182, -1, 4, 2, 1, '', '9999-12-31 23:59:59'),
(647, 12541, b'1', b'0', '', '', 13, '2019-04-15 14:02:39', '9999-12-31 23:59:59', '1', '2019-04-15 14:30:00', '2019-04-15 15:45:00', 183, 20, 1, 2, 1, '', '9999-12-31 23:59:59'),
(648, 12073, b'1', b'0', '', '', 15, '2019-04-15 14:02:39', '9999-12-31 23:59:59', '1', '2019-04-15 09:30:00', '2019-04-15 10:45:00', 184, 11, 1, 2, 1, '', '9999-12-31 23:59:59'),
(649, 13897, b'1', b'0', '', '', 15, '2019-04-15 14:02:40', '9999-12-31 23:59:59', '2', '2019-04-15 11:00:00', '2019-04-15 12:15:00', 184, 11, 1, 2, 1, '', '9999-12-31 23:59:59'),
(650, 11696, b'1', b'0', '', '', 30, '2019-04-15 14:02:40', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 185, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(651, 12388, b'1', b'0', '', '', 30, '2019-04-15 14:02:40', '9999-12-31 23:59:59', '1', '2019-04-15 16:00:00', '2019-04-15 18:45:00', 186, 6, 1, 2, 1, '', '9999-12-31 23:59:59'),
(652, 12389, b'1', b'0', '', '', 30, '2019-04-15 14:02:41', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 187, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(653, 13451, b'1', b'0', '', '', 30, '2019-04-15 14:02:41', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 188, 6, 1, 2, 1, '', '9999-12-31 23:59:59'),
(654, 10423, b'1', b'0', '', '', 30, '2019-04-15 14:02:41', '9999-12-31 23:59:59', '1', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 189, 6, 1, 2, 1, '', '9999-12-31 23:59:59'),
(655, 13898, b'1', b'0', '', '', 7, '2019-04-15 14:02:41', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 190, -1, 5, 2, 1, '', '9999-12-31 23:59:59'),
(656, 11696, b'1', b'0', '', '', 4, '2019-04-15 14:02:42', '9999-12-31 23:59:59', '1', '2019-04-15 13:00:00', '2019-04-15 14:15:00', 191, -1, 1, 2, 1, '', '9999-12-31 23:59:59'),
(657, 12390, b'1', b'0', '', '', 5, '2019-04-15 14:02:42', '9999-12-31 23:59:59', '1', '2019-04-15 16:00:00', '2019-04-15 18:45:00', 192, 6, 1, 2, 1, '', '9999-12-31 23:59:59'),
(658, 12391, b'1', b'0', '', '', 5, '2019-04-15 14:02:42', '9999-12-31 23:59:59', '1', '0001-01-01 00:00:00', '0001-01-01 00:00:00', 193, 13, 5, 2, 1, '', '9999-12-31 23:59:59'),
(659, 13452, b'1', b'0', '', '', 5, '2019-04-15 14:02:43', '9999-12-31 23:59:59', '1', '2019-04-15 13:30:00', '2019-04-15 14:45:00', 194, 6, 1, 2, 1, '', '9999-12-31 23:59:59'),
(660, 13899, b'1', b'0', '', '', 3, '2019-04-15 14:02:43', '9999-12-31 23:59:59', '1', '2019-04-15 15:00:00', '2019-04-15 16:15:00', 195, 6, 1, 2, 1, '', '9999-12-31 23:59:59');

-- --------------------------------------------------------

--
-- Table structure for table `semesters`
--

CREATE TABLE `semesters` (
  `SemesterID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Abbreviation` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `semesters`
--

INSERT INTO `semesters` (`SemesterID`, `Name`, `Abbreviation`) VALUES
(1, 'Spring', 'AS'),
(2, 'Summer', 'ASU'),
(3, 'Fall', 'AF');

-- --------------------------------------------------------

--
-- Table structure for table `spreadsheetvariables`
--

CREATE TABLE `spreadsheetvariables` (
  `SpreadsheetVariableID` int(11) NOT NULL,
  `Spreadsheet` blob NOT NULL,
  `StartingRowNumber` int(11) NOT NULL,
  `DefaultFontSize` int(11) NOT NULL,
  `AddChangeDelete` varchar(255) NOT NULL,
  `AcademicSemester` varchar(255) NOT NULL,
  `SubjectName` varchar(255) NOT NULL,
  `SectionCRN` varchar(255) NOT NULL,
  `CourseNumber` varchar(255) NOT NULL,
  `SectionNumber` varchar(255) NOT NULL,
  `CrossListID` varchar(255) NOT NULL,
  `CourseTitle` varchar(255) NOT NULL,
  `Campus` varchar(255) NOT NULL,
  `ScheduleType` varchar(255) NOT NULL,
  `MoodleRequired` varchar(255) NOT NULL,
  `InstructorApprovalRequired` varchar(255) NOT NULL,
  `PartOfTerm` varchar(255) NOT NULL,
  `FixedCredit` varchar(255) NOT NULL,
  `MinimumCredits` varchar(255) NOT NULL,
  `MaximumCredits` varchar(255) NOT NULL,
  `ClassLimit` varchar(255) NOT NULL,
  `Monday` varchar(255) NOT NULL,
  `Tuesday` varchar(255) NOT NULL,
  `Wednesday` varchar(255) NOT NULL,
  `Thursday` varchar(255) NOT NULL,
  `Friday` varchar(255) NOT NULL,
  `Saturday` varchar(255) NOT NULL,
  `Sunday` varchar(255) NOT NULL,
  `StartTime` varchar(255) NOT NULL,
  `EndTime` varchar(255) NOT NULL,
  `Building` varchar(255) NOT NULL,
  `Room` varchar(255) NOT NULL,
  `PrimaryInstructorFirstName` varchar(255) NOT NULL,
  `PrimaryInstructorLastName` varchar(255) NOT NULL,
  `PrimaryInstructorNumber` varchar(255) NOT NULL,
  `PrimaryInstructorTeachingPercentRequired` varchar(255) NOT NULL,
  `SecondaryInstructorFirstName` varchar(255) NOT NULL,
  `SecondaryInstructorLastName` varchar(255) NOT NULL,
  `SecondaryInstructorNumber` varchar(255) NOT NULL,
  `SecondaryInstructorTeachingPercentRequired` varchar(255) NOT NULL,
  `ClassFeeDetailCode` varchar(255) NOT NULL,
  `ClassFeeAmount` varchar(255) NOT NULL,
  `SectionNotes` varchar(255) NOT NULL,
  `CrossListSubject` varchar(255) NOT NULL,
  `CrossListCourseNumber` varchar(255) NOT NULL,
  `DepartmentComments` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `RoleID` int(11) DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `usertodepartments`
--

CREATE TABLE `usertodepartments` (
  `UserToDepartmentID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `DepartmentID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academicsemesters`
--
ALTER TABLE `academicsemesters`
  ADD PRIMARY KEY (`AcademicSemesterID`),
  ADD KEY `SemesterID` (`SemesterID`);

--
-- Indexes for table `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`BuildingID`),
  ADD KEY `CampusID` (`CampusID`);

--
-- Indexes for table `campuses`
--
ALTER TABLE `campuses`
  ADD PRIMARY KEY (`CampusID`);

--
-- Indexes for table `changelogs`
--
ALTER TABLE `changelogs`
  ADD PRIMARY KEY (`ChangeLogID`),
  ADD KEY `SectionID` (`SectionID`);

--
-- Indexes for table `colleges`
--
ALTER TABLE `colleges`
  ADD PRIMARY KEY (`CollegeID`);

--
-- Indexes for table `collegetousers`
--
ALTER TABLE `collegetousers`
  ADD PRIMARY KEY (`CollegeToUserID`),
  ADD KEY `CollegeID` (`CollegeID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`CourseID`),
  ADD KEY `DepartmentID` (`DepartmentID`);

--
-- Indexes for table `days`
--
ALTER TABLE `days`
  ADD PRIMARY KEY (`DayID`);

--
-- Indexes for table `departmentcolleges`
--
ALTER TABLE `departmentcolleges`
  ADD PRIMARY KEY (`DepartmentCollegeID`),
  ADD KEY `CollegeID` (`CollegeID`),
  ADD KEY `DepartmentID` (`DepartmentID`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`DepartmentID`);

--
-- Indexes for table `fees`
--
ALTER TABLE `fees`
  ADD PRIMARY KEY (`FeeID`);

--
-- Indexes for table `instructors`
--
ALTER TABLE `instructors`
  ADD PRIMARY KEY (`InstructorID`);

--
-- Indexes for table `instructortosections`
--
ALTER TABLE `instructortosections`
  ADD PRIMARY KEY (`InstructorToSectionID`),
  ADD KEY `InstructorID` (`InstructorID`),
  ADD KEY `SectionID` (`SectionID`);

--
-- Indexes for table `partofterm`
--
ALTER TABLE `partofterm`
  ADD PRIMARY KEY (`PartOfTermID`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`RoleID`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`RoomID`),
  ADD KEY `BuildingID` (`BuildingID`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`ScheduleID`),
  ADD KEY `CollegeID` (`CollegeID`);

--
-- Indexes for table `scheduletypes`
--
ALTER TABLE `scheduletypes`
  ADD PRIMARY KEY (`ScheduleTypeID`);

--
-- Indexes for table `sectiondays`
--
ALTER TABLE `sectiondays`
  ADD PRIMARY KEY (`SectionDayID`),
  ADD KEY `SectionID` (`SectionID`),
  ADD KEY `DayID` (`DayID`);

--
-- Indexes for table `sectionfees`
--
ALTER TABLE `sectionfees`
  ADD PRIMARY KEY (`SectionFeeID`),
  ADD KEY `SectionID` (`SectionID`),
  ADD KEY `FeeID` (`FeeID`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`SectionID`),
  ADD KEY `CourseID` (`CourseID`),
  ADD KEY `RoomID` (`RoomID`),
  ADD KEY `ScheduleTypeID` (`ScheduleTypeID`),
  ADD KEY `AcademicSemesterID` (`AcademicSemesterID`),
  ADD KEY `PartOfTermID` (`PartOfTermID`);

--
-- Indexes for table `semesters`
--
ALTER TABLE `semesters`
  ADD PRIMARY KEY (`SemesterID`);

--
-- Indexes for table `spreadsheetvariables`
--
ALTER TABLE `spreadsheetvariables`
  ADD PRIMARY KEY (`SpreadsheetVariableID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD KEY `RoleID` (`RoleID`);

--
-- Indexes for table `usertodepartments`
--
ALTER TABLE `usertodepartments`
  ADD PRIMARY KEY (`UserToDepartmentID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `DepartmentID` (`DepartmentID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academicsemesters`
--
ALTER TABLE `academicsemesters`
  MODIFY `AcademicSemesterID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `buildings`
--
ALTER TABLE `buildings`
  MODIFY `BuildingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `campuses`
--
ALTER TABLE `campuses`
  MODIFY `CampusID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `changelogs`
--
ALTER TABLE `changelogs`
  MODIFY `ChangeLogID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=661;

--
-- AUTO_INCREMENT for table `colleges`
--
ALTER TABLE `colleges`
  MODIFY `CollegeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `collegetousers`
--
ALTER TABLE `collegetousers`
  MODIFY `CollegeToUserID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `CourseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=196;

--
-- AUTO_INCREMENT for table `days`
--
ALTER TABLE `days`
  MODIFY `DayID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `departmentcolleges`
--
ALTER TABLE `departmentcolleges`
  MODIFY `DepartmentCollegeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `DepartmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `fees`
--
ALTER TABLE `fees`
  MODIFY `FeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `instructors`
--
ALTER TABLE `instructors`
  MODIFY `InstructorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `instructortosections`
--
ALTER TABLE `instructortosections`
  MODIFY `InstructorToSectionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=557;

--
-- AUTO_INCREMENT for table `partofterm`
--
ALTER TABLE `partofterm`
  MODIFY `PartOfTermID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `RoleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `RoomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `ScheduleID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scheduletypes`
--
ALTER TABLE `scheduletypes`
  MODIFY `ScheduleTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sectiondays`
--
ALTER TABLE `sectiondays`
  MODIFY `SectionDayID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=821;

--
-- AUTO_INCREMENT for table `sectionfees`
--
ALTER TABLE `sectionfees`
  MODIFY `SectionFeeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `SectionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=661;

--
-- AUTO_INCREMENT for table `semesters`
--
ALTER TABLE `semesters`
  MODIFY `SemesterID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `spreadsheetvariables`
--
ALTER TABLE `spreadsheetvariables`
  MODIFY `SpreadsheetVariableID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `usertodepartments`
--
ALTER TABLE `usertodepartments`
  MODIFY `UserToDepartmentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `academicsemesters`
--
ALTER TABLE `academicsemesters`
  ADD CONSTRAINT `academicsemesters_ibfk_1` FOREIGN KEY (`SemesterID`) REFERENCES `semesters` (`SemesterID`);

--
-- Constraints for table `buildings`
--
ALTER TABLE `buildings`
  ADD CONSTRAINT `buildings_ibfk_1` FOREIGN KEY (`CampusID`) REFERENCES `campuses` (`CampusID`);

--
-- Constraints for table `changelogs`
--
ALTER TABLE `changelogs`
  ADD CONSTRAINT `changelogs_ibfk_1` FOREIGN KEY (`SectionID`) REFERENCES `sections` (`SectionID`);

--
-- Constraints for table `collegetousers`
--
ALTER TABLE `collegetousers`
  ADD CONSTRAINT `collegetousers_ibfk_1` FOREIGN KEY (`CollegeID`) REFERENCES `colleges` (`CollegeID`),
  ADD CONSTRAINT `collegetousers_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `departments` (`DepartmentID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
