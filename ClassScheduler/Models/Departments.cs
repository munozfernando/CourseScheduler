/* Model for Subjects
 * Subject: The academic subject of a course.
 * Created on 2/19/19 by Jason Durfee
 */

using MySql.Data.MySqlClient;
using System;
using System.ComponentModel.DataAnnotations;

namespace ClassScheduler.Models {
    public class Department : DatabaseNamedObject {
        public Department() {

        }
        public Department(MySqlDataReader dr)
        {
            Fill(dr);
        }
        #region private variables
        private string _Abbreviation = String.Empty;
        


        internal const string db_ID = "DepartmentID";
        internal const string db_Name = "Name";
        internal const string db_Abbreviation = "Abbreviation";
        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the Abbreviation attribute for this Subject
        /// </summary>
        [Required]
        public string Abbreviation {
            get { return _Abbreviation; }
            set {
                if (value != null)
                {
                    _Abbreviation = value.Trim();
                }
            }
        }
        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _Abbreviation = dr.GetString(db_Abbreviation);
            _Name = (string)dr[db_Name];
        }
        #endregion
    }
}
