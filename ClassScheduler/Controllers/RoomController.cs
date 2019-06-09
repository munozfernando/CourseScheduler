using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace ClassScheduler.Models {
    public class RoomController : Controller {

        // GET: Room
        public async Task<IActionResult> Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Rooms.CanView) {
                List<Room> rooms = DAL.GetRooms();
                List<AcademicSemester> academicSemesters = DAL.GetAcademicSemesters();
                List<int> years = new List<int>();
                foreach (AcademicSemester academicSemester in academicSemesters) {
                    if (!years.Contains(academicSemester.AcademicYear)) {
                        years.Add(academicSemester.AcademicYear);
                    }
                }
                Dictionary<int, List<Section>> roomSections = new Dictionary<int, List<Section>>();
                List<Section> sections = DAL.GetSectionsByAcademicSemesterID(SessionVariables.GetSessionAcademicSemesterID(HttpContext));
                foreach (Room room in rooms) {
                    if (!roomSections.ContainsKey(room.ID)) {
                        roomSections.Add(room.ID, new List<Section>());
                    }
                    foreach (Section sc in sections) {
                        if (sc.RoomID == room.ID && sc.Course != null) {
                            roomSections[room.ID].Add(sc);
                        }
                    }
                }
                ViewData["AcademicSemesterYear"] = SessionVariables.GetSessionAcademicSemester(HttpContext).AcademicYear;
                ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", SessionVariables.GetSessionAcademicSemester(HttpContext).SemesterID);
                ViewData["AcademicYears"] = new SelectList(years, SessionVariables.GetSessionAcademicSemester(HttpContext).AcademicYear);
                ViewData["AcademicSemester"] = SessionVariables.GetSessionAcademicSemester(HttpContext).Display;
                ViewData["RoomSections"] = roomSections;
                return View(rooms);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view rooms");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Room/Details/5
        public async Task<IActionResult> Details(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Rooms.CanView) {
                if (id == null) {
                    return NotFound();
                }
                Room room = DAL.GetRoom((int)id);
                if (room == null) {
                    return NotFound();
                }
                return View(room);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view rooms");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: Room/Create
        public IActionResult Create() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Rooms.CanAdd) {
                ViewData["BuildingID"] = new SelectList(DAL.GetBuildings(), "ID", "Name");
                return View();
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create rooms");
                return RedirectToAction("Index");
            }
        }

        // POST: Room/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,Number,BuildingID,SeatsAvailable,Details")] Room room) {
            if (ModelState.IsValid) {
                if (DAL.AddRoom(room) > 0) {
                    SessionVariables.SetSuccessMessage("Room created successfully");
                    return RedirectToAction(nameof(Index));
                }
                else {
                    SessionVariables.SetErrorMessage("Room create failed");
                }
            }
            ViewData["BuildingID"] = new SelectList(DAL.GetBuildings(), "ID", "Name", room.BuildingID);
            return View(room);
        }

        // GET: Room/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Rooms.CanEdit) {
                if (id == null) {
                    return NotFound();
                }
                Room room = DAL.GetRoom((int)id);
                if (room == null) {
                    return NotFound();
                }
                ViewData["BuildingID"] = new SelectList(DAL.GetBuildings(), "ID", "Name", room.BuildingID);
                return View(room);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit rooms");
                return RedirectToAction("Index");
            }
        }

        // POST: Room/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,Number,BuildingID,SeatsAvailable,Details")] Room room) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Rooms.CanEdit) {
                if (id != room.ID) {
                    return NotFound();
                }
                if (ModelState.IsValid) {
                    if (DAL.UpdateRoom(room) > 0) {
                        SessionVariables.SetSuccessMessage("Room edited successfully");
                        return RedirectToAction(nameof(Index));
                    }
                    else {
                        SessionVariables.SetErrorMessage("Room edit failed");
                    }
                }
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit rooms");
                return RedirectToAction("Index");
            }
            ViewData["BuildingID"] = new SelectList(DAL.GetBuildings(), "ID", "Name", room.BuildingID);
            return View(room);
        }

        // GET: Room/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Rooms.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                Room room = DAL.GetRoom((int)id);
                if (room == null) {
                    return NotFound();
                }
                return View(room);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete rooms");
                return RedirectToAction("Index");
            }
        }

        // POST: Room/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Rooms.CanDelete) {
                if (DAL.RemoveRoom(id) > 0) {
                    SessionVariables.SetSuccessMessage("Room deleted successfully");
                    return RedirectToAction("Index");
                }
                else {
                    SessionVariables.SetErrorMessage("Room delete failed");
                    return RedirectToAction("Index");
                }
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete rooms");
                return RedirectToAction("Index");
            }
        }

        public void ToggleTimeFormat() {
            if (DAL.TimeFormat == "HH:mm") {
                DAL.TimeFormat = "hh:mm tt";
            }
            else {
                DAL.TimeFormat = "HH:mm";
            }
        }

        public void SelectAcademicSemester(int currentSemesterID, int currentYear) {
            SessionVariables.SetSessionAcademicSemesterID(HttpContext, DAL.GetAcademicSemesterByYearAndSemester(currentSemesterID, currentYear).ID);
        }
    }
}
