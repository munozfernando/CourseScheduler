/* Data Access Layer
 * Interacts with the database to create/edit/view/delete things
 * Created on 3/14/19 by Jason Durfee, Completed by the team
 * Database connection and objects regions as well as the template for model functions created by Jon Holmes
 */

using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using Microsoft.AspNetCore.Identity;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Security.Cryptography;

namespace ClassScheduler.Models {
    public static class DAL {

        public static readonly DateTime MinimumDateTime = new DateTime(1970, 01, 01);
        public static readonly DateTime MaximumDateTime = new DateTime(3000, 12, 31);
        public static string _Pepper = "gLj23Epo084ioAnRfgoaHyskjasf";
        public static int _Stretches = 10000;

        //TODO TimeFormat should be in session variables once that is up and running
        internal static string _TimeFormat = "h:mm tt";

        public static string TimeFormat {
            get { return _TimeFormat; }
            set { _TimeFormat = value; }
        }

        #region Database Connection
        internal enum dbAction {
            Read,
            Edit
        }
        private static string ReadOnlyConnectionString = "Server=localhost;Database=db_a41845_sched;Uid=root;Pwd=";
        private static string EditOnlyConnectionString = "Server=localhost;Database=db_a41845_sched;Uid=root;Pwd=";
        //private static string ReadOnlyConnectionString = "Server=MYSQL5013.site4now.net;Database=db_a41845_sched;Uid=a41845_sched;Pwd=INFO4482Pass";
        //private static string EditOnlyConnectionString = "Server=MYSQL5013.site4now.net;Database=db_a41845_sched;Uid=a41845_sched;Pwd=INFO4482Pass";

        /// <summary>
        /// connects to the database with the appropriate Edit/Read connection string string
        /// </summary>ChangedDepartment
        internal static void ConnectToDatabase(MySqlCommand comm, dbAction action = dbAction.Read) {
            try {
                if (action == dbAction.Edit)
                    comm.Connection = new MySqlConnection(EditOnlyConnectionString);
                else
                    comm.Connection = new MySqlConnection(ReadOnlyConnectionString);

                comm.CommandType = System.Data.CommandType.StoredProcedure;
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        /// <summary>
        /// Gets the data reader for a database command
        /// </summary>
        public static MySqlDataReader GetDataReader(MySqlCommand comm) {
            try {
                ConnectToDatabase(comm);
                comm.Connection.Open();
                return comm.ExecuteReader();
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                System.Diagnostics.Debug.WriteLine(ex.StackTrace);
                return null;
            }
        }
        #endregion

        #region Objects
        /// <summary>
        /// adds an object to the database
        /// </summary>
        /// <returns>the objects new ID or -1 if it fails</returns>
        internal static int AddObject(MySqlCommand comm, string parameterName) {
            int retInt = 0;
            try {
                comm.Connection = new MySqlConnection(EditOnlyConnectionString);
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Connection.Open();
                MySqlParameter retParameter;
                retParameter = comm.Parameters.Add(parameterName, MySqlDbType.Int32);
                retParameter.Direction = System.Data.ParameterDirection.Output;
                comm.ExecuteNonQuery();
                retInt = (int)retParameter.Value;
                comm.Connection.Close();
            }
            catch (Exception ex) {
                if (comm.Connection != null)
                    comm.Connection.Close();

                retInt = -1;
                System.Diagnostics.Debug.WriteLine(ex.Message);
                System.Diagnostics.Debug.WriteLine(ex.StackTrace);
            }
            return retInt;
        }


        /// <summary>
        /// Sets Connection and Executes given comm on the database
        /// </summary>
        /// <param name="comm">MySqlCommand to execute</param>
        /// <returns>number of rows affected; -1 on failure, positive value on success.</returns>
        /// <remarks>Must make sure to populate the command with MySqltext and any parameters before passing to this function.
        ///       Edit Connection is set here.</remarks>
        internal static int UpdateObject(MySqlCommand comm) {
            int retInt = 0;
            try {
                comm.Connection = new MySqlConnection(EditOnlyConnectionString);
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Connection.Open();
                retInt = comm.ExecuteNonQuery();
                comm.Connection.Close();
            }
            catch (Exception ex) {
                if (comm.Connection != null)
                    comm.Connection.Close();

                retInt = -1;
                System.Diagnostics.Debug.WriteLine(ex.Message);
                System.Diagnostics.Debug.WriteLine(ex.StackTrace);
            }
            return retInt;
        }
        #endregion

        #region AcademicSemesters
        /// <summary>
        /// AcademicSemester DAL functionality created by Fernando Munoz
        /// March 17th, 2019
        /// </summary>
        /// <returns></returns>
        public static List<AcademicSemester> GetAcademicSemesters() {
            MySqlCommand comm = new MySqlCommand("getAcademicSemesters");
            List<AcademicSemester> retList = new List<AcademicSemester>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new AcademicSemester(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        public static AcademicSemester GetAcademicSemester(int id) {
            MySqlCommand comm = new MySqlCommand("getAcademicSemesterByID");
            AcademicSemester retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + AcademicSemester.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new AcademicSemester(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;

        }

        public static AcademicSemester GetAcademicSemesterByYearAndSemester(int semesterID, int year) {
            AcademicSemester retObj = null;
            AcademicSemester acadSem = GetAcademicSemesters().Find(x => x.SemesterID == semesterID &&
                                             x.AcademicYear == year);
            if (acadSem != null) {
                retObj = acadSem;
            }
            else {
                retObj = new AcademicSemester();
                retObj.SemesterID = semesterID;
                retObj.AcademicYear = year;
                retObj.ID = AddAcademicSemester(retObj);
            }
            return retObj;
        }

        public static int AddAcademicSemester(AcademicSemester obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertAcademicSemester");
            try {
                comm.Parameters.AddWithValue("i_" + AcademicSemester.db_SemesterID, obj.SemesterID);
                comm.Parameters.AddWithValue("i_" + AcademicSemester.db_AcademicYear, obj.AcademicYear);

                return AddObject(comm, "i_" + AcademicSemester.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int UpdateAcademicSemester(AcademicSemester obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateAcademicSemester");
            try {
                comm.Parameters.AddWithValue("i_" + AcademicSemester.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + AcademicSemester.db_SemesterID, obj.SemesterID);
                comm.Parameters.AddWithValue("i_" + AcademicSemester.db_AcademicYear, obj.AcademicYear);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int RemoveAcademicSemester(int ID) {
            if (ID == -1)
                return -1;
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteAcademicSemester";
                comm.Parameters.AddWithValue("i_" + AcademicSemester.db_ID, ID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region Buildings
        /// <summary>
        /// Building DAL functionality created by Fernando Munoz
        /// March 17th, 2019
        /// </summary>
        /// <returns></returns>

        public static List<Building> GetBuildings() {
            MySqlCommand comm = new MySqlCommand("getBuildings");
            List<Building> retList = new List<Building>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Building(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        public static Building GetBuilding(int id) {
            MySqlCommand comm = new MySqlCommand("getBuildingByID");
            Building retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Building.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Building(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;

        }

        public static int GetBuildingByAbbreviation(string abbr) {
            int retObj = -1;
            Building build = GetBuildings().Find(x => x.Abbreviation == abbr);
            if (build != null) {
                retObj = build.ID;
            }
            return retObj;
        }

        public static int AddBuilding(Building obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertBuilding");
            try {
                comm.Parameters.AddWithValue("i_" + Building.db_CampusID, obj.CampusID);
                comm.Parameters.AddWithValue("i_" + Building.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + Building.db_Name, obj.Name);

                return AddObject(comm, "i_" + Building.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int UpdateBuilding(Building obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateBuilding");
            try {
                comm.Parameters.AddWithValue("i_" + Building.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Building.db_CampusID, obj.CampusID);
                comm.Parameters.AddWithValue("i_" + Building.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + Building.db_Name, obj.Name);

                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int RemoveBuilding(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteBuilding";
                comm.Parameters.AddWithValue("i_" + Building.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        #endregion

        #region Campuses
        /// <summary>
        /// Campus DAL functionality created by Fernando Munoz
        /// March 17th, 2019
        /// </summary>
        /// <returns></returns>
        public static List<Campus> GetCampuses() {
            MySqlCommand comm = new MySqlCommand("getCampuses");
            List<Campus> retList = new List<Campus>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Campus(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        public static Campus GetCampus(int id) {
            MySqlCommand comm = new MySqlCommand("getCampusByID");
            Campus retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Campus.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Campus(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;

        }

        public static int GetCampusByAbbreviation(string abbr) {
            int retObj = -1;
            Campus campus = GetCampuses().Find(x => x.Abbreviation == abbr);
            if (campus != null) {
                retObj = campus.ID;
            }
            return retObj;
        }

        public static int AddCampus(Campus obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertCampus");
            try {
                comm.Parameters.AddWithValue("i_" + Campus.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + Campus.db_Name, obj.Name);

                return AddObject(comm, "i_" + Campus.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int UpdateCampus(Campus obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateCampus");
            try {
                comm.Parameters.AddWithValue("i_" + Campus.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Campus.db_Name, obj.Name);
                comm.Parameters.AddWithValue("i_" + Campus.db_Abbreviation, obj.Abbreviation);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int RemoveCampus(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteCampus";
                comm.Parameters.AddWithValue("i_" + Campus.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region ChangeLogs
        /// <summary>
        /// ChangeLog DAL functionality created by Fernando Munoz
        /// March 17th, 2019
        /// </summary>
        /// <returns></returns>
        public static List<ChangeLog> GetChangeLogs() {
            MySqlCommand comm = new MySqlCommand("getChangeLogs");
            List<ChangeLog> retList = new List<ChangeLog>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new ChangeLog(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        public static ChangeLog GetChangeLog(int id) {
            MySqlCommand comm = new MySqlCommand("getChangeLog");
            ChangeLog retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new ChangeLog(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;

        }

        public static ChangeLog GetChangeLogBySection(Section sect) {
            MySqlCommand comm = new MySqlCommand("getChangeLogBySectionID");
            ChangeLog retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Section.db_ID, sect.ID);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new ChangeLog(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        public static int AddChangeLog(ChangeLog obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertChangeLog");
            try {
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedBuilding, obj.ChangedBuilding);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedCampus, obj.ChangedCampus);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedStudentLimit, obj.ChangedStudentLimit);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedCourseNumber, obj.ChangedCourseNumber);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedTitle, obj.ChangedTitle);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_DateCreated, obj.DateCreated);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedCrossListedDepartment, obj.ChangedCrossListedDepartment);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedCrossListedSection, obj.ChangedCrossListedSection);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_DateDeleted, obj.DateDeleted);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedDepartmentComments, obj.ChangedDepartmentComments);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedEndTime, obj.ChangedEndTime);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedFixedCredits, obj.ChangedFixedCredit);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedFriday, obj.ChangedFriday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_DateImported, obj.DateImported);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedInstructorApproval, obj.ChangedInstructorApproval);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedMaxCredits, obj.ChangedMaxCredits);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedMinCredits, obj.ChangedMinCredits);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedMonday, obj.ChangedMonday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedMoodleRequired, obj.ChangedMoodleRequired);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSectionNotes, obj.ChangedSectionNotes);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedPartOfTerm, obj.ChangedPartOfTerm);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedPrimeInstructor, obj.ChangedPrimeInstructor);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedPrimeInstructorPercent, obj.ChangedPrimeInstructorPercent);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedRoom, obj.ChangedRoom);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSaturday, obj.ChangedSaturday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedScheduleType, obj.ChangedScheduleType);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSecondInstructor, obj.ChangedSecondInstructor);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSecondInstructorPercent, obj.ChangedSecondInstructorPercent);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSectionNumber, obj.ChangedSectionNumber);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedStartTime, obj.ChangedStartTime);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedDepartment, obj.ChangedDepartment);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSunday, obj.ChangedSunday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedThursday, obj.ChangedThursday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedTuesday, obj.ChangedTuesday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedWednesday, obj.ChangedWednesday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_SectionID, obj.SectionID);

                return AddObject(comm, "i_" + ChangeLog.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int UpdateChangeLog(ChangeLog obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateChangeLog");
            try {
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_DateCreated, obj.DateCreated);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_DateDeleted, obj.DateDeleted);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_DateImported, obj.DateImported);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedBuilding, obj.ChangedBuilding);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedCampus, obj.ChangedCampus);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedStudentLimit, obj.ChangedStudentLimit);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedCourseNumber, obj.ChangedCourseNumber);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedTitle, obj.ChangedTitle);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedCrossListedDepartment, obj.ChangedCrossListedDepartment);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedCrossListedSection, obj.ChangedCrossListedSection);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedDepartmentComments, obj.ChangedDepartmentComments);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedEndTime, obj.ChangedEndTime);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedFixedCredits, obj.ChangedFixedCredit);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedFriday, obj.ChangedFriday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedInstructorApproval, obj.ChangedInstructorApproval);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedMaxCredits, obj.ChangedMaxCredits);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedMinCredits, obj.ChangedMinCredits);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedMonday, obj.ChangedMonday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedMoodleRequired, obj.ChangedMoodleRequired);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSectionNotes, obj.ChangedSectionNotes);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedPartOfTerm, obj.ChangedPartOfTerm);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedPrimeInstructor, obj.ChangedPrimeInstructor);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedPrimeInstructorPercent, obj.ChangedPrimeInstructorPercent);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedRoom, obj.ChangedRoom);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSaturday, obj.ChangedSaturday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedScheduleType, obj.ChangedScheduleType);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSecondInstructor, obj.ChangedSecondInstructor);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSecondInstructorPercent, obj.ChangedSecondInstructorPercent);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSectionNumber, obj.ChangedSectionNumber);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedStartTime, obj.ChangedStartTime);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedDepartment, obj.ChangedDepartment);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedSunday, obj.ChangedSunday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedThursday, obj.ChangedThursday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedTuesday, obj.ChangedTuesday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ChangedWednesday, obj.ChangedWednesday);
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_SectionID, obj.SectionID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int RemoveChangeLog(ChangeLog obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteChangeLog";
                comm.Parameters.AddWithValue("i_" + ChangeLog.db_ID, obj.ID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region Courses
        /// <summary>
        ///  Course DAL functionaity created by Fernando Munoz
        ///  March 17th, 2019
        /// </summary>
        /// <returns></returns>
        public static List<Course> GetCourses() {
            MySqlCommand comm = new MySqlCommand("getCourses");
            List<Course> retList = new List<Course>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Course(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        public static Course GetCourse(int id) {
            MySqlCommand comm = new MySqlCommand("getCourseByID");
            Course retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Course.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Course(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;

        }

        public static Course GetCourseByDepartmentNumberAndTitle(string deptAbbr, int courseNumber, string courseTitle) {
            MySqlCommand comm = new MySqlCommand("getCourseByDepartmentNumberAndTitle");
            Course retObj = null;
            try {
                comm.Parameters.AddWithValue("i_DepartmentAbbreviation", deptAbbr);
                comm.Parameters.AddWithValue("i_" + Course.db_Number, courseNumber);
                comm.Parameters.AddWithValue("i_" + Course.db_Title, courseTitle);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Course(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// gets a course from a given department abbreviation and course number
        /// </summary>
        /// <param name="deptAbbr"></param>
        /// <param name="courseNumber"></param>
        /// <returns></returns>
        public static Course GetCourseByDepartmentAndNumber(string deptAbbr, int courseNumber) {
            MySqlCommand comm = new MySqlCommand("getCourseByDepartmentAndNumber");
            Course retObj = null;
            try {
                comm.Parameters.AddWithValue("i_DepartmentAbbreviation", deptAbbr);
                comm.Parameters.AddWithValue("i_" + Course.db_Number, courseNumber);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Course(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        public static int AddCourse(Course obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertCourse");
            try {

                comm.Parameters.AddWithValue("i_" + Course.db_Description, obj.Description);
                comm.Parameters.AddWithValue("i_" + Course.db_DepartmentID, obj.DepartmentID);
                comm.Parameters.AddWithValue("i_" + Course.db_CrossListedCourseID, obj.CrossListedCourseID);
                comm.Parameters.AddWithValue("i_" + Course.db_CrossScheduledCourseID, obj.CrossScheduledCourseID);
                comm.Parameters.AddWithValue("i_" + Course.db_Number, obj.Number);
                comm.Parameters.AddWithValue("i_" + Course.db_Title, obj.Title);
                comm.Parameters.AddWithValue("i_" + Course.db_MinimumCredits, obj.MinimumCredits);
                comm.Parameters.AddWithValue("i_" + Course.db_MaximumCredits, obj.MaximumCredits);
                comm.Parameters.AddWithValue("i_" + Course.db_FixedCredits, obj.FixedCredits);
                comm.Parameters.AddWithValue("i_" + Course.db_IsFixedCredit, obj.IsFixedCredit);
                return AddObject(comm, "i_" + Course.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int UpdateCourse(Course obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateCourse");
            try {
                comm.Parameters.AddWithValue("i_" + Course.db_Description, obj.Description);
                comm.Parameters.AddWithValue("i_" + Course.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Course.db_CrossListedCourseID, obj.CrossListedCourseID);
                comm.Parameters.AddWithValue("i_" + Course.db_DepartmentID, obj.DepartmentID);
                comm.Parameters.AddWithValue("i_" + Course.db_CrossScheduledCourseID, obj.CrossScheduledCourseID);
                comm.Parameters.AddWithValue("i_" + Course.db_Number, obj.Number);
                comm.Parameters.AddWithValue("i_" + Course.db_Title, obj.Title);
                comm.Parameters.AddWithValue("i_" + Course.db_MinimumCredits, obj.MinimumCredits);
                comm.Parameters.AddWithValue("i_" + Course.db_MaximumCredits, obj.MaximumCredits);
                comm.Parameters.AddWithValue("i_" + Course.db_FixedCredits, obj.FixedCredits);
                comm.Parameters.AddWithValue("i_" + Course.db_IsFixedCredit, obj.IsFixedCredit);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int RemoveCourse(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteCourse";
                comm.Parameters.AddWithValue("i_" + Course.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region Colleges
        /// <summary>
        /// gets a list of Colleges from the database
        /// </summary>
        /// <returns>list of Colleges</returns>
        public static List<College> GetColleges() {
            MySqlCommand comm = new MySqlCommand("getColleges");
            List<College> retList = new List<College>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new College(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the College with the given ID
        /// </summary>
        /// <returns>list of Colleges</returns>
        public static College GetCollege(String idstring, Boolean retNewObject) {
            College retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new College();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetCollege(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the College with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static College GetCollege(int id) {
            MySqlCommand comm = new MySqlCommand("getCollegeByID");
            College retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + College.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new College(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a College to the database
        /// </summary>
        /// <param name="obj">the College object</param>
        /// <returns>the College's ID or -1 if it fails</returns>
        public static int AddCollege(College obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertCollege");
            try {
                comm.Parameters.AddWithValue("i_" + College.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + College.db_Name, obj.Name);
                return AddObject(comm, "i_" + College.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a College in the database
        /// </summary>
        /// <param name="obj">the College object</param>
        /// <returns>the College's ID or -1 if it fails</returns>
        public static int UpdateCollege(College obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateCollege");
            try {
                comm.Parameters.AddWithValue("i_" + College.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + College.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + College.db_Name, obj.Name);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the College
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveCollege(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteCollege";
                comm.Parameters.AddWithValue("i_" + College.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region Days

        internal static List<Day> _Days;

        /// <summary>
        /// gets a list of Days from the database
        /// </summary>
        /// <returns>list of Days</returns>
        public static List<Day> GetDays() {
            MySqlCommand comm = new MySqlCommand("getDays");
            List<Day> retList = new List<Day>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Day(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Day with the given ID
        /// </summary>
        /// <returns>list of Days</returns>
        public static Day GetDay(String idstring, Boolean retNewObject) {
            Day retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new Day();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetDay(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the Day with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static Day GetDay(int id) {
            MySqlCommand comm = new MySqlCommand("getDayByID");
            Day retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Day.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Day(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// Gets the Day with the given Section ID
        /// </summary>
        /// <remarks></remarks>

        public static List<Day> GetDaysBySectionID(int id, bool getArchived = false) {
            DateTime dateToCheck = DateTime.Now;
            if (getArchived) {
                dateToCheck = DAL.MinimumDateTime;
            }
            MySqlCommand comm = new MySqlCommand("getDaysBySectionID");
            List<Day> retList = new List<Day>();
            try {
                comm.Parameters.AddWithValue("i_" + Section.db_ID, id);
                comm.Parameters.AddWithValue("i_DateToCheck", dateToCheck);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    Day retObj = new Day(dr);
                    retList.Add(retObj);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// adds a Day to the database
        /// </summary>
        /// <param name="obj">the Day object</param>
        /// <returns>the Day's ID or -1 if it fails</returns>
        public static int AddDay(Day obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertDay");
            try {
                comm.Parameters.AddWithValue("i_" + Day.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + Day.db_Name, obj.Name);
                return AddObject(comm, "i_" + Day.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Day in the database
        /// </summary>
        /// <param name="obj">the Day object</param>
        /// <returns>the Day's ID or -1 if it fails</returns>
        public static int UpdateDay(Day obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateDay");
            try {
                comm.Parameters.AddWithValue("i_" + Day.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Day.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + Day.db_Name, obj.Name);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Day
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveDay(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteDay";
                comm.Parameters.AddWithValue("i_" + Day.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static int GetDayByAbbreviation(string abbreviation) {
            List<Day> days = GetDays();
            int retVal = -1;
            for (int dayIndex = 0; dayIndex < days.Count; dayIndex++) {
                if (days[dayIndex].Abbreviation == abbreviation) {
                    retVal = days[dayIndex].ID;
                }
            }
            return retVal;
        }
        #endregion

        #region Departments
        /// <summary>
        /// gets a list of Departments from the database
        /// </summary>
        /// <returns>list of Departments</returns>
        public static List<Department> GetDepartments() {
            MySqlCommand comm = new MySqlCommand("getDepartments");
            List<Department> retList = new List<Department>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Department(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Department with the given ID
        /// </summary>
        /// <returns>list of Departments</returns>
        public static Department GetDepartment(String idstring, Boolean retNewObject) {
            Department retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new Department();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetDepartment(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the Department with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static Department GetDepartment(int id) {
            MySqlCommand comm = new MySqlCommand("getDepartmentByID");
            Department retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Department.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Department(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// Gets the Department with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static Department GetDepartmentByAbbreviation(string abbreviation) {
            //TODO remove this when the sproc is made
            Department department = GetDepartments().Find(d => d.Abbreviation.Equals(abbreviation));
            return department;

            MySqlCommand comm = new MySqlCommand("getDepartmentByAbbreviation");
            Department retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Department.db_Abbreviation, abbreviation);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Department(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a Department to the database
        /// </summary>
        /// <param name="obj">the Department object</param>
        /// <returns>the Department's ID or -1 if it fails</returns>
        public static int AddDepartment(Department obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertDepartment");
            try {
                comm.Parameters.AddWithValue("i_" + Department.db_Name, obj.Name);
                comm.Parameters.AddWithValue("i_" + Department.db_Abbreviation, obj.Abbreviation);
                return AddObject(comm, "i_" + Department.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Department in the database
        /// </summary>
        /// <param name="obj">the Department object</param>
        /// <returns>the Department's ID or -1 if it fails</returns>
        public static int UpdateDepartment(Department obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateDepartment");
            try {
                comm.Parameters.AddWithValue("i_" + Department.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Department.db_Name, obj.Name);
                comm.Parameters.AddWithValue("i_" + Department.db_Abbreviation, obj.Abbreviation);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Department
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveDepartment(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteDepartment";
                comm.Parameters.AddWithValue("i_" + Department.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region DetailCodes

        /// <summary>
        /// gets a list of DetailCodes from the database
        /// </summary>
        /// <returns>list of DetailCodes</returns>
        public static List<DetailCode> GetDetailCodes() {
            MySqlCommand comm = new MySqlCommand("getDetailCodes");
            List<DetailCode> retList = new List<DetailCode>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new DetailCode(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the DetailCode with the given ID
        /// </summary>
        /// <returns>list of DetailCodes</returns>
        public static DetailCode GetDetailCode(String idstring, Boolean retNewObject) {
            DetailCode retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new DetailCode();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetDetailCode(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the DetailCode with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static DetailCode GetDetailCode(int id) {
            MySqlCommand comm = new MySqlCommand("getDetailCodeByID");
            DetailCode retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + DetailCode.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new DetailCode(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a DetailCode to the database
        /// </summary>
        /// <param name="obj">the DetailCode object</param>
        /// <returns>the DetailCode's ID or -1 if it fails</returns>
        public static int AddDetailCode(DetailCode obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertDetailCode");
            try {
                comm.Parameters.AddWithValue("i_" + DetailCode.db_Name, obj.Name);
                return AddObject(comm, "i_" + DetailCode.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a DetailCode in the database
        /// </summary>
        /// <param name="obj">the DetailCode object</param>
        /// <returns>the DetailCode's ID or -1 if it fails</returns>
        public static int UpdateDetailCode(DetailCode obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateDetailCode");
            try {
                comm.Parameters.AddWithValue("i_" + DetailCode.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + DetailCode.db_Name, obj.Name);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the DetailCode
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveDetailCode(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteDetailCode";
                comm.Parameters.AddWithValue("i_" + DetailCode.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static DetailCode GetDetailCodeByName(string name) {
            MySqlCommand comm = new MySqlCommand("getDetailCodeByName");
            DetailCode retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + DetailCode.db_Name, name);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new DetailCode(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }
        #endregion

        #region Instructors
        /// <summary>
        /// gets a list of Instructors from the database
        /// </summary>
        /// <returns>list of Instructors</returns>
        public static List<Instructor> GetInstructors() {
            MySqlCommand comm = new MySqlCommand("getInstructors");
            List<Instructor> retList = new List<Instructor>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Instructor(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Instructor with the given ID
        /// </summary>
        /// <returns>list of Instructors</returns>
        public static Instructor GetInstructor(String idstring, Boolean retNewObject) {
            Instructor retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new Instructor();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetInstructor(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the Instructor with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static Instructor GetInstructor(int id) {
            MySqlCommand comm = new MySqlCommand("getInstructorByID");
            Instructor retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Instructor.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Instructor(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a Instructor to the database
        /// </summary>
        /// <param name="obj">the Instructor object</param>
        /// <returns>the Instructor's ID or -1 if it fails</returns>
        public static int AddInstructor(Instructor obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertInstructor");
            try {
                comm.Parameters.AddWithValue("i_" + Instructor.db_FirstName, obj.FirstName);
                comm.Parameters.AddWithValue("i_" + Instructor.db_LastName, obj.LastName);
                comm.Parameters.AddWithValue("i_" + Instructor.db_MiddleName, obj.MiddleName);
                comm.Parameters.AddWithValue("i_" + Instructor.db_Number, obj.Number);
                comm.Parameters.AddWithValue("i_" + Instructor.db_CourseLoad, obj.CourseLoad);
                return AddObject(comm, "i_" + Instructor.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Instructor in the database
        /// </summary>
        /// <param name="obj">the Instructor object</param>
        /// <returns>the Instructor's ID or -1 if it fails</returns>
        public static int UpdateInstructor(Instructor obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateInstructor");
            try {
                comm.Parameters.AddWithValue("i_" + Instructor.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Instructor.db_FirstName, obj.FirstName);
                comm.Parameters.AddWithValue("i_" + Instructor.db_LastName, obj.LastName);
                comm.Parameters.AddWithValue("i_" + Instructor.db_MiddleName, obj.MiddleName);
                comm.Parameters.AddWithValue("i_" + Instructor.db_Number, obj.Number);
                comm.Parameters.AddWithValue("i_" + Instructor.db_CourseLoad, obj.CourseLoad);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Instructor
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveInstructor(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteInstructor";
                comm.Parameters.AddWithValue("i_" + Instructor.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// gets an instructor ID by first and last name
        /// </summary>
        /// <param name="firstName"></param>
        /// <param name="lastName"></param>
        /// <returns></returns>
        public static Instructor GetInstructorByFirstAndLastName(string firstName, string lastName) {
            MySqlCommand comm = new MySqlCommand("getInstructorByFirstAndLastName");
            Instructor retVal = null;
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("i_" + Instructor.db_FirstName, firstName);
                comm.Parameters.AddWithValue("i_" + Instructor.db_LastName, lastName);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retVal = new Instructor(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retVal;
        }

        #endregion

        #region InstructorToSections
        /// <summary>
        /// gets a list of Instructor to Sections from the database
        /// </summary>
        /// <returns>list of Instructor to Sections</returns>
        public static List<InstructorToSection> GetInstructorToSections() {
            MySqlCommand comm = new MySqlCommand("getInstructorToSections");
            List<InstructorToSection> retList = new List<InstructorToSection>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new InstructorToSection(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Instructor to Section with the given ID
        /// </summary>
        /// <returns>list of Instructor to Sections</returns>
        public static InstructorToSection GetInstructorToSection(String idstring, Boolean retNewObject) {
            InstructorToSection retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new InstructorToSection();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetInstructorToSection(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the InstructorToSection with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static InstructorToSection GetInstructorToSection(int id) {
            MySqlCommand comm = new MySqlCommand("getInstructorToSectionByID");
            InstructorToSection retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new InstructorToSection(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a Instructor To Section to the database
        /// </summary>
        /// <param name="obj">the Instructor to Section object</param>
        /// <returns>the Instructor to Section's ID or -1 if it fails</returns>
        public static int AddInstructorToSection(InstructorToSection obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertInstructorToSection");
            try {
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_InstructorID, obj.InstructorID);
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_SectionID, obj.SectionID);
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_IsPrimary, obj.IsPrimary);
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_TeachingPercentage, obj.TeachingPercentage);
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_DateArchived, obj.DateArchived);

                return AddObject(comm, "i_" + InstructorToSection.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Instructor to Section in the database
        /// </summary>
        /// <param name="obj">the Instructor to Section object</param>
        /// <returns>the Instructor to Section's ID or -1 if it fails</returns>
        public static int UpdateInstructorToSection(InstructorToSection obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateInstructorToSection");
            try {
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_InstructorID, obj.InstructorID);
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_SectionID, obj.SectionID);
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_IsPrimary, obj.IsPrimary);
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_TeachingPercentage, obj.TeachingPercentage);
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_DateArchived, obj.DateArchived);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Instructor to Section
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveInstructorToSection(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteInstructorToSection";
                comm.Parameters.AddWithValue("i_" + InstructorToSection.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        public static InstructorToSection GetInstructorToSectionByInstructorIDAndSectionID(int sectionID, int instructorID) {
            InstructorToSection retSectionInstructor = null;
            //TODO this needs to use a sproc if it's going to be in the DAL
            foreach (InstructorToSection instructorToSection in DAL.GetInstructorsBySectionID(sectionID, true)) {
                if (instructorToSection.SectionID == sectionID && instructorToSection.InstructorID == instructorID) {
                    retSectionInstructor = instructorToSection;
                }
            }
            return retSectionInstructor;
        }

        public static List<InstructorToSection> GetInstructorsBySectionID(int id, bool getArchived = false) {
            DateTime dateToCheck = DateTime.Now;
            if (getArchived) {
                dateToCheck = DAL.MinimumDateTime;
            }
            List<InstructorToSection> retList = new List<InstructorToSection>();
            MySqlCommand comm = new MySqlCommand("getInstructorsBySectionID");
            try {
                comm.Parameters.AddWithValue("i_" + Section.db_ID, id);
                comm.Parameters.AddWithValue("i_DateToCheck", dateToCheck);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    InstructorToSection retObject = new InstructorToSection(dr);
                    retList.Add(retObject);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        public static List<InstructorToSection> GetInstructorToSectionsByAcademicSemesterID(int academicSemesterID) {
            MySqlCommand comm = new MySqlCommand("getInstructorToSectionsByAcademicSemesterID");
            List<InstructorToSection> retObj = new List<InstructorToSection>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("i_" + AcademicSemester.db_ID, academicSemesterID);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj.Add(new InstructorToSection(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }
        #endregion

        #region PartOfTerms

        internal static List<PartOfTerm> _PartOfTerms;

        /// <summary>
        /// gets a list of Part of Terms from the database
        /// </summary>
        /// <returns>list of Part of Terms</returns>
        public static List<PartOfTerm> GetPartOfTerms() {
            MySqlCommand comm = new MySqlCommand("getPartOfTerm");
            List<PartOfTerm> retList = new List<PartOfTerm>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new PartOfTerm(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Part of Term with the given ID
        /// </summary>
        /// <returns>list of Part of Terms</returns>
        public static PartOfTerm GetPartOfTerm(String idstring, Boolean retNewObject) {
            PartOfTerm retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new PartOfTerm();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetPartOfTerm(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the Part of Term with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static PartOfTerm GetPartOfTerm(int id) {
            MySqlCommand comm = new MySqlCommand("getPartOfTermByID");
            PartOfTerm retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new PartOfTerm(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a Part of Term to the database
        /// </summary>
        /// <param name="obj">the Part of Term object</param>
        /// <returns>the Part of Term's ID or -1 if it fails</returns>
        public static int AddPartOfTerm(PartOfTerm obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertPartOfTerm");
            try {
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_Name, obj.Name);
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_StartWeek, obj.StartWeek);
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_EndWeek, obj.EndWeek);
                return AddObject(comm, "i_" + PartOfTerm.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Part of Term in the database
        /// </summary>
        /// <param name="obj">the Part of Term object</param>
        /// <returns>the Part of Term's ID or -1 if it fails</returns>
        public static int UpdatePartOfTerm(PartOfTerm obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updatePartOfTerm");
            try {
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_Name, obj.Name);
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_StartWeek, obj.StartWeek);
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_EndWeek, obj.EndWeek);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Part of Term
        /// </summary>
        /// <remarks></remarks>
        public static int RemovePartOfTerm(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deletePartOfTerm";
                comm.Parameters.AddWithValue("i_" + PartOfTerm.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }


        public static int GetPartOfTermByAbbreviation(string abbreviation) {
            List<PartOfTerm> partOfTerms = new List<PartOfTerm>();
            partOfTerms = GetPartOfTerms();
            int retVal = -1;
            for (int partOfTermIndex = 0; partOfTermIndex < partOfTerms.Count; partOfTermIndex++) {
                if (partOfTerms[partOfTermIndex].Abbreviation == abbreviation) {
                    retVal = partOfTerms[partOfTermIndex].ID;
                }
            }
            return retVal;
        }
        #endregion

        #region Roles
        /// <summary>
        /// gets a list of Role from the database
        /// </summary>
        /// <returns>list of Role</returns>
        public static List<Role> GetRoles() {
            MySqlCommand comm = new MySqlCommand("getRoles");
            List<Role> retList = new List<Role>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Role(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Role with the given ID
        /// </summary>
        /// <returns>list of Role</returns>
        public static Role GetRole(String idstring, Boolean retNewObject) {
            Role retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new Role();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetRole(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the Role with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static Role GetRole(int id) {
            MySqlCommand comm = new MySqlCommand("getRoleByID");
            Role retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Role.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Role(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a Role to the database
        /// </summary>
        /// <param name="obj">the Role object</param>
        /// <returns>the Roles ID or -1 if it fails</returns>
        public static int AddRole(Role obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertRole");
            try {
                comm.Parameters.AddWithValue("i_" + Role.db_IsAdmin, obj.IsAdmin);
                comm.Parameters.AddWithValue("i_" + Role.db_Name, obj.Name);
                comm.Parameters.AddWithValue("i_" + Role.db_Buildings, obj.Buildings.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_Campuses, obj.Campuses.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_Courses, obj.Courses.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_Days, obj.Days.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_Departments, obj.Departments.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_Instructors, obj.Instructors.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_Roles, obj.Roles.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_Rooms, obj.Rooms.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_ScheduleTypes, obj.ScheduleTypes.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_Sections, obj.Sections.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_Spreadsheets, obj.Spreadsheets.GetIntValue());
                comm.Parameters.AddWithValue("i_" + Role.db_Users, obj.Users.GetIntValue());
                return AddObject(comm, "i_" + Role.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Role in the database
        /// </summary>
        /// <param name="obj">the Role object</param>
        /// <returns>the Roles ID or -1 if it fails</returns>
        public static int UpdateRole(Role obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateRole");
            try {
                comm.Parameters.AddWithValue("i_" + Role.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Role.db_IsAdmin, obj.IsAdmin);
                comm.Parameters.AddWithValue("i_" + Role.db_Buildings, obj.Buildings);
                comm.Parameters.AddWithValue("i_" + Role.db_Campuses, obj.Campuses);
                comm.Parameters.AddWithValue("i_" + Role.db_Courses, obj.Courses);
                comm.Parameters.AddWithValue("i_" + Role.db_Days, obj.Days);
                comm.Parameters.AddWithValue("i_" + Role.db_Departments, obj.Departments);
                comm.Parameters.AddWithValue("i_" + Role.db_Instructors, obj.Instructors);
                comm.Parameters.AddWithValue("i_" + Role.db_Roles, obj.Roles);
                comm.Parameters.AddWithValue("i_" + Role.db_Rooms, obj.Rooms);
                comm.Parameters.AddWithValue("i_" + Role.db_ScheduleTypes, obj.ScheduleTypes);
                comm.Parameters.AddWithValue("i_" + Role.db_Sections, obj.Sections);
                comm.Parameters.AddWithValue("i_" + Role.db_Spreadsheets, obj.Spreadsheets);
                comm.Parameters.AddWithValue("i_" + Role.db_Users, obj.Users);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Role
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveRole(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteRole";
                comm.Parameters.AddWithValue("i_" + Role.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region Rooms
        /// <summary>
        /// gets a list of Room from the database
        /// </summary>
        /// <returns>list of Room</returns>
        public static List<Room> GetRooms() {
            MySqlCommand comm = new MySqlCommand("getRooms");
            List<Room> retList = new List<Room>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Room(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Room with the given ID
        /// </summary>
        /// <returns>list of Room</returns>
        public static Room GetRoom(String idstring, Boolean retNewObject) {
            Room retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new Room();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetRoom(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the Room with the given ID
        /// </summary>
        /// <returns>list of Room</returns>
        public static Room GetRoomByNumbereAndBuildingAbbreviation(int number, string abbreviation) {
            MySqlCommand comm = new MySqlCommand("getRoomByNumbereAndBuildingAbbreviation");
            Room retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Room.db_Number, number);
                comm.Parameters.AddWithValue("i_" + Building.db_Abbreviation, abbreviation);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Room(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// Gets the Room with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static Room GetRoom(int id) {
            MySqlCommand comm = new MySqlCommand("getRoomByID");
            Room retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Room.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Room(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// Gets the Room with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static Room GetRoomByNumberAndBuildingAbbreviation(int roomNumber, string buildingAbbreviation) {
            MySqlCommand comm = new MySqlCommand("getRoomByNumberAndBuildingAbbreviation");
            Room retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Building.db_Abbreviation, buildingAbbreviation);
                comm.Parameters.AddWithValue("i_" + Room.db_Number, roomNumber);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Room(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a Room to the database
        /// </summary>
        /// <param name="obj">the Room object</param>
        /// <returns>the Rooms ID or -1 if it fails</returns>
        public static int AddRoom(Room obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertRoom");
            try {
                comm.Parameters.AddWithValue("i_" + Room.db_BuildingID, obj.BuildingID);
                comm.Parameters.AddWithValue("i_" + Room.db_Details, obj.Details);
                comm.Parameters.AddWithValue("i_" + Room.db_Number, obj.Number);
                comm.Parameters.AddWithValue("i_" + Room.db_SeatsAvailable, obj.SeatsAvailable);
                return AddObject(comm, "i_" + Room.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Room in the database
        /// </summary>
        /// <param name="obj">the Room object</param>
        /// <returns>the Rooms ID or -1 if it fails</returns>
        public static int UpdateRoom(Room obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateRoom");
            try {
                comm.Parameters.AddWithValue("i_" + Room.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Room.db_BuildingID, obj.BuildingID);
                comm.Parameters.AddWithValue("i_" + Room.db_Details, obj.Details);
                comm.Parameters.AddWithValue("i_" + Room.db_Number, obj.Number);
                comm.Parameters.AddWithValue("i_" + Room.db_SeatsAvailable, obj.SeatsAvailable);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Role
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveRoom(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteRoom";
                comm.Parameters.AddWithValue("i_" + Room.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region Schedules
        /// <summary>
        /// gets a list of Schedule from the database
        /// </summary>
        /// <returns>list of Schedule</returns>
        public static List<Schedule> GetSchedules() {
            MySqlCommand comm = new MySqlCommand("getSchedules");
            List<Schedule> retList = new List<Schedule>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Schedule(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Schedule with the given ID
        /// </summary>
        /// <returns>list of Schedule</returns>
        public static Schedule GetSchedule(String idstring, Boolean retNewObject) {
            Schedule retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new Schedule();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetSchedule(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the Schedule with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static Schedule GetSchedule(int id) {
            MySqlCommand comm = new MySqlCommand("getScheduleByID");
            Schedule retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Schedule.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Schedule(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a Schedule to the database
        /// </summary>
        /// <param name="obj">the Schedule object</param>
        /// <returns>the Schedules ID or -1 if it fails</returns>
        public static int AddSchedule(Schedule obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertSchedule");
            try {
                comm.Parameters.AddWithValue("i_" + Schedule.db_StartTime, obj.StartTime);
                comm.Parameters.AddWithValue("i_" + Schedule.db_EndTime, obj.EndTime);
                comm.Parameters.AddWithValue("i_" + Schedule.db_DaysSelected, obj.DaysSelected);
                comm.Parameters.AddWithValue("i_" + Schedule.db_College, obj.College);
                return AddObject(comm, "i_" + Schedule.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Schedule in the database
        /// </summary>
        /// <param name="obj">the Schedule object</param>
        /// <returns>the Schedules ID or -1 if it fails</returns>
        public static int UpdateSchedule(Schedule obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateSchedule");
            try {
                comm.Parameters.AddWithValue("i_" + Schedule.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Schedule.db_StartTime, obj.StartTime);
                comm.Parameters.AddWithValue("i_" + Schedule.db_EndTime, obj.EndTime);
                comm.Parameters.AddWithValue("i_" + Schedule.db_DaysSelected, obj.DaysSelected);
                comm.Parameters.AddWithValue("i_" + Schedule.db_College, obj.College);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Role
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveSchedule(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteSchedule";
                comm.Parameters.AddWithValue("i_" + Schedule.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region ScheduleTypes
        /// <summary>
        /// gets a list of ScheduleType from the database
        /// </summary>
        /// <returns>list of ScheduleType</returns>
        public static List<ScheduleType> GetScheduleTypes() {
            MySqlCommand comm = new MySqlCommand("getScheduleTypes");
            List<ScheduleType> retList = new List<ScheduleType>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new ScheduleType(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// gets a list of ScheduleType from the database given a string for the abbreviation
        /// </summary>
        /// <returns>list of ScheduleType</returns>
        public static ScheduleType GetScheduleTypeByAbbreviation(string abbreviation) {
            MySqlCommand comm = new MySqlCommand("getScheduleTypeByAbbreviation");
            ScheduleType retVal = null;
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_Abbreviation, abbreviation);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retVal = new ScheduleType(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retVal;
        }

        /// <summary>
        /// Gets the ScheduleType with the given ID
        /// </summary>
        /// <returns>list of ScheduleType</returns>
        public static ScheduleType GetScheduleType(String idstring, Boolean retNewObject) {
            ScheduleType retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new ScheduleType();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetScheduleType(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the ScheduleType with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static ScheduleType GetScheduleType(int id) {
            MySqlCommand comm = new MySqlCommand("getScheduleTypeByID");
            ScheduleType retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new ScheduleType(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a ScheduleType to the database
        /// </summary>
        /// <param name="obj">the ScheduleType object</param>
        /// <returns>the ScheduleTypes ID or -1 if it fails</returns>
        public static int AddScheduleType(ScheduleType obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertScheduleType");
            try {
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_Name, obj.Name);
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_RequiresRoom, obj.RequiresRoom);
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_RequiresDays, obj.RequiresDays);
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_RequiresTimes, obj.RequiresTimes);
                return AddObject(comm, "i_" + ScheduleType.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a ScheduleType in the database
        /// </summary>
        /// <param name="obj">the ScheduleType object</param>
        /// <returns>the ScheduleTypes ID or -1 if it fails</returns>
        public static int UpdateScheduleType(ScheduleType obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateScheduleType");
            try {
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_Name, obj.Name);
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_Abbreviation, obj.Abbreviation);
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_RequiresRoom, obj.RequiresRoom);
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_RequiresDays, obj.RequiresDays);
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_RequiresTimes, obj.RequiresTimes);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Role
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveScheduleType(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteScheduleType";
                comm.Parameters.AddWithValue("i_" + ScheduleType.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region Sections
        /// <summary>
        /// gets a list of Section from the database
        /// </summary>
        /// <returns>list of Section</returns>
        public static List<Section> GetSections(bool getArchived = false) {
            DateTime dateToCheck = DateTime.Now;
            if (getArchived) {
                dateToCheck = DAL.MinimumDateTime;
            }
            MySqlCommand comm = new MySqlCommand("getSections");
            List<Section> retList = new List<Section>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("i_DateToCheck", dateToCheck);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Section(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// gets a list of Section from the database for a given AcademicSemesterID
        /// </summary>
        /// <returns>list of Section</returns>
        public static List<Section> GetSectionsByAcademicSemesterID(int academicSemesterID, bool getDeleted = false) {
            MySqlCommand comm = new MySqlCommand("getSectionsByAcademicSemesterID");
            List<Section> retList = new List<Section>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("i_" + Section.db_AcademicSemesterID, academicSemesterID);
                comm.Parameters.AddWithValue("i_GetDeleted", getDeleted);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Section(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// gets a list of Section from the database for a given AcademicSemesterID
        /// </summary>
        /// <returns>list of Section</returns>
        public static List<Section> GetSectionsByCourse(int courseID) {
            MySqlCommand comm = new MySqlCommand("getSectionsByCourseID");
            List<Section> retList = new List<Section>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("i_" + Section.db_CourseID, courseID);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Section(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Section with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static Section GetSection(int id) {
            MySqlCommand comm = new MySqlCommand("getSectionByID");
            Section retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Section.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Section(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a Section to the database
        /// </summary>
        /// <param name="obj">the Section object</param>
        /// <returns>the Sections ID or -1 if it fails</returns>
        public static int AddSection(Section obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertSection");
            try {
                comm.Parameters.AddWithValue("i_" + Section.db_AcademicSemesterID, obj.AcademicSemesterID);
                comm.Parameters.AddWithValue("i_" + Section.db_CourseID, obj.CourseID);
                comm.Parameters.AddWithValue("i_" + Section.db_CRN, obj.CRN);
                comm.Parameters.AddWithValue("i_" + Section.db_DateArchived, obj.DateArchived);
                comm.Parameters.AddWithValue("i_" + Section.db_DateCreated, obj.DateCreated);
                comm.Parameters.AddWithValue("i_" + Section.db_DateDeleted, obj.DateDeleted);
                comm.Parameters.AddWithValue("i_" + Section.db_DepartmentComments, obj.DepartmentComments);
                comm.Parameters.AddWithValue("i_" + Section.db_EndTime, obj.EndTime);
                comm.Parameters.AddWithValue("i_" + Section.db_StartTime, obj.StartTime);
                comm.Parameters.AddWithValue("i_" + Section.db_Notes, obj.Notes);
                comm.Parameters.AddWithValue("i_" + Section.db_FeeID, obj.FeeID);
                comm.Parameters.AddWithValue("i_" + Section.db_CrossListedSectionID, obj.CrossListedSectionID);
                comm.Parameters.AddWithValue("i_" + Section.db_Number, obj.Number);
                comm.Parameters.AddWithValue("i_" + Section.db_PartOfTermID, obj.PartOfTermID);
                comm.Parameters.AddWithValue("i_" + Section.db_RequiresMoodle, obj.RequiresMoodle);
                comm.Parameters.AddWithValue("i_" + Section.db_RequiresPermission, obj.RequiresPermission);
                comm.Parameters.AddWithValue("i_" + Section.db_RoomID, obj.RoomID);
                comm.Parameters.AddWithValue("i_" + Section.db_ScheduleTypeID, obj.ScheduleTypeID);
                comm.Parameters.AddWithValue("i_" + Section.db_StudentLimit, obj.StudentLimit);
                comm.Parameters.AddWithValue("i_" + Section.db_XListID, obj.XListID);
                return AddObject(comm, "i_" + Section.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Section in the database
        /// </summary>
        /// <param name="obj">the Section object</param>
        /// <returns>the Sections ID or -1 if it fails</returns>
        public static int UpdateSection(Section obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateSection");
            try {
                comm.Parameters.AddWithValue("i_" + Section.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Section.db_AcademicSemesterID, obj.AcademicSemesterID);
                comm.Parameters.AddWithValue("i_" + Section.db_CourseID, obj.CourseID);
                comm.Parameters.AddWithValue("i_" + Section.db_CRN, obj.CRN);
                comm.Parameters.AddWithValue("i_" + Section.db_DateArchived, obj.DateArchived);
                comm.Parameters.AddWithValue("i_" + Section.db_DateCreated, obj.DateCreated);
                comm.Parameters.AddWithValue("i_" + Section.db_DateDeleted, obj.DateDeleted);
                comm.Parameters.AddWithValue("i_" + Section.db_DepartmentComments, obj.DepartmentComments);
                comm.Parameters.AddWithValue("i_" + Section.db_EndTime, obj.EndTime);
                comm.Parameters.AddWithValue("i_" + Section.db_StartTime, obj.StartTime);
                comm.Parameters.AddWithValue("i_" + Section.db_Notes, obj.Notes);
                comm.Parameters.AddWithValue("i_" + Section.db_FeeID, obj.FeeID);
                comm.Parameters.AddWithValue("i_" + Section.db_CrossListedSectionID, obj.CrossListedSectionID);
                comm.Parameters.AddWithValue("i_" + Section.db_Number, obj.Number);
                comm.Parameters.AddWithValue("i_" + Section.db_PartOfTermID, obj.PartOfTermID);
                comm.Parameters.AddWithValue("i_" + Section.db_RequiresMoodle, obj.RequiresMoodle);
                comm.Parameters.AddWithValue("i_" + Section.db_RequiresPermission, obj.RequiresPermission);
                comm.Parameters.AddWithValue("i_" + Section.db_RoomID, obj.RoomID);
                comm.Parameters.AddWithValue("i_" + Section.db_ScheduleTypeID, obj.ScheduleTypeID);
                comm.Parameters.AddWithValue("i_" + Section.db_StudentLimit, obj.StudentLimit);
                comm.Parameters.AddWithValue("i_" + Section.db_XListID, obj.XListID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// gets a list of Section from the database
        /// </summary>
        /// <returns>list of Section</returns>
        public static List<Section> CheckForExistingSection(int academicSemesterID, int courseID, string sectionNumber) {
            MySqlCommand comm = new MySqlCommand("checkForExistingSection");
            List<Section> retList = new List<Section>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("i_" + AcademicSemester.db_ID, academicSemesterID);
                comm.Parameters.AddWithValue("i_" + Course.db_ID, courseID);
                comm.Parameters.AddWithValue("i_Section" + Section.db_Number, sectionNumber);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Section(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Role
        /// </summary>
        /// <remarks></remarks>
        public static int ArchiveSection(Section obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteSection";
                comm.Parameters.AddWithValue("i_" + Section.db_ID, obj.ID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Role
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveSection(Section obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteSection";
                comm.Parameters.AddWithValue("i_" + Section.db_ID, obj.ID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region SectionDays
        /// <summary>
        /// gets a list of SectionDay from the database
        /// </summary>
        /// <returns>list of SectionDay</returns>
        public static List<SectionDay> GetSectionDays() {
            MySqlCommand comm = new MySqlCommand("getSectionDays");
            List<SectionDay> retList = new List<SectionDay>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new SectionDay(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// gets a list of SectionDay from the database
        /// </summary>
        /// <returns>list of SectionDay</returns>
        public static List<SectionDay> GetSectionDaysBySectionID(int sectionID, bool getArchived = false) {
            DateTime dateToCheck = DateTime.Now;
            if (getArchived) {
                dateToCheck = DAL.MinimumDateTime;
            }
            MySqlCommand comm = new MySqlCommand("getSectionDaysBySectionID");
            List<SectionDay> retList = new List<SectionDay>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("i_" + Section.db_ID, sectionID);
                comm.Parameters.AddWithValue("i_DateToCheck", dateToCheck);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new SectionDay(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the SectionDay with the given ID
        /// </summary>
        /// <returns>list of SectionDay</returns>
        public static SectionDay GetSectionDay(String idstring, Boolean retNewObject) {
            SectionDay retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new SectionDay();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetSectionDay(ID);
                }
            }
            return retObject;
        }


        /// <summary>
        /// Gets the SectionDay with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static SectionDay GetSectionDay(int id) {
            MySqlCommand comm = new MySqlCommand("getSectionDayByID");
            SectionDay retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + SectionDay.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new SectionDay(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// Gets the SectionDay with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static SectionDay GetSectionDayByDayIDAndSectionID(int dayID, int sectionID) {
            MySqlCommand comm = new MySqlCommand("getSectionDayByDayIDAndSectionID");
            SectionDay retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Day.db_ID, dayID);
                comm.Parameters.AddWithValue("i_" + SectionDay.db_ID, sectionID);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new SectionDay(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a SectionDay to the database
        /// </summary>
        /// <param name="obj">the SectionDay object</param>
        /// <returns>the SectionDays ID or -1 if it fails</returns>
        public static int AddSectionDay(SectionDay obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertSectionDay");
            try {
                comm.Parameters.AddWithValue("i_" + SectionDay.db_DayID, obj.DayID);
                comm.Parameters.AddWithValue("i_" + SectionDay.db_SectionID, obj.SectionID);
                comm.Parameters.AddWithValue("i_" + SectionDay.db_DateArchived, obj.DateArchived);
                return AddObject(comm, "i_" + SectionDay.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a SectionDay in the database
        /// </summary>
        /// <param name="obj">the SectionDay object</param>
        /// <returns>the SectionDays ID or -1 if it fails</returns>
        public static int UpdateSectionDay(SectionDay obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateSectionDay");
            try {
                comm.Parameters.AddWithValue("i_" + SectionDay.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + SectionDay.db_DayID, obj.DayID);
                comm.Parameters.AddWithValue("i_" + SectionDay.db_SectionID, obj.SectionID);
                comm.Parameters.AddWithValue("i_" + SectionDay.db_DateArchived, obj.DateArchived);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Role
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveSectionDay(int ID) {
            if (ID == -1)
                return -1;
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteSectionDay";
                comm.Parameters.AddWithValue("i_" + SectionDay.db_ID, ID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region Fees
        /// <summary>
        /// Gets a list of Fee from database
        /// </summary>
        /// <param name="getArchived"></param>
        /// <returns>List of Section Fee</returns>
        public static List<Fee> GetFees() {
            MySqlCommand comm = new MySqlCommand("getFees");
            List<Fee> retList = new List<Fee>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Fee(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Fee with the given ID
        /// </summary>
        /// <remarks></remarks>
        public static Fee GetFee(int id) {
            MySqlCommand comm = new MySqlCommand("getFeeByID");
            Fee retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Fee.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Fee(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// Gets a list of Section Fee from the database for a given FeeID
        /// </summary>
        /// <returns>List of Section Fees</returns>
        public static Fee GetFeeByDetailCodeAndAmount(int detailCodeID, float amount) {
            MySqlCommand comm = new MySqlCommand("getFeeByDetailCodeAndAmount");
            Fee retVal = null;
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                comm.Parameters.AddWithValue("i_" + Fee.db_DetailCodeID, detailCodeID);
                comm.Parameters.AddWithValue("i_" + Fee.db_Amount, amount);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retVal = new Fee(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retVal;
        }

        /// <summary>
        /// adds a Section Fee to the database
        /// </summary>
        /// <param name="obj">the Section Fee object</param>
        /// <returns>the Section Fee's ID or -1 if it fails</returns>
        public static int AddFee(Fee obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertFee");
            try {
                comm.Parameters.AddWithValue("i_" + Fee.db_DetailCodeID, obj.DetailCodeID);
                comm.Parameters.AddWithValue("i_" + Fee.db_Amount, obj.Amount);
                return AddObject(comm, "i_" + Fee.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Section Fee in the database
        /// </summary>
        /// <param name="obj">the Section Fee object</param>
        /// <returns>the Section Fee's ID or -1 if it fails</returns>
        public static int UpdateFee(Fee obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateFee");
            try {
                comm.Parameters.AddWithValue("i_" + Fee.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Fee.db_DetailCodeID, obj.DetailCodeID);
                comm.Parameters.AddWithValue("i_" + Fee.db_Amount, obj.Amount);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }


        /// <summary>
        /// Attempts to delete the database entry corresponding to the Fee
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveFee(int ID) {
            if (ID == -1)
                return -1;
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteFee";
                comm.Parameters.AddWithValue("i_" + Fee.db_ID, ID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region Semesters
        /// <summary>
        /// gets a list of Semester from the database
        /// </summary>
        /// <returns>list of Semester</returns>
        public static List<Semester> GetSemesters() {
            MySqlCommand comm = new MySqlCommand("getSemesters");
            List<Semester> retList = new List<Semester>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new Semester(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the Semester with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static Semester GetSemester(int id) {
            MySqlCommand comm = new MySqlCommand("getSemesterByID");
            Semester retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + Semester.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new Semester(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// Gets a specific Semester from an ID
        /// </summary>
        /// <param name="ID"></param>
        /// <returns>Academic Semester</returns>
        public static Semester GetSemesterByAbbreviation(string abbreviation) {
            Semester retSemester = null;
            foreach (Semester Semester in DAL.GetSemesters()) {
                if (Semester.Abbreviation == abbreviation) {
                    retSemester = Semester;
                }
            }
            return retSemester;
        }

        /// <summary>
        /// adds a Semester to the database
        /// </summary>
        /// <param name="obj">the semester object</param>
        /// <returns>the semesters ID or -1 if it fails</returns>
        public static int AddSemester(Semester obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertSemester");
            try {
                comm.Parameters.AddWithValue("i_" + Semester.db_Name, obj.Name);
                return AddObject(comm, "i_" + Semester.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a Semester in the database
        /// </summary>
        /// <param name="obj">the semester object</param>
        /// <returns>the semesters ID or -1 if it fails</returns>
        public static int UpdateSemester(Semester obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateSemester");
            try {
                comm.Parameters.AddWithValue("i_" + Semester.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + Semester.db_Name, obj.Name);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Role
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveSemester(int ID) {
            if (ID == -1)
                return -1;
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteSemester";
                comm.Parameters.AddWithValue("i_" + Semester.db_ID, ID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region SpreadsheetVariables
        /// <summary>
        /// gets a list of SpreadsheetVariables from the database
        /// </summary>
        /// <returns>list of SpreadsheetVariables</returns>
        public static List<SpreadsheetVariables> GetSpreadsheetVariablesList() {
            MySqlCommand comm = new MySqlCommand("getSpreadsheetVariables");
            List<SpreadsheetVariables> retList = new List<SpreadsheetVariables>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new SpreadsheetVariables(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the SpreadsheetVariable with the given ID
        /// </summary>
        /// <returns>list of SpreadsheetVariables</returns>
        public static SpreadsheetVariables GetSpreadsheetVariables(String idstring, Boolean retNewObject) {
            SpreadsheetVariables retObject = null;
            int ID;
            if (int.TryParse(idstring, out ID)) {
                if (ID == -1 && retNewObject) {
                    retObject = new SpreadsheetVariables();
                    retObject.ID = -1;
                }
                else if (ID >= 0) {
                    retObject = GetSpreadsheetVariables(ID);
                }
            }
            return retObject;
        }

        /// <summary>
        /// Gets the SpreadsheetVariable with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static SpreadsheetVariables GetSpreadsheetVariables(int id) {
            MySqlCommand comm = new MySqlCommand("getSpreadsheetVariablesByID");
            SpreadsheetVariables retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ID, id);

                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new SpreadsheetVariables(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a SpreadsheetVariable to the database
        /// </summary>
        /// <param name="obj">the SpreadsheetVariable object</param>
        /// <returns>the SpreadsheetVariable's ID or -1 if it fails</returns>
        public static int AddSpreadsheetVariables(SpreadsheetVariables obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertSpreadsheetVariables");
            try {
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_AcademicSemester, obj.AcademicSemester);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_AddChangeDelete, obj.AddChangeDelete);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Building, obj.Building);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Campus, obj.Campus);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ClassFeeAmount, obj.ClassFeeAmount);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ClassFeeDetailCode, obj.ClassFeeDetailCode);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ClassLimit, obj.ClassLimit);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_CourseNumber, obj.CourseNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_CourseTitle, obj.CourseTitle);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_CrossListCourseNumber, obj.CrossListCourseNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_CrossListID, obj.CrossListID);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_CrossListSubject, obj.CrossListSubject);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_DefaultFontSize, obj.DefaultFontSize);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_DefaultFontStyle, obj.DefaultFontStyle);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Department, obj.Department);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_DepartmentComments, obj.DepartmentComments);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_EndTime, obj.EndTime);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_FallAbbreviation, obj.FallAbbreviation);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_FixedCredit, obj.FixedCredit);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Friday, obj.Friday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_InstructorApprovalRequired, obj.InstructorApprovalRequired);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_MaximumCredits, obj.MaximumCredits);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_MinimumCredits, obj.MinimumCredits);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Monday, obj.Monday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_MoodleRequired, obj.MoodleRequired);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_PartOfTerm, obj.PartOfTerm);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_PrimaryInstructorFirstName, obj.PrimaryInstructorFirstName);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_PrimaryInstructorLastName, obj.PrimaryInstructorLastName);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_PrimaryInstructorNumber, obj.PrimaryInstructorNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_PrimaryInstructorTeachingPercent, obj.PrimaryInstructorTeachingPercentage);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Room, obj.Room);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Saturday, obj.Saturday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ScheduleType, obj.ScheduleType);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SecondaryInstructorFirstName, obj.SecondaryInstructorFirstName);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SecondaryInstructorLastName, obj.SecondaryInstructorLastName);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SecondaryInstructorNumber, obj.SecondaryInstructorNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SecondaryInstructorTeachingPercent, obj.SecondaryInstructorTeachingPercentage);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SectionCRN, obj.SectionCRN);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SectionNotes, obj.SectionNotes);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SectionNumber, obj.SectionNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SpringAbbreviation, obj.SpringAbbreviation);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_StartingRowNumber, obj.StartingRowNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_StartTime, obj.StartTime);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SummerAbbreviation, obj.SummerAbbreviation);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_RequiresMoodleAbbreviation, obj.RequiresMoodleAbbreviation);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_RequiresPermissionAbbreviation, obj.RequiresPermissionAbbreviation);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Sunday, obj.Sunday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Thursday, obj.Thursday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Tuesday, obj.Tuesday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Wednesday, obj.Wednesday);
                return AddObject(comm, "i_" + SpreadsheetVariables.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a SpreadsheetVariable in the database
        /// </summary>
        /// <param name="obj">the SpreadsheetVariable object</param>
        /// <returns>the SpreadsheetVariable's ID or -1 if it fails</returns>
        public static int UpdateSpreadsheetVariables(SpreadsheetVariables obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateSpreadsheetVariables");
            try {
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_AcademicSemester, obj.AcademicSemester);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_AddChangeDelete, obj.AddChangeDelete);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Building, obj.Building);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Campus, obj.Campus);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ClassFeeAmount, obj.ClassFeeAmount);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ClassFeeDetailCode, obj.ClassFeeDetailCode);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ClassLimit, obj.ClassLimit);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_CourseNumber, obj.CourseNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_CourseTitle, obj.CourseTitle);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_CrossListCourseNumber, obj.CrossListCourseNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_CrossListID, obj.CrossListID);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_CrossListSubject, obj.CrossListSubject);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_DefaultFontSize, obj.DefaultFontSize);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_DefaultFontStyle, obj.DefaultFontStyle);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Department, obj.Department);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_DepartmentComments, obj.DepartmentComments);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_EndTime, obj.EndTime);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_FallAbbreviation, obj.FallAbbreviation);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_FixedCredit, obj.FixedCredit);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Friday, obj.Friday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_InstructorApprovalRequired, obj.InstructorApprovalRequired);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_MaximumCredits, obj.MaximumCredits);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_MinimumCredits, obj.MinimumCredits);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Monday, obj.Monday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_MoodleRequired, obj.MoodleRequired);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_PartOfTerm, obj.PartOfTerm);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_PrimaryInstructorFirstName, obj.PrimaryInstructorFirstName);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_PrimaryInstructorLastName, obj.PrimaryInstructorLastName);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_PrimaryInstructorNumber, obj.PrimaryInstructorNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_PrimaryInstructorTeachingPercent, obj.PrimaryInstructorTeachingPercentage);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Room, obj.Room);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Saturday, obj.Saturday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ScheduleType, obj.ScheduleType);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SecondaryInstructorFirstName, obj.SecondaryInstructorFirstName);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SecondaryInstructorLastName, obj.SecondaryInstructorLastName);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SecondaryInstructorNumber, obj.SecondaryInstructorNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SecondaryInstructorTeachingPercent, obj.SecondaryInstructorTeachingPercentage);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SectionCRN, obj.SectionCRN);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SectionNotes, obj.SectionNotes);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SectionNumber, obj.SectionNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SpringAbbreviation, obj.SpringAbbreviation);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_StartingRowNumber, obj.StartingRowNumber);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_StartTime, obj.StartTime);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_SummerAbbreviation, obj.SummerAbbreviation);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_RequiresMoodleAbbreviation, obj.RequiresMoodleAbbreviation);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_RequiresPermissionAbbreviation, obj.RequiresPermissionAbbreviation);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Sunday, obj.Sunday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Thursday, obj.Thursday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Tuesday, obj.Tuesday);
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_Wednesday, obj.Wednesday);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the SpreadsheetVariable
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveSpreadsheetVariables(int id) {
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteSpreadsheetVariables";
                comm.Parameters.AddWithValue("i_" + SpreadsheetVariables.db_ID, id);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region Users
        /// <summary>
        /// gets a list of User from the database
        /// </summary>
        /// <returns>list of User</returns>
        public static List<User> GetUsers() {
            MySqlCommand comm = new MySqlCommand("getUsers");
            List<User> retList = new List<User>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new User(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the User with the given ID
        /// </summary>
        /// <remarks></remarks>
        public static User GetUser(int id) {
            MySqlCommand comm = new MySqlCommand("getUserByID");
            User retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + User.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new User(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// Gets the User with the given username and password - created by Jon Holmes pulled from the peerVal project
        /// </summary>
        /// <remarks></remarks>
        public static User GetUser(string username, string password) {
            MySqlCommand comm = new MySqlCommand("getUserByUsername");
            User retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + User.db_Username, username);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new User(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            /// Verify password matches.
            if (retObj != null) {
                if (!Tools.Hasher.IsValid(password, retObj.Salt, _Pepper, _Stretches, retObj.Password)) {
                    retObj = null;
                }
            }
            return retObj;
        }

        /// <summary>
        /// Attempts to add a database entry corresponding to the given User - created by Jon Holmes pulled from PeerVal
        /// </summary>
        /// <remarks></remarks>
        internal static int AddUser(User obj) {
            if (obj == null) return -1;
            MySqlCommand comm = new MySqlCommand("insertUser");
            try {
                // generate new password first.
                obj.Salt = Tools.Hasher.GenerateSalt(50);
                string newPass = Tools.Hasher.Get(obj.Password, obj.Salt, _Pepper, _Stretches, 64);
                obj.Password = newPass;
                // now set object to Database.
                comm.Parameters.AddWithValue("i_" + User.db_Username, obj.Username);
                comm.Parameters.AddWithValue("i_" + User.db_Password, obj.Password);
                comm.Parameters.AddWithValue("i_" + User.db_Salt, obj.Salt);
                comm.Parameters.AddWithValue("i_" + User.db_RoleID, obj.RoleID);
                return AddObject(comm, "i_" + User.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to the database entry corresponding to the given User - created by Jon Holmes pulled from PeerVal
        /// </summary>
        /// <remarks></remarks>

        internal static int UpdateUser(User obj) {
            if (obj == null) return -1;
            MySqlCommand comm = new MySqlCommand("sproc_UserUpdate");
            try {
                string newPass = Tools.Hasher.Get(obj.Password, obj.Salt, _Pepper, _Stretches, 64);
                comm.Parameters.AddWithValue("i_" + User.db_ID, obj.ID);
                comm.Parameters.AddWithValue("i_" + User.db_Username, obj.Username);
                comm.Parameters.AddWithValue("i_" + User.db_Password, newPass);
                comm.Parameters.AddWithValue("i_" + User.db_Salt, obj.Salt);
                comm.Parameters.AddWithValue("i_" + User.db_RoleID, obj.RoleID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Role
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveUser(int ID) {
            if (ID == -1)
                return -1;
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteUser";
                comm.Parameters.AddWithValue("i_" + User.db_ID, ID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }
        #endregion

        #region UserToDepartments
        /// <summary>
        /// gets a list of UserToDepartment from the database
        /// </summary>
        /// <returns>list of UserToDepartment</returns>
        public static List<UserToDepartment> GetUserToDepartments() {
            MySqlCommand comm = new MySqlCommand("getUserToDepartments");
            List<UserToDepartment> retList = new List<UserToDepartment>();
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retList.Add(new UserToDepartment(dr));
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retList;
        }

        /// <summary>
        /// Gets the UserToDepartment with the given ID
        /// </summary>
        /// <remarks></remarks>

        public static UserToDepartment GetUserToDepartment(int id) {
            MySqlCommand comm = new MySqlCommand("getUserToDepartmentByID");
            UserToDepartment retObj = null;
            try {
                comm.Parameters.AddWithValue("i_" + UserToDepartment.db_ID, id);
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retObj = new UserToDepartment(dr);
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retObj;
        }

        /// <summary>
        /// adds a UserToDepartment to the database
        /// </summary>
        /// <param name="obj">the UserToDepartment object</param>
        /// <returns>the UserToDepartments ID or -1 if it fails</returns>
        public static int AddUserToDepartment(UserToDepartment obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("insertUserToDepartment");
            try {
                //comm.Parameters.AddWithValue("i_" + UserToDepartment.db_UserToDepartmentname, obj.UserToDepartmentname);
                return AddObject(comm, "i_" + UserToDepartment.db_ID);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// updates a UserToDepartment in the database
        /// </summary>
        /// <param name="obj">the UserToDepartment object</param>
        /// <returns>the UserToDepartments ID or -1 if it fails</returns>
        public static int UpdateUserToDepartment(UserToDepartment obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand("updateUserToDepartment");
            try {
                comm.Parameters.AddWithValue("i_" + UserToDepartment.db_ID, obj.ID);
                //comm.Parameters.AddWithValue("i_" + UserToDepartment.db_UserToDepartmentname, obj.UserToDepartmentname);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        /// <summary>
        /// Attempts to delete the database entry corresponding to the Role
        /// </summary>
        /// <remarks></remarks>
        public static int RemoveUserToDepartment(UserToDepartment obj) {
            if (obj == null)
                return -1;
            MySqlCommand comm = new MySqlCommand();
            try {
                comm.CommandText = "deleteUserToDepartment";
                comm.Parameters.AddWithValue("i_" + UserToDepartment.db_ID, obj.ID);
                return UpdateObject(comm);
            }
            catch (Exception ex) {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return -1;
        }

        #endregion

        public static bool TestConnection() {
            bool retVal = false;
            MySqlCommand comm = new MySqlCommand("getUsers");
            try {
                comm.CommandType = System.Data.CommandType.StoredProcedure;
                MySqlDataReader dr = GetDataReader(comm);
                while (dr.Read()) {
                    retVal = true;
                }
                comm.Connection.Close();
            }
            catch (Exception ex) {
                comm.Connection.Close();
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return retVal;
        }
    }
}
