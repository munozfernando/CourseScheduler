/* Model for Days
 * Days: A day of the week a course can take place on.
 * Created on 2/11/19 by Fernando Munoz
 */

using MySql.Data.MySqlClient;

namespace ClassScheduler.Models
{
    public class Day : DatabaseNamedObject
    {
        public Day()
        {

        }
        public Day(MySqlDataReader dr)
        {
            Fill(dr);
        }

        #region private variables
        private string _Abbreviation = string.Empty;

        internal const string db_ID = "DayID";
        internal const string db_Abbreviation = "Abbreviation";
        internal const string db_Name = "Name";
        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the Abbreviation attribute for this Day
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
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _Abbreviation = dr.GetString(db_Abbreviation);
            _Name = dr.GetString(db_Name);
        }
        #endregion
    }

}
