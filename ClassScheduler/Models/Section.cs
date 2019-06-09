using System;
using System.ComponentModel;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.ComponentModel.DataAnnotations;

namespace ClassScheduler.Models {
    public class Section : DatabaseObject {
        public Section() {

        }

        public Section(MySqlDataReader dr) {
            Fill(dr);
        }

        internal const string db_ID = "SectionID";
        internal const string db_CourseID = "CourseID";
        internal const string db_RoomID = "RoomID";
        internal const string db_ScheduleTypeID = "ScheduleTypeID";
        internal const string db_AcademicSemesterID = "AcademicSemesterID";
        internal const string db_PartOfTermID = "PartOfTermID";
        internal const string db_StudentLimit = "StudentLimit";
        internal const string db_XListID = "XListID";
        internal const string db_FeeID = "FeeID";
        internal const string db_DateCreated = "DateCreated";
        internal const string db_DateArchived = "DateArchived";
        internal const string db_DateDeleted = "DateDeleted";
        internal const string db_CRN = "CRN";
        internal const string db_RequiresMoodle = "RequiresMoodle";
        internal const string db_RequiresPermission = "RequiresPermission";
        internal const string db_Notes = "Notes";
        internal const string db_DepartmentComments = "DepartmentComments";
        internal const string db_Number = "Number";
        internal const string db_StartTime = "StartTime";
        internal const string db_EndTime = "EndTime";
        internal const string db_CrossListedSectionID = "CrossListedSectionID";


        #region private variables
        private int _CourseID = -1;
        private Course _Course;
        private int _RoomID;
        private Room _Room;
        private int _ScheduleTypeID;
        private ScheduleType _ScheduleType;
        private int _AcademicSemesterID;
        private AcademicSemester _AcademicSemester;
        private int _PartOfTermID;
        private PartOfTerm _PartOfTerm;
        private int _StudentLimit;
        private string _XListID = "";
        private DateTime _DateCreated = DateTime.Now;
        private DateTime _DateArchived = DAL.MaximumDateTime;
        private DateTime _DateDeleted = DAL.MaximumDateTime;
        private int _CRN = 0;
        private bool _RequiresMoodle = true;
        private bool _RequiresPermission = false;
        private string _Notes = "";
        private string _DepartmentComments = "";
        private string _Number = "1";
        private DateTime _StartTime;
        private DateTime _EndTime;
        private List<InstructorToSection> _Instructors;
        private int _PrimaryInstructorID = -1;
        private int _PrimaryInstructorPercent;
        private Instructor _PrimaryInstructor;
        private int _SecondaryInstructorID = -1;
        private int _SecondaryInstructorPercent;
        private Instructor _SecondaryInstructor;
        private List<Day> _Days;
        private Fee _Fee;
        private int _FeeID;
        private int _CrossListedSectionID = -1;
        #endregion

        #region Public Variables    
        /// <summary>
        /// gets and sets the XListID attribute for this Course
        /// </summary>
        [DisplayName("Cross List ID")]
        public string XListID {
            get { return _XListID; }
            set {
                if (value != null) {
                    _XListID = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the Number attribute for this Section
        /// </summary>
        [DisplayName("Section Number")]
        public string Number {
            get { return _Number; }
            set {
                if (value != null) {
                    _Number = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the DepartmentComments attribute for this Section
        /// </summary>
        [DisplayName("Dept. Comments")]
        public string DepartmentComments {
            get => _DepartmentComments;
            set {
                if (value != null) {
                    _DepartmentComments = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the Notes attribute for this Section
        /// </summary>
        public string Notes {
            get => _Notes;
            set {
                if (value != null) {
                    _Notes = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the RequiresPermission attribute for this Section
        /// </summary>
        [DisplayName("Requires Permission?")]
        [UIHint("Checkbox")]
        public bool RequiresPermission {
            get => _RequiresPermission;
            set => _RequiresPermission = value;
        }
        /// <summary>
        /// gets and sets the RequiresMoodle attribute for this Section
        /// </summary>
        [DisplayName("Requires Moodle?")]
        [UIHint("Checkbox")]
        public bool RequiresMoodle {
            get => _RequiresMoodle;
            set => _RequiresMoodle = value;
        }
        /// <summary>
        /// gets and sets the CRN attribute for this Section
        /// </summary>
        public int CRN {
            get => _CRN;
            set => _CRN = value;
        }
        /// <summary>
        /// gets and sets the DateArchived attribute for this Section
        /// </summary>
        [DisplayName("Date Archived")]
        public DateTime DateArchived {
            get => _DateArchived;
            set => _DateArchived = value;
        }
        /// <summary>
        /// gets and sets the DateCreated attribute for this Section
        /// </summary>
        [DisplayName("Date Created")]
        public DateTime DateCreated {
            get => _DateCreated;
            set => _DateCreated = value;
        }
        /// <summary>
        /// gets and sets the DateDeleted attribute for this Section
        /// </summary>
        [DisplayName("Date Deleted")]
        public DateTime DateDeleted {
            get => _DateDeleted;
            set => _DateDeleted = value;
        }
        /// <summary>
        /// gets and sets the StudentLimit attribute for this Section
        /// </summary>
        [DisplayName("Student Limit")]
        public int StudentLimit {
            get => _StudentLimit;
            set => _StudentLimit = value;
        }
        /// <summary>
        /// gets and sets the PartOfTermID attribute for this Section
        /// </summary>
        public int PartOfTermID {
            get => _PartOfTermID;
            set => _PartOfTermID = value;
        }
        /// <summary>
        /// gets and sets the AcademicSemesterID attribute for this Section
        /// </summary>
        public int AcademicSemesterID {
            get => _AcademicSemesterID;
            set => _AcademicSemesterID = value;
        }
        /// <summary>
        /// gets and sets the ScheduleTypeID attribute for this Section
        /// </summary>
        public int ScheduleTypeID {
            get => _ScheduleTypeID;
            set => _ScheduleTypeID = value;
        }
        /// <summary>
        /// gets and sets the RoomID attribute for this Section
        /// </summary>
        public int RoomID {
            get => _RoomID;
            set => _RoomID = value;
        }
        /// <summary>
        /// gets and sets the CourseID attribute for this Section
        /// </summary>
        public int CourseID {
            get => _CourseID;
            set => _CourseID = value;
        }

        /// <summary>
        /// gets and sets the StartTime attribute for this Section
        /// </summary>
        [DisplayName("Start Time")]
        [DisplayFormat(DataFormatString = "{0:HH:mm}", ApplyFormatInEditMode = true)]
        public DateTime StartTime {
            get { return _StartTime; }
            set { _StartTime = value; }
        }

        [DisplayName("Start Time")]
        public string StartTimeDisplay {
            get { return StartTime.ToString(DAL.TimeFormat); }
        }

        /// <summary>
        /// gets and sets the EndTime attribute for this Section
        /// </summary>
        [DisplayName("End Time")]
        [DisplayFormat(DataFormatString = "{0:HH:mm}", ApplyFormatInEditMode = true)]
        public DateTime EndTime {
            get { return _EndTime; }
            set { _EndTime = value; }
        }
        [DisplayName("End Time")]
        public string EndTimeDisplay {
            get {
                return EndTime.ToString(DAL.TimeFormat);
            }
        }

        /// <summary>
        /// gets and sets the Room attribute for this Section
        /// </summary>
        public Room Room {
            get {
                if (_Room == null) {
                    _Room = DAL.GetRoom(_RoomID);
                }
                return _Room;
            }
            set {
                _Room = value;
                if (value == null) {
                    _RoomID = -1;
                }
                else {
                    _RoomID = value.ID;
                }
            }
        }

        /// <summary>
        /// gets and sets the AcademicSemester attribute for this Section
        /// </summary>
        [DisplayName("Academic Semester")]
        public AcademicSemester AcademicSemester {
            get {
                if (_AcademicSemester == null) {
                    _AcademicSemester = DAL.GetAcademicSemester(_AcademicSemesterID);
                }
                return _AcademicSemester;
            }
            set {
                _AcademicSemester = value;
                if (value == null) {
                    _AcademicSemesterID = -1;
                }
                else {
                    _AcademicSemesterID = value.ID;
                }
            }
        }
        /// <summary>
        /// gets and sets the PartOfTerm attribute for this Section
        /// </summary>
        [DisplayName("Part of Term")]
        public PartOfTerm PartOfTerm {
            get {
                if (_PartOfTerm == null) {
                    _PartOfTerm = DAL.GetPartOfTerm(_PartOfTermID);
                }
                return _PartOfTerm;
            }
            set {
                _PartOfTerm = value;
                if (value == null) {
                    _PartOfTermID = -1;
                }
                else {
                    _PartOfTermID = value.ID;
                }
            }
        }
        /// <summary>
        /// gets and sets the ScheduleType attribute for this Section
        /// </summary>
        [DisplayName("Schedule Type")]
        public ScheduleType ScheduleType {
            get {
                if (_ScheduleType == null) {
                    _ScheduleType = DAL.GetScheduleType(_ScheduleTypeID);
                }
                return _ScheduleType;
            }
            set {
                _ScheduleType = value;
                if (value == null) {
                    _ScheduleTypeID = -1;
                }
                else {
                    _ScheduleTypeID = value.ID;
                }
            }
        }
        /// <summary>
        /// gets and sets the Course attribute for this Section
        /// </summary>
        public Course Course {
            get {
                if (_Course == null) {
                    _Course = DAL.GetCourse(_CourseID);
                }
                return _Course;
            }
            set {
                _Course = value;
                if (value == null) {
                    _CourseID = -1;
                }
                else {
                    _CourseID = value.ID;
                }
            }
        }

        /// <summary>
        /// gets and sets the Days attribute for this Section
        /// </summary>
        [Required]
        public List<Day> Days {
            get {
                if (_Days == null) {
                    _Days = DAL.GetDaysBySectionID(ID);
                }
                return _Days;
            }
            set { _Days = value; }
        }

        /// <summary>
        /// gets and sets the PrimaryInstructorID attribute for this Section
        /// </summary>
        public int PrimaryInstructorID {
            get { return _PrimaryInstructorID; }
            set { _PrimaryInstructorID = value; }
        }


        /// <summary>
        /// gets and sets the PrimaryInstructor attribute for this Section
        /// </summary>
        [DisplayName("Secondary Instructor")]
        public Instructor SecondaryInstructor {
            get {
                if (_SecondaryInstructor == null) {
                    _SecondaryInstructor = DAL.GetInstructor(SecondaryInstructorID);
                }
                return _SecondaryInstructor;
            }
            set {
                _SecondaryInstructor = value;
                if (_SecondaryInstructor == null) {
                    _SecondaryInstructorID = -1;
                }
                else {
                    _SecondaryInstructorID = value.ID;
                }
            }
        }

        /// <summary>
        /// gets and sets the SecondaryInstructorID attribute for this Section
        /// </summary>
        public int SecondaryInstructorID {
            get { return _SecondaryInstructorID; }
            set { _SecondaryInstructorID = value; }
        }

        /// <summary>
        /// gets and sets the PrimaryInstructor attribute for this Section
        /// </summary>
        [DisplayName("Primary Instructor")]
        public Instructor PrimaryInstructor {
            get {
                if (_PrimaryInstructor == null) {
                    _PrimaryInstructor = DAL.GetInstructor(PrimaryInstructorID);
                }
                return _PrimaryInstructor;
            }
            set {
                _PrimaryInstructor = value;
                if (_PrimaryInstructor == null) {
                    _PrimaryInstructorID = -1;
                }
                else {
                    _PrimaryInstructorID = value.ID;
                }
            }
        }

        /// <summary>
        /// gets and sets the PrimaryInstructor attribute for this Section
        /// </summary>
        [DisplayName("Instructors")]
        [Required]
        public List<InstructorToSection> Instructors {
            get {
                if (_Instructors == null) {
                    _Instructors = DAL.GetInstructorsBySectionID(ID);
                }
                return _Instructors;
            }
            set { _Instructors = value; }
        }

        /// <summary>
        /// gets and sets the SectionFeeID attribute for this Section
        /// </summary>
        public int FeeID {
            get { return _FeeID; }
            set { _FeeID = value; }
        }

        /// <summary>
        /// gets and sets the SectionPrimaryInstructorPercent attribute for this Section
        /// </summary>
        [DisplayName("Primary Instructor Teaching Percent")]
        public int PrimaryInstructorPercent {
            get { return _PrimaryInstructorPercent; }
            set { _PrimaryInstructorPercent = value; }
        }

        /// <summary>
        /// gets and sets the SectionSecondaryInstructorPercent attribute for this Section
        /// </summary>
        [DisplayName("Secondary Instructor Teaching Percent")]
        public int SecondaryInstructorPercent {
            get { return _SecondaryInstructorPercent; }
            set { _SecondaryInstructorPercent = value; }
        }

        /// <summary>
        /// gets and sets the Fee attribute for this Section
        /// </summary>
        public Fee Fee {
            get {
                if (_Fee == null) {
                    _Fee = DAL.GetFee(_FeeID);
                }
                return _Fee;
            }
            set {
                _Fee = value;
                if (value == null) {
                    _FeeID = -1;
                }
                else {
                    _FeeID = value.ID;
                }
            }
        }

        /// <summary>
        /// gets and sets the SectionCrossListSectionID attribute for this Section
        /// </summary>
        public int CrossListedSectionID {
            get { return _CrossListedSectionID; }
            set { _CrossListedSectionID = value; }
        }

        /// <summary>
        /// gets the string representation of the Sections days in their abbreviated form
        /// </summary>
        [DisplayName("Days")]
        public string DayDisplay {
            get {
                string days = "";
                foreach (Day day in Days) {
                    days += (day.Abbreviation) + " ";
                }
                return days;
            }
        }

        /// <summary>
        /// gets the string representation of the Sections days in their abbreviated form
        /// </summary>
        [DisplayName("Student Limit")]
        public string StudentLimitDisplay {
            get {
                if (StudentLimit == 0) {
                    return "";
                }
                else {
                    return StudentLimit.ToString();
                }
            }
        }

        [DisplayName("Section")]
        public string SectionNumberAndCourseName {
            get {
                if (Course != null) {
                    return Course.Name + "-" + Number;
                }
                return "";
            }
        }

        #endregion

        #region public functions
        /// <summary>
        /// scans through sectionDays and archives those that aren't used and creates those that don't exist yet
        /// </summary>
        /// <param name="sectionID"></param>
        /// <param name="section"></param>
        public void SetUpDays(List<string> daysFromForm, List<Day> days) {
            Days.Clear();
            List<SectionDay> sectionDays = DAL.GetSectionDaysBySectionID(ID, true);
            foreach (Day day in days) {
                if (!daysFromForm.Contains(day.Name)) {
                    ArchiveMatchingSectionDay(sectionDays, day);
                }
                else {
                    bool foundMatch = UnarchiveMatchingSectionDay(sectionDays, day);
                    if (!foundMatch) {
                        AddSectionDay(day);
                    }
                    Days.Add(day);
                }
            }
        }

        /// <summary>
        /// takes a timespan and converts it to simple military time
        /// </summary>
        /// <param name="timeToConvert"></param>
        /// <returns></returns>
        public string GetTimeInSpreadsheetFormat(TimeSpan timeToConvert) {
            string retVal = "";
            retVal = timeToConvert.ToString(@"hh\:mm");
            if (retVal == "00:00") {
                retVal = "";
            }
            retVal = retVal.TrimStart('0');
            retVal = retVal.Replace(":", "");
            return retVal;
        }

        /// <summary>
        /// archives the SectionDay found in a list with the matching Day
        /// </summary>
        /// <param name="sectionDays"></param>
        /// <param name="day"></param>
        private void ArchiveMatchingSectionDay(List<SectionDay> sectionDays, Day day) {
            int sectionDayIndex = 0;
            while (sectionDayIndex < sectionDays.Count) {
                if (sectionDays[sectionDayIndex].DayID == day.ID) {
                    if (sectionDays[sectionDayIndex].DateArchived > DateTime.Now) {
                        sectionDays[sectionDayIndex].DateArchived = DateTime.Now;
                        DAL.UpdateSectionDay(sectionDays[sectionDayIndex]);
                    }
                    sectionDays.Remove(sectionDays[sectionDayIndex]);
                    sectionDayIndex = sectionDays.Count;
                }
                sectionDayIndex++;
            }
        }

        /// <summary>
        /// unarchives the SectionDay found in a list with the matching Day
        /// </summary>
        /// <param name="sectionDays"></param>
        /// <param name="day"></param>
        /// <returns></returns>
        private bool UnarchiveMatchingSectionDay(List<SectionDay> sectionDays, Day day) {
            bool foundMatch = false;
            int sectionDayIndex = 0;
            while (sectionDayIndex < sectionDays.Count && !foundMatch) {
                if (sectionDays[sectionDayIndex].DayID == day.ID) {
                    sectionDays[sectionDayIndex].DateArchived = DAL.MaximumDateTime;
                    DAL.UpdateSectionDay(sectionDays[sectionDayIndex]);
                    sectionDays.Remove(sectionDays[sectionDayIndex]);
                    sectionDayIndex = sectionDays.Count;
                    foundMatch = true;
                }
                sectionDayIndex++;
            }
            return foundMatch;
        }

        /// <summary>
        /// adds a SectionDay with a given section and day
        /// </summary>
        /// <param name="section"></param>
        /// <param name="day"></param>
        /// <param name="foundMatch"></param>
        private void AddSectionDay(Day day) {
            SectionDay newSectionDay = new SectionDay();
            newSectionDay.SectionID = ID;
            newSectionDay.DayID = day.ID;
            DAL.AddSectionDay(newSectionDay);
        }

        public void GetInstructorDetails() {
            List<InstructorToSection> instructorToSections = Instructors;
            foreach (InstructorToSection its in instructorToSections) {
                if (its.IsPrimary) {
                    PrimaryInstructorID = its.InstructorID;
                    PrimaryInstructorPercent = its.TeachingPercentage;
                }
                else {
                    SecondaryInstructorID = its.InstructorID;
                    SecondaryInstructorPercent = its.TeachingPercentage;
                }
            }
        }
        #endregion

        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _AcademicSemesterID = dr.GetInt32(db_AcademicSemesterID);
            _CourseID = dr.GetInt32(db_CourseID);
            _PartOfTermID = dr.GetInt32(db_PartOfTermID);
            _FeeID = dr.GetInt32(db_FeeID);
            _RoomID = dr.GetInt32(db_RoomID);
            _ScheduleTypeID = dr.GetInt32(db_ScheduleTypeID);
            _StartTime = (DateTime)dr.GetMySqlDateTime(db_StartTime);
            _EndTime = (DateTime)dr.GetMySqlDateTime(db_EndTime);
            _StudentLimit = dr.GetInt32(db_StudentLimit);
            _XListID = dr.GetString(db_XListID);
            _FeeID = dr.GetInt32(db_FeeID);
            _CrossListedSectionID = dr.GetInt32(db_CrossListedSectionID);
            _CRN = dr.GetInt32(db_CRN);
            _DateArchived = (DateTime)dr.GetMySqlDateTime(db_DateArchived);
            _DateCreated = (DateTime)dr.GetMySqlDateTime(db_DateCreated);
            _DateDeleted = (DateTime)dr.GetMySqlDateTime(db_DateDeleted);
            _DepartmentComments = dr.GetString(db_DepartmentComments);
            _Notes = dr.GetString(db_Notes);
            _Number = dr.GetString(db_Number);
            _RequiresMoodle = dr.GetBoolean(db_RequiresMoodle);
            _RequiresPermission = dr.GetBoolean(db_RequiresPermission);
        }
    }
}
