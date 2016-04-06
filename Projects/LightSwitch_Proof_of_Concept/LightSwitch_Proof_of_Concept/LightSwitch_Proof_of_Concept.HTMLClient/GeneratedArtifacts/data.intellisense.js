/// <reference path="data.js" />

(function (lightSwitchApplication) {

    msls._addEntryPoints(lightSwitchApplication.Patient_Main, {
        /// <field>
        /// Called when a new patient_Main is created.
        /// <br/>created(msls.application.Patient_Main entity)
        /// </field>
        created: [lightSwitchApplication.Patient_Main]
    });

}(msls.application));
