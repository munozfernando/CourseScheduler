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

    public class UserController : Controller {

        // GET: User
        public async Task<IActionResult> Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Users.CanView) {
                List<User> users = DAL.GetUsers();
                return View(users);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view users");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: User/Details/5
        public async Task<IActionResult> Details(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Users.CanView) {
                if (id == null) {
                    return NotFound();
                }
                User user = DAL.GetUser((int)id);
                if (user == null) {
                    return NotFound();
                }
                return View(user);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view users");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: User/Create
        public IActionResult Create() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Users.CanAdd) {
                ViewData["RoleID"] = new SelectList(DAL.GetRoles(), "ID", "Name");
                return View(new User());
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create users");
                return RedirectToAction("Index");
            }
        }

        // POST: User/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID, Username, Password, RoleID")] User user) {
            if (ModelState.IsValid) {
                if (DAL.AddUser(user) > 0) {
                    SessionVariables.SetSuccessMessage("User created successfully");
                }
                else {
                    SessionVariables.SetErrorMessage("User create failed");
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["RoleID"] = new SelectList(DAL.GetRoles(), "ID", "Name");

            return View(user);
        }


        // GET: User/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Users.CanEdit) {
                if (id == null) {
                    return NotFound();
                }
                User user = DAL.GetUser((int)id);
                if (user == null) {
                    return NotFound();
                }
                ViewData["RoleID"] = new SelectList(DAL.GetRoles(), "ID", "Name", user.RoleID);
                return View(user);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit users");
                return RedirectToAction("Index");
            }
        }

        // POST: User/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID, Username, Password, RoleID")] User user) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Users.CanEdit) {
                if (id != user.ID) {
                    return NotFound();
                }
                if (currentUser.ID == id && currentUser.RoleID != user.RoleID) {
                    SessionVariables.SetErrorMessage("You cannot change your own role");
                    return RedirectToAction("index");
                }
                if (ModelState.IsValid) {
                    if (DAL.UpdateUser(user) > 0) {
                        SessionVariables.SetSuccessMessage("User edited successfully");
                    }
                    else {
                        SessionVariables.SetErrorMessage("User edit failed");
                    }
                    return RedirectToAction(nameof(Index));
                }
                ViewData["RoleID"] = new SelectList(DAL.GetUsers(), "ID", "Name");
                return View(user);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit users");
                return RedirectToAction("index");
            }
        }

        // GET: User/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Users.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                if (id == currentUser.ID) {
                    SessionVariables.SetErrorMessage("You can't delete your own user");
                    return RedirectToAction("Index");
                }
                User user = DAL.GetUser((int)id);
                if (user == null) {
                    return NotFound();
                }
                return View(user);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete users");
                return RedirectToAction("Index");
            }
        }

        // POST: User/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Users.CanDelete) {
                if (id == currentUser.ID) {
                    SessionVariables.SetErrorMessage("You can't delete your own user");
                    return RedirectToAction("Index");
                }
                if (DAL.RemoveUser(id) > 0) {
                    SessionVariables.SetSuccessMessage("User deleted successfully");
                }
                else {
                    SessionVariables.SetErrorMessage("User delete failed");
                }
                return RedirectToAction(nameof(Index));
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete users");
                return RedirectToAction("Index");
            }
        }

        public IActionResult Login() {
            if (!DAL.TestConnection()) {
                SessionVariables.SetErrorMessageStay("Unable to make a connection with the database. Please check with an administrator.");
            }
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Sections.CanView) {
                return RedirectToAction("Index", "Section");
            }
            return View();
        }

        // POST: User/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Login([Bind("Username, Password")] User user) {
            if (!DAL.TestConnection()) {
                SessionVariables.SetErrorMessageStay("Unable to make a connection with the database. Please check with an administrator.");
                return View();
            }
            if (ModelState.IsValid) {
                User currentUser = DAL.GetUser(user.Username, user.Password);
                if (currentUser != null) {
                    SessionVariables.SetCurrentUserID(HttpContext, currentUser.ID);
                    SessionVariables.SetSuccessMessage("Logged in");
                    return RedirectToAction("Index", "Section");
                }
                SessionVariables.SetErrorMessage("Error logging in, Check username and password");
                user.Password = "";
                return View(user);
            }
            return View();
        }

        public IActionResult Logout() {
            SessionVariables.SetCurrentUserID(HttpContext, -1);
            SessionVariables.LoggedIn = false;
            return RedirectToAction("Login", "User");
        }
    }
}

