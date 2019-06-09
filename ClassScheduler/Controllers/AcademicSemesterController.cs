using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace ClassScheduler.Models
{
    /*
     * Cleaned up by Fernando Munoz
     * February 21st, 2019
     */

    public class AcademicSemesterController : Controller
    {

        // GET: AcademicSemester
        public async Task<IActionResult> Index()
        {
            List<AcademicSemester> academicSemesters = DAL.GetAcademicSemesters();
            return View(academicSemesters);
        }

        // GET: AcademicSemester/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            AcademicSemester academicSemester = DAL.GetAcademicSemester((int)id);
            if (academicSemester == null)
            {
                return NotFound();
            }
            return View(academicSemester);
        }

        // GET: AcademicSemester/Create
        public IActionResult Create()
        {
            ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name");
            return View();
        }

        // POST: AcademicSemester/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID, SemesterID, AcademicYear")] AcademicSemester academicSemester)
        {
            if (ModelState.IsValid)
            {
                DAL.AddAcademicSemester(academicSemester);
                return RedirectToAction(nameof(Index));
            }
            ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", academicSemester.SemesterID);
            return View(academicSemester);
        }


        // GET: AcademicSemester/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            AcademicSemester academicSemester = DAL.GetAcademicSemester((int)id);
            if (academicSemester == null)
            {
                return NotFound();
            }
            ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", academicSemester.SemesterID.ToString());
            return View(academicSemester);
        }

        // POST: AcademicSemester/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,SemesterID,AcademicYear")] AcademicSemester academicSemester)
        {
            if (id != academicSemester.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                DAL.UpdateAcademicSemester(academicSemester);
                return RedirectToAction(nameof(Index));
            }
            ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", academicSemester.SemesterID);
            return View(academicSemester);
        }

        // GET: AcademicSemester/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            AcademicSemester academicSemester = DAL.GetAcademicSemester((int)id);
            if (academicSemester == null)
            {
                return NotFound();
            }

            return View(academicSemester);
        }

        // POST: AcademicSemester/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            DAL.RemoveAcademicSemester(id);
            return RedirectToAction(nameof(Index));
        }
    }
}

