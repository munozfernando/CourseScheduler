using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ClassScheduler.Models;

namespace ClassScheduler.Controllers {
    public class ScheduleTypeController : Controller {
        // GET: Schedule Type
        public async Task<IActionResult> Index() {
            List<ScheduleType> scheduleTypes = DAL.GetScheduleTypes();
            return View(scheduleTypes);
        }
        // GET: ScheduleType/Details/5
        public async Task<IActionResult> Details(int? id) {
            if (id == null) {
                return NotFound();
            }
            ScheduleType scheduleType = DAL.GetScheduleType((int)id);
            if (scheduleType == null) {
                return NotFound();
            }
            return View(scheduleType);
        }

        // GET: ScheduleType/Create
        public IActionResult Create() {
            return View();
        }

        // POST: ScheduleType/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID, Name, Abbreviation, RequiresRoom, RequiresTimes, RequiresDays")] ScheduleType scheduleType) {
            if (ModelState.IsValid) {
                DAL.AddScheduleType(scheduleType);
                return RedirectToAction(nameof(Index));
            }
            ViewData["ScheduleTypeID"] = new SelectList(DAL.GetScheduleTypes(), "ID", "Name", "Abbreviation");
            return View(scheduleType);
        }

        // GET: ScheduleType/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            if (id == null) {
                return NotFound();
            }
            ScheduleType scheduleType = DAL.GetScheduleType((int)id);
            if (scheduleType == null) {
                return NotFound();
            }
            ViewData["ScheduleTypeID"] = new SelectList(DAL.GetScheduleTypes(), "ID", "Name", "Abbreviation");
            return View(scheduleType);
        }

        // POST: ScheduleType/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Name,Abbreviation,RequiresRoom,RequiresTimes,RequiresDays")] ScheduleType scheduleType) {
            if (id != scheduleType.ID) {
                return NotFound();
            }

            if (ModelState.IsValid) {
                DAL.UpdateScheduleType(scheduleType);
                return RedirectToAction(nameof(Index));
            }
            ViewData["ScheduleTypeID"] = new SelectList(DAL.GetScheduleTypes(), "ID", "Name", "Abbreviation");
            return View(scheduleType);
        }

        // GET: ScheduleType/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.ScheduleTypes.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                ScheduleType scheduleType = DAL.GetScheduleType((int)id);
                if (scheduleType == null) {
                    return NotFound();
                }
                return View(scheduleType);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete schedule types");
                return RedirectToAction("Index");
            }
        }

        // POST: ScheduleType/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.ScheduleTypes.CanDelete) {
                DAL.RemoveScheduleType(id);
                return RedirectToAction(nameof(Index));
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete schedule types");
                return RedirectToAction("Index");
            }
        }
    }
}
