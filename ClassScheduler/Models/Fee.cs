/* Model for Fees
 * Fees: A payment required for a course.
 * Created on 2/12/19 by Jason Durfee
 */

using System;
using System.ComponentModel;
using MySql.Data.MySqlClient;
// Fernando Munoz
// March 5th, 2019
// Fees inherit from the DatabaseNamedObject, and thus do not store any addtional information
namespace ClassScheduler.Models {
    public class Fee : DatabaseObject {
        public Fee() {
                
        }

        public Fee(MySqlDataReader dr)
        {
            Fill(dr);
        }

        #region private variables
        internal const string db_ID = "FeeID";
        internal const string db_DetailCodeID = "DetailCodeID";
        internal const string db_Amount = "Amount";

        private int _DetailCodeID;
        private DetailCode _DetailCode;
        private float _Amount;

        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the DetailCode attribute for this Fee
        /// </summary>
        [DisplayName("DetailCodeID")]
        public int DetailCodeID {
            get { return _DetailCodeID; }
            set { _DetailCodeID = value; }
        }

        /// <summary>
        /// gets and sets the DetailCode attribute for this Section
        /// </summary>
        public DetailCode DetailCode {
            get {
                if (_DetailCode == null) {
                    _DetailCode = DAL.GetDetailCode(_DetailCodeID);
                }
                return _DetailCode;
            }
            set {
                _DetailCode = value;
                if (value == null) {
                    _DetailCodeID = -1;
                }
                else {
                    _DetailCodeID = value.ID;
                }
            }
        }

        /// <summary>
        /// gets and sets the Amount attribute for this Fee
        /// </summary>
        public float Amount {
            get { return _Amount; }
            set { _Amount = value; }
        }
        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _DetailCodeID = dr.GetInt32(db_DetailCodeID);
            _Amount = dr.GetFloat(db_Amount);
        }
        #endregion
    }
}
