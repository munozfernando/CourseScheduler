using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ClassScheduler.Models;

namespace ClassScheduler.Controllers {
    public class InstructorToSectionController : Controller {


        // GET: InstructorToSection
        public async Task<IActionResult> Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Instructors.CanView && currentUser.Role.Sections.CanView) {
                Dictionary<int, Section> sections = DAL.GetSectionsByAcademicSemesterID(SessionVariables.GetSessionAcademicSemesterID(HttpContext)).ToDictionary(x => x.ID, x => x);
                List<InstructorToSection> instructorToSections = DAL.GetInstructorToSectionsByAcademicSemesterID(SessionVariables.GetSessionAcademicSemesterID(HttpContext));

                foreach (InstructorToSection iToS in instructorToSections) {
                    iToS.Section = sections[iToS.SectionID];
                }
                return View(instructorToSections);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view that");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: InstructorToSection/Details/5
        public async Task<IActionResult> Details(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Instructors.CanView && currentUser.Role.Sections.CanView) {
                if (id == null) {
                    return NotFound();
                }
                InstructorToSection instructorToSection = DAL.GetInstructorToSection((int)id);
                if (instructorToSection == null) {
                    return NotFound();
                }
                return View(instructorToSection);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view that");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: InstructorToSection/Create
        public IActionResult Create() {
            ViewData["InstructorID"] = new SelectList(DAL.GetInstructors(), "ID", "FullName");
            ViewData["SectionID"] = new SelectList(DAL.GetSections(), "ID", "SectionNumberAndCourseName");
            return View();
        }

        // POST: InstructorToSection/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("InstructorID,SectionID,IsPrimary,TeachingPercentage,ID")] InstructorToSection instructorToSection) {
            if (ModelState.IsValid) {
                DAL.AddInstructorToSection(instructorToSection);
                return RedirectToAction(nameof(Index));
            }
            ViewData["InstructorID"] = new SelectList(DAL.GetInstructors(), "ID", "FullName", instructorToSection.InstructorID);
            ViewData["SectionID"] = new SelectList(DAL.GetSections(), "ID", "SectionNumberAndCourseName", instructorToSection.SectionID);
            return View(instructorToSection);
        }

        // GET: InstructorToSection/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            if (id == null) {
                return NotFound();
            }
            InstructorToSection instructorToSection = DAL.GetInstructorToSection((int)id);
            if (instructorToSection == null) {
                return NotFound();
            }
            ViewData["InstructorID"] = new SelectList(DAL.GetInstructors(), "ID", "FullName", instructorToSection.InstructorID);
            ViewData["SectionID"] = new SelectList(DAL.GetSections(), "ID", "SectionNumberAndCourseName", instructorToSection.SectionID);

            return View(instructorToSection);
        }

        // POST: InstructorToSection/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("InstructorID,SectionID,IsPrimary,TeachingPercentage,ID")] InstructorToSection instructorToSection) {
            if (id != instructorToSection.ID) {
                return NotFound();
            }

            if (ModelState.IsValid) {
                DAL.UpdateInstructorToSection(instructorToSection);
                return RedirectToAction(nameof(Index));
            }
            ViewData["InstructorID"] = new SelectList(DAL.GetInstructors(), "ID", "FullName", instructorToSection.InstructorID);
            ViewData["SectionID"] = new SelectList(DAL.GetSections(), "ID", "SectionNumberAndCourseName", instructorToSection.SectionID);
            return View(instructorToSection);
        }

        // GET: InstructorToSection/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            if (id == null) {
                return NotFound();
            }

            InstructorToSection instructorToSection = DAL.GetInstructorToSection((int)id);
            if (instructorToSection == null) {
                return NotFound();
            }

            return View(instructorToSection);
        }

        // POST: InstructorToSection/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            DAL.RemoveInstructorToSection(id);
            return RedirectToAction(nameof(Index));
        }
    }
}
