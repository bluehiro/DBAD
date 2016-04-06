/// <reference path="../Scripts/msls.js" />

window.myapp = msls.application;

(function (lightSwitchApplication) {

    var $Entity = msls.Entity,
        $DataService = msls.DataService,
        $DataWorkspace = msls.DataWorkspace,
        $defineEntity = msls._defineEntity,
        $defineDataService = msls._defineDataService,
        $defineDataWorkspace = msls._defineDataWorkspace,
        $DataServiceQuery = msls.DataServiceQuery,
        $toODataString = msls._toODataString;

    function Patient_Main(entitySet) {
        /// <summary>
        /// Represents the Patient_Main entity type.
        /// </summary>
        /// <param name="entitySet" type="msls.EntitySet" optional="true">
        /// The entity set that should contain this patient_Main.
        /// </param>
        /// <field name="ID1" type="Number">
        /// Gets or sets the iD1 for this patient_Main.
        /// </field>
        /// <field name="Last_Name" type="String">
        /// Gets or sets the last_Name for this patient_Main.
        /// </field>
        /// <field name="First_Name" type="String">
        /// Gets or sets the first_Name for this patient_Main.
        /// </field>
        /// <field name="MR" type="String">
        /// Gets or sets the mR for this patient_Main.
        /// </field>
        /// <field name="Age" type="String">
        /// Gets or sets the age for this patient_Main.
        /// </field>
        /// <field name="Admit_Date" type="Date">
        /// Gets or sets the admit_Date for this patient_Main.
        /// </field>
        /// <field name="Floor" type="String">
        /// Gets or sets the floor for this patient_Main.
        /// </field>
        /// <field name="Bed" type="Number">
        /// Gets or sets the bed for this patient_Main.
        /// </field>
        /// <field name="Staff" type="String">
        /// Gets or sets the staff for this patient_Main.
        /// </field>
        /// <field name="Op_Res" type="String">
        /// Gets or sets the op_Res for this patient_Main.
        /// </field>
        /// <field name="Op_Res_2" type="String">
        /// Gets or sets the op_Res_2 for this patient_Main.
        /// </field>
        /// <field name="Consult_Inpatient" type="String">
        /// Gets or sets the consult_Inpatient for this patient_Main.
        /// </field>
        /// <field name="Diagnosis" type="String">
        /// Gets or sets the diagnosis for this patient_Main.
        /// </field>
        /// <field name="Procedures" type="String">
        /// Gets or sets the procedures for this patient_Main.
        /// </field>
        /// <field name="Note" type="String">
        /// Gets or sets the note for this patient_Main.
        /// </field>
        /// <field name="Discharged" type="Boolean">
        /// Gets or sets the discharged for this patient_Main.
        /// </field>
        /// <field name="Discharge_Date" type="Date">
        /// Gets or sets the discharge_Date for this patient_Main.
        /// </field>
        /// <field name="Complication" type="Boolean">
        /// Gets or sets the complication for this patient_Main.
        /// </field>
        /// <field name="Complication__1" type="String">
        /// Gets or sets the complication__1 for this patient_Main.
        /// </field>
        /// <field name="Complication__2" type="String">
        /// Gets or sets the complication__2 for this patient_Main.
        /// </field>
        /// <field name="Complication_Description" type="String">
        /// Gets or sets the complication_Description for this patient_Main.
        /// </field>
        /// <field name="Research_Pt" type="String">
        /// Gets or sets the research_Pt for this patient_Main.
        /// </field>
        /// <field name="M___M" type="Boolean">
        /// Gets or sets the m___M for this patient_Main.
        /// </field>
        /// <field name="Status" type="String">
        /// Gets or sets the status for this patient_Main.
        /// </field>
        /// <field name="FT" type="Number">
        /// Gets or sets the fT for this patient_Main.
        /// </field>
        /// <field name="TBI" type="Boolean">
        /// Gets or sets the tBI for this patient_Main.
        /// </field>
        /// <field name="TBI_f_u_complete" type="Boolean">
        /// Gets or sets the tBI_f_u_complete for this patient_Main.
        /// </field>
        /// <field name="PCP" type="String">
        /// Gets or sets the pCP for this patient_Main.
        /// </field>
        /// <field name="Address_line__1" type="String">
        /// Gets or sets the address_line__1 for this patient_Main.
        /// </field>
        /// <field name="Address_line__2" type="String">
        /// Gets or sets the address_line__2 for this patient_Main.
        /// </field>
        /// <field name="Address_line__3" type="String">
        /// Gets or sets the address_line__3 for this patient_Main.
        /// </field>
        /// <field name="Preferred_1" type="Boolean">
        /// Gets or sets the preferred_1 for this patient_Main.
        /// </field>
        /// <field name="E_mail" type="String">
        /// Gets or sets the e_mail for this patient_Main.
        /// </field>
        /// <field name="Preferred_2" type="Boolean">
        /// Gets or sets the preferred_2 for this patient_Main.
        /// </field>
        /// <field name="Tel" type="String">
        /// Gets or sets the tel for this patient_Main.
        /// </field>
        /// <field name="Preferred_3" type="Boolean">
        /// Gets or sets the preferred_3 for this patient_Main.
        /// </field>
        /// <field name="Referring_Phys" type="String">
        /// Gets or sets the referring_Phys for this patient_Main.
        /// </field>
        /// <field name="BC_notes" type="String">
        /// Gets or sets the bC_notes for this patient_Main.
        /// </field>
        /// <field name="KJB_notes" type="String">
        /// Gets or sets the kJB_notes for this patient_Main.
        /// </field>
        /// <field name="PCP_f_u_done" type="Boolean">
        /// Gets or sets the pCP_f_u_done for this patient_Main.
        /// </field>
        /// <field name="details" type="msls.application.Patient_Main.Details">
        /// Gets the details for this patient_Main.
        /// </field>
        $Entity.call(this, entitySet);
    }

    function NeuroPatData(dataWorkspace) {
        /// <summary>
        /// Represents the NeuroPatData data service.
        /// </summary>
        /// <param name="dataWorkspace" type="msls.DataWorkspace">
        /// The data workspace that created this data service.
        /// </param>
        /// <field name="Patient_Mains" type="msls.EntitySet">
        /// Gets the Patient_Mains entity set.
        /// </field>
        /// <field name="details" type="msls.application.NeuroPatData.Details">
        /// Gets the details for this data service.
        /// </field>
        $DataService.call(this, dataWorkspace);
    };
    function DataWorkspace() {
        /// <summary>
        /// Represents the data workspace.
        /// </summary>
        /// <field name="NeuroPatData" type="msls.application.NeuroPatData">
        /// Gets the NeuroPatData data service.
        /// </field>
        /// <field name="details" type="msls.application.DataWorkspace.Details">
        /// Gets the details for this data workspace.
        /// </field>
        $DataWorkspace.call(this);
    };

    msls._addToNamespace("msls.application", {

        Patient_Main: $defineEntity(Patient_Main, [
            { name: "ID1", type: Number },
            { name: "Last_Name", type: String },
            { name: "First_Name", type: String },
            { name: "MR", type: String },
            { name: "Age", type: String },
            { name: "Admit_Date", type: Date },
            { name: "Floor", type: String },
            { name: "Bed", type: Number },
            { name: "Staff", type: String },
            { name: "Op_Res", type: String },
            { name: "Op_Res_2", type: String },
            { name: "Consult_Inpatient", type: String },
            { name: "Diagnosis", type: String },
            { name: "Procedures", type: String },
            { name: "Note", type: String },
            { name: "Discharged", type: Boolean },
            { name: "Discharge_Date", type: Date },
            { name: "Complication", type: Boolean },
            { name: "Complication__1", type: String },
            { name: "Complication__2", type: String },
            { name: "Complication_Description", type: String },
            { name: "Research_Pt", type: String },
            { name: "M___M", type: Boolean },
            { name: "Status", type: String },
            { name: "FT", type: Number },
            { name: "TBI", type: Boolean },
            { name: "TBI_f_u_complete", type: Boolean },
            { name: "PCP", type: String },
            { name: "Address_line__1", type: String },
            { name: "Address_line__2", type: String },
            { name: "Address_line__3", type: String },
            { name: "Preferred_1", type: Boolean },
            { name: "E_mail", type: String },
            { name: "Preferred_2", type: Boolean },
            { name: "Tel", type: String },
            { name: "Preferred_3", type: Boolean },
            { name: "Referring_Phys", type: String },
            { name: "BC_notes", type: String },
            { name: "KJB_notes", type: String },
            { name: "PCP_f_u_done", type: Boolean }
        ]),

        NeuroPatData: $defineDataService(NeuroPatData, lightSwitchApplication.rootUri + "/NeuroPatData.svc", [
            { name: "Patient_Mains", elementType: Patient_Main }
        ], [
            {
                name: "Patient_Mains_SingleOrDefault", value: function (Discharged, Complication, M___M, TBI, TBI_f_u_complete, Preferred_1, Preferred_2, Preferred_3, PCP_f_u_done) {
                    return new $DataServiceQuery({ _entitySet: this.Patient_Mains },
                        lightSwitchApplication.rootUri + "/NeuroPatData.svc" + "/Patient_Mains(" + "Discharged=" + $toODataString(Discharged, "Boolean?") + "," + "Complication=" + $toODataString(Complication, "Boolean?") + "," + "M___M=" + $toODataString(M___M, "Boolean?") + "," + "TBI=" + $toODataString(TBI, "Boolean?") + "," + "TBI_f_u_complete=" + $toODataString(TBI_f_u_complete, "Boolean?") + "," + "Preferred_1=" + $toODataString(Preferred_1, "Boolean?") + "," + "Preferred_2=" + $toODataString(Preferred_2, "Boolean?") + "," + "Preferred_3=" + $toODataString(Preferred_3, "Boolean?") + "," + "PCP_f_u_done=" + $toODataString(PCP_f_u_done, "Boolean?") + ")"
                    );
                }
            }
        ]),

        DataWorkspace: $defineDataWorkspace(DataWorkspace, [
            { name: "NeuroPatData", type: NeuroPatData }
        ])

    });

}(msls.application));
