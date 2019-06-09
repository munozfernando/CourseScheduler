/* Model for Users
 * Users: A web application user.
 * Created on 2/11/19 by Fernando Munoz
 */

using MySql.Data.MySqlClient;
using System;
using System.ComponentModel.DataAnnotations;

namespace ClassScheduler.Models {

    public class User : DatabaseObject {
        #region Constructor
        public User() {
            Salt = Tools.Hasher.GenerateSalt(15);
            Password = "";
            Username = "";
            RoleID = -1;
        }
        #endregion


        #region Private Variables
        private string _Username;
        private string _Password;
        private string _Salt;
        private Role _Role;
        private int _RoleID;

        internal const string db_ID = "UserID";
        internal const string db_RoleID = "RoleID";
        internal const string db_Salt = "Salt";
        internal const string db_Username = "Username";
        internal const string db_Password = "Password";

        #endregion

        #region Public Properties

        public User(MySqlDataReader dr) {
            Fill(dr);
        }
        /// <summary>
        /// gets and sets the Username attribute for this User
        /// </summary>
        [Required]
        public string Username {
            get { return _Username; }
            set {
                if (value != null) {
                    _Username = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the Salt attribute for this User
        /// </summary>
        public string Salt {
            get { return _Salt; }
            set {
                if (value != null) {
                    _Salt = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the Password attribute for this User
        /// </summary>
        [Required]
        public string Password {
            get { return _Password; }
            set {
                if (value != null) {
                    _Password = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the Role attribute for this User
        /// </summary>
        public Role Role {
            get {
                if (_Role == null) {
                    _Role = DAL.GetRole(_RoleID);
                }
                return _Role;
            }
            set {
                _Role = value;
                if (value == null) {
                    _RoleID = -1;
                }
                else {
                    _RoleID = value.ID;
                }
            }
        }
        /// <summary>
        /// gets and sets the RoleID attribute for this User
        /// </summary>
        public int RoleID {
            get { return _RoleID; }
            set { _RoleID = value; }
        }
        #endregion

        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _RoleID = dr.GetInt32(db_RoleID);
            _Username = dr.GetString(db_Username);
            _Password = dr.GetString(db_Password);
            _Salt = dr.GetString(db_Salt);
        }
    }
}