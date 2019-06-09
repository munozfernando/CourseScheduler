using MySql.Data.MySqlClient;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ClassScheduler.Models
{
    public class PartOfTerm : DatabaseNamedObject
    {
        #region Constructors
        public PartOfTerm(){
            int i = 0;
        }
        public PartOfTerm(MySqlDataReader dr)
        {
            Fill(dr);
        }

        internal const string db_ID = "PartOfTermID";
        internal const string db_Abbreviation = "Abbreviation";
        internal const string db_Name = "Name";
        internal const string db_StartWeek = "StartWeek";
        internal const string db_EndWeek = "EndWeek";
        #endregion

        #region private variables
        private string _Abbreviation = string.Empty;
        private int _StartWeek = 0;
        private int _EndWeek = 0;
        #endregion

        #region Public Variables   
        /// <summary>
        /// gets and sets the Abbreviation attribute for this PartOfTerm
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
        [DisplayName("Start Week")]
        public int StartWeek
        {
            get { return _StartWeek; }
            set{ _StartWeek = value; }
        }
        [DisplayName("End Week")]
        public int EndWeek
        {
            get { return _EndWeek; }
            set { _EndWeek = value; }
        }
        #endregion

        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _Abbreviation = dr.GetString(db_Abbreviation);
            _Name = dr.GetString(db_Name);
            _EndWeek = dr.GetInt32(db_EndWeek);
            _StartWeek = dr.GetInt32(db_StartWeek);
        }
    }
}