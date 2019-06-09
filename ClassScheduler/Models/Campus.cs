/* Model for Campus
 * Campus Years: The school ground where courses are scheduled.
 * Created on 2/6/19 by Jason Durfee
 */

using System;
using System.ComponentModel;
using MySql.Data.MySqlClient;

namespace ClassScheduler.Models {
    public class Campus : DatabaseNamedObject {
        public Campus() {

        }

        public Campus(MySqlDataReader dr)
        {
            Fill(dr);
        }

        #region private variables
        private string _Abbreviation = String.Empty;

        internal const string db_ID = "CampusID";
        internal const string db_Name = "Name";
        internal const string db_Abbreviation = "Abbreviation";

        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the Abbreviation attribute for this Campus
        /// </summary>
        public string Abbreviation {
            get { return _Abbreviation; }
            set {
                if (value != null)
                {
                    _Abbreviation = value;
                }
            }
        }
        #endregion

        #region public functions
        public override void Fill(MySqlDataReader dr)
        {
            _ID = dr.GetInt32(db_ID);
            _Name = dr.GetString(db_Name);
            _Abbreviation = dr.GetString(db_Abbreviation);
        }
        #endregion
    }
}
