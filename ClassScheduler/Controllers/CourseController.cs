using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace ClassScheduler.Models {
    /*
     * Completed by Fernando Munoz
     * February 22nd, 2019
     */

    public class CourseController : Controller {

        // GET: Course
        public async Task<IActionResult> Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Courses.CanView) {
                List<Course> courses = DAL.GetCourses();
                return View(courses);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view courses");
                return RedirectToAction("Index", "Section");
            }
        }

        //GET: Course/Sync
        public async Task<IActionResult> Sync() {
            List<Course> dbCourses = DAL.GetCourses();
            List<Course> catCourses = FakeDAL.GetCoursesFromCatalog();
            foreach (Course course in catCourses) {
                int chk = (from dbCrs in dbCourses
                           where (dbCrs.Department.Abbreviation == course.Department.Abbreviation && dbCrs.Number == course.Number)
                           select dbCrs).Count();
                if (chk < 1) {
                    DAL.AddCourse(course);
                }

            }
            return RedirectToAction(nameof(Index));
        }

        // GET: Course/Details/5
        public async Task<IActionResult> Details(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Courses.CanView) {
                if (id == null) {
                    return NotFound();
                }
                Course course = DAL.GetCourse((int)id);
                if (course == null) {
                    return NotFound();
                }
                return View(course);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view courses");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Course/Create
        public IActionResult Create() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Courses.CanAdd) {
                List<Department> departments = DAL.GetDepartments();
                ViewData["DepartmentID"] = new SelectList(departments, "ID", "Abbreviation");
                ViewData["CrossListedDepartmentID"] = new SelectList(departments, "ID", "Abbreviation");
                ViewData["CrossScheduledDepartmentID"] = new SelectList(departments, "ID", "Abbreviation");
                return View(new Course());
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to add courses");
                return RedirectToAction("Index");
            }
        }

        // POST: Course/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,DepartmentID,Title,Number,MinimumCredits,MaximumCredits,FixedCredits," +
            "IsFixedCredits,Description,IsCrossListed,IsCrossScheduled,CrossListedCourseID,CrossScheduledCourseID")] Course course) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Courses.CanAdd) {
                Course courseToCrossList = null;
                Course courseToCrossSchedule = null;
                if (ModelState.IsValid) {
                    if (!course.IsCrossListed) {
                        course.CrossListedCourseID = -1;
                    }
                    else {
                        courseToCrossList = DAL.GetCourse(course.CrossListedCourseID);
                    }
                    int newCourseID = DAL.AddCourse(course);
                    if (newCourseID > 0 && courseToCrossList != null && courseToCrossList.ID > 0) {
                        courseToCrossList.CrossListedCourseID = newCourseID;
                        DAL.UpdateCourse(courseToCrossList);
                    }
                    if (!course.IsCrossScheduled) {
                        course.CrossScheduledCourseID = -1;
                    }
                    else {
                        courseToCrossSchedule = DAL.GetCourse(course.CrossScheduledCourseID);
                    }
                    if (newCourseID > 0 && courseToCrossSchedule != null && courseToCrossSchedule.ID > 0) {
                        courseToCrossSchedule.CrossScheduledCourseID = newCourseID;
                        DAL.UpdateCourse(courseToCrossSchedule);
                    }
                    return RedirectToAction(nameof(Index));
                }
                return View(course);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to add courses");
                return RedirectToAction("Index");
            }
        }


        // GET: Course/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Courses.CanEdit) {
                List<Department> departments = DAL.GetDepartments();
                if (id == null) {
                    return NotFound();
                }
                Course course = DAL.GetCourse((int)id);
                if (course == null) {
                    return NotFound();
                }
                ViewData["DepartmentID"] = new SelectList(departments, "ID", "Abbreviation", course.DepartmentID);
                if (course.CrossListedCourseID > 0) {
                    course.IsCrossListed = true;
                    ViewData["CrossListedDepartmentID"] = new SelectList(departments, "ID", "Abbreviation", DAL.GetCourse(course.CrossListedCourseID).DepartmentID);
                }
                else {
                    course.IsCrossListed = false;
                    ViewData["CrossListedDepartmentID"] = new SelectList(departments, "ID", "Abbreviation");
                }
                if (course.CrossScheduledCourseID > 0) {
                    course.IsCrossScheduled = true;
                    ViewData["CrossScheduledDepartmentID"] = new SelectList(departments, "ID", "Abbreviation", DAL.GetCourse(course.CrossScheduledCourseID).DepartmentID);
                }
                else {
                    course.IsCrossScheduled = false;
                    ViewData["CrossScheduledDepartmentID"] = new SelectList(departments, "ID", "Abbreviation");
                }
                ViewData["CrossListedCourseNumbers"] = new SelectList(DAL.GetCourses(), "ID", "NumberAndTitle", course.CrossListedCourseID);
                ViewData["CrossScheduledCourseNumbers"] = new SelectList(DAL.GetCourses(), "ID", "NumberAndTitle", course.CrossScheduledCourseID);
                return View(course);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit courses");
                return RedirectToAction("Index");
            }
        }

        // POST: Course/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind(" ID,DepartmentID,FixedCredits,MaximumCredits,MinimumCredits,Title,Number," +
            "IsFixedCredit,Description,IsCrossListed,IsCrossScheduled,CrossListedCourseID,CrossScheduledCourseID")] Course course) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Courses.CanEdit) {
                Course courseToCrossList = null;
                Course courseToCrossSchedule = null;
                if (id != course.ID) {
                    return NotFound();
                }
                if (ModelState.IsValid) {
                    if (course.IsCrossListed) {
                        courseToCrossList = DAL.GetCourse(course.CrossListedCourseID);
                        if (courseToCrossList != null) {
                            courseToCrossList.CrossListedCourseID = id;
                            DAL.UpdateCourse(courseToCrossList);
                        }
                    }
                    else {
                        if (DAL.GetCourse(id).CrossListedCourseID > 0) {
                            //have to get the course from the database because the cross list ID may or may not be the right one
                            Course currentCourse = DAL.GetCourse(id);
                            Course courseToRemoveCrossList = DAL.GetCourse(currentCourse.CrossListedCourseID);
                            if (courseToRemoveCrossList != null) {
                                courseToRemoveCrossList.CrossListedCourseID = -1;
                                DAL.UpdateCourse(courseToRemoveCrossList);
                            }
                        }
                        course.CrossListedCourseID = -1;
                    }
                    if (course.IsCrossScheduled) {
                        courseToCrossSchedule = DAL.GetCourse(course.CrossScheduledCourseID);
                        if (courseToCrossSchedule != null) {
                            courseToCrossSchedule.CrossScheduledCourseID = id;
                            DAL.UpdateCourse(courseToCrossSchedule);
                        }
                    }
                    else {
                        if (DAL.GetCourse(id).CrossScheduledCourseID > 0) {
                            //have to get the course from the database because the cross list ID may or may not be the right one
                            Course currentCourse = DAL.GetCourse(id);
                            Course courseToRemoveCrossSchedule = DAL.GetCourse(currentCourse.CrossScheduledCourseID);
                            if (courseToRemoveCrossSchedule != null) {
                                courseToRemoveCrossSchedule.CrossScheduledCourseID = -1;
                                DAL.UpdateCourse(courseToRemoveCrossSchedule);
                            }
                        }
                        course.CrossScheduledCourseID = -1;
                    }
                    if (DAL.UpdateCourse(course) >= 0) {
                        SessionVariables.SetSuccessMessage("Course edited");
                    }
                    else {
                        SessionVariables.SetErrorMessage("Course edit failed");
                    }
                    return RedirectToAction(nameof(Index));
                }
                ViewData["DepartmentID"] = new SelectList(DAL.GetDepartments(), "ID", "Abbreviation", course.DepartmentID);
                return View(course);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit courses");
                return RedirectToAction("Index");
            }
        }

        // GET: Course/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Courses.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                Course course = DAL.GetCourse((int)id);
                if (course == null) {
                    return NotFound();
                }
                return View(course);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete courses");
                return RedirectToAction("Index");
            }
        }

        // POST: Course/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Courses.CanDelete) {
                DAL.RemoveCourse(id);
                return RedirectToAction(nameof(Index));
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete courses");
                return RedirectToAction("Index");
            }
        }

        public List<Course> FillCourseNumbers(int departmentID) {
            List<Course> retList = new List<Course>();
            List<Course> courses = DAL.GetCourses();
            foreach (Course course in courses) {
                if (course.DepartmentID == departmentID) {
                    retList.Add(course);
                }
            }
            return retList;
        }

    }
}

