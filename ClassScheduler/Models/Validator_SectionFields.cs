using ClassScheduler.Models;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

/// <summary>
/// Created by Fernando Munoz
/// April 17th, 2019
/// This validator checks a list of sections provided and returns a list of tuples, 
/// each of which is a Section and a String. The string contains the reasons why a section
/// failed validation.
/// </summary>

namespace ClassScheduler.Models
{
    public class Validator_SectionFields
    {

        public Validator_SectionFields()
        {

        }

        private List<Tuple<Section, List<String>>> _Errors;
        private List<Section> _Sections;

        private enum BadData
        {
            Room, Time, Instructor, Days, StudentLimit
        }

        private readonly Dictionary<BadData, String> ErrorCodes = new Dictionary<BadData, string>()
        {
            [BadData.Room] = "No ROOM",
            [BadData.Time] = "Bad START/END TIME",
            [BadData.Instructor] = "No INSTRUCTOR",
            [BadData.Days] = "No DAY(s)",
            [BadData.StudentLimit] = "No STUDENT LIMIT",
        };

        public List<Tuple<Section, List<String>>> Errors
        {
            get
            {
                return _Errors;
            }
        }

        private void RefreshData(HttpContext httpContext)
        {
            _Sections = DAL.GetSectionsByAcademicSemesterID(SessionVariables.GetSessionAcademicSemesterID(httpContext));
        }

        public List<Tuple<Section, List<String>>> GetErrors(HttpContext httpContext)
        {
            RefreshData(httpContext);
            _Errors = RunChecks();
            return _Errors;
        }


        /// <summary>
        /// This is the main function to validate parameters of a List of Sections.
        /// </summary>
        /// <param name="Sections">The list of Sections to check</param>
        /// <returns>A list of Tuples, whose first item is the erroneous Section. 
        /// The second item is a string with reasons why validation failed for that Section</returns>
        private List<Tuple<Section, List<String>>> RunChecks()
        {
            List<Tuple<Section, List<String>>> errorneousSections = new List<Tuple<Section, List<String>>>();
            Dictionary<int, Instructor> instructors = DAL.GetInstructors().ToDictionary(x => x.ID, x => x);

            foreach(Section s in _Sections)
            {
                List<BadData> sectionCodes = new List<BadData>();

                s.GetInstructorDetails();

                if (!HasRoom(s) && RequiresRoom(s))
                {
                    AddBadDataCode(sectionCodes, BadData.Room);
                }
                if (!HasDays(s) && RequiresDays(s))
                {
                    AddBadDataCode(sectionCodes, BadData.Days);
                }
                if (!IsTimeValid(s) && RequiresTimes(s))
                {
                   AddBadDataCode(sectionCodes, BadData.Time);
                }
                if (!HasPrimaryInst(s))
                {
                    AddBadDataCode(sectionCodes, BadData.Instructor);
                }
                if (!HasStudentLimit(s))
                {
                    AddBadDataCode(sectionCodes, BadData.StudentLimit);
                }

                if(sectionCodes.Count > 0)
                {
                    errorneousSections.Add(new Tuple<Section, List<String>>(s, ConvertDataCodesToString(sectionCodes)));
                }
            }
            return errorneousSections;
        }

        private void FillInstructors(Section s, ref Dictionary<int, Instructor> dict )
        {
            if(s.PrimaryInstructorID != -1)
            {
                s.PrimaryInstructor = dict[s.PrimaryInstructorID];
            }
            if (s.SecondaryInstructorID != -1)
            {
                s.SecondaryInstructor = dict[s.SecondaryInstructorID];
            }
        }

        /// <summary>
        /// Checks to make sure the time is valid on a section
        /// </summary>
        /// <param name="s">Section to be checked for valid time parameters</param>
        /// <returns>True if StartTime and EndTime are valid</returns>
        private bool IsTimeValid(Section s)
        {
            if(s.StartTime == DAL.MinimumDateTime || s.EndTime == DAL.MinimumDateTime || s.StartTime > s.EndTime || s.EndTime < s.StartTime || s.StartTime == s.EndTime)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// Checks to ensure a section has a primary instructor assigned
        /// </summary>
        /// <param name="s">Section to be checked for an Instructor</param>
        /// <returns>True if the Primary Instructor has been assgined</returns>
        private bool HasPrimaryInst(Section s)
        {
            if(s.PrimaryInstructor == null)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// Checks to ensure a section has Day(s) assigned
        /// </summary>
        /// <param name="s">Section to be checked for Day(s)</param>
        /// <returns>True if 1 or more days are assigned</returns>
        private bool HasDays(Section s)
        {
            if (s.Days != null && s.Days.Count > 0)
            {
                return true;
            }
            return false;
        }
        /// <summary>
        /// Checks to ensure a section has a room
        /// </summary>
        /// <param name="s">Section to be checked for a room parameter</param>
        /// <returns>True if has room</returns>
        private bool HasRoom(Section s)
        {
            if(s.Room != null)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// Checks to ensure at least 1 student has been assigned to a section
        /// </summary>
        /// <param name="s">Section to be checked for students</param>
        /// <returns>True if StudentLimit > 0</returns>
        private bool HasStudentLimit(Section s)
        {
            if(s.StudentLimit > 0)
            {
                return true;
            }
            return false;
        }

        private bool RequiresRoom(Section s)
        {
            return s.ScheduleType.RequiresRoom;
        }
        private bool RequiresDays(Section s)
        {
            return s.ScheduleType.RequiresDays;
        }
        private bool RequiresTimes(Section s)
        {
            return s.ScheduleType.RequiresTimes;
        }



        /// <summary>
        /// Adds a BadData enum value to a list of codes
        /// </summary>
        /// <param name="list">List to add the enum value to</param>
        /// <param name="code">The BadData enum value to add to the list</param>
        private void AddBadDataCode(List<BadData> list, BadData code)
        {
            list.Add(code);
        }

        /// <summary>
        /// Converts a List of BadData enums into a string representing the same codes
        /// </summary>
        /// <param name="codes">A list of BadData enum codes</param>
        /// <returns>A string representation explaining each BadData code, separarted by newlines</returns>
        private List<String> ConvertDataCodesToString(List<BadData> codes)
        {
            List<String> stringifiedCodes = new List<String>();
            foreach(BadData bd in codes)
            {
                stringifiedCodes.Add(ErrorCodes[bd]);
            }
            return stringifiedCodes;
        }
    }
}
