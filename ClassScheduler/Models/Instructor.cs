using MySql.Data.MySqlClient;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ClassScheduler.Models
{
    public class Instructor : DatabaseObject
    {
        public Instructor()
        {

        }
        public Instructor(MySqlDataReader dr)
        {
            Fill(dr);
        }
        internal const string db_ID = "InstructorID";
        internal const string db_FirstName = "FirstName";
        internal const string db_LastName = "LastName";
        internal const string db_MiddleName = "MiddleName";
        internal const string db_Number = "Number";
        internal const string db_CourseLoad = "CourseLoad";

        #region private variables
        private string _FirstName = string.Empty;
        private string _LastName = string.Empty;
        private string _MiddleName = string.Empty;
        private string _FullName = string.Empty;
        private int _Number;
        private int _CourseLoad;

        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the FirstName attribute for this Instructor
        /// </summary>
        [DisplayName("First Name")]
        [Required]
        public string FirstName
        {
            get { return _FirstName; }
            set
            {
                if (value != null)
                {
                    _FirstName = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the MiddleName attribute for this Instructor
        /// </summary>
        [DisplayName("Middle Name")]
        public string MiddleName {
            get { return _MiddleName; }
            set
            {
                if (value != null)
                {
                    _MiddleName = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the LastName attribute for this Instructor
        /// </summary>
        [DisplayName("Last Name")]
        [Required]
        public string LastName {
            get { return _LastName; }
            set
            {
                if (value != null)
                {
                    _LastName = value;
                }
            }
        }

        /// <summary>
        /// gets and sets the FullName attribute for this Instructor
        /// </summary>
        [DisplayName("Instructor")]
        public string FullName
        {
            get { return _FirstName + " " + _LastName; }
        }

        /// <summary>
        /// gets and sets the Number attribute for this Instructor
        /// </summary>
        public int Number
        {
            get { return _Number; }
            set { _Number = value; }
        }

        /// <summary>
        /// gets and sets the CourseLoad attribute for this Instructor
        /// </summary>
        [DisplayName("Course Load")]
        public int CourseLoad
        {
            get { return _CourseLoad; }
            set { _CourseLoad = value; }
        }
        [DisplayName("Instructor Number")]
        public string NumberDisplay {
            get {
                if (_Number == 0) {
                    return "";
                }
                else {
                    return Number.ToString();
                }
            }
        }

        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr)
        {
            _ID = dr.GetInt32(db_ID);
            _FirstName = dr.GetString(db_FirstName);
            _LastName = dr.GetString(db_LastName);
            _MiddleName = dr.GetString(db_MiddleName);
            _Number = dr.GetInt32(db_Number);
            _CourseLoad = dr.GetInt32(db_CourseLoad);
        }
        #endregion
    }
}