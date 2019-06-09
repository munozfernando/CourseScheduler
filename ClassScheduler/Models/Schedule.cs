/* Model for Academic Years
 * Academic Years: The period of time during which courses are taught.
 * Created on 2/12/19 by Jason Durfee
 */

using System;
using System.ComponentModel;
using MySql.Data.MySqlClient;

namespace ClassScheduler.Models
{
    public class Schedule : DatabaseObject
    {
        public Schedule()
        {

        }

        public Schedule(MySqlDataReader dr)
        {
            Fill(dr);
        }

        #region private variables
        private int _SemesterID;
        private int _CollegeID;
        private Semester _Semester;
        private DateTime _StartTime;
        private DateTime _EndTime;
        private College _College;
        private int _DaysSelected;
        #endregion

        #region Database variables
        internal const string db_ID = "ScheduleID";
        internal const string db_College = "College";
        internal const string db_StartTime = "StartTime";
        internal const string db_EndTime = "EndTime";
        internal const string db_DaysSelected = "DaysSelected";
        #endregion

        #region public properties


        #endregion

        #region public functions

        #endregion
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr)
        {
            _ID = dr.GetInt32(db_ID);
            _CollegeID = dr.GetInt32(db_College);
        }
        
        /// <summary>
        /// gets and sets the Start Time attribute for this Schedule
        /// </summary>
        public DateTime StartTime
        {
            get { return _StartTime; }
            set { _StartTime = value; }
        }
        /// <summary>
        /// gets and sets the End Time attribute for this Schedule
        /// </summary>
        public DateTime EndTime
        {
            get { return _EndTime; }
            set { _EndTime = value; }
        }

        /// <summary>
        /// gets and sets the College attribute for this Schedule
        /// </summary>
        public College College
        {
            get { return _College; }
            set { _College = value; }
        }
        /// <summary>
        /// gets and sets the DaysSelected attribute for this Schedule
        /// </summary>
        public int DaysSelected
        {
            get { return _DaysSelected; }
            set { _DaysSelected = value; }
        }

    }
}
