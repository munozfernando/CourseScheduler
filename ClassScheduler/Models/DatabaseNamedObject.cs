using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace ClassScheduler.Models {
    public abstract class DatabaseNamedObject : DatabaseObject {
        protected string _Name = String.Empty;

        /// <summary>
        /// gets and sets the Name attribute for this DatabaseObject
        /// </summary>
        [Required]
        public string Name {
            get { return _Name; }
            set {
                if (value != null)
                {
                    _Name = value;
                }
            }
        }
    }
}
