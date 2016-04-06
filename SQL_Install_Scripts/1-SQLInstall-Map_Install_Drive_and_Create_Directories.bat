REM -----------------------------------------------------

REM Purpose: Map SQL Install share & create standard directories on the E: drive

REM Created 20121108DO

REM See Document "Installing SQL2012 Ent on Win 2008R2 Ent.docx"


REM -----------------------------------------------------

REM ----- Map Install Directory to Z: -----

net use Z: \\ohsu.edu\share\APP\SQL /PERSISTENT:YES


REM ----- Create SQL Directories -----

E:

md TLOGS

md MSSQL

md DataCollection