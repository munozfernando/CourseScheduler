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
     * February 23rd, 2019
     */

    public class SemesterController : Controller {

        // GET: Semester
        public async Task<IActionResult> Index() {
            List<Semester> semesters = DAL.GetSemesters();
            return View(semesters);
        }

        // GET: Semester/Details/5
        public async Task<IActionResult> Details(int? id) {
            if (id == null) {
                return NotFound();
            }

            Semester semester = DAL.GetSemester((int)id);
            if (semester == null) {
                return NotFound();
            }
            return View(semester);
        }

        // GET: Semester/Create
        public IActionResult Create() {
            ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", "Abbreviation");
            return View();
        }

        // POST: Semester/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID, Name, Abbreviation")] Semester semester) {
            if (ModelState.IsValid) {
                DAL.AddSemester(semester);
                return RedirectToAction(nameof(Index));
            }
            ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", "Abbreviation");

            return View(semester);
        }


        // GET: Semester/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            if (id == null) {
                return NotFound();
            }

            Semester semester = DAL.GetSemester((int)id);
            if (semester == null) {
                return NotFound();
            }
            ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", "Abbreviation");
            return View(semester);
        }

        // POST: Semester/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID, Name, Abbreviation")] Semester semester) {
            if (id != semester.ID) {
                return NotFound();
            }

            if (ModelState.IsValid) {
                DAL.UpdateSemester(semester);
                return RedirectToAction(nameof(Index));
            }
            ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", "Abbreviation");
            return View(semester);
        }

        // GET: Semester/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            if (id == null) {
                return NotFound();
            }

            Semester semester = DAL.GetSemester((int)id);
            if (semester == null) {
                return NotFound();
            }

            return View(semester);
        }

        // POST: Semester/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            DAL.RemoveSemester(id);
            return RedirectToAction(nameof(Index));
        }
    }
}

