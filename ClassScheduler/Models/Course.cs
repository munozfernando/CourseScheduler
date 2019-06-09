/* Model for Courses
 * Courses: A class taught by a professor during a given semester.
 * Created on 2/11/19 by Fernando Munoz
 */

using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using MySql.Data.MySqlClient;

namespace ClassScheduler.Models {
    public class Course : DatabaseObject {
        public Course() {

        }

        public Course(MySqlDataReader dr) {
            Fill(dr);
        }

        #region private variables
        private Department _Department;
        private int _DepartmentID = -1;
        private int _Number;
        private string _Title = String.Empty;
        private int _MinimumCredits;
        private int _MaximumCredits;
        private int _FixedCredits;
        private bool _IsFixedCredit = true;
        private bool _IsCrossListed = false;
        private bool _IsCrossScheduled = false;
        private string _Description = String.Empty;
        private int _CrossListedCourseID = -1;
        private int _CrossScheduledCourseID = -1;

        internal const string db_ID = "CourseID";
        internal const string db_DepartmentID = "DepartmentID";
        internal const string db_Number = "Number";
        internal const string db_Title = "Title";
        internal const string db_MinimumCredits = "MinimumCredits";
        internal const string db_MaximumCredits = "MaximumCredits";
        internal const string db_FixedCredits = "FixedCredits";
        internal const string db_IsFixedCredit = "IsFixedCredit";
        internal const string db_Description = "Description";
        internal const string db_CrossListedCourseID = "CrossListedCourseID";
        internal const string db_CrossScheduledCourseID = "CrossScheduledCourseID";

        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the Title attribute for this Course
        /// </summary>
        [Required]
        public string Title {
            get { return _Title; }
            set {
                if (value != null) {
                    _Title = value;
                }
            }
        }

        /// <summary>
        /// gets and sets the Number attribute for this Course
        /// </summary>
        [Required]
        public int Number {
            get { return _Number; }
            set { _Number = value; }
        }
        /// <summary>
        /// gets and sets the MinimumCredits attribute for this Course
        /// </summary>
        [DisplayName("Minimum Credits")]
        public int MinimumCredits {
            get {
                if (IsFixedCredit) {
                    return 0;
                }
                else {
                    return _MinimumCredits;
                }
            }
            set {
                _MinimumCredits = value;
            }
        }
        /// <summary>
        /// gets and sets the MaximumCredits attribute for this Course
        /// </summary>
        [DisplayName("Maximum Credits")]
        public int MaximumCredits {
            get {
                if (IsFixedCredit) {
                    return 0;
                }
                else {
                    return _MaximumCredits;
                }
            }
            set { _MaximumCredits = value; }
        }
        /// <summary>
        /// gets and sets the FixedCredits attribute for this Course
        /// </summary>
        [DisplayName("Fixed Credits")]
        public int FixedCredits {
            get {
                if (!IsFixedCredit) {
                    return 0;
                }
                else {
                    return _FixedCredits;
                }
            }
            set { _FixedCredits = value; }
        }

        /// <summary>
        /// gets and sets the IsFixedCredits attribute for this Course
        /// </summary>
        [DisplayName("Fixed Credit")]
        [UIHint("Checkbox")]
        public bool IsFixedCredit {
            get { return _IsFixedCredit; }
            set { _IsFixedCredit = value; }
        }

        /// <summary>
        /// gets and sets the IsIsCrossListed attribute for this Course
        /// </summary>
        [DisplayName("Cross Listed")]
        [UIHint("Checkbox")]
        public bool IsCrossListed {
            get { return _IsCrossListed; }
            set { _IsCrossListed = value; }
        }

        /// <summary>
        /// gets and sets the IsIsCrossScheduled attribute for this Course
        /// </summary>
        [DisplayName("Cross Scheduled")]
        [UIHint("Checkbox")]
        public bool IsCrossScheduled {
            get { return _IsCrossScheduled; }
            set { _IsCrossScheduled = value; }
        }

        /// <summary>
        /// gets and sets the DepartmentID attribute for this Course
        /// </summary>
        public int DepartmentID {
            get { return _DepartmentID; }
            set { _DepartmentID = value; }
        }
        /// <summary>
        /// gets and sets the Department attribute for this Course
        /// </summary>
        public Department Department {
            get {
                if (_Department == null) {
                    _Department = DAL.GetDepartment(_DepartmentID);
                }
                return _Department;
            }
            set {
                _Department = value;
                if (value == null) {
                    _DepartmentID = -1;
                }
                else {
                    _DepartmentID = value.ID;
                }
            }
        }

        /// <summary>
        /// gets and sets the CrossListCourseID attribute for this Course
        /// </summary>
        [DisplayName("Cross-Listed Course")]
        public int CrossListedCourseID {
            get { return _CrossListedCourseID; }
            set { _CrossListedCourseID = value; }
        }

        /// <summary>
        /// gets and sets the CrossScheduledCourseID attribute for this Course
        /// </summary>
        [DisplayName("Cross-Scheduled Course")]
        public int CrossScheduledCourseID {
            get { return _CrossScheduledCourseID; }
            set { _CrossScheduledCourseID = value; }
        }

        public string Name {
            get { return Department.Abbreviation + " " + _Number; }
        }

        public string NumberAndTitle {
            get { return Number + " - " + Title; }
        }

        public string Description {
            get => _Description;
            set {
                if (value != null) {
                    _Description = value;
                }

            }
        }
        #endregion

        public override void Fill(MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _DepartmentID = dr.GetInt32(db_DepartmentID);
            _CrossListedCourseID = dr.GetInt32(db_CrossListedCourseID);
            _CrossScheduledCourseID = dr.GetInt32(db_CrossScheduledCourseID);
            _Number = dr.GetInt32(db_Number);
            _Title = dr.GetString(db_Title);
            _MinimumCredits = dr.GetInt32(db_MinimumCredits);
            _MaximumCredits = dr.GetInt32(db_MaximumCredits);
            _FixedCredits = dr.GetInt32(db_FixedCredits);
            _IsFixedCredit = dr.GetBoolean(db_IsFixedCredit);
            _Description = dr.GetString(db_Description);
        }
    }
}