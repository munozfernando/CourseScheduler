using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ClassScheduler.Models {
    /// <summary>
    /// Created by Fernando Munoz
    /// Date: February 23rd, 2019
    /// This is the relational model for relating Sections and Fees
    /// </summary>
    public class DetailCode : DatabaseNamedObject {
        public DetailCode() {

        }

        public DetailCode(MySqlDataReader dr) {
            Fill(dr);
        }

        internal const string db_ID = "DetailCodeID";
        internal const string db_Name = "Name";


        #region Public properties

        #endregion

        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _Name = dr.GetString(db_Name);
        }
    }
}
