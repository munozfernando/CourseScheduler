$(document).ready(function () {
    FixedCreditToggle();
    CrossListedToggle();
    CrossScheduledToggle();
    CheckForCrossListedCourseNumbers();
    $("#CrossListedDepartmentID").on("change", CheckForCrossListedCourseNumbers);
    CheckForCrossScheduledCourseNumbers();
    $("#CrossScheduledDepartmentID").on("change", CheckForCrossScheduledCourseNumbers);
});

//toggles the fixed credits and varied credits on the course create
function FixedCreditToggle() {
    var fixedCredits = document.getElementById("divFixedCredits");
    var variedCredits = document.getElementById("divVariedCredits");
    var isFixedCheck = document.getElementById("IsFixedCredit");
    if (isFixedCheck.checked) {
        variedCredits.hidden = true;
        fixedCredits.hidden = false;
    }
    else {
        variedCredits.hidden = false;
        fixedCredits.hidden = true;
    }
    $(isFixedCheck).on("change", function () {
        if (isFixedCheck.checked) {
            variedCredits.hidden = true;
            fixedCredits.hidden = false;
        }
        else {
            variedCredits.hidden = false;
            fixedCredits.hidden = true;
        }
    });
}

//toggles cross listed course
function CrossListedToggle() {
    var isCrossListed = document.getElementById("IsCrossListed");
    var courseSelect = document.getElementById("divCrossListedSelect");
    if (isCrossListed.checked) {
        courseSelect.hidden = false;
    }
    else {
        courseSelect.hidden = true;
    }
    $(isCrossListed).on("change", function () {
        if (isCrossListed.checked) {
            courseSelect.hidden = false;
        }
        else {
            courseSelect.hidden = true;
        }
    });
}

//Checks if courses exist with the entered data and gives an error indicating to create a course
function CheckForCrossListedCourseNumbers() {
    var departmentID = $("#CrossListedDepartmentID").val();
    var courseIDGet = $("#CrossListedCourseID").val();
    $.ajax({
        type: "GET",
        url: document.getElementById("actionUpdateCrossListedCourse").href,
        data: {
            "departmentID": departmentID
        },
        success: function (response) {
            $("#CrossListedCourseID").empty();
            var selectedIndex = -1;
            for (var courseIndex = 0; courseIndex < response.length; courseIndex++) {
                var option = option = '<option value="' + response[courseIndex].id + '">' + response[courseIndex].numberAndTitle + '</option>';
                var indexID = response[courseIndex].id + "";
                var courseID = courseIDGet + "";
                if (indexID === courseID) {
                    selectedIndex = indexID;
                }
                $("#CrossListedCourseID").append(option);
            }
            $("#CrossListedCourseID").val(selectedIndex);
            $("#CrossListedCourseID").trigger("chosen:updated");
            if (!response) {
                alert("Selected course doesn't exist please change the selected values or create a new one.");
            }
        },
        failure: function (response) {
            alert("Something went wrong checking for course");
        }
    });
}

//toggles cross Scheduled course
function CrossScheduledToggle() {
    var isCrossScheduled = document.getElementById("IsCrossScheduled");
    var courseSelect = document.getElementById("divCrossScheduledSelect");
    if (isCrossScheduled.checked) {
        courseSelect.hidden = false;
    }
    else {
        courseSelect.hidden = true;
    }
    $(isCrossScheduled).on("change", function () {
        if (isCrossScheduled.checked) {
            courseSelect.hidden = false;
        }
        else {
            courseSelect.hidden = true;
        }
    });
}

//Checks if courses exist with the entered data and gives an error indicating to create a course
function CheckForCrossScheduledCourseNumbers() {
    var departmentID = $("#CrossScheduledDepartmentID").val();
    var courseIDGet = $("#CrossScheduledCourseID").val();
    $.ajax({
        type: "GET",
        url: document.getElementById("actionUpdateCrossScheduledCourse").href,
        data: {
            "departmentID": departmentID
        },
        success: function (response) {
            $("#CrossScheduledCourseID").empty();
            var selectedIndex = -1;
            for (var courseIndex = 0; courseIndex < response.length; courseIndex++) {
                var option = option = '<option value="' + response[courseIndex].id + '">' + response[courseIndex].numberAndTitle + '</option>';
                var indexID = response[courseIndex].id + "";
                var courseID = courseIDGet + "";
                if (indexID === courseID) {
                    selectedIndex = indexID;
                }
                $("#CrossScheduledCourseID").append(option);
            }
            $("#CrossScheduledCourseID").val(selectedIndex);
            $("#CrossScheduledCourseID").trigger("chosen:updated");
            if (!response) {
                alert("Selected course doesn't exist please change the selected values or create a new one.");
            }
        },
        failure: function (response) {
            alert("Something went wrong checking for course");
        }
    });
}