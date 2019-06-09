// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
var totalComparisons = 0;
var comparisonsCompleted = 0;

$(document).ready(function () {
    totalComparisons = document.getElementsByClassName("importedSections").length;
    $(".chosen-select").chosen();
    $(".thSortable").click(function (event) {
        Sort(event.target.innerText);
    });
    // Fernando Munoz
    // March 3, 2019
    // Apparently, what we were trying to do, has already been done. Like really well...
    // last edit: Nolan Crone, added the ability to scroll (see: scroller and the 3 lines before it.)
    // ************Enter, DataTables****************
    // Using DataTables js library. See Tables.js.
    // For addtional information on DataTables, see
    // https://datatables.net/examples/index - a free and open-source table library.
    $(".table").addClass("display").DataTable({
        "lengthMenu": [[-1, 12, 25, 50, 100], ["All", 12, 25, 50, 100]],
        deferRender: true,
        scrollY: window.screen.availHeight - 450,
        scrollCollapse: true,
        scroller: true,
        "oSearch": { "sSearch": $.urlParam('search') }
    });

    $('#myModal').on('shown.bs.modal', function () {
        $('#myInput').trigger('focus');
    });
    $(".trEditableRow").on("click", NavigateToEdit);
    $("#btnAcademicSemesterEnter").on("click", SelectAcademicSemester);
    $("#inputTimeToggle").on("click", TimeToggle);
});

$.urlParam = function (name) {
    var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (!results) {
        return;
    }
    return results[1] || "";
};

function TimeToggle() {
    $.ajax({
        type: "GET",
        url: document.getElementById("TimeToggle").href,
        success: function () {
            location.reload();
        },
        failure: function () {
            alert("Something went wrong");
        }
    });
}

function NavigateToEdit(event) {
    var link = event.currentTarget.children[0].children[0];
    window.location = link;
}


/*new Dropdown menu stuff started by Nolan
    OG creator W3schools: https://www.w3schools.com/howto/howto_js_dropdown.asp
*/
/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function (event) {
    if (!event.target.matches('.dropbtn')) {
        var dropdowns = document.getElementsByClassName("dropdown-content");
        var i;
        for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }
};


function SelectAcademicSemester() {
    var currentYear = $(document.getElementById("inputAcademicYearSelector")).val();
    var currentSemesterID = $(document.getElementById("selectAcademicSemester")).val();
    $.ajax({
        type: "GET",
        url: document.getElementById("linkAcademicSemesterSelector").href,
        data: {
            "currentYear": currentYear,
            "currentSemesterID": currentSemesterID
        },
        success: function (results) {
            location.reload();
            //$("#tbodySections").empty();
            //$("#tbodySections").html(results);
        },
        failure: function () {
            alert("Something went wrong selecting semester");
        }
    });
}

function UpdateFileNameDiv(rawFileName) {
    var fileName = rawFileName.slice(12);
    document.getElementById("divFileNameDisplay").innerText = fileName;
}

function Test(sectionChoiceID, comparerIndex) {
    var link = document.getElementById("linkSectionCompare").href;
    $.ajax({
        type: "GET",
        url: link,
        data: {
            "sectionID": sectionChoiceID
        },
        success: function (succeeded) {
            if (succeeded) {
                $(document.getElementById("divNewComparer" + comparerIndex)).hide();
                $(document.getElementById("divOldComparer" + comparerIndex)).hide();
                comparisonsCompleted++;
            }
            if (comparisonsCompleted === totalComparisons) {
                window.location = document.getElementById("linkSectionHome").href;
            }
        },
        failure: function () {
            alert("Something went wrong getting section comparisons");
        }
    });
}