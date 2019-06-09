using MySql.Data.MySqlClient;


namespace ClassScheduler.Models
{
    public class UserSettings : DatabaseNamedObject
    {
        public UserSettings()
        {

        }

        public UserSettings(MySqlDataReader dr)
        {
            Fill(dr);
        }

        internal const string db_ID = "UserSettingsID";
        internal const string db_OldUsername = "OldUsername";
        internal const string db_NewUsername = "NewUsername";

        #region private variables

        #endregion

        #region public properties

        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr)
        {
            _ID = dr.GetInt32(db_ID);
            _Name = dr.GetString(db_OldUsername);
            _Name = dr.GetString(db_NewUsername);
        }
        #endregion
    }
}
