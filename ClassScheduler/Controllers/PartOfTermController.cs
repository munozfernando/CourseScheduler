using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ClassScheduler.Models;

namespace ClassScheduler.Controllers {
    public class PartOfTermController : Controller {
        // GET: PartOfTerm
        public async Task<IActionResult> Index() {
            List<PartOfTerm> partOfTerms = DAL.GetPartOfTerms();
            return View(partOfTerms);
        }

        // GET: PartOfTerm/Details/5
        public async Task<IActionResult> Details(int? id) {
            if (id == null) {
                return NotFound();
            }
            PartOfTerm partOfTerm = DAL.GetPartOfTerm((int)id);
            if (partOfTerm == null) {
                return NotFound();
            }
            return View(partOfTerm);
        }

        // GET: PartOfTerm/Create
        public IActionResult Create() {
            ViewData["PartOfTermID"] = new SelectList(DAL.GetPartOfTerms(), "ID", "Name");
            return View();
        }

        // POST: PartOfTerm/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Name,Abbreviation,ID,StartWeek,EndWeek")] PartOfTerm partOfTerm) {
            if (ModelState.IsValid) {
                DAL.AddPartOfTerm(partOfTerm);
                return RedirectToAction(nameof(Index));
            }
            return View(partOfTerm);
        }

        // GET: PartOfTerm/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            if (id == null) {
                return NotFound();
            }
            PartOfTerm partOfTerm = DAL.GetPartOfTerm((int)id);
            if (partOfTerm == null) {
                return NotFound();
            }
            return View(partOfTerm);
        }

        // POST: PartOfTerm/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Name,Abbreviation,ID,StartWeek,EndWeek")] PartOfTerm partOfTerm) {
            if (id != partOfTerm.ID) {
                return NotFound();
            }

            if (ModelState.IsValid) {
                DAL.UpdatePartOfTerm(partOfTerm);
                return RedirectToAction(nameof(Index));
            }
            return View(partOfTerm);
        }

        // GET: PartOfTerm/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            if (id == null) {
                return NotFound();
            }

            PartOfTerm partOfTerm = DAL.GetPartOfTerm((int)id);
            if (partOfTerm == null) {
                return NotFound();
            }

            return View(partOfTerm);
        }

        // POST: PartOfTerm/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            DAL.RemovePartOfTerm(id);
            return RedirectToAction(nameof(Index));
        }
    }
}
