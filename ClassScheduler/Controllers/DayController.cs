using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ClassScheduler.Models;

namespace ClassScheduler.Controllers
{
    public class DayController : Controller
    {

        // GET: Day
        public async Task<IActionResult> Index()
        {
            List<Day> days = DAL.GetDays();
            return View(days);
        }

        // GET: Day/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Day day = DAL.GetDay((int)id);
            if (day == null)
            {
                return NotFound();
            }

            return View(day);
        }

        // GET: Day/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Day/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Name,Abbreviation,ID")] Day day)
        {
            if (ModelState.IsValid)
            {
                DAL.AddDay(day);
                return RedirectToAction(nameof(Index));
            }
            return View(day);
        }

        // GET: Day/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Day day = DAL.GetDay((int)id);
            if (day == null)
            {
                return NotFound();
            }
            return View(day);
        }

        // POST: Day/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Name,Abbreviation,ID")] Day day)
        {
            if (id != day.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                DAL.UpdateDay(day);
                return RedirectToAction(nameof(Index));
            }
            return View(day);
        }

        // GET: Day/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Day day = DAL.GetDay((int)id);
            if (day == null)
            {
                return NotFound();
            }

            return View(day);
        }

        // POST: Day/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            DAL.RemoveDay(id);
            return RedirectToAction(nameof(Index));
        }
    }
}
