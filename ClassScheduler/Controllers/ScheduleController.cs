using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ClassScheduler.Models
{

    public class ScheduleController : Controller
    {

        private int _StartTime;
        private int _EndTime;
        private int _DaysSelected;
        private int _College;


        // GET: Schedule
        public async Task<IActionResult> Index()
        {
            List<Schedule> schedules = DAL.GetSchedules();
            return View(schedules);
        }

        // GET: Schedule/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Schedule schedule = DAL.GetSchedule((int)id);
            if (schedule == null)
            {
                return NotFound();
            }
            return View(schedule);
        }

        // GET: Schedule/Create
        public IActionResult Create()
        {
            ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name");
            return View();
        }

        // POST: Schedule/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID, SemesterID, StartTime, EndTime, College")] Schedule schedule)
        {
            if (ModelState.IsValid)
            {
                DAL.AddSchedule(schedule);
                return RedirectToAction(nameof(Index));
            }
            return View(schedule);
        }


        // GET: Schedule/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Schedule schedule = DAL.GetSchedule((int)id);
            return View(schedule);
        }

        // POST: Schedule/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,SemesterID,StartTime,EndTime,College")] Schedule schedule)
        {
            if (id != schedule.ID)
            {
                return NotFound();
            }
            if (ModelState.IsValid)
            {
                DAL.UpdateSchedule(schedule);
                return RedirectToAction(nameof(Index));
            }
            return View(schedule);
        }

        // GET: Schedule/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Schedule schedule = DAL.GetSchedule((int)id);
            return View(schedule);
        }

        // POST: Schedule/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            DAL.RemoveSchedule(id);
            return RedirectToAction(nameof(Index));
        }

        /// <summary>
        /// gets and sets the StartTime attribute for this Schedule
        /// </summary>
        public int StartTime
        {
            get { return _StartTime; }
            set { _StartTime = value; }
        }
        /// <summary>
        /// gets and sets the EndTime attribute for this Schedule
        /// </summary>
        public int EndTime
        {
            get { return _EndTime; }
            set { _EndTime = value; }
        }
        /// <summary>
        /// gets and sets the StartTime attribute for this Schedule
        /// </summary>
        public int College
        {
            get { return _College; }
            set { _College = value; }
        }
        /// <summary>
        /// gets and sets the StartTime attribute for this Schedule
        /// </summary>
        public int DaysSelected
        {
            get { return _DaysSelected; }
            set { _DaysSelected = value; }
        }
    }
}

