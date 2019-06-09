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

CREATE TABLE Days (
  DayID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) NOT NULL,
  Abbreviation varchar(255) NOT NULL
) ;

CREATE TABLE Departments (
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
  REFERENCES Departments(DepartmentID),
  CrossListedCourseID int(11) NOT NULL,
  CrossScheduledCourseID int(11) NOT NULL
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

CREATE TABLE DetailCodes (
  DetailCodeID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) NOT NULL
) ;

CREATE TABLE instructors (
  InstructorID int(11) AUTO_INCREMENT PRIMARY KEY ,
  FirstName varchar(255) NOT NULL,
  MiddleName varchar(255) NOT NULL,
  LastName varchar(255) NOT NULL,
  Number int(11) NOT NULL,
  CourseLoad int(11) NOT NULL
) ;

CREATE TABLE partofterms (
  PartOfTermID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) NOT NULL,
  Abbreviation varchar(255) NOT NULL,
  StartWeek int NOT NULL,
  EndWeek int NOT NULL
) ;

CREATE TABLE roles (
  RoleID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Name varchar(255) DEFAULT NULL,
  IsAdmin bit(1) NOT NULL,
  Sections int(4) NOT NULL,
  Courses int(4) NOT NULL,
  Buildings int(4) NOT NULL,
  Campuses int(4) NOT NULL,
  Roles int(4) NOT NULL,
  Users int(4) NOT NULL,
  Departments int(4) NOT NULL,
  Instructors int(4) NOT NULL,
  Days int(4) NOT NULL,
  Rooms int(4) NOT NULL,
  ScheduleTypes int(4) NOT NULL,
  Spreadsheets int(4) NOT NULL
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
`ScheduleTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Abbreviation` varchar(255) NOT NULL,
  `RequiresRoom` bit(1) NOT NULL,
  `RequiresDays` bit(1) NOT NULL,
  `RequiresTimes` bit(1) NOT NULL,
  PRIMARY KEY (`ScheduleTypeID`)
) ;

CREATE TABLE users (
  UserID int(11) AUTO_INCREMENT PRIMARY KEY ,
  Username varchar(255) NOT NULL,
  Password varchar(255) NOT NULL,
  Salt varchar(255) NOT NULL,
  RoleID int(11) NOT NULL,
  CONSTRAINT RoleToUser FOREIGN KEY (RoleID)
  REFERENCES Roles(RoleID)
) ;

CREATE TABLE spreadsheetvariables (
  SpreadsheetVariablesID int(11) AUTO_INCREMENT PRIMARY KEY ,
  StartingRowNumber int(11) NOT NULL,
  DefaultFontSize int(11) NOT NULL,
  DefaultFontStyle varchar(255) NOT NULL,
  AddChangeDelete varchar(255) NOT NULL,
  AcademicSemester varchar(255) NOT NULL,
  Department varchar(255) NOT NULL,
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
  RequiresPermissionAbbreviation varchar(255) NOT NULL,
  RequiresMoodleAbbreviation varchar(255) NOT NULL,
  PrimaryInstructorFirstName varchar(255) NOT NULL,
  PrimaryInstructorLastName varchar(255) NOT NULL,
  PrimaryInstructorNumber varchar(255) NOT NULL,
  PrimaryInstructorTeachingPercent varchar(255) NOT NULL,
  SecondaryInstructorFirstName varchar(255) NOT NULL,
  SecondaryInstructorLastName varchar(255) NOT NULL,
  SecondaryInstructorNumber varchar(255) NOT NULL,
  SecondaryInstructorTeachingPercent varchar(255) NOT NULL,
  ClassFeeDetailCode varchar(255) NOT NULL,
  ClassFeeAmount varchar(255) NOT NULL,
  SectionNotes varchar(255) NOT NULL,
  CrossListSubject varchar(255) NOT NULL,
  CrossListCourseNumber varchar(255) NOT NULL,
  DepartmentComments varchar(255) NOT NULL,
  FallAbbreviation varchar(255) NOT NULL,
  SummerAbbreviation varchar(255) NOT NULL,
  SpringAbbreviation varchar(255) NOT NULL
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

CREATE TABLE Fees (
  FeeID int(11) AUTO_INCREMENT PRIMARY KEY ,
  DetailCodeID int(11) NOT NULL,
  CONSTRAINT FeeToSection FOREIGN KEY (DetailCodeID)
  REFERENCES DetailCodes(DetailCodeID),
  Amount Float(13,4) DEFAULT NULL
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
  FeeID int(11) NOT NULL,
  PartOfTermID int(11) NOT NULL,
  XListID varchar(255) NOT NULL,
  CrossListedSectionID int(11) NOT NULL,
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

INSERT INTO days (Name, Abbreviation) VALUES
('Monday', 'M'),
('Tuesday', 'T'),
('Wednesday', 'W'),
('Thursday', 'R'),
('Friday', 'F'),
('Saturday', 'S'),
('Sunday', 'U');

INSERT INTO departments (Name, Abbreviation) VALUES
('Accounting', 'ACCT'),
('Finance', 'FIN'),
('Informatics', 'INFO'),
('Computer Science', 'CS'),
('Business Admin', 'BA'),
('Marketing', 'MKTG'),
('Economics', 'ECON'),
('Masters of Business Admin', 'MBA'),
('Management', 'MGT'),
('Health Care Admin', 'HCA');

INSERT INTO DetailCodes (Name) VALUES
('CAC1'),
('IBU'),
('CBA2'),
('CCl1'),
('CCR0'),
('CCI1'),
('CBA0');


INSERT INTO campuses (Name, Abbreviation) VALUES
('Pocatello', 'PC'),
('Idaho Falls', 'IF'),
('Meridian', 'MD');

INSERT INTO buildings (Name, Abbreviation, CampusID) VALUES
('Business Administration', 'BA', 1),
('Rendevous', 'REND', 1),
('Center for Higher Education', 'CHE', 2),
('Tingey Administration', 'TA', 2),
('', 'WEB', 1);

INSERT INTO Rooms (RoomID, Number, SeatsAvailable, Details, BuildingID) VALUES
(1, '407', 38, '', 1),
(2, '506', 48, 'Distance learning\r\nDual projectors\r\nPowered desks', 1),
(3, '267', 0, '', 4),
(4, '412', 48, '', 1),
(5, '503', 48, 'Dual projectors', 1),
(6, '411', 40, '', 1),
(7, '402', 38, '', 1),
(8, '133', 47, '', 1),
(9, '263', 0, '', 4),
(10, '214', 47, '', 1),
(11, '208', 18, '', 1),
(12, '135', 50, '', 1),
(13, '0', 0, '', 5),
(14, '315', 0, '', 2),
(15, '211', 0, '', 3),
(16, '118', 0, '', 2),
(17, '108', 0, '', 2),
(18, '408', 46, '', 1),
(19, '104', 200, '', 1),
(20, '211', 40, '', 1),
(21, '403', 38, '', 1),
(22, '307', 0, '', 3),
(23, '212', 72, '', 1),
(24, '311', 35, '', 1),
(25, '313', 35, '', 1),
(26, '307', 38, '', 1),
(27, '308', 40, '', 1),
(28, '309', 33, '', 1),
(29, '304', 38, '', 1),
(30, '305', 36, '', 1);

INSERT INTO semesters (Name, Abbreviation) VALUES
('Spring', 'AS'),
('Summer', 'ASU'),
('Fall', 'AF');

INSERT INTO AcademicSemesters (SemesterID, AcademicYear) VALUES
(1, 2019),
(3, 2019),
(2, 2019),
(3, 2018);

INSERT INTO `courses` (`CourseID`, `Number`, `Title`, `Description`, `MinimumCredits`, `MaximumCredits`, `FixedCredits`, `IsFixedCredit`, `DepartmentID`, `CrossListedCourseID`, `CrossScheduledCourseID`) VALUES
(1,2201,'Principles of Accounting I','',0,0,3,b'1',1,-1,-1),
(2,2202,'Principles of Accounting II','',0,0,3,b'1',1,-1,-1),
(3,3303,'Accounting Concepts','',0,0,3,b'1',1,-1,-1),
(4,3323,'Intermediate Accounting I','',0,0,3,b'1',1,-1,-1),
(5,3324,'Intermediate Accounting II','',0,0,3,b'1',1,-1,-1),
(6,3331,'Principles of Taxation','',0,0,3,b'1',1,-1,-1),
(7,3332,'Principles of Taxation II','',0,0,3,b'1',1,-1,-1),
(8,3341,'Managerial and Cost Accounting','',0,0,3,b'1',1,-1,-1),
(9,3393,'Accounting Internship','',1,3,0,b'0',1,-1,-1),
(10,3399,'Accounting Data Analytics','',0,0,3,b'1',1,-1,-1),
(11,4403,'Accounting Information Systems','',0,0,3,b'1',1,-1,18),
(12,4425,'Intermediate Accounting III','',0,0,3,b'1',1,-1,-1),
(13,4433,'Legal Environment of Acct','',0,0,3,b'1',1,-1,20),
(14,4456,'Auditing','',0,0,3,b'1',1,-1,21),
(15,4492,'Special Problems in Accounting','',0,0,3,b'1',1,-1,-1),
(16,4493,'Advanced Accounting Internship','',1,3,0,b'0',1,-1,-1),
(17,4499,'Business Advisory Services','',0,0,3,b'1',1,291,284),
(18,5503,'Accounting Information Systems','',0,0,3,b'1',1,-1,11),
(19,5531,'Advanced Tax Concepts','',0,0,3,b'1',1,-1,-1),
(20,5533,'Legal Environment of Acct','',0,0,3,b'1',1,-1,13),
(21,5556,'Auditing','',0,0,3,b'1',1,-1,14),
(22,5561,'Advanced Accounting','',0,0,3,b'1',1,-1,-1),
(23,5571,'Accounting Capstone I','',0,0,1,b'1',1,-1,-1),
(24,5572,'Accounting Capstone 2','',0,0,1,b'1',1,-1,-1),
(25,5573,'Accounting Capstone 3','',0,0,1,b'1',1,-1,-1),
(26,5574,'Accounting Capstone 4','',0,0,1,b'1',1,-1,-1),
(27,5592,'Special Problems Acct','',1,3,0,b'0',1,-1,-1),
(28,5593,'Accounting Internship','',1,3,0,b'0',1,-1,-1),
(30,6631,'Accounting Theory','',0,0,3,b'1',1,-1,-1),
(31,6641,'Tax Individuals and Property','',0,0,3,b'1',1,-1,-1),
(32,6645,'Tax Rsrch Planning and Policy','',0,0,3,b'1',1,-1,-1),
(33,1110,'The World of Business','',0,0,3,b'1',5,-1,-1),
(34,2210,'Professional Development I','',0,0,1,b'1',5,-1,-1),
(35,3310,'Professional Development II','',0,0,1,b'1',5,-1,-1),
(36,1181,'Computer Sci and Programming I','',0,0,3,b'1',4,113,-1),
(37,1337,'System Programming and Assembly','',0,0,3,b'1',4,-1,-1),
(38,2235,'Data Structures and Algorithms','',0,0,3,b'1',4,-1,-1),
(39,3305,'Intro to Computational Theory','',0,0,3,b'1',4,-1,-1),
(40,3316,'Soc Iss and Prof Pract in Comp','',0,0,3,b'1',4,-1,-1),
(41,3321,'Introduction to Software Engineering','',0,0,3,b'1',4,118,-1),
(42,3393,'Computer Science Internship','',1,3,0,b'0',4,-1,-1),
(43,4421,'Software Architecture','',0,0,3,b'1',4,-1,286),
(44,4458,'Computer Graphics','',0,0,3,b'1',4,-1,52),
(45,4470,'Parallel Processing','',0,0,3,b'1',4,-1,53),
(46,4471,'Operating Systems','',0,0,4,b'1',4,-1,-1),
(47,4478,'Machine Learning','',0,0,3,b'1',4,-1,285),
(48,4481,'Compilers','',0,0,3,b'1',4,-1,55),
(49,4488,'Capstone Project','',0,0,3,b'1',4,128,-1),
(50,4499,'Machine Learning/Data Mining','',0,0,3,b'1',4,-1,-1),
(51,5102,'Teach and Learn CS I','',0,0,3,b'1',4,-1,-1),
(52,5558,'Computer Graphics','',0,0,3,b'1',4,-1,44),
(53,5570,'Parallel Processing','',0,0,3,b'1',4,-1,45),
(54,5580,'Theory of Computation','',0,0,3,b'1',4,-1,-1),
(55,5581,'Compilers','',0,0,3,b'1',4,-1,48),
(56,5599,'Machine Learning/Data Mining','',0,0,3,b'1',4,-1,-1),
(57,1100,'Economic Issues','',0,0,3,b'1',7,-1,-1),
(58,2201,'Principles of Macroeconomics','',0,0,3,b'1',7,-1,-1),
(59,2202,'Principles of Microeconomics','',0,0,3,b'1',7,-1,-1),
(60,3301,'Macroeconomic Theory','',0,0,3,b'1',7,-1,-1),
(61,4431,'Money and Banking','',0,0,3,b'1',7,-1,-1),
(62,4438,'Public Finance','',0,0,3,b'1',7,-1,68),
(63,4440,'Healthcare Economics and Policy','',0,0,3,b'1',7,-1,-1),
(64,4485,'Econometrics','',0,0,3,b'1',7,-1,70),
(65,4492,'Spec Prob in Econ','',0,0,3,b'1',7,-1,-1),
(67,5531,'Money and Banking','',0,0,3,b'1',7,-1,-1),
(68,5538,'Public Finance','',0,0,3,b'1',7,-1,62),
(69,5540,'Healthcare Economics and Policy','',0,0,3,b'1',7,-1,-1),
(70,5585,'Econometrics','',0,0,3,b'1',7,-1,64),
(72,1115,'Personal Finance','',0,0,3,b'1',2,-1,-1),
(73,3303,'Financial Concepts','',0,0,3,b'1',2,-1,-1),
(74,3315,'Corporate Financial Management','',0,0,3,b'1',2,-1,-1),
(75,3393,'Finance Internship','',1,3,0,b'0',2,-1,-1),
(76,4405,'Adv Corp Fin Mgt I','',0,0,3,b'1',2,-1,83),
(77,4445,'Real Estate Finance','',0,0,3,b'1',2,-1,84),
(78,4448,'Financial Mgt of Deposit Institut','',0,0,3,b'1',2,-1,85),
(79,4451,'Student-Managed Invst Fund I','',0,0,3,b'1',2,-1,86),
(80,4475,'International Corp Finance','',0,0,3,b'1',2,-1,-1),
(81,4478,'Investments','',0,0,3,b'1',2,-1,88),
(82,4492,'Special Problems in Finance','',0,0,3,b'1',2,-1,-1),
(83,5505,'Adv Corp Fin Mgt','',0,0,3,b'1',2,-1,76),
(84,5545,'Real Estate Finance','',0,0,3,b'1',2,-1,77),
(85,5548,'Financial Mgt of Deposit Institut','',0,0,3,b'1',2,-1,78),
(86,5551,'Student-Managed Invst Fund I','',0,0,3,b'1',2,-1,79),
(87,5575,'International Corp Finance','',0,0,3,b'1',2,-1,-1),
(88,5578,'Investments','',0,0,3,b'1',2,-1,81),
(89,1110,'Intro Allied Hlth Profssns','',0,0,3,b'1',10,-1,-1),
(90,1115,'US Health System','',0,0,3,b'1',10,-1,-1),
(91,3330,'Health Information Systems','',0,0,3,b'1',10,119,-1),
(92,3340,'Healthcare Policy','',0,0,3,b'1',10,-1,-1),
(93,3384,'HR Mgt in Healthcare Orgs','',0,0,3,b'1',10,-1,-1),
(94,4410,'Mgt HCA Providers','',0,0,3,b'1',10,-1,102),
(97,4453,'Healthcare Finance','',0,0,3,b'1',10,-1,105),
(98,4460,'HC Quality and PI','',0,0,3,b'1',10,-1,106),
(99,4475,'Health Law and Bioethics','',0,0,3,b'1',10,-1,107),
(100,4489,'Health Care Info Syst Pract','',0,0,3,b'1',10,-1,-1),
(101,4495,'Administrative Internship','',0,0,4,b'1',10,-1,-1),
(102,5510,'Mgt of HC Provider Orgs','',0,0,3,b'1',10,-1,94),
(104,5540,'Healthcare Econ and Policy','',0,0,3,b'1',10,296,224),
(105,5553,'Healthcare Finance','',0,0,3,b'1',10,-1,97),
(106,5560,'HC Quality and PI','',0,0,3,b'1',10,-1,98),
(107,5575,'Health Law and Bioethics','',0,0,3,b'1',10,-1,99),
(108,5595,'Administrative Internship','',0,0,4,b'1',10,-1,-1),
(109,6650,'Healthcare Leadership and Governance','',0,0,3,b'1',10,-1,-1),
(110,6695,'Healthcare Residency','',0,0,3,b'1',10,-1,-1),
(111,1101,'Digital Information Literacy','',0,0,3,b'1',3,-1,-1),
(112,1150,'Software and Systems Arch','',0,0,3,b'1',3,-1,-1),
(113,1181,'Informatics and Programming I','',0,0,3,b'1',3,36,-1),
(114,1182,'Informatics and Programming II','',0,0,3,b'1',3,-1,-1),
(115,2220,'Web Development Client','',0,0,3,b'1',3,-1,-1),
(116,3301,'Intro Informatics Analytics','',0,0,3,b'1',3,-1,-1),
(117,3303,'Informatics Concepts','',0,0,3,b'1',3,-1,-1),
(118,3307,'Systems Analysis and Design','',0,0,3,b'1',3,41,133),
(119,3330,'Health Informatics','',0,0,3,b'1',3,91,140),
(120,3380,'Networking and Virtualization','',0,0,3,b'1',3,-1,-1),
(121,3393,'Informatics Internship','',1,3,0,b'0',3,-1,-1),
(122,4407,'Database Design Implementation','',0,0,3,b'1',3,-1,134),
(123,4411,'Intermediate Info Assurance','',0,0,3,b'1',3,-1,-1),
(124,4419,'Advanced Informatics Practicum','',1,3,0,b'0',3,-1,-1),
(125,4424,'Healthcare Workflow Process','',0,0,3,b'1',3,-1,141),
(126,4430,'Web Application Development','',0,0,3,b'1',3,-1,142),
(127,4484,'Secure Software Life Cycle Dev','',0,0,3,b'1',3,-1,-1),
(128,4488,'Informatics Senior Project','',0,0,3,b'1',3,49,-1),
(129,4491,'Seminar in Informatics','',0,0,3,b'1',3,-1,-1),
(130,4492,'Special Problems Informatics','',1,3,0,b'0',3,-1,144),
(131,4493,'Advanced Informatics Intern','',0,0,3,b'1',3,-1,-1),
(132,4499,'Data Visualization','',0,0,3,b'1',3,-1,-1),
(133,5307,'Intermediate Systems Analysis','',0,0,3,b'1',3,-1,118),
(134,5507,'Database Design and Implement','',0,0,3,b'1',3,-1,122),
(135,5511,'Intermediate Info Assurance','',0,0,3,b'1',3,-1,-1),
(136,5512,'Systems Security for Sr Mgt','',1,3,0,b'0',3,-1,-1),
(137,5513,'Systems Security Admin','',0,0,1,b'1',3,-1,-1),
(138,5514,'Systems Security Management','',1,3,0,b'0',3,-1,-1),
(139,5519,'Advanced Informatics Practicum','',1,3,0,b'0',3,-1,-1),
(140,5520,'Health Informatics','',0,0,3,b'1',3,-1,119),
(141,5524,'Healthcare Workflow Process','',0,0,3,b'1',3,-1,125),
(142,5530,'Web Application Development','',0,0,3,b'1',3,-1,126),
(143,5584,'Secure Software Life Cyc Dev','',0,0,3,b'1',3,-1,-1),
(144,5592,'Special Problems Informatics','',1,3,0,b'0',3,-1,130),
(145,5599,'Data Visualization','',0,0,3,b'1',3,-1,-1),
(146,6528,'Electronic Health Records','',0,0,3,b'1',3,-1,-1),
(147,6540,'Health Clinical Practicum','',0,0,3,b'1',3,-1,-1),
(148,6660,'Informatics Project','',1,3,0,b'0',3,-1,-1),
(149,6611,'Fin Reporting Managerial Acct','',0,0,3,b'1',8,-1,-1),
(150,6613,'Marketing','',0,0,3,b'1',8,-1,-1),
(151,6620,'Quant Info for Bus Decisions','',0,0,3,b'1',8,-1,-1),
(152,6621,'Managerial Decision-Making','',0,0,3,b'1',8,-1,-1),
(153,6623,'Marketing Management','',0,0,3,b'1',8,-1,-1),
(154,6626,'Business Policy and Strategy','',0,0,3,b'1',8,-1,-1),
(155,6628,'Applied Business Solutions','',0,0,3,b'1',8,-1,-1),
(156,6637,'Intro to Business Analytics','',0,0,3,b'1',8,-1,-1),
(157,6639,'MBA Paper','',0,0,3,b'1',8,-1,-1),
(158,6650,'Thesis','',1,6,0,b'0',8,-1,-1),
(159,6692,'Special Problems in Bus Admin','',0,0,3,b'1',8,-1,-1),
(160,2210,'Beg Entrepreneurship','',0,0,3,b'1',9,-1,167),
(161,2216,'Business Statistics','',0,0,3,b'1',9,-1,-1),
(162,2217,'Advanced Business Statistics','',0,0,3,b'1',9,-1,-1),
(163,2261,'Legal Environment of Orgs','',0,0,3,b'1',9,-1,-1),
(164,3312,'Indiv and Organizational Behav','',0,0,3,b'1',9,-1,-1),
(165,3329,'Operations Production Mgt','',0,0,3,b'1',9,-1,-1),
(166,4410,'Entrepreneurship','',0,0,3,b'1',9,183,-1),
(167,4411,'Sm Bus Entrepreneurship Prac','',0,0,3,b'1',9,184,160),
(168,4441,'Leading in Organizations','',0,0,3,b'1',9,-1,175),
(169,4460,'Strategic Management','',0,0,3,b'1',9,-1,-1),
(170,4473,'Human Resource Management','',0,0,3,b'1',9,225,176),
(171,4480,'Labor and Employment Law','',0,0,3,b'1',9,-1,-1),
(172,4482,'Project Management','',0,0,3,b'1',9,-1,-1),
(173,4492,'Research Methods in Management','',0,0,3,b'1',9,-1,-1),
(174,4499,'Data Visualization','',0,0,3,b'1',9,-1,-1),
(175,5541,'Leading in Organizations','',0,0,3,b'1',9,-1,168),
(176,5573,'Human Resource Management','',0,0,3,b'1',9,-1,170),
(177,5580,'Labor and Employment Law','',0,0,3,b'1',9,-1,-1),
(178,5582,'Project Management','',0,0,3,b'1',9,-1,-1),
(179,5592,'Special Problems in Management','',0,0,3,b'1',9,-1,-1),
(180,5599,'Business Advisory Services','',0,0,3,b'1',9,284,291),
(181,2225,'Principles of Marketing','',0,0,3,b'1',6,-1,-1),
(182,3393,'Marketing Internship','',1,3,0,b'0',6,-1,-1),
(183,4410,'Entrepreneurship','',0,0,3,b'1',6,166,-1),
(184,4411,'Sm Bus Entrepreneurship Prac','',0,0,3,b'1',6,167,-1),
(185,4421,'Services Marketing','',0,0,3,b'1',6,-1,191),
(186,4426,'Marketing Research','',0,0,3,b'1',6,-1,192),
(187,4427,'Consumer Behavior','',0,0,3,b'1',6,-1,193),
(188,4428,'Integrated Brand Promotion','',0,0,3,b'1',6,-1,194),
(189,4480,'Social media marketing','',0,0,3,b'1',6,-1,-1),
(190,4499,'Data Visualization','',0,0,3,b'1',6,-1,-1),
(191,5521,'Services Marketing','',0,0,3,b'1',6,-1,185),
(192,5526,'Marketing Research','',0,0,3,b'1',6,-1,186),
(193,5527,'Consumer Behavior','',0,0,3,b'1',6,-1,187),
(194,5528,'Integrated Brand Promotion','',0,0,3,b'1',6,-1,188),
(195,5580,'Social media marketing','',0,0,3,b'1',6,-1,-1),
(196,4440,'Accounting Practicum','',0,0,3,b'1',1,-1,-1),
(197,4490,'Fin Report and Statmnt Anlys','',0,0,3,b'1',1,-1,199),
(198,5557,'Advanced Auditing','',0,0,3,b'1',1,-1,-1),
(199,5590,'Fin Report and Statement Anlys','',0,0,3,b'1',1,-1,197),
(200,5599,'Fraud Examination','',0,0,3,b'1',1,-1,-1),
(201,6612,'Corporate Taxation II','',0,0,3,b'1',1,-1,-1),
(202,6621,'Partnership Taxation','',0,0,3,b'1',1,-1,-1),
(203,6634,'Seminar in Accounting','',0,0,3,b'1',1,-1,-1),
(204,6648,'Gift and Estate Tax Planning','',0,0,3,b'1',1,-1,-1),
(205,6660,'Acct Govt Non Profit Entities','',0,0,3,b'1',1,-1,-1),
(206,4410,'Professional Development III','',0,0,1,b'1',5,-1,-1),
(207,3302,'Microeconomic Theory','',0,0,3,b'1',7,-1,-1),
(208,3352,'Environmental Economics','',0,0,3,b'1',7,-1,-1),
(209,4433,'Economic Development','',0,0,3,b'1',7,-1,-1),
(210,4474,'Economics Capstone','',0,0,3,b'1',7,-1,212),
(211,4499,'Healthcare Economics and Policy','',0,0,3,b'1',7,-1,296),
(212,5574,'ST:Economics Capstone','',0,0,3,b'1',7,-1,210),
(213,5599,'Healthcare Economics and Policy','',0,0,3,b'1',7,-1,295),
(214,4452,'Student Investment Fund II','',0,0,3,b'1',2,-1,217),
(215,4464,'Entrepreneurial Finance','',0,0,3,b'1',2,-1,218),
(216,4493,'Advanced Finance Internship','',0,0,3,b'1',2,-1,-1),
(217,5552,'Student-Managed Inv Fund II','',0,0,3,b'1',2,-1,214),
(218,5564,'Entrepreneurial Finance','',0,0,3,b'1',2,-1,215),
(219,5592,'Special Problems in Finance','',0,0,3,b'1',2,-1,-1),
(220,2215,'Healthcare Leadership','',0,0,3,b'1',10,-1,-1),
(221,4415,'Physician Practice Management','',0,0,3,b'1',10,-1,227),
(222,4417,'HCA Mgt Epidemiology Pop','',0,0,3,b'1',10,-1,228),
(223,4420,'The Business of Healthcare','',0,0,3,b'1',10,-1,229),
(224,4440,'Healthcare Economics and Policy','',0,0,3,b'1',10,295,104),
(225,4473,'Healthcare Str Plan Marketing','',0,0,3,b'1',10,170,231),
(226,4480,'Long-Term Care Management','',0,0,3,b'1',10,-1,232),
(227,5515,'Physician Practice Management','',0,0,3,b'1',10,-1,221),
(228,5517,'Managerial Epidemiology','',0,0,3,b'1',10,-1,222),
(229,5520,'The Business of Healthcare','',0,0,3,b'1',10,-1,223),
(230,5565,'Health Care Operations Quality','',0,0,3,b'1',10,-1,-1),
(231,5573,'HC Strategic Plng Mktg','',0,0,3,b'1',10,-1,225),
(232,5599,'Long Term Care Management','',0,0,3,b'1',10,-1,226),
(234,4422,'Health Information Governance','',0,0,3,b'1',3,-1,237),
(235,4426,'Health Data Analytics','',0,0,3,b'1',3,-1,238),
(236,4482,'Syst Dev Implementation Method','',0,0,3,b'1',3,-1,239),
(237,5522,'Health Information Governance','',0,0,3,b'1',3,-1,234),
(238,5526,'Health Data Analytics','',0,0,3,b'1',3,-1,235),
(239,5582,'Systems Dev Implement Methods','',0,0,3,b'1',3,-1,236),
(240,5593,'Informatics Internship','',1,3,0,b'0',3,-1,-1),
(241,3310,'Intro to Information Assurance','',0,0,3,b'1',3,-1,-1),
(242,4499,'Computer Forensics Essentials','',0,0,3,b'1',3,-1,-1),
(243,4499,'Proj Based Software Syst Study','',0,0,3,b'1',3,-1,-1),
(244,4499,'SCADA Management and Lab','',0,0,1,b'1',3,-1,-1),
(245,4499,'CyberWar and Intel Community','',0,0,3,b'1',3,-1,-1),
(246,5515,'System Certification','',0,0,3,b'1',3,-1,-1),
(247,5516,'Risk Analysis','',0,0,3,b'1',3,-1,-1),
(248,5517,'Information Assurance Engineer','',0,0,3,b'1',3,-1,-1),
(249,5571,'Computer Forensics Essentials','',0,0,3,b'1',3,-1,-1),
(250,5574,'SCADA Management and Lab','',0,0,1,b'1',3,-1,-1),
(251,5587,'Software Systems Study','',0,0,3,b'1',3,-1,-1),
(252,5599,'CyberWar and Intel Community','',0,0,3,b'1',3,-1,-1),
(253,4499,'Cases in Industrial Control System Security','',0,0,3,b'1',3,-1,-1),
(254,5599,'Cases in Industrial Control System Security','',0,0,3,b'1',3,-1,-1),
(255,6610,'Applied Economics','',0,0,3,b'1',8,-1,-1),
(256,6612,'Human Behavior Organizations','',0,0,3,b'1',8,-1,-1),
(257,6614,'Operations Management','',0,0,3,b'1',8,-1,-1),
(258,6615,'Finance','',0,0,3,b'1',8,-1,-1),
(259,6622,'Financial Management','',0,0,3,b'1',8,-1,-1),
(260,6624,'Information Systems Business','',0,0,3,b'1',8,-1,-1),
(261,6699,'Pharmacy Business Plan','',0,0,3,b'1',8,-1,-1),
(262,3393,'Management Internship','',1,3,0,b'0',9,-1,-1),
(263,4434,'Productivity and Quality','',0,0,3,b'1',9,-1,269),
(264,4461,'Business Law','',0,0,3,b'1',9,-1,271),
(265,4462,'Issues In Business and Society','',0,0,3,b'1',9,-1,272),
(266,4474,'Adv Human Resource Mgt','',0,0,3,b'1',9,-1,273),
(267,4493,'Advanced Management Internship','',0,0,3,b'1',9,-1,-1),
(268,4499,'Business Simulation','',0,0,3,b'1',9,-1,-1),
(269,5534,'Productivity and Quality','',0,0,3,b'1',9,-1,263),
(271,5561,'Business Law','',0,0,3,b'1',9,-1,264),
(272,5562,'Issues in Business and Society','',0,0,3,b'1',9,-1,265),
(273,5574,'Adv Human Resource Mgt','',0,0,3,b'1',9,-1,266),
(274,5584,'International Collegiate Business Strategy Competition','',0,0,3,b'1',9,-1,-1),
(275,2225,'Basic Marketing Management','',0,0,3,b'1',6,-1,-1),
(276,4432,'New Product Management','',0,0,3,b'1',6,-1,281),
(277,4480,'Marketing on the Internet','',0,0,3,b'1',6,-1,282),
(278,4492,'Special Problems in Marketing','',0,0,3,b'1',6,-1,-1),
(279,4493,'Advanced Marketing Internship','',0,0,3,b'1',6,-1,-1),
(280,4499,'Nonprofit Marketing','',0,0,3,b'1',6,-1,-1),
(281,5532,'New Product Management','',0,0,3,b'1',6,-1,276),
(282,5580,'Marketing on the Internet','',0,0,3,b'1',6,-1,277),
(283,4492,'Special Topics in Computer Graphics','',0,0,3,b'1',4,-1,-1),
(284,5599,'Business Advisory Services','',0,0,3,b'1',1,180,17),
(285,5599,'Machine Learning','',0,0,3,b'1',4,-1,47),
(286,5599,'Software Architecture','',0,0,3,b'1',4,-1,43),
(287,4499,'Behavioral Economics','',0,0,3,b'1',7,-1,-1),
(288,5599,'Behavioral Economics','',0,0,3,b'1',7,-1,-1),
(289,4499,'Intermediate Non-proliferation','',0,0,3,b'1',3,-1,-1),
(290,5599,'Intermediate Non-proliferation','',0,0,3,b'1',3,-1,-1),
(291,4499,'Business Advisory Services','',0,0,3,b'1',9,17,180),
(292,4499,'Collaborative Creativity','',0,0,3,b'1',9,-1,294),
(293,5599,'','',0,0,3,b'1',9,-1,-1),
(294,5599,'Collaborative Creativity','',0,0,3,b'1',9,-1,292),
(295,4499,'Healthcare Economics and Polic','',0,0,3,b'1',7,224,296),
(296,5599,'Healthcare Economics and Polic','',0,0,3,b'1',7,104,295),
(297,5599,'Long Term Care Managment','',0,0,3,b'1',10,-1,-1),
(298,5599,'Data Visualization','',0,0,3,b'1',9,-1,-1),
(299,5599,'Data Visualization','',0,0,3,b'1',6,-1,-1);


INSERT INTO Instructors (InstructorID, FirstName, MiddleName, LastName, Number, CourseLoad) VALUES
(1, 'Justin', '', 'Wood', 903511, 0),
(2, 'Michele', '', 'O Brien-Rose', 842313, 0),
(3, 'Robert', '', 'Picard', 73654, 0),
(4, 'Jerry', '', 'Leffler', 32919, 0),
(5, 'Dawn', '', 'Konicek', 799901, 0),
(6, 'Jason', '', 'Chen', 903611, 0),
(7, 'Ramon', '', 'Rodriguez', 903140, 0),
(8, 'Marcus', '', 'Burger', 890705, 0),
(9, 'Dave', '', 'Bagley', 826057, 0),
(10, 'Brandon', '', 'Carpenter', 0, 0),
(11, 'Jonathan', '', 'Holmes', 163604, 0),
(12, 'David', '', 'Beard', 0, 0),
(13, 'Michael', '', 'McGregor', 215125, 0),
(14, 'Robert', '', 'Howe', 0, 0),
(15, 'Paul', '', 'Bodily', 0, 0),
(16, 'Isaac', '', 'Griffith', 0, 0),
(17, 'Robert', '', 'Houghton', 860821, 0),
(18, 'Iris', '', 'Buder', 892363, 0),
(19, 'Karl', '', 'Geisler', 926525, 0),
(20, 'Scott', '', 'Benson', 0, 0),
(21, 'Jason', '', 'Hansen', 87742, 0),
(22, 'Tesa', '', 'Stegner', 86804, 0),
(23, 'Fred', '', 'Parrish', 92153, 0),
(24, 'Steven', '', 'Byers', 107286, 0),
(25, 'Jeffrey', '', 'Brookman', 204825, 0),
(26, 'Ken', '', 'Khang', 174519, 0),
(27, 'Joshua', '', 'Thompson', 59849, 0),
(28, 'Ruiling', '', 'Guo', 165340, 0),
(29, 'Velma', '', 'Payne', 915828, 0),
(30, 'Tracy', '', 'Farnsworth', 205147, 0),
(31, 'Douglas', '', 'Crabtree', 0, 0),
(32, 'John', '', 'Abreu', 908585, 0),
(33, 'Robert', '', 'Cuoio', 0, 0),
(34, 'Ann', '', 'Nevers', 0, 0),
(35, 'Tony', '', 'Lovgren', 21432, 0),
(36, 'Frankie', '', 'Adams', 0, 0),
(37, 'Thomas', '', 'Ottaway', 141430, 0),
(38, 'Larry', '', 'Leibrock', 867527, 0),
(39, 'Corey', '', 'Schou', 107683, 0),
(40, 'Sandra', '', 'Speck', 184988, 0),
(41, 'Alexander', '', 'Bolinger', 105613, 0),
(42, 'Gregory', '', 'Murphy', 216222, 0),
(43, 'Neil', '', 'Tocher', 204198, 0),
(44, 'Teri', '', 'Peterson', 68885, 0),
(45, 'Kerry', '', 'Casperson', 0, 0),
(46, 'Jeff', '', 'Street', 199919, 0),
(47, 'Julie', '', 'Frischmann', 0, 0),
(48, 'Norman', '', 'Smith', 0, 0),
(49, 'Yan', '', 'Chen', 927670, 0),
(50, 'Larry', '', 'Cravens', 0, 0),
(51, 'Tyler', '', 'Burch', 891483, 0),
(52, 'Dennis', '', 'Krumwiede', 131014, 0),
(53, 'Stacy', '', 'Gibson', 0, 0),
(54, 'Stacey', '', 'gibson', 0, 0),
(55, 'Alexander', '', 'Rose', 915088, 0),
(56, 'Nicole', '', 'Hanson', 915959, 0),
(57, 'John', '', 'Ney', 138193, 0),
(58, 'Allen', '', 'Claudia', 153607, 0),
(59, 'Mark', '', 'Arstein', 4714, 0),
(61, 'Dan', '', 'Cravens', 817704, 0),
(63, 'Ann', '', 'Hackert', 107732, 0),
(64, 'Kelli', '', 'Horrocks', 0, 0),
(66, 'Dave', '', 'O Connell', 196615, 0),
(67, 'Kevin', '', 'Parker', 120650, 0),
(68, 'Suzette', '', 'Porter', 134196, 0),
(69, 'Sue', '', 'Schou', 71369, 0),
(70, 'Ann', '', 'Swanson', 185613, 0),
(71, 'Robert', '', 'Tokle', 107292, 0),
(72, 'Kelsey', '', 'West', 218715, 0),
(73, 'Justin', '', 'Johnson', 709299, 0),
(74, 'Sariah', '', 'Millis', 856450, 0),
(75, 'Randy', '', 'Smith', 116638, 0);

INSERT INTO partofterms (Name, Abbreviation, StartWeek, EndWeek) VALUES
('Full','Full',1,16),
('Early 4','E4',1,4),
('Early 6','E6',1,6),
('Early 8','E8',1,8),
('Middle 4','M4',5,8),
('Late 8','L8',9,16),
('Late 6','L6',7,12),
('Late 4','L4',9,12);

INSERT INTO roles (Name, IsAdmin, Sections, Courses, Buildings, Campuses, Roles, Users, Departments, Instructors, Days, Rooms, ScheduleTypes, Spreadsheets) VALUES
('Admin', b'1', 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15),
('Basic', b'0', 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);

INSERT INTO users (UserID, Username, Password, RoleID, Salt) VALUES
(1, 'Admin', '1H2GcQC8gZsVkd0K1HQSb8mSN0dqp10sV8db6zKbMeF47+SF97Sql/xAXlfZvcN3', 1, '//J+U1wypDjzUkFHZg4l7rXVUlqi2Z8Alge7nqkStxDgridk8Z');

INSERT INTO scheduletypes (Name, Abbreviation, RequiresRoom, RequiresDays, RequiresTimes) VALUES
('Standard Lecture','CL',b'1',b'1',b'1'),
('Labratory','LB',b'1',b'1',b'1'),
('Distance Learning','DL',b'1',b'1',b'1'),
('Thesis, Dissertation, Practicum - Does not require a room/not online','OT',b'0',b'0',b'0'),
('Asynchronous Online available anytime','AO',b'0',b'0',b'0'),
('Synchronous Online available at certain times','SO',b'0',b'1',b'1'),
('Blended Online (reduced seat time with less than 40% online components','BL',b'1',b'0',b'0'),
('Mostly Online (Online with up to five on-campus meetings required)','OL',b'1',b'0',b'0'),
('Distance Learning / Supplemented(Delivered to multiple campuses)','VS',b'1',b'1',b'1');

INSERT INTO spreadsheetvariables (SpreadsheetVariablesID, StartingRowNumber, DefaultFontSize, DefaultFontStyle, AddChangeDelete, AcademicSemester, Department, SectionCRN, CourseNumber, SectionNumber, CrossListID, CourseTitle, Campus, ScheduleType, MoodleRequired, InstructorApprovalRequired, PartOfTerm, FixedCredit, MinimumCredits, MaximumCredits, ClassLimit, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday, StartTime, EndTime, Building, Room, RequiresPermissionAbbreviation, RequiresMoodleAbbreviation, PrimaryInstructorFirstName, PrimaryInstructorLastName, PrimaryInstructorNumber, PrimaryInstructorTeachingPercent, SecondaryInstructorFirstName, SecondaryInstructorLastName, SecondaryInstructorNumber, SecondaryInstructorTeachingPercent, ClassFeeDetailCode, ClassFeeAmount, SectionNotes, CrossListSubject, CrossListCourseNumber, DepartmentComments, FallAbbreviation, SummerAbbreviation, SpringAbbreviation) VALUES
(1, 4, 11, 'Calibri', 'B', 'A', 'D', 'C', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'IN', 'M', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AL', 'AM', 'AN', 'AO', 'AP', 'AF', 'ASU', 'AS');

--
-- Database: `db_a41845_sched`
--

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

CREATE PROCEDURE deleteChangeLog (IN `i_ChangeLogID` INT)  
BEGIN
  DELETE FROM ChangeLogs
  WHERE ChangeLogID = i_ChangeLogID;
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
  DELETE FROM PartOfTerms
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

CREATE PROCEDURE deleteSectionDay (IN `i_SectionDayID` INT)  
BEGIN
  DELETE FROM SectionDays 
  WHERE SectionDayID = i_SectionDayID;
END //

CREATE PROCEDURE deleteDetailCode (IN `i_Name` INT)  
BEGIN
    DELETE FROM DetailCodes 
    WHERE Name = i_Name;
END //

CREATE PROCEDURE deleteSemester (IN `i_SemesterID` INT)  
BEGIN
    DELETE FROM Semesters 
    WHERE SemesterID = i_SemesterID;
END //

CREATE PROCEDURE deleteSpreadsheetVariable (IN `i_spreadsheetvariablesID` INT)  
BEGIN
  DELETE FROM SpreadsheetVariables 
  WHERE SpreadsheetVariablesID = i_spreadsheetvariablesID;
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
  SELECT * FROM AcademicSemesters
    ORDER BY AcademicYear DESC;
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

CREATE PROCEDURE getCourseByDepartmentAndNumber (IN `i_DepartmentAbbreviation` VARCHAR(255), IN `i_Number` INT)  
BEGIN
  SELECT * FROM Courses c
	JOIN Departments d ON c.DepartmentID = d.DepartmentID
    WHERE d.Abbreviation = i_DepartmentAbbreviation AND c.Number = i_Number;
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
  SELECT * FROM Departments
  ORDER BY Abbreviation;
END //

CREATE PROCEDURE getDetailCodeByName (IN `i_Name` VARCHAR(255))  
BEGIN
  SELECT * FROM DetailCodes 
  WHERE Name = i_Name;
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
  SELECT * FROM Instructors
  ORDER BY FirstName, LastName;
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

CREATE PROCEDURE getInstructorToSectionsByAcademicSemesterID(IN `i_AcademicSemesterID` INT)
BEGIN
SELECT * FROM InstructorToSections as InstSec
	JOIN Sections as s ON InstSec.SectionID = s.SectionID
    WHERE s.AcademicSemesterID = i_AcademicSemesterID;
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
  SELECT * FROM PartOfTerms;
END //

CREATE PROCEDURE getPartOfTermByAbbreviation (IN `abbreviation` VARCHAR(255))  
BEGIN
  SELECT * FROM PartOfTerms
  WHERE Abbreviation = abbreviation;
END //

CREATE PROCEDURE getPartOfTermByID (IN `i_PartOfTermID` INT)  
BEGIN
  SELECT * FROM PartOfTerms 
  WHERE PartOfTermID = i_PartOfTermID;
END //

CREATE PROCEDURE getPartOfTerms ()  
BEGIN
  SELECT * FROM PartOfTerms;
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
  SELECT * FROM Rooms AS r
  JOIN Buildings AS b ON b.BuildingID = r.BuildingID
  ORDER BY b.Abbreviation, r.Number;
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

CREATE PROCEDURE getDetailCodeByID (IN `i_DetailCodeID` INT)  
BEGIN
	SELECT * FROM DetailCodes 
    WHERE DetailCodeID = i_DetailCodeID; 
END //

CREATE PROCEDURE getDetailCodes ()  
BEGIN
	SELECT * FROM DetailCodes;
END //

CREATE PROCEDURE getFeeByDetailCodeAndAmount (IN `i_DetailCodeID` INT, IN `i_Amount` FLOAT)  
BEGIN
	SELECT * FROM Fees 
    WHERE DetailCodeID = i_DetailCodeID AND Amount = i_Amount; 
END //

CREATE PROCEDURE getSections ()  
BEGIN
  SELECT * FROM Sections;
END //

CREATE PROCEDURE getSectionsByAcademicSemesterID (IN `i_academicsemesterID` INT, IN `i_GetDeleted` BIT)  
BEGIN
IF i_GetDeleted THEN
  SELECT * FROM Sections AS s
	JOIN Courses AS c ON c.CourseID = s.CourseID
	JOIN Departments AS d ON d.DepartmentID = c.DepartmentID
	WHERE AcademicSemesterID = i_academicsemesterID AND DateArchived > NOW()
	ORDER BY d.Abbreviation, c.Number, s.Number;
  END IF;
  IF NOT i_GetDeleted THEN
	SELECT * FROM Sections AS s
	JOIN Courses AS c ON c.CourseID = s.CourseID
	JOIN Departments AS d ON d.DepartmentID = c.DepartmentID
    WHERE AcademicSemesterID = i_academicsemesterID AND DateArchived > NOW() AND DateDeleted > NOW()
	ORDER BY d.Abbreviation, c.Number, s.Number;
	END IF;
END //

CREATE PROCEDURE getSectionsByCourseID (IN `i_CourseID` INT)  
BEGIN
    SELECT * FROM Sections
	WHERE CourseID = i_CourseID AND DateArchived > NOW() AND DateDeleted > NOW()
	ORDER BY Number;
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

CREATE PROCEDURE getSpreadsheetVariablesByID (IN `i_spreadsheetvariablesID` INT)  
BEGIN
  SELECT * FROM SpreadsheetVariables 
  WHERE SpreadsheetVariablesID = i_spreadsheetvariablesID;
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

CREATE PROCEDURE getUserByUsername (IN `i_Username` VARCHAR(255))
BEGIN
	SELECT * FROM Users WHERE Username = i_Username;
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
IN `i_changedsectionnotes` BIT, IN `i_changedcrosslistedDepartment` BIT, IN `i_changedcrosslistedsection` BIT, IN `i_changeddepartmentcomments` BIT, 
OUT `i_ChangeLogID` INT, IN `i_DateImported` DATETIME, IN `i_DateCreated` DATETIME, IN `i_DateDeleted` DATETIME)  
BEGIN
	INSERT INTO ChangeLogs (SectionID, ChangedDepartment, ChangedCourseNumber, ChangedSectionNumber, ChangedTitle, 
	ChangedCampus, ChangedScheduleType, ChangedRequiresMoodle, ChangedRequiresPermission, ChangedPartOfTerm, 
	ChangedStudentLimit, ChangedCreditMax, ChangedCreditMin, ChangedFixedCredit, ChangedMonday, ChangedTuesday, 
	ChangedWednesday, ChangedThursday, ChangedFriday, ChangedSaturday, ChangedSunday, ChangedStartTime, ChangedEndTime, 
	ChangedBuilding, ChangedRoom, ChangedPrimeInstructor, ChangedPrimeInstructorPercent, ChangedSecondInstructor, 
	ChangedSecondInstructorPercent, ChangedSectionNotes, ChangedCrossListedDepartment, ChangedCrossListedSection, 
	ChangedDepartmentComments, DateImported, DateCreated, DateDeleted) 
	VALUES (i_sectionID, i_changedDepartment, i_changedcoursenumber, i_changedsectionnumber, i_changedtitle, i_changedcampus, 
	i_changedscheduletype, i_changedrequiresmoodle, i_changedrequirespermission, i_changedpartofterm, i_changedstudentlimit, 
	i_changedcreditmax, i_changedcreditmin, i_changedfixedcredit, i_changedmonday, i_changedtuesday, i_changedwednesday, 
	i_changedthursday, i_changedfriday, i_changedsaturday, i_changedsunday, i_changedstarttime, i_changedendtime, 
	i_changedbuilding, i_changedroom, i_changedprimeinstructor, i_changedprimeinstructorpercent, i_changedsecondinstructor, 
	i_changedsecondinstructorpercent, i_changedsectionnotes, i_changedcrosslistedDepartment, i_changedcrosslistedsection, 
	i_changeddepartmentcomments, i_DateImported, i_DateCreated, i_DateDeleted);
	SET i_ChangeLogID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertCourse (IN `i_number` INT, IN `i_title` VARCHAR(255), IN `i_minimumcredits` INT, IN `i_maximumcredits` INT, IN `i_fixedcredits` INT, 
IN `i_isfixedcredit` BIT, IN `i_DepartmentID` INT, IN `i_CrossListedCourseID` INT, IN `i_CrossScheduledCourseID` INT,IN `i_Description` VARCHAR(255), OUT `i_CourseID` INT)  
BEGIN
	INSERT INTO Courses (Number, Title, MinimumCredits, MaximumCredits, FixedCredits, IsFixedCredit, DepartmentID, CrossListedCourseID, CrossScheduledCourseID, Description) 
    VALUES (i_number, i_title, i_minimumcredits, i_maximumcredits, i_fixedcredits, i_isfixedcredit, i_DepartmentID, i_CrossListedCourseID, i_CrossScheduledCourseID, i_Description);
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

CREATE PROCEDURE insertFee (IN `i_DetailCodeID` int, IN `i_Amount` FLOAT, OUT `i_FeeID` INT)  
BEGIN
  INSERT INTO Fees (DetailCodeID, Amount) 
  VALUES (i_DetailCodeID, i_Amount);
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

CREATE PROCEDURE insertPartOfTerm (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), IN `i_StartWeek` INT(11), IN `i_EndWeek` INT(11), OUT `i_PartOfTermID` INT)
BEGIN
  INSERT INTO PartOfTerm (Name, Abbreviation, StartWeek, EndWeek) 
  VALUES (i_Name, i_Abbreviation, i_StartWeek, i_EndWeek);
  SET i_PartOfTermID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertRole(IN i_Name VARCHAR(255), IN i_IsAdmin BIT(1), IN i_Sections INT(4), IN i_Courses INT(4), IN i_Buildings INT(4), 
IN i_Campuses INT(4), IN i_Roles INT(4), IN i_Users INT(4), IN i_Days INT(4), IN i_Rooms INT(4), IN i_ScheduleTypes INT(4), 
IN i_Spreadsheets INT(4), OUT i_RoleID INT, IN i_Departments INT(4), IN i_Instructors INT(4))
BEGIN
  INSERT INTO Roles (Name, IsAdmin, Sections, Courses, Buildings, Campuses, Roles, Users, Days, Departments, Instructors, Rooms, ScheduleTypes, Spreadsheets) 
  VALUES (i_Name, i_IsAdmin, i_Sections, i_Courses, i_Buildings, i_Campuses, i_Roles, i_Users, i_Days, i_Departments, i_Instructors, i_Rooms, 
  i_ScheduleTypes, i_Spreadsheets);
  SET i_RoleID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertRoom (IN `i_Number` VARCHAR(255), IN `i_SeatsAvailable` INT, IN `i_Details` VARCHAR(255), IN `i_BuildingID` INT, OUT `i_RoomID` INT)  
BEGIN
  INSERT INTO Rooms (Number, SeatsAvailable, Details, BuildingID) 
  VALUES (i_Number, i_SeatsAvailable, i_Details, i_BuildingID);
  SET i_RoomID = LAST_INSERT_ID();
END //

CREATE PROCEDURE `insertScheduleType`(IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), IN `i_RequiresRoom` bit(1), IN `i_RequiresDays` bit(1), IN `i_RequiresTimes` bit(1), OUT `i_ScheduleTypeID` INT)
BEGIN
  INSERT INTO ScheduleTypes (Name, Abbreviation, RequiresRoom, RequiresDays, RequiresTimes) 
  VALUES (i_Name, i_Abbreviation, i_RequiresRoom, i_RequiresDays, i_RequiresTimes);
  SET i_ScheduleTypeID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertSection (IN `i_crn` INT, IN `i_requiresmoodle` BIT, IN `i_requirespermission` BIT, IN `i_notes` VARCHAR(255), 
IN `i_departmentcomments` VARCHAR(255), IN `i_studentlimit` INT, IN `i_datecreated` DATETIME, IN `i_datearchived` DATETIME, IN `i_number`  VARCHAR(255), 
IN `i_starttime` DATETIME, IN `i_endtime` DATETIME, IN `i_courseID` INT, IN `i_roomID` INT, IN `i_scheduletypeID` INT, IN `i_academicsemesterID` INT, 
IN `i_partoftermID` INT, IN `i_FeeID` INT, OUT `i_SectionID` INT, IN `i_DateDeleted` DATETIME,  IN `i_CrossListedSectionID` INT, IN `i_XListID` VARCHAR(255))  
BEGIN
  INSERT INTO Sections (CRN, RequiresMoodle, RequiresPermission, Notes, DepartmentComments, StudentLimit, DateCreated, DateArchived, DateDeleted, 
  Number, StartTime, EndTime, CourseID, RoomID, ScheduleTypeID, AcademicSemesterID, PartOfTermID, XListID, FeeID, CrossListedSectionID) 
  VALUES (i_crn, i_requiresmoodle, i_requirespermission, i_notes, i_departmentcomments, i_studentlimit, i_datecreated, i_datearchived, 
  i_DateDeleted, i_number, i_starttime, i_endtime, i_courseID, i_roomID, i_scheduletypeID, i_academicsemesterID, i_partoftermID, i_XListID, i_FeeID,
  i_CrossListedSectionID);
  SET i_SectionID = LAST_INSERT_ID();
END //

CREATE PROCEDURE insertSectionDay (IN `i_DayID` INT, IN `i_SectionID` INT, IN `i_DateArchived` DATETIME, OUT `i_SectionDayID` INT)  
BEGIN
    INSERT INTO SectionDays (SectionID, DayID, DateArchived) 
    VALUES (i_SectionID, i_DayID, i_DateArchived);
    SET i_SectionDayID = last_insert_id();
END //

CREATE PROCEDURE insertDetailCode (IN `i_Name` nvarchar(255), OUT `i_DetailCodeID` INT)  
BEGIN
    INSERT INTO DetailCodes (Name) 
    VALUES (i_Name);
    SET i_DetailCodeID = last_insert_id();
END //

CREATE PROCEDURE insertSemester (IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), OUT `i_SemesterID` INT)  
BEGIN
    INSERT INTO Semesters (Name, Abbreviation) 
    VALUES (i_Name, i_Abbreviation);
    SET i_SemesterID = last_insert_id();
END //

CREATE PROCEDURE insertSpreadsheetVariables (IN `i_startingrownumber` INT, IN `i_defaultfontsize` INT, IN `i_defaultfontstyle` VARCHAR(255), IN `i_academicsemester` VARCHAR(255), 
IN `i_addchangedelete` VARCHAR(255), IN `i_sectioncrn` VARCHAR(255), IN `i_Department` VARCHAR(255), IN `i_coursenumber` VARCHAR(255), IN `i_FallAbbreviation` VARCHAR(255), 
IN `i_SummerAbbreviation` VARCHAR(255), IN `i_SpringAbbreviation` VARCHAR(255), IN `i_sectionnumber` VARCHAR(255), IN `i_crosslistid` VARCHAR(255), IN `i_coursetitle` VARCHAR(255), 
IN `i_campus` VARCHAR(255), IN `i_scheduletype` VARCHAR(255), IN `i_moodlerequired` VARCHAR(255), IN `i_instructorapprovalrequired` VARCHAR(255), 
IN `i_partofterm` VARCHAR(255), IN `i_fixedcredit` VARCHAR(255), IN `i_minimumcredits` VARCHAR(255), IN `i_maximumcredits` VARCHAR(255), IN `i_classlimit` VARCHAR(255), 
IN `i_monday` VARCHAR(255), IN `i_tuesday` VARCHAR(255), IN `i_wednesday` VARCHAR(255), IN `i_thursday` VARCHAR(255), IN `i_friday` VARCHAR(255), 
IN `i_saturday` VARCHAR(255), IN `i_sunday` VARCHAR(255), IN `i_starttime` VARCHAR(255), IN `i_endtime` VARCHAR(255), IN `i_building` VARCHAR(255), 
IN `i_room` VARCHAR(255), IN `i_primaryinstructorfirstname` VARCHAR(255), IN `i_primaryinstructorlastname` VARCHAR(255), IN `i_primaryinstructornumber` VARCHAR(255), 
IN `i_primaryinstructorteachingpercent` VARCHAR(255), IN `i_secondaryinstructorfirstname` VARCHAR(255), IN `i_secondaryinstructorlastname` VARCHAR(255), 
IN `i_secondaryinstructornumber` VARCHAR(255), IN `i_secondaryinstructorteachingpercent` VARCHAR(255), IN `i_classfeedetailcode` VARCHAR(255), 
IN `i_classfeeamount` VARCHAR(255), IN `i_sectionnotes` VARCHAR(255), IN `i_crosslistsubject` VARCHAR(255), IN `i_crosslistcoursenumber` VARCHAR(255), 
IN `i_departmentcomments` VARCHAR(255),IN `i_RequiresMoodleAbbreviation` VARCHAR(255), IN `i_RequiresPermissionAbbreviation` VARCHAR(255), 
OUT `i_SpreadSheetVariablesID` INT)  
BEGIN
  INSERT INTO SpreadsheetVariables (StartingRowNumber, DefaultFontSize, DefaultFontStyle, AcademicSemester, AddChangeDelete, SectionCRN, Department, CourseNumber, 
  FallAbbreviation, SummerAbbreviation, SpringAbbreviation, SectionNumber, CrossListID, CourseTitle, Campus, ScheduleType, MoodleRequired, InstructorApprovalRequired, 
  PartOfTerm, FixedCredit, MinimumCredits, MaximumCredits, ClassLimit, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday, StartTime, EndTime, 
  Building, Room, PrimaryInstructorFirstName, PrimaryInstructorLastName, PrimaryInstructorNumber, PrimaryInstructorTeachingPercent, SecondaryInstructorFirstName, 
  SecondaryInstructorLastName, SecondaryInstructorNumber, SecondaryInstructorTeachingPercent, ClassFeeDetailCode, ClassFeeAmount, SectionNotes, CrossListSubject, 
  CrossListCourseNumber, DepartmentComments, RequiresPermissionAbbreviation, RequiresMoodleAbbreviation) 
  VALUES (i_startingrownumber, i_defaultfontsize, i_defaultfontstyle, i_academicsemester, i_addchangedelete, i_sectioncrn, i_Department, i_coursenumber, 
  i_FallAbbreviation, i_SummerAbbreviation, i_SpringAbbreviation, i_sectionnumber, i_crosslistid, i_coursetitle, i_campus, i_scheduletype, i_moodlerequired, 
  i_instructorapprovalrequired, i_partofterm, i_fixedcredit, i_minimumcredits, i_maximumcredits, i_classlimit, i_monday, i_tuesday, i_wednesday, i_thursday, 
  i_friday, i_saturday, i_sunday, i_starttime, i_endtime, i_building, i_room, i_primaryinstructorfirstname, i_primaryinstructorlastname, i_primaryinstructornumber,
  i_primaryinstructorteachingpercent, i_secondaryinstructorfirstname, i_secondaryinstructorlastname, i_secondaryinstructornumber, 
  i_secondaryinstructorteachingpercent, i_classfeedetailcode, i_classfeeamount, i_sectionnotes, i_crosslistsubject, 
  i_crosslistcoursenumber, i_departmentcomments, i_RequiresPermissionAbbreviation, i_RequiresMoodleAbbreviation);
  SET i_SpreadSheetVariablesID = last_insert_id();
END //

CREATE PROCEDURE insertUser (IN `i_RoleID` INT, IN `i_Username` VARCHAR(255), IN `i_Salt` VARCHAR(255), IN `i_Password` VARCHAR(255), OUT `i_UserID` INT)  
BEGIN
    INSERT INTO Users (Username, Password, RoleID, Salt) 
    VALUES (i_Username, i_Password, i_RoleID, i_Salt);
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
IN `i_changedsecondinstructorpercent` BIT, IN `i_changedsectionnotes` BIT, IN `i_changedcrosslisteddepartment` BIT, 
IN `i_changedcrosslistedsection` BIT, IN `i_changeddepartmentcomments` BIT, IN `i_DateCreated` DATETIME, IN `i_DateImported` DATETIME, 
IN `i_DateDeleted` DATETIME)  
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
	ChangedSectionNotes = i_changedsectionnotes,ChangedCrossListedDepartment = i_changedcrosslistedDepartment, 
	ChangedCrossListedSection = i_changedcrosslistedsection,ChangedDepartmentComments = i_changeddepartmentcomments, 
	DateImported = i_DateImported, DateCreated = i_DateCreated, DateDeleted = i_DateDeleted 
    WHERE ChangeLogID = i_changelogID;
END //

CREATE PROCEDURE updateCourse (IN `i_CourseID` INT, IN `i_number` INT, IN `i_title` VARCHAR(255), IN `i_minimumcredits` INT, IN `i_maximumcredits` INT, 
IN `i_fixedcredits` INT, IN `i_isfixedcredit` BIT, IN `i_departmentID` INT, IN `i_CrossListedCourseID` INT, IN `i_CrossScheduledCourseID` INT, IN `i_Description` VARCHAR(255))  
BEGIN
  UPDATE Courses SET Number = i_number, Title = i_title, MinimumCredits = i_minimumcredits, MaximumCredits = i_maximumcredits, FixedCredits = i_fixedcredits, 
  IsFixedCredit = i_isfixedcredit, DepartmentID = i_departmentID, CrossListedCourseID = i_CrossListedCourseID, CrossScheduledCourseID = i_CrossScheduledCourseID, 
  Description = i_Description 
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

CREATE PROCEDURE updateFee (IN `i_FeeID` INT, IN `i_DetailCodeID` INT, IN `i_Amount` FLOAT)  
BEGIN
  UPDATE Fees SET DetailCodeID = i_DetailCodeID, Amount = i_Amount
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

CREATE PROCEDURE updatePartOfTerm (IN `i_PartOfTermID` INT, IN `i_Name` VARCHAR(255), IN `i_StartWeek` INT(11), IN `i_EndWeek` INT(11), IN `i_Abbreviation` VARCHAR(255))
BEGIN
  UPDATE PartOfTerms SET Name = i_Name, Abbreviation = i_Abbreviation, StartWeek = i_StartWeek, EndWeek = i_EndWeek
  WHERE PartOfTermID = i_PartOfTermID;
END //

CREATE PROCEDURE updateRoom (IN `i_RoomID` INT, IN `i_Number` VARCHAR(255), IN `i_SeatsAvailable` INT, IN `i_Details` VARCHAR(255), IN `i_BuildingID` INT)  
BEGIN
  UPDATE Rooms SET Number = i_Number, SeatsAvailable = i_SeatsAvailable, Details = i_Details, BuildingID = i_BuildingID 
  WHERE RoomID = i_RoomID;
END //

CREATE PROCEDURE `updateScheduleType`(IN `i_ScheduleTypeID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255), IN `i_RequiresRoom` bit(1), IN `i_RequiresDays` bit(1), IN `i_RequiresTimes` bit(1))
BEGIN
  UPDATE ScheduleTypes SET Name = i_Name, Abbreviation = i_Abbreviation, RequiresRoom = i_RequiresRoom, RequiresDays = i_RequiresDays, RequiresTimes = i_RequiresTimes 
  WHERE ScheduleTypeID = i_ScheduleTypeID;
END //

CREATE PROCEDURE updateSection (IN `i_sectionID` INT, IN `i_crn` INT, IN `i_requiresmoodle` BIT, IN `i_requirespermission` BIT, IN `i_notes` VARCHAR(255), 
IN `i_departmentcomments` VARCHAR(255), IN `i_studentlimit` INT, IN `i_datecreated` DATETIME, IN `i_datearchived` DATETIME, IN `i_number` VARCHAR(255), 
IN `i_starttime` DATETIME, IN `i_endtime` DATETIME, IN `i_courseID` INT, IN `i_roomID` INT, IN `i_scheduletypeID` INT, IN `i_academicsemesterID` INT, 
IN `i_partoftermID` INT, IN `i_FeeID` INT, IN `i_CrossListedSectionID` INT, IN `i_DateDeleted` DATETIME)  
BEGIN
  UPDATE Sections SET CRN = i_crn, RequiresMoodle = i_requiresmoodle, RequiresPermission = i_requirespermission, Notes = i_notes, 
  DepartmentComments = i_departmentcomments, StudentLimit = i_studentlimit, DateCreated = i_datecreated, DateArchived = i_datearchived, 
  Number = i_number, StartTime = i_starttime, EndTime = i_endtime, CourseID = i_courseID, RoomID = i_roomID, ScheduleTypeID = i_scheduletypeID, 
  AcademicSemesterID = i_academicsemesterID, PartOfTermID = i_partoftermID, FeeId = i_FeeID, DateDeleted = i_DateDeleted, 
  CrossListedSectionID = i_CrossListedSectionID
  WHERE SectionID = i_sectionID;
END //

CREATE PROCEDURE updateSectionDay (IN `i_DayID` INT, IN `i_SectionID` INT, IN `i_DateArchived` DATETIME, IN `i_SectionDayID` INT) 
BEGIN
    UPDATE SectionDays SET SectionID = i_SectionID, DayID = i_DayID, DateArchived = i_DateArchived 
    WHERE SectionDayID = i_SectionDayID;
END //

CREATE PROCEDURE updateDetailCode (IN `i_DetailCodeID` INT, IN `i_Code` nvarchar(255))  
BEGIN
    UPDATE DetailCodes SET Code = i_Code 
    WHERE DetailCodeID = i_DetailCodeID;
END //

CREATE PROCEDURE updateSemester (IN `i_SemesterID` INT, IN `i_Name` VARCHAR(255), IN `i_Abbreviation` VARCHAR(255))  
BEGIN
    UPDATE Semesters SET Name = i_Name, Abbreviation = i_Abbreviation 
    WHERE SemesterID = i_SemesterID;
END //

CREATE PROCEDURE updateSpreadsheetVariables (IN `i_startingrownumber` INT, IN `i_defaultfontsize` INT, IN `i_defaultfontstyle` VARCHAR(255), IN `i_academicsemester` VARCHAR(255), 
IN `i_addchangedelete` VARCHAR(255), IN `i_sectioncrn` VARCHAR(255), IN `i_Department` VARCHAR(255), IN `i_coursenumber` VARCHAR(255), IN `i_FallAbbreviation` VARCHAR(255), 
IN `i_SummerAbbreviation` VARCHAR(255), IN `i_SpringAbbreviation` VARCHAR(255), IN `i_sectionnumber` VARCHAR(255), IN `i_crosslistid` VARCHAR(255), IN `i_coursetitle` VARCHAR(255), 
IN `i_campus` VARCHAR(255), IN `i_scheduletype` VARCHAR(255), IN `i_moodlerequired` VARCHAR(255), IN `i_instructorapprovalrequired` VARCHAR(255), 
IN `i_partofterm` VARCHAR(255), IN `i_fixedcredit` VARCHAR(255), IN `i_minimumcredits` VARCHAR(255), IN `i_maximumcredits` VARCHAR(255), IN `i_classlimit` VARCHAR(255), 
IN `i_monday` VARCHAR(255), IN `i_tuesday` VARCHAR(255), IN `i_wednesday` VARCHAR(255), IN `i_thursday` VARCHAR(255), IN `i_friday` VARCHAR(255), 
IN `i_saturday` VARCHAR(255), IN `i_sunday` VARCHAR(255), IN `i_starttime` VARCHAR(255), IN `i_endtime` VARCHAR(255), IN `i_building` VARCHAR(255), 
IN `i_room` VARCHAR(255), IN `i_primaryinstructorfirstname` VARCHAR(255), IN `i_primaryinstructorlastname` VARCHAR(255), IN `i_primaryinstructornumber` VARCHAR(255), 
IN `i_primaryinstructorteachingpercent` VARCHAR(255), IN `i_secondaryinstructorfirstname` VARCHAR(255), IN `i_secondaryinstructorlastname` VARCHAR(255), 
IN `i_secondaryinstructornumber` VARCHAR(255), IN `i_secondaryinstructorteachingpercent` VARCHAR(255), IN `i_classfeedetailcode` VARCHAR(255), 
IN `i_classfeeamount` VARCHAR(255), IN `i_sectionnotes` VARCHAR(255), IN `i_crosslistsubject` VARCHAR(255), IN `i_crosslistcoursenumber` VARCHAR(255), 
IN `i_departmentcomments` VARCHAR(255),IN `i_RequiresMoodleAbbreviation` VARCHAR(255), IN `i_RequiresPermissionAbbreviation` VARCHAR(255), 
IN `i_SpreadSheetVariablesID` INT)  
BEGIN
  UPDATE SpreadsheetVariables SET startingrownumber = i_startingrownumber, defaultfontsize = i_defaultfontsize, defaultfontstyle = i_defaultfontstyle,
  academicsemester = i_academicsemester, addchangedelete = i_addchangedelete, sectioncrn = i_sectioncrn, Department = i_Department, coursenumber = i_coursenumber,
  FallAbbreviation = i_FallAbbreviation, SummerAbbreviation = i_SummerAbbreviation, SpringAbbreviation = i_SpringAbbreviation, sectionnumber = i_sectionnumber,
  crosslistid = i_crosslistid, coursetitle = i_coursetitle, campus = i_campus, scheduletype = i_scheduletype, moodlerequired = i_moodlerequired, 
  instructorapprovalrequired = i_instructorapprovalrequired, partofterm = i_partofterm, fixedcredit = i_fixedcredit, minimumcredits = i_minimumcredits, 
  maximumcredits = i_maximumcredits, classlimit = i_classlimit, monday = i_monday, tuesday = i_tuesday, wednesday = i_wednesday, thursday = i_thursday,
  friday = i_friday, saturday = i_saturday, sunday = i_sunday, starttime = i_starttime, endtime = i_endtime, building = i_building,
  room = i_room, primaryinstructorfirstname = i_primaryinstructorfirstname, primaryinstructorlastname = i_primaryinstructorlastname,
  primaryinstructornumber = i_primaryinstructornumber, primaryinstructorteachingpercent = i_primaryinstructorteachingpercent, 
  secondaryinstructorfirstname = i_secondaryinstructorfirstname, secondaryinstructorlastname = i_secondaryinstructorlastname, 
  secondaryinstructornumber = i_secondaryinstructornumber, secondaryinstructorteachingpercent = i_secondaryinstructorteachingpercent,
  classfeedetailcode = i_classfeedetailcode, classfeeamount = i_classfeeamount, sectionnotes = i_sectionnotes, crosslistsubject = i_crosslistsubject,
  crosslistcoursenumber = i_crosslistcoursenumber, departmentcomments = i_departmentcomments, RequiresMoodleAbbreviation = i_RequiresMoodleAbbreviation,
  RequiresPermissionAbbreviation = i_RequiresPermissionAbbreviation
  WHERE SpreadsheetVariablesID = i_spreadsheetvariablesID;
END //

CREATE PROCEDURE updateUser (IN `i_RoleID` INT, IN `i_Username` VARCHAR(255), IN `i_Password` VARCHAR(255), IN `i_UserID` INT)  
BEGIN
    UPDATE Users SET Username = i_Username, Password = i_Password, RoleID = i_RoleID 
    WHERE UserID = i_UserID;
END //

DELIMITER ;