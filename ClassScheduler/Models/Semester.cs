using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ClassScheduler.Models {
    public class Semester : DatabaseNamedObject {


        public Semester() {

        }

        public Semester(MySqlDataReader dr) {
            Fill(dr);
        }

        internal const string db_ID = "SemesterID";
        internal const string db_Name = "Name";
        internal const string db_Abbreviation = "Abbreviation";

        #region private variables
        private string _Abbreviation = String.Empty;

        #endregion

        #region public properties
        /// <summary>
        /// gets and sets this Semesters Abbreviation property
        /// </summary>
        public string Abbreviation {
            get { return _Abbreviation; }
            set
            {
                if (value != null)
                {
                    _Abbreviation = value;
                }
            }
        }
        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _Name = dr.GetString(db_Name);
            _Abbreviation = dr.GetString(db_Abbreviation);
        }
        #endregion
    }
}
