using ClassScheduler.Models;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;

namespace ClassScheduler.Controllers {
    public class ImportExportController : Controller {
        private IHostingEnvironment _Environment;
        public ImportExportController(IHostingEnvironment env) {
            _Environment = env;
        }
        #region spreadsheetVariable
        private SpreadsheetVariables sv = DAL.GetSpreadsheetVariables(1);
        #endregion

        public IActionResult Index() {
            List<AcademicSemester> academicSemesters = DAL.GetAcademicSemesters();
            List<int> years = new List<int>();
            foreach (AcademicSemester academicSemester in academicSemesters) {
                if (!years.Contains(academicSemester.AcademicYear)) {
                    years.Add(academicSemester.AcademicYear);
                }
            }
            List<Section> sections = DAL.GetSections().Where(s => s.AcademicSemesterID == SessionVariables.GetSessionAcademicSemesterID(HttpContext)).ToList();
            ViewData["AcademicSemesterYear"] = SessionVariables.GetSessionAcademicSemester(HttpContext).AcademicYear;
            ViewData["SemesterID"] = new SelectList(DAL.GetSemesters(), "ID", "Name", SessionVariables.GetSessionAcademicSemester(HttpContext).SemesterID);
            ViewData["AcademicYears"] = new SelectList(years, SessionVariables.GetSessionAcademicSemester(HttpContext).AcademicYear);
            return View();
        }

        /// <summary>
        /// imports a spreadsheet and all of its details
        /// </summary>
        /// <param name="file"></param>
        /// <returns></returns>
        public IActionResult ImportSpreadsheet(IFormFile file) {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Spreadsheets.CanAdd) {
                Dictionary<string, string> spreadsheetData = new Dictionary<string, string>();
                List<int> courseTitleComparer = new List<int>();
                Dictionary<string, List<Section>> sectionComparer = new Dictionary<string, List<Section>>();
                sectionComparer.Add("Old Sections", new List<Section>());
                sectionComparer.Add("New Sections", new List<Section>());
                if (file != null && file.ContentDisposition.Length > 0) {
                    try {
                        ExcelPackage package = new ExcelPackage(file.OpenReadStream());
                        ExcelWorksheet worksheet = package.Workbook.Worksheets[1];
                        int rowCount = worksheet.Dimension.End.Row;
                        int colCount = worksheet.Dimension.End.Column;
                        FillDictionaryKeys(spreadsheetData, rowCount, colCount);
                        for (int row = 1; row <= rowCount; row++) {
                            for (int col = 1; col <= colCount; col++) {
                                if (worksheet.Cells[row, col].Value != null) {
                                    spreadsheetData[worksheet.Cells[row, col].Address] = worksheet.Cells[row, col].Value.ToString().Trim();
                                }
                            }
                        }
                        CreateAcademicSemester(ref spreadsheetData);
                        CreateScheduleTypes(ref spreadsheetData);
                        CreateCampuses(ref spreadsheetData);
                        CreateBuildings(ref spreadsheetData);
                        CreateRooms(ref spreadsheetData);
                        CreateDetailCodes(ref spreadsheetData);
                        CreateDepartments(ref spreadsheetData);
                        CreateCourses(ref spreadsheetData, ref courseTitleComparer);
                        CreateInstructors(ref spreadsheetData);
                        SearchAndCreateSections(ref spreadsheetData, ref sectionComparer);
                        if (sectionComparer["Old Sections"].Count > 0) {
                            foreach (Section oldSection in sectionComparer["Old Sections"]) {
                                oldSection.GetInstructorDetails();
                            }
                            foreach (Section newSection in sectionComparer["New Sections"]) {
                                newSection.GetInstructorDetails();
                            }
                            return View("Comparer", sectionComparer);
                        }
                        if (spreadsheetData.Keys.Count > 0) {
                            SessionVariables.SetSuccessMessage("Spreadsheet successfully imported");
                        }
                        else {
                            SessionVariables.SetErrorMessage("Error on import please check the spreadsheet and try again");
                        }
                    }
                    catch (Exception error) {
                        SessionVariables.SetErrorMessage("Error on import please check the spreadsheet and try again");
                        return RedirectToAction("Index", "ImportExport");
                    }
                }
                else {
                    SessionVariables.SetErrorMessage("No spreadsheet selected please select a spreadsheet");
                    return RedirectToAction("Index", "ImportExport");
                }
                return RedirectToAction("Index", "Section");
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to import spreadsheet data");
                return RedirectToAction("Index", "Section");
            }
        }

        /// <summary>
        /// cycles through the spreadsheet data and creates any missing ScheduleTypes
        /// </summary>
        /// <param name="spreadsheetData"></param>
        private void CreateScheduleTypes(ref Dictionary<string, string> spreadsheetData) {
            List<ScheduleType> scheduleTypes = DAL.GetScheduleTypes();
            foreach (KeyValuePair<string, string> kvp in spreadsheetData) {
                string columnName = GetCellColumnLetters(kvp.Key);
                int rowNumber = GetCellRowNumber(kvp.Key);
                if (columnName == sv.ScheduleType && rowNumber >= sv.StartingRowNumber && kvp.Value != "") {
                    bool foundMatch = false;
                    for (int scheduleTypeIndex = 0; scheduleTypeIndex < scheduleTypes.Count; scheduleTypeIndex++) {
                        if (scheduleTypes[scheduleTypeIndex].Abbreviation == kvp.Value) {
                            foundMatch = true;
                        }
                    }
                    if (!foundMatch) {
                        ScheduleType newScheduleType = new ScheduleType();
                        newScheduleType.Abbreviation = kvp.Value;
                        DAL.AddScheduleType(newScheduleType);
                        scheduleTypes.Add(newScheduleType);
                    }
                }
            }
        }

        /// <summary>
        /// cycles through the spreadsheet data and creates any missing AcademicSemesters
        /// </summary>
        /// <param name="spreadsheetData"></param>
        private void CreateAcademicSemester(ref Dictionary<string, string> spreadsheetData) {
            List<AcademicSemester> academicSemsesters = DAL.GetAcademicSemesters();
            string currentYearString = DateTime.Now.ToString("yyyy");
            string currentYearOffsetString = DateTime.Now.ToString("yy");
            int currentYearOffset = int.Parse(currentYearString) - int.Parse(currentYearOffsetString);
            string columnName = GetCellColumnLetters(spreadsheetData[sv.AcademicSemester + sv.StartingRowNumber]);
            string semesterAbbreviation = spreadsheetData[sv.AcademicSemester + sv.StartingRowNumber].Trim('1', '2', '3', '4', '5', '6', '7', '8', '9', '0');
            int semesterYear = int.Parse(spreadsheetData[sv.AcademicSemester + sv.StartingRowNumber].Trim('A', 'F', 'S', 'U', 'M')) + currentYearOffset;
            Semester importedSemester = DAL.GetSemesterByAbbreviation(semesterAbbreviation);
            if (importedSemester == null) {
                //semester was null so the spreadsheet dictionary needs to be cleared to display an error to the user
                spreadsheetData = new Dictionary<string, string>();
                return;
            }
            AcademicSemester asToAdd = DAL.GetAcademicSemesterByYearAndSemester(importedSemester.ID, semesterYear);
            if (asToAdd == null) {
                //couldn't add the academic semester so the dictionary is cleared to prevent further errors
                spreadsheetData = new Dictionary<string, string>();
                return;
            }
            SessionVariables.SetSessionAcademicSemesterID(HttpContext, asToAdd.ID);
        }

        /// <summary>
        /// cycles through the spreadsheet data and creates any missing Courses
        /// </summary>
        /// <param name="spreadsheetData"></param>
        private void CreateCourses(ref Dictionary<string, string> spreadsheetData, ref List<int> courseComparer) {
            List<Course> courses = DAL.GetCourses();
            foreach (KeyValuePair<string, string> kvp in spreadsheetData) {
                string columnName = GetCellColumnLetters(kvp.Key);
                int rowNumber = GetCellRowNumber(kvp.Key);
                if (columnName == sv.CourseNumber && rowNumber >= sv.StartingRowNumber && kvp.Value != "") {
                    Course foundCourse = null;
                    string courseNumberString = spreadsheetData[sv.CourseNumber + rowNumber];
                    string courseFixedCreditsString = spreadsheetData[sv.FixedCredit + rowNumber];
                    string courseMinCreditsString = spreadsheetData[sv.MinimumCredits + rowNumber];
                    string courseMaxCreditsString = spreadsheetData[sv.MaximumCredits + rowNumber];
                    int courseNumber = 0;
                    int lastTwoDigits = 0;
                    int.TryParse(courseNumberString, out courseNumber);
                    if (courseNumber > 1000 && courseNumber < 10000) {
                        lastTwoDigits = courseNumber % 100;
                        if (lastTwoDigits == 99) {
                            //courses ending in a 99 are experimental and often have multiple titles
                            foundCourse = DAL.GetCourseByDepartmentNumberAndTitle(spreadsheetData[sv.Department + rowNumber], courseNumber, spreadsheetData[sv.CourseTitle + rowNumber]);
                        }
                        else {
                            //if the course is not experimental to prevent duplicate courses it's checked by department and number only
                            foundCourse = DAL.GetCourseByDepartmentAndNumber(spreadsheetData[sv.Department + rowNumber], courseNumber);
                            //checks if the course title is the same as the and adds the courseID to a list if there is a difference to notify the user
                            if (foundCourse != null && foundCourse.Title != spreadsheetData[sv.CourseTitle + rowNumber] && !courseComparer.Contains(foundCourse.ID)) {
                                courseComparer.Add(foundCourse.ID);
                            }
                        }
                        if (foundCourse == null) {
                            int courseFixedCredits = 0;
                            int courseMinCredits = 0;
                            int courseMaxCredits = 0;
                            if (courseFixedCreditsString != "") {
                                int.TryParse(courseFixedCreditsString, out courseFixedCredits);
                            }
                            else {
                                int.TryParse(courseMinCreditsString, out courseMinCredits);
                                int.TryParse(courseMaxCreditsString, out courseMaxCredits);
                            }
                            Course newCourse = new Course();
                            if (courseMinCredits == courseMaxCredits) {
                                newCourse.IsFixedCredit = true;
                            }
                            else {
                                newCourse.IsFixedCredit = false;
                            }
                            newCourse.FixedCredits = courseFixedCredits;
                            newCourse.MinimumCredits = courseMinCredits;
                            newCourse.MaximumCredits = courseMaxCredits;
                            newCourse.Number = courseNumber;
                            newCourse.Title = spreadsheetData[sv.CourseTitle + rowNumber];
                            string subjectAbbrev = spreadsheetData[sv.Department + rowNumber];
                            newCourse.DepartmentID = DAL.GetDepartmentByAbbreviation(subjectAbbrev).ID;
                            DAL.AddCourse(newCourse);
                            courses.Add(newCourse);
                        }
                    }
                }
            }
        }

        /// <summary>
        /// cycles through the spreadsheet data and creates any missing Department
        /// </summary>
        /// <param name="spreadsheetData"></param>
        private void CreateDepartments(ref Dictionary<string, string> spreadsheetData) {
            List<Department> departments = DAL.GetDepartments();
            foreach (KeyValuePair<string, string> kvp in spreadsheetData) {
                string columnName = GetCellColumnLetters(kvp.Key);
                int rowNumber = GetCellRowNumber(kvp.Key);
                if (columnName == sv.Department && rowNumber >= sv.StartingRowNumber && kvp.Value != "") {
                    bool foundMatch = false;
                    for (int departmentIndex = 0; departmentIndex < departments.Count; departmentIndex++) {
                        if (departments[departmentIndex].Abbreviation.ToUpper() == kvp.Value.ToUpper()) {
                            foundMatch = true;
                        }
                    }
                    if (!foundMatch) {
                        Department newdepartment = new Department();
                        newdepartment.Abbreviation = kvp.Value.ToUpper();
                        newdepartment.Name = "Unknown / Missing";
                        DAL.AddDepartment(newdepartment);
                        departments.Add(newdepartment);
                    }
                }
            }
        }

        /// <summary>
        /// cycles through the spreadsheet data and creates any missing Fees
        /// </summary>
        /// <param name="spreadsheetData"></param>
        private void CreateDetailCodes(ref Dictionary<string, string> spreadsheetData) {
            List<DetailCode> codes = DAL.GetDetailCodes();
            foreach (KeyValuePair<string, string> kvp in spreadsheetData) {
                string columnName = GetCellColumnLetters(kvp.Key);
                int rowNumber = GetCellRowNumber(kvp.Key);
                if (columnName == sv.ClassFeeDetailCode && rowNumber >= sv.StartingRowNumber && kvp.Value != "") {
                    bool foundMatch = false;
                    string feeAmountString = spreadsheetData[sv.ClassFeeAmount + rowNumber].TrimStart('$');
                    int feeAmount = 0;
                    int.TryParse(feeAmountString, out feeAmount);
                    for (int codeIndex = 0; codeIndex < codes.Count; codeIndex++) {
                        if (codes[codeIndex].Name.ToUpper() == kvp.Value.ToUpper()) {
                            foundMatch = true;
                        }
                    }
                    if (!foundMatch) {
                        DetailCode newCode = new DetailCode();
                        newCode.Name = kvp.Value;
                        DAL.AddDetailCode(newCode);
                        codes.Add(newCode);
                    }
                }
            }
        }

        /// <summary>
        /// cycles through the spreadsheet data and creates any missing Instructors
        /// </summary>
        /// <param name="spreadsheetData"></param>
        private void CreateInstructors(ref Dictionary<string, string> spreadsheetData) {
            List<Instructor> instructors = DAL.GetInstructors();
            foreach (KeyValuePair<string, string> kvp in spreadsheetData) {
                string columnName = GetCellColumnLetters(kvp.Key);
                int rowNumber = GetCellRowNumber(kvp.Key);
                //detects if there is a primary instructor and creates one if one is not in the database
                if (columnName == sv.PrimaryInstructorFirstName && rowNumber >= sv.StartingRowNumber && kvp.Value != "") {
                    bool foundMatch = false;
                    int instructorNumber = 0;
                    int.TryParse(spreadsheetData[sv.PrimaryInstructorNumber + rowNumber], out instructorNumber);
                    for (int instructorIndex = 0; instructorIndex < instructors.Count; instructorIndex++) {
                        if (instructors[instructorIndex].FirstName.ToLower() == kvp.Value.ToLower() && instructors[instructorIndex].LastName.ToLower() == spreadsheetData[sv.PrimaryInstructorLastName + rowNumber].ToLower()) {
                            foundMatch = true;
                        }
                    }
                    if (!foundMatch && kvp.Value.ToLower() != "staff" && kvp.Value != "") {
                        string instructorNumberString = spreadsheetData[sv.PrimaryInstructorNumber + rowNumber];
                        Instructor newInstructor = new Instructor();
                        newInstructor.FirstName = kvp.Value;
                        newInstructor.LastName = spreadsheetData[sv.PrimaryInstructorLastName + rowNumber];
                        newInstructor.Number = instructorNumber;
                        newInstructor.MiddleName = "";
                        newInstructor.CourseLoad = 0;
                        DAL.AddInstructor(newInstructor);
                        instructors.Add(newInstructor);
                    }
                }
                //detects if there is a secondary instructor and creates one if one is not in the database
                if (columnName == sv.SecondaryInstructorFirstName && rowNumber > 3 && kvp.Value != "") {
                    bool foundMatch = false;
                    string instructorLastName = spreadsheetData[sv.SecondaryInstructorLastName + rowNumber];
                    for (int instructorIndex = 0; instructorIndex < instructors.Count; instructorIndex++) {
                        if (instructors[instructorIndex].FirstName.ToLower() == kvp.Value.ToLower() && instructors[instructorIndex].LastName.ToLower() == instructorLastName.ToLower()) {
                            foundMatch = true;
                        }
                    }
                    if (!foundMatch && kvp.Value.ToLower() != "staff" && kvp.Value != "") {
                        string instructorNumberString = spreadsheetData[sv.SecondaryInstructorNumber + rowNumber];
                        int instructorNumber = 0;
                        int.TryParse(instructorNumberString, out instructorNumber);
                        Instructor newInstructor = new Instructor();
                        newInstructor.FirstName = kvp.Value;
                        newInstructor.LastName = instructorLastName;
                        newInstructor.Number = instructorNumber;
                        newInstructor.MiddleName = "";
                        newInstructor.CourseLoad = 0;
                        DAL.AddInstructor(newInstructor);
                        instructors.Add(newInstructor);
                    }
                }
            }
        }

        /// <summary>
        /// cycles through the spreadsheet data and creates any missing Rooms
        /// </summary>
        /// <param name="spreadsheetData"></param>
        private void CreateRooms(ref Dictionary<string, string> spreadsheetData) {
            List<Room> rooms = DAL.GetRooms();
            foreach (KeyValuePair<string, string> kvp in spreadsheetData) {
                string columnName = GetCellColumnLetters(kvp.Key);
                int rowNumber = GetCellRowNumber(kvp.Key);
                if (columnName == sv.Room && rowNumber >= sv.StartingRowNumber && kvp.Value != "") {
                    bool foundMatch = false;
                    int roomNumberParse = 0;
                    int.TryParse(kvp.Value, out roomNumberParse);
                    string buildingAbbrev = spreadsheetData[sv.Building + rowNumber];
                    for (int roomIndex = 0; roomIndex < rooms.Count; roomIndex++) {
                        Room room = DAL.GetRoomByNumberAndBuildingAbbreviation(roomNumberParse, buildingAbbrev);
                        if (room != null) {
                            foundMatch = true;
                        }
                    }
                    if (!foundMatch) {
                        //add a rool to the DAL list
                        Room newRoom = new Room();
                        newRoom.Number = roomNumberParse;
                        newRoom.BuildingID = DAL.GetBuildingByAbbreviation(buildingAbbrev);
                        newRoom.SeatsAvailable = 0;
                        DAL.AddRoom(newRoom);
                        rooms.Add(newRoom);
                    }
                }
            }
        }

        /// <summary>
        /// cycles through the spreadsheet data and creates any missing Buildings
        /// </summary>
        /// <param name="spreadsheetData"></param>
        private void CreateBuildings(ref Dictionary<string, string> spreadsheetData) {
            List<Building> buildings = DAL.GetBuildings();
            foreach (KeyValuePair<string, string> kvp in spreadsheetData) {
                string columnName = GetCellColumnLetters(kvp.Key);
                int rowNumber = GetCellRowNumber(kvp.Key);
                if (columnName == sv.Building && rowNumber >= sv.StartingRowNumber && kvp.Value != "") {
                    bool foundMatch = false;
                    for (int BuildingIndex = 0; BuildingIndex < buildings.Count; BuildingIndex++) {
                        if (buildings[BuildingIndex].Abbreviation.ToUpper() == kvp.Value.ToUpper()) {
                            foundMatch = true;
                        }
                    }
                    if (!foundMatch) {
                        //add Building to the database
                        Building newBuilding = new Building();
                        newBuilding.Abbreviation = kvp.Value.ToUpper();
                        newBuilding.Name = "";
                        newBuilding.CampusID = DAL.GetCampusByAbbreviation(spreadsheetData[sv.Campus + rowNumber]);
                        DAL.AddBuilding(newBuilding);
                        buildings.Add(newBuilding);
                    }
                }
            }
        }

        /// <summary>
        /// cycles through the spreadsheet data and creates any missing ca.puses
        /// </summary>
        /// <param name="spreadsheetData"></param>
        private void CreateCampuses(ref Dictionary<string, string> spreadsheetData) {
            List<Campus> campuses = DAL.GetCampuses();
            foreach (KeyValuePair<string, string> kvp in spreadsheetData) {
                string columnName = GetCellColumnLetters(kvp.Key);
                int rowNumber = GetCellRowNumber(kvp.Key);
                if (columnName == sv.Campus && rowNumber >= sv.StartingRowNumber && kvp.Value != "") {
                    bool foundMatch = false;
                    for (int campusIndex = 0; campusIndex < campuses.Count; campusIndex++) {
                        if (campuses[campusIndex].Abbreviation == kvp.Value) {
                            foundMatch = true;
                            campusIndex = campuses.Count;
                        }
                    }
                    if (!foundMatch) {
                        //add campus to fake dal list
                        Campus newCampus = new Campus();
                        newCampus.Abbreviation = kvp.Value;
                        newCampus.Name = "";
                        DAL.AddCampus(newCampus);
                    }
                }
            }
        }

        /// <summary>
        /// gets the row number of a given cell from the spreadsheet data
        /// </summary>
        /// <param name="kvp"></param>
        /// <returns>int rowNumber</returns>
        private int GetCellRowNumber(string cellName) {
            string rowNumberString;
            int rowNumber = 0;
            char[] lettersToTrim = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
            rowNumberString = cellName;
            rowNumberString = rowNumberString.TrimStart(lettersToTrim);
            if (rowNumberString != "") {
                int.TryParse(rowNumberString, out rowNumber);
            }
            return rowNumber;
        }

        /// <summary>
        /// gets the letters of a column of a given cell from the spreadsheet data
        /// </summary>
        /// <param name="kvp"></param>
        /// <returns></returns>
        private string GetCellColumnLetters(string cellName) {
            string columnName;
            char[] numbersToTrim = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
            columnName = cellName;
            columnName = columnName.TrimEnd(numbersToTrim);
            return columnName;
        }

        /// <summary>
        /// cycles through the spreadsheet data and fills the list of sections with the corresponding data
        /// </summary>
        /// <param name="spreadsheetData"></param>
        private void SearchAndCreateSections(ref Dictionary<string, string> spreadsheetData, ref Dictionary<string, List<Section>> sectionComparer) {
            List<Section> sections = DAL.GetSections();
            AcademicSemester spreadsheetSemester = GetAcademicSemesterOnImport(spreadsheetData);
            if (spreadsheetSemester != null) {
                foreach (KeyValuePair<string, string> kvp in spreadsheetData) {
                    string columnName = GetCellColumnLetters(kvp.Key);
                    int rowNumber = GetCellRowNumber(kvp.Key);
                    //TODO get this se up to dynamically find the data not starting at baked values
                    if (columnName == sv.AcademicSemester && rowNumber >= sv.StartingRowNumber && kvp.Value != "") {
                        Section spreadsheetSection = new Section();
                        Course spreadsheetCourse = null;
                        spreadsheetSection.AcademicSemesterID = spreadsheetSemester.ID;
                        int courseNumber = 0;
                        int lastTwoDigits = 0;
                        int.TryParse(spreadsheetData[sv.CourseNumber + rowNumber], out courseNumber);
                        if (courseNumber > 1000 && courseNumber < 10000) {
                            lastTwoDigits = courseNumber % 100;
                            if (lastTwoDigits == 99) {
                                //courses ending in a 99 are experimental and often have multiple titles
                                spreadsheetCourse = DAL.GetCourseByDepartmentNumberAndTitle(spreadsheetData[sv.Department + rowNumber], courseNumber, spreadsheetData[sv.CourseTitle + rowNumber]);
                            }
                            else {
                                //if the course is not experimental to prevent duplicate courses it's checked by department and number only
                                spreadsheetCourse = DAL.GetCourseByDepartmentAndNumber(spreadsheetData[sv.Department + rowNumber], courseNumber);
                            }
                            if (spreadsheetCourse != null) {
                                spreadsheetSection.CourseID = spreadsheetCourse.ID;
                            }
                            spreadsheetSection.Number = spreadsheetData[sv.SectionNumber + rowNumber];
                            List<Section> databaseSections = DAL.CheckForExistingSection(spreadsheetSection.AcademicSemesterID, spreadsheetSection.CourseID, spreadsheetSection.Number);
                            //trimming numbers and letters from the first column to determine the semester and year
                            if (databaseSections.Count == 0) {
                                CreateNewSection(spreadsheetData, rowNumber, ref spreadsheetSection);
                            }
                            else if (databaseSections.Count == 1) {
                                if (CheckSectionChanges(spreadsheetData, rowNumber, databaseSections[0])) {
                                    databaseSections[0].PrimaryInstructor = DAL.GetInstructor(databaseSections[0].PrimaryInstructorID);
                                    databaseSections[0].SecondaryInstructor = DAL.GetInstructor(databaseSections[0].SecondaryInstructorID);
                                    spreadsheetSection = new Section();
                                    spreadsheetSection.ID = databaseSections[0].ID;
                                    spreadsheetSection.AcademicSemesterID = spreadsheetSemester.ID;
                                    spreadsheetSection.CourseID = spreadsheetCourse.ID;
                                    spreadsheetSection.Number = spreadsheetData[sv.SectionNumber + rowNumber];
                                    spreadsheetSection.DateArchived = DateTime.Now;
                                    CreateNewSection(spreadsheetData, rowNumber, ref spreadsheetSection);
                                    sectionComparer["Old Sections"].Add(spreadsheetSection);
                                    sectionComparer["New Sections"].Add(databaseSections[0]);
                                }
                                else if (databaseSections[0].DateDeleted < DateTime.Now) {
                                    ChangeLog changeLogToRevive = DAL.GetChangeLogBySection(databaseSections[0]);
                                    changeLogToRevive.DateDeleted = DAL.MaximumDateTime;
                                    DAL.UpdateChangeLog(changeLogToRevive);
                                    databaseSections[0].DateDeleted = DAL.MaximumDateTime;
                                    DAL.UpdateSection(databaseSections[0]);
                                }
                            }
                            else {
                                if (CheckSectionChanges(spreadsheetData, rowNumber, databaseSections[0])) {
                                    sectionComparer["Old Sections"].Add(databaseSections[0]);
                                    //default to keeping the older section since it was likely the one imported before
                                    databaseSections[1].DateArchived = DateTime.Now;
                                    DAL.UpdateSection(databaseSections[1]);
                                    sectionComparer["New Sections"].Add(databaseSections[1]);
                                }
                                else {
                                    List<InstructorToSection> instructorToSections = DAL.GetInstructorsBySectionID(databaseSections[1].ID);
                                    foreach (InstructorToSection its in instructorToSections) {
                                        DAL.RemoveInstructorToSection(its.ID);
                                    }
                                    List<SectionDay> sectionDays = DAL.GetSectionDaysBySectionID(databaseSections[1].ID);
                                    foreach (SectionDay sd in sectionDays) {
                                        DAL.RemoveSectionDay(sd.ID);
                                    }
                                    ChangeLog changeLogToDelete = DAL.GetChangeLogBySection(databaseSections[1]);
                                    DAL.RemoveChangeLog(changeLogToDelete);
                                    DAL.RemoveSection(databaseSections[1]);
                                }
                            }
                        }
                    }
                }
            }
        }

        /// <summary>
        /// compares the spreadsheet section with the database section
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowNumber"></param>
        private bool CheckSectionChanges(Dictionary<string, string> spreadsheetData, int rowNumber, Section databaseSection) {
            bool foundDifference = false;
            //compare the spreadsheet section with the database section to get differences
            //compares Campus, ScheduleType, MoodleRequired, InstructorApprovalRequired, PartOfTerm, Credits, ClassLimit, Days, Times, Building, Room, Instructors, and Notes
            if (databaseSection.Room != null && (spreadsheetData[sv.Room + rowNumber] != databaseSection.Room.NumberDisplay && spreadsheetData[sv.Building + rowNumber].ToUpper() != "WEB")) {
                foundDifference = true;
            }
            if (databaseSection.Room == null && (spreadsheetData[sv.Room + rowNumber] != "" && spreadsheetData[sv.Building + rowNumber].ToUpper() != "WEB")) {
                foundDifference = true;
            }
            if (databaseSection.ScheduleType != null && spreadsheetData[sv.ScheduleType + rowNumber] != databaseSection.ScheduleType.Abbreviation) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.MoodleRequired + rowNumber] == sv.RequiresMoodleAbbreviation && !databaseSection.RequiresMoodle) {
                foundDifference = true;
            }
            if ((spreadsheetData[sv.MoodleRequired + rowNumber] != sv.RequiresMoodleAbbreviation && databaseSection.RequiresMoodle)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.InstructorApprovalRequired + rowNumber] == sv.RequiresPermissionAbbreviation && !databaseSection.RequiresPermission) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.InstructorApprovalRequired + rowNumber] != sv.RequiresPermissionAbbreviation && databaseSection.RequiresPermission) {
                foundDifference = true;
            }
            if (databaseSection.PartOfTerm != null && spreadsheetData[sv.PartOfTerm + rowNumber] != databaseSection.PartOfTerm.Abbreviation) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.MaximumCredits + rowNumber] == "" && databaseSection.Course.MaximumCredits != 0) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.MinimumCredits + rowNumber] == "" && databaseSection.Course.MinimumCredits != 0) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.FixedCredit + rowNumber] == "" && databaseSection.Course.FixedCredits != 0) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.MaximumCredits + rowNumber] != "" && databaseSection.Course.MaximumCredits == 0) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.MinimumCredits + rowNumber] != "" && databaseSection.Course.MinimumCredits == 0) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.FixedCredit + rowNumber] != "" && databaseSection.Course.FixedCredits == 0) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.ClassLimit + rowNumber] != databaseSection.StudentLimitDisplay) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Monday + rowNumber] != "" && !CheckSectionDayChanges(spreadsheetData[sv.Monday + rowNumber], databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Monday + rowNumber] == "" && CheckSectionDayChanges("M", databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Tuesday + rowNumber] != "" && !CheckSectionDayChanges(spreadsheetData[sv.Tuesday + rowNumber], databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Tuesday + rowNumber] == "" && CheckSectionDayChanges("T", databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Wednesday + rowNumber] != "" && !CheckSectionDayChanges(spreadsheetData[sv.Wednesday + rowNumber], databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Wednesday + rowNumber] == "" && CheckSectionDayChanges("W", databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Thursday + rowNumber] != "" && !CheckSectionDayChanges(spreadsheetData[sv.Thursday + rowNumber], databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Thursday + rowNumber] == "" && CheckSectionDayChanges("R", databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Friday + rowNumber] != "" && !CheckSectionDayChanges(spreadsheetData[sv.Friday + rowNumber], databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Friday + rowNumber] == "" && CheckSectionDayChanges("F", databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Saturday + rowNumber] != "" && !CheckSectionDayChanges(spreadsheetData[sv.Saturday + rowNumber], databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Saturday + rowNumber] == "" && CheckSectionDayChanges("S", databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Sunday + rowNumber] != "" && !CheckSectionDayChanges(spreadsheetData[sv.Sunday + rowNumber], databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.Sunday + rowNumber] == "" && CheckSectionDayChanges("U", databaseSection)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.StartTime + rowNumber] != databaseSection.GetTimeInSpreadsheetFormat(databaseSection.StartTime.TimeOfDay)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.EndTime + rowNumber] != databaseSection.GetTimeInSpreadsheetFormat(databaseSection.EndTime.TimeOfDay)) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.DepartmentComments + rowNumber] != databaseSection.DepartmentComments) {
                foundDifference = true;
            }
            if (spreadsheetData[sv.SectionNotes + rowNumber] != databaseSection.Notes) {
                foundDifference = true;
            }
            if (CheckForInstructorChanges(spreadsheetData, rowNumber, databaseSection)) {
                foundDifference = true;
            }
            return foundDifference;
        }


        /// <summary>
        /// checks if the spreadsheets instructors are the same as the database instructors for a section
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="databaseSection"></param>
        /// <returns></returns>
        private bool CheckForInstructorChanges(Dictionary<string, string> spreadsheetData, int rowNumber, Section databaseSection) {
            bool foundChanges = false;
            foreach (InstructorToSection its in databaseSection.Instructors) {
                if (its.IsPrimary) {
                    if (spreadsheetData[sv.PrimaryInstructorFirstName + rowNumber].ToUpper() != its.Instructor.FirstName.ToUpper()
                    || spreadsheetData[sv.PrimaryInstructorLastName + rowNumber].ToUpper() != its.Instructor.LastName.ToUpper()
                    || (spreadsheetData[sv.PrimaryInstructorTeachingPercentage + rowNumber] != its.TeachingPercentageDisplay 
                    && spreadsheetData[sv.PrimaryInstructorTeachingPercentage + rowNumber] != "")) {
                        foundChanges = true;
                    }
                }
                else {
                    if (spreadsheetData[sv.SecondaryInstructorFirstName + rowNumber].ToUpper() != its.Instructor.FirstName.ToUpper()
                    || spreadsheetData[sv.SecondaryInstructorLastName + rowNumber].ToUpper() != its.Instructor.LastName.ToUpper()
                    || (spreadsheetData[sv.SecondaryInstructorTeachingPercentage + rowNumber] != its.TeachingPercentageDisplay
                    && spreadsheetData[sv.SecondaryInstructorTeachingPercentage + rowNumber] != "")) {
                        foundChanges = true;
                    }
                }
            }
            return foundChanges;
        }


        /// <summary>
        /// checks if a section in the database has an active sectionDay from a day abbreviation
        /// </summary>
        /// <param name="v"></param>
        /// <param name="databaseSection"></param>
        /// <returns></returns>
        private bool CheckSectionDayChanges(string dayAbbreviation, Section databaseSection) {
            bool dayMatchFound = false;
            foreach (Day day in databaseSection.Days) {
                if (day.Abbreviation == dayAbbreviation) {
                    dayMatchFound = true;
                }
            }
            return dayMatchFound;
        }

        /// <summary>
        /// creates a new section on import of a spreadsheet
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowNumber"></param>
        /// <param name="newSection"></param>
        private void CreateNewSection(Dictionary<string, string> spreadsheetData, int rowNumber, ref Section newSection) {
            newSection.XListID = spreadsheetData[sv.CrossListID + rowNumber];
            //gets the room for the section
            GetSectionRoomOnImport(spreadsheetData, rowNumber, newSection);
            //gets the scheduleType for the section
            GetSectionScheduleTypeOnImport(spreadsheetData, rowNumber, newSection);
            if (spreadsheetData[sv.MoodleRequired + rowNumber] == "M") { newSection.RequiresMoodle = true; }
            else { newSection.RequiresMoodle = false; }
            if (spreadsheetData[sv.InstructorApprovalRequired + rowNumber] == "IN") { newSection.RequiresPermission = true; }
            newSection.PartOfTermID = DAL.GetPartOfTermByAbbreviation(spreadsheetData[sv.PartOfTerm + rowNumber]);
            if (spreadsheetData[sv.ClassFeeDetailCode + rowNumber] != "") {
                GetFeeOnImport(spreadsheetData, rowNumber, newSection);
            }
            else {
                newSection.FeeID = -1;
            }
            int studentLimit = 0;
            int.TryParse(spreadsheetData[sv.ClassLimit + rowNumber], out studentLimit);
            newSection.StudentLimit = studentLimit;
            newSection.Notes = spreadsheetData[sv.SectionNotes + rowNumber];
            newSection.DepartmentComments = spreadsheetData[sv.DepartmentComments + rowNumber];
            //gets the start time and end time from the spreadsheet
            GetStartAndEndTimeOnImport(spreadsheetData, rowNumber, newSection);
            //detects if a section is held on a Monday and creates a SectionDay for it if so
            int CRN = 0;
            int.TryParse(spreadsheetData[sv.SectionCRN + rowNumber], out CRN);
            newSection.CRN = CRN;
            AddNewSectionAndChangeLog(spreadsheetData, rowNumber, newSection);
        }

        /// <summary>
        /// adds a new section and changelog to the database
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowNumber"></param>
        /// <param name="newSection"></param>
        private void AddNewSectionAndChangeLog(Dictionary<string, string> spreadsheetData, int rowNumber, Section newSection) {
            newSection.ID = DAL.AddSection(newSection);
            if (newSection.ID > 0) {
                ChangeLog newChangeLog = new ChangeLog();
                newChangeLog.SectionID = newSection.ID;
                newChangeLog.DateCreated = DAL.MinimumDateTime;
                newChangeLog.DateDeleted = DAL.MaximumDateTime;
                newChangeLog.DateImported = DateTime.Now;
                DAL.AddChangeLog(newChangeLog);
                if (spreadsheetData[sv.Monday + rowNumber] != "") { CreateSectionDayOnImport(spreadsheetData, newSection.ID, sv.Monday + rowNumber); }
                if (spreadsheetData[sv.Tuesday + rowNumber] != "") { CreateSectionDayOnImport(spreadsheetData, newSection.ID, sv.Tuesday + rowNumber); }
                if (spreadsheetData[sv.Wednesday + rowNumber] != "") { CreateSectionDayOnImport(spreadsheetData, newSection.ID, sv.Wednesday + rowNumber); }
                if (spreadsheetData[sv.Thursday + rowNumber] != "") { CreateSectionDayOnImport(spreadsheetData, newSection.ID, sv.Thursday + rowNumber); }
                if (spreadsheetData[sv.Friday + rowNumber] != "") { CreateSectionDayOnImport(spreadsheetData, newSection.ID, sv.Friday + rowNumber); }
                if (spreadsheetData[sv.Saturday + rowNumber] != "") { CreateSectionDayOnImport(spreadsheetData, newSection.ID, sv.Saturday + rowNumber); }
                if (spreadsheetData[sv.Sunday + rowNumber] != "") { CreateSectionDayOnImport(spreadsheetData, newSection.ID, sv.Sunday + rowNumber); }
                CreateInstructorToSectionsOnImport(spreadsheetData, rowNumber, newSection, newSection.ID);
            }
        }


        /// <summary>
        /// checks for an existing Fee and creates a new one if no match is found
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowNumber"></param>
        /// <param name="newSection"></param>
        private void GetFeeOnImport(Dictionary<string, string> spreadsheetData, int rowNumber, Section newSection) {
            DetailCode code = DAL.GetDetailCodeByName(spreadsheetData[sv.ClassFeeDetailCode + rowNumber]);
            string amountString = spreadsheetData[sv.ClassFeeAmount + rowNumber];
            float amount;
            float.TryParse(amountString, out amount);
            Fee newFee = DAL.GetFeeByDetailCodeAndAmount(code.ID, amount);
            if (newFee == null) {
                newFee = new Fee();
                newFee.Amount = amount;
                newFee.DetailCodeID = code.ID;
                newFee.ID = DAL.AddFee(newFee);
            }
            newSection.FeeID = newFee.ID;
        }

        /// <summary>
        /// checks for an existing ScheduleType
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowNumber"></param>
        /// <param name="newSection"></param>
        private void GetSectionScheduleTypeOnImport(Dictionary<string, string> spreadsheetData, int rowNumber, Section newSection) {
            if (spreadsheetData[sv.ScheduleType + rowNumber] == "") {
                newSection.ScheduleTypeID = -1;
            }
            else {
                ScheduleType scheduleType = DAL.GetScheduleTypeByAbbreviation(spreadsheetData[sv.ScheduleType + rowNumber]);
                if (scheduleType != null) {
                    newSection.ScheduleTypeID = scheduleType.ID;
                }
                else {
                    newSection.ScheduleTypeID = -1;
                }
            }
        }

        /// <summary>
        /// checks for an existing Room
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowNumber"></param>
        /// <param name="newSection"></param>
        private void GetSectionRoomOnImport(Dictionary<string, string> spreadsheetData, int rowNumber, Section newSection) {
            int roomNumber = 0;
            int.TryParse(spreadsheetData[sv.Room + rowNumber], out roomNumber);
            Room sectionRoom = DAL.GetRoomByNumberAndBuildingAbbreviation(roomNumber, spreadsheetData[sv.Building + rowNumber]);
            if (sectionRoom != null) {
                newSection.RoomID = sectionRoom.ID;
            }
            else {
                newSection.RoomID = -1;
            }
        }

        /// <summary>
        /// checks for StartTime and EndTime
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowNumber"></param>
        /// <param name="newSection"></param>
        private void GetStartAndEndTimeOnImport(Dictionary<string, string> spreadsheetData, int rowNumber, Section newSection) {
            if (spreadsheetData[sv.StartTime + rowNumber] != "") {
                string time = spreadsheetData[sv.StartTime + rowNumber];
                if (time.Length < 4) {
                    time = time.Insert(0, "0");
                }
                time = time.Insert(time.Length - 2, ":");
                DateTime sectionTime = DateTime.ParseExact(time, "HH:mm", CultureInfo.InvariantCulture);
                newSection.StartTime = sectionTime;
            }
            if (spreadsheetData[sv.StartTime + rowNumber] != "") {
                string time = spreadsheetData[sv.EndTime + rowNumber];
                if (time.Length < 4) {
                    time = time.Insert(0, "0");
                }
                time = time.Insert(time.Length - 2, ":");
                DateTime sectionTime = DateTime.ParseExact(time, "HH:mm", CultureInfo.InvariantCulture);
                newSection.EndTime = sectionTime;
            }
        }

        /// <summary>
        /// gets the AcademicSemester for a section
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowNumber"></param>
        /// <param name="newSection"></param>
        private AcademicSemester GetAcademicSemesterOnImport(Dictionary<string, string> spreadsheetData) {
            string academicYearAbbreviation = spreadsheetData[sv.AcademicSemester + sv.StartingRowNumber];
            char[] numbersToTrim = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
            char[] lettersToTrim = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
            string academicSemesterString = academicYearAbbreviation.TrimEnd(numbersToTrim);
            Semester semester = DAL.GetSemesterByAbbreviation(academicSemesterString);
            string academicYearString = academicYearAbbreviation.TrimStart(lettersToTrim);
            string currentYearString = DateTime.Now.ToString("yyyy");
            string currentYearOffsetString = DateTime.Now.ToString("yy");
            int currentYearOffset = int.Parse(currentYearString) - int.Parse(currentYearOffsetString);
            int year = int.Parse(academicYearString) + currentYearOffset;
            AcademicSemester retVal = DAL.GetAcademicSemesterByYearAndSemester(semester.ID, year);
            return retVal;
        }

        /// <summary>
        /// checks for an existing InstructorToSection and creates a new one if no match is found
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowNumber"></param>
        /// <param name="newSection"></param>
        private void CreateInstructorToSectionsOnImport(Dictionary<string, string> spreadsheetData, int rowNumber, Section newSection, int sectionID) {
            if (spreadsheetData[sv.PrimaryInstructorFirstName + rowNumber] != "" && spreadsheetData[sv.PrimaryInstructorLastName + rowNumber] != "") {
                InstructorToSection newInstructorToSection = new InstructorToSection();
                newInstructorToSection.Instructor = DAL.GetInstructorByFirstAndLastName(spreadsheetData[sv.PrimaryInstructorFirstName + rowNumber],
                spreadsheetData[sv.PrimaryInstructorLastName + rowNumber]);
                if (newInstructorToSection.Instructor != null) {
                    newInstructorToSection.SectionID = sectionID;
                    newInstructorToSection.InstructorID = newInstructorToSection.Instructor.ID;
                    newInstructorToSection.IsPrimary = true;
                    int teachingPercent;
                    int.TryParse(spreadsheetData[sv.PrimaryInstructorTeachingPercentage + rowNumber], out teachingPercent);
                    // if a professor is the only one teaching the course is should be 100%
                    if (spreadsheetData[sv.SecondaryInstructorFirstName + rowNumber] == "" && spreadsheetData[sv.SecondaryInstructorLastName + rowNumber] == "") {
                        teachingPercent = 100;
                    }
                    newInstructorToSection.TeachingPercentage = teachingPercent;
                    newSection.PrimaryInstructorID = newInstructorToSection.InstructorID;
                    newSection.PrimaryInstructor = newInstructorToSection.Instructor;
                    DAL.AddInstructorToSection(newInstructorToSection);
                }
            }
            //detects if a secondary instructor is allocated to a section and creates an InstructorToSection if so
            if (spreadsheetData[sv.SecondaryInstructorFirstName + rowNumber] != "" && spreadsheetData[sv.SecondaryInstructorLastName + rowNumber] != "") {
                InstructorToSection newInstructorToSection = new InstructorToSection();
                newInstructorToSection.Instructor = DAL.GetInstructorByFirstAndLastName(spreadsheetData[sv.SecondaryInstructorFirstName + rowNumber],
                spreadsheetData[sv.SecondaryInstructorLastName + rowNumber]);
                if (newInstructorToSection.Instructor != null) {
                    newInstructorToSection.SectionID = sectionID;
                    newInstructorToSection.InstructorID = newInstructorToSection.Instructor.ID;
                    newInstructorToSection.IsPrimary = false;
                    int teachingPercent;
                    int.TryParse(spreadsheetData[sv.SecondaryInstructorTeachingPercentage + rowNumber], out teachingPercent);
                    newInstructorToSection.TeachingPercentage = teachingPercent;
                    newSection.SecondaryInstructorID = newInstructorToSection.InstructorID;
                    newSection.SecondaryInstructor = newInstructorToSection.Instructor;
                    DAL.AddInstructorToSection(newInstructorToSection);
                }
            }
        }

        /// <summary>
        /// creates a SectionDay for a given section
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowNumber"></param>
        /// <param name="sectionID"></param>
        /// <param name="spreadsheetColumn"></param>
        private void CreateSectionDayOnImport(Dictionary<string, string> spreadsheetData, int sectionID, string spreadsheetPosition) {
            SectionDay newSectionDay = new SectionDay();
            newSectionDay.SectionID = sectionID;
            newSectionDay.DayID = DAL.GetDayByAbbreviation(spreadsheetData[spreadsheetPosition]);
            DAL.AddSectionDay(newSectionDay);
        }

        /// <summary>
        /// fills a dictionary with the names of each cell that would be included in an excel spreadsheet with the dimensions given
        /// </summary>
        /// <param name="spreadsheetData"></param>
        /// <param name="rowCount">the number of rows detected on the spreadsheet</param>
        /// <param name="colCount">the number of columns detected on the spreadsheet</param>
        private void FillDictionaryKeys(Dictionary<string, string> spreadsheetData, int rowCount, int colCount) {
            int letterIndex = 65;
            int letter2Index = 65;
            for (int rowIndex = 1; rowIndex <= rowCount; rowIndex++) {
                bool doubleDigitColumns = false;
                letterIndex = 65;
                letter2Index = 65;
                for (int colIndex = 1; colIndex <= colCount; colIndex++) {
                    char letter = FindCharFromInt(letterIndex);
                    char letter2 = FindCharFromInt(letter2Index);
                    if (doubleDigitColumns) {
                        if (!spreadsheetData.ContainsKey(letter + "" + letter2 + "" + rowIndex)) {
                            spreadsheetData.Add(letter + "" + letter2 + "" + rowIndex, "");
                        }
                    }
                    else {
                        if (!spreadsheetData.ContainsKey(letter + "" + rowIndex)) {
                            spreadsheetData.Add(letter + "" + rowIndex, "");
                        }
                    }
                    if (!doubleDigitColumns) {
                        letterIndex++;
                    }
                    else {
                        letter2Index++;
                    }
                    //resets the char values to A if they reach Z
                    if (letterIndex > 90 || letter2Index > 90) {
                        letterIndex = 65;
                        letter2Index = 65;
                        doubleDigitColumns = true;
                    }
                }
            }
        }

        /// <summary>
        /// gets a character given its bit value represented as an integer
        /// </summary>
        /// <param name="bitValue"></param>
        /// <returns></returns>
        private char FindCharFromInt(int bitValue) {
            return (char)bitValue;
        }

        /// <summary>
        /// exports a table of data to an excel document
        /// </summary>
        /// <returns></returns>
        public IActionResult ExportToExcel() {
            User currentUser = SessionVariables.GetCurrentUser(HttpContext);
            if (currentUser != null && currentUser.Role != null && currentUser.Role.Spreadsheets.CanView) {
                string webRoot = _Environment.WebRootPath;
                AcademicSemester academicSemester = SessionVariables.GetSessionAcademicSemester(HttpContext);
                List<Section> sections = DAL.GetSectionsByAcademicSemesterID(academicSemester.ID, true);
                ExcelPackage package = new ExcelPackage(new FileInfo(webRoot + "\\currentSheet.xlsx"));
                ExcelWorksheet worksheet = package.Workbook.Worksheets[1];
                //checks if the section has a new Department/Subject to insert a spacer
                if (sections.Count == 0) {
                    SessionVariables.SetErrorMessage("Nothing to export for the selected academic semester");
                    return RedirectToAction("index");
                }
                Department departmentDivider = sections[0].Course.Department;
                worksheet.DeleteRow(4, worksheet.Dimension.Rows);
                if (package != null) {
                    Color grayColor = System.Drawing.ColorTranslator.FromHtml("#B1B1B1");
                    int startingRowCount = sv.StartingRowNumber;
                    for (int sectionIndex = 0; sectionIndex < sections.Count; sectionIndex++) {
                        if (departmentDivider.Abbreviation != sections[sectionIndex].Course.Department.Abbreviation) {
                            worksheet.InsertRow(sectionIndex + startingRowCount, 1);
                            worksheet.Row(sectionIndex + startingRowCount).Style.Fill.PatternType = ExcelFillStyle.Solid;
                            worksheet.Row(sectionIndex + startingRowCount).Style.Fill.BackgroundColor.SetColor(grayColor);
                            departmentDivider = sections[sectionIndex].Course.Department;
                            startingRowCount++;
                        }
                        ChangeLog changeLog = DAL.GetChangeLogBySection(sections[sectionIndex]);
                        if (changeLog != null) {
                            DetectChanges(ref sections, worksheet, startingRowCount + sectionIndex, changeLog);
                            FillCellData(sections, worksheet, startingRowCount, sectionIndex);
                        }
                    }
                    int year = sections[0].AcademicSemester.AcademicYear % 100;
                    string semesterAbrev = sections[0].AcademicSemester.Semester.Abbreviation;
                    string academicSemesterAbbreviation = semesterAbrev + year;
                    OutlineCells(worksheet);
                    FormatFontAndCenter(worksheet);
                    //adds the package file to the downloads folder
                    byte[] fileContents = package.GetAsByteArray();
                    string pathUser = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
                    string pathDownload = Path.Combine(pathUser, "Downloads\\");
                    return File(
                    fileContents: fileContents,
                    contentType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                    fileDownloadName: academicSemesterAbbreviation + "ScheduleFinal.xlsx");
                }
                else {
                    return NotFound();
                }
            }
            else {
                SessionVariables.SetErrorMessage("You do not have permission to view spreadsheet data");
                return RedirectToAction("Index", "Section");
            }
        }

        /// <summary>
        /// applies the proper cell font size and centering
        /// </summary>
        /// <param name="worksheet"></param>
        private void FormatFontAndCenter(ExcelWorksheet worksheet) {
            foreach (ExcelRangeBase cell in worksheet.Cells) {
                string cellLetter = GetCellColumnLetters(cell.Address);
                int cellRow = GetCellRowNumber(cell.Address);
                if (cellRow >= sv.StartingRowNumber) {
                    cell.Style.Font.SetFromFont(new Font(sv.DefaultFontStyle, sv.DefaultFontSize));
                    if (cellLetter != sv.SectionNotes && cellLetter != sv.DepartmentComments && cellLetter != sv.CourseTitle) {
                        cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    }
                }
            }
        }

        /// <summary>
        /// fills a row of a worksheet with data
        /// </summary>
        private void FillCellData(List<Section> sections, ExcelWorksheet worksheet, int startingRowCount, int sectionIndex) {
            int rowIndex = startingRowCount + sectionIndex;
            int year = sections[sectionIndex].AcademicSemester.AcademicYear % 100;
            string semesterAbrev = sections[sectionIndex].AcademicSemester.Semester.Abbreviation;
            worksheet.Cells[sv.AcademicSemester + rowIndex].Value = semesterAbrev + year;
            if (sections[sectionIndex].CRN != 0) {
                worksheet.Cells[sv.SectionCRN + rowIndex].Value = sections[sectionIndex].CRN;
            }
            worksheet.Cells[sv.Department + rowIndex].Value = sections[sectionIndex].Course.Department.Abbreviation;
            worksheet.Cells[sv.CourseNumber + rowIndex].Value = sections[sectionIndex].Course.Number;
            if (int.TryParse(sections[sectionIndex].Number, out int sectionNumber)) {
                //formats the cell as a number since it is just a number
                worksheet.Cells[sv.SectionNumber + rowIndex].Value = sectionNumber;
            }
            else {
                //formats the cell as a string since it couldn't be parsed
                worksheet.Cells[sv.SectionNumber + rowIndex].Value = sections[sectionIndex].Number;
            }
            worksheet.Cells[sv.CrossListID + rowIndex].Value = sections[sectionIndex].XListID;
            worksheet.Cells[sv.CourseTitle + rowIndex].Value = sections[sectionIndex].Course.Title;
            if (sections[sectionIndex].Room != null && sections[sectionIndex].Room.Building != null && sections[sectionIndex].Room.Building.CampusID != -1 && sections[sectionIndex].Room.Building.Campus.Abbreviation != null) {
                worksheet.Cells[sv.Campus + rowIndex].Value = sections[sectionIndex].Room.Building.Campus.Abbreviation;
            }
            else {
                worksheet.Cells[sv.Campus + rowIndex].Value = "PC";
            }
            worksheet.Cells[sv.ScheduleType + rowIndex].Value = sections[sectionIndex].ScheduleType.Abbreviation;
            if (sections[sectionIndex].RequiresMoodle) {
                worksheet.Cells[sv.MoodleRequired + rowIndex].Value = "M";
            }
            if (sections[sectionIndex].RequiresPermission) {
                worksheet.Cells[sv.InstructorApprovalRequired + rowIndex].Value = "IN";
            }
            worksheet.Cells[sv.PartOfTerm + rowIndex].Value = sections[sectionIndex].PartOfTerm.Abbreviation;
            if (sections[sectionIndex].Course.IsFixedCredit) {
                worksheet.Cells[sv.FixedCredit + rowIndex].Value = sections[sectionIndex].Course.FixedCredits;
            }
            else {
                worksheet.Cells[sv.MinimumCredits + rowIndex].Value = sections[sectionIndex].Course.MinimumCredits;
                worksheet.Cells[sv.MaximumCredits + rowIndex].Value = sections[sectionIndex].Course.MaximumCredits;
            }
            worksheet.Cells[sv.ClassLimit + rowIndex].Value = sections[sectionIndex].StudentLimit;
            foreach (Day day in sections[sectionIndex].Days) {

            }
            foreach (Day day in sections[sectionIndex].Days) {
                FillCellsForDay(worksheet, rowIndex, day);
            }
            int startTimeInt = 0;
            int endTimeInt = 0;
            string startTime = sections[sectionIndex].StartTime.ToString("HH:mm").Remove(2, 1);
            string endTime = sections[sectionIndex].EndTime.ToString("HH:mm").Remove(2, 1);
            int.TryParse(startTime, out startTimeInt);
            int.TryParse(endTime, out endTimeInt);
            if (startTimeInt == 0) {
                worksheet.Cells[sv.StartTime + rowIndex].Value = "";
            }
            else {
                worksheet.Cells[sv.StartTime + rowIndex].Value = startTimeInt;
            }
            if (startTimeInt == 0) {
                worksheet.Cells[sv.EndTime + rowIndex].Value = "";
            }
            else {
                worksheet.Cells[sv.EndTime + rowIndex].Value = endTimeInt;
            }
            if (sections[sectionIndex].Room != null) {
                worksheet.Cells[sv.Building + rowIndex].Value = sections[sectionIndex].Room.Building.Abbreviation;
            }
            if (sections[sectionIndex].Room != null && sections[sectionIndex].Room.Number != 0) {
                worksheet.Cells[sv.Room + rowIndex].Value = sections[sectionIndex].Room.Number;
            }
            if (sections[sectionIndex].Room != null && sections[sectionIndex].Room.Building.Abbreviation == "WEB") {
                worksheet.Cells[sv.Room + rowIndex].Value = "COURSE";
            }
            if (sections[sectionIndex].Instructors.Count != 0) {
                FillCellDataForInstructors(sections, worksheet, sectionIndex, rowIndex);
            }
            if (sections[sectionIndex].Fee != null) {
                worksheet.Cells[sv.ClassFeeDetailCode + rowIndex].Value = sections[sectionIndex].Fee.DetailCode.Name;
                worksheet.Cells[sv.ClassFeeAmount + rowIndex].Value = sections[sectionIndex].Fee.Amount;
            }
            worksheet.Cells[sv.ClassFeeAmount + rowIndex].Style.Numberformat.Format = "$#,##0.00";
            worksheet.Cells[sv.SectionNotes + rowIndex].Value = sections[sectionIndex].Notes;
            //worksheet.Cells[sv.CrossListCourseNumber + rowIndex].Value = sections[sectionIndex].;
            //worksheet.Cells[sv.CrossListSubject + rowIndex].Value = sections[sectionIndex].;
            worksheet.Cells[sv.DepartmentComments + rowIndex].Value = sections[sectionIndex].DepartmentComments;
        }

        /// <summary>
        /// fills the instructor sections of a given worksheet row with the instructor information
        /// </summary>
        /// <param name="sections"></param>
        /// <param name="worksheet"></param>
        /// <param name="sectionIndex"></param>
        /// <param name="rowIndex"></param>
        private void FillCellDataForInstructors(List<Section> sections, ExcelWorksheet worksheet, int sectionIndex, int rowIndex) {
            foreach (InstructorToSection instructorToSection in sections[sectionIndex].Instructors) {
                if (instructorToSection.IsPrimary) {
                    worksheet.Cells[sv.PrimaryInstructorFirstName + rowIndex].Value = instructorToSection.Instructor.FirstName;
                    worksheet.Cells[sv.PrimaryInstructorLastName + rowIndex].Value = instructorToSection.Instructor.LastName;
                    if (instructorToSection.Instructor.Number != 0) {
                        worksheet.Cells[sv.PrimaryInstructorNumber + rowIndex].Value = instructorToSection.Instructor.Number;
                    }
                    if (instructorToSection.TeachingPercentage != 0) {
                        worksheet.Cells[sv.PrimaryInstructorTeachingPercentage + rowIndex].Value = instructorToSection.TeachingPercentage;
                    }
                }
                else {
                    worksheet.Cells[sv.SecondaryInstructorFirstName + rowIndex].Value = instructorToSection.Instructor.FirstName;
                    worksheet.Cells[sv.SecondaryInstructorLastName + rowIndex].Value = instructorToSection.Instructor.LastName;
                    if (instructorToSection.Instructor.Number != 0) {
                        worksheet.Cells[sv.SecondaryInstructorNumber + rowIndex].Value = instructorToSection.Instructor.Number;
                    }
                    if (instructorToSection.TeachingPercentage != 0) {
                        worksheet.Cells[sv.SecondaryInstructorTeachingPercentage + rowIndex].Value = instructorToSection.TeachingPercentage;
                    }
                }
            }
        }

        /// <summary>
        /// fills a cell corresponding to a given day and row in a worksheet
        /// </summary>
        /// <param name="worksheet"></param>
        /// <param name="rowIndex"></param>
        /// <param name="day"></param>
        private void FillCellsForDay(ExcelWorksheet worksheet, int rowIndex, Day day) {
            if (day.Name == "Monday") {
                worksheet.Cells[sv.Monday + rowIndex].Value = day.Abbreviation;
            }
            else if (day.Name == "Tuesday") {
                worksheet.Cells[sv.Tuesday + rowIndex].Value = day.Abbreviation;
            }
            else if (day.Name == "Wednesday") {
                worksheet.Cells[sv.Wednesday + rowIndex].Value = day.Abbreviation;
            }
            else if (day.Name == "Thursday") {
                worksheet.Cells[sv.Thursday + rowIndex].Value = day.Abbreviation;
            }
            else if (day.Name == "Friday") {
                worksheet.Cells[sv.Friday + rowIndex].Value = day.Abbreviation;
            }
            else if (day.Name == "Saturday") {
                worksheet.Cells[sv.Saturday + rowIndex].Value = day.Abbreviation;
            }
            else if (day.Name == "Sunday") {
                worksheet.Cells[sv.Sunday + rowIndex].Value = day.Abbreviation;
            }
        }


        /// <summary>
        /// Detects changes and highlights rows/cells that are changed
        /// </summary>
        private void DetectChanges(ref List<Section> sections, ExcelWorksheet worksheet, int currentRow, ChangeLog changeLog) {
            Color yellowColor = System.Drawing.ColorTranslator.FromHtml("#FFFF00");
            bool changeMade = false;

            if (changeLog.DateCreated > changeLog.DateImported) {
                worksheet.Row(currentRow).Style.Fill.PatternType = ExcelFillStyle.Solid;
                worksheet.Row(currentRow).Style.Fill.BackgroundColor.SetColor(yellowColor);
                worksheet.Cells[sv.AddChangeDelete + (currentRow)].Value = "Add";
            }
            else if (changeLog.DateDeleted == changeLog.DateCreated) {
                //the section was created after the import and then deleted so it shouldn't show on the spreadsheet at allchang
                int sectionToRemove = DAL.GetSection(changeLog.SectionID).ID;
                sections.RemoveAll(sec => sec.ID == sectionToRemove);
            }
            else if (changeLog.DateDeleted < DateTime.Now) {
                worksheet.Row(currentRow).Style.Fill.PatternType = ExcelFillStyle.Solid;
                worksheet.Row(currentRow).Style.Fill.BackgroundColor.SetColor(yellowColor);
                worksheet.Cells[sv.AddChangeDelete + (currentRow)].Value = "Delete";
            }
            else {
                changeMade = FindSectionChanges(worksheet, currentRow, changeMade, changeLog);
                changeMade = FindCourseChanges(worksheet, currentRow, changeMade, changeLog);
                changeMade = FindLocationChanges(worksheet, currentRow, changeMade, changeLog);
                changeMade = FindTypeChanges(worksheet, currentRow, changeMade, changeLog);
                changeMade = FindBoolChanges(worksheet, currentRow, changeMade, changeLog);
                changeMade = FindCreditChanges(worksheet, currentRow, changeMade, changeLog);
                changeMade = FindDayChanges(worksheet, currentRow, changeMade, changeLog);
                changeMade = FindTimeChanges(worksheet, currentRow, changeMade, changeLog);
                changeMade = FindInstructorChanges(worksheet, currentRow, changeMade, changeLog);
                changeMade = FindNoteChanges(worksheet, currentRow, changeMade, changeLog);
                if (changeMade) {
                    changeMade = AddColorFormatting(worksheet, currentRow, sv.AddChangeDelete);
                    worksheet.Cells[sv.AddChangeDelete + (currentRow)].Value = "Change";
                }
            }
        }

        /// <summary>
        /// Determines if changes were made the the Notes or DepartmentComments and adds highlighting if so
        /// </summary>
        /// <returns>true if changes made to Notes or DepartmentComments</returns>
        private bool FindNoteChanges(ExcelWorksheet worksheet, int currentRow, bool changeMade, ChangeLog changeLog) {
            if (changeLog.ChangedSectionNotes) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.SectionNotes);
            }
            if (changeLog.ChangedDepartmentComments) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.DepartmentComments);
            }
            return changeMade;
        }

        /// <summary>
        /// Determines if changes were made the the Instructor and adds highlighting if so
        /// </summary>
        /// <returns>true if changes made to Instructor</returns>
        private bool FindInstructorChanges(ExcelWorksheet worksheet, int currentRow, bool changeMade, ChangeLog changeLog) {
            if (changeLog.ChangedPrimeInstructor) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.PrimaryInstructorFirstName);
                changeMade = AddColorFormatting(worksheet, currentRow, sv.PrimaryInstructorLastName);
                changeMade = AddColorFormatting(worksheet, currentRow, sv.PrimaryInstructorNumber);
                changeMade = AddColorFormatting(worksheet, currentRow, sv.PrimaryInstructorTeachingPercentage);
            }
            if (changeLog.ChangedSecondInstructor) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.SecondaryInstructorFirstName);
                changeMade = AddColorFormatting(worksheet, currentRow, sv.SecondaryInstructorLastName);
                changeMade = AddColorFormatting(worksheet, currentRow, sv.SecondaryInstructorNumber);
                changeMade = AddColorFormatting(worksheet, currentRow, sv.SecondaryInstructorTeachingPercentage);
            }
            return changeMade;
        }

        /// <summary>
        /// Determines if changes were made the the Times and adds highlighting if so
        /// </summary>
        /// <returns>true if changes made to Times</returns>
        private bool FindTimeChanges(ExcelWorksheet worksheet, int currentRow, bool changeMade, ChangeLog changeLog) {
            if (changeLog.ChangedStartTime) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.StartTime);
            }
            if (changeLog.ChangedEndTime) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.EndTime);
            }
            return changeMade;
        }

        /// <summary>
        /// Determines if changes were made the the Days and adds highlighting if so
        /// </summary>
        /// <returns>true if changes made to Days</returns>
        private bool FindDayChanges(ExcelWorksheet worksheet, int currentRow, bool changeMade, ChangeLog changeLog) {
            if (changeLog.ChangedMonday) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Monday);
            }
            if (changeLog.ChangedTuesday) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Tuesday);
            }
            if (changeLog.ChangedWednesday) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Wednesday);
            }
            if (changeLog.ChangedThursday) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Thursday);
            }
            if (changeLog.ChangedFriday) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Friday);
            }
            if (changeLog.ChangedSaturday) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Saturday);
            }
            if (changeLog.ChangedSunday) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Sunday);
            }
            return changeMade;
        }

        private bool AddColorFormatting(ExcelWorksheet worksheet, int currentRow, string cellColumnName) {
            Color yellowColor = System.Drawing.ColorTranslator.FromHtml("#FFFF00");
            worksheet.Cells[cellColumnName + currentRow].Style.Fill.PatternType = ExcelFillStyle.Solid;
            worksheet.Cells[cellColumnName + currentRow].Style.Fill.BackgroundColor.SetColor(yellowColor);
            return true;
        }

        /// <summary>
        /// Determines if changes were made the the Credits and adds highlighting if so
        /// </summary>
        /// <returns>true if changes made to Credits</returns>
        private bool FindCreditChanges(ExcelWorksheet worksheet, int currentRow, bool changeMade, ChangeLog changeLog) {
            if (changeLog.ChangedFixedCredit) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.FixedCredit);
            }
            if (changeLog.ChangedMinCredits) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.MinimumCredits);
            }
            if (changeLog.ChangedMaxCredits) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.MaximumCredits);
            }
            return changeMade;
        }

        /// <summary>
        /// Determines if changes were made the the Course.Number, Course.Title, or Subject and adds highlighting if so
        /// </summary>
        /// <returns>true if changes made to Course.Number, Course.Title, or Subject</returns>
        private bool FindCourseChanges(ExcelWorksheet worksheet, int currentRow, bool changeMade, ChangeLog changeLog) {
            if (changeLog.ChangedDepartment) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Department);
            }
            if (changeLog.ChangedCourseNumber) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.CourseNumber);
            }
            if (changeLog.ChangedTitle) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.CourseTitle);
            }
            return changeMade;
        }

        /// <summary>
        /// Determines if changes were made the the RequiresMoodle or RequiresPermission and adds highlighting if so
        /// </summary>
        /// <returns>true if changes made to RequiresMoodle or RequiresPermission</returns>
        private bool FindBoolChanges(ExcelWorksheet worksheet, int currentRow, bool changeMade, ChangeLog changeLog) {
            if (changeLog.ChangedMoodleRequired) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.MoodleRequired);
            }
            if (changeLog.ChangedInstructorApproval) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.InstructorApprovalRequired);
            }
            return changeMade;
        }

        /// <summary>
        /// Determines if changes were made the the Campus,Building or Room and adds highlighting if so
        /// </summary>
        /// <returns>true if changes made to Campus,Building or Room</returns>
        private bool FindLocationChanges(ExcelWorksheet worksheet, int currentRow, bool changeMade, ChangeLog changeLog) {
            if (changeLog.ChangedCampus) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Campus);
            }
            if (changeLog.ChangedBuilding) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Building);
            }
            if (changeLog.ChangedRoom) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.Room);
            }
            return changeMade;
        }

        /// <summary>
        /// Determines if changes were made the the ScheduleType or PartOfTerm and adds highlighting if so
        /// </summary>
        /// <returns>true if changes made to ScheduleType or PartOfTerm</returns>
        private bool FindTypeChanges(ExcelWorksheet worksheet, int currentRow, bool changeMade, ChangeLog changeLog) {
            if (changeLog.ChangedScheduleType) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.ScheduleType);
            }
            if (changeLog.ChangedPartOfTerm) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.PartOfTerm);
            }
            return changeMade;
        }

        /// <summary>
        /// Determines if changes were made the the CRN or Section.Number and adds highlighting if so
        /// </summary>
        /// <returns>true if changes made to CRN or Section.Number</returns>
        private bool FindSectionChanges(ExcelWorksheet worksheet, int currentRow, bool changeMade, ChangeLog changeLog) {
            if (changeLog.ChangedSectionNumber) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.SectionNumber);
            }
            if (changeLog.ChangedStudentLimit) {
                changeMade = AddColorFormatting(worksheet, currentRow, sv.ClassLimit);
            }
            return changeMade;
        }

        /// <summary>
        /// outlines all cells in a worksheet with a thin boarder
        /// </summary>
        private void OutlineCells(ExcelWorksheet worksheet) {
            Dictionary<string, string> cellNames = new Dictionary<string, string>();
            FillDictionaryKeys(cellNames, worksheet.Dimension.Rows, worksheet.Dimension.Columns);
            foreach (KeyValuePair<string, string> kvp in cellNames) {
                worksheet.Cells[kvp.Key].Style.Border.BorderAround(ExcelBorderStyle.Thin);
            }
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error() {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public void SelectAcademicSemester(int currentSemesterID, int currentYear) {
            SessionVariables.SetSessionAcademicSemesterID(HttpContext, DAL.GetAcademicSemesterByYearAndSemester(currentSemesterID, currentYear).ID);
        }
        
        public bool SectionCompare(int sectionID) {
            Section sectionToSave = DAL.GetSection(sectionID);
            if (sectionToSave != null) {
                List<Section> sectionsToPick = DAL.CheckForExistingSection(sectionToSave.AcademicSemesterID, sectionToSave.CourseID, sectionToSave.Number);
                foreach (Section sectionOption in sectionsToPick) {
                    if (sectionOption.ID != sectionID) {
                        List<InstructorToSection> instructorToSections = DAL.GetInstructorsBySectionID(sectionOption.ID, true);
                        foreach (InstructorToSection its in instructorToSections) {
                            DAL.RemoveInstructorToSection(its.ID);
                        }
                        List<SectionDay> sectionDays = DAL.GetSectionDaysBySectionID(sectionOption.ID, true);
                        foreach (SectionDay sd in sectionDays) {
                            DAL.RemoveSectionDay(sd.ID);
                        }
                        ChangeLog changeLogToDelete = DAL.GetChangeLogBySection(sectionOption);
                        DAL.RemoveChangeLog(changeLogToDelete);
                        DAL.RemoveSection(sectionOption);
                    }
                    else {
                        sectionOption.DateArchived = DAL.MaximumDateTime;
                        DAL.UpdateSection(sectionOption);
                    }
                }
                return true;
            }
            return false;
        }
    }
}
