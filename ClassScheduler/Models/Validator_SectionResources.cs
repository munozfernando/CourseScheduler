using ClassScheduler.Models;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

/// <summary>
/// Created by Fernando Munoz
/// 04/19/2019
/// Utility Class: Validates all sections for resource conflicts between each other
/// </summary>
namespace ClassScheduler.Models
{
    public class Validator_SectionResourceConflicts
    {
        public Validator_SectionResourceConflicts()
        {

        }

        private Dictionary<int, Section> _Sections;
        private Dictionary<int, List<int>> _CourseIDToXCourses;
        private List<Tuple<Section, Section, String>> _Conflicts;

        private enum Conflict
        {
            Room, Instructor, PartOfTerm, CrossCandidate
        }
        
        private readonly Dictionary<Conflict, String> _ConflictReasons = new Dictionary<Conflict, String>()
        {
            [Conflict.Room] = "Room",
            [Conflict.Instructor] = "Instructor",
            [Conflict.PartOfTerm] = "Part Of Term",
            [Conflict.CrossCandidate] = "Add X'ed to Courses"
        };

        public List<Tuple<Section, Section, String>> GetErrors(HttpContext httpContext)
        {
            RefreshData(httpContext);
            _Conflicts = RunChecks();
            return _Conflicts;
        }

        public List<Tuple<Section, Section, String>> Conflicts
        {
            get
            {
                return _Conflicts;
            }
        }

        private void RefreshData(HttpContext httpContext)
        {
            _Sections = DAL.GetSectionsByAcademicSemesterID(SessionVariables.GetSessionAcademicSemesterID(httpContext)).ToDictionary(x => x.ID, x => x);
        }
        /// <summary>
        /// Checks two sections for time conflicts
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        private bool IsTimeConflict(Section a, Section b)
        {
            if (b.EndTime.TimeOfDay > a.StartTime.TimeOfDay && b.StartTime.TimeOfDay < a.EndTime.TimeOfDay)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// Compares two Sections for Day overlap
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns>True if any days are found to match between the two</returns>
        private bool IsDayConflict(Section a, Section b)
        {
            if (a.Days != null && b.Days != null && a.Days.Count > 0 && b.Days.Count > 0)
            {
                foreach (Day dA in a.Days)
                {
                    foreach( Day dB in b.Days)
                    {
                        if(dB.ID == dA.ID)
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
        }
   
        /// <summary>
        /// Checks if two sections share an instructor
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        private bool IsInstructorConflict(Section a, Section b)
        {
            if (a.PrimaryInstructor != null && b.PrimaryInstructor != null)
            {
                if (a.PrimaryInstructorID == b.PrimaryInstructorID)
                {
                    return true;
                }
                if (b.SecondaryInstructor != null && a.PrimaryInstructorID == b.SecondaryInstructorID)
                {
                    return true;
                }
            }
            if (a.SecondaryInstructor != null )
            {
                if (b.SecondaryInstructor != null)
                {
                    if(a.SecondaryInstructorID == b.SecondaryInstructorID)
                    {
                        return true;
                    }
                }
                if (b.PrimaryInstructor != null)
                {
                    if(a.SecondaryInstructorID == b.SecondaryInstructorID)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        private bool IsRoomConflict(Section a, Section b)
        {
            if (a.Room != null && b.Room != null && a.RoomID == b.RoomID)
            {
                return true;
            }
            return false;
        }
        
        /// <summary>
        /// Compares both Sections for XLSTID vs both Section's Course name
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns>True if either Section's XLSTID matches the Course name of the other</returns>
        private bool IsCrossListed(Section a, Section b)
        {
            if (a.Course.CrossListedCourseID != -1 && b.Course.CrossListedCourseID != -1)
            {
                if (a.Course.CrossListedCourseID == b.CourseID || b.Course.CrossListedCourseID == a.CourseID)
                {
                     return true;
                }
            }
            return false;
        }

        /// <summary>
        /// Builds a dictionary of all the cross-listed and cross-scheduled courses to match on with an int ID to List<int>
        /// </summary>
        /// <returns></returns>
        private Dictionary<int, List<int>> BuildCourseCrossedGroupings()
        {
            List<Course> courses = DAL.GetCourses();
            Dictionary<int, Course> courseMapping = courses.ToDictionary(x => x.ID, x => x);
            _CourseIDToXCourses = new Dictionary<int, List<int>>();

            foreach (Course c in courses)
            {
                List<int> grouping = new List<int>();

                if(c.CrossListedCourseID > 0)
                {
                    if (courseMapping.ContainsKey(c.CrossListedCourseID))
                    {
                        if (courseMapping[c.CrossListedCourseID].CrossListedCourseID > 0 &&
                           courseMapping.ContainsKey(courseMapping[c.CrossListedCourseID].CrossListedCourseID))
                        {
                            grouping.Add(courseMapping[courseMapping[c.CrossListedCourseID].CrossListedCourseID].ID);
                        }
                        if (courseMapping[c.CrossListedCourseID].CrossScheduledCourseID > 0 &&
                            courseMapping.ContainsKey(courseMapping[c.CrossListedCourseID].CrossScheduledCourseID))
                        {
                            grouping.Add(courseMapping[courseMapping[c.CrossListedCourseID].CrossScheduledCourseID].ID);
                        }
                    }
                }
                if (c.CrossScheduledCourseID > 0)
                {
                    if (courseMapping.ContainsKey(c.CrossScheduledCourseID))
                    {
                        if (courseMapping[c.CrossScheduledCourseID].CrossListedCourseID > 0 &&
                            courseMapping.ContainsKey(courseMapping[c.CrossScheduledCourseID].CrossListedCourseID))
                        {
                            grouping.Add(courseMapping[courseMapping[c.CrossScheduledCourseID].CrossListedCourseID].ID);
                        }
                        if (courseMapping[c.CrossScheduledCourseID].CrossScheduledCourseID > 0 &&
                            courseMapping.ContainsKey(courseMapping[c.CrossScheduledCourseID].CrossScheduledCourseID))
                        {
                            grouping.Add(courseMapping[courseMapping[c.CrossScheduledCourseID].CrossScheduledCourseID].ID);
                        }
                    }
                }
                grouping.Add(c.ID);
                _CourseIDToXCourses.Add(c.ID, grouping);
            }
            return _CourseIDToXCourses;
        }

        /// <summary>
        /// Compares two Sections for CrossScheduling, as described in the course catalog
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns>True if the two sections are cross-scheduled</returns>
        private bool IsCrossScheduled(Section a, Section b)
        {
            if (a.Course.CrossScheduledCourseID != -1 && b.Course.CrossScheduledCourseID != -1)
            {
                if (a.Course.CrossScheduledCourseID == b.CourseID || b.Course.CrossScheduledCourseID == a.CourseID)
                {
                    return true;
                }
            }
            return false;
        }

        /// <summary>
        /// This is bandaid job. A real fix would require an association from PartOfTerm to AcademicSemester...
        /// </summary>
        /// <param name="a"></param>
        /// <param name="b"></param>
        /// <returns></returns>
        private bool IsPartOfTermConflict(Section a, Section b)
        {
            int sa = a.PartOfTerm.StartWeek;
            int ea = a.PartOfTerm.EndWeek;
            int sb = b.PartOfTerm.StartWeek;
            int eb = b.PartOfTerm.EndWeek;

            if (a.AcademicSemester.Semester.Name == "Summer" || b.AcademicSemester.Semester.Name == "Summer")
            {
                if (a.PartOfTerm.Name == "Late 8")
                {
                    sa = 5; ea = 12;
                }
                if (b.PartOfTerm.Name == "Late 8")
                {
                    sb = 5; eb = 12;
                }
            }

            if (eb > sa && sb < ea)
            {
                return true;
            }
            return false;
        }

        private bool IsSamePartOfTerm(Section a, Section b)
        {
            if(a.PartOfTermID != -1 && b.PartOfTermID != -1 && a.PartOfTermID == b.PartOfTermID)
            {
                return true;
            }
            return false;
        }

        private bool IsSameCourse(Section a, Section b)
        {
            if(a.CourseID > -1 && a.CourseID == b.CourseID)
            {
                return true;
            }
            return false;
        }

        private bool IsSameCampus(Section a, Section b)
        {
            if (a.Room != null && b.Room != null)
            {
                if (a.Room.Building != null && b.Room.Building != null)
                {
                    if(a.Room.Building.CampusID == b.Room.Building.CampusID)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        private bool IsCrossCandidate(Section a, Section b)
        {
            if( a.XListID != null && b.XListID != null && a.XListID != "" && b.XListID != "")
            {
                if(a.XListID == b.XListID)
                {
                    return true;
                }
            }
            return false;
        }

        private bool HasPotentialIssue(Section a, Section b)
        {
            if(IsRoomConflict(a, b) && IsDayConflict(a, b) && IsTimeConflict(a, b))
            {
                return true;
            }
            return false;
        }

        private List<Tuple<Section, Section, String>> RunChecks()
        {
            List<Tuple<Section, Section, String>> conflictingSections = new List<Tuple<Section, Section, String>>();
            Section[] temp = _Sections.Values.ToArray();

            foreach(Section s in temp)
            {
                s.GetInstructorDetails();
            }

            Dictionary<int, List<int>> courseXGroupings = BuildCourseCrossedGroupings();
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();
            for (int i = 0; i < temp.Length; i++)
            {
                for (int j = i + 1; j < temp.Length; j++)
                {
                    List<Conflict> conflicts = Compare(temp[i], temp[j], courseXGroupings);
                    String reason = BuildConflictReasonString(conflicts);
                    if (!String.IsNullOrEmpty(reason))
                    {
                        Tuple<Section, Section, String> foundConflict = new Tuple<Section, Section, string>(temp[i], temp[j], reason);
                        conflictingSections.Add(foundConflict);
                    }
                }
            }
            stopWatch.Stop();
            // Get the elapsed time as a TimeSpan value.
            TimeSpan ts = stopWatch.Elapsed;

            // Format and display the TimeSpan value. 
            string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
                ts.Hours, ts.Minutes, ts.Seconds,
                ts.Milliseconds / 10);
            Console.WriteLine("RunTime " + elapsedTime);
            return conflictingSections;
        }

        private bool CheckIfCrossedInAnyWay(int firstCourseID, int secondCourseID)
        {
            if(_CourseIDToXCourses[firstCourseID].Contains(secondCourseID) || _CourseIDToXCourses[secondCourseID].Contains(firstCourseID))
            {
                return true;
            }
            return false;
        }

        private List<Conflict> Compare(Section a, Section b, Dictionary<int, List<int>> courseIDToXCourses)
        {
            List<Conflict> thisIsAListOfTheIssuesTheseTwoHave = new List<Conflict>();
            // #needscounseling,
            // #dontworry,we'llgetyouguysthroughthis
            // #0conflictsftw
            // #veryunlikely
            // #pleasedontbreakthisprecariouslogic
            // #checkoutthisbeautifulnestibuilt
            // #dontbreakthenest
            // #inmylastlife,iwasabird,probably
            // #prettysureonlylikedalillamasgettoknowwhattheyusedtobe
            // #dontreincarnateasabug
            // #wesquishbugs
            // #ifidocomebackasabug,idcomebackasa737max8flightcontrolbug
            // #toosoon

            // !!!!!!!!!!!!!!THIS LOGIC IS PRECARIOUS!!!!!!!!!!!!!
            // Just kidding, but seriously, modify with caution...
            // First, establish the we are in the same term and that the two are not crossed
            if (!IsCrossScheduled(a, b) && !IsCrossListed(a, b) && IsPartOfTermConflict(a, b))
            {
                // Now, check if we have day and time overlap
                if (IsDayConflict(a, b) && IsTimeConflict(a, b))
                {
                    // if we do have overlap, check to see if either one is in the crossed groupings
                    if (!CheckIfCrossedInAnyWay(a.CourseID, b.CourseID))
                    {
                        // If same instructor (independent of room), then we have instructor issue, since 
                        // one instructor cannot teach two courses at the same time (that arent crossed)
                        if (IsInstructorConflict(a, b))
                        {
                            AddConflictCode(thisIsAListOfTheIssuesTheseTwoHave, Conflict.Instructor);
                        }
                        // The spreadsheet matches XLSTID, but the courses do not have each other crossed in the database
                        else if (IsCrossCandidate(a, b)){
                            AddConflictCode(thisIsAListOfTheIssuesTheseTwoHave, Conflict.CrossCandidate);
                        }
                        // Not the same instructor, we have a time conflict
                        else if (IsRoomConflict(a, b))
                        {
                            AddConflictCode(thisIsAListOfTheIssuesTheseTwoHave, Conflict.Room);
                        }
                        
                    }
                }
            }
            return thisIsAListOfTheIssuesTheseTwoHave;
        }

        private string BuildConflictReasonString(List<Conflict> conflictCodes)
        {
            String reasons = "";
            if (conflictCodes != null && conflictCodes.Count > 0)
            {
                foreach (Conflict code in conflictCodes)
                {
                    reasons += " " + _ConflictReasons[code];
                }
            }
            return reasons;
        }

        private void AddConflictCode(List<Conflict> conflicts, Conflict newConflict)
        {
            conflicts.Add(newConflict);
        }

    }
}
