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

    public class DepartmentController : Controller {

        // GET: Department
        public async Task<IActionResult> Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Departments.CanView) {
                List<Department> departments = DAL.GetDepartments();
                return View(departments);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view departments");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Department/Sync
        public async Task<IActionResult> Sync() {
            List<Department> dbDepartments = DAL.GetDepartments();
            List<Department> fkDepartments = FakeDAL._Departments;
            foreach (Department department in fkDepartments) {
                int chk = (from dbDpt in dbDepartments
                           where dbDpt.Abbreviation == department.Abbreviation
                           select dbDpt).Count();
                if (chk < 1) {
                    DAL.AddDepartment(department);
                }
            }
            return RedirectToAction(nameof(Index));
        }

        // GET: Department/Details/5
        public async Task<IActionResult> Details(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Departments.CanView) {
                if (id == null) {
                    return NotFound();
                }
                Department department = DAL.GetDepartment((int)id);
                if (department == null) {
                    return NotFound();
                }
                return View(department);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view departments");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Department/Create
        public IActionResult Create() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Departments.CanAdd) {
                ViewData["DepartmentID"] = new SelectList(DAL.GetDepartments(), "ID", "Name");
                return View();
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create departments");
                return RedirectToAction("Index");
            }
        }

        // POST: Department/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID, Name", "Abbreviation")] Department department) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Departments.CanAdd) {
                if (ModelState.IsValid) {
                    DAL.AddDepartment(department);
                    return RedirectToAction(nameof(Index));
                }
                ViewData["DepartmentID"] = new SelectList(DAL.GetDepartments(), "ID", "Name");
                return View(department);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create departments");
                return RedirectToAction("Index");
            }
        }


        // GET: Department/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Departments.CanEdit) {
                if (id == null) {
                    return NotFound();
                }
                Department department = DAL.GetDepartment((int)id);
                if (department == null) {
                    return NotFound();
                }
                ViewData["DepartmentID"] = new SelectList(DAL.GetDepartments(), "ID", "Name");
                return View(department);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit departments");
                return RedirectToAction("Index");
            }
        }

        // POST: Department/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID, Name, Abbreviation")] Department department) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Departments.CanEdit) {
                if (id != department.ID) {
                    return NotFound();
                }
                if (ModelState.IsValid) {
                    DAL.UpdateDepartment(department);
                    return RedirectToAction(nameof(Index));
                }
                ViewData["DepartmentID"] = new SelectList(DAL.GetDepartments(), "ID", "Name");
                return View(department);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit departments");
                return RedirectToAction("Index");
            }
        }

        // GET: Department/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Departments.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                Department department = DAL.GetDepartment((int)id);
                if (department == null) {
                    return NotFound();
                }
                return View(department);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete departments");
                return RedirectToAction("Index");
            }
        }

        // POST: Department/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Departments.CanDelete) {
                DAL.RemoveDepartment(id);
                return RedirectToAction(nameof(Index));
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete departments");
                return RedirectToAction("Index");
            }
        }
    }
}

