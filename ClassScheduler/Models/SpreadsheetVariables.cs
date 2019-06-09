/* Model for ColumnAliases
 * ColumnAlias: the text found in the header of a column to asscociate with section details
 * Created on 3/3/19 by Jason Durfee
 */

using MySql.Data.MySqlClient;
using OfficeOpenXml;

namespace ClassScheduler.Models
{
    public class SpreadsheetVariables : DatabaseObject
    {
        public SpreadsheetVariables() {

        }

        public SpreadsheetVariables(MySqlDataReader dr) {
            Fill(dr);
        }
        #region constant strings
        internal const string db_ID = "SpreadsheetVariablesID";
        internal const string db_Spreadsheet = "Spreadsheet";
        internal const string db_StartingRowNumber = "StartingRowNumber";
        internal const string db_AcademicSemester = "AcademicSemester";
        internal const string db_AddChangeDelete = "AddChangeDelete";
        internal const string db_SectionCRN = "SectionCRN";
        internal const string db_Department = "Department";
        internal const string db_CourseNumber = "CourseNumber";
        internal const string db_SectionNumber = "SectionNumber";
        internal const string db_CrossListID = "CrossListID";
        internal const string db_CourseTitle = "CourseTitle";
        internal const string db_Campus = "Campus";
        internal const string db_ScheduleType = "ScheduleType";
        internal const string db_MoodleRequired = "MoodleRequired";
        internal const string db_InstructorApprovalRequired = "InstructorApprovalRequired";
        internal const string db_PartOfTerm = "PartOfTerm";
        internal const string db_FixedCredit = "FixedCredit";
        internal const string db_MinimumCredits = "MinimumCredits";
        internal const string db_MaximumCredits = "MaximumCredits";
        internal const string db_ClassLimit = "ClassLimit";
        internal const string db_Monday = "Monday";
        internal const string db_Tuesday = "Tuesday";
        internal const string db_Wednesday = "Wednesday";
        internal const string db_Thursday = "Thursday";
        internal const string db_Friday = "Friday";
        internal const string db_Saturday = "Saturday";
        internal const string db_Sunday = "Sunday";
        internal const string db_StartTime = "StartTime";
        internal const string db_EndTime = "EndTime";
        internal const string db_Building = "Building";
        internal const string db_Room = "Room";
        internal const string db_PrimaryInstructorFirstName = "PrimaryInstructorFirstName";
        internal const string db_PrimaryInstructorLastName = "PrimaryInstructorLastName";
        internal const string db_PrimaryInstructorNumber = "PrimaryInstructorNumber";
        internal const string db_PrimaryInstructorTeachingPercent = "PrimaryInstructorTeachingPercent";
        internal const string db_SecondaryInstructorFirstName = "SecondaryInstructorFirstName";
        internal const string db_SecondaryInstructorLastName = "SecondaryInstructorLastName";
        internal const string db_SecondaryInstructorNumber = "SecondaryInstructorNumber";
        internal const string db_SecondaryInstructorTeachingPercent = "SecondaryInstructorTeachingPercent";
        internal const string db_ClassFeeDetailCode = "ClassFeeDetailCode";
        internal const string db_ClassFeeAmount = "ClassFeeAmount";
        internal const string db_SectionNotes = "SectionNotes";
        internal const string db_CrossListSubject = "CrossListSubject";
        internal const string db_CrossListCourseNumber = "CrossListCourseNumber";
        internal const string db_DepartmentComments = "DepartmentComments";
        internal const string db_DefaultFontStyle = "DefaultFontStyle";
        internal const string db_SpringAbbreviation = "SpringAbbreviation";
        internal const string db_SummerAbbreviation = "SummerAbbreviation";
        internal const string db_FallAbbreviation = "FallAbbreviation";
        internal const string db_DefaultFontSize = "DefaultFontSize";
        internal const string db_RequiresPermissionAbbreviation = "RequiresPermissionAbbreviation";
        internal const string db_RequiresMoodleAbbreviation = "RequiresMoodleAbbreviation";
        #endregion

        #region private variables
        private ExcelPackage _Spreadsheet;
        private int _StartingRowNumber = 4;
        private string _AcademicSemester = "A";
        private string _AddChangeDelete = "B";
        private string _SectionCRN = "C";
        private string _Department = "D";
        private string _CourseNumber = "E";
        private string _SectionNumber = "F";
        private string _CrossListID = "G";
        private string _CourseTitle = "H";
        private string _Campus = "I";
        private string _ScheduleType = "J";
        private string _MoodleRequired = "K";
        private string _InstructorApprovalRequired = "L";
        private string _PartOfTerm = "M";
        private string _FixedCredit = "N";
        private string _MinimumCredits = "O";
        private string _MaximumCredits = "P";
        private string _ClassLimit = "Q";
        private string _Monday = "R";
        private string _Tuesday = "S";
        private string _Wednesday = "T";
        private string _Thursday = "U";
        private string _Friday = "V";
        private string _Saturday = "W";
        private string _Sunday = "X";
        private string _StartTime = "Y";
        private string _EndTime = "Z";
        private string _Building = "AA";
        private string _Room = "AB";
        private string _PrimaryInstructorFirstName = "AC";
        private string _PrimaryInstructorLastName = "AD";
        private string _PrimaryInstructorNumber = "AE";
        private string _PrimaryInstructorTeachingPercentage = "AF";
        private string _SecondaryInstructorFirstName = "AG";
        private string _SecondaryInstructorLastName = "AH";
        private string _SecondaryInstructorNumber = "AI";
        private string _SecondaryInstructorTeachingPercentage = "AJ";
        private string _ClassFeeDetailCode = "AK";
        private string _ClassFeeAmount = "AL";
        private string _SectionNotes = "AM";
        private string _CrossListSubject = "AN";
        private string _CrossListCourseNumber = "AO";
        private string _DepartmentComments = "AP";
        private string _DefaultFontStyle = "Calibri";
        private string _SpringAbbreviation = "AS";
        private string _SummerAbbreviation = "ASU";
        private string _FallAbbreviation = "AF";
        private string _RequiresPermissionAbbreviation = "IN";
        private string _RequiresMoodleAbbreviation = "M";
        private int _DefaultFontSize = 11;
        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the Spreadsheet for this ColumnAlias
        /// </summary>
        public ExcelPackage Spreadsheet {
            get { return _Spreadsheet; }
            set { _Spreadsheet = value; }
        }

        /// <summary>
        /// gets and sets the StartRowNumber for this ColumnAlias
        /// </summary>
        public int StartingRowNumber {
            get { return _StartingRowNumber; }
            set { _StartingRowNumber = value; }
        }

        /// <summary>
        /// gets and sets the AcademicSemester text for this ColumnAlias
        /// </summary>
        public string AcademicSemester {
            get { return _AcademicSemester; }
            set { _AcademicSemester = value; }
        }

        /// <summary>
        /// gets and sets the AddChangeDelete text for this ColumnAlias
        /// </summary>
        public string AddChangeDelete {
            get { return _AddChangeDelete; }
            set { _AddChangeDelete = value; }
        }

        /// <summary>
        /// gets and sets the SubjectName text for this ColumnAlias
        /// </summary>
        public string Department {
            get { return _Department; }
            set { _Department = value; }
        }

        /// <summary>
        /// gets and sets the SectionCRN text for this ColumnAlias
        /// </summary>
        public string SectionCRN {
            get { return _SectionCRN; }
            set { _SectionCRN = value; }
        }

        /// <summary>
        /// gets and sets the CourseNumber text for this ColumnAlias
        /// </summary>
        public string CourseNumber {
            get { return _CourseNumber; }
            set { _CourseNumber = value; }
        }

        /// <summary>
        /// gets and sets the SectionNumber text for this ColumnAlias
        /// </summary>
        public string SectionNumber {
            get { return _SectionNumber; }
            set { _SectionNumber = value; }
        }

        /// <summary>
        /// gets and sets the CrossListID text for this ColumnAlias
        /// </summary>
        public string CrossListID {
            get { return _CrossListID; }
            set { _CrossListID = value; }
        }

        /// <summary>
        /// gets and sets the CourseTitle text for this ColumnAlias
        /// </summary>
        public string CourseTitle {
            get { return _CourseTitle; }
            set { _CourseTitle = value; }
        }

        /// <summary>
        /// gets and sets the Campus text for this ColumnAlias
        /// </summary>
        public string Campus {
            get { return _Campus; }
            set { _Campus = value; }
        }

        /// <summary>
        /// gets and sets the ScheduleType text for this ColumnAlias
        /// </summary>
        public string ScheduleType {
            get { return _ScheduleType; }
            set { _ScheduleType = value; }
        }

        /// <summary>
        /// gets and sets the MoodleRequired text for this ColumnAlias
        /// </summary>
        public string MoodleRequired {
            get { return _MoodleRequired; }
            set { _MoodleRequired = value; }
        }

        /// <summary>
        /// gets and sets the InstructorApprovalRequired text for this ColumnAlias
        /// </summary>
        public string InstructorApprovalRequired {
            get { return _InstructorApprovalRequired; }
            set { _InstructorApprovalRequired = value; }
        }

        /// <summary>
        /// gets and sets the PartOfTerm text for this ColumnAlias
        /// </summary>
        public string PartOfTerm {
            get { return _PartOfTerm; }
            set { _PartOfTerm = value; }
        }

        /// <summary>
        /// gets and sets the FixedCredit text for this ColumnAlias
        /// </summary>
        public string FixedCredit {
            get { return _FixedCredit; }
            set { _FixedCredit = value; }
        }

        /// <summary>
        /// gets and sets the MinimumCredits text for this ColumnAlias
        /// </summary>
        public string MinimumCredits {
            get { return _MinimumCredits; }
            set { _MinimumCredits = value; }
        }

        /// <summary>
        /// gets and sets the MaximumCredits text for this ColumnAlias
        /// </summary>
        public string MaximumCredits {
            get { return _MaximumCredits; }
            set { _MaximumCredits = value; }
        }

        /// <summary>
        /// gets and sets the ClassLimit text for this ColumnAlias
        /// </summary>
        public string ClassLimit {
            get { return _ClassLimit; }
            set { _ClassLimit = value; }
        }

        /// <summary>
        /// gets and sets the Monday text for this ColumnAlias
        /// </summary>
        public string Monday {
            get { return _Monday; }
            set { _Monday = value; }
        }

        /// <summary>
        /// gets and sets the Tuesday text for this ColumnAlias
        /// </summary>
        public string Tuesday {
            get { return _Tuesday; }
            set { _Tuesday = value; }
        }

        /// <summary>
        /// gets and sets the Wednesday text for this ColumnAlias
        /// </summary>
        public string Wednesday {
            get { return _Wednesday; }
            set { _Wednesday = value; }
        }

        /// <summary>
        /// gets and sets the Thursday text for this ColumnAlias
        /// </summary>
        public string Thursday {
            get { return _Thursday; }
            set { _Thursday = value; }
        }

        /// <summary>
        /// gets and sets the Friday text for this ColumnAlias
        /// </summary>
        public string Friday {
            get { return _Friday; }
            set { _Friday = value; }
        }

        /// <summary>
        /// gets and sets the Saturday text for this ColumnAlias
        /// </summary>
        public string Saturday {
            get { return _Saturday; }
            set { _Saturday = value; }
        }

        /// <summary>
        /// gets and sets the Sunday text for this ColumnAlias
        /// </summary>
        public string Sunday {
            get { return _Sunday; }
            set { _Sunday = value; }
        }

        /// <summary>
        /// gets and sets the StartTime text for this ColumnAlias
        /// </summary>
        public string StartTime {
            get { return _StartTime; }
            set { _StartTime = value; }
        }

        /// <summary>
        /// gets and sets the EndTime text for this ColumnAlias
        /// </summary>
        public string EndTime {
            get { return _EndTime; }
            set { _EndTime = value; }
        }

        /// <summary>
        /// gets and sets the Building text for this ColumnAlias
        /// </summary>
        public string Building {
            get { return _Building; }
            set { _Building = value; }
        }

        /// <summary>
        /// gets and sets the Room text for this ColumnAlias
        /// </summary>
        public string Room {
            get { return _Room; }
            set { _Room = value; }
        }

        /// <summary>
        /// gets and sets the PrimaryInstructorFirstName text for this ColumnAlias
        /// </summary>
        public string PrimaryInstructorFirstName {
            get { return _PrimaryInstructorFirstName; }
            set { _PrimaryInstructorFirstName = value; }
        }

        /// <summary>
        /// gets and sets the PrimaryInstructorLastName text for this ColumnAlias
        /// </summary>
        public string PrimaryInstructorLastName {
            get { return _PrimaryInstructorLastName; }
            set { _PrimaryInstructorLastName = value; }
        }

        /// <summary>
        /// gets and sets the PrimaryInstructorNumber text for this ColumnAlias
        /// </summary>
        public string PrimaryInstructorNumber {
            get { return _PrimaryInstructorNumber; }
            set { _PrimaryInstructorNumber = value; }
        }

        /// <summary>
        /// gets and sets the PrimaryInstructorTeachingPercentage text for this ColumnAlias
        /// </summary>
        public string PrimaryInstructorTeachingPercentage {
            get { return _PrimaryInstructorTeachingPercentage; }
            set { _PrimaryInstructorTeachingPercentage = value; }
        }

        /// <summary>
        /// gets and sets the SecondaryInstructorFirstName text for this ColumnAlias
        /// </summary>
        public string SecondaryInstructorFirstName {
            get { return _SecondaryInstructorFirstName; }
            set { _SecondaryInstructorFirstName = value; }
        }

        /// <summary>
        /// gets and sets the SecondaryInstructorLastName text for this ColumnAlias
        /// </summary>
        public string SecondaryInstructorLastName {
            get { return _SecondaryInstructorLastName; }
            set { _SecondaryInstructorLastName = value; }
        }

        /// <summary>
        /// gets and sets the SecondaryInstructorNumber text for this ColumnAlias
        /// </summary>
        public string SecondaryInstructorNumber {
            get { return _SecondaryInstructorNumber; }
            set { _SecondaryInstructorNumber = value; }
        }

        /// <summary>
        /// gets and sets the SecondaryInstructorTeachingPercentage text for this ColumnAlias
        /// </summary>
        public string SecondaryInstructorTeachingPercentage {
            get { return _SecondaryInstructorTeachingPercentage; }
            set { _SecondaryInstructorTeachingPercentage = value; }
        }

        /// <summary>
        /// gets and sets the ClassFeeDetailCode text for this ColumnAlias
        /// </summary>
        public string ClassFeeDetailCode {
            get { return _ClassFeeDetailCode; }
            set { _ClassFeeDetailCode = value; }
        }

        /// <summary>
        /// gets and sets the ClassFeeAmount text for this ColumnAlias
        /// </summary>
        public string ClassFeeAmount {
            get { return _ClassFeeAmount; }
            set { _ClassFeeAmount = value; }
        }

        /// <summary>
        /// gets and sets the SectionNotes text for this ColumnAlias
        /// </summary>
        public string SectionNotes {
            get { return _SectionNotes; }
            set { _SectionNotes = value; }
        }

        /// <summary>
        /// gets and sets the CrossListSubject text for this ColumnAlias
        /// </summary>
        public string CrossListSubject {
            get { return _CrossListSubject; }
            set { _CrossListSubject = value; }
        }

        /// <summary>
        /// gets and sets the CrossListCourseNumber text for this ColumnAlias
        /// </summary>
        public string CrossListCourseNumber {
            get { return _CrossListCourseNumber; }
            set { _CrossListCourseNumber = value; }
        }

        /// <summary>
        /// gets and sets the DepartmentComments text for this ColumnAlias
        /// </summary>
        public string DepartmentComments {
            get { return _DepartmentComments; }
            set { _DepartmentComments = value; }
        }

        /// <summary>
        /// gets and sets the DefaultFontStyle text for this ColumnAlias
        /// </summary>
        public string DefaultFontStyle {
            get { return _DefaultFontStyle; }
            set { _DefaultFontStyle = value; }
        }

        /// <summary>
        /// gets and sets the DefaultFontSize text for this ColumnAlias
        /// </summary>
        public int DefaultFontSize {
            get { return _DefaultFontSize; }
            set { _DefaultFontSize = value; }
        }

        /// <summary>
        /// gets and sets the SpringAbbreviation text for this ColumnAlias
        /// </summary>
        public string SpringAbbreviation {
            get { return _SpringAbbreviation; }
            set { _SpringAbbreviation = value; }
        }

        /// <summary>
        /// gets and sets the SummerAbbreviation text for this ColumnAlias
        /// </summary>
        public string SummerAbbreviation {
            get { return _SummerAbbreviation; }
            set { _SummerAbbreviation = value; }
        }

        /// <summary>
        /// gets and sets the FallAbbreviation text for this ColumnAlias
        /// </summary>
        public string FallAbbreviation {
            get { return _FallAbbreviation; }
            set { _FallAbbreviation = value; }
        }


        /// <summary>
        /// gets and sets the RequiresPermissionAbbreviation text for this ColumnAlias
        /// </summary>
        public string RequiresPermissionAbbreviation {
            get { return _RequiresPermissionAbbreviation; }
            set { _RequiresPermissionAbbreviation = value; }
        }


        /// <summary>
        /// gets and sets the RequiresMoodleAbbreviation text for this ColumnAlias
        /// </summary>
        public string RequiresMoodleAbbreviation {
            get { return _RequiresMoodleAbbreviation; }
            set { _RequiresMoodleAbbreviation = value; }
        }

        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _StartingRowNumber = dr.GetInt32(db_StartingRowNumber);
            _AcademicSemester = dr.GetString(db_AcademicSemester);
            _AddChangeDelete = dr.GetString(db_AddChangeDelete);
            _SectionCRN = dr.GetString(db_SectionCRN);
            _Department = dr.GetString(db_Department);
            _CourseNumber = dr.GetString(db_CourseNumber);
            _SectionNumber = dr.GetString(db_SectionNumber);
            _CrossListID = dr.GetString(db_CrossListID);
            _CourseTitle = dr.GetString(db_CourseTitle);
            _Campus = dr.GetString(db_Campus);
            _ScheduleType = dr.GetString(db_ScheduleType);
            _MoodleRequired = dr.GetString(db_MoodleRequired);
            _InstructorApprovalRequired = dr.GetString(db_InstructorApprovalRequired);
            _PartOfTerm = dr.GetString(db_PartOfTerm);
            _FixedCredit = dr.GetString(db_FixedCredit);
            _MinimumCredits = dr.GetString(db_MinimumCredits);
            _MaximumCredits = dr.GetString(db_MaximumCredits);
            _ClassLimit = dr.GetString(db_ClassLimit);
            _Monday = dr.GetString(db_Monday);
            _Tuesday = dr.GetString(db_Tuesday);
            _Wednesday = dr.GetString(db_Wednesday);
            _Thursday = dr.GetString(db_Thursday);
            _Friday = dr.GetString(db_Friday);
            _Saturday = dr.GetString(db_Saturday);
            _Sunday = dr.GetString(db_Sunday);
            _StartTime = dr.GetString(db_StartTime);
            _EndTime = dr.GetString(db_EndTime);
            _Building = dr.GetString(db_Building);
            _Room = dr.GetString(db_Room);
            _PrimaryInstructorFirstName = dr.GetString(db_PrimaryInstructorFirstName);
            _PrimaryInstructorLastName = dr.GetString(db_PrimaryInstructorLastName);
            _PrimaryInstructorNumber = dr.GetString(db_PrimaryInstructorNumber);
            _PrimaryInstructorTeachingPercentage = dr.GetString(db_PrimaryInstructorTeachingPercent);
            _SecondaryInstructorFirstName = dr.GetString(db_SecondaryInstructorFirstName);
            _SecondaryInstructorLastName = dr.GetString(db_SecondaryInstructorLastName);
            _SecondaryInstructorNumber = dr.GetString(db_SecondaryInstructorNumber);
            _SecondaryInstructorTeachingPercentage = dr.GetString(db_SecondaryInstructorTeachingPercent);
            _ClassFeeDetailCode = dr.GetString(db_ClassFeeDetailCode);
            _ClassFeeAmount = dr.GetString(db_ClassFeeAmount);
            _SectionNotes = dr.GetString(db_SectionNotes);
            _CrossListSubject = dr.GetString(db_CrossListSubject);
            _CrossListCourseNumber = dr.GetString(db_CrossListCourseNumber);
            _DepartmentComments = dr.GetString(db_DepartmentComments);
            _DefaultFontStyle = dr.GetString(db_DefaultFontStyle);
            _SpringAbbreviation = dr.GetString(db_SpringAbbreviation);
            _SummerAbbreviation = dr.GetString(db_SummerAbbreviation);
            _FallAbbreviation = dr.GetString(db_FallAbbreviation);
            _DefaultFontSize = dr.GetInt32(db_DefaultFontSize);
            _RequiresMoodleAbbreviation = dr.GetString(db_RequiresMoodleAbbreviation);
            _RequiresPermissionAbbreviation = dr.GetString(db_RequiresPermissionAbbreviation);
        }
        #endregion
    }

}
