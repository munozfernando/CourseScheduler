/* Model for Rooms
 * Rooms: A room in a given building where a class takes place.
 * Created on 2/6/19 by Jason Durfee
 */

using System;
using MySql.Data.MySqlClient;
using System.ComponentModel.DataAnnotations;

namespace ClassScheduler.Models {
    public class Room : DatabaseObject {
        public Room() {

        }

        public Room(MySqlDataReader dr) {
            Fill(dr);
        }

        internal const string db_ID = "RoomID";
        internal const string db_BuildingID = "BuildingID";
        internal const string db_Number = "Number";
        internal const string db_SeatsAvailable = "SeatsAvailable";
        internal const string db_Details = "Details";

        #region private variables
        private int _Number;
        private int _BuildingID;
        private int _SeatsAvailable;
        private Building _Building;
        private string _Details = String.Empty;
        private Campus _Campus;
        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the Number attribute for this Room
        /// </summary>
        public int Number {
            get { return _Number; }
            set { _Number = value; }
        }
        /// <summary>
        /// gets and sets the BuildingID attribute for this Room
        /// </summary>
        [Display(Name = "Building ID")]
        public int BuildingID {
            get { return _BuildingID; }
            set { _BuildingID = value; }
        }
        /// <summary>
        /// gets and sets the SeatsAvailable attribute for this Room
        /// </summary>
        [Display(Name = "Seats Available")]
        public int SeatsAvailable {
            get { return _SeatsAvailable; }
            set { _SeatsAvailable = value; }
        }
        /// <summary>
        /// gets and sets the Building attribute for this Room
        /// </summary>
        public Building Building {
            get {
                if (_Building == null) {
                    _Building = DAL.GetBuilding(_BuildingID);
                }
                return _Building;
            }
            set {
                _Building = value;
                if (value == null) {
                    _BuildingID = -1;
                }
                else {
                    _BuildingID = value.ID;
                }
            }
        }
        /// <summary>
        /// gets and sets the Name attribute for this Room
        /// </summary>
        [Display(Name = "Room")]
        public string Name {
            get {
                if (Building.Abbreviation.ToUpper() == "WEB") {
                    return "WEB";
                }
                else if (Number == 0) {
                    return "";
                }
                else {
                    return Building.Abbreviation + " " + Number;
                }
            }
        }

        /// <summary>
        /// gets and sets the Name attribute for this Room
        /// </summary>
        [Display(Name = "Details")]
        public string Details {
            get { return _Details; }
            set {
                if (value != null) {
                    _Details = value;
                }
            }
        }

        [Display(Name = "Campus")]
        public Campus Campus
        {
            get { return _Campus; }
            set
            {
                if (value != null)
                {
                    _Campus = value;
                }
            }
        }


        public string NumberDisplay {
            get {
                if (Number == 0) {
                    return "";
                }
                else {
                    return Number.ToString();
                }
            }
        }

        public string NameAndCampus {
            get {
                if (Number == 0 && BuildingID == -1) {
                    return "Not Selected";
                }
                return Building.Abbreviation + " " + Number + " - " + Building.Campus.Abbreviation;
            }
        }
        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _BuildingID = dr.GetInt32(db_BuildingID);
            int number = 0;
            int.TryParse((string)dr[db_Number], out number);
            _Number = number;
            _SeatsAvailable = dr.GetInt32(db_SeatsAvailable);
            _Details = dr.GetString(db_Details);
        }
        #endregion
    }
}
