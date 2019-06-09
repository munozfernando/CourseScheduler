using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace ClassScheduler.Models {
    public class CampusController : Controller {

        // GET: Campus
        public ActionResult Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Campuses.CanView) {
                List<Campus> campuses = DAL.GetCampuses();
                return View(campuses);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view campuses");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Campus/Details/5
        public ActionResult Details(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Campuses.CanView) {
                if (id == null) {
                    return NotFound();
                }
                Campus campus = DAL.GetCampus((int)id);
                if (campus == null) {
                    return NotFound();
                }
                return View(campus);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view campuses");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Campus/Create
        public ActionResult Create() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Campuses.CanAdd) {
                return View();
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create campuses");
                return RedirectToAction("Index");
            }
        }

        // POST: Campus/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind("ID,Name,Abbreviation")] Campus campus) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Campuses.CanAdd) {
                if (ModelState.IsValid) {
                    if (DAL.AddCampus(campus) > 0) {
                        SessionVariables.SetSuccessMessage("Campus created successfully");
                    }
                    else {
                        SessionVariables.SetErrorMessage("Campus create failed");
                    }
                    return RedirectToAction(nameof(Index));
                }
                return View(campus);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create campuses");
                return RedirectToAction("Index");
            }
        }

        // GET: Campus/Edit/5
        public ActionResult Edit(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Campuses.CanEdit) {
                if (id == null) {
                    return NotFound();
                }
                Campus campus = DAL.GetCampus((int)id);
                return View(campus);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit campuses");
                return RedirectToAction("Index");
            }
        }

        // POST: Campus/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, [Bind("ID,Name,Abbreviation")] Campus campus) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Campuses.CanEdit) {
                if (id != campus.ID) {
                    return NotFound();
                }
                if (ModelState.IsValid) {
                    if (DAL.UpdateCampus(campus) > 0) {
                        SessionVariables.SetSuccessMessage("Campus edited successfully");
                    }
                    else {
                        SessionVariables.SetErrorMessage("Campus edit failed");
                    }
                    return RedirectToAction(nameof(Index));
                }
                return View(campus);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit campuses");
                return RedirectToAction("Index");
            }
        }

        // GET: Campus/Delete/5
        public ActionResult Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Campuses.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                Campus campus = DAL.GetCampus((int)id);
                return View(campus);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete campuses");
                return RedirectToAction("Index");
            }
        }

        // POST: Campus/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Campuses.CanDelete) {
                if (DAL.RemoveCampus(id) > 0) {
                    SessionVariables.SetSuccessMessage("Campus deleted successfully");
                }
                else {
                    SessionVariables.SetErrorMessage("Campus delete failed");
                }
                return RedirectToAction(nameof(Index));
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete campuses");
                return RedirectToAction("Index");
            }
        }
    }
}
