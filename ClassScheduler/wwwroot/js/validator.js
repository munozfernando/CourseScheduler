const OK_MESSAGE = "OK! No errors found ";
const ERROR_PREFIX = "ERROR! View ";

const SECTION_DATA_LINK = "/ScheduleValidator/SectionData";
const SECTION_RESOURCE_LINK = "/ScheduleValidator/SectionResources";
const INSTRUCTOR_COURSELOAD_LINK = "/ScheduleValidator/CourseLoads";

$(document).ready(function () {

    $.ajax({
        type: 'GET',
        url: '/CheckSectionResources',
        success: function (result) {
            let statusIcon = document.getElementById("resourceCheckLoader");
            let messageArea = document.getElementById("msgResourceCheck");
            let messageContext = "between SECTION assigned resources.";

            if (result !== true) {
                setOK(statusIcon, messageArea, messageContext);
            }
            else {
                setError(statusIcon, messageArea, SECTION_RESOURCE_LINK, "Section Resource Conflicts");
            }
        },
        failure: function() {
            alert("Something went wrong with the SECTION RESOURCE validator");
        }
    });

    $.ajax({
        type: 'GET',
        url: '/CheckInstructorCourseLoads',
        success: function (result) {
            let statusIcon = document.getElementById("instructorCheckLoader");
            let messageArea = document.getElementById("msgInstructorCheck");
            let messageContext = "on INSTRUCTOR assigned course loads.";

            if (result !== true) {
                setOK(statusIcon, messageArea, messageContext);
            }
            else {
                setError(statusIcon, messageArea, INSTRUCTOR_COURSELOAD_LINK, "Instructor Course Load Errors");
            }
        },
        failure: function () {
            alert("Something went wrong with the INSTRUCTOR COURSELOAD validator");
        }
    });

    $.ajax({
        type: 'GET',
        url: '/CheckSectionData',
        success: function (result) {
            let statusIcon = document.getElementById("dataCheckLoader");
            let messageArea = document.getElementById("msgDataCheck");
            let messageContext = "on the any SECTION's data.";

            if (result !== true) {
                setOK(statusIcon, messageArea, messageContext);
            }
            else {
                setError(statusIcon, messageArea, SECTION_DATA_LINK, "Section Data Issues");
            }
        },
        failure: function () {
            alert("Something went wrong with the SECTION DATA validator");
        }
    });
}); 

function setOK(iconElement, messageElement, message) {
    iconElement.classList.remove("loader");
    // Uncomment below, and comment above to remove spinny stuff :D
    iconElement.className = "";
    iconElement.innerHTML = "✔️";
    messageElement.innerHTML = OK_MESSAGE + message;
}

function setError(iconElement, messageArea, url, linkText) {
    iconElement.classList.remove("loader");
    // Uncomment below, and comment above to remove spinny stuff :D
    iconElement.className = "";
    iconElement.innerHTML = "❌";
    messageArea.innerHTML = ERROR_PREFIX + '<a href="' + url + '" target="_blank">' + linkText + '</a>';
}