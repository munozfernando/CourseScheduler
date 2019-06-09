using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using MySql.Data.MySqlClient;
using System.ComponentModel.DataAnnotations;


namespace ClassScheduler.Models
{
    public class Validator_InstructorCourseLoad
    {
        private List<Tuple<Instructor, int, List<String>>> _Issues;
        private List<InstructorToSection> _InstructorToSections;

        public Validator_InstructorCourseLoad()
        {

        }

        private enum Errors
        {
            UnsetLimit, Over, Under, ScheduleType
        }

        private readonly Dictionary<Errors, String> ErrorCodes = new Dictionary<Errors, string>()
        {
            [Errors.UnsetLimit] = "Unset Load / Schedule Type Errors",
            [Errors.Over] = "Overloaded",
            [Errors.Under] = "Load Deficit"
        };

        public List<Tuple<Instructor, int, List<String>>> Issues
        {
            get
            {
                return _Issues;
            }
        }
        public List<Tuple<Instructor, int, List<String>>> GetErrors(HttpContext httpContext)
        {
            RefreshData(httpContext);
            _Issues = RunChecks();
            return _Issues;
        }
        private void RefreshData(HttpContext httpContext)
        {
            _InstructorToSections = DAL.GetInstructorToSectionsByAcademicSemesterID(SessionVariables.GetSessionAcademicSemesterID(httpContext));
        }

        public List<Tuple<Instructor, int, List<String>>> RunChecks()
        {
            List<Tuple<Instructor, int, List<String>>> courseLoadIssues = new List<Tuple<Instructor,int, List<String>>>();

            MapSectionsToInstSects();
            Dictionary<Instructor, int> instructorSectionCounts = ConsolidateSections(_InstructorToSections);

            foreach (KeyValuePair<Instructor, int> kvp in instructorSectionCounts)
            {
                List<Errors> errors = new List<Errors>();

                if (!IsCourseLoadSet(kvp.Key))
                {
                    AddBadDataCode(errors, Errors.UnsetLimit);
                }
                else if (IsCourseDeficit(kvp))
                {
                    AddBadDataCode(errors, Errors.Under);
                }
                else if (IsCourseOverload(kvp))
                {
                    AddBadDataCode(errors, Errors.Over);
                }

                if (errors.Count > 0)
                {
                    courseLoadIssues.Add(new Tuple<Instructor, int, List<String>>(kvp.Key, kvp.Value, ConvertDataCodesToString(errors)));
                }
            }
            return courseLoadIssues;
        }

        // NOTE: We are considering Early 8 and Late 8 courses to each be equivalent to 1 course for a semester
        private Dictionary<Instructor, int> ConsolidateSections(List<InstructorToSection> instSecs)
        {
            Dictionary<int, int> IDToSecCount = new Dictionary<int, int>();
            Dictionary<int, List<Section>> instSectionsMap = new Dictionary<int, List<Section>>();
            Dictionary<Instructor, int> finalInstToSecCoount = new Dictionary<Instructor, int>();

            foreach (InstructorToSection instuctorSection in instSecs)
            {
                if (instuctorSection.InstructorID > -1)
                {
                    if (instSectionsMap.ContainsKey(instuctorSection.InstructorID))
                    {
                        instSectionsMap[instuctorSection.InstructorID].Add(instuctorSection.Section);
                    }
                    else
                    {
                        instSectionsMap.Add(instuctorSection.InstructorID, new List<Section>()
                        {
                            instuctorSection.Section,
                        });
                    }
                }
            }

            IDToSecCount = CountSections(instSectionsMap);

            foreach (KeyValuePair<int, int> kvp in IDToSecCount)
            {
                finalInstToSecCoount.Add(DAL.GetInstructor(kvp.Key), kvp.Value);
            }
            return finalInstToSecCoount;
        }

        private Dictionary<int, int> CountSections(Dictionary<int, List<Section>> instToSectListMap )
        {
            Dictionary<int, int> instLoadCounts = new Dictionary<int, int>();

            foreach(KeyValuePair<int, List<Section>> kvp in instToSectListMap)
            {
                bool done = false;
                int count = 0;

                List<Section> secTemp = kvp.Value.ToList();
                List<Section> secTempCopy = kvp.Value.ToList();

                while (!done)
                {
                    if (count >= secTemp.Count)
                    {
                        done = true;
                        break;
                    }
                    Section current = secTemp.ElementAt(count);

                    foreach (Section s in secTemp)
                    {
                        if(current != s)
                        {
                            if (HasPotentialIssue(current, s))
                            {
                                if (IsSamePartOfTerm(current, s))
                                {
                                    secTempCopy.Remove(secTempCopy.Find(x => x.ID == s.ID));
                                }
                            }
                        }
                    }
                    secTemp = secTempCopy.ToList();
                    count++;
                }
                instLoadCounts.Add(kvp.Key, count);
            }
            return instLoadCounts;
        }
        
        private void MapSectionsToInstSects()
        {
            Dictionary<int, Section> tempSections = DAL.GetSections().ToDictionary(x => x.ID, x => x);

            foreach(InstructorToSection IS in _InstructorToSections)
            {
                IS.Section = tempSections[IS.SectionID];
            }
        }

        private bool IsCourseLoadSet(Instructor i)
        {
            if (i.CourseLoad > 0)
            {
                return true;
            }
            return false;
        }

        private bool IsCourseDeficit(KeyValuePair<Instructor, int> kvp)
        {
            if (kvp.Value < kvp.Key.CourseLoad)
            {
                return true;
            }
            return false;
        }

        private bool IsCourseOverload(KeyValuePair<Instructor, int> kvp)
        {
            if (kvp.Value > kvp.Key.CourseLoad)
            {
                return true;
            }
            return false;
        }

        private bool HasPotentialIssue(Section a, Section b)
        {
            if (IsDayConflict(a, b) && IsTimeConflict(a, b))
            {
                return true;
            }
            return false;
        }

        private bool IsTimeConflict(Section a, Section b)
        {
            if (b.EndTime.TimeOfDay > a.StartTime.TimeOfDay && b.StartTime.TimeOfDay < a.EndTime.TimeOfDay)
            {
                return true;
            }
            return false;
        }

        private bool IsDayConflict(Section a, Section b)
        {
            if (a.Days != null && b.Days != null && a.Days.Count > 0 && b.Days.Count > 0)
            {
                foreach (Day dA in a.Days)
                {
                    foreach (Day dB in b.Days)
                    {
                        if (dB.ID == dA.ID)
                        {
                            return true;
                        }
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

        private bool IsSamePartOfTerm(Section a, Section b)
        {
            if (a.PartOfTermID != -1 && b.PartOfTermID != -1 && a.PartOfTermID == b.PartOfTermID)
            {
                return true;
            }
            return false;
        }

        private void AddBadDataCode(List<Errors> list, Errors code)
        {
            list.Add(code);
        }

        /// <summary>
        /// Converts a List of Error enums into a string representing the same codes
        /// </summary>
        /// <param name="codes">A list of BadData enum codes</param>
        /// <returns>A string representation explaining each BadData code, separarted by newlines</returns>
        private List<String> ConvertDataCodesToString(List<Errors> codes)
        {
            List<String> stringifiedCodes = new List<String>();
            foreach (Errors bd in codes)
            {
                stringifiedCodes.Add(ErrorCodes[bd]);
            }
            return stringifiedCodes;
        }

    }

}
