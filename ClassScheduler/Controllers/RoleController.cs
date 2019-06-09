using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ClassScheduler.Models;

namespace ClassScheduler.Controllers {
    public class RoleController : Controller {

        // GET: Role
        public async Task<IActionResult> Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Roles.CanView) {
                List<Role> roles = DAL.GetRoles();
                return View(roles);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view roles");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Role/Details/5
        public async Task<IActionResult> Details(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Roles.CanView) {
                if (id == null) {
                    return NotFound();
                }
                Role role = DAL.GetRole((int)id);
                if (role == null) {
                    return NotFound();
                }
                return View(role);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view roles");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Role/Create
        public IActionResult Create() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Roles.CanAdd) {
                ViewData["RoleID"] = new SelectList(DAL.GetRoles(), "ID", "Name");
                return View();
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create roles");
                return RedirectToAction("Index");
            }
        }

        // POST: Role/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Name,IsAdmin,Buildings,Campuses,Courses,Days,Departments,DateTimeModels,Fees,Instructors," +
            "Roles,Rooms,ScheduleTypes,Sections,Spreadsheets,Subjects,Users,ID")] Role role) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Roles.CanAdd) {
                if (ModelState.IsValid) {
                    if (DAL.AddRole(role) > 0) {
                        SessionVariables.SetSuccessMessage("Role created successfully");
                    }
                    else {
                        SessionVariables.SetErrorMessage("Role create failed");
                    }
                    return RedirectToAction(nameof(Index));
                }
                return View(role);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create roles");
                return RedirectToAction("Index");
            }
        }

        // GET: Role/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Roles.CanEdit) {
                if (id == null) {
                    return NotFound();
                }
                Role role = DAL.GetRole((int)id);
                if (role == null) {
                    return NotFound();
                }
                return View(role);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit roles");
                return RedirectToAction("Index");
            }
        }

        // POST: Role/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Name,IsAdmin,Buildings,Campuses,Courses,Days,Departments,DateTimeModels,Fees,Instructors," +
            "Roles,Rooms,ScheduleTypes,Sections,Spreadsheets,Subjects,Users,ID")] Role role) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Roles.CanEdit) {
                if (id != role.ID) {
                    return NotFound();
                }

                if (ModelState.IsValid) {
                    if (DAL.UpdateRole(role) > 0) {
                        SessionVariables.SetSuccessMessage("Role edited successfully");
                    }
                    else {
                        SessionVariables.SetErrorMessage("Role edit failed");
                    }
                    return RedirectToAction(nameof(Index));
                }
                return View(role);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit roles");
                return RedirectToAction("Index");
            }
        }

        // GET: Role/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Roles.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                Role role = DAL.GetRole((int)id);
                if (role == null) {
                    return NotFound();
                }
                return View(role);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete roles");
                return RedirectToAction("Index");
            }
        }

        // POST: Role/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Roles.CanDelete) {
                if (DAL.RemoveRole(id) > 0) {
                    SessionVariables.SetSuccessMessage("Role deleted successfully");
                }
                else {
                    SessionVariables.SetErrorMessage("Role delete failed");
                }
                return RedirectToAction(nameof(Index));
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete roles");
                return RedirectToAction("Index");
            }
        }

    }
}
