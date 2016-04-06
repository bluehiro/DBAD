/// <reference path="~/GeneratedArtifacts/viewModel.js" />

myapp.ViewPatient_Main1.Details_postRender = function (element, contentItem) {
    // Write code here.
    var name = contentItem.screen.Patient_Main.details.getModel()[':@SummaryProperty'].property.name;
    contentItem.dataBind("screen.Patient_Main." + name, function (value) {
        contentItem.screen.details.displayName = value;
    });
}

