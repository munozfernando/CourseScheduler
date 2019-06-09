using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel;
using Microsoft.AspNetCore.Http;

namespace ClassScheduler.Models {
        static public class ScheduleValidator {


        internal static bool HasSectionResourceConflicts(HttpContext httpContext)
        {
            Validator_SectionResourceConflicts sectionResourceChecker = new Validator_SectionResourceConflicts();
            sectionResourceChecker.GetErrors(httpContext);
            if (sectionResourceChecker.Conflicts.Count < 1)
            {
                return false;
            }
            return true;
        }

        public static bool HasInstructorCourseLoadIssues (HttpContext httpContext)
        {
            Validator_InstructorCourseLoad courseLoadChecker = new Validator_InstructorCourseLoad();
            courseLoadChecker.GetErrors(httpContext);
            if (courseLoadChecker.Issues.Count < 1)
            {
                return false;
            }
            return true;
        }

        public static bool HasSectionFieldErrors (HttpContext httpContext)
        {
            Validator_SectionFields sectionFieldChecker = new Validator_SectionFields();
            sectionFieldChecker.GetErrors(httpContext);
            if (sectionFieldChecker.Errors.Count < 1)
            {
                return false;
            }
            return true;
        }
    }
}
