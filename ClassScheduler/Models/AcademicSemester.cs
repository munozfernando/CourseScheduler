/* Model for Academic Years
 * Academic Years: The period of time during which courses are taught.
 * Created on 2/12/19 by Jason Durfee
 */

using System;
using System.ComponentModel;
using MySql.Data.MySqlClient;

namespace ClassScheduler.Models {
    public class AcademicSemester : DatabaseObject {
        public AcademicSemester()
        {

        }

        public AcademicSemester(MySqlDataReader dr) {
            Fill(dr);
        }

        #region private variables
        private int _AcademicYear;
        private int _SemesterID;
        private Semester _Semester;
        #endregion

        #region Database variables
        internal const string db_ID = "AcademicSemesterID";
        internal const string db_AcademicYear = "AcademicYear";
        internal const string db_SemesterID = "SemesterID";
        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the AcademicYear attribute for this AcademicSemester
        /// </summary>
        public int AcademicYear {
            get { return _AcademicYear; }
            set { _AcademicYear = value; }
        }
        /// <summary>
        /// gets and sets the SemesterID attribute for this AcademicSemester
        /// </summary>
        public int SemesterID {
            get { return _SemesterID; }
            set { _SemesterID = value; }
        }

        /// <summary>
        /// gets and sets the Semester attribute for this AcademicSemester
        /// </summary>
        public Semester Semester {
   
            get
            {
                if (_Semester == null)
                {
                    _Semester = DAL.GetSemester(_SemesterID);
                }
                return _Semester;
            }
            set
            {
                _Semester = value;
                if (value == null)
                {
                    _SemesterID = -1;
                }
                else
                {
                    _SemesterID = value.ID;
                }
            }
        }
        /// <summary>
        /// gets and sets the Display attribute for this AcademicSemester
        /// </summary>
        public string Display {
            get { return Semester.Name + " " + AcademicYear; }
        }

        #endregion

        #region public functions

        #endregion
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _SemesterID = dr.GetInt32(db_SemesterID);
            _AcademicYear = dr.GetInt32(db_AcademicYear);
        }
    }
}
