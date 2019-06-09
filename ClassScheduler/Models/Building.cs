/* Model for Buildings
 * Buildings: A structure containing rooms.
 * Created on 2/6/19 by Jason Durfee
 */

using System;
using System.ComponentModel;
using MySql.Data.MySqlClient;

namespace ClassScheduler.Models {
    public class Building : DatabaseNamedObject {
        public Building() {

        }

        public Building(MySqlDataReader dr)
        {
            Fill(dr);
        }

        #region private variables
        private string _Abbreviation = String.Empty;
        private int _CampusID;
        private Campus _Campus;

        internal const string db_ID = "BuildingID";
        internal const string db_Name = "Name";
        internal const string db_Abbreviation = "Abbreviation";
        internal const string db_CampusID = "CampusID";

        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the Abbreviation attribute for this Building
        /// </summary>
        [DisplayName("Abbreviation")]
        public string Abbreviation {
            get { return _Abbreviation; }
            set {
                if (value != null)
                {
                    _Abbreviation = value;
                }
            }
        }
        /// <summary>
        /// gets and sets the CampusID attribute for this Building
        /// </summary>
        public int CampusID {
            get { return _CampusID; }
            set { _CampusID = value; }
        }
        /// <summary>
        /// gets and sets the Campus attribute for this Building
        /// </summary>
        public Campus Campus {
            get {
                if (_Campus == null) {
                    _Campus = DAL.GetCampus(_CampusID);
                }
                return _Campus;
            }
            set {
                _Campus = value;
                if (value == null) {
                    _CampusID = -1;
                }
                else {
                    _CampusID = value.ID;
                }
            }
        }
        #endregion

        #region public functions
        public override void Fill(MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _Name = dr.GetString(db_Name);
            _Abbreviation = dr.GetString(db_Abbreviation);
            _CampusID = dr.GetInt32(db_CampusID);
        }
        #endregion
    }
}
