/* Model for Academic Years
 * Academic Years: The period of time during which courses are taught.
 * Created on 2/6/19 by Jason Durfee
 */

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using HtmlAgilityPack;

namespace ClassScheduler.Models
{
    public static class FakeDAL
    {

        #region internal static variables
        //TODO TimeFormat should be in session variables once that is up and running
        internal static string _TimeFormat = "h:mm tt";
        internal static List<AcademicSemester> _AcademicSemesters;
        internal static List<Building> _Buildings;
        internal static List<Campus> _Campuses;
        internal static List<Course> _Courses;

        internal static List<Day> _Days;
        internal static List<Fee> _Fees;
        internal static List<Instructor> _Instructors;
        internal static List<InstructorToSection> _InstructorToSections;
        internal static List<PartOfTerm> _PartOfTerms;
        internal static List<Role> _Roles;
        internal static List<Room> _Rooms;
        internal static List<ScheduleType> _ScheduleTypes;
        internal static List<Section> _Sections;
        internal static List<SectionDay> _SectionDays;
        internal static List<DetailCode> _SectionFees;



        internal static List<Semester> _Semesters;
        internal static List<Department> _Departments;
        internal static List<User> _Users;
        internal static List<ChangeLog> _ChangeLogs;
        internal static List<SpreadsheetVariables> _SpreadsheetVariables;
        #endregion

        #region instances
        static FakeDAL()
        {
            _AcademicSemesters = new List<AcademicSemester>() {
                new AcademicSemester { ID = 1, AcademicYear = 2017, SemesterID = 1},
                new AcademicSemester { ID = 2, AcademicYear = 2017, SemesterID = 2},
                new AcademicSemester { ID = 3, AcademicYear = 2017, SemesterID = 3},
                new AcademicSemester { ID = 4, AcademicYear = 2018, SemesterID = 1},
                new AcademicSemester { ID = 5, AcademicYear = 2018, SemesterID = 2},
                new AcademicSemester { ID = 6, AcademicYear = 2018, SemesterID = 3},
                //new AcademicSemester { ID = 7, AcademicYear = 2019, SemesterID = 1},
                //new AcademicSemester { ID = 8, AcademicYear = 2019, SemesterID = 2},
                //new AcademicSemester { ID = 9, AcademicYear = 2019, SemesterID = 3},
            };
            _Buildings = new List<Building>() {
                new Building { ID = 1, Name = "Business Administration", Abbreviation = "BA", CampusID = 1},
                new Building { ID = 2, Name = "Rendezvous", Abbreviation = "REND", CampusID = 1},
                new Building { ID = 3, Name = "Physical Science Complex", Abbreviation = "PSC", CampusID = 1},
                new Building { ID = 4, Name = "Center for Higher Education", Abbreviation = "CHE", CampusID = 2},
                new Building { ID = 5, Name = "Student Union Building", Abbreviation = "SUB", CampusID = 2},
                new Building { ID = 6, Name = "Web", Abbreviation = "WEB", CampusID = -1},
            };
            _Campuses = new List<Campus>() {
                new Campus { ID = 1, Name = "Pocatello", Abbreviation = "PC" },
                new Campus { ID = 2, Name = "Idaho Falls", Abbreviation = "IF"}
            };
            //_Courses = new List<Course>() {
            //    new Course { ID = 2, Title = "Informatics and Programming I", Number = 1181, FixedCredits = 3,
            //                IsFixedCredits = true, DepartmentID = 3}
            //};
            _Days = new List<Day>() {
                new Day { ID = 1, Name = "Monday", Abbreviation = "M" },
                new Day { ID = 2, Name = "Tuesday", Abbreviation = "T" },
                new Day { ID = 3, Name = "Wednesday", Abbreviation = "W" },
                new Day { ID = 4, Name = "Thursday", Abbreviation = "R" },
                new Day { ID = 5, Name = "Friday", Abbreviation = "F" },
                new Day { ID = 6, Name = "Saturday", Abbreviation = "S" },
                new Day { ID = 7, Name = "Sunday", Abbreviation = "U" },
            };
            //_Fees = new List<Fee>() {
            //    new Fee { ID = 1, DetailCode = "CAC1" },
            //    new Fee { ID = 2, DetailCode = "IBU" },
            //    new Fee { ID = 3, DetailCode = "CBA2" },
            //    new Fee { ID = 4, DetailCode = "CCl1" },
            //};
            _Instructors = new List<Instructor>()
            {
            new Instructor { FirstName="None", MiddleName="", LastName="", Number=0, CourseLoad=0, ID=-1},
            new Instructor { FirstName="Alexander", MiddleName="", LastName="Bolinger", Number=0, CourseLoad=1, ID=1},
            new Instructor { FirstName="Alexander", MiddleName="", LastName= "Rose", Number=0, CourseLoad=1, ID=2},
            new Instructor { FirstName="Ann", MiddleName="", LastName= "Nevers", Number=0, CourseLoad=1, ID=3},
            new Instructor { FirstName="Brandon", MiddleName="", LastName= "Carpenter", Number=0, CourseLoad=1, ID=4},
            new Instructor { FirstName="Corey", MiddleName="", LastName= "Schou", Number=0, CourseLoad=1, ID=5},
            new Instructor { FirstName="Dave", MiddleName="", LastName= "Bagley", Number=0, CourseLoad=1, ID=6},
            new Instructor { FirstName="David", MiddleName="", LastName= "Mills", Number=0, CourseLoad=1, ID=7},
            new Instructor { FirstName="Dawn", MiddleName="", LastName= "Konicek", Number=0, CourseLoad=1, ID=8},
            new Instructor { FirstName="Debra", MiddleName="", LastName= "Gerber", Number=0, CourseLoad=1, ID=9},
            new Instructor { FirstName="Dennis", MiddleName="", LastName= "Krumwiede", Number=0, CourseLoad=1, ID=10},
            new Instructor { FirstName="Douglas", MiddleName="", LastName= "Crabtree", Number=0, CourseLoad=1, ID=11},
            new Instructor { FirstName="Frankie", MiddleName="", LastName= "Adams", Number=0, CourseLoad=1, ID=12},
            new Instructor { FirstName="Fred", MiddleName="", LastName= "Parrish", Number=0, CourseLoad=1, ID=13},
            new Instructor { FirstName="Gregory", MiddleName="", LastName= "Murphy", Number=0, CourseLoad=1, ID=14},
            new Instructor { FirstName="Iris", MiddleName="", LastName= "Buder", Number=0, CourseLoad=1, ID=15},
            new Instructor { FirstName="Isaac", MiddleName="", LastName= "Griffith", Number=0, CourseLoad=1, ID=16},
            new Instructor { FirstName="James", MiddleName="", LastName= "Lineberger", Number=0, CourseLoad=1, ID=17},
            new Instructor { FirstName="Jason", MiddleName="", LastName= "Chen", Number=0, CourseLoad=1, ID=18},
            new Instructor { FirstName="Jason", MiddleName="", LastName= "Hansen", Number=0, CourseLoad=1, ID=19},
            new Instructor { FirstName="Jeff", MiddleName="", LastName= "Street", Number=0, CourseLoad=1, ID=20},
            new Instructor { FirstName="Jeffrey", MiddleName="", LastName= "Brookman", Number=0, CourseLoad=1, ID=21},
            new Instructor { FirstName="Jerry", MiddleName="", LastName= "Leffler", Number=0, CourseLoad=1, ID=22},
            new Instructor { FirstName="John", MiddleName="", LastName= "Abreu", Number=0, CourseLoad=1, ID=23},
            new Instructor { FirstName="John", MiddleName="", LastName= "Ney", Number=0, CourseLoad=1, ID=24},
            new Instructor { FirstName="Jonathan", MiddleName="", LastName= "Holmes", Number=0, CourseLoad=1, ID=25},
            new Instructor { FirstName="Joshua", MiddleName="", LastName= "Thompson", Number=0, CourseLoad=1, ID=26},
            new Instructor { FirstName="Justin", MiddleName="", LastName= "Wood", Number=0, CourseLoad=1, ID=27},
            new Instructor { FirstName="Karl", MiddleName="", LastName= "Geisler", Number=0, CourseLoad=1, ID=28},
            new Instructor { FirstName="Kenneth", MiddleName="", LastName= "Khang", Number=0, CourseLoad=1, ID=29},
            new Instructor { FirstName="Kerry", MiddleName="", LastName= "Casperson", Number=0, CourseLoad=1, ID=30},
            new Instructor { FirstName="Kevin", MiddleName="", LastName= "Parker", Number=0, CourseLoad=1, ID=31},
            new Instructor { FirstName="Larry", MiddleName="", LastName= "Cravons", Number=0, CourseLoad=1, ID=32},
            new Instructor { FirstName="Larry", MiddleName="", LastName= "Leibrock", Number=0, CourseLoad=1, ID=33},
            new Instructor { FirstName="Leslie", MiddleName="", LastName= "Kerby", Number=0, CourseLoad=1, ID=34},
            new Instructor { FirstName="Marcus", MiddleName="", LastName= "Burger", Number=0, CourseLoad=1, ID=35},
            new Instructor { FirstName="Michael", MiddleName="", LastName= "McGregor", Number=0, CourseLoad=1, ID=36},
            new Instructor { FirstName="Michele", MiddleName="", LastName= "O Brien - Rose", Number=0, CourseLoad=1, ID=37},
            new Instructor { FirstName="Neil", MiddleName="", LastName= "Tocher", Number=0, CourseLoad=1, ID=38},
            new Instructor { FirstName="Nicole", MiddleName="", LastName= "Hanson", Number=0, CourseLoad=1, ID=39},
            new Instructor { FirstName="Norman", MiddleName="", LastName= "Smith", Number=0, CourseLoad=1, ID=40},
            new Instructor { FirstName="Ramon", MiddleName="", LastName= "Rodriguez", Number=0, CourseLoad=1, ID=41},
            new Instructor { FirstName="Robert", MiddleName="", LastName= "Cuoio", Number=0, CourseLoad=1, ID=42},
            new Instructor { FirstName="Robert", MiddleName="", LastName= "Houghton", Number=0, CourseLoad=1, ID=43},
            new Instructor { FirstName="Robert", MiddleName="", LastName= "Howe", Number=0, CourseLoad=1, ID=44},
            new Instructor { FirstName="Robert", MiddleName="", LastName= "Picard", Number=0, CourseLoad=1, ID=45},
            new Instructor { FirstName="Robert", MiddleName="", LastName= "Tokle", Number=0, CourseLoad=1, ID=46},
            new Instructor { FirstName="Ruiling", MiddleName="", LastName= "Guo", Number = 0, CourseLoad = 1, ID = 47 },
            new Instructor { FirstName="Ryan", MiddleName="", LastName= "Sargent", Number = 0, CourseLoad = 1, ID = 48 },
            new Instructor { FirstName="Sandra", MiddleName="", LastName= "Speck", Number=0, CourseLoad=1, ID=49},
            new Instructor { FirstName="Sariah", MiddleName="", LastName= "Millis", Number=0, CourseLoad=1, ID=50},
            new Instructor { FirstName="Scott", MiddleName="", LastName= "Benson", Number=0, CourseLoad=1, ID=51},
            new Instructor { FirstName="Sean", MiddleName="", LastName= "McBride", Number=0, CourseLoad=1, ID=52},
            new Instructor { FirstName="Stacey", MiddleName="", LastName= "Gibson", Number=0, CourseLoad=1, ID=53},
            new Instructor { FirstName="Steven", MiddleName="", LastName= "Byers", Number=0, CourseLoad=1, ID=54},
            new Instructor { FirstName="Sue", MiddleName="", LastName= "Schou", Number=0, CourseLoad=1, ID=55},
            new Instructor { FirstName="Teri", MiddleName="", LastName= "Peterson", Number=0, CourseLoad=1, ID=56},
            new Instructor { FirstName="Tesa", MiddleName="", LastName= "Stegner", Number=0, CourseLoad=1, ID=57},
            new Instructor { FirstName="Thomas", MiddleName="", LastName= "Ottaway", Number=0, CourseLoad=1, ID=58},
            new Instructor { FirstName="Tony", MiddleName="", LastName= "Lovgren", Number=0, CourseLoad=1, ID=59},
            new Instructor { FirstName="Tracy", MiddleName="", LastName= "Farnsworth", Number=0, CourseLoad=1, ID=60},
            new Instructor { FirstName="Tyler", MiddleName="", LastName= "Burch", Number=0, CourseLoad=1, ID=61},
            new Instructor { FirstName="Velma", MiddleName="", LastName= "Payne", Number=0, CourseLoad=1, ID=62},
            new Instructor { FirstName="Yan", MiddleName="", LastName= "Chen", Number=0, CourseLoad=1, ID=63},


            };
            _InstructorToSections = new List<InstructorToSection>()
            {

            };
            _PartOfTerms = new List<PartOfTerm>() {
                new PartOfTerm { ID = 1, Name = "Full", Abbreviation = "Full"},
                new PartOfTerm { ID = 2, Name = "Early 4", Abbreviation = "E4"},
                new PartOfTerm { ID = 3, Name = "Early 6", Abbreviation = "E6"},
                new PartOfTerm { ID = 4, Name = "Early 8", Abbreviation = "E8"},
                new PartOfTerm { ID = 5, Name = "Middle 4", Abbreviation = "M4"},
                new PartOfTerm { ID = 6, Name = "Late 8", Abbreviation = "L8"},
                new PartOfTerm { ID = 7, Name = "Late 6", Abbreviation = "L6"},
                new PartOfTerm { ID = 8, Name = "Late 4", Abbreviation = "L4"},
            };
            _SectionDays = new List<SectionDay>() {
                new SectionDay {ID = 1, SectionID = 1, DayID = 1},
                new SectionDay {ID = 2, SectionID = 1, DayID = 2},
                new SectionDay {ID = 3, SectionID = 1, DayID = 5},
                new SectionDay {ID = 4, SectionID = 2, DayID = 2},
                new SectionDay {ID = 5, SectionID = 2, DayID = 3},
                new SectionDay {ID = 6, SectionID = 2, DayID = 5},
            };
            //_SectionFees = new List<DetailCode>()
            //{
            //    new DetailCode { ID = 1, SectionID = 1, FeeID = 1 },
            //    new DetailCode { ID = 2, SectionID = 2, FeeID = 3 },
            //};
            _Semesters = new List<Semester>() {
                new Semester { ID = 1, Name = "Spring", Abbreviation = "AS"},
                new Semester { ID = 2, Name = "Summer", Abbreviation = "??"},
                new Semester { ID = 3, Name = "Fall", Abbreviation = "AF"},
            };

            //{
            //    new Department { ID = 1, Name = "Accounting", Abbreviation = "ACCT"},
            //    new Department { ID = 2, Name = "Finance", Abbreviation = "FIN"},
            //    new Department { ID = 3, Name = "Informatics", Abbreviation = "INFO"},
            //    new Department { ID = 4, Name = "Computer Science", Abbreviation = "CS"},
            //    new Department { ID = 5, Name = "Business Admin", Abbreviation = "BA"},
            //    new Department { ID = 6, Name = "Marketing", Abbreviation = "MKTG"},
            //    new Department { ID = 7, Name = "Economics", Abbreviation = "ECON"},
            //    new Department { ID = 8, Name = "Masters of Business Admin", Abbreviation = "MBA"},
            //    new Department { ID = 9, Name = "Management", Abbreviation = "MGT"},
            //    new Department { ID = 10, Name = "Health Care Admin", Abbreviation = "HCA"}
            //};

            //_Departments = GetDepartmentsFromCatalog();
            //_Departments.Clear();
            _Departments = new List<Department>(){
                new Department { ID = 1, Name = "Accounting", Abbreviation = "ACCT"},
                new Department { ID = 2, Name = "Econimics", Abbreviation = "ECON"},
                new Department { ID = 3, Name = "Finance", Abbreviation = "FIN"},
                new Department { ID = 4, Name = "Business Admin", Abbreviation = "BA"},
                new Department { ID = 5, Name = "Health Care Administration", Abbreviation = "HCA"},
                new Department { ID = 6, Name = "Informatics", Abbreviation = "INFO"},
                new Department { ID = 7, Name = "Management", Abbreviation = "MGT"},
                new Department { ID = 8, Name = "Marketing", Abbreviation = "MKTG"},
                new Department { ID = 9, Name = "Computer Science", Abbreviation = "CS"},
                new Department { ID = 10, Name = "General Business", Abbreviation = "BA"},
                new Department { ID = 11, Name = "Masters in Business Admin", Abbreviation = "MBA"},
            };


            //_Courses.Clear();
            _Courses = GetCoursesFromCatalog();

            _Users = new List<User>() {
                new User { ID = 1, Username = "DrHoughton", Password = "superstrongpassword", RoleID = 1 },
            };
            _ChangeLogs = new List<ChangeLog>()
            {

            };
            _SpreadsheetVariables = new List<SpreadsheetVariables>() {
                new SpreadsheetVariables {ID = 1, AcademicSemester = "A", AddChangeDelete = "B", SectionCRN = "C", Department = "D", CourseNumber = "E",
                SectionNumber = "F", CrossListID = "G", CourseTitle = "H", Campus = "I", ScheduleType = "J", MoodleRequired = "K",
                InstructorApprovalRequired = "L", PartOfTerm = "M", FixedCredit = "N", MinimumCredits = "O", MaximumCredits = "P",
                ClassLimit = "Q", Monday = "R", Tuesday = "S", Wednesday = "T", Thursday = "U", Friday = "V", Saturday = "W", Sunday = "X",
                StartTime = "Y", EndTime = "Z", Building = "AA", Room = "AB", PrimaryInstructorFirstName = "AC", PrimaryInstructorLastName = "AD",
                PrimaryInstructorNumber = "AE", PrimaryInstructorTeachingPercentage = "AF", SecondaryInstructorFirstName = "AG",
                SecondaryInstructorLastName = "AH", SecondaryInstructorNumber = "AI", SecondaryInstructorTeachingPercentage = "AJ",
                ClassFeeDetailCode = "AK", ClassFeeAmount = "AL", SectionNotes = "AM", CrossListSubject = "AN", CrossListCourseNumber = "AO",
                DepartmentComments = "AP"}
            };
        }

        #endregion

        public static string TimeFormat {
            get { return _TimeFormat; }
            set { _TimeFormat = value; }
        }

        #region private variables

        #endregion

        #region public properties

        #endregion

        #region public functions

        #region AcademicSemesters
        /// <summary>
        /// Gets all AcademicSemesters
        /// </summary>
        /// <returns>a list of academic semesters</returns>
        public static List<AcademicSemester> GetAcademicSemesters()
        {
            return _AcademicSemesters;
        }

        /// <summary>
        /// Gets a specific AcademicSemester from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static AcademicSemester GetAcademicSemester(int ID)
        {
            AcademicSemester retAcademicSemester = new AcademicSemester();
            foreach (AcademicSemester AcademicSemester in _AcademicSemesters)
            {
                if (AcademicSemester.ID == ID)
                {
                    retAcademicSemester = AcademicSemester;
                }
            }
            return retAcademicSemester;
        }

        public static int GetAcademicSemesterByYearAndSemester(int semesterID, int yearID)
        {
            int retVal = -1;
            for (int academicSemesterID = 0; academicSemesterID < _AcademicSemesters.Count; academicSemesterID++)
            {
                if (_AcademicSemesters[academicSemesterID].AcademicYear == yearID && _AcademicSemesters[academicSemesterID].SemesterID == semesterID)
                {
                    retVal = _AcademicSemesters[academicSemesterID].ID;
                }
            }
            return retVal;
        }
        /// <summary>
        /// Adds an AcademicSemester
        /// </summary>
        /// <param name="newAcademicSemester"></param>
        public static void AddAcademicSemester(AcademicSemester newAcademicSemester)
        {
            if (newAcademicSemester != null)
            {
                newAcademicSemester.ID = _AcademicSemesters.Max(c => c.ID) + 1;
                _AcademicSemesters.Add(newAcademicSemester);
            }
        }

        /// <summary>
        /// Updates an AcademicSemester
        /// </summary>
        /// <param name="id"></param>
        /// <param name="updatedAcademicSemester"></param>
        public static void UpdateAcademicSemester(int id, AcademicSemester updatedAcademicSemester)
        {
            for (int AcademicSemesterIndex = 0; AcademicSemesterIndex < _AcademicSemesters.Count; AcademicSemesterIndex++)
            {
                if (_AcademicSemesters[AcademicSemesterIndex].ID == id)
                {
                    _AcademicSemesters[AcademicSemesterIndex] = updatedAcademicSemester;
                }
            }
        }

        /// <summary>
        /// Deletes an AcademicSemester
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveAcademicSemester(int id)
        {
            for (int AcademicSemesterIndex = 0; AcademicSemesterIndex < _AcademicSemesters.Count; AcademicSemesterIndex++)
            {
                if (_AcademicSemesters[AcademicSemesterIndex].ID == id)
                {
                    _AcademicSemesters.Remove(_AcademicSemesters[AcademicSemesterIndex]);
                }
            }
        }
        #endregion

        #region Buildings
        public static List<Building> GetBuildings()
        {
            return _Buildings;
        }

        public static Building GetBuilding(int ID)
        {
            Building retBuilding = new Building();
            foreach (Building building in _Buildings)
            {
                if (building.ID == ID)
                {
                    retBuilding = building;
                }
            }
            return retBuilding;
        }

        public static int GetBuildingByAbbreviation(string buildingAbbrev)
        {
            int retVal = -1;
            for (int buildingIndex = 0; buildingIndex < _Buildings.Count; buildingIndex++)
            {
                if (_Buildings[buildingIndex].Abbreviation == buildingAbbrev)
                {
                    retVal = _Buildings[buildingIndex].ID;
                }
            }
            return retVal;
        }

        public static void AddBuilding(Building newBuilding)
        {
            if (newBuilding != null)
            {
                newBuilding.ID = _Buildings.Max(b => b.ID) + 1;
                _Buildings.Add(newBuilding);
            }
        }

        public static void UpdateBuilding(int id, Building updatedBuilding)
        {
            for (int buildingIndex = 0; buildingIndex < _Buildings.Count; buildingIndex++)
            {
                if (_Buildings[buildingIndex].ID == id)
                {
                    _Buildings[buildingIndex] = updatedBuilding;
                }
            }
        }

        public static void RemoveBuilding(int id)
        {
            for (int buildingIndex = 0; buildingIndex < _Buildings.Count; buildingIndex++)
            {
                if (_Buildings[buildingIndex].ID == id)
                {
                    _Buildings.Remove(_Buildings[buildingIndex]);
                }
            }
        }
        #endregion

        #region Campuses
        public static List<Campus> GetCampuses()
        {
            return _Campuses;
        }

        public static Campus GetCampus(int ID)
        {
            Campus retCampus = new Campus();
            foreach (Campus campus in _Campuses)
            {
                if (campus.ID == ID)
                {
                    retCampus = campus;
                }
            }
            return retCampus;
        }

        public static int GetCampusByAbbreviation(string abbreviation)
        {
            int retVal = -1;
            foreach (Campus campus in _Campuses)
            {
                if (campus.Abbreviation == abbreviation)
                {
                    retVal = campus.ID;
                }
            }
            return retVal;
        }

        public static void AddCampus(Campus newCampus)
        {
            if (newCampus != null)
            {
                newCampus.ID = _Campuses.Max(c => c.ID) + 1;
                _Campuses.Add(newCampus);
            }
        }

        public static void UpdateCampus(int id, Campus updatedCampus)
        {
            for (int campusIndex = 0; campusIndex < _Campuses.Count; campusIndex++)
            {
                if (_Campuses[campusIndex].ID == id)
                {
                    _Campuses[campusIndex] = updatedCampus;
                }
            }
        }

        public static void RemoveCampus(int id)
        {
            for (int campusIndex = 0; campusIndex < _Campuses.Count; campusIndex++)
            {
                if (_Campuses[campusIndex].ID == id)
                {
                    _Campuses.Remove(_Campuses[campusIndex]);
                }
            }
        }
        #endregion

        #region ChangeLogs
        /// <summary>
        /// Gets all ChangeLogs
        /// </summary>
        /// <returns>a list of academic semesters</returns>
        public static List<ChangeLog> GetChangeLogs()
        {
            return _ChangeLogs;
        }

        /// <summary>
        /// Gets a specific ChangeLog from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static ChangeLog GetChangeLog(int ID)
        {
            ChangeLog retChangeLog = new ChangeLog();
            foreach (ChangeLog ChangeLog in _ChangeLogs)
            {
                if (ChangeLog.ID == ID)
                {
                    retChangeLog = ChangeLog;
                }
            }
            return retChangeLog;
        }

        /// <summary>
        /// Gets a specific ChangeLog from a Section
        /// </summary>
        /// <param name="section"></param>
        /// <returns>ChangeLogID</returns>
        public static ChangeLog GetChangeLogBySection(Section section)
        {
            ChangeLog retLog = new ChangeLog();
            for (int ChangeLogIndex = 0; ChangeLogIndex < _ChangeLogs.Count; ChangeLogIndex++)
            {
                if (_ChangeLogs[ChangeLogIndex].SectionID == section.ID)
                {
                    retLog = _ChangeLogs[ChangeLogIndex];
                }
            }
            return retLog;
        }

        /// <summary>
        /// Adds an ChangeLog
        /// </summary>
        /// <param name="newChangeLog"></param>
        public static void AddChangeLog(ChangeLog newChangeLog)
        {
            if (newChangeLog != null)
            {
                if (_ChangeLogs.Count == 0)
                {
                    newChangeLog.ID = 1;
                }
                else
                {
                    newChangeLog.ID = _ChangeLogs.Max(c => c.ID) + 1;
                }
                _ChangeLogs.Add(newChangeLog);
            }
        }

        /// <summary>
        /// Updates an ChangeLog
        /// </summary>
        /// <param name="id"></param>
        /// <param name="updatedChangeLog"></param>
        public static void UpdateChangeLog(int id, ChangeLog updatedChangeLog)
        {
            for (int ChangeLogIndex = 0; ChangeLogIndex < _ChangeLogs.Count; ChangeLogIndex++)
            {
                if (_ChangeLogs[ChangeLogIndex].ID == id)
                {
                    _ChangeLogs[ChangeLogIndex] = updatedChangeLog;
                }
            }
        }

        /// <summary>
        /// Deletes an ChangeLog
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveChangeLog(int id)
        {
            for (int ChangeLogIndex = 0; ChangeLogIndex < _ChangeLogs.Count; ChangeLogIndex++)
            {
                if (_ChangeLogs[ChangeLogIndex].ID == id)
                {
                    _ChangeLogs.Remove(_ChangeLogs[ChangeLogIndex]);
                }
            }
        }
        #endregion

        #region SpreadsheetVariables
        /// <summary>
        /// Gets a list of all SpreadsheetVariables
        /// </summary>
        /// <returns>a list of SpreadsheetVariables</returns>
        public static List<SpreadsheetVariables> GetSpreadsheetVariablesList()
        {
            return _SpreadsheetVariables;
        }

        /// <summary>
        /// Gets a specific SpreadsheetVariables from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>SpreadsheetVariables</returns>
        public static SpreadsheetVariables GetSpreadsheetVariables(int ID)
        {
            SpreadsheetVariables retSpreadsheetVariables = new SpreadsheetVariables();
            foreach (SpreadsheetVariables spreadsheetVariables in _SpreadsheetVariables)
            {
                if (spreadsheetVariables.ID == ID)
                {
                    retSpreadsheetVariables = spreadsheetVariables;
                }
            }
            return retSpreadsheetVariables;
        }

        /// <summary>
        /// Adds a SpreadsheetVariables
        /// </summary>
        /// <param name="newSpreadsheetVariables"></param>
        public static int AddSpreadsheetVariables(SpreadsheetVariables newSpreadsheetVariables)
        {
            if (newSpreadsheetVariables != null)
            {
                if (_SpreadsheetVariables.Count == 0)
                {
                    newSpreadsheetVariables.ID = 1;
                }
                else
                {
                    newSpreadsheetVariables.ID = _SpreadsheetVariables.Max(c => c.ID) + 1;
                }
                _SpreadsheetVariables.Add(newSpreadsheetVariables);
            }
            return newSpreadsheetVariables.ID;
        }

        /// <summary>
        /// Updates a SpreadsheetVariables
        /// </summary>
        /// <param name="id"></param>
        /// <param name="updatedSpreadsheetVariables"></param>
        public static void UpdateSpreadsheetVariables(int id, SpreadsheetVariables updatedSpreadsheetVariables)
        {
            for (int spreadsheetVariablesIndex = 0; spreadsheetVariablesIndex < _SpreadsheetVariables.Count; spreadsheetVariablesIndex++)
            {
                if (_SpreadsheetVariables[spreadsheetVariablesIndex].ID == id)
                {
                    _SpreadsheetVariables[spreadsheetVariablesIndex] = updatedSpreadsheetVariables;
                }
            }
        }

        public static void ClearAllColumnAliass()
        {
            _SpreadsheetVariables = new List<SpreadsheetVariables>();
        }

        /// <summary>
        /// Deletes a SpreadsheetVariables
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveSpreadsheetVariables(int id)
        {
            for (int spreadsheetVariablesIndex = 0; spreadsheetVariablesIndex < _SpreadsheetVariables.Count; spreadsheetVariablesIndex++)
            {
                if (_SpreadsheetVariables[spreadsheetVariablesIndex].ID == id)
                {
                    _SpreadsheetVariables.Remove(_SpreadsheetVariables[spreadsheetVariablesIndex]);
                }
            }
        }
        #endregion

        #region Courses
        /// <summary>
        /// Gets all Courses
        /// </summary>
        /// <returns>a list of academic semesters</returns>
        public static List<Course> GetCourses()
        {
            return _Courses;

        }

        /// <summary>
        /// Parse Courses from catalog
        /// refrence: https://www.c-sharpcorner.com/UploadFile/9b86d4/getting-started-with-html-agility-pack/
        /// </summary>
        /// <returns>List of Courses</returns>
        public static List<Course> GetCoursesFromCatalog()
        {
            List<Course> retList = new List<Course>();
            foreach (Department department in DAL.GetDepartments())
            {
                if (department.Abbreviation == "MBA")
                {
                    retList.AddRange(GetCoursesWithURL("http://coursecat.isu.edu/graduate/allcourses/" + department.Abbreviation.ToLower() + "/", department));
                } else if (department.Abbreviation == "BA")
                {
                    retList.AddRange(GetCoursesWithURL("http://coursecat.isu.edu/undergraduate/allcourses/" + department.Abbreviation.ToLower() + "/", department));
                }
                else
                {
                    retList.AddRange(GetCoursesWithURL("http://coursecat.isu.edu/graduate/allcourses/" + department.Abbreviation.ToLower() + "/", department));
                    retList.AddRange(GetCoursesWithURL("http://coursecat.isu.edu/undergraduate/allcourses/" + department.Abbreviation.ToLower() + "/", department));
                }
            }
            return retList;
        }

        public static List<Course> GetCoursesWithURL(string url, Department department)
        {
            HtmlWeb coursesWeb = new HtmlWeb();
            HtmlDocument courseDocument = coursesWeb.Load(url);
            var courseBlockNodes = courseDocument.DocumentNode.SelectNodes("//div[@class='courseblock']");

            List<Course> retList = new List<Course>();

            foreach (var courseBlock in courseBlockNodes)
            {
                var crsDoc = new HtmlDocument();
                crsDoc.LoadHtml(courseBlock.InnerHtml.ToString());

                //Filter and get Number
                Regex rxNumber = new Regex(@"(?<=&#160;)\d{4}");
                var pNumber = crsDoc.DocumentNode.SelectSingleNode("//p[@class='courseblocktitle']");
                string cNumber = rxNumber.Match(pNumber.InnerHtml).ToString();
                //Filter and get Title
                Regex rxTitle = new Regex(@"(?<=\d{4})(.*)(?=:)");
                var pTitle = crsDoc.DocumentNode.SelectSingleNode("//p[@class='courseblocktitle']");
                string cTitle = rxTitle.Match(pTitle.InnerHtml).ToString().Trim();
                //Filter and ger desctiption
                var pDesc = crsDoc.DocumentNode.SelectSingleNode("//p[@class='courseblockdesc']");
                string cDescription =Regex.Replace(pDesc.InnerText.ToString().Trim(), @"&#160;|&nbsp", " ");
               
                Course retCourse = new Course { Number = Int32.Parse(cNumber), DepartmentID = department.ID, Title = cTitle, Description = cDescription };

                //Filter Credit
                Regex rxCredit = new Regex(@"(?<=:)(.*)(?= sem)");
                var pCredit = crsDoc.DocumentNode.SelectSingleNode("//p[@class='courseblocktitle']");
                string strCredit = rxCredit.Match(pCredit.InnerText).ToString().Trim();
                int cCredit = 0;
                if (int.TryParse(strCredit, out cCredit))
                {
                    retCourse.FixedCredits = cCredit;
                    retCourse.IsFixedCredit = true;
                }
                else
                {
                    retCourse.IsFixedCredit = false;
                    retCourse.MinimumCredits = (int) char.GetNumericValue(strCredit[0]);
                    retCourse.MaximumCredits = (int) char.GetNumericValue(strCredit[2]);
                }
                retList.Add(retCourse);

            }
            return retList;
        }

        /// <summary>
        /// Gets a specific Course from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static Course GetCourse(int ID)
        {
            Course retCourse = new Course();
            foreach (Course Course in _Courses)
            {
                if (Course.ID == ID)
                {
                    retCourse = Course;
                }
            }
            return retCourse;
        }

        public static Course GetCourseByDepartmentAndNumber(string deptAbbrev, int courseNumber)
        {
            Course retVal = null;
            for (int courseIndex = 0; courseIndex < _Courses.Count; courseIndex++)
            {
                if (_Courses[courseIndex].Department.Abbreviation == deptAbbrev && _Courses[courseIndex].Number == courseNumber)
                {
                    retVal = _Courses[courseIndex];
                }
            }
            return retVal;
        }

        /// <summary>
        /// Adds an Course
        /// </summary>
        /// <param name="newCourse"></param>
        public static void AddCourse(Course newCourse)
        {
            if (newCourse != null)
            {
                if (_Courses.Count == 0)
                {
                    newCourse.ID = 1;
                }
                else
                {
                    newCourse.ID = _Courses.Max(c => c.ID) + 1;
                }
                _Courses.Add(newCourse);
            }
        }

        /// <summary>
        /// Updates an Course
        /// </summary>
        /// <param name="id"></param>
        /// <param name="updatedCourse"></param>
        public static void UpdateCourse(int id, Course updatedCourse)
        {
            for (int CourseIndex = 0; CourseIndex < _Courses.Count; CourseIndex++)
            {
                if (_Courses[CourseIndex].ID == id)
                {
                    _Courses[CourseIndex] = updatedCourse;
                }
            }
        }

        /// <summary>
        /// Deletes an Course
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveCourse(int id)
        {
            for (int CourseIndex = 0; CourseIndex < _Courses.Count; CourseIndex++)
            {
                if (_Courses[CourseIndex].ID == id)
                {
                    _Courses.Remove(_Courses[CourseIndex]);
                }
            }
        }




        #endregion

        #region Days
        /// <summary>
        /// Gets all Days
        /// </summary>
        /// <returns>a list of academic semesters</returns>
        public static List<Day> GetDays()
        {
            return _Days;
        }

        /// <summary>
        /// Gets a specific Day from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static Day GetDay(int ID)
        {
            Day retDay = new Day();
            foreach (Day Day in _Days)
            {
                if (Day.ID == ID)
                {
                    retDay = Day;
                }
            }
            return retDay;
        }

        public static int GetDayByAbbreviation(string abbreviation)
        {
            int retVal = -1;
            for (int dayIndex = 0; dayIndex < _Days.Count; dayIndex++)
            {
                if (_Days[dayIndex].Abbreviation == abbreviation)
                {
                    retVal = _Days[dayIndex].ID;
                }
            }
            return retVal;
        }

        /// <summary>
        /// gets the days for a given sectionID
        /// </summary>
        /// <param name="sectionID"></param>
        /// <returns></returns>
        public static List<Day> GetDaysBySectionID(int sectionID)
        {
            List<Day> days = new List<Day>();
            foreach (SectionDay sectionDay in _SectionDays)
            {
                if (sectionDay.SectionID == sectionID && sectionDay.DateArchived > DateTime.Now)
                {
                    days.Add(sectionDay.Day);
                }
            }
            days = days.OrderBy(d => d.ID).ToList();
            return days;
        }

        /// <summary>
        /// Adds a Day
        /// </summary>
        /// <param name="newDay"></param>
        public static void AddDay(Day newDay)
        {
            if (newDay != null)
            {
                newDay.ID = _Days.Max(c => c.ID) + 1;
                _Days.Add(newDay);
            }
        }

        /// <summary>
        /// Updates a Day
        /// </summary>
        /// <param name="id"></param>
        /// <param name="updatedDay"></param>
        public static void UpdateDay(int id, Day updatedDay)
        {
            for (int DayIndex = 0; DayIndex < _Days.Count; DayIndex++)
            {
                if (_Days[DayIndex].ID == id)
                {
                    _Days[DayIndex] = updatedDay;
                }
            }
        }

        /// <summary>
        /// Deletes a Day
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveDay(int id)
        {
            for (int DayIndex = 0; DayIndex < _Days.Count; DayIndex++)
            {
                if (_Days[DayIndex].ID == id)
                {
                    _Days.Remove(_Days[DayIndex]);
                }
            }
        }
        #endregion

        #region Fees
        //public static List<Fee> GetFees() {
        //    return _Fees;
        //}

        //public static Fee GetFee(int ID) {
        //    Fee retFee = new Fee();
        //    foreach (Fee fee in _Fees) {
        //        if (fee.ID == ID) {
        //            retFee = fee;
        //        }
        //    }
        //    return retFee;
        //}

        //public static Fee GetFeeByDetailCode(string detailCode) {
        //    Fee retFee = null;
        //    foreach (Fee fee in _Fees) {
        //        if (fee.DetailCode == detailCode) {
        //            retFee = fee;
        //        }
        //    }
        //    return retFee;
        //}

        //public static List<Fee> GetFeesBySectionID(int sectionID) {
        //    List<Fee> fees = new List<Fee>();
        //    foreach (DetailCode sectionFee in _SectionFees) {
        //        if (sectionFee.SectionID == sectionID) {
        //            fees.Add(sectionFee.Fee);
        //        }
        //    }
        //    return fees;
        //}


        //public static void AddFee(Fee newFee) {
        //    if (newFee != null) {
        //        newFee.ID = _Fees.Max(c => c.ID) + 1;
        //        _Fees.Add(newFee);
        //    }
        //}

        //public static void UpdateFee(int id, Fee updatedFee) {
        //    for (int FeeIndex = 0; FeeIndex < _Fees.Count; FeeIndex++) {
        //        if (_Fees[FeeIndex].ID == id) {
        //            _Fees[FeeIndex] = updatedFee;
        //        }
        //    }
        //}

        //public static void RemoveFee(int id) {
        //    for (int FeeIndex = 0; FeeIndex < _Fees.Count; FeeIndex++) {
        //        if (_Fees[FeeIndex].ID == id) {
        //            _Fees.Remove(_Fees[FeeIndex]);
        //        }
        //    }
        //}
        #endregion

        #region Instructors
        /// <summary>
        /// Gets all Instructors
        /// </summary>
        /// <returns>a list of academic semesters</returns>
        public static List<Instructor> GetInstructors()
        {
            return _Instructors;
        }

        /// <summary>
        /// Gets a specific Instructor from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static Instructor GetInstructor(int ID)
        {
            Instructor retInstructor = new Instructor();
            foreach (Instructor Instructor in _Instructors)
            {
                if (Instructor.ID == ID)
                {
                    retInstructor = Instructor;
                }
            }
            return retInstructor;
        }

        /// <summary>
        /// gets an instructor ID by first and last name
        /// </summary>
        /// <param name="firstName"></param>
        /// <param name="lastName"></param>
        /// <returns></returns>
        public static int GetInstructorByFirstAndLastName(string firstName, string lastName)
        {
            int retVal = -1;
            for (int instructorIndex = 0; instructorIndex < _Instructors.Count; instructorIndex++)
            {
                if (_Instructors[instructorIndex].FirstName == firstName && _Instructors[instructorIndex].LastName == lastName)
                {
                    retVal = _Instructors[instructorIndex].ID;
                }
            }
            return retVal;
        }

        /// <summary>
        /// Adds an Instructor
        /// </summary>
        /// <param name="newInstructor"></param>
        public static void AddInstructor(Instructor newInstructor)
        {
            if (newInstructor != null)
            {
                if (_Instructors.Count == 0)
                {
                    newInstructor.ID = 1;
                }
                else
                {
                    newInstructor.ID = _Instructors.Max(c => c.ID) + 1;
                }
                _Instructors.Add(newInstructor);
            }
        }

        /// <summary>
        /// Updates an Instructor
        /// </summary>
        /// <param name="id"></param>
        /// <param name="updatedInstructor"></param>
        public static void UpdateInstructor(int id, Instructor updatedInstructor)
        {
            for (int InstructorIndex = 0; InstructorIndex < _Instructors.Count; InstructorIndex++)
            {
                if (_Instructors[InstructorIndex].ID == id)
                {
                    _Instructors[InstructorIndex] = updatedInstructor;
                }
            }
        }

        /// <summary>
        /// Deletes an Instructor
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveInstructor(int id)
        {
            for (int InstructorIndex = 0; InstructorIndex < _Instructors.Count; InstructorIndex++)
            {
                if (_Instructors[InstructorIndex].ID == id)
                {
                    _Instructors.Remove(_Instructors[InstructorIndex]);
                }
            }
        }
        #endregion

        #region InstructorToSections
        /// <summary>
        /// Gets all InstructorToSections
        /// </summary>
        /// <returns>a list of academic semesters</returns>
        public static List<InstructorToSection> GetInstructorToSections()
        {
            return _InstructorToSections;
        }

        /// <summary>
        /// Gets a specific InstructorToSection from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static InstructorToSection GetInstructorToSection(int ID)
        {
            InstructorToSection retInstructorToSection = new InstructorToSection();
            foreach (InstructorToSection InstructorToSection in _InstructorToSections)
            {
                if (InstructorToSection.ID == ID)
                {
                    retInstructorToSection = InstructorToSection;
                }
            }
            return retInstructorToSection;
        }

        /// <summary>
        /// gets the Instructors for a given sectionID
        /// </summary>
        /// <param name="sectionID"></param>
        /// <returns></returns>
        public static List<InstructorToSection> GetInstructorsBySectionID(int sectionID)
        {
            List<InstructorToSection> instructors = new List<InstructorToSection>();
            foreach (InstructorToSection sectionInstructor in _InstructorToSections)
            {
                if (sectionInstructor.SectionID == sectionID)
                {
                    instructors.Add(sectionInstructor);
                }
            }
            return instructors;
        }

        public static InstructorToSection GetInstructorToSectionByInstructorIDAndSectionID(int sectionID, int instructorID)
        {
            InstructorToSection retSectionInstructor = null;
            foreach (InstructorToSection instructorToSection in _InstructorToSections)
            {
                if (instructorToSection.SectionID == sectionID && instructorToSection.InstructorID == instructorID)
                {
                    retSectionInstructor = instructorToSection;
                }
            }
            return retSectionInstructor;
        }

        public static void ClearAllInstructorToSections()
        {
            _InstructorToSections = new List<InstructorToSection>();
        }

        /// <summary>
        /// Adds an InstructorToSection
        /// </summary>
        /// <param name="newInstructorToSection"></param>
        public static void AddInstructorToSection(InstructorToSection newInstructorToSection)
        {
            if (newInstructorToSection != null)
            {
                if (_InstructorToSections.Count == 0)
                {
                    newInstructorToSection.ID = 1;
                }
                else
                {
                    newInstructorToSection.ID = _InstructorToSections.Max(c => c.ID) + 1;
                }
                _InstructorToSections.Add(newInstructorToSection);
            }
        }

        /// <summary>
        /// Updates an InstructorToSection
        /// </summary>
        /// <param name="id"></param>
        /// <param name="updatedInstructorToSection"></param>
        public static void UpdateInstructorToSection(int id, InstructorToSection updatedInstructorToSection)
        {
            for (int InstructorToSectionIndex = 0; InstructorToSectionIndex < _InstructorToSections.Count; InstructorToSectionIndex++)
            {
                if (_InstructorToSections[InstructorToSectionIndex].ID == id)
                {
                    _InstructorToSections[InstructorToSectionIndex] = updatedInstructorToSection;
                }
            }
        }

        /// <summary>
        /// Deletes an InstructorToSection
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveInstructorToSection(int id)
        {
            for (int InstructorToSectionIndex = 0; InstructorToSectionIndex < _InstructorToSections.Count; InstructorToSectionIndex++)
            {
                if (_InstructorToSections[InstructorToSectionIndex].ID == id)
                {
                    _InstructorToSections.Remove(_InstructorToSections[InstructorToSectionIndex]);
                }
            }
        }
        #endregion

        #region SectionDays

        public static SectionDay GetSectionDayByDayAndSection(int sectionID, int dayID)
        {
            SectionDay retSectionDay = null;
            foreach (SectionDay sectionDay in _SectionDays)
            {
                if (sectionDay.SectionID == sectionID && sectionDay.DayID == dayID)
                {
                    retSectionDay = sectionDay;
                }
            }
            return retSectionDay;
        }

        public static Section GetSection(int id)
        {
            Section retVal = null;
            foreach (Section section in _Sections)
            {
                if (section.ID == id)
                {
                    retVal = section;
                }
            }
            return retVal;
        }


        /// <summary>
        /// Deletes a SectionDay
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveSectionDay(int id)
        {
            for (int SectionDaysIndex = 0; SectionDaysIndex < _SectionDays.Count; SectionDaysIndex++)
            {
                if (_SectionDays[SectionDaysIndex].ID == id)
                {
                    _SectionDays[SectionDaysIndex].DateArchived = DateTime.Now;
                }
            }
        }
        #endregion

        #region SectionFees
        ///// <summary>
        ///// Gets all SectionFees
        ///// </summary>
        ///// <returns>a list of academic semesters</returns>
        //public static List<DetailCode> GetSectionFees() {
        //    return _SectionFees;
        //}

        ///// <summary>
        ///// Gets a specific SectionFee from an ID
        ///// </summary>
        ///// <param name="ID"></param>
        ///// <returns>Academic Semester</returns>
        //public static DetailCode GetSectionFee(int ID) {
        //    DetailCode retSectionFee = new DetailCode();
        //    foreach (DetailCode SectionFee in _SectionFees) {
        //        if (SectionFee.ID == ID) {
        //            retSectionFee = SectionFee;
        //        }
        //    }
        //    return retSectionFee;
        //}

        ///// <summary>
        ///// Adds a SectionFee
        ///// </summary>
        ///// <param name="newSectionFees"></param>
        //public static void AddSectionFee(DetailCode newSectionFees) {
        //    if (newSectionFees != null) {
        //        if (_SectionFees.Count == 0) {
        //            newSectionFees.ID = 1;
        //        }
        //        else {
        //            newSectionFees.ID = _SectionFees.Max(c => c.ID) + 1;
        //        }
        //        _SectionFees.Add(newSectionFees);
        //    }
        //}

        ///// <summary>
        ///// Updates a SectionFee
        ///// </summary>
        ///// <param name="id"></param>
        ///// <param name="updatedSectionFees"></param>
        //public static void UpdateSectionFee(int id, DetailCode updatedSectionFees) {
        //    for (int SectionFeesIndex = 0; SectionFeesIndex < _SectionFees.Count; SectionFeesIndex++) {
        //        if (_SectionFees[SectionFeesIndex].ID == id) {
        //            _SectionFees[SectionFeesIndex] = updatedSectionFees;
        //        }
        //    }
        //}

        ///// <summary>
        ///// Deletes a SectionFee
        ///// </summary>
        ///// <param name="id"></param>
        //public static void RemoveSectionFee(int id) {
        //    for (int SectionFeesIndex = 0; SectionFeesIndex < _SectionFees.Count; SectionFeesIndex++) {
        //        if (_SectionFees[SectionFeesIndex].ID == id) {
        //            _SectionFees.Remove(_SectionFees[SectionFeesIndex]);
        //        }
        //    }
        //}
        #endregion

        #region Semesters
        /// <summary>
        /// Gets all Semesters
        /// </summary>
        /// <returns>a list of academic semesters</returns>
        public static List<Semester> GetSemesters()
        {
            return _Semesters;
        }

        /// <summary>
        /// Gets a specific Semester from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static Semester GetSemester(int ID)
        {
            Semester retSemester = new Semester();
            foreach (Semester Semester in _Semesters)
            {
                if (Semester.ID == ID)
                {
                    retSemester = Semester;
                }
            }
            return retSemester;
        }


        /// <summary>
        /// Gets a specific Semester from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static Semester GetSemesterByAbbreviation(string abbreviation)
        {
            Semester retSemester = new Semester();
            foreach (Semester Semester in _Semesters)
            {
                if (Semester.Abbreviation == abbreviation)
                {
                    retSemester = Semester;
                }
            }
            return retSemester;
        }

        /// <summary>
        /// Adds a Semester
        /// </summary>
        /// <param name="newSemester"></param>
        public static void AddSemester(Semester newSemester)
        {
            if (newSemester != null)
            {
                newSemester.ID = _Semesters.Max(c => c.ID) + 1;
                _Semesters.Add(newSemester);
            }
        }

        /// <summary>
        /// Updates a Semester
        /// </summary>
        /// <param name="id"></param>
        /// <param name="updatedSemester"></param>
        public static void UpdateSemester(int id, Semester updatedSemester)
        {
            for (int SemesterIndex = 0; SemesterIndex < _Semesters.Count; SemesterIndex++)
            {
                if (_Semesters[SemesterIndex].ID == id)
                {
                    _Semesters[SemesterIndex] = updatedSemester;
                }
            }
        }

        /// <summary>
        /// Deletes a Semester
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveSemester(int id)
        {
            for (int SemesterIndex = 0; SemesterIndex < _Semesters.Count; SemesterIndex++)
            {
                if (_Semesters[SemesterIndex].ID == id)
                {
                    _Semesters.Remove(_Semesters[SemesterIndex]);
                }
            }
        }
        #endregion

        #region Departments

        /// <summary>
        /// get all departments from Database and return it
        /// </summary>
        /// <returns></returns>
        public static List<Department> GetDepartments()
        {
            return _Departments;
        }

        /// <summary>
        /// get course Abbreviation for Department
        /// </summary>
        /// <param name="departmentNode"></param>
        /// <returns></returns>
        private static string GetDepartmentAbbreviationFromCatalog(HtmlNode departmentNode)
        {
            HtmlWeb departmentsWeb = new HtmlWeb();
            //this will grab html age and keep it into htmlDocument object
            HtmlDocument departmentDocument = departmentsWeb.Load("http://coursecat.isu.edu/" + departmentNode.Attributes["href"].Value);
            HtmlNode abbrNodeString = departmentDocument.DocumentNode.SelectNodes("//div[@class='courses']//strong").ToArray()[0];
            Regex regex = new Regex(@"(?<=^)(.*)(?=&#160;)");
            string abbr = regex.Match(abbrNodeString.InnerHtml).ToString();
            return abbr;
        }

        /// <summary>
        /// Gets a specific Department from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static Department GetDepartment(int ID)
        {
            Department retDepartment = new Department();
            foreach (Department Department in _Departments)
            {
                if (Department.ID == ID)
                {
                    retDepartment = Department;
                }
            }
            return retDepartment;
        }

        public static int GetDepartmentByAbbreviation(string DepartmentAbbrev)
        {
            int retVal = -1;
            for (int DepartmentIndex = 0; DepartmentIndex < _Departments.Count; DepartmentIndex++)
            {
                if (_Departments[DepartmentIndex].Abbreviation == DepartmentAbbrev)
                {
                    retVal = _Departments[DepartmentIndex].ID;
                }
            }
            return retVal;
        }

        /// <summary>
        /// Adds a Department
        /// </summary>
        /// <param name="newDepartment"></param>
        public static void AddDepartment(Department newDepartment)
        {
            if (newDepartment != null)
            {
                newDepartment.ID = _Departments.Max(c => c.ID) + 1;
                _Departments.Add(newDepartment);
            }
        }

        /// <summary>
        /// Updates a Department
        /// </summary>
        /// <param name="id"></param>
        /// <param name="updatedDepartment"></param>
        public static void UpdateDepartment(int id, Department updatedDepartment)
        {
            for (int DepartmentIndex = 0; DepartmentIndex < _Departments.Count; DepartmentIndex++)
            {
                if (_Departments[DepartmentIndex].ID == id)
                {
                    _Departments[DepartmentIndex] = updatedDepartment;
                }
            }
        }

        /// <summary>
        /// Deletes a Department
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveDepartment(int id)
        {
            for (int DepartmentIndex = 0; DepartmentIndex < _Departments.Count; DepartmentIndex++)
            {
                if (_Departments[DepartmentIndex].ID == id)
                {
                    _Departments.Remove(_Departments[DepartmentIndex]);
                }
            }
        }

        #endregion

        #region Users
        /// <summary>
        /// Gets all Users
        /// </summary>
        /// <returns>a list of academic semesters</returns>
        public static List<User> GetUsers()
        {
            return _Users;
        }

        /// <summary>
        /// Gets a specific User from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static User GetUser(int ID)
        {
            User retUser = new User();
            foreach (User User in _Users)
            {
                if (User.ID == ID)
                {
                    retUser = User;
                }
            }
            return retUser;
        }

        /// <summary>
        /// Adds a User
        /// </summary>
        /// <param name="newUser"></param>
        public static void AddUser(User newUser)
        {
            if (newUser != null)
            {
                newUser.ID = _Users.Max(c => c.ID) + 1;
                _Users.Add(newUser);
            }
        }

        /// <summary>
        /// Updates a User
        /// </summary>
        /// <param name="id"></param>
        /// <param name="updatedUser"></param>
        public static void UpdateUser(int id, User updatedUser)
        {
            for (int UserIndex = 0; UserIndex < _Users.Count; UserIndex++)
            {
                if (_Users[UserIndex].ID == id)
                {
                    _Users[UserIndex] = updatedUser;
                }
            }
        }

        /// <summary>
        /// Deletes a User
        /// </summary>
        /// <param name="id"></param>
        public static void RemoveUser(int id)
        {
            for (int UserIndex = 0; UserIndex < _Users.Count; UserIndex++)
            {
                if (_Users[UserIndex].ID == id)
                {
                    _Users.Remove(_Users[UserIndex]);
                }
            }
        }

        #endregion

        #region Colleges
        internal static List<College> GetColleges()
        {
            return null;
        }
        internal static void AddCollege(College college)
        {

        }
        internal static void RemoveCollege(int id)
        {

        }

        internal static void UpdateCollege(int id, College college)
        {

        }
        internal static College GetCollege(int id)
        {
            return null;
        }
        #endregion


        #endregion
    }
}
