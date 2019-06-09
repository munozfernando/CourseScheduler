/* Model for UserToDepartments
 * UserToDepartment: An assosciative model between Users and Departments. 
 * Created on 3/5/19 by Jason Durfee
 */

using MySql.Data.MySqlClient;
using System;
using System.ComponentModel;

namespace ClassScheduler.Models {
    public class UserToDepartment : DatabaseObject {
        public UserToDepartment() {

        }

        #region private variables
        private int _UserID;
        private User _User;
        private int _DepartmentID;
        private Department _Department;

        internal const string db_ID = "UserToDepartmentID";
        internal const string db_UserID = "UserID";
        internal const string db_DepartmentID = "DepartmentID";

        #endregion

        #region public properties
        public UserToDepartment(MySqlDataReader dr)
        {
            Fill(dr);
        }
        /// <summary>
        /// gets and sets the UserID attribute for this UserToDepartment
        /// </summary>
        public int UserID {
            get { return _UserID; }
            set { _UserID = value; }
        }
        /// <summary>
        /// gets and sets the User attribute for this UserToDepartment
        /// </summary>
        public User User {
            get {
                if (_User == null) {
                    _User = DAL.GetUser(_UserID);
                }
                return _User;
            }
            set {
                _User = value;
                if (value == null) {
                    _UserID = -1;
                }
                else {
                    _UserID = value.ID;
                }
            }
        }
        /// <summary>
        /// gets and sets the DepartmentID attribute for this UserToDepartment
        /// </summary>
        public int DepartmentID {
            get { return _DepartmentID; }
            set { _DepartmentID = value; }
        }
        /// <summary>
        /// gets and sets the Department attribute for this UserToDepartment
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
        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _UserID = dr.GetInt32(db_UserID);
            _ID = dr.GetInt32(db_ID);
            _DepartmentID = dr.GetInt32(db_DepartmentID);
        }
        #endregion
    }
}
