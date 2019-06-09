var daysChecked = 0;
var miltime = false;
var tempHeldIndex = $("#SecondaryInstructorID").val();

$(document).ready(function () {
    SetDayCheckboxClicks();
    var dayChecks = document.getElementsByClassName("inputDayOptions");
    for (var dayIndex = 0; dayIndex < dayChecks.length; dayIndex++) {
        if (dayChecks[dayIndex].checked) {
            daysChecked++;
        }
    }
    CheckForCourseNumbers();
    $("#Course_DepartmentID").on("change", CheckForCourseNumbers);
    PrimaryInstructorChanged();
    $("#PrimaryInstructorID").on("change", PrimaryInstructorChanged);
});


function SetTime() {
    var radioButtons = document.getElementsByClassName("radioTimePicker");
    for (var radioIndex = 0; radioIndex < radioButtons.length; radioIndex++) {
        if (radioButtons[radioIndex].checked) {
            var value = radioButtons[radioIndex].value;
            if (value === "Time Slot 1-1") {
                document.getElementById('StartTime').value = '16:00';
                document.getElementById('EndTime').value = '18:45';
            }
            else if (value === "Time Slot 1-2") {
                document.getElementById('StartTime').value = '18:00';
                document.getElementById('EndTime').value = '20:45';
            }
            else if (value === "Time Slot 2-1") {
                document.getElementById('StartTime').value = '08:00';
                document.getElementById('EndTime').value = '09:15';
            }
            else if (value === "Time Slot 2-2") {
                document.getElementById('StartTime').value = '09:30';
                document.getElementById('EndTime').value = '10:45';
            }
            else if (value === "Time Slot 2-3") {
                document.getElementById('StartTime').value = '11:00';
                document.getElementById('EndTime').value = '12:15';
            }
            else if (value === "Time Slot 2-4") {
                document.getElementById('StartTime').value = '13:00';
                document.getElementById('EndTime').value = '14:15';
            }
            else if (value === "Time Slot 2-5") {
                document.getElementById('StartTime').value = '13:30';
                document.getElementById('EndTime').value = '14:45';
            }
            else if (value === "Time Slot 2-6") {
                document.getElementById('StartTime').value = '14:30';
                document.getElementById('EndTime').value = '15:45';
            }
            else if (value === "Time Slot 2-7") {
                document.getElementById('StartTime').value = '15:00';
                document.getElementById('EndTime').value = '16:15';
            }
            else if (value === "Time Slot 3-1") {
                document.getElementById('StartTime').value = '08:00';
                document.getElementById('EndTime').value = '08:50';
            }
            else if (value === "Time Slot 3-2") {
                document.getElementById('StartTime').value = '09:00';
                document.getElementById('EndTime').value = '09:50';
            }
            else if (value === "Time Slot 3-3") {
                document.getElementById('StartTime').value = '10:00';
                document.getElementById('EndTime').value = '10:50';
            }
            else if (value === "Time Slot 3-4") {
                document.getElementById('StartTime').value = '11:00';
                document.getElementById('EndTime').value = '11:50';
            }
            else if (value === "Time Slot 3-5") {
                document.getElementById('StartTime').value = '13:00';
                document.getElementById('EndTime').value = '13:50';
            }
        }
    }
}

function SetDaysChecked() {
    daysChecked = 0;
    var dayChecks = document.getElementsByClassName("inputDayOptions");
    for (var dayIndex = 0; dayIndex < dayChecks.length; dayIndex++) {
        if (dayChecks[dayIndex].checked) {
            daysChecked++;
        }
    }
    if (daysChecked === 1) {
        document.getElementById("divTimeSlotsUnknown").hidden = true;
        document.getElementById("divTimeSlotsOneDay").hidden = false;
        document.getElementById("divTimeSlotsTwoDays").hidden = true;
        document.getElementById("divTimeSlotsThreeDays").hidden = true;
    }
    else if (daysChecked === 2) {
        document.getElementById("divTimeSlotsUnknown").hidden = true;
        document.getElementById("divTimeSlotsOneDay").hidden = true;
        document.getElementById("divTimeSlotsTwoDays").hidden = false;
        document.getElementById("divTimeSlotsThreeDays").hidden = true;
    }
    else if (daysChecked === 3) {
        document.getElementById("divTimeSlotsUnknown").hidden = true;
        document.getElementById("divTimeSlotsOneDay").hidden = true;
        document.getElementById("divTimeSlotsTwoDays").hidden = true;
        document.getElementById("divTimeSlotsThreeDays").hidden = false;
    }
    else {
        document.getElementById("divTimeSlotsUnknown").hidden = false;
        document.getElementById("divTimeSlotsOneDay").hidden = true;
        document.getElementById("divTimeSlotsTwoDays").hidden = true;
        document.getElementById("divTimeSlotsThreeDays").hidden = true;
    }
}

function SetDayCheckboxClicks() {
    var checks = document.getElementsByClassName("checkmark");
    $(checks).on("click", function (event) {
        var day = $(event.target).siblings()[0].name;
        var daySpans = document.getElementsByClassName("checkmark");
        if (day === "Monday") {
            if (!$(daySpans[2]).siblings()[0].checked && !$(daySpans[0]).siblings()[0].checked) {
                $(daySpans[2]).click();
            }
        }
        if (day === "Tuesday") {
            if (!$(daySpans[3]).siblings()[0].checked && !$(daySpans[1]).siblings()[0].checked) {
                $(daySpans[3]).click();
            }
        }
        if (day === "Friday") {
            if (!$(daySpans[0]).siblings()[0].checked && !$(daySpans[2]).siblings()[0].checked && !$(daySpans[4]).siblings()[0].checked) {
                $(daySpans[0]).click();
            }
        }
        if (day === "Friday") {
            if (!$(daySpans[2]).siblings()[0].checked && !$(daySpans[4]).siblings()[0].checked) {
                $(daySpans[2]).click();
            }
        }
    });
}

//Checks if courses exist with the entered data and gives an error indicating to create a course
function CheckForCourseNumbers() {
    var departmentID = $("#Course_DepartmentID").val();
    var courseIDGet = $("#CourseID").val();
    $.ajax({
        type: "GET",
        url: document.getElementById("actionUpdateCourseList").href,
        data: {
            "departmentID": departmentID
        },
        success: function (response) {
            $("#CourseID").empty();
            var selectedIndex = -1;
            for (var courseIndex = 0; courseIndex < response.length; courseIndex++) {
                var option = option = '<option value="' + response[courseIndex].id + '">' + response[courseIndex].numberAndTitle + '</option>';
                var indexID = response[courseIndex].id + "";
                var courseID = courseIDGet + "";
                if (indexID === courseID) {
                    selectedIndex = indexID;
                }
                $("#CourseID").append(option);
            }
            $("#CourseID").val(selectedIndex);
            $("#CourseID").trigger("chosen:updated");
        },
        failure: function () {
            alert("Something went wrong checking for course");
        }
    });
}

//changes values for the preset times in a section create from military time to standard
function TimeFormatToggle(event) {
    //toggles on/of for military time
    var btntotoggle = document.getElementById('miltimebtn');
    if (miltime) {
        miltime = false;
        btntotoggle.style.background = "white";
        toggleListFormat(miltime);
    }
    else {
        miltime = true;
        btntotoggle.style.background = "black";
        toggleListFormat();
    }
    var list = $('.divTimeSlotOption');
    if (!miltime) {
        list[0].lastElementChild.innerText = "4:00 pm - 6:45 pm";
        list[1].lastElementChild.innerText = "6:00 pm - 8:45 pm";
        list[2].lastElementChild.innerText = "8:00 am - 9:15 am";
        list[3].lastElementChild.innerText = "9:30 am - 10:45 am";
        list[4].lastElementChild.innerText = "11:00 am - 12:15 pm";
        list[5].lastElementChild.innerText = "1:00 pm - 2:15 pm";
        list[6].lastElementChild.innerText = "1:30 pm - 2:45 pm";
        list[7].lastElementChild.innerText = "2:30 pm - 3:45 pm";
        list[8].lastElementChild.innerText = "3:00 pm - 4:15 pm";
        list[9].lastElementChild.innerText = "8:00 am - 8:50 am";
        list[10].lastElementChild.innerText = "9:00 am - 9:50 am";
        list[11].lastElementChild.innerText = "10:00 am - 10:50 am";
        list[12].lastElementChild.innerText = "11:00 am - 11:50 am";
        list[13].lastElementChild.innerText = "1:00 pm - 1:50 pm";

    } else {
        list[0].lastElementChild.innerText = "16:00 - 18:45";
        list[1].lastElementChild.innerText = "18:00 - 20:45";
        list[2].lastElementChild.innerText = "8:00 - 9:15";
        list[3].lastElementChild.innerText = "9:30 - 10:45";
        list[4].lastElementChild.innerText = "11:00 - 12:15";
        list[5].lastElementChild.innerText = "13:00 - 14:15";
        list[6].lastElementChild.innerText = "13:30 - 14:45";
        list[7].lastElementChild.innerText = "14:30 - 15:45";
        list[8].lastElementChild.innerText = "15:00 - 16:15";
        list[9].lastElementChild.innerText = "8:00 - 8:50";
        list[10].lastElementChild.innerText = "9:00 - 9:50";
        list[11].lastElementChild.innerText = "10:00 - 10:50";
        list[12].lastElementChild.innerText = "11:00 - 11:50";
        list[13].lastElementChild.innerText = "13:00 - 13:50";
    }

}

function toggleListFormat(miltime) {
    var starttimes = document.getElementsByClassName("starttime");
    var endtimes = document.getElementsByClassName("endtime");
    for (var i; i < starttimes.length(); i++) { timeformat(starttimes[i], miltime); }
    for (var j; j < endtimes.length(); j++) { timeformat(endtimes[j], miltime); }
}
function timeformat(str, miltime) {
    var time = str;
    time = time.split(':');

    var hours = Number(time[0]);
    var minutes = Number(time[1]);
    var amORpm = time[2];

    if (miltime) {
        if (hours === 24)
            hours = "00";
        if (amORpm === "pm")
            hours += 12;
        return hours + ":" + minutes;
    }
    else {
        if (hours > 12) {
            hours -= 12;
            amORpm = "pm";
        }
        return hours + ":" + minutes + amORpm;
    }
}

function PrimaryInstructorChanged() {
    if ($("#PrimaryInstructorID").val() > 0) {
        $("#SecondaryInstructorID").val(tempHeldIndex);
        $("#divSecondaryInstructor").show();
    }
    else {
        tempHeldIndex = $("#SecondaryInstructorID").val();
        $("#SecondaryInstructorID").val(-1);
        $("#divSecondaryInstructor").hide();
    }
}