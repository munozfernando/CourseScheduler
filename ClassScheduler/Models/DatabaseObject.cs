using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ClassScheduler.Models {
    public abstract class DatabaseObject {
        protected int _ID;

        /// <summary>
        /// gets and sets the ID attribute for this DatabaseObject
        /// </summary>
        public int ID {
            get { return _ID; }
            set { _ID = value; }
        }

        //public abstract int dbSave();

        //protected abstract int dbAdd();

        //protected abstract int dbUpdate();

        public abstract void Fill(MySql.Data.MySqlClient.MySqlDataReader dr);

        //public abstract override string ToString();
    }
}
