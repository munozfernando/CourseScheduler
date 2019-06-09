using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace ClassScheduler.Models
{
    public class ScheduleType : DatabaseNamedObject
    {
        public ScheduleType() {

        }

        public ScheduleType(MySqlDataReader dr) {
            Fill(dr);
        }

        internal const string db_ID = "ScheduleTypeID";
        internal const string db_Name = "Name";
        internal const string db_Abbreviation = "Abbreviation";
        internal const string db_RequiresRoom = "RequiresRoom";
        internal const string db_RequiresTimes = "RequiresTimes";
        internal const string db_RequiresDays = "RequiresDays";

        #region private variables
        private String _Abbreviation = string.Empty;
        private bool _RequiresRoom = false;
        private bool _RequiresTimes = false;
        private bool _RequiresDays = false;
        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the Abbreviation attribute for this ScheduleType
        /// </summary>
        [Required]
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

        [DisplayName("Reqs. Room")]
        [UIHint("Checkbox")]
        public bool RequiresRoom
        {
            get { return _RequiresRoom; }
            set { _RequiresRoom = value; }
        }

        [DisplayName("Reqs. Times")]
        [UIHint("Checkbox")]
        public bool RequiresTimes {
            get { return _RequiresTimes; }
            set { _RequiresTimes = value; }
        }

        [DisplayName("Reqs. Days")]
        [UIHint("Checkbox")]
        public bool RequiresDays {
            get { return _RequiresDays; }
            set { _RequiresDays = value; }
        }
        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _Name = dr.GetString(db_Name);
            _Abbreviation = dr.GetString(db_Abbreviation);
            _RequiresRoom = dr.GetBoolean(db_RequiresRoom);
            _RequiresDays = dr.GetBoolean(db_RequiresDays);
            _RequiresTimes = dr.GetBoolean(db_RequiresTimes);
        }
        #endregion
    }
}
