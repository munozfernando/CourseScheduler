-- THIS IS NOT AS ACCURATE AS THE FULL GENERATION SCRIPT --

DELIMITER //
CREATE PROCEDURE checkForExistingSection (IN `i_academicsemesterID` INT, IN `i_courseID` INT, IN `i_sectionnumber` INT)  
BEGIN
	SELECT * FROM Sections
	WHERE AcademicSemesterID = i_academicsemesterID
	AND CourseID = i_courseID 
	AND Number = i_sectionnumber;
END //

CREATE PROCEDURE deleteAcademicSemester (IN `i_academicsemesterID` INT)  
BEGIN
  DELETE FROM AcademicSemesters 
  WHERE AcademicSemesterID = i_academicsemesterID;
END //

CREATE PROCEDURE deleteBuilding (IN `i_BuildingID` INT)  
BEGIN
  DELETE FROM Buildings 
  WHERE BuildingID = i_BuildingID;
END //

CREATE PROCEDURE deleteCampus (IN `i_CampusID` INT)  
BEGIN
  DELETE FROM Campuses 
  WHERE CampusID = i_CampusID;
END //

CREATE PROCEDURE deleteCourse (IN `i_CourseID` INT)  
BEGIN
  DELETE FROM Courses 
  WHERE CourseID = i_CourseID;
END //

CREATE PROCEDURE deleteDay (IN `i_DayID` INT)  
BEGIN
  DELETE FROM Days 
  WHERE DayID = i_DayID;
END //

CREATE PROCEDURE deleteDepartment (IN `i_DepartmentID` INT)  
BEGIN
  DELETE FROM Departments 
  WHERE DepartmentID = i_DepartmentID;
END //

CREATE PROCEDURE deleteFee (IN `i_FeeID` INT)  
BEGIN
  DELETE FROM Fees 
  WHERE FeeID = i_FeeID;
END //

CREATE PROCEDURE deleteInstructor (IN `i_InstructorID` INT)  
BEGIN
  DELETE FROM Instructors 
  WHERE InstructorID = i_InstructorID;
END //

CREATE PROCEDURE deleteInstructorToSection (IN `i_instructortosectionID` INT)  
BEGIN
  DELETE FROM InstructorToSections 
  WHERE InstructorToSectionID = i_instructortosectionID;
END //

CREATE PROCEDURE deletePartOfTerm (IN `i_PartOfTermID` INT)  
BEGIN
  DELETE FROM PartOfTerm 
  WHERE PartOfTermID = i_PartOfTermID;
END //

CREATE PROCEDURE deleteRole (IN `i_RoleID` INT)  
BEGIN
  DELETE FROM Roles 
  WHERE RoleID = i_RoleID;
END //

CREATE PROCEDURE deleteRoom (IN `i_RoomID` INT)  
BEGIN
  DELETE FROM Rooms 
  WHERE RoomID = i_RoomID;
END //

CREATE PROCEDURE deleteScheduleType (IN `i_ScheduleTypeID` INT)  
BEGIN
  DELETE FROM ScheduleTypes 
  WHERE ScheduleTypeID = i_ScheduleTypeID;
END //

CREATE PROCEDURE deleteSection (IN `i_SectionID` INT)  
BEGIN
  DELETE FROM Sections 
  WHERE SectionID = i_SectionID;
END //

CREATE PROCEDURE deleteSectionFee (IN `i_SectionFeeID` INT)  
BEGIN
    DELETE FROM SectionFees 
    WHERE SectionFeeID = i_SectionFeeID;
END //

CREATE PROCEDURE deleteSemester (IN `i_SemesterID` INT)  
BEGIN
    DELETE FROM Semesters 
    WHERE SemesterID = i_SemesterID;
END //

CREATE PROCEDURE deleteSpreadsheetVariable (IN `i_spreadsheetvariableID` INT)  
BEGIN
  DELETE FROM SpreadsheetVariables 
  WHERE SpreadsheetVariableID = i_spreadsheetvariableID;
END //

CREATE PROCEDURE deleteSubject (IN `i_subject_id` INT)  
BEGIN
  DELETE FROM Subjects 
  WHERE SubjectID = i_subject_id;
END //

CREATE PROCEDURE deleteUser (IN `i_UserID` INT)  
BEGIN
    DELETE FROM Users 
    WHERE UserID = i_UserID;
END //

CREATE PROCEDURE getAcademicSemesterByID (IN `i_AcademicSemesterID` INT)  
BEGIN
  SELECT * FROM AcademicSemesters 
  WHERE AcademicSemesterID = i_AcademicSemesterID;
END //

CREATE PROCEDURE getAcademicSemesters ()  
BEGIN
  SELECT * FROM AcademicSemesters;
END //

CREATE PROCEDURE getAcademicYearByID (IN `i_academicyear_id` INT)  
BEGIN
  SELECT * FROM AcademicYears 
  WHERE AcademicYearID = i_academicyear_id;
END //

CREATE PROCEDURE getAcademicYears ()  
BEGIN
  SELECT * FROM AcademicYears;
END //

CREATE PROCEDURE getBuildingByID (IN `i_BuildingID` INT)  
BEGIN
  SELECT * FROM Buildings 
  WHERE BuildingID = i_BuildingID;
END //

CREATE PROCEDURE getBuildings ()  
BEGIN
  SELECT * FROM Buildings;
END //

CREATE PROCEDURE getCampusByID (IN `i_CampusID` INT)  
BEGIN
  SELECT * FROM Campuses 
  WHERE CampusID = i_CampusID;
END //

CREATE PROCEDURE getCampuses ()  
BEGIN
  SELECT * FROM Campuses;
END //

CREATE PROCEDURE getChangeLogBySectionID (IN `i_SectionID` INT)  
BEGIN
  SELECT * FROM changelogs 
  WHERE SectionID = i_SectionID;
END //

CREATE PROCEDURE getCourseByDepartmentNumberAndTitle (IN `i_DepartmentAbbreviation` VARCHAR(255), IN `i_Number` INT, IN `i_Title` VARCHAR(255))  
BEGIN
  SELECT * FROM Courses c
	JOIN Departments d ON c.DepartmentID = d.DepartmentID
    WHERE d.Abbreviation = i_DepartmentAbbreviation AND c.Number = i_Number AND c.Title = i_Title;
END //

CREATE PROCEDURE getCourseByID (IN `i_CourseID` INT)  
BEGIN
  SELECT * FROM Courses 
  WHERE CourseID = i_CourseID;
END //

CREATE PROCEDURE getCourses ()  
BEGIN
  SELECT * FROM Courses;
END //

CREATE PROCEDURE getDayByAbbreviation (IN `abbreviation` VARCHAR(255))  
BEGIN
  SELECT * FROM Days 
  WHERE Abbreviation = abbreviation;
END //

CREATE PROCEDURE getDayByID (IN `i_DayID` INT)  
BEGIN
  SELECT * FROM Days 
  WHERE DayID = i_DayID;
END //

CREATE PROCEDURE getDays ()  
BEGIN
  SELECT * FROM Days;
END //

CREATE PROCEDURE getDaysBySectionID (IN `i_sectionID` INT, IN `i_DateToCheck` DATETIME)  
BEGIN
  SELECT * FROM Days AS d
  JOIN SectionDays AS sd ON sd.DayID = d.DayID
  JOIN Sections AS s ON s.SectionID = sd.SectionID
  WHERE s.SectionID = i_sectionID AND sd.DateArchived > i_DateToCheck
  ORDER BY d.DayID;
END //

CREATE PROCEDURE getDepartmentByAbbreviation (IN `abbreviation` VARCHAR(255))  
BEGIN
  SELECT * FROM Departments
  WHERE Abbreviation = abbreviation;
END //

CREATE PROCEDURE getDepartmentByID (IN `i_DepartmentID` INT)  
BEGIN
  SELECT * FROM Departments 
  WHERE DepartmentID = i_DepartmentID;
END //

CREATE PROCEDURE getDepartments ()  
BEGIN
  SELECT * FROM Departments;
END //

CREATE PROCEDURE getFeeByDetailCode (IN `detailcode` VARCHAR(255))  
BEGIN
  SELECT * FROM Fees 
  WHERE DetailCode = detailcode;
END //

CREATE PROCEDURE getFeeByID (IN `i_FeeID` INT)  
BEGIN
  SELECT * FROM Fees 
  WHERE FeeID = i_FeeID;
END //

CREATE PROCEDURE getFees ()  
BEGIN
  SELECT * FROM Fees;
END //

CREATE PROCEDURE getFeesBySectionID (IN `i_sectionID` INT)  
BEGIN
  SELECT f.FeeID, f.DetailCode FROM Fees AS f 
  JOIN SectionFees AS sf ON sf.FeeID = f.FeeID
  JOIN Sections AS s ON s.SectionID = sf.SectionID
  WHERE s.SectionID = i_sectionID;
END //

CREATE PROCEDURE getInstructorByFirstAndLastName (IN `i_firstname` VARCHAR(255), IN `i_lastname` VARCHAR(255))  
BEGIN
  SELECT * FROM Instructors 
  WHERE FirstName LIKE i_firstname AND LastName LIKE i_lastname;
END //

CREATE PROCEDURE getInstructorByID (IN `i_InstructorID` INT)  
BEGIN
  SELECT * FROM Instructors 
  WHERE InstructorID = i_InstructorID;
END //

CREATE PROCEDURE getInstructors ()  
BEGIN
  SELECT * FROM Instructors;
END //

CREATE PROCEDURE getInstructorsBySectionID (IN `i_sectionID` INT, IN `i_DateToCheck` DATETIME)  
BEGIN
  SELECT * FROM InstructorToSections
  WHERE SectionID = i_SectionID AND DateArchived > i_DateToCheck
  ORDER BY IsPrimary DESC;
END //

CREATE PROCEDURE getInstructorsToSectionByInstructorIDAndSectionID (IN `i_instructorID` INT, IN `i_sectionID` INT)  
BEGIN
  SELECT * FROM InstructorToSections 
  WHERE InstructorID = i_instructorID AND SectionID = i_sectionID;
END //

CREATE PROCEDURE getInstructorToSectionByID (IN `i_instructortosectionID` INT)  
BEGIN
  SELECT * FROM InstructorToSections 
  WHERE InstructorToSectionID = i_instructortosectionID;
END //

CREATE PROCEDURE getInstructorToSections ()  
BEGIN
  SELECT * FROM InstructorToSections 
  WHERE DateArchived > NOW();
END //

CREATE PROCEDURE getInstructorToSectionsBySectionID (IN `i_SectionID` INT)  
BEGIN
	SELECT * FROM InstructorToSections as i
	JOIN Sections as s ON s.SectionID = i.SectionID
	WHERE s.SectionID = i_SectionID;
END //

CREATE PROCEDURE getPartOfTerm ()  BEGIN
  SELECT * FROM PartOfTerm;
END //

CREATE PROCEDURE getPartOfTermByAbbreviation (IN `abbreviation` VARCHAR(255))  
BEGIN
  SELECT * FROM PartOfTerm 
  WHERE Abbreviation = abbreviation;
END //

CREATE PROCEDURE getPartOfTermByID (IN `i_PartOfTermID` INT)  
BEGIN
  SELECT * FROM PartOfTerm 
  WHERE PartOfTermID = i_PartOfTermID;
END //

CREATE PROCEDURE getPartOfTerms ()  
BEGIN
  SELECT * FROM PartOfTerm;
END //

CREATE PROCEDURE getRoleByID (IN `i_RoleID` INT)  
BEGIN
  SELECT * FROM Roles 
  WHERE RoleID = i_RoleID;
END //

CREATE PROCEDURE getRoles ()  
BEGIN
  SELECT * FROM Roles;
END //

CREATE PROCEDURE getRoomByID (IN `i_RoomID` INT)  
BEGIN
  SELECT * FROM Rooms 
  WHERE RoomID = i_RoomID;
END //

CREATE PROCEDURE getRoomByNumberAndBuildingAbbreviation (IN `i_Number` INT, IN `i_Abbreviation` VARCHAR(255))  
BEGIN
  SELECT * FROM Rooms AS r JOIN Buildings AS b on r.BuildingID = b.BuildingID 
  WHERE r.Number = i_Number AND b.Abbreviation = i_Abbreviation;
END //

CREATE PROCEDURE getRooms ()  
BEGIN
  SELECT * FROM Rooms;
END //

CREATE PROCEDURE getScheduleTypeByAbbreviation (IN `i_Abbreviation` VARCHAR(255))  
BEGIN
  SELECT * FROM ScheduleTypes 
  WHERE Abbreviation = i_Abbreviation;
END //

CREATE PROCEDURE getScheduleTypeByID (IN `i_ScheduleTypeID` INT)  
BEGIN
  SELECT * FROM ScheduleTypes 
  WHERE ScheduleTypeID = i_ScheduleTypeID;
END //

CREATE PROCEDURE getScheduleTypes ()  
BEGIN
  SELECT * FROM ScheduleTypes;
END //

CREATE PROCEDURE getSectionByID (IN `i_sectionID` INT)  
BEGIN
  SELECT * FROM Sections 
  WHERE SectionID = i_sectionID;
END //

CREATE PROCEDURE getSectionDayByDayIDAndSectionID (IN `i_DayID` INT, IN `i_SectionID` INT)  
BEGIN
  SELECT * FROM SectionDays 
  WHERE DayID = i_DayID AND SectionID = i_SectionID;
END //

CREATE PROCEDURE getSectionDayByID (IN `i_SectionDayID` INT)  
BEGIN
  SELECT * FROM SectionDays 
  WHERE SectionDayID = i_SectionDayID;
END //

CREATE PROCEDURE getSectionDays ()  BEGIN
	SELECT * FROM SectionDays;
END //

CREATE PROCEDURE getSectionDaysBySectionID (IN `i_sectionID` INT, IN `i_DateToCheck` DATETIME)  
BEGIN
  SELECT * FROM SectionDays
  WHERE SectionID = i_SectionID AND DateArchived > i_DateToCheck
  ORDER BY DayID;
END //

CREATE PROCEDURE getSectionFeeByID (IN `i_SectionFeeID` INT)  
BEGIN
	SELECT * FROM SectionFees 
    WHERE SectionFeeID = i_SectionFeeID; 
END //

CREATE PROCEDURE getSectionFees ()  
BEGIN
	SELECT * FROM SectionFees;
END //

CREATE PROCEDURE getSectionFeesByFeeID (IN `i_FeeID` INT)  
BEGIN
	SELECT * FROM SectionFees 
    WHERE FeeID = i_FeeID; 
END //

CREATE PROCEDURE getSectionFeesBySectionID (IN `i_SectionID` INT)  
BEGIN
	SELECT * FROM SectionFees 
    WHERE SectionID = i_SectionID; 
END //

CREATE PROCEDURE getSections ()  
BEGIN
  SELECT * FROM Sections;
END //

CREATE PROCEDURE getSectionsByAcademicSemesterID (IN `i_academicsemesterID` INT, IN `i_GetDeleted` BIT)  
BEGIN
IF i_GetDeleted THEN
  SELECT * FROM Sections 
  WHERE AcademicSemesterID = i_academicsemesterID AND DateArchived > NOW();
  END IF;
  IF NOT i_GetDeleted THEN
	SELECT * FROM Sections 
    WHERE AcademicSemesterID = i_academicsemesterID AND DateArchived > NOW() AND DateDeleted > NOW();
	END IF;
END //

CREATE PROCEDURE getSemesterByID (IN `i_SemesterID` INT)  
BEGIN
	SELECT * FROM Semesters 
    WHERE SemesterID = i_SemesterID; 
END //

CREATE PROCEDURE getSemesters ()  
BEGIN
	SELECT * FROM Semesters;
END //

CREATE PROCEDURE getSpreadsheetVariableByID (IN `i_spreadsheetvariableID` INT)  
BEGIN
  SELECT * FROM SpreadsheetVariables 
  WHERE SpreadsheetVariableID = i_spreadsheetvariableID;
END //

CREATE PROCEDURE getSpreadsheetVariables ()  
BEGIN
  SELECT * FROM SpreadsheetVariables;
END //

CREATE PROCEDURE getUserByID (IN `i_UserID` INT)  
BEGIN
	SELECT * FROM Users 
    WHERE UserID = i_UserID; 
END //

CREATE PROCEDURE getUsers ()  
BEGIN
	SELECT * FROM Users;
END //

CREATE PROCEDURE insertAcademicSemester (IN `i_AcademicYear` INT, IN `i_SemesterID` INT, OUT `i_AcademicSemesterID` INT)  
BEGIN
  INSERT INTO AcademicSemesters (AcademicYear, SemesterID) 
  VALUES (i_AcademicYear, i_SemesterID);
  SET i_AcademicSemesterID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertBuilding (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), IN `i_CampusID` INT, OUT `i_BuildingID` INT)  
BEGIN
  INSERT INTO Buildings (Name, Abbreviation, CampusID) 
  VALUES (i_Name, i_Abbreviation, i_CampusID);
  SET i_BuildingID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertCampus (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_CampusID` INT)  
BEGIN
  INSERT INTO Campuses (Name, Abbreviation) 
  VALUES (i_Name, i_Abbreviation);
  SET i_CampusID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertChangeLog (IN `i_sectionID` INT, IN `i_changedDepartment` BIT, IN `i_changedcoursenumber` BIT, IN `i_changedsectionnumber` BIT, 
IN `i_changedtitle` BIT, IN `i_changedcampus` BIT, IN `i_changedscheduletype` BIT, IN `i_changedrequiresmoodle` BIT, IN `i_changedrequirespermission` BIT, 
IN `i_changedpartofterm` BIT, IN `i_changedstudentlimit` BIT, IN `i_changedcreditmax` BIT, IN `i_changedcreditmin` BIT, IN `i_changedfixedcredit` BIT, 
IN `i_changedmonday` BIT, IN `i_changedtuesday` BIT, IN `i_changedwednesday` BIT, IN `i_changedthursday` BIT, IN `i_changedfriday` BIT, IN `i_changedsaturday` BIT, 
IN `i_changedsunday` BIT, IN `i_changedstarttime` BIT, IN `i_changedendtime` BIT, IN `i_changedbuilding` BIT, IN `i_changedroom` BIT, 
IN `i_changedprimeinstructor` BIT, IN `i_changedprimeinstructorpercent` BIT, IN `i_changedsecondinstructor` BIT, IN `i_changedsecondinstructorpercent` BIT, 
IN `i_changedfeedetailcode` BIT, IN `i_changedfeeamount` BIT, IN `i_changedsectionnotes` BIT, IN `i_changedcrosslistedDepartment` BIT, 
IN `i_changedcrosslistedsection` BIT, IN `i_changeddepartmentcomments` BIT, OUT `i_ChangeLogID` INT, IN `i_DateImported` DATETIME, IN `i_DateCreated` DATETIME, 
IN `i_DateDeleted` DATETIME)  
BEGIN
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
END //

CREATE PROCEDURE insertCourse (IN `i_number` INT, IN `i_title` VARCHAR(255), IN `i_minimumcredits` INT, IN `i_maximumcredits` INT, IN `i_fixedcredits` INT, 
IN `i_isfixedcredit` BIT, IN `i_DepartmentID` INT, IN `i_Description` VARCHAR(255), OUT `i_CourseID` INT)  
BEGIN
	INSERT INTO Courses (Number, Title, MinimumCredits, MaximumCredits, FixedCredits, IsFixedCredit, DepartmentID, Description) 
    VALUES (i_number, i_title, i_minimumcredits, i_maximumcredits, i_fixedcredits, i_isfixedcredit, i_DepartmentID, i_Description);
	SET i_CourseID = last_insert_id();
END //

CREATE PROCEDURE insertDay (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_DayID` INT)  
BEGIN
  INSERT INTO Days (Name, Abbreviation) 
  VALUES (i_Name, i_Abbreviation);
  SET i_DayID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertDepartment (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_DepartmentID` INT)  
BEGIN
  INSERT INTO Departments (Name, Abbreviation) 
  VALUES (i_Name, i_Abbreviation);
  SET i_DepartmentID = last_insert_id();
END //

CREATE PROCEDURE insertFee (IN `i_DetailCode` VARCHAR(255), OUT `i_FeeID` INT)  
BEGIN
  INSERT INTO Fees (DetailCode) 
  VALUES (i_DetailCode);
  SET i_FeeID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertInstructor (IN `i_FirstName` VARCHAR(255), IN `i_MiddleName` VARCHAR(255), IN `i_LastName` VARCHAR(255), IN `i_Number` INT, 
IN `i_CourseLoad` INT, OUT `i_InstructorID` INT)  
BEGIN
  INSERT INTO Instructors (FirstName, MiddleName, LastName, Number, CourseLoad) 
  VALUES (i_FirstName, i_MiddleName, i_LastName, i_Number, i_CourseLoad);
  SET i_InstructorID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertInstructorToSection (IN `i_isprimary` INT, IN `i_teachingpercentage` INT, IN `i_datearchived` DATETIME, IN `i_instructorID` INT, 
IN `i_sectionID` INT, OUT `i_InstructorToSectionID` INT)  BEGIN
  INSERT INTO InstructorToSections (IsPrimary, TeachingPercentage, DateArchived, InstructorID, SectionID) 
  VALUES (i_isprimary, i_teachingpercentage, i_datearchived, i_instructorID, i_sectionID);
  SET i_InstructorToSectionID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertPartOfTerm (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_PartOfTermID` INT)  
BEGIN
  INSERT INTO PartOfTerm (Name, Abbreviation) 
  VALUES (i_Name, i_Abbreviation);
  SET i_PartOfTermID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertRole (IN `i_Name` VARCHAR(255), IN `i_IsAdmin` BIT, `i_Sections` BIT(4), `i_Courses` BIT(4), `i_Buildings` BIT(4), 
`i_Campuses` BIT(4), `i_Roles` BIT(4), `i_Users` BIT(4), `i_Departments` BIT(4), `i_Fees` BIT(4), `i_Instructors` BIT(4), `i_Days` BIT(4), 
`i_Rooms` BIT(4), `i_ScheduleTypes` BIT(4), `i_Spreadsheets` BIT(4))  
BEGIN
  INSERT INTO Days (Name, IsAdmin, Sections, Courses, Buildings, Campuses, Roles, Users, Departments, Fees, Instructors, Days, Rooms, ScheduleTypes, Spreadsheets) 
  VALUES (i_Name, i_IsAdmin, i_Sections, i_Courses, i_Buildings, i_Campuses, i_Roles, i_Users, i_Departments, i_Fees, i_Instructors, i_Days, i_Rooms, 
  i_ScheduleTypes, i_Spreadsheets);
END //

CREATE PROCEDURE insertRoom (IN `i_Number` VARCHAR(255), IN `i_SeatsAvailable` INT, IN `i_Details` VARCHAR(255), IN `i_BuildingID` INT, OUT `i_RoomID` INT)  
BEGIN
  INSERT INTO Rooms (Number, SeatsAvailable, Details, BuildingID) 
  VALUES (i_Number, i_SeatsAvailable, i_Details, i_BuildingID);
  SET i_RoomID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertScheduleType (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_ScheduleTypeID` INT)  
BEGIN
  INSERT INTO ScheduleTypes (Name, Abbreviation) 
  VALUES (i_Name, i_Abbreviation);
  SET i_ScheduleTypeID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertSection (IN `i_crn` INT, IN `i_requiresmoodle` BIT, IN `i_requirespermission` BIT, IN `i_notes` VARCHAR(255), 
IN `i_departmentcomments` VARCHAR(255), IN `i_studentlimit` INT, IN `i_datecreated` DATETIME, IN `i_datearchived` DATETIME, IN `i_number` INT, 
IN `i_starttime` DATETIME, IN `i_endtime` DATETIME, IN `i_courseID` INT, IN `i_roomID` INT, IN `i_scheduletypeID` INT, IN `i_academicsemesterID` INT, 
IN `i_partoftermID` INT, OUT `i_SectionID` INT, IN `i_DateDeleted` DATETIME, IN `i_XListID` VARCHAR(255))  
BEGIN
  INSERT INTO Sections (CRN, RequiresMoodle, RequiresPermission, Notes, DepartmentComments, StudentLimit, DateCreated, DateArchived, DateDeleted, 
  Number, StartTime, EndTime, CourseID, RoomID, ScheduleTypeID, AcademicSemesterID, PartOfTermID, XListID) 
  VALUES (i_crn, i_requiresmoodle, i_requirespermission, i_notes, i_departmentcomments, i_studentlimit, i_datecreated, i_datearchived, 
  i_DateDeleted, i_number, i_starttime, i_endtime, i_courseID, i_roomID, i_scheduletypeID, i_academicsemesterID, i_partoftermID, i_XListID);
  SET i_SectionID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertSectionDay (IN `i_DayID` INT, IN `i_SectionID` INT, IN `i_DateArchived` DATETIME, OUT `i_SectionDayID` INT)  
BEGIN
    INSERT INTO SectionDays (SectionID, DayID, DateArchived) 
    VALUES (i_SectionID, i_DayID, i_DateArchived);
    SET i_SectionDayID = last_insert_id();
END //

CREATE PROCEDURE insertSectionFee (IN `i_Amount` DECIMAL(13,4), IN `i_SectionID` INT, IN `i_FeeID` INT, OUT `i_SectionFeeID` INT)  
BEGIN
    INSERT INTO SectionFees ( SectionID, FeeID, Amount) 
    VALUES (i_SectionID, i_FeeID, i_Amount);
    SET i_SectionFeeID = last_insert_id();
END //

CREATE PROCEDURE insertSemester (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_SemesterID` INT)  
BEGIN
    INSERT INTO Semesters (Name, Abbreviation) 
    VALUES (i_Name, i_Abbreviation);
    SET i_SemesterID = last_insert_id();
END //

CREATE PROCEDURE insertSpreadsheetVariable (IN `i_spreadsheet` BLOB, IN `i_startrownumber` INT, IN `i_defaultfontsize` INT, IN `i_academicsemester` VARCHAR(255), 
IN `i_addchangedelete` VARCHAR(255), IN `i_sectioncrn` VARCHAR(255), IN `i_subjectname` VARCHAR(255), IN `i_coursenumber` VARCHAR(255), 
IN `i_sectionnumber` VARCHAR(255), IN `i_crosslistid` VARCHAR(255), IN `i_coursetitle` VARCHAR(255), IN `i_campus` VARCHAR(255), IN `i_scheduletype` VARCHAR(255), 
IN `i_moodlerequired` VARCHAR(255), IN `i_instructorapprovalrequired` VARCHAR(255), IN `i_partofterm` VARCHAR(255), IN `i_fixedcredit` VARCHAR(255), 
IN `i_minimumcredits` VARCHAR(255), IN `i_maximumcredits` VARCHAR(255), IN `i_classlimit` VARCHAR(255), IN `i_monday` VARCHAR(255), IN `i_tuesday` VARCHAR(255), 
IN `i_wednesday` VARCHAR(255), IN `i_thursday` VARCHAR(255), IN `i_friday` VARCHAR(255), IN `i_saturday` VARCHAR(255), IN `i_sunday` VARCHAR(255), 
IN `i_starttime` VARCHAR(255), IN `i_endtime` VARCHAR(255), IN `i_building` VARCHAR(255), IN `i_room` VARCHAR(255), IN `i_primaryinstructorfirstname` VARCHAR(255), 
IN `i_primaryinstructorlastname` VARCHAR(255), IN `i_primaryinstructornumber` VARCHAR(255), IN `i_primaryinstructorteachingpercentage` VARCHAR(255), 
IN `i_secondaryinstructorfirstname` VARCHAR(255), IN `i_secondaryinstructorlastname` VARCHAR(255), IN `i_secondaryinstructornumber` VARCHAR(255), 
IN `i_secondaryinstructorteachingpercentage` VARCHAR(255), IN `i_classfeedetailcode` VARCHAR(255), IN `i_classfeeamount` VARCHAR(255), 
IN `i_sectionnotes` VARCHAR(255), IN `i_crosslistsubject` VARCHAR(255), IN `i_crosslistcoursenumber` VARCHAR(255), IN `i_departmentcomments` VARCHAR(255))  
BEGIN
  INSERT INTO SpreadsheetVariables (Spreadsheet, StartRowNumber, DefaultFontSize, AcademicSemester, AddChangeDelete, SectionCRN, SubjectName, CourseNumber, 
  SectionNumber, CrossListID, CourseTitle, Campus, ScheduleType, MoodleRequired, InstructorApprovalRequired, PartOfTerm, FixedCredit, MinimumCredits, 
  MaximumCredits, ClassLimit, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday, StartTime, EndTime, Building, Room, PrimaryInstructorFirstName, 
  PrimaryInstructorLastName, PrimaryInstructorNumber, PrimaryInstructorTeachingPercentage, SecondaryInstructorFirstName, SecondaryInstructorLastName, 
  SecondaryInstructorNumber, SecondaryInstructorTeachingPercentage, ClassFeeDetailCode, ClassFeeAmount, SectionNotes, CrossListSubject, CrossListCourseNumber, 
  DepartmentComments) 
  VALUES (i_spreadsheet, i_startrownumber, i_defaultfontsize, i_academicsemester, i_addchangedelete, i_sectioncrn, i_subjectname, i_coursenumber, 
  i_sectionnumber, i_crosslistid, i_coursetitle, i_campus, i_scheduletype, i_moodlerequired, i_instructorapprovalrequired, i_partofterm, i_fixedcredit, 
  i_minimumcredits, i_maximumcredits, i_classlimit, i_monday, i_tuesday, i_wednesday, i_thursday, i_friday, i_saturday, i_sunday, i_starttime, i_endtime, 
  i_building, i_room, i_primaryinstructorfirstname, i_primaryinstructorlastname, i_primaryinstructornumber, i_primaryinstructorteachingpercentage, 
  i_secondaryinstructorfirstname, i_secondaryinstructorlastname, i_secondaryinstructornumber, i_secondaryinstructorteachingpercentage, i_classfeedetailcode, 
  i_classfeeamount, i_sectionnotes, i_sectionnotes, i_crosslistsubject, i_crosslistcoursenumber, i_departmentcomments);
END //

CREATE PROCEDURE insertUser (IN `i_RoleID` INT, IN `i_Username` VARCHAR(255), IN `i_Password` VARCHAR(255), OUT `i_UserID` INT)  
BEGIN
    INSERT INTO Users (Username, Password, RoleID) 
    VALUES (i_Username, i_Password, i_RoleID);
    SET i_UserID = last_insert_id();
END //

CREATE PROCEDURE updateAcademicSemester (IN `i_academicsemesterID` INT, IN `i_semesterID` INT, IN `i_academicyear` INT)  
BEGIN
  UPDATE AcademicSemesters SET SemesterID = i_semesterID, AcademicYear = i_academicyear 
  WHERE AcademicSemesterID = i_academicsemesterID;
END //

CREATE PROCEDURE updateBuilding (IN `i_BuildingID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), IN `i_CampusID` INT)  
BEGIN
  UPDATE Buildings SET Name = i_Name, Abbreviation = i_Abbreviation, CampusID = i_CampusID 
  WHERE BuildingID = i_BuildingID;
END //

CREATE PROCEDURE updateCampus (IN `i_CampusID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  BEGIN
  UPDATE Campuses SET Name = i_Name, Abbreviation = i_Abbreviation WHERE CampusID = i_CampusID;
END //

CREATE PROCEDURE updateChangeLog (IN `i_changelogID` INT, IN `i_sectionID` INT, IN `i_changedcoursenumber` BIT, IN `i_changedsectionnumber` BIT, 
IN `i_changedtitle` BIT, IN `i_changedcampus` BIT, IN `i_changedscheduletype` BIT, IN `i_changedrequiresmoodle` BIT, IN `i_changedrequirespermission` BIT, 
IN `i_changedpartofterm` BIT, IN `i_changedstudentlimit` BIT, IN `i_changedcreditmax` BIT, IN `i_changedcreditmin` BIT, IN `i_changedfixedcredit` BIT, 
IN `i_changedmonday` BIT, IN `i_changedtuesday` BIT, IN `i_changedwednesday` BIT, IN `i_changedthursday` BIT, IN `i_changedfriday` BIT, 
IN `i_changedsaturday` BIT, IN `i_changedsunday` BIT, IN `i_changedstarttime` BIT, IN `i_changedendtime` BIT, IN `i_changedbuilding` BIT, 
IN `i_changedroom` BIT, IN `i_changedprimeinstructor` BIT, IN `i_changedprimeinstructorpercent` BIT, IN `i_changedsecondinstructor` BIT, 
IN `i_changedsecondinstructorpercent` BIT, IN `i_changedfeedetailcode` BIT, IN `i_changedfeeamount` BIT, IN `i_changedsectionnotes` BIT, 
IN `i_changedcrosslisteddepartment` BIT, IN `i_changedcrosslistedsection` BIT, IN `i_changeddepartmentcomments` BIT, IN `i_DateCreated` DATETIME, 
IN `i_DateImported` DATETIME, IN `i_DateDeleted` DATETIME)  
BEGIN
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
	ChangedDepartmentComments = i_changeddepartmentcomments, DateImported = i_DateImported, DateCreated = i_DateCreated, DateDeleted = i_DateDeleted 
    WHERE ChangeLogID = i_changelogID;
END //

CREATE PROCEDURE updateCourse (IN `i_CourseID` INT, IN `i_number` INT, IN `i_title` VARCHAR(255), IN `i_minimumcredits` INT, IN `i_maximumcredits` INT, 
IN `i_fixedcredits` INT, IN `i_isfixedcredit` BIT, IN `i_departmentID` INT, IN `i_Description` VARCHAR(255))  
BEGIN
  UPDATE Courses SET Number = i_number, Title = i_title, MinimumCredits = i_minimumcredits, MaximumCredits = i_maximumcredits, FixedCredits = i_fixedcredits, 
  IsFixedCredit = i_isfixedcredit, DepartmentID = i_departmentID, Description = i_Description 
  WHERE CourseID = i_courseID;
END //

CREATE PROCEDURE updateDay (IN `i_DayID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  
BEGIN
  UPDATE Days SET Name = i_Name, Abbreviation = i_Abbreviation 
  WHERE DayID = i_DayID;
END //

CREATE PROCEDURE updateDepartment (IN `i_DepartmentID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  
BEGIN
  UPDATE Departments SET Name = i_Name, Abbreviation = i_Abbreviation 
  WHERE DepartmentID = i_DepartmentID;
END //

CREATE PROCEDURE updateFee (IN `i_FeeID` INT, IN `i_DetailCode` VARCHAR(255))  
BEGIN
  UPDATE Fees SET DetailCode = i_DetailCode 
  WHERE FeeID = i_FeeID;
END //

CREATE PROCEDURE updateInstructor (IN `i_InstructorID` INT, IN `i_FirstName` VARCHAR(255), IN `i_MiddleName` VARCHAR(255), IN `i_LastName` VARCHAR(255), 
IN `i_Number` INT, IN `i_CourseLoad` INT)  
BEGIN
  UPDATE Instructors SET FirstName = i_FirstName, MiddleName = i_MiddleName, LastName = i_LastName, Number = i_Number, CourseLoad = i_CourseLoad 
  WHERE InstructorID = i_InstructorID;
END //

CREATE PROCEDURE updateInstructorToSection (IN `i_instructortosectionID` INT, IN `i_isprimary` INT, IN `i_teachingpercentage` INT, 
IN `i_datearchived` DATETIME, IN `i_instructorID` INT, IN `i_sectionID` INT)  
BEGIN
  UPDATE InstructorToSections SET IsPrimary = i_isprimary, TeachingPercentage = i_teachingpercentage, DateArchived = i_datearchived, 
  InstructorID = i_instructorID, SectionID = i_sectionID 
  WHERE InstructorToSectionID = i_instructortosectionID;
END //

CREATE PROCEDURE updatePartOfTerm (IN `i_PartOfTermID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  
BEGIN
  UPDATE PartOfTerm SET Name = i_Name, Abbreviation = i_Abbreviation 
  WHERE PartOfTermID = i_PartOfTermID;
END //

CREATE PROCEDURE updateRoom (IN `i_RoomID` INT, IN `i_Number` VARCHAR(255), IN `i_SeatsAvailable` INT, IN `i_Details` VARCHAR(255), IN `i_BuildingID` INT)  
BEGIN
  UPDATE Rooms SET Number = i_Number, SeatsAvailable = i_SeatsAvailable, Details = i_Details, BuildingID = i_BuildingID 
  WHERE RoomID = i_RoomID;
END //

CREATE PROCEDURE updateScheduleType (IN `i_ScheduleTypeID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  
BEGIN
  UPDATE ScheduleTypes SET Name = i_Name, Abbreviation = i_Abbreviation 
  WHERE ScheduleTypeID = i_ScheduleTypeID;
END //

CREATE PROCEDURE updateSection (IN `i_sectionID` INT, IN `i_crn` INT, IN `i_requiresmoodle` BIT, IN `i_requirespermission` BIT, IN `i_notes` VARCHAR(255), 
IN `i_departmentcomments` VARCHAR(255), IN `i_studentlimit` INT, IN `i_datecreated` DATETIME, IN `i_datearchived` DATETIME, IN `i_number` INT, 
IN `i_starttime` DATETIME, IN `i_endtime` DATETIME, IN `i_courseID` INT, IN `i_roomID` INT, IN `i_scheduletypeID` INT, IN `i_academicsemesterID` INT, 
IN `i_partoftermID` INT, IN `i_DateDeleted` DATETIME)  
BEGIN
  UPDATE Sections SET CRN = i_crn, RequiresMoodle = i_requiresmoodle, RequiresPermission = i_requirespermission, Notes = i_notes, 
  DepartmentComments = i_departmentcomments, StudentLimit = i_studentlimit, DateCreated = i_datecreated, DateArchived = i_datearchived, 
  Number = i_number, StartTime = i_starttime, EndTime = i_endtime, CourseID = i_courseID, RoomID = i_roomID, ScheduleTypeID = i_scheduletypeID, 
  AcademicSemesterID = i_academicsemesterID, PartOfTermID = i_partoftermID, DateDeleted = i_DateDeleted 
  WHERE SectionID = i_sectionID;
END //

CREATE PROCEDURE updateSectionDay (IN `i_DayID` INT, IN `i_SectionID` INT, IN `i_DateArchived` DATETIME, IN `i_SectionDayID` INT) 
BEGIN
    UPDATE SectionDays SET SectionID = i_SectionID, DayID = i_DayID, DateArchived = i_DateArchived 
    WHERE SectionDayID = i_SectionDayID;
END //

CREATE PROCEDURE updateSectionFee (IN `i_SectionFeeID` INT, IN `i_Amount` DECIMAL(13,4), IN `i_SectionID` INT, IN `i_FeeID` INT)  
BEGIN
    UPDATE SectionFees SET SectionID = i_SectionID, FeeID = i_FeeID, Amount = i_Amount 
    WHERE SectionFeeID = i_SectionFeeID;
END //

CREATE PROCEDURE updateSemester (IN `i_SemesterID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  
BEGIN
    UPDATE Semesters SET Name = i_Name, Abbreviation = i_Abbreviation 
    WHERE SemesterID = i_SemesterID;
END //

CREATE PROCEDURE updateSpreadsheetVariable (IN `i_spreadsheetvariableID` INT, IN `i_spreadsheet` BLOB, IN `i_startrownumber` INT, IN `i_defaultfontsize` INT, 
IN `i_academicsemester` VARCHAR(255), IN `i_addchangedelete` VARCHAR(255), IN `i_sectioncrn` VARCHAR(255), IN `i_subjectname` VARCHAR(255), 
IN `i_coursenumber` VARCHAR(255), IN `i_sectionnumber` VARCHAR(255), IN `i_crosslistid` VARCHAR(255), IN `i_coursetitle` VARCHAR(255), 
IN `i_campus` VARCHAR(255), IN `i_scheduletype` VARCHAR(255), IN `i_moodlerequired` VARCHAR(255), IN `i_instructorapprovalrequired` VARCHAR(255), 
IN `i_partofterm` VARCHAR(255), IN `i_fixedcredit` VARCHAR(255), IN `i_minimumcredits` VARCHAR(255), IN `i_maximumcredits` VARCHAR(255), 
IN `i_classlimit` VARCHAR(255), IN `i_monday` VARCHAR(255), IN `i_tuesday` VARCHAR(255), IN `i_wednesday` VARCHAR(255), IN `i_thursday` VARCHAR(255), 
IN `i_friday` VARCHAR(255), IN `i_saturday` VARCHAR(255), IN `i_sunday` VARCHAR(255), IN `i_starttime` VARCHAR(255), IN `i_endtime` VARCHAR(255), 
IN `i_building` VARCHAR(255), IN `i_room` VARCHAR(255), IN `i_primaryinstructorfirstname` VARCHAR(255), IN `i_primaryinstructorlastname` VARCHAR(255), 
IN `i_primaryinstructornumber` VARCHAR(255), IN `i_primaryinstructorteachingpercentage` VARCHAR(255), IN `i_secondaryinstructorfirstname` VARCHAR(255), 
IN `i_secondaryinstructorlastname` VARCHAR(255), IN `i_secondaryinstructornumber` VARCHAR(255), IN `i_secondaryinstructorteachingpercentage` VARCHAR(255), 
IN `i_classfeedetailcode` VARCHAR(255), IN `i_classfeeamount` VARCHAR(255), IN `i_sectionnotes` VARCHAR(255), IN `i_crosslistsubject` VARCHAR(255), 
IN `i_crosslistcoursenumber` VARCHAR(255), IN `i_departmentcomments` VARCHAR(255))  
BEGIN
  UPDATE SpreadsheetVariables SET Spreadsheet = i_spreadsheet, StartRowNumber = i_startrownumber, DefaultFontSize = i_defaultfontsize, 
  AcademicSemester = i_academicsemester, AddChangeDelete = i_addchangedelete, SectionCRN = i_sectioncrn, SubjectName = i_subjectname, 
  CourseNumber = i_coursenumber, SectionNumber = i_sectionnumber, CrossListID = i_crosslistid, CourseTitle = i_coursetitle, Campus = i_campus, 
  ScheduleType = i_scheduletype, MoodleRequired = i_moodlerequired, InstructorApprovalRequired = i_instructorapprovalrequired, PartOfTerm = i_partofterm, 
  FixedCredit = i_fixedcredit, MinimumCredits = i_minimumcredits, MaximumCredits = i_maximumcredits, ClassLimit = i_classlimit, Monday = i_monday, 
  Tuesday = i_tuesday, Wednesday = i_wednesday, Thursday = i_thursday, Friday = i_friday, Saturday = i_saturday, Sunday = i_sunday, StartTime = i_starttime, 
  EndTime = i_endtime, Building = i_building, Room = i_room, PrimaryInstructorFirstName = i_primaryinstructorfirstname, 
  PrimaryInstructorLastName = i_primaryinstructorlastname, PrimaryInstructorNumber = i_primaryinstructornumber, 
  PrimaryInstructorTeachingPercentage = i_primaryinstructorteachingpercentage, SecondaryInstructorFirstName = i_secondaryinstructorfirstname, 
  SecondaryInstructorLastName = i_secondaryinstructorlastname, SecondaryInstructorNumber = i_secondaryinstructornumber, 
  SecondaryInstructorTeachingPercentage = i_secondaryinstructorteachingpercentage, ClassFeeDetailCode = i_classfeedetailcode, 
  ClassFeeAmount = i_classfeeamount, SectionNotes = i_sectionnotes, CrossListSubject = i_crosslistsubject, CrossListCourseNumber = i_crosslistcoursenumber, 
  DepartmentComments = i_departmentcomments 
  WHERE SpreadsheetVariableID = i_spreadsheetvariableID;
END //

CREATE PROCEDURE updateSubject (IN `i_subject_id` INT, IN `i_number` INT, IN `i_title` VARCHAR(255), IN `i_minimumcredits` INT, IN `i_maximumcredits` INT, 
IN `i_fixedcredits` INT, IN `i_isfixedcredit` BIT, IN `i_department_id` INT)  
BEGIN
  UPDATE Subjects SET Number = i_number, Title = i_title, MinimumCredits = i_minimumcredits, MaximumCredits = i_maximumcredits, 
  FixedCredits = i_fixedcredits, IsFixedCredit = i_isfixedcredit, DepartmentID = i_department_id 
  WHERE SubjectID = i_course_id;
END //

CREATE PROCEDURE updateUser (IN `i_RoleID` INT, IN `i_Username` VARCHAR(255), IN `i_Password` VARCHAR(255), IN `i_UserID` INT)  
BEGIN
    UPDATE Users SET Username = i_Username, Password = i_Password, RoleID = i_RoleID 
    WHERE UserID = i_UserID;
END //

DELIMITER ;