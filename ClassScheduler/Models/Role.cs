/* Model for Roles
 * Roles: A web application user can have roles which a set of permissions.
 * Created on 2/11/19 by Fernando Munoz
 */

using MySql.Data.MySqlClient;
using System.ComponentModel.DataAnnotations;

namespace ClassScheduler.Models {
    public class Role : DatabaseNamedObject {
        #region Constructors


        public Role() {

        }

        public Role(MySqlDataReader dr) {
            Fill(dr);
        }
        internal const string db_Name = "Name";
        internal const string db_ID = "RoleID";
        internal const string db_IsAdmin = "IsAdmin";
        internal const string db_Sections = "Sections";
        internal const string db_Courses = "Courses";
        internal const string db_Buildings = "Buildings";
        internal const string db_Campuses = "Campuses";
        internal const string db_Roles = "Roles";
        internal const string db_Users = "Users";
        internal const string db_Departments = "Departments";
        internal const string db_Instructors = "Instructors";
        internal const string db_Days = "Days";
        internal const string db_Rooms = "Rooms";
        internal const string db_ScheduleTypes = "ScheduleTypes";
        internal const string db_Spreadsheets = "Spreadsheets";

        #endregion

        #region Private Variables 
        private bool _IsAdmin;
        private RolePermission _Sections;
        private RolePermission _Courses;
        private RolePermission _Buildings;
        private RolePermission _Campuses;
        private RolePermission _Roles;
        private RolePermission _Users;
        private RolePermission _Departments;
        private RolePermission _Instructors;
        private RolePermission _Days;
        private RolePermission _Rooms;
        private RolePermission _ScheduleTypes;
        private RolePermission _Spreadsheets;


        #endregion


        #region Public Properties
        /// <summary>
        /// gets and sets the IsAdmin for a Role object
        /// </summary>
        [UIHint("Checkbox")]
        public bool IsAdmin {
            get { return _IsAdmin; }
            set { _IsAdmin = value; }
        }

        /// <summary>
        /// gets and sets the section permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Sections {
            get { return _Sections; }
            set {
                if (IsAdmin) {
                    _Sections = new RolePermission(15);
                }
                else {
                    _Sections = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the course permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Courses {
            get { return _Courses; }
            set {
                if (IsAdmin) {
                    _Courses = new RolePermission(15);
                }
                else {
                    _Courses = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the building permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Buildings {
            get { return _Buildings; }
            set {
                if (IsAdmin) {
                    _Buildings = new RolePermission(15);
                }
                else {
                    _Buildings = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the campus permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Campuses {
            get { return _Campuses; }
            set {
                if (IsAdmin) {
                    _Campuses = new RolePermission(15);
                }
                else {
                    _Campuses = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the role permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Roles {
            get { return _Roles; }
            set {
                if (IsAdmin) {
                    _Roles = new RolePermission(15);
                }
                else {
                    _Roles = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the user permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Users {
            get { return _Users; }
            set {
                if (IsAdmin) {
                    _Users = new RolePermission(15);
                }
                else {
                    _Users = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the subject permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Departments {
            get { return _Departments; }
            set {
                if (IsAdmin) {
                    _Departments = new RolePermission(15);
                }
                else {
                    _Departments = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the instructor permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Instructors {
            get { return _Instructors; }
            set {
                if (IsAdmin) {
                    _Instructors = new RolePermission(15);
                }
                else {
                    _Instructors = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the days permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Days {
            get { return _Days; }
            set {
                if (IsAdmin) {
                    _Days = new RolePermission(15);
                }
                else {
                    _Days = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the room permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Rooms {
            get { return _Rooms; }
            set {
                if (IsAdmin) {
                    _Rooms = new RolePermission(15);
                }
                else {
                    _Rooms = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the schedule type permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission ScheduleTypes {
            get { return _ScheduleTypes; }
            set {
                if (IsAdmin) {
                    _ScheduleTypes = new RolePermission(15);
                }
                else {
                    _ScheduleTypes = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the spreadsheet permissions for a Role object
        /// </summary>
        [UIHint("RolePermission")]
        public RolePermission Spreadsheets {
            get { return _Spreadsheets; }
            set {
                if (IsAdmin) {
                    _Spreadsheets = new RolePermission(15);
                }
                else {
                    _Spreadsheets = value;
                }
            }
        }


        #endregion
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _Name = dr.GetString(db_Name);
            _IsAdmin = dr.GetBoolean(db_IsAdmin);
            _Sections = new RolePermission(dr.GetInt32(db_Sections));
            _Courses = new RolePermission(dr.GetInt32(db_Courses));
            _Buildings = new RolePermission(dr.GetInt32(db_Buildings));
            _Campuses = new RolePermission(dr.GetInt32(db_Campuses));
            _Roles = new RolePermission(dr.GetInt32(db_Roles));
            _Users = new RolePermission(dr.GetInt32(db_Users));
            _Departments = new RolePermission(dr.GetInt32(db_Departments));
            _Instructors = new RolePermission(dr.GetInt32(db_Instructors));
            _Days = new RolePermission(dr.GetInt32(db_Days));
            _Rooms = new RolePermission(dr.GetInt32(db_Rooms));
            _ScheduleTypes = new RolePermission(dr.GetInt32(db_ScheduleTypes));
            _Spreadsheets = new RolePermission(dr.GetInt32(db_Spreadsheets));
        }
    }
}