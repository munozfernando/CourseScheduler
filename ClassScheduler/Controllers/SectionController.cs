using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using ClassScheduler.Models;
using Microsoft.AspNetCore.Hosting;

namespace ClassScheduler.Controllers {
    public class SectionController : Controller {
        // GET: Section
        public IActionResult Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Sections.CanView) {
                List<AcademicSemester> academicSemesters = DAL.GetAcademicSemesters();
                List<int> years = new List<int>();
                foreach (AcademicSemester academicSemester in academicSemesters) {
                    if (!years.Contains(academicSemester.AcademicYear)) {
                        years.Add(academicSemester.AcademicYear);
                    }
                }
                List<Section> sections = DAL.GetSectionsByAcademicSemesterID(SessionVariables.GetSessionAcademicSemester(HttpContext).ID);
                ViewData["AcademicSemesterYear"] = SessionVariables.GetSessionAcademicSemester(HttpContext).AcademicYear;
                ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", SessionVariables.GetSessionAcademicSemester(HttpContext).SemesterID);
                ViewData["AcademicYears"] = new SelectList(years, SessionVariables.GetSessionAcademicSemester(HttpContext).AcademicYear);
                ViewData["AcademicSemester"] = SessionVariables.GetSessionAcademicSemester(HttpContext).Display;
                return View(sections);
            }
            else {
                SessionVariables.SetErrorMessage("Login required");
                return RedirectToAction("Login", "User");
            }
        }

        // GET: Section/Create
        public IActionResult Create() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Sections.CanAdd) {
                Section newSection = new Section() { CourseID = -1 };
                ViewData["Section"] = newSection;
                SetUpSectionViewBags(newSection);
                return View();
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to do that");
                return RedirectToAction("index");
            }
        }

        // POST: Section/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create([Bind("ID,Name,DepartmentComments,Notes,RequiresPermission,RequiresMoodle,CRN,DateArchived,DateCreated,StudentLimit," +
            "StartTime,EndTime,PartOfTermID,CourseID,PrimaryInstructorPercent,SecondaryInstructorPercent,ScheduleTypeID,Number" +
            "PrimaryInstructorID,SecondaryInstructorID,RoomID")] Section section) {
            if (ModelState.IsValid) {
                //section number isn't being passed from the form for some reason so it's being grabbed directly from the form
                section.Number = Request.Form["Number"];
                section.AcademicSemesterID = SessionVariables.GetSessionAcademicSemester(HttpContext).ID;
                if (section.PrimaryInstructorID > 0 && section.SecondaryInstructorID > 0) {
                    if (section.PrimaryInstructorPercent + section.SecondaryInstructorPercent != 100) {
                        ModelState.AddModelError("PrimaryInstructorPercent", "Percentages don't equal 100%");
                        ModelState.AddModelError("SecondaryInstructorPercent", "Percentages don't equal 100%");
                        SetUpSectionViewBags(section, true);
                        return View(section);
                    }
                }
                else {
                    section.PrimaryInstructorPercent = 100;
                }
                section.ID = DAL.AddSection(section);
                if (section.ID > 0) {
                    SessionVariables.SetSuccessMessage("Section created");
                    if (section.Course.CrossListedCourseID > 0) {
                        CreateCrossListedSection(ref section);
                    }
                    SetUpSectionDays(section);
                    SetUpSectionInstructors(section);
                    ChangeLog changeLog = new ChangeLog();
                    changeLog.SectionID = section.ID;
                    changeLog.DateCreated = DateTime.Now;
                    changeLog.DateDeleted = DAL.MaximumDateTime;
                    changeLog.DateImported = DAL.MinimumDateTime;
                    DAL.AddChangeLog(changeLog);
                }
                else {
                    SessionVariables.SetErrorMessage("Section create failed");
                }
                return RedirectToAction(nameof(Index));
            }
            SetUpSectionViewBags(section);
            return View(section);
        }

        /// <summary>
        /// creates a duplicate section with everything the same except the course number being the cross listed course
        /// </summary>
        private void CreateCrossListedSection(ref Section originalSection) {
            Section newCrossListSection = new Section();
            newCrossListSection.CourseID = originalSection.Course.CrossListedCourseID;
            newCrossListSection.Course = DAL.GetCourse(originalSection.Course.CrossListedCourseID);
            newCrossListSection.AcademicSemesterID = originalSection.AcademicSemesterID;
            newCrossListSection.AcademicSemester = originalSection.AcademicSemester;
            newCrossListSection.CrossListedSectionID = originalSection.ID;
            List<Section> sectionsByCourse = DAL.GetSectionsByCourse(originalSection.Course.CrossListedCourseID);
            if (sectionsByCourse.Count > 0) {
                int sectionNumber = int.Parse(sectionsByCourse[sectionsByCourse.Count - 1].Number) + 1;
                newCrossListSection.Number = sectionNumber.ToString();
            }
            else {
                newCrossListSection.Number = "1";
            }
            newCrossListSection.PartOfTermID = originalSection.PartOfTermID;
            newCrossListSection.PartOfTerm = originalSection.PartOfTerm;
            newCrossListSection.RequiresMoodle = originalSection.RequiresMoodle;
            newCrossListSection.RequiresPermission = originalSection.RequiresPermission;
            newCrossListSection.RoomID = originalSection.RoomID;
            newCrossListSection.Room = originalSection.Room;
            newCrossListSection.ScheduleTypeID = originalSection.ScheduleTypeID;
            newCrossListSection.ScheduleType = originalSection.ScheduleType;
            newCrossListSection.StartTime = originalSection.StartTime;
            newCrossListSection.EndTime = originalSection.EndTime;
            newCrossListSection.DateArchived = originalSection.DateArchived;
            newCrossListSection.DateCreated = originalSection.DateCreated;
            newCrossListSection.DateDeleted = originalSection.DateDeleted;
            newCrossListSection.FeeID = originalSection.FeeID;
            newCrossListSection.PrimaryInstructorID = originalSection.PrimaryInstructorID;
            newCrossListSection.SecondaryInstructorID = originalSection.SecondaryInstructorID;
            newCrossListSection.Fee = originalSection.Fee;
            newCrossListSection.StudentLimit = originalSection.StudentLimit;
            newCrossListSection.ID = DAL.AddSection(newCrossListSection);
            if (newCrossListSection.ID > 0) {
                SetUpSectionDays(newCrossListSection);
                SetUpSectionInstructors(newCrossListSection);
                ChangeLog changeLog = new ChangeLog();
                changeLog.SectionID = newCrossListSection.ID;
                changeLog.DateCreated = DateTime.Now;
                changeLog.DateDeleted = DAL.MaximumDateTime;
                changeLog.DateImported = DAL.MinimumDateTime;
                DAL.AddChangeLog(changeLog);
                originalSection.CrossListedSectionID = newCrossListSection.ID;
                DAL.UpdateSection(originalSection);
            }
        }

        private void SetUpSectionViewBags(Section section, bool withValues = false) {
            List<Room> rooms = DAL.GetRooms();
            rooms.Add(new Room { ID = -1, Number = 0, Building = new Building { ID = -1, Name = "None", Campus = new Campus { ID = -1, Name = "" } } });
            List<Instructor> instructors = DAL.GetInstructors();
            section.GetInstructorDetails();
            List<Course> courses = DAL.GetCourses();
            List<Department> departments = DAL.GetDepartments();
            instructors.Add(new Instructor { ID = -1, FirstName = "None", MiddleName = "", LastName = "" });
            List<Day> days = DAL.GetDays();
            Dictionary<int, bool> dictDays = new Dictionary<int, bool>();
            foreach (Day day in days) {
                if (!dictDays.ContainsKey(day.ID)) {
                    dictDays.Add(day.ID, false);
                }
            }
            if (withValues) {
                ViewData["DepartmentID"] = new SelectList(departments, "ID", "Abbreviation", section.Course.DepartmentID);
                ViewData["PartOfTermID"] = new SelectList(DAL.GetPartOfTerms(), "ID", "Name", section.PartOfTermID);
                ViewData["RoomID"] = new SelectList(rooms, "ID", "NameAndCampus", section.RoomID);
                ViewData["ScheduleTypeID"] = new SelectList(DAL.GetScheduleTypes(), "ID", "Name", section.ScheduleTypeID);
                ViewData["PrimaryInstructorID"] = new SelectList(instructors, "ID", "FullName", section.PrimaryInstructorID);
                ViewData["SecondaryInstructorID"] = new SelectList(instructors, "ID", "FullName", section.SecondaryInstructorID);
                ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", section.AcademicSemester.SemesterID);
                ViewData["CourseNumbers"] = new SelectList(courses, "ID", "NumberAndTitle", section.CourseID);
                foreach (Day day in section.Days) {
                    if (dictDays.ContainsKey(day.ID)) {
                        dictDays[day.ID] = true;
                    }
                }
            }
            else {
                ViewData["DepartmentID"] = new SelectList(departments, "ID", "Abbreviation");
                ViewData["PartOfTermID"] = new SelectList(DAL.GetPartOfTerms(), "ID", "Name");
                ViewData["RoomID"] = new SelectList(DAL.GetRooms(), "ID", "NameAndCampus");
                ViewData["ScheduleTypeID"] = new SelectList(DAL.GetScheduleTypes(), "ID", "Name");
                ViewData["PrimaryInstructorID"] = new SelectList(instructors, "ID", "FullName", -1);
                ViewData["SecondaryInstructorID"] = new SelectList(instructors, "ID", "FullName", -1);
                ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name");
                ViewData["CourseNumbers"] = new SelectList(courses, "ID", "NumberAndTitle");
            }
            ViewData["AcademicSemester"] = SessionVariables.GetSessionAcademicSemester(HttpContext).Display;
            ViewData["AllDays"] = days;
            ViewData["Days"] = dictDays;
        }

        // GET: Section/Edit/5
        public IActionResult Edit(int? id) {
            Section section = null;
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Sections.CanEdit) {
                if (id == null) {
                    return NotFound();
                }
                section = DAL.GetSection((int)id);
                if (section == null) {
                    return NotFound();
                }
                SetUpSectionViewBags(section, true);
                if (currentUser != null && currentUser.Role != null) {
                    ViewData["CanDelete"] = currentUser.Role.Sections.CanDelete;
                }
                else {
                    ViewData["CanDelete"] = false;
                }
                return View(section);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission edit sections");
                return RedirectToAction("Index");
            }
        }

        // POST: Section/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, [Bind("ID,Number,DepartmentComments,Notes,RequiresPermission,RequiresMoodle,CRN,DateArchived,DateCreated,StudentLimit," +
            "StartTime,EndTime,PartOfTermID,CourseID,CRN,PrimaryInstructorPercent,SecondaryInstructorPercent,CrossScheduledSectionID," +
            "ScheduleTypeID,PrimaryInstructorID,FeeID,AcademicSemesterID,SecondaryInstructorID,RoomID")] Section section) {
            if (id != section.ID) {
                return NotFound();
            }
            if (section.XListID == null) {
                section.XListID = "";
            }
            Section oldSection = DAL.GetSection((int)id);
            List<Day> days = oldSection.Days;
            if (ModelState.IsValid) {
                section.AcademicSemesterID = SessionVariables.GetSessionAcademicSemester(HttpContext).ID;
                if (section.PrimaryInstructorID > 0 && section.SecondaryInstructorID > 0) {
                    if (section.PrimaryInstructorPercent + section.SecondaryInstructorPercent != 100) {
                        ModelState.AddModelError("PrimaryInstructorPercent", "Percentages don't equal 100%");
                        ModelState.AddModelError("SecondaryInstructorPercent", "Percentages don't equal 100%");
                        SetUpSectionViewBags(section, true);
                        User currentUser = SessionVariables.GetCurrentUser(HttpContext);
                        if (currentUser != null && currentUser.Role != null) {
                            ViewData["CanDelete"] = currentUser.Role.Sections.CanDelete;
                        }
                        else {
                            ViewData["CanDelete"] = false;
                        }
                        return View(section);
                    }
                }
                else {
                    section.PrimaryInstructorPercent = 100;
                }
                SetUpSectionDays(section);
                SetUpSectionInstructors(section);
                UpdateChangeLog(oldSection, section);
                if (section.CrossListedSectionID > 0) {
                    UpdateCrossListedSection(ref section);
                }
                int updatedSuccessfully = DAL.UpdateSection(section);
                if (updatedSuccessfully > 0) {
                    SessionVariables.SetSuccessMessage("Section edited");
                }
                else {
                    SessionVariables.SetErrorMessage("Section edit failed");
                }
                return RedirectToAction(nameof(Index));
            }
            SetUpSectionViewBags(section, true);
            return View(section);
        }

        /// <summary>
        /// updates the cross listed section to match the original section changes
        /// </summary>
        /// <param name="section"></param>
        private void UpdateCrossListedSection(ref Section originalSection) {
            Section oldSection = DAL.GetSection(originalSection.CrossListedSectionID);
            List<Day> days = oldSection.Days;
            Section crossListedSection = DAL.GetSection(originalSection.CrossListedSectionID);
            crossListedSection.PartOfTermID = originalSection.PartOfTermID;
            crossListedSection.PartOfTerm = originalSection.PartOfTerm;
            crossListedSection.RequiresMoodle = originalSection.RequiresMoodle;
            crossListedSection.RequiresPermission = originalSection.RequiresPermission;
            crossListedSection.RoomID = originalSection.RoomID;
            crossListedSection.Room = originalSection.Room;
            crossListedSection.ScheduleTypeID = originalSection.ScheduleTypeID;
            crossListedSection.ScheduleType = originalSection.ScheduleType;
            crossListedSection.StartTime = originalSection.StartTime;
            crossListedSection.EndTime = originalSection.EndTime;
            crossListedSection.FeeID = originalSection.FeeID;
            crossListedSection.PrimaryInstructorID = originalSection.PrimaryInstructorID;
            crossListedSection.SecondaryInstructorID = originalSection.SecondaryInstructorID;
            crossListedSection.Fee = originalSection.Fee;
            int updatedSection = DAL.UpdateSection(crossListedSection);
            if (updatedSection > 0) {
                SetUpSectionDays(crossListedSection);
                SetUpSectionInstructors(crossListedSection);
                UpdateChangeLog(oldSection, crossListedSection);
            }
        }


        /// <summary>
        /// scans through sectionDays and archives those that aren't used and creates those that don't exist yet
        /// </summary>
        /// <param name="sectionID"></param>
        /// <param name="section"></param>
        private void SetUpSectionDays(Section section) {
            List<string> dayStrings = new List<string>();
            List<Day> days = DAL.GetDays();
            foreach (Day day in days) {
                if (Request.Form[day.Name].ToString() != "") {
                    dayStrings.Add(day.Name);
                }
            }
            section.SetUpDays(dayStrings, days);
        }

        /// <summary>
        /// gets the next sequential number for a section
        /// </summary>
        /// <param name="courseID"></param>
        /// <returns></returns>
        public string GetNextSectionNumber(int courseID) {
            string retVal = "1";
            List<Section> sectionsByCourse = DAL.GetSectionsByCourse(courseID);
            if (sectionsByCourse.Count > 0) {
                if (int.TryParse(sectionsByCourse[sectionsByCourse.Count - 1].Number, out int newNumber)) {
                    retVal = (newNumber + 1).ToString();
                }
                else {
                    char[] letters = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
                    string trimmedNumber = sectionsByCourse[sectionsByCourse.Count - 1].Number.Trim(letters);
                    if (int.TryParse(trimmedNumber, out int secondNewNumber)) {
                        retVal = (secondNewNumber + 1).ToString();
                    }
                }
            }
            return retVal;
        }


        /// <summary>
        /// scans through InstructorToSections and archives those that aren't used and creates those that don't exist yet
        /// </summary>
        /// <param name="sectionID"></param>
        /// <param name="section"></param>
        private void SetUpSectionInstructors(Section section) {
            HandleInstructorToSectionArchiving(section);
            CreateNewInstructorToSections(section);
        }

        /// <summary>
        /// checks if an InstructorToSection should be archived or not and adjusts if needed
        /// </summary>
        /// <param name="section"></param>
        private static void HandleInstructorToSectionArchiving(Section section) {
            section.Instructors.Clear();
            List<InstructorToSection> sectionInstructors = DAL.GetInstructorsBySectionID(section.ID, true).OrderBy(instructor => instructor.IsPrimary).ToList();
            foreach (InstructorToSection instructorToSection in sectionInstructors) {
                //detects if the Sections PrimaryInstructor matches the InstructorToSections Instructor
                if (instructorToSection.InstructorID == section.PrimaryInstructorID) {
                    //detects if the InstructorToSection was changed to determine if a database call is needed
                    if (!instructorToSection.IsPrimary || instructorToSection.DateArchived < DateTime.Now) {
                        instructorToSection.IsPrimary = true;
                        instructorToSection.DateArchived = DAL.MaximumDateTime;
                    }
                    instructorToSection.TeachingPercentage = section.PrimaryInstructorPercent;
                    DAL.UpdateInstructorToSection(instructorToSection);
                    section.Instructors.Add(instructorToSection);
                }
                //detects if the Sections SecondaryInstructor matches the InstructorToSections Instructor
                if (instructorToSection.InstructorID == section.SecondaryInstructorID) {
                    //detects if the InstructorToSection was changed to determine if a database call is needed
                    if (instructorToSection.IsPrimary || instructorToSection.DateArchived < DateTime.Now) {
                        instructorToSection.IsPrimary = false;
                        instructorToSection.DateArchived = DAL.MaximumDateTime;
                    }
                    instructorToSection.TeachingPercentage = section.SecondaryInstructorPercent;
                    DAL.UpdateInstructorToSection(instructorToSection);
                    section.Instructors.Add(instructorToSection);
                }
                //archives an InstructorToSection if it is not currently in use
                if (instructorToSection.InstructorID != section.PrimaryInstructorID && instructorToSection.InstructorID != section.SecondaryInstructorID) {
                    instructorToSection.DateArchived = DateTime.Now;
                    DAL.UpdateInstructorToSection(instructorToSection);
                }
            }
        }


        /// <summary>
        /// creates new InstructorToSections if they don't exist for a given Section
        /// </summary>
        /// <param name="section"></param>
        private static void CreateNewInstructorToSections(Section section) {
            if (section.PrimaryInstructorID != -1) {
                InstructorToSection primaryInstructor = DAL.GetInstructorToSectionByInstructorIDAndSectionID(section.ID, section.PrimaryInstructorID);
                if (primaryInstructor == null) {
                    InstructorToSection newInstructorToSection = new InstructorToSection();
                    newInstructorToSection.SectionID = section.ID;
                    newInstructorToSection.InstructorID = section.PrimaryInstructorID;
                    newInstructorToSection.TeachingPercentage = section.PrimaryInstructorPercent;
                    newInstructorToSection.IsPrimary = true;
                    DAL.AddInstructorToSection(newInstructorToSection);
                    section.Instructors.Add(newInstructorToSection);
                }
            }
            if (section.SecondaryInstructorID != -1) {
                InstructorToSection secondaryInstructor = DAL.GetInstructorToSectionByInstructorIDAndSectionID(section.ID, section.SecondaryInstructorID);
                if (secondaryInstructor == null) {
                    InstructorToSection newInstructorToSection = new InstructorToSection();
                    newInstructorToSection.SectionID = section.ID;
                    newInstructorToSection.InstructorID = section.SecondaryInstructorID;
                    newInstructorToSection.TeachingPercentage = section.SecondaryInstructorPercent;
                    newInstructorToSection.IsPrimary = false;
                    DAL.AddInstructorToSection(newInstructorToSection);
                    section.Instructors.Add(newInstructorToSection);
                }
            }
        }

        /// <summary>
        /// scans through sectionDays and archives those that aren't used and creates those that don't exist yet
        /// </summary>
        /// <param name="sectionID"></param>
        /// <param name="section"></param>
        private void SetUpSectionDaysTemp(Section section) {
            section.Days.Clear();
            List<Day> days = DAL.GetDays();
            List<SectionDay> sectionDays = DAL.GetSectionDaysBySectionID(section.ID);
            foreach (Day day in days) {
                var test = Request.Form[day.Name].ToString();
                if (Request.Form[day.Name].ToString() != "") {
                    section.Days.Add(day);
                }
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


        /// <summary>
        /// updates the changelog for a section
        /// </summary>
        /// <param name="oldSection"></param>
        /// <param name="newSection"></param>
        private void UpdateChangeLog(Section oldSection, Section newSection) {
            ChangeLog changeLogToUpdate = DAL.GetChangeLogBySection(newSection);
            if (changeLogToUpdate != null) {
                if (oldSection.Course.DepartmentID != newSection.Course.DepartmentID) { changeLogToUpdate.ChangedDepartment = true; }
                if (oldSection.Course.Number != newSection.Course.Number) { changeLogToUpdate.ChangedCourseNumber = true; }
                if (oldSection.Number != newSection.Number) { changeLogToUpdate.ChangedSectionNumber = true; }
                if (oldSection.Course.Title != newSection.Course.Title) { changeLogToUpdate.ChangedTitle = true; }
                if (oldSection.Room != null && oldSection.Room.Building.CampusID != newSection.Room.Building.CampusID) { changeLogToUpdate.ChangedCampus = true; }
                if (oldSection.ScheduleTypeID != newSection.ScheduleTypeID) { changeLogToUpdate.ChangedScheduleType = true; }
                if (oldSection.RequiresMoodle != newSection.RequiresMoodle) { changeLogToUpdate.ChangedMoodleRequired = true; }
                if (oldSection.RequiresPermission != newSection.RequiresPermission) { changeLogToUpdate.ChangedInstructorApproval = true; }
                if (oldSection.PartOfTermID != newSection.PartOfTermID) { changeLogToUpdate.ChangedPartOfTerm = true; }
                if (oldSection.Course.FixedCredits != newSection.Course.FixedCredits) { changeLogToUpdate.ChangedFixedCredit = true; }
                if (oldSection.Course.MinimumCredits != newSection.Course.MinimumCredits) { changeLogToUpdate.ChangedMinCredits = true; }
                if (oldSection.Course.MaximumCredits != newSection.Course.MaximumCredits) { changeLogToUpdate.ChangedMaxCredits = true; }
                if (oldSection.StudentLimit != newSection.StudentLimit) { changeLogToUpdate.ChangedStudentLimit = true; }
                if (oldSection.StartTime.TimeOfDay != newSection.StartTime.TimeOfDay) { changeLogToUpdate.ChangedStartTime = true; }
                if (oldSection.EndTime.TimeOfDay != newSection.EndTime.TimeOfDay) { changeLogToUpdate.ChangedEndTime = true; }
                if (oldSection.Room != null && oldSection.Room.BuildingID != newSection.Room.BuildingID) { changeLogToUpdate.ChangedBuilding = true; }
                if (oldSection.RoomID != newSection.RoomID) { changeLogToUpdate.ChangedRoom = true; }
                CheckForDayChanges(oldSection, newSection, ref changeLogToUpdate);
                CheckForInstructorChanges(oldSection, newSection, ref changeLogToUpdate);
                if (newSection.Notes != null && oldSection.Notes != newSection.Notes) { changeLogToUpdate.ChangedSectionNotes = true; }
                if (newSection.DepartmentComments != null && oldSection.DepartmentComments != newSection.DepartmentComments) { changeLogToUpdate.ChangedDepartmentComments = true; }
                DAL.UpdateChangeLog(changeLogToUpdate);
            }
        }


        /// <summary>
        /// checks for changes in a sections days and updates the changelog if so
        /// </summary>
        /// <param name="oldSection"></param>
        /// <param name="newSection"></param>
        /// <param name="changeLog"></param>
        private void CheckForDayChanges(Section oldSection, Section newSection, ref ChangeLog changeLog) {
            foreach (Day oldDay in oldSection.Days) {
                bool foundInNewSection = false;
                foreach (Day newDay in newSection.Days) {
                    if (oldDay.ID == newDay.ID) {
                        foundInNewSection = true;
                    }
                }
                if (!foundInNewSection) {
                    UpdateChangeLogDay(changeLog, oldDay);
                }
            }
            foreach (Day newDay in newSection.Days) {
                bool foundInNewSection = false;
                foreach (Day oldDay in oldSection.Days) {
                    if (oldDay.ID == newDay.ID) {
                        foundInNewSection = true;
                    }
                }
                if (!foundInNewSection) {
                    UpdateChangeLogDay(changeLog, newDay);
                }
            }
        }

        /// <summary>
        /// 
        /// updates a changelogs date changed for a given day
        /// </summary>
        /// <param name="changeLog"></param>
        /// <param name="day"></param>
        private void UpdateChangeLogDay(ChangeLog changeLog, Day day) {
            if (day.Name == "Monday") {
                changeLog.ChangedMonday = true;
            }
            if (day.Name == "Tuesday") {
                changeLog.ChangedTuesday = true;
            }
            if (day.Name == "Wednesday") {
                changeLog.ChangedWednesday = true;
            }
            if (day.Name == "Thursday") {
                changeLog.ChangedThursday = true;
            }
            if (day.Name == "Friday") {
                changeLog.ChangedFriday = true;
            }
            if (day.Name == "Saturday") {
                changeLog.ChangedSaturday = true;
            }
            if (day.Name == "Sunday") {
                changeLog.ChangedSunday = true;
            }
        }

        /// <summary>
        /// checks for changes in a sections instructors and updates the changelog if so
        /// </summary>
        /// <param name="oldSection"></param>
        /// <param name="newSection"></param>
        /// <param name="changeLog"></param>
        private static void CheckForInstructorChanges(Section oldSection, Section newSection, ref ChangeLog changeLog) {
            foreach (InstructorToSection oldITS in oldSection.Instructors) {
                bool foundInNewSection = false;
                bool teachingPercentChanged = false;
                foreach (InstructorToSection newITS in newSection.Instructors) {
                    if (oldITS.ID == newITS.ID) {
                        foundInNewSection = true;
                        if (oldITS.TeachingPercentage != newITS.TeachingPercentage) {
                            teachingPercentChanged = true;
                        }
                    }
                }
                if (!foundInNewSection && oldITS.IsPrimary) {
                    changeLog.ChangedPrimeInstructor = true;
                    changeLog.ChangedPrimeInstructorPercent = true;
                }
                if (teachingPercentChanged && oldITS.IsPrimary) {
                    changeLog.ChangedPrimeInstructorPercent = true;
                }
            }
            foreach (InstructorToSection newITS in newSection.Instructors) {
                bool foundInNewSection = false;
                bool teachingPercentChanged = false;
                foreach (InstructorToSection oldITS in oldSection.Instructors) {
                    if (oldITS.ID == newITS.ID) {
                        foundInNewSection = true;
                        if (oldITS.TeachingPercentage != newITS.TeachingPercentage) {
                            teachingPercentChanged = true;
                        }
                    }
                }
                if (!foundInNewSection && !newITS.IsPrimary) {
                    changeLog.ChangedSecondInstructor = true;
                    changeLog.ChangedSecondInstructorPercent = true;
                }
                if (teachingPercentChanged && !newITS.IsPrimary) {
                    changeLog.ChangedSecondInstructorPercent = true;
                }
            }
        }


        // GET: Section/Delete/5
        public IActionResult Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role.Sections.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                Section section = DAL.GetSection((int)id);
                if (section == null) {
                    return NotFound();
                }
                return View(section);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete sections");
                return RedirectToAction("index");
            }
        }


        // POST: Section/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id, [Bind("ID,Number,DepartmentComments,Notes,RequiresPermission,RequiresMoodle,CRN,DateArchived,DateCreated,StudentLimit," +
            "StartTime,EndTime,PartOfTermID,CourseID,ScheduleTypeID,PrimaryInstructorID,SectionFeeID,SecondaryInstructorID,RoomID,")] Section section) {
            Section sectionToDelete = DAL.GetSection(id);
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Sections.CanDelete) {
                ChangeLog changeLog = DAL.GetChangeLogBySection(sectionToDelete);
                //checks if the section was created after the spreadsheet import
                changeLog.DateDeleted = DateTime.Now;
                sectionToDelete.DateDeleted = DateTime.Now;
                if (changeLog.DateCreated >= changeLog.DateImported) {
                    //completely delete the section so it isn't put on the spreadsheet as it was created after the import
                    List<InstructorToSection> instructorToSections = DAL.GetInstructorsBySectionID(id);
                    foreach (InstructorToSection its in instructorToSections) {
                        DAL.RemoveInstructorToSection(its.ID);
                    }
                    List<SectionDay> sectionDays = DAL.GetSectionDaysBySectionID(id);
                    foreach (SectionDay sd in sectionDays) {
                        DAL.RemoveSectionDay(sd.ID);
                    }
                    ChangeLog changeLogToDelete = DAL.GetChangeLogBySection(section);
                    DAL.RemoveChangeLog(changeLogToDelete);
                    DAL.RemoveSection(section);
                }
                int updatedChangelog = DAL.UpdateChangeLog(changeLog);
                int updatedSection = DAL.UpdateSection(sectionToDelete);
                if (updatedChangelog >= 0 && updatedSection >= 0) {
                    SessionVariables.SetSuccessMessage("Section deleted");
                }
                else {
                    SessionVariables.SetErrorMessage("Section delete failed");
                }
                return RedirectToAction(nameof(Index));
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete sections");
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
            //List<Section> retList = new List<Section>();
            SessionVariables.SetSessionAcademicSemesterID(HttpContext, DAL.GetAcademicSemesterByYearAndSemester(currentSemesterID, currentYear).ID);
            //retList = DAL.GetSections().Where(s => s.AcademicSemesterID == SessionVariables.GetSessionAcademicSemesterID(HttpContext)).ToList();
            //return PartialView("Parts/_IndexList", retList);
        }
    }
}
