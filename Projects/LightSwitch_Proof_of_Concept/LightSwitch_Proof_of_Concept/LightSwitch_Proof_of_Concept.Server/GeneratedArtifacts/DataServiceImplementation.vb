﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated by a tool.
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On

Namespace LightSwitchApplication.Implementation
    <Global.System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.LightSwitch.BuildTasks.CodeGen", "12.1.0.0")> _
    <Global.System.Diagnostics.DebuggerNonUserCodeAttribute()> _
    Public Class NeuroPatDataDataService
        Inherits Global.Microsoft.LightSwitch.ServerGenerated.Implementation.DataService(Of Global.LightSwitchApplication.Implementation.NeuroPatData)
    
        Public Sub New()
            MyBase.New()
        End Sub
    
        Protected Overrides Function GetDataService(dataWorkspace As Global.Microsoft.LightSwitch.IDataWorkspace) As Global.Microsoft.LightSwitch.IDataService
            Return DirectCast(dataWorkspace, Global.LightSwitchApplication.DataWorkspace).NeuroPatData
        End Function
    
    End Class
    
    <Global.System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.LightSwitch.BuildTasks.CodeGen", "12.1.0.0")> _
    <Global.System.Diagnostics.DebuggerNonUserCodeAttribute()> _
    Public Class NeuroPatDataServiceImplementation
        Inherits Global.Microsoft.LightSwitch.ServerGenerated.Implementation.DataServiceImplementation(Of Global.LightSwitchApplication.Implementation.NeuroPatData)
    
        Public Sub New(ByVal dataService As Global.Microsoft.LightSwitch.IDataService)
            MyBase.New(dataService)
        End Sub
    
    #Region "Queries"
    #End Region

    #Region "Protected methods"
        Protected Overrides Function CreateObject(ByVal type As Global.System.Type) As Object
            If (GetType(Global.LightSwitchApplication.Implementation.Patient_Main).Equals(type)) Then
                Return New Global.LightSwitchApplication.Implementation.Patient_Main
            End If
    
            Return MyBase.CreateObject(type)
        End Function
    
        Protected Overrides Function CreateObjectContext() As Global.LightSwitchApplication.Implementation.NeuroPatData
            Dim assemblyName As String = Global.System.Reflection.Assembly.GetExecutingAssembly().GetName().Name
            Return New Global.LightSwitchApplication.Implementation.NeuroPatData(Me.GetEntityConnectionString( _
                "NeuroPatData", _
                "res://" + assemblyName + "/NeuroPatData.csdl|res://" + assemblyName + "/NeuroPatData.ssdl|res://" + assemblyName + "/NeuroPatData.msl", _
                "System.Data.SqlClient", _
                True))
        End Function
    
        Protected Overrides Function CreateEntityImplementation(Of T As Global.Microsoft.LightSwitch.IEntityObject)() As Global.Microsoft.LightSwitch.Internal.IEntityImplementation
            If GetType(T).Equals(GetType(Global.LightSwitchApplication.Patient_Main)) Then
                Return New Global.LightSwitchApplication.Implementation.Patient_Main()
            End If
            Return Nothing
        End Function
    
    #End Region
    
    End Class
    
    
    #Region "DataServiceImplementationFactory"
    <Global.System.ComponentModel.Composition.PartCreationPolicy(Global.System.ComponentModel.Composition.CreationPolicy.Shared)> _
    <Global.System.ComponentModel.Composition.Export(GetType(Global.Microsoft.LightSwitch.Internal.IDataServiceFactory))> _
    <Global.System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.LightSwitch.BuildTasks.CodeGen", "12.1.0.0")> _
    <Global.System.Diagnostics.DebuggerNonUserCodeAttribute()> _
    Public Class __DataServiceFactory
        Inherits Global.Microsoft.LightSwitch.ServerGenerated.Implementation.DataServiceFactory
    
        Protected Overrides Function CreateDataService(ByVal dataServiceType As Global.System.Type) As Global.Microsoft.LightSwitch.IDataService
            If dataServiceType.Equals(GetType(Global.LightSwitchApplication.NeuroPatDataService)) Then
                Return New Global.LightSwitchApplication.NeuroPatDataService()
            End If
            Return MyBase.CreateDataService(dataServiceType)
        End Function
    
        Protected Overrides Function CreateDataServiceImplementation(Of TDataService As Global.Microsoft.LightSwitch.IDataService)(ByVal dataService As TDataService) As Global.Microsoft.LightSwitch.Internal.IDataServiceImplementation
            If GetType(TDataService).Equals(GetType(Global.LightSwitchApplication.NeuroPatDataService)) Then
                Return New Global.LightSwitchApplication.Implementation.NeuroPatDataServiceImplementation(dataService)
            End If
            Return MyBase.CreateDataServiceImplementation(dataService)
        End Function
    End Class
    #End Region
    
    <Global.System.ComponentModel.Composition.PartCreationPolicy(Global.System.ComponentModel.Composition.CreationPolicy.Shared)> _
    <Global.System.ComponentModel.Composition.Export(GetType(Global.Microsoft.LightSwitch.Internal.ITypeMappingProvider))> _
    <Global.System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.LightSwitch.BuildTasks.CodeGen", "12.1.0.0")> _
    <Global.System.Diagnostics.DebuggerNonUserCodeAttribute()> _
    Public Class __TypeMapping
        Implements Global.Microsoft.LightSwitch.Internal.ITypeMappingProvider
        Private Function GetImplementationType(ByVal definitionType As Global.System.Type) As Global.System.Type Implements Global.Microsoft.LightSwitch.Internal.ITypeMappingProvider.GetImplementationType
            If GetType(Global.LightSwitchApplication.Patient_Main).Equals(definitionType)
                Return GetType(Global.LightSwitchApplication.Implementation.Patient_Main)
            End If
            Return Nothing
        End Function
    End Class
    <Global.System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.LightSwitch.BuildTasks.CodeGen", "12.1.0.0")> _
    <Global.System.Diagnostics.DebuggerNonUserCodeAttribute()> _
    Partial Public Class Patient_Main
        Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation

        Private Property _ID1Implementation() As Global.System.Nullable(Of Integer) Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.ID1
            Get
                Return Me.ID1
            End Get
            Set(ByVal value As Global.System.Nullable(Of Integer))
                Me.ID1 = value
            End Set
        End Property
        
        Private Property _Last_NameImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Last_Name
            Get
                Return Me.Last_Name
            End Get
            Set(ByVal value As String)
                Me.Last_Name = value
            End Set
        End Property
        
        Private Property _First_NameImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.First_Name
            Get
                Return Me.First_Name
            End Get
            Set(ByVal value As String)
                Me.First_Name = value
            End Set
        End Property
        
        Private Property _MRImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.MR
            Get
                Return Me.MR
            End Get
            Set(ByVal value As String)
                Me.MR = value
            End Set
        End Property
        
        Private Property _AgeImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Age
            Get
                Return Me.Age
            End Get
            Set(ByVal value As String)
                Me.Age = value
            End Set
        End Property
        
        Private Property _Admit_DateImplementation() As Global.System.Nullable(Of Date) Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Admit_Date
            Get
                Return Me.Admit_Date
            End Get
            Set(ByVal value As Global.System.Nullable(Of Date))
                Me.Admit_Date = value
            End Set
        End Property
        
        Private Property _FloorImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Floor
            Get
                Return Me.Floor
            End Get
            Set(ByVal value As String)
                Me.Floor = value
            End Set
        End Property
        
        Private Property _BedImplementation() As Global.System.Nullable(Of Integer) Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Bed
            Get
                Return Me.Bed
            End Get
            Set(ByVal value As Global.System.Nullable(Of Integer))
                Me.Bed = value
            End Set
        End Property
        
        Private Property _StaffImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Staff
            Get
                Return Me.Staff
            End Get
            Set(ByVal value As String)
                Me.Staff = value
            End Set
        End Property
        
        Private Property _Op_ResImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Op_Res
            Get
                Return Me.Op_Res
            End Get
            Set(ByVal value As String)
                Me.Op_Res = value
            End Set
        End Property
        
        Private Property _Op_Res_2Implementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Op_Res_2
            Get
                Return Me.Op_Res_2
            End Get
            Set(ByVal value As String)
                Me.Op_Res_2 = value
            End Set
        End Property
        
        Private Property _Consult_InpatientImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Consult_Inpatient
            Get
                Return Me.Consult_Inpatient
            End Get
            Set(ByVal value As String)
                Me.Consult_Inpatient = value
            End Set
        End Property
        
        Private Property _DiagnosisImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Diagnosis
            Get
                Return Me.Diagnosis
            End Get
            Set(ByVal value As String)
                Me.Diagnosis = value
            End Set
        End Property
        
        Private Property _ProceduresImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Procedures
            Get
                Return Me.Procedures
            End Get
            Set(ByVal value As String)
                Me.Procedures = value
            End Set
        End Property
        
        Private Property _NoteImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Note
            Get
                Return Me.Note
            End Get
            Set(ByVal value As String)
                Me.Note = value
            End Set
        End Property
        
        Private Property _DischargedImplementation() As Boolean Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Discharged
            Get
                Return Me.Discharged
            End Get
            Set(ByVal value As Boolean)
                Me.Discharged = value
            End Set
        End Property
        
        Private Property _Discharge_DateImplementation() As Global.System.Nullable(Of Date) Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Discharge_Date
            Get
                Return Me.Discharge_Date
            End Get
            Set(ByVal value As Global.System.Nullable(Of Date))
                Me.Discharge_Date = value
            End Set
        End Property
        
        Private Property _ComplicationImplementation() As Boolean Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Complication
            Get
                Return Me.Complication
            End Get
            Set(ByVal value As Boolean)
                Me.Complication = value
            End Set
        End Property
        
        Private Property _Complication__1Implementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Complication__1
            Get
                Return Me.Complication__1
            End Get
            Set(ByVal value As String)
                Me.Complication__1 = value
            End Set
        End Property
        
        Private Property _Complication__2Implementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Complication__2
            Get
                Return Me.Complication__2
            End Get
            Set(ByVal value As String)
                Me.Complication__2 = value
            End Set
        End Property
        
        Private Property _Complication_DescriptionImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Complication_Description
            Get
                Return Me.Complication_Description
            End Get
            Set(ByVal value As String)
                Me.Complication_Description = value
            End Set
        End Property
        
        Private Property _Research_PtImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Research_Pt
            Get
                Return Me.Research_Pt
            End Get
            Set(ByVal value As String)
                Me.Research_Pt = value
            End Set
        End Property
        
        Private Property _M___MImplementation() As Boolean Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.M___M
            Get
                Return Me.M___M
            End Get
            Set(ByVal value As Boolean)
                Me.M___M = value
            End Set
        End Property
        
        Private Property _StatusImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Status
            Get
                Return Me.Status
            End Get
            Set(ByVal value As String)
                Me.Status = value
            End Set
        End Property
        
        Private Property _FTImplementation() As Global.System.Nullable(Of Integer) Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.FT
            Get
                Return Me.FT
            End Get
            Set(ByVal value As Global.System.Nullable(Of Integer))
                Me.FT = value
            End Set
        End Property
        
        Private Property _TBIImplementation() As Boolean Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.TBI
            Get
                Return Me.TBI
            End Get
            Set(ByVal value As Boolean)
                Me.TBI = value
            End Set
        End Property
        
        Private Property _TBI_f_u_completeImplementation() As Boolean Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.TBI_f_u_complete
            Get
                Return Me.TBI_f_u_complete
            End Get
            Set(ByVal value As Boolean)
                Me.TBI_f_u_complete = value
            End Set
        End Property
        
        Private Property _PCPImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.PCP
            Get
                Return Me.PCP
            End Get
            Set(ByVal value As String)
                Me.PCP = value
            End Set
        End Property
        
        Private Property _Address_line__1Implementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Address_line__1
            Get
                Return Me.Address_line__1
            End Get
            Set(ByVal value As String)
                Me.Address_line__1 = value
            End Set
        End Property
        
        Private Property _Address_line__2Implementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Address_line__2
            Get
                Return Me.Address_line__2
            End Get
            Set(ByVal value As String)
                Me.Address_line__2 = value
            End Set
        End Property
        
        Private Property _Address_line__3Implementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Address_line__3
            Get
                Return Me.Address_line__3
            End Get
            Set(ByVal value As String)
                Me.Address_line__3 = value
            End Set
        End Property
        
        Private Property _Preferred_1Implementation() As Boolean Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Preferred_1
            Get
                Return Me.Preferred_1
            End Get
            Set(ByVal value As Boolean)
                Me.Preferred_1 = value
            End Set
        End Property
        
        Private Property _E_mailImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.E_mail
            Get
                Return Me.E_mail
            End Get
            Set(ByVal value As String)
                Me.E_mail = value
            End Set
        End Property
        
        Private Property _Preferred_2Implementation() As Boolean Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Preferred_2
            Get
                Return Me.Preferred_2
            End Get
            Set(ByVal value As Boolean)
                Me.Preferred_2 = value
            End Set
        End Property
        
        Private Property _TelImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Tel
            Get
                Return Me.Tel
            End Get
            Set(ByVal value As String)
                Me.Tel = value
            End Set
        End Property
        
        Private Property _Preferred_3Implementation() As Boolean Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Preferred_3
            Get
                Return Me.Preferred_3
            End Get
            Set(ByVal value As Boolean)
                Me.Preferred_3 = value
            End Set
        End Property
        
        Private Property _Referring_PhysImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.Referring_Phys
            Get
                Return Me.Referring_Phys
            End Get
            Set(ByVal value As String)
                Me.Referring_Phys = value
            End Set
        End Property
        
        Private Property _BC_notesImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.BC_notes
            Get
                Return Me.BC_notes
            End Get
            Set(ByVal value As String)
                Me.BC_notes = value
            End Set
        End Property
        
        Private Property _KJB_notesImplementation() As String Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.KJB_notes
            Get
                Return Me.KJB_notes
            End Get
            Set(ByVal value As String)
                Me.KJB_notes = value
            End Set
        End Property
        
        Private Property _PCP_f_u_doneImplementation() As Boolean Implements Global.LightSwitchApplication.Patient_Main.DetailsClass.IImplementation.PCP_f_u_done
            Get
                Return Me.PCP_f_u_done
            End Get
            Set(ByVal value As Boolean)
                Me.PCP_f_u_done = value
            End Set
        End Property
        
        #Region "IEntityImplementation Members"
        Private __host As Global.Microsoft.LightSwitch.Internal.IEntityImplementationHost
        
        Private ReadOnly Property __HostImplementation() As Global.Microsoft.LightSwitch.Internal.IEntityImplementationHost Implements Global.Microsoft.LightSwitch.Internal.IEntityImplementation.Host
            Get
                Return Me.__host
            End Get
        End Property
        
        Private Sub _Initialize(ByVal host As Global.Microsoft.LightSwitch.Internal.IEntityImplementationHost) Implements Global.Microsoft.LightSwitch.Internal.IEntityImplementation.Initialize
            Me.__host = host
        End Sub
        
        Protected Overrides Sub OnPropertyChanged(ByVal propertyName As String)
            MyBase.OnPropertyChanged(propertyName)
        
            If Not Me.__host Is Nothing Then
                Me.__host.RaisePropertyChanged(propertyName)
            End If
        End Sub
        #End Region
    End Class
    
End Namespace

