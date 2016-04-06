<#
This simple PowerShell routine scripts out all the user-defined functions,
stored procedures, tables and views in all the databases on the server that
you specify, to the path that you specify.
SMO must be installed on the machine (it happens if SSMS is installed)
Warning: Be sure to include a "\" at the end of the path variable or it will merge the folder name with the database name 
#>

Param(
    # ServerName
    [Parameter(Mandatory=$true)]
    [ValidatePattern("[a-zA-Z0-9]*")]
    [String]
    $ServerName,

    # path
    [Parameter(Mandatory=$true)]
    [String]
    $path
)
 
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO')
$serverInstance = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $ServerName
 
$IncludeTypes = @(“tables”,”StoredProcedures”,"Views","UserDefinedFunctions")
$ExcludeSchemas = @(“sys”,”Information_Schema”)
 
 
$so = new-object (‘Microsoft.SqlServer.Management.Smo.ScriptingOptions’)
$so.IncludeIfNotExists = 0
$so.SchemaQualify = 1
$so.AllowSystemObjects = 0
$so.ScriptDrops = 0         #Script Drop Objects
 
$dbs=$serverInstance.Databases
foreach ($db in $dbs)
{
       $dbname = "$db".replace("[","").replace("]","")
       $dbpath = "$path"+"$dbname" + "\"
    if ( !(Test-Path $dbpath))
           {$null=new-item -type directory -name "$dbname"-path "$path"}
 
       foreach ($Type in $IncludeTypes)
       {
              $objpath = "$dbpath" + "$Type" + "\"
         if ( !(Test-Path $objpath))
           {$null=new-item -type directory -name "$Type"-path "$dbpath"}
              foreach ($objs in $db.$Type)
              {
                     If ($ExcludeSchemas -notcontains $objs.Schema ) 
                      {
                           $ObjName = "$objs".replace("[","").replace("]","")                  
                           $OutFile = "$objpath" + "$ObjName" + ".sql"
                           $objs.Script($so)+"GO" | out-File $OutFile #-Append
                      }
              }
       }     
}