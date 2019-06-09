using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ClassScheduler.Models;
using Microsoft.AspNetCore.Mvc;

namespace ClassScheduler.Controllers
{
    public class ScheduleValidatorController : Controller
    {
        public async Task<IActionResult> Index()
        {
            return View();
        }

        // These routes are for the AJAX calls on the mian validator page
        [Route("CheckSectionData")]
        public IActionResult CheckSectionData()
        {
            return new JsonResult(ScheduleValidator.HasSectionFieldErrors(HttpContext));
        }

        [Route("CheckSectionResources")]
        public IActionResult CheckSectionResources()
        {
            return new JsonResult(ScheduleValidator.HasSectionResourceConflicts(HttpContext));
        }

        [Route("CheckInstructorCourseLoads")]
        public IActionResult CheckInstructorCourseLoads()
        {
            return new JsonResult(ScheduleValidator.HasInstructorCourseLoadIssues(HttpContext));
        }

        // These are utilized on the views for each sub-validator
        public async Task<IActionResult> SectionResources()
        {

            Validator_SectionResourceConflicts sectionResourceChecker = new Validator_SectionResourceConflicts();
            sectionResourceChecker.GetErrors(HttpContext);
            return View(sectionResourceChecker.Conflicts);
        }

        public async Task<IActionResult> CourseLoads()
        {
            Validator_InstructorCourseLoad courseLoadChecker = new Validator_InstructorCourseLoad();
            courseLoadChecker.GetErrors(HttpContext);
            return View(courseLoadChecker.Issues);
        }

        public async Task<IActionResult> SectionData()
        {
            Validator_SectionFields sectionFieldChecker = new Validator_SectionFields();
            sectionFieldChecker.GetErrors(HttpContext);
            return View(sectionFieldChecker.Errors);
        }
    }
}