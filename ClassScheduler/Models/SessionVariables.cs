/* Model for SessionVariables
 * SessionVariables: a static class used to store things pertaining to a web session
 * Created on 3/7/19 by Jason Durfee
 */
using System;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Session;


namespace ClassScheduler.Models {
    public static class SessionVariables {

        #region private variables
        private static int _CurrentAcademicSemesterID = -1;
        private static AcademicSemester _CurrentAcademicSemester;
        private static string _ErrorMessage;
        private static string _ErrorMessageStay;
        private static string _SuccessMessage;
        private static bool _LoggedIn;
        private static bool _ShowMessage = false;

        #endregion

        #region public properties

        /// <summary>
        /// gets and sets the CurrentAcademicSemesterID attribute for this SessionVariables
        /// </summary>
        public static int CurrentAcademicSemesterID {
            get {
                return _CurrentAcademicSemesterID;
            }
            set {
                _CurrentAcademicSemesterID = value;
            }
        }

        /// <summary>
        /// gets and sets the CurrentAcademicSemester attribute for this SessionVariables
        /// </summary>
        public static AcademicSemester CurrentAcademicSemester {
            get {
                if (_CurrentAcademicSemester == null) {
                    if (CurrentAcademicSemesterID <= 0) {
                        int currentYear = DateTime.Now.Year;
                        int semesterID = 1;
                        if (DateTime.Now.DayOfYear > 121 && DateTime.Now.DayOfYear < 241) {
                            semesterID = 2;
                        }
                        if (DateTime.Now.DayOfYear > 242) {
                            semesterID = 3;
                        }
                        var t = DateTime.Now.DayOfYear;
                        _CurrentAcademicSemesterID = DAL.GetAcademicSemesterByYearAndSemester(semesterID, currentYear).ID;
                    }
                    _CurrentAcademicSemester = DAL.GetAcademicSemester(_CurrentAcademicSemesterID);
                }
                return _CurrentAcademicSemester;
            }
            set {
                _CurrentAcademicSemester = value;
                if (value == null) {
                    _CurrentAcademicSemesterID = -1;
                }
                else {
                    _CurrentAcademicSemesterID = value.ID;
                }
            }
        }

        /// <summary>
        /// Fernando Munoz ---
        /// To my best understanding, although this static class is shared by all users of the application, 
        /// this approach should work practically all the time... barring this application scaling to a massive 
        /// amount of users (where the call to CurrentAcademicSemester would check _CurrentAcademicSemester
        /// and it is no longer null in between the previous null assignment and runnning of CurrentAcademicSemester,
        /// since it could be set by another user...)
        /// </summary>
        /// <param name="HttpContext"></param>
        /// <returns></returns>
        public static AcademicSemester GetSessionAcademicSemester(HttpContext HttpContext) {
            int? testSessionAcadSem = HttpContext.Session.GetInt32("AcademicSemester");

            if (testSessionAcadSem == null || testSessionAcadSem <= 0) {
                // Lets start fresh... make sure when we call CurrentAcademicSemester, we fill out the _CurrentAcademicSemester and 
                // _CurrentAcademicSemesterID by setting them to null & -1
                _CurrentAcademicSemester = null;
                _CurrentAcademicSemesterID = -1;
                HttpContext.Session.SetInt32("AcademicSemester", CurrentAcademicSemester.ID);
            }
            // Return the AcademicSemester based on the provided, or default, AcademicSemesterID
            return DAL.GetAcademicSemester((int)HttpContext.Session.GetInt32("AcademicSemester"));
        }

        public static int GetSessionAcademicSemesterID(HttpContext HttpContext) {
            int? testSessionAcadSem = HttpContext.Session.GetInt32("AcademicSemester");

            if (testSessionAcadSem == null || testSessionAcadSem <= 0) {
                GetSessionAcademicSemester(HttpContext);
            }
            return (int)HttpContext.Session.GetInt32("AcademicSemester");
        }

        public static void SetSessionAcademicSemesterID(HttpContext HttpContext, int acadSemID) {
            HttpContext.Session.SetInt32("AcademicSemester", acadSemID);
        }

        /// <summary>
        /// gets the current user
        /// </summary>
        /// <param name="HttpContext"></param>
        /// <returns></returns>
        public static User GetCurrentUser(HttpContext HttpContext) {
            int? userID = HttpContext.Session.GetInt32("UserID");
            if (userID != null && userID >= 1) {
                User currentUser = DAL.GetUser((int)userID);
                if (currentUser != null) {
                    LoggedIn = true;
                }
                return currentUser;
            }
            return null;
        }
        

        /// <summary>
        /// sets the current user id in the session
        /// </summary>
        /// <param name="HttpContext"></param>
        /// <param name="userID"></param>
        public static void SetCurrentUserID(HttpContext HttpContext, int userID) {
            HttpContext.Session.SetInt32("UserID", userID);
        }

        /// <summary>
        /// gets and sets the show message status
        /// </summary>
        public static bool ShowMessage {
            get { return _ShowMessage; }
            set { _ShowMessage = value; }
        }

        /// <summary>
        /// gets and sets the logged in status
        /// </summary>
        public static bool LoggedIn {
            get { return _LoggedIn; }
            set { _LoggedIn = value; }
        }

        /// <summary>
        /// gets and sets the error message
        /// </summary>
        public static string ErrorMessage {
            get {
                if (_ErrorMessage == null) {
                    return "";
                }
                return _ErrorMessage;
            }
            set { _ErrorMessage = value; }
        }

        /// <summary>
        /// gets and sets the error message that stays
        /// </summary>
        public static string ErrorMessageStay {
            get {
                if (_ErrorMessageStay == null) {
                    return "";
                }
                return _ErrorMessageStay;
            }
            set { _ErrorMessageStay = value; }
        }

        /// <summary>
        /// gets and sets the success message
        /// </summary>
        public static string SuccessMessage {
            get {
                if (_SuccessMessage == null) {
                    return "";
                }
                return _SuccessMessage;
            }
            set { _SuccessMessage = value; }
        }

        /// <summary>
        /// gets and sets the error message
        /// </summary>
        /// <param name="message"></param>
        public static void SetErrorMessage(string message) {
            _ErrorMessage = message;
            _ShowMessage = true;
        }

        /// <summary>
        /// gets and sets the error message
        /// </summary>
        /// <param name="message"></param>
        public static void SetErrorMessageStay(string message) {
            _ErrorMessageStay = message;
            _ShowMessage = true;
        }

        /// <summary>
        /// gets and sets the success message
        /// </summary>
        /// <param name="message"></param>
        public static void SetSuccessMessage(string message) {
            _SuccessMessage = message;
            _ShowMessage = true;
        }

        #endregion

        #region public functions
        #endregion
    }
}

