/* Model for InstructorToSections
 * InstructorToSection: An assosciative model between Instructors and Sections. 
 * Created on 2/11/19 by Fernando Munoz
 */

using System;
using MySql.Data.MySqlClient;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ClassScheduler.Models {
    public class InstructorToSection : DatabaseObject {
        public InstructorToSection() {

        }
        public InstructorToSection(MySqlDataReader dr)
        {
            Fill(dr);
        }

        internal const string db_ID = "InstructorToSectionID";
        internal const string db_InstructorID = "InstructorID";
        internal const string db_SectionID = "SectionID";
        internal const string db_IsPrimary = "IsPrimary";
        internal const string db_TeachingPercentage = "TeachingPercentage";
        internal const string db_DateArchived = "DateArchived";

        #region private variables
        private int _InstructorID;
        private Instructor _Instructor;
        private int _SectionID;
        private Section _Section;
        private bool _IsPrimary;
        private int _TeachingPercentage;
        private DateTime _DateArchived = DAL.MaximumDateTime;

        #endregion

        #region public properties
        /// <summary>
        /// gets and sets the InstructorID attribute for this InstructorToSection
        /// </summary>
        public int InstructorID {
            get { return _InstructorID; }
            set { _InstructorID = value; }
        }
        /// <summary>
        /// gets and sets the Instructor attribute for this InstructorToSection
        /// </summary>
        public Instructor Instructor {
            get {
                if (_Instructor == null) {
                    _Instructor = DAL.GetInstructor(_InstructorID);
                }
                return _Instructor;
            }
            set {
                _Instructor = value;
                if (value == null) {
                    _InstructorID = -1;
                }
                else {
                    _InstructorID = value.ID;
                }
            }
        }
        /// <summary>
        /// gets and sets the SectionID attribute for this InstructorToSection
        /// </summary>
        public int SectionID {
            get { return _SectionID; }
            set { _SectionID = value; }
        }
        /// <summary>
        /// gets and sets the Section attribute for this InstructorToSection
        /// </summary>
        public Section Section {
            get {
                //if (_Section == null) {
                //    _Section = DAL.GetSection(_SectionID);
                //}
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
        /// gets and sets the IsPrimary attribute for this InstructorToSection
        /// </summary>
        [DisplayName("Primary Instructor?")]
        public bool IsPrimary {
            get { return _IsPrimary; }
            set { _IsPrimary = value; }
        }
        /// <summary>
        /// gets and sets the TeachingPercentage attribute for this InstructorToSection
        /// </summary>
        [DisplayName("Teaching %")]
        public int TeachingPercentage {
            get { return _TeachingPercentage; }
            set { _TeachingPercentage = value; }
        }

        public DateTime DateArchived {
            get { return _DateArchived; }
            set { _DateArchived = value; }
        }


        public string TeachingPercentageDisplay {
            get {
                if (TeachingPercentage == 0) {
                    return "";
                }
                else {
                    return TeachingPercentage.ToString();
                }
            }
        }

        #endregion

        #region public functions
        public override void Fill(MySql.Data.MySqlClient.MySqlDataReader dr) {
            _ID = dr.GetInt32(db_ID);
            _InstructorID = dr.GetInt32(db_InstructorID);
            _SectionID = dr.GetInt32(db_SectionID);
            _IsPrimary = dr.GetBoolean(db_IsPrimary);
            _TeachingPercentage = dr.GetInt32(db_TeachingPercentage);
            _DateArchived = dr.GetDateTime(db_DateArchived);
        }
        #endregion
    }
}
