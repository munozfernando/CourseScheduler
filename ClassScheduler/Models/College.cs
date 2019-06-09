//The entity that subjects will belong to, many S to one C.
//Created by Nolan Crone 3/28/2019
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace ClassScheduler.Models
{
    public class College : DatabaseNamedObject
    {
        public College()
        {

        }

        public College(MySqlDataReader dr)
        {
            Fill(dr);
        }

        #region private variables
        private string _Abbreviation = String.Empty;

        internal const string db_ID = "CollegeID";
        internal const string db_Name = "Name";
        internal const string db_Abbreviation = "Abbreviation";

        #endregion

        #region public properties

        public string Abbreviation
        {
            get { return _Abbreviation; }
            set {
                if (value != null)
                {
                    _Abbreviation = value;
                }
            }
        }

        public override void Fill(MySqlDataReader dr)
        {
            _ID = dr.GetInt32(db_ID);
            _Name = dr.GetString(db_Name);
            _Abbreviation = dr.GetString(db_Abbreviation);
        }
        #endregion
    }
}
