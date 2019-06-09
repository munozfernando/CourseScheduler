$(document).ready(function () {
    SetSectionNumber();
    $("#CourseID").on("change", SetSectionNumber);
});

function SetSectionNumber() {
    var courseID = $("#CourseID").val();
    $.ajax({
        type: "GET",
        data: {
            "courseID": courseID
        },
        url: document.getElementById("actionUpdateSectionNumber").href,
        success: function (response) {
            $("#Number").val(response);
        },
        failure: function () {

        }
    });
}