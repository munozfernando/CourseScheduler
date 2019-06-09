/* Model for ChangeLogs
 * ChangeLog: keeps track of the changes made to a section for formatting
 * Created on 3/4/19 by Jason Durfee
 */

using System;
using MySql.Data.MySqlClient;

namespace ClassScheduler.Models
{
    public class ChangeLog : DatabaseObject
    {
        public ChangeLog()
        {

        }

        public ChangeLog(MySqlDataReader dr)
        {
            Fill(dr);
        }

        #region private variables
        private int _SectionID;
        private DateTime _DateCreated;
        private DateTime _DateDeleted;
        private DateTime _DateImported;
        private bool _ChangedDepartment = false;
        private bool _ChangedCourseNumber = false;
        private bool _ChangedSectionNumber = false;
        private bool _ChangedTitle = false;
        private bool _ChangedCampus = false;
        private bool _ChangedScheduleType = false;
        private bool _ChangedMoodleRequired = false;
        private bool _ChangedInstructorApproval = false;
        private bool _ChangedPartOfTerm = false;
        private bool _ChangedFixedCredits = false;
        private bool _ChangedMinCredits = false;
        private bool _ChangedMaxCredits = false;
        private bool _ChangedStudentLimit = false;
        private bool _ChangedMonday = false;
        private bool _ChangedTuesday = false;
        private bool _ChangedWednesday = false;
        private bool _ChangedThursday = false;
        private bool _ChangedFriday = false;
        private bool _ChangedSaturday = false;
        private bool _ChangedSunday = false;
        private bool _ChangedStartTime = false;
        private bool _ChangedEndTime = false;
        private bool _ChangedBuilding = false;
        private bool _ChangedRoom = false;
        private bool _ChangedPrimeInstructor = false;
        private bool _ChangedPrimeInstructorPercent = false;
        private bool _ChangedSecondInstructor = false;
        private bool _ChangedSecondInstructorPercent = false;
        private bool _ChangedSectionNotes = false;
        private bool _ChangedCrossListedSection = false;
        private bool _ChangedCrossListedDepartment = false;
        private bool _ChangedDepartmentComments = false;

        internal const string db_ID = "ChangeLogID";
        internal const string db_SectionID = "SectionID";
        internal const string db_DateCreated = "DateCreated";
        internal const string db_DateDeleted = "DateDeleted";
        internal const string db_DateImported = "DateImported";
        internal const string db_ChangedDepartment = "ChangedDepartment";
        internal const string db_ChangedCourseNumber = "ChangedCourseNumber";
        internal const string db_ChangedSectionNumber = "ChangedSectionNumber";
        internal const string db_ChangedTitle = "ChangedTitle";
        internal const string db_ChangedCampus = "ChangedCampus";
        internal const string db_ChangedScheduleType = "ChangedScheduleType";
        internal const string db_ChangedMoodleRequired = "ChangedRequiresMoodle";
        internal const string db_ChangedInstructorApproval = "ChangedRequiresPermission";
        internal const string db_ChangedPartOfTerm = "ChangedPartOfTerm";
        internal const string db_ChangedFixedCredits = "ChangedFixedCredit";
        internal const string db_ChangedMinCredits = "ChangedCreditMin";
        internal const string db_ChangedMaxCredits = "ChangedCreditMax";
        internal const string db_ChangedStudentLimit = "ChangedStudentLimit";
        internal const string db_ChangedMonday = "ChangedMonday";
        internal const string db_ChangedTuesday = "ChangedTuesday";
        internal const string db_ChangedWednesday = "ChangedWednesday";
        internal const string db_ChangedThursday = "ChangedThursday";
        internal const string db_ChangedFriday = "ChangedFriday";
        internal const string db_ChangedSaturday = "ChangedSaturday";
        internal const string db_ChangedSunday = "ChangedSunday";
        internal const string db_ChangedStartTime = "ChangedStartTime";
        internal const string db_ChangedEndTime = "ChangedEndTime";
        internal const string db_ChangedBuilding = "ChangedBuilding";
        internal const string db_ChangedRoom = "ChangedRoom";
        internal const string db_ChangedPrimeInstructor = "ChangedPrimeInstructor";
        internal const string db_ChangedPrimeInstructorPercent = "ChangedPrimeInstructorPercent";
        internal const string db_ChangedSecondInstructor = "ChangedSecondInstructor";
        internal const string db_ChangedSecondInstructorPercent = "ChangedSecondInstructorPercent";
        internal const string db_ChangedSectionNotes = "ChangedSectionNotes";
        internal const string db_ChangedCrossListedSection = "ChangedCrossListedSection";
        internal const string db_ChangedCrossListedDepartment = "ChangedCrossListedDepartment";
        internal const string db_ChangedDepartmentComments = "ChangedDepartmentComments";

        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the SectionID attribute for this ChangeLog
        /// </summary>

        public int SectionID {
            get { return _SectionID; }
            set { _SectionID = value; }
        }

        /// <summary>
        /// gets and sets the DateCreated attribute for this ChangeLog
        /// </summary>

        public DateTime DateCreated {
            get { return _DateCreated; }
            set { _DateCreated = value; }
        }

        /// <summary>
        /// gets and sets the DateImported attribute for this ChangeLog
        /// </summary>

        public DateTime DateImported {
            get { return _DateImported; }
            set { _DateImported = value; }
        }

        /// <summary>
        /// gets and sets the DateDeleted attribute for this ChangeLog
        /// </summary>

        public DateTime DateDeleted {
            get { return _DateDeleted; }
            set { _DateDeleted = value; }
        }

        /// <summary>
        /// gets and sets the ChangedSubject attribute for this ChangeLog
        /// </summary>

        public bool ChangedDepartment {
            get { return _ChangedDepartment; }
            set { _ChangedDepartment = value; }
        }

        /// <summary>
        /// gets and sets the ChangedCourseNumber attribute for this ChangeLog
        /// </summary>

        public bool ChangedCourseNumber {
            get { return _ChangedCourseNumber; }
            set { _ChangedCourseNumber = value; }
        }

        /// <summary>
        /// gets and sets the ChangedSectionNumber attribute for this ChangeLog
        /// </summary>

        public bool ChangedSectionNumber {
            get { return _ChangedSectionNumber; }
            set { _ChangedSectionNumber = value; }
        }

        /// <summary>
        /// gets and sets the ChangedCourseTitle attribute for this ChangeLog
        /// </summary>

        public bool ChangedTitle {
            get { return _ChangedTitle; }
            set { _ChangedTitle = value; }
        }

        /// <summary>
        /// gets and sets the ChangedCampus attribute for this ChangeLog
        /// </summary>

        public bool ChangedCampus {
            get { return _ChangedCampus; }
            set { _ChangedCampus = value; }
        }

        /// <summary>
        /// gets and sets the ChangedScheduleType attribute for this ChangeLog
        /// </summary>

        public bool ChangedScheduleType {
            get { return _ChangedScheduleType; }
            set { _ChangedScheduleType = value; }
        }

        /// <summary>
        /// gets and sets the ChangedMoodleRequired attribute for this ChangeLog
        /// </summary>

        public bool ChangedMoodleRequired {
            get { return _ChangedMoodleRequired; }
            set { _ChangedMoodleRequired = value; }
        }

        /// <summary>
        /// gets and sets the ChangedInstructorApproval attribute for this ChangeLog
        /// </summary>

        public bool ChangedInstructorApproval {
            get { return _ChangedInstructorApproval; }
            set { _ChangedInstructorApproval = value; }
        }

        /// <summary>
        /// gets and sets the ChangedPartOfTerm attribute for this ChangeLog
        /// </summary>

        public bool ChangedPartOfTerm {
            get { return _ChangedPartOfTerm; }
            set { _ChangedPartOfTerm = value; }
        }

        /// <summary>
        /// gets and sets the ChangedFixedCredit attribute for this ChangeLog
        /// </summary>

        public bool ChangedFixedCredit {
            get { return _ChangedFixedCredits; }
            set { _ChangedFixedCredits = value; }
        }

        /// <summary>
        /// gets and sets the ChangedMinCredits attribute for this ChangeLog
        /// </summary>

        public bool ChangedMinCredits {
            get { return _ChangedMinCredits; }
            set { _ChangedMinCredits = value; }
        }

        /// <summary>
        /// gets and sets the ChangedMaxCredits attribute for this ChangeLog
        /// </summary>

        public bool ChangedMaxCredits {
            get { return _ChangedMaxCredits; }
            set { _ChangedMaxCredits = value; }
        }

        /// <summary>
        /// gets and sets the ChangedClassLimit attribute for this ChangeLog
        /// </summary>

        public bool ChangedStudentLimit {
            get { return _ChangedStudentLimit; }
            set { _ChangedStudentLimit = value; }
        }

        /// <summary>
        /// gets and sets the ChangedMonday attribute for this ChangeLog
        /// </summary>

        public bool ChangedMonday {
            get { return _ChangedMonday; }
            set { _ChangedMonday = value; }
        }

        /// <summary>
        /// gets and sets the ChangedTuesday attribute for this ChangeLog
        /// </summary>

        public bool ChangedTuesday {
            get { return _ChangedTuesday; }
            set { _ChangedTuesday = value; }
        }

        /// <summary>
        /// gets and sets the ChangedWednesday attribute for this ChangeLog
        /// </summary>

        public bool ChangedWednesday {
            get { return _ChangedWednesday; }
            set { _ChangedWednesday = value; }
        }

        /// <summary>
        /// gets and sets the ChangedThursday attribute for this ChangeLog
        /// </summary>

        public bool ChangedThursday {
            get { return _ChangedThursday; }
            set { _ChangedThursday = value; }
        }

        /// <summary>
        /// gets and sets the ChangedFriday attribute for this ChangeLog
        /// </summary>

        public bool ChangedFriday {
            get { return _ChangedFriday; }
            set { _ChangedFriday = value; }
        }

        /// <summary>
        /// gets and sets the ChangedSaturday attribute for this ChangeLog
        /// </summary>

        public bool ChangedSaturday {
            get { return _ChangedSaturday; }
            set { _ChangedSaturday = value; }
        }

        /// <summary>
        /// gets and sets the ChangedSunday attribute for this ChangeLog
        /// </summary>

        public bool ChangedSunday {
            get { return _ChangedSunday; }
            set { _ChangedSunday = value; }
        }

        /// <summary>
        /// gets and sets the ChangedStartTime attribute for this ChangeLog
        /// </summary>

        public bool ChangedStartTime {
            get { return _ChangedStartTime; }
            set { _ChangedStartTime = value; }
        }

        /// <summary>
        /// gets and sets the ChangedEndTime attribute for this ChangeLog
        /// </summary>

        public bool ChangedEndTime {
            get { return _ChangedEndTime; }
            set { _ChangedEndTime = value; }
        }

        /// <summary>
        /// gets and sets the ChangedBuilding attribute for this ChangeLog
        /// </summary>

        public bool ChangedBuilding {
            get { return _ChangedBuilding; }
            set { _ChangedBuilding = value; }
        }

        /// <summary>
        /// gets and sets the ChangedRoom attribute for this ChangeLog
        /// </summary>

        public bool ChangedRoom {
            get { return _ChangedRoom; }
            set { _ChangedRoom = value; }
        }

        /// <summary>
        /// gets and sets the ChangedPrimeInstructor attribute for this ChangeLog
        /// </summary>

        public bool ChangedPrimeInstructor {
            get { return _ChangedPrimeInstructor; }
            set { _ChangedPrimeInstructor = value; }
        }

        /// <summary>
        /// gets and sets the ChangedPrimeInstructorPercentage attribute for this ChangeLog
        /// </summary>

        public bool ChangedPrimeInstructorPercent {
            get { return _ChangedPrimeInstructorPercent; }
            set { _ChangedPrimeInstructorPercent = value; }
        }

        /// <summary>
        /// gets and sets the ChangedSecondInstructor attribute for this ChangeLog
        /// </summary>

        public bool ChangedSecondInstructor {
            get { return _ChangedSecondInstructor; }
            set { _ChangedSecondInstructor = value; }
        }

        /// <summary>
        /// gets and sets the ChangedSecondInstructorPercentage attribute for this ChangeLog
        /// </summary>

        public bool ChangedSecondInstructorPercent {
            get { return _ChangedSecondInstructorPercent; }
            set { _ChangedSecondInstructorPercent = value; }
        }

        /// <summary>
        /// gets and sets the ChangedNotes attribute for this ChangeLog
        /// </summary>

        public bool ChangedSectionNotes {
            get { return _ChangedSectionNotes; }
            set { _ChangedSectionNotes = value; }
        }

        /// <summary>
        /// gets and sets the ChangedCrossListSubject attribute for this ChangeLog
        /// </summary>

        public bool ChangedCrossListedSection {
            get { return _ChangedCrossListedSection; }
            set { _ChangedCrossListedSection = value; }
        }

        /// <summary>
        /// gets and sets the ChangedCrossListCourse attribute for this ChangeLog
        /// </summary>

        public bool ChangedCrossListedDepartment {
            get { return _ChangedCrossListedDepartment; }
            set { _ChangedCrossListedDepartment = value; }
        }

        /// <summary>
        /// gets and sets the ChangedDepartmentComments attribute for this ChangeLog
        /// </summary>

        public bool ChangedDepartmentComments {
            get { return _ChangedDepartmentComments; }
            set { _ChangedDepartmentComments = value; }
        }
        #endregion

        #region public functions

        #endregion
        public override void Fill(MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _SectionID = dr.GetInt32(db_SectionID);
            _DateCreated = (DateTime)dr.GetMySqlDateTime(db_DateCreated);
            _DateDeleted = (DateTime)dr.GetMySqlDateTime(db_DateDeleted);
            _DateImported = (DateTime)dr.GetMySqlDateTime(db_DateImported);
            _ChangedDepartment = dr.GetBoolean(db_ChangedDepartment);
            _ChangedCourseNumber = dr.GetBoolean(db_ChangedCourseNumber);
            _ChangedSectionNumber = dr.GetBoolean(db_ChangedSectionNumber);
            _ChangedTitle = dr.GetBoolean(db_ChangedTitle);
            _ChangedCampus = dr.GetBoolean(db_ChangedCampus);
            _ChangedScheduleType = dr.GetBoolean(db_ChangedScheduleType);
            _ChangedMoodleRequired = dr.GetBoolean(db_ChangedMoodleRequired);
            _ChangedInstructorApproval = dr.GetBoolean(db_ChangedInstructorApproval);
            _ChangedPartOfTerm = dr.GetBoolean(db_ChangedPartOfTerm);
            _ChangedFixedCredits = dr.GetBoolean(db_ChangedFixedCredits);
            _ChangedMinCredits = dr.GetBoolean(db_ChangedMinCredits);
            _ChangedMaxCredits = dr.GetBoolean(db_ChangedMaxCredits);
            _ChangedStudentLimit = dr.GetBoolean(db_ChangedStudentLimit);
            _ChangedMonday = dr.GetBoolean(db_ChangedMonday);
            _ChangedTuesday = dr.GetBoolean(db_ChangedTuesday);
            _ChangedWednesday = dr.GetBoolean(db_ChangedWednesday);
            _ChangedThursday = dr.GetBoolean(db_ChangedThursday);
            _ChangedFriday = dr.GetBoolean(db_ChangedFriday);
            _ChangedSaturday = dr.GetBoolean(db_ChangedSaturday);
            _ChangedSunday = dr.GetBoolean(db_ChangedSunday);
            _ChangedStartTime = dr.GetBoolean(db_ChangedStartTime);
            _ChangedEndTime = dr.GetBoolean(db_ChangedEndTime);
            _ChangedBuilding = dr.GetBoolean(db_ChangedBuilding);
            _ChangedRoom = dr.GetBoolean(db_ChangedRoom);
            _ChangedPrimeInstructor = dr.GetBoolean(db_ChangedPrimeInstructor);
            _ChangedPrimeInstructorPercent = dr.GetBoolean(db_ChangedPrimeInstructorPercent);
            _ChangedSecondInstructor = dr.GetBoolean(db_ChangedSecondInstructor);
            _ChangedSecondInstructorPercent = dr.GetBoolean(db_ChangedSecondInstructorPercent);
            _ChangedSectionNotes = dr.GetBoolean(db_ChangedSectionNotes);
            _ChangedCrossListedSection = dr.GetBoolean(db_ChangedCrossListedSection);
            _ChangedCrossListedDepartment = dr.GetBoolean(db_ChangedCrossListedDepartment);
            _ChangedDepartmentComments = dr.GetBoolean(db_ChangedDepartmentComments);
        }
    }
}
