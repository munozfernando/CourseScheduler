using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace ClassScheduler.Models {
    public class BuildingController : Controller {

        // GET: Building
        public async Task<IActionResult> Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Buildings.CanView) {
                List<Building> buildings = DAL.GetBuildings();
                return View(buildings);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view buildings");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Building/Details/5
        public async Task<IActionResult> Details(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Buildings.CanView) {
                if (id == null) {
                    return NotFound();
                }
                Building building = DAL.GetBuilding((int)id);
                if (building == null) {
                    return NotFound();
                }
                return View(building);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view buildings");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Building/Create
        public IActionResult Create() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Buildings.CanAdd) {
                ViewData["CampusID"] = new SelectList(DAL.GetCampuses(), "ID", "Name");
                return View();
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create buildings");
                return RedirectToAction("Index");
            }
        }

        // POST: Building/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,Name,Abbreviation,CampusID")] Building building) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Buildings.CanAdd) {
                if (ModelState.IsValid) {
                    if (DAL.AddBuilding(building) > 0) {
                        SessionVariables.SetSuccessMessage("Building created successfully");
                    }
                    else {
                        SessionVariables.SetErrorMessage("Building create failed");
                    }
                    return RedirectToAction(nameof(Index));
                }
                ViewData["CampusID"] = new SelectList(DAL.GetCampuses(), "ID", "Name", building.CampusID);
                return View(building);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create buildings");
                return RedirectToAction("Index");
            }
        }

        // GET: Building/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Buildings.CanEdit) {
                if (id == null) {
                    return NotFound();
                }

                Building building = DAL.GetBuilding((int)id);
                if (building == null) {
                    return NotFound();
                }
                ViewData["CampusID"] = new SelectList(DAL.GetCampuses(), "ID", "Name", building.CampusID);
                return View(building);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit buildings");
                return RedirectToAction("Index");
            }
        }

        // POST: Building/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Name,Abbreviation,CampusID")] Building building) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Buildings.CanEdit) {
                if (id != building.ID) {
                    return NotFound();
                }
                if (ModelState.IsValid) {
                    if (DAL.UpdateBuilding(building) > 0) {
                        SessionVariables.SetSuccessMessage("Building edited successfully");
                    }
                    else {
                        SessionVariables.SetErrorMessage("Building edit failed");
                    }
                    return RedirectToAction(nameof(Index));
                }
                ViewData["CampusID"] = new SelectList(DAL.GetCampuses(), "ID", "Name", building.CampusID);
                return View(building);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit buildings");
                return RedirectToAction("Index");
            }
        }

        // GET: Building/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Buildings.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                Building building = DAL.GetBuilding((int)id);
                if (building == null) {
                    return NotFound();
                }
                return View(building);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete buildings");
                return RedirectToAction("Index");
            }
        }

        // POST: Building/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Buildings.CanDelete) {
                if (DAL.RemoveBuilding(id) > 0) {
                    SessionVariables.SetSuccessMessage("Building deleted successfully");
                }
                else {
                    SessionVariables.SetErrorMessage("Building delete failed");
                }
                return RedirectToAction(nameof(Index));
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete buildings");
                return RedirectToAction("Index");
            }
        }
    }
}
