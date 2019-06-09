using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ClassScheduler.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace ClassScheduler.Controllers
{
    public class CollegeController : Controller
    {

        // GET: College
        public ActionResult Index()
        {
            List<College> collegees = DAL.GetColleges();
            return View(collegees);
        }

        // GET: College/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            College college = DAL.GetCollege((int)id);
            if (college == null)
            {
                return NotFound();
            }
            return View(college);
        }

        // GET: College/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: College/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind("ID,Name,Abbreviation")] College college)
        {
            if (ModelState.IsValid)
            {
                DAL.AddCollege(college);
                return RedirectToAction(nameof(Index));
            }
            return View(college);
        }

        // GET: College/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            College college = DAL.GetCollege((int)id);
            return View(college);
        }

        // POST: College/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, [Bind("ID,Name,Abbreviation")] College college)
        {
            if (id != college.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                DAL.UpdateCollege(college);
                return RedirectToAction(nameof(Index));
            }
            return View(college);
        }

        // GET: College/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            College college = DAL.GetCollege((int)id);
            return View(college);
        }

        // POST: College/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            DAL.RemoveCollege(id);
            return RedirectToAction(nameof(Index));
        }
    }
}