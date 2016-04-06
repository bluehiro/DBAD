/// <reference path="data.js" />

(function (lightSwitchApplication) {

    var $Screen = msls.Screen,
        $defineScreen = msls._defineScreen,
        $DataServiceQuery = msls.DataServiceQuery,
        $toODataString = msls._toODataString,
        $defineShowScreen = msls._defineShowScreen;

    function AddEditPatient_Main(parameters, dataWorkspace) {
        /// <summary>
        /// Represents the AddEditPatient_Main screen.
        /// </summary>
        /// <param name="parameters" type="Array">
        /// An array of screen parameter values.
        /// </param>
        /// <param name="dataWorkspace" type="msls.application.DataWorkspace" optional="true">
        /// An existing data workspace for this screen to use. By default, a new data workspace is created.
        /// </param>
        /// <field name="Patient_Main" type="msls.application.Patient_Main">
        /// Gets or sets the patient_Main for this screen.
        /// </field>
        /// <field name="details" type="msls.application.AddEditPatient_Main.Details">
        /// Gets the details for this screen.
        /// </field>
        if (!dataWorkspace) {
            dataWorkspace = new lightSwitchApplication.DataWorkspace();
        }
        $Screen.call(this, dataWorkspace, "AddEditPatient_Main", parameters);
    }

    function ViewPatient_Main1(parameters, dataWorkspace) {
        /// <summary>
        /// Represents the ViewPatient_Main1 screen.
        /// </summary>
        /// <param name="parameters" type="Array">
        /// An array of screen parameter values.
        /// </param>
        /// <param name="dataWorkspace" type="msls.application.DataWorkspace" optional="true">
        /// An existing data workspace for this screen to use. By default, a new data workspace is created.
        /// </param>
        /// <field name="Patient_Main" type="msls.application.Patient_Main">
        /// Gets or sets the patient_Main for this screen.
        /// </field>
        /// <field name="details" type="msls.application.ViewPatient_Main1.Details">
        /// Gets the details for this screen.
        /// </field>
        if (!dataWorkspace) {
            dataWorkspace = new lightSwitchApplication.DataWorkspace();
        }
        $Screen.call(this, dataWorkspace, "ViewPatient_Main1", parameters);
    }

    function BrowsePatient_Mains1(parameters, dataWorkspace) {
        /// <summary>
        /// Represents the BrowsePatient_Mains1 screen.
        /// </summary>
        /// <param name="parameters" type="Array">
        /// An array of screen parameter values.
        /// </param>
        /// <param name="dataWorkspace" type="msls.application.DataWorkspace" optional="true">
        /// An existing data workspace for this screen to use. By default, a new data workspace is created.
        /// </param>
        /// <field name="Patient_Mains" type="msls.VisualCollection" elementType="msls.application.Patient_Main">
        /// Gets the patient_Mains for this screen.
        /// </field>
        /// <field name="details" type="msls.application.BrowsePatient_Mains1.Details">
        /// Gets the details for this screen.
        /// </field>
        if (!dataWorkspace) {
            dataWorkspace = new lightSwitchApplication.DataWorkspace();
        }
        $Screen.call(this, dataWorkspace, "BrowsePatient_Mains1", parameters);
    }

    msls._addToNamespace("msls.application", {

        AddEditPatient_Main: $defineScreen(AddEditPatient_Main, [
            { name: "Patient_Main", kind: "local", type: lightSwitchApplication.Patient_Main }
        ], [
        ]),

        ViewPatient_Main1: $defineScreen(ViewPatient_Main1, [
            { name: "Patient_Main", kind: "local", type: lightSwitchApplication.Patient_Main }
        ], [
        ]),

        BrowsePatient_Mains1: $defineScreen(BrowsePatient_Mains1, [
            {
                name: "Patient_Mains", kind: "collection", elementType: lightSwitchApplication.Patient_Main,
                createQuery: function () {
                    return this.dataWorkspace.NeuroPatData.Patient_Mains;
                }
            }
        ], [
        ]),

        showAddEditPatient_Main: $defineShowScreen(function showAddEditPatient_Main(Patient_Main, options) {
            /// <summary>
            /// Asynchronously navigates forward to the AddEditPatient_Main screen.
            /// </summary>
            /// <param name="options" optional="true">
            /// An object that provides one or more of the following options:<br/>- beforeShown: a function that is called after boundary behavior has been applied but before the screen is shown.<br/>+ Signature: beforeShown(screen)<br/>- afterClosed: a function that is called after boundary behavior has been applied and the screen has been closed.<br/>+ Signature: afterClosed(screen, action : msls.NavigateBackAction)
            /// </param>
            /// <returns type="WinJS.Promise" />
            var parameters = Array.prototype.slice.call(arguments, 0, 1);
            return lightSwitchApplication.showScreen("AddEditPatient_Main", parameters, options);
        }),

        showViewPatient_Main1: $defineShowScreen(function showViewPatient_Main1(Patient_Main, options) {
            /// <summary>
            /// Asynchronously navigates forward to the ViewPatient_Main1 screen.
            /// </summary>
            /// <param name="options" optional="true">
            /// An object that provides one or more of the following options:<br/>- beforeShown: a function that is called after boundary behavior has been applied but before the screen is shown.<br/>+ Signature: beforeShown(screen)<br/>- afterClosed: a function that is called after boundary behavior has been applied and the screen has been closed.<br/>+ Signature: afterClosed(screen, action : msls.NavigateBackAction)
            /// </param>
            /// <returns type="WinJS.Promise" />
            var parameters = Array.prototype.slice.call(arguments, 0, 1);
            return lightSwitchApplication.showScreen("ViewPatient_Main1", parameters, options);
        }),

        showBrowsePatient_Mains1: $defineShowScreen(function showBrowsePatient_Mains1(options) {
            /// <summary>
            /// Asynchronously navigates forward to the BrowsePatient_Mains1 screen.
            /// </summary>
            /// <param name="options" optional="true">
            /// An object that provides one or more of the following options:<br/>- beforeShown: a function that is called after boundary behavior has been applied but before the screen is shown.<br/>+ Signature: beforeShown(screen)<br/>- afterClosed: a function that is called after boundary behavior has been applied and the screen has been closed.<br/>+ Signature: afterClosed(screen, action : msls.NavigateBackAction)
            /// </param>
            /// <returns type="WinJS.Promise" />
            var parameters = Array.prototype.slice.call(arguments, 0, 0);
            return lightSwitchApplication.showScreen("BrowsePatient_Mains1", parameters, options);
        })

    });

}(msls.application));
