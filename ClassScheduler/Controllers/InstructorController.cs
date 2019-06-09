using ClassScheduler.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ClassScheduler.Controllers {
    public class InstructorController : Controller {


        // GET: Instructor
        public async Task<IActionResult> Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Instructors.CanView) {
                List<Instructor> instructors = DAL.GetInstructors();
                Dictionary<int, List<Section>> instructorSchedules = new Dictionary<int, List<Section>>();
                List<InstructorToSection> instructorSections = DAL.GetInstructorToSectionsByAcademicSemesterID(SessionVariables.GetSessionAcademicSemesterID(HttpContext));
                List<Section> sections = DAL.GetSectionsByAcademicSemesterID(SessionVariables.GetSessionAcademicSemesterID(HttpContext));
                foreach (Instructor instructor in instructors) {
                    if (!instructorSchedules.ContainsKey(instructor.ID)) {
                        instructorSchedules.Add(instructor.ID, new List<Section>());
                    }
                    foreach (InstructorToSection its in instructorSections) {
                        if (its.InstructorID == instructor.ID) {
                            instructorSchedules[instructor.ID].Add(DAL.GetSection(its.SectionID));
                        }
                    }
                }
                List<AcademicSemester> academicSemesters = DAL.GetAcademicSemesters();
                List<int> years = new List<int>();
                foreach (AcademicSemester academicSemester in academicSemesters) {
                    if (!years.Contains(academicSemester.AcademicYear)) {
                        years.Add(academicSemester.AcademicYear);
                    }
                }
                ViewData["AcademicSemesterYear"] = SessionVariables.GetSessionAcademicSemester(HttpContext).AcademicYear;
                ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", SessionVariables.GetSessionAcademicSemester(HttpContext).SemesterID);
                ViewData["AcademicYears"] = new SelectList(years, SessionVariables.GetSessionAcademicSemester(HttpContext).AcademicYear);
                ViewData["AcademicSemester"] = SessionVariables.GetSessionAcademicSemester(HttpContext).Display;
                ViewData["InstructorSections"] = instructorSchedules;
                return View(instructors);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view instructors");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Instructor/Details/5
        public async Task<IActionResult> Details(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Instructors.CanView) {
                if (id == null) {
                    return NotFound();
                }
                Instructor instructor = DAL.GetInstructor((int)id);
                if (instructor == null) {
                    return NotFound();
                }
                return View(instructor);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view instructors");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Instructor/Create
        public IActionResult Create() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Instructors.CanAdd) {
                return View();
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create instructors");
                return RedirectToAction("Index");
            }
        }



        // POST: Instructor/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("FirstName,MiddleName,LastName,Number,CourseLoad,ID")] Instructor instructor) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Instructors.CanAdd) {
                if (ModelState.IsValid) {
                    if (DAL.AddInstructor(instructor) > 0) {
                        SessionVariables.SetSuccessMessage("Instructor created successfully");
                    }
                    else {
                        SessionVariables.SetErrorMessage("Instructor create failed");
                    }
                    return RedirectToAction(nameof(Index));
                }
                ViewData["InstructorID"] = new SelectList(DAL.GetInstructors(), "ID", "ID", instructor.ID);
                return View(instructor);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create instructors");
                return RedirectToAction("Index");
            }
        }

        // GET: Instructor/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Instructors.CanEdit) {
                if (id == null) {
                    return NotFound();
                }
                Instructor instructor = DAL.GetInstructor((int)id);
                if (instructor == null) {
                    return NotFound();
                }
                return View(instructor);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit instructors");
                return RedirectToAction("Index");
            }
        }

        // POST: Instructor/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("FirstName,MiddleName,LastName,Number,CourseLoad,ID")] Instructor instructor) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Instructors.CanEdit) {
                if (id != instructor.ID) {
                    return NotFound();
                }
                if (ModelState.IsValid) {
                    if (DAL.UpdateInstructor(instructor) > 0) {
                        SessionVariables.SetSuccessMessage("Instructor edited successfully");
                    }
                    else {
                        SessionVariables.SetErrorMessage("Instructor edit failed");
                    }
                    return RedirectToAction(nameof(Index));
                }
                return View(instructor);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit instructors");
                return RedirectToAction("Index");
            }
        }

        // GET: Instructor/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Instructors.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                Instructor instructor = DAL.GetInstructor((int)id);
                if (instructor == null) {
                    return NotFound();
                }
                return View(instructor);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete instructors");
                return RedirectToAction("Index");
            }
        }

        // POST: Instructor/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Instructors.CanDelete) {
                if (DAL.RemoveInstructor(id) > 0) {
                SessionVariables.SetSuccessMessage("Instructor deleted successfully");
            }
            else {
                SessionVariables.SetErrorMessage("Instructor delete failed");
            }
            return RedirectToAction(nameof(Index));
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete instructors");
                return RedirectToAction("Index");
            }
        }

        public void ToggleTimeFormat() {
            if (DAL.TimeFormat == "HH:mm") {
                DAL.TimeFormat = "hh:mm tt";
            }
            else {
                DAL.TimeFormat = "HH:mm";
            }
        }

        public void SelectAcademicSemester(int currentSemesterID, int currentYear) {
            SessionVariables.SetSessionAcademicSemesterID(HttpContext, DAL.GetAcademicSemesterByYearAndSemester(currentSemesterID, currentYear).ID);
        }
    }
}
