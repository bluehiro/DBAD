/// <reference path="viewModel.js" />

(function (lightSwitchApplication) {

    var $element = document.createElement("div");

    lightSwitchApplication.AddEditPatient_Main.prototype._$contentItems = {
        Tabs: {
            _$class: msls.ContentItem,
            _$name: "Tabs",
            _$parentName: "RootContentItem",
            screen: lightSwitchApplication.AddEditPatient_Main
        },
        Details: {
            _$class: msls.ContentItem,
            _$name: "Details",
            _$parentName: "Tabs",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.AddEditPatient_Main,
            value: lightSwitchApplication.AddEditPatient_Main
        },
        columns: {
            _$class: msls.ContentItem,
            _$name: "columns",
            _$parentName: "Details",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.AddEditPatient_Main,
            value: lightSwitchApplication.Patient_Main
        },
        left: {
            _$class: msls.ContentItem,
            _$name: "left",
            _$parentName: "columns",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: lightSwitchApplication.Patient_Main
        },
        ID1: {
            _$class: msls.ContentItem,
            _$name: "ID1",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Number
        },
        Last_Name: {
            _$class: msls.ContentItem,
            _$name: "Last_Name",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        First_Name: {
            _$class: msls.ContentItem,
            _$name: "First_Name",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        MR: {
            _$class: msls.ContentItem,
            _$name: "MR",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Age: {
            _$class: msls.ContentItem,
            _$name: "Age",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Admit_Date: {
            _$class: msls.ContentItem,
            _$name: "Admit_Date",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Date
        },
        Floor: {
            _$class: msls.ContentItem,
            _$name: "Floor",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Bed: {
            _$class: msls.ContentItem,
            _$name: "Bed",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Number
        },
        Staff: {
            _$class: msls.ContentItem,
            _$name: "Staff",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Op_Res: {
            _$class: msls.ContentItem,
            _$name: "Op_Res",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Op_Res_2: {
            _$class: msls.ContentItem,
            _$name: "Op_Res_2",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Consult_Inpatient: {
            _$class: msls.ContentItem,
            _$name: "Consult_Inpatient",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Diagnosis: {
            _$class: msls.ContentItem,
            _$name: "Diagnosis",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Procedures: {
            _$class: msls.ContentItem,
            _$name: "Procedures",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Note: {
            _$class: msls.ContentItem,
            _$name: "Note",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Discharged: {
            _$class: msls.ContentItem,
            _$name: "Discharged",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Boolean
        },
        Discharge_Date: {
            _$class: msls.ContentItem,
            _$name: "Discharge_Date",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Date
        },
        Complication: {
            _$class: msls.ContentItem,
            _$name: "Complication",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Boolean
        },
        Complication__1: {
            _$class: msls.ContentItem,
            _$name: "Complication__1",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Complication__2: {
            _$class: msls.ContentItem,
            _$name: "Complication__2",
            _$parentName: "left",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        right: {
            _$class: msls.ContentItem,
            _$name: "right",
            _$parentName: "columns",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: lightSwitchApplication.Patient_Main
        },
        Complication_Description: {
            _$class: msls.ContentItem,
            _$name: "Complication_Description",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Research_Pt: {
            _$class: msls.ContentItem,
            _$name: "Research_Pt",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        M___M: {
            _$class: msls.ContentItem,
            _$name: "M___M",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Boolean
        },
        Status: {
            _$class: msls.ContentItem,
            _$name: "Status",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        FT: {
            _$class: msls.ContentItem,
            _$name: "FT",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Number
        },
        TBI: {
            _$class: msls.ContentItem,
            _$name: "TBI",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Boolean
        },
        TBI_f_u_complete: {
            _$class: msls.ContentItem,
            _$name: "TBI_f_u_complete",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Boolean
        },
        PCP: {
            _$class: msls.ContentItem,
            _$name: "PCP",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Address_line__1: {
            _$class: msls.ContentItem,
            _$name: "Address_line__1",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Address_line__2: {
            _$class: msls.ContentItem,
            _$name: "Address_line__2",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Address_line__3: {
            _$class: msls.ContentItem,
            _$name: "Address_line__3",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Preferred_1: {
            _$class: msls.ContentItem,
            _$name: "Preferred_1",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Boolean
        },
        E_mail: {
            _$class: msls.ContentItem,
            _$name: "E_mail",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Preferred_2: {
            _$class: msls.ContentItem,
            _$name: "Preferred_2",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Boolean
        },
        Tel: {
            _$class: msls.ContentItem,
            _$name: "Tel",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        Preferred_3: {
            _$class: msls.ContentItem,
            _$name: "Preferred_3",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Boolean
        },
        Referring_Phys: {
            _$class: msls.ContentItem,
            _$name: "Referring_Phys",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        BC_notes: {
            _$class: msls.ContentItem,
            _$name: "BC_notes",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        KJB_notes: {
            _$class: msls.ContentItem,
            _$name: "KJB_notes",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: String
        },
        PCP_f_u_done: {
            _$class: msls.ContentItem,
            _$name: "PCP_f_u_done",
            _$parentName: "right",
            screen: lightSwitchApplication.AddEditPatient_Main,
            data: lightSwitchApplication.Patient_Main,
            value: Boolean
        },
        Popups: {
            _$class: msls.ContentItem,
            _$name: "Popups",
            _$parentName: "RootContentItem",
            screen: lightSwitchApplication.AddEditPatient_Main
        }
    };

    msls._addEntryPoints(lightSwitchApplication.AddEditPatient_Main, {
        /// <field>
        /// Called when a new AddEditPatient_Main screen is created.
        /// <br/>created(msls.application.AddEditPatient_Main screen)
        /// </field>
        created: [lightSwitchApplication.AddEditPatient_Main],
        /// <field>
        /// Called before changes on an active AddEditPatient_Main screen are applied.
        /// <br/>beforeApplyChanges(msls.application.AddEditPatient_Main screen)
        /// </field>
        beforeApplyChanges: [lightSwitchApplication.AddEditPatient_Main],
        /// <field>
        /// Called after the Details content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Details_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Details"); }],
        /// <field>
        /// Called after the columns content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        columns_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("columns"); }],
        /// <field>
        /// Called after the left content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        left_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("left"); }],
        /// <field>
        /// Called after the ID1 content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        ID1_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("ID1"); }],
        /// <field>
        /// Called after the Last_Name content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Last_Name_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Last_Name"); }],
        /// <field>
        /// Called after the First_Name content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        First_Name_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("First_Name"); }],
        /// <field>
        /// Called after the MR content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        MR_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("MR"); }],
        /// <field>
        /// Called after the Age content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Age_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Age"); }],
        /// <field>
        /// Called after the Admit_Date content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Admit_Date_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Admit_Date"); }],
        /// <field>
        /// Called after the Floor content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Floor_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Floor"); }],
        /// <field>
        /// Called after the Bed content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Bed_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Bed"); }],
        /// <field>
        /// Called after the Staff content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Staff_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Staff"); }],
        /// <field>
        /// Called after the Op_Res content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Op_Res_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Op_Res"); }],
        /// <field>
        /// Called after the Op_Res_2 content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Op_Res_2_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Op_Res_2"); }],
        /// <field>
        /// Called after the Consult_Inpatient content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Consult_Inpatient_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Consult_Inpatient"); }],
        /// <field>
        /// Called after the Diagnosis content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Diagnosis_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Diagnosis"); }],
        /// <field>
        /// Called after the Procedures content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Procedures_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Procedures"); }],
        /// <field>
        /// Called after the Note content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Note_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Note"); }],
        /// <field>
        /// Called after the Discharged content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Discharged_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Discharged"); }],
        /// <field>
        /// Called after the Discharge_Date content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Discharge_Date_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Discharge_Date"); }],
        /// <field>
        /// Called after the Complication content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Complication_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Complication"); }],
        /// <field>
        /// Called after the Complication__1 content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Complication__1_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Complication__1"); }],
        /// <field>
        /// Called after the Complication__2 content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Complication__2_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Complication__2"); }],
        /// <field>
        /// Called after the right content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        right_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("right"); }],
        /// <field>
        /// Called after the Complication_Description content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Complication_Description_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Complication_Description"); }],
        /// <field>
        /// Called after the Research_Pt content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Research_Pt_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Research_Pt"); }],
        /// <field>
        /// Called after the M___M content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        M___M_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("M___M"); }],
        /// <field>
        /// Called after the Status content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Status_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Status"); }],
        /// <field>
        /// Called after the FT content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        FT_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("FT"); }],
        /// <field>
        /// Called after the TBI content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        TBI_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("TBI"); }],
        /// <field>
        /// Called after the TBI_f_u_complete content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        TBI_f_u_complete_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("TBI_f_u_complete"); }],
        /// <field>
        /// Called after the PCP content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        PCP_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("PCP"); }],
        /// <field>
        /// Called after the Address_line__1 content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Address_line__1_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Address_line__1"); }],
        /// <field>
        /// Called after the Address_line__2 content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Address_line__2_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Address_line__2"); }],
        /// <field>
        /// Called after the Address_line__3 content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Address_line__3_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Address_line__3"); }],
        /// <field>
        /// Called after the Preferred_1 content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Preferred_1_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Preferred_1"); }],
        /// <field>
        /// Called after the E_mail content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        E_mail_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("E_mail"); }],
        /// <field>
        /// Called after the Preferred_2 content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Preferred_2_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Preferred_2"); }],
        /// <field>
        /// Called after the Tel content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Tel_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Tel"); }],
        /// <field>
        /// Called after the Preferred_3 content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Preferred_3_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Preferred_3"); }],
        /// <field>
        /// Called after the Referring_Phys content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        Referring_Phys_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("Referring_Phys"); }],
        /// <field>
        /// Called after the BC_notes content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        BC_notes_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("BC_notes"); }],
        /// <field>
        /// Called after the KJB_notes content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        KJB_notes_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("KJB_notes"); }],
        /// <field>
        /// Called after the PCP_f_u_done content item has been rendered.
        /// <br/>postRender(HTMLElement element, msls.ContentItem contentItem)
        /// </field>
        PCP_f_u_done_postRender: [$element, function () { return new lightSwitchApplication.AddEditPatient_Main().findContentItem("PCP_f_u_done"); }]
    });

}(msls.application));