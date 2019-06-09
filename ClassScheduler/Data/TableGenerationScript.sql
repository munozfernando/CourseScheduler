-- THIS IS NOT AS ACCURATE AS THE FULL GENERATION SCRIPT --

CREATE TABLE semesters (
  SemesterID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) NOT NULL,
  Abbreviation varchar(10) NOT NULL
) ;

CREATE TABLE academicsemesters (
  AcademicSemesterID int(11) AUTO_INCREMENT PRIMARY KEY ,
  SemesterID int(11) NOT NULL,
  CONSTRAINT SemesterToAcademicSemester FOREIGN KEY (SemesterID)
  REFERENCES Semesters(SemesterID),
  AcademicYear int(11) NOT NULL
) ;

CREATE TABLE campuses (
  CampusID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) NOT NULL,
  Abbreviation varchar(255) NOT NULL
) ;

CREATE TABLE buildings (
  BuildingID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) NOT NULL,
  Abbreviation varchar(255) NOT NULL,
  CampusID int(11) NOT NULL,
  CONSTRAINT CampusToBuilding FOREIGN KEY (CampusID)
  REFERENCES Campuses(CampusID)
) ;

CREATE TABLE rooms (
  RoomID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Number varchar(255) NOT NULL,
  SeatsAvailable int(11) NOT NULL,
  Details varchar(255) NOT NULL,
  BuildingID int(11) NOT NULL,
  CONSTRAINT BuildingToRoom FOREIGN KEY (BuildingID)
  REFERENCES Buildings(BuildingID)
) ;

CREATE TABLE colleges (
  CollegeID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) DEFAULT NULL
) ;

CREATE TABLE days (
  DayID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) NOT NULL,
  Abbreviation varchar(255) NOT NULL
) ;

CREATE TABLE departments (
  DepartmentID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) DEFAULT NULL,
  Abbreviation varchar(255) DEFAULT NULL
) ;

CREATE TABLE courses (
  CourseID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Number int(11) NOT NULL,
  Title varchar(255) NOT NULL,
  Description varchar(255) NOT NULL,
  MinimumCredits int(11) NOT NULL,
  MaximumCredits int(11) NOT NULL,
  FixedCredits int(11) NOT NULL,
  IsFixedCredit bit(1) NOT NULL,
  DepartmentID int(11) NOT NULL,
  CONSTRAINT DepartmentToCourse FOREIGN KEY (DepartmentID)
  REFERENCES Departments(DepartmentID)
) ;

CREATE TABLE departmentcolleges (
  DepartmentCollegeID int(11) AUTO_INCREMENT PRIMARY KEY ,
  CollegeID int(11) NOT NULL,
  CONSTRAINT CollegeToDepartment FOREIGN KEY (CollegeID)
  REFERENCES Colleges(CollegeID),
  DepartmentID int(11) NOT NULL,
  CONSTRAINT DepartmentToCollege FOREIGN KEY (DepartmentID)
  REFERENCES Departments(DepartmentID)
) ;

CREATE TABLE fees (
  FeeID int(11) AUTO_INCREMENT PRIMARY KEY ,
  DetailCode varchar(255) NOT NULL
) ;

CREATE TABLE instructors (
  InstructorID int(11) AUTO_INCREMENT PRIMARY KEY ,
  FirstName varchar(255) NOT NULL,
  MiddleName varchar(255) NOT NULL,
  LastName varchar(255) NOT NULL,
  Number int(11) NOT NULL,
  CourseLoad int(11) NOT NULL
) ;

CREATE TABLE partofterm (
  PartOfTermID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) NOT NULL,
  Abbreviation varchar(255) NOT NULL
) ;

CREATE TABLE roles (
  RoleID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) DEFAULT NULL,
  IsAdmin bit(1) NOT NULL,
  Sections bit(4) NOT NULL,
  Courses bit(4) NOT NULL,
  Buildings bit(4) NOT NULL,
  Campuses bit(4) NOT NULL,
  Roles bit(4) NOT NULL,
  Users bit(4) NOT NULL,
  Departments bit(4) NOT NULL,
  Fees bit(4) NOT NULL,
  Instructors bit(4) NOT NULL,
  Days bit(4) NOT NULL,
  Rooms bit(4) NOT NULL,
  ScheduleTypes bit(4) NOT NULL,
  Spreadsheets bit(4) NOT NULL
) ;

CREATE TABLE schedules (
  ScheduleID int(11) AUTO_INCREMENT PRIMARY KEY ,
  StartTime datetime NOT NULL,
  EndTime datetime NOT NULL,
  NumberOfDays int(11) NOT NULL,
  CollegeID int(11) NOT NULL,
  CONSTRAINT CollegeToSchedule FOREIGN KEY (CollegeID)
  REFERENCES Colleges(CollegeID)
) ;

CREATE TABLE scheduletypes (
  ScheduleTypeID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) NOT NULL,
  Abbreviation varchar(255) NOT NULL
) ;

CREATE TABLE users (
  UserID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Username varchar(255) NOT NULL,
  Password varchar(255) DEFAULT NULL,
  RoleID int(11) DEFAULT '2',
  CONSTRAINT RoleToUser FOREIGN KEY (RoleID)
  REFERENCES Roles(RoleID)
) ;

CREATE TABLE spreadsheetvariables (
  SpreadsheetVariableID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Spreadsheet blob NOT NULL,
  StartingRowNumber int(11) NOT NULL,
  DefaultFontSize int(11) NOT NULL,
  AddChangeDelete varchar(255) NOT NULL,
  AcademicSemester varchar(255) NOT NULL,
  SubjectName varchar(255) NOT NULL,
  SectionCRN varchar(255) NOT NULL,
  CourseNumber varchar(255) NOT NULL,
  SectionNumber varchar(255) NOT NULL,
  CrossListID varchar(255) NOT NULL,
  CourseTitle varchar(255) NOT NULL,
  Campus varchar(255) NOT NULL,
  ScheduleType varchar(255) NOT NULL,
  MoodleRequired varchar(255) NOT NULL,
  InstructorApprovalRequired varchar(255) NOT NULL,
  PartOfTerm varchar(255) NOT NULL,
  FixedCredit varchar(255) NOT NULL,
  MinimumCredits varchar(255) NOT NULL,
  MaximumCredits varchar(255) NOT NULL,
  ClassLimit varchar(255) NOT NULL,
  Monday varchar(255) NOT NULL,
  Tuesday varchar(255) NOT NULL,
  Wednesday varchar(255) NOT NULL,
  Thursday varchar(255) NOT NULL,
  Friday varchar(255) NOT NULL,
  Saturday varchar(255) NOT NULL,
  Sunday varchar(255) NOT NULL,
  StartTime varchar(255) NOT NULL,
  EndTime varchar(255) NOT NULL,
  Building varchar(255) NOT NULL,
  Room varchar(255) NOT NULL,
  PrimaryInstructorFirstName varchar(255) NOT NULL,
  PrimaryInstructorLastName varchar(255) NOT NULL,
  PrimaryInstructorNumber varchar(255) NOT NULL,
  PrimaryInstructorTeachingPercentRequired varchar(255) NOT NULL,
  SecondaryInstructorFirstName varchar(255) NOT NULL,
  SecondaryInstructorLastName varchar(255) NOT NULL,
  SecondaryInstructorNumber varchar(255) NOT NULL,
  SecondaryInstructorTeachingPercentRequired varchar(255) NOT NULL,
  ClassFeeDetailCode varchar(255) NOT NULL,
  ClassFeeAmount varchar(255) NOT NULL,
  SectionNotes varchar(255) NOT NULL,
  CrossListSubject varchar(255) NOT NULL,
  CrossListCourseNumber varchar(255) NOT NULL,
  DepartmentComments varchar(255) NOT NULL
) ;

CREATE TABLE usertodepartments (
  UserToDepartmentID int(11) AUTO_INCREMENT PRIMARY KEY ,
  UserID int(11) NOT NULL,
  CONSTRAINT UserToDepartment FOREIGN KEY (UserID)
  REFERENCES Users(UserID),
  DepartmentID int(11) NOT NULL,
  CONSTRAINT DepartmentToUser FOREIGN KEY (DepartmentID)
  REFERENCES Departments(DepartmentID)
) ;

CREATE TABLE sections (
  SectionID int(11) AUTO_INCREMENT PRIMARY KEY ,
  CRN int(11) NOT NULL,
  RequiresMoodle bit(1) NOT NULL,
  RequiresPermission bit(1) NOT NULL,
  Notes varchar(255) NOT NULL,
  DepartmentComments varchar(255) NOT NULL,
  StudentLimit int(11) NOT NULL,
  DateCreated datetime NOT NULL,
  DateArchived datetime NOT NULL,
  Number varchar(255) NOT NULL,
  StartTime datetime NOT NULL,
  EndTime datetime NOT NULL,
  CourseID int(11) NOT NULL,
  CONSTRAINT CourseToSection FOREIGN KEY (CourseID)
  REFERENCES Courses(CourseID),
  RoomID int(11) NOT NULL,
  ScheduleTypeID int(11) NOT NULL,
  AcademicSemesterID int(11) NOT NULL,
  CONSTRAINT AcademicSemesterToSection FOREIGN KEY (AcademicSemesterID)
  REFERENCES AcademicSemesters(AcademicSemesterID),
  PartOfTermID int(11) NOT NULL,
  XListID varchar(255) NOT NULL,
  DateDeleted datetime NOT NULL
) ;

CREATE TABLE sectiondays (
  SectionDayID int(11) AUTO_INCREMENT PRIMARY KEY ,
  SectionID int(11) NOT NULL,
  CONSTRAINT SectionToDay FOREIGN KEY (SectionID)
  REFERENCES Sections(SectionID),
  DayID int(11) NOT NULL,
  CONSTRAINT DayToSection FOREIGN KEY (DayID)
  REFERENCES Days(DayID),
  DateArchived datetime NOT NULL
) ;

CREATE TABLE sectionfees (
  SectionFeeID int(11) AUTO_INCREMENT PRIMARY KEY ,
  SectionID int(11) NOT NULL,
  CONSTRAINT SectionToFee FOREIGN KEY (SectionID)
  REFERENCES Sections(SectionID),
  FeeID int(11) NOT NULL,
  CONSTRAINT FeeToSection FOREIGN KEY (FeeID)
  REFERENCES Fees(FeeID),
  Amount decimal(13,4) DEFAULT NULL
) ;

CREATE TABLE changelogs (
  ChangeLogID int(11) AUTO_INCREMENT PRIMARY KEY ,
  SectionID int(11) NOT NULL,
  CONSTRAINT SectionToChangeLog FOREIGN KEY (SectionID)
  REFERENCES Sections(SectionID),
  ChangedDepartment bit(1) NOT NULL,
  ChangedCourseNumber bit(1) NOT NULL,
  ChangedSectionNumber bit(1) NOT NULL,
  ChangedTitle bit(1) NOT NULL,
  ChangedCampus bit(1) NOT NULL,
  ChangedScheduleType bit(1) NOT NULL,
  ChangedRequiresMoodle bit(1) NOT NULL,
  ChangedRequiresPermission bit(1) NOT NULL,
  ChangedPartOfTerm bit(1) NOT NULL,
  ChangedStudentLimit bit(1) NOT NULL,
  ChangedCreditMax bit(1) NOT NULL,
  ChangedCreditMin bit(1) NOT NULL,
  ChangedFixedCredit bit(1) NOT NULL,
  ChangedMonday bit(1) NOT NULL,
  ChangedTuesday bit(1) NOT NULL,
  ChangedWednesday bit(1) NOT NULL,
  ChangedThursday bit(1) NOT NULL,
  ChangedFriday bit(1) NOT NULL,
  ChangedSaturday bit(1) NOT NULL,
  ChangedSunday bit(1) NOT NULL,
  ChangedStartTime bit(1) NOT NULL,
  ChangedEndTime bit(1) NOT NULL,
  ChangedBuilding bit(1) NOT NULL,
  ChangedRoom bit(1) NOT NULL,
  ChangedPrimeInstructor bit(1) NOT NULL,
  ChangedPrimeInstructorPercent bit(1) NOT NULL,
  ChangedSecondInstructor bit(1) NOT NULL,
  ChangedSecondInstructorPercent bit(1) NOT NULL,
  ChangedFeeDetailCode bit(1) NOT NULL,
  ChangedFeeAmount bit(1) NOT NULL,
  ChangedSectionNotes bit(1) NOT NULL,
  ChangedCrossListedDepartment bit(1) NOT NULL,
  ChangedCrossListedSection bit(1) NOT NULL,
  ChangedDepartmentComments bit(1) NOT NULL,
  DateImported datetime NOT NULL,
  DateCreated datetime NOT NULL,
  DateDeleted datetime NOT NULL
) ;

CREATE TABLE instructortosections (
  InstructorToSectionID int(11) AUTO_INCREMENT PRIMARY KEY ,
  IsPrimary bit(1) NOT NULL,
  TeachingPercentage int(11) NOT NULL,
  DateArchived datetime NOT NULL,
  InstructorID int(11) NOT NULL,
  CONSTRAINT InstructorToSection FOREIGN KEY (InstructorID)
  REFERENCES Instructors(InstructorID),
  SectionID int(11) NOT NULL,
  CONSTRAINT SectionToInstructor FOREIGN KEY (SectionID)
  REFERENCES Sections(SectionID)
) ;

CREATE TABLE collegetousers (
  CollegeToUserID int(11) AUTO_INCREMENT PRIMARY KEY ,
  CollegeID int(11) NOT NULL,
  CONSTRAINT CollegeToUser FOREIGN KEY (CollegeID)
  REFERENCES Colleges(CollegeID),
  UserID int(11) NOT NULL,
  CONSTRAINT UserToCollege FOREIGN KEY (UserID)
  REFERENCES Users(UserID)
) ;