using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ClassScheduler.Models;
using OfficeOpenXml;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Hosting;
using System.IO;

namespace ClassScheduler.Controllers {
    public class SpreadsheetVariablesController : Controller {
        private IHostingEnvironment _Environment;
        public SpreadsheetVariablesController(IHostingEnvironment env) {
            _Environment = env;
        }

        // GET: SpreadsheetVariables
        public IActionResult Index() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Spreadsheets.CanEdit) {
                List<SpreadsheetVariables> spreadsheetVariables = DAL.GetSpreadsheetVariablesList();
                return RedirectToAction("Edit", spreadsheetVariables[0]);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit spreadsheet details");
                return RedirectToAction("Index", "Section");
            }
        }

        // GET: SpreadsheetVariables/Details/5
        public IActionResult Details(int? id) {
            if (id == null) {
                return NotFound();
            }

            SpreadsheetVariables spreadsheetVariables = DAL.GetSpreadsheetVariables((int)id);
            if (spreadsheetVariables == null) {
                return NotFound();
            }

            return View(spreadsheetVariables);
        }

        // GET: SpreadsheetVariables/Create
        public IActionResult Create() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Spreadsheets.CanAdd) {
                SpreadsheetVariables sv = new SpreadsheetVariables();
                return View(sv);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to create spreadsheet details");
                return RedirectToAction("Index");
            }
        }

        // POST: SpreadsheetVariables/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create([Bind("StartingRowNumber,AcademicSemester,AddChangeDelete,Department,SectionCRN," +
            "CourseNumber,SectionNumber,CrossListID,CourseTitle,Campus,ScheduleType,MoodleRequired,InstructorApprovalRequired," +
            "PartOfTerm,FixedCredit,MinimumCredits,MaximumCredits,ClassLimit,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday," +
            "Sunday,StartTime,EndTime,Building,Room,PrimaryInstructorFirstName,PrimaryInstructorLastName,PrimaryInstructorNumber," +
            "PrimaryInstructorTeachingPercentage,SecondaryInstructorFirstName,SecondaryInstructorLastName,SecondaryInstructorNumber," +
            "SecondaryInstructorTeachingPercentage,ClassFeeDetailCode,ClassFeeAmount,SectionNotes,CrossListSubject,CrossListCourseNumber," +
            "DepartmentComments,ID,DefaultFontStyle,DefaultFontSize,RequiresPermissionAbbreviation,RequiresMoodleAbbreviation")]
            SpreadsheetVariables spreadsheetVariables, IFormFile file) {
            if (ModelState.IsValid) {
                try {
                    ExcelPackage package = new ExcelPackage(file.OpenReadStream());
                    DAL.AddSpreadsheetVariables(spreadsheetVariables);
                    return RedirectToAction("Index");
                }
                catch (Exception error) {

                }
            }
            return View(spreadsheetVariables);
        }

        // GET: SpreadsheetVariables/Edit/5
        public async Task<IActionResult> Edit(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Spreadsheets.CanEdit) {
                if (id == null) {
                    return NotFound();
                }
                SpreadsheetVariables spreadsheetVariables = DAL.GetSpreadsheetVariables((int)id);
                if (spreadsheetVariables == null) {
                    return NotFound();
                }
                return View(spreadsheetVariables);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to edit spreadsheet details");
                return RedirectToAction("Index");
            }
        }

        // POST: SpreadsheetVariables/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("StartingRowNumber,AcademicSemester,AddChangeDelete,Department,SectionCRN," +
            "CourseNumber,SectionNumber,CrossListID,CourseTitle,Campus,ScheduleType,MoodleRequired,InstructorApprovalRequired," +
            "PartOfTerm,FixedCredit,MinimumCredits,MaximumCredits,ClassLimit,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday," +
            "Sunday,StartTime,EndTime,Building,Room,PrimaryInstructorFirstName,PrimaryInstructorLastName,PrimaryInstructorNumber," +
            "PrimaryInstructorTeachingPercentage,SecondaryInstructorFirstName,SecondaryInstructorLastName,SecondaryInstructorNumber," +
            "SecondaryInstructorTeachingPercentage,ClassFeeDetailCode,ClassFeeAmount,SectionNotes,CrossListSubject,CrossListCourseNumber," +
            "DepartmentComments,ID,DefaultFontStyle,DefaultFontSize,RequiresPermissionAbbreviation,RequiresMoodleAbbreviation")]
            SpreadsheetVariables spreadsheetVariables, IFormFile file) {
            if (id != spreadsheetVariables.ID) {
                return NotFound();
            }

            if (ModelState.IsValid) {
                if (DAL.UpdateSpreadsheetVariables(spreadsheetVariables) > 0) {
                    SessionVariables.SetSuccessMessage("Spreadsheet variables edited successfully");
                }
                if (file != null) {
                    try {
                        ExcelPackage package = new ExcelPackage(file.OpenReadStream());
                        ExcelWorksheet worksheet = package.Workbook.Worksheets[1];
                        string webRoot = _Environment.WebRootPath;
                        //saves a spreadsheet for formatting not needing to save the changes each time though because it is just using the top 3 rows
                        package.SaveAs(new FileInfo(webRoot + "\\currentSheet.xlsx"));
                    }
                    catch (Exception error) {
                        SessionVariables.SetErrorMessage("Spreadsheet template save failed");
                    }
                }
                return RedirectToAction("Index");
            }
            return View(spreadsheetVariables);
        }

        // GET: SpreadsheetVariables/Delete/5
        public async Task<IActionResult> Delete(int? id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Spreadsheets.CanDelete) {
                if (id == null) {
                    return NotFound();
                }
                SpreadsheetVariables spreadsheetVariables = DAL.GetSpreadsheetVariables((int)id);
                if (spreadsheetVariables == null) {
                    return NotFound();
                }
                return View(spreadsheetVariables);
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete spreadsheet details");
                return RedirectToAction("Index");
            }
        }

        // POST: SpreadsheetVariables/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Spreadsheets.CanDelete) {
                DAL.RemoveSpreadsheetVariables((int)id);
                return RedirectToAction("Index");
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to delete spreadsheet details");
                return RedirectToAction("Index");
            }
        }
    }
}
