/* Model for SectionDays
 * CourseDays: An associative entity between courses and days.
 * Created on 2/11/19 by Fernando Munoz
 */

using MySql.Data.MySqlClient;
using System;

namespace ClassScheduler.Models {
    public class SectionDay : DatabaseObject {
        public SectionDay() {

        }

        public SectionDay(MySqlDataReader dr) {
            Fill(dr);
        }

        internal const string db_ID = "SectionDayID";
        internal const string db_SectionID = "SectionID";
        internal const string db_DayID = "DayID";
        internal const string db_DateArchived = "DateArchived";

        #region private variables
        private Section _Section;
        private int _SectionID;
        private Day _Day;
        private int _DayID;
        private DateTime _DateArchived = DAL.MaximumDateTime;

        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the Section attribute for this SectionDay
        /// </summary>
        public Section Section {
            get {
                if (_Section == null) {
                    _Section = DAL.GetSection(_SectionID);
                }
                return _Section;
            }
            set {
                _Section = value;
                if (value == null) {
                    _SectionID = -1;
                }
                else {
                    _SectionID = value.ID;
                }
            }
        }
        /// <summary>
        /// gets and sets the Day attribute for this SectionDay
        /// </summary>
        public Day Day
        {
            get
            {
                if (_Day == null)
                {
                    _Day = DAL.GetDay(_DayID);
                }
                return _Day;
            }
            set
            {
                _Day = value;
                if (value == null)
                {
                    _Day.ID = -1;
                }
                else
                {
                    _Day.ID = value.ID;
                }
            }
        }
        /// <summary>
        /// gets and sets the SectionID attribute for this SectionDay
        /// </summary>
        public int SectionID {
            get { return _SectionID; }
            set { _SectionID = value; }
        }
        /// <summary>
        /// gets and sets the DayID attribute for this SectionDay
        /// </summary>
        public int DayID {
            get { return _DayID; }
            set { _DayID = value; }
        }

        public DateTime DateArchived {
            get { return _DateArchived; }
            set { _DateArchived = value; }
        }

        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = (int)dr[db_ID];
            _DayID = (int)dr[db_DayID];
            _SectionID = (int)dr[db_SectionID];
            _DateArchived = (DateTime)dr[db_DateArchived];
        }
        #endregion
    }
}

