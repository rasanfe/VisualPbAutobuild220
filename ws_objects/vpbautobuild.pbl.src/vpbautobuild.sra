$PBExportHeader$vpbautobuild.sra
$PBExportComments$Generated Application Object
forward
global type vpbautobuild from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
string gs_appdir, gs_SetupFile, gs_AutoPath
boolean gb_auto=FALSE
n_cst_functions gn_fn
String gs_version, gs_platform, gs_logo
end variables

global type vpbautobuild from application
string appname = "vpbautobuild"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 22.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = "icono.ico"
string appruntimeversion = "22.2.0.3356"
boolean manualsession = false
boolean unsupportedapierror = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
end type
global vpbautobuild vpbautobuild

type prototypes
//Funcion para tomar el directorio de la aplicacion  -64Bits 
FUNCTION	uLong	GetModuleFileName ( uLong lhModule, ref string sFileName, ulong nSize )  LIBRARY "Kernel32.dll" ALIAS FOR "GetModuleFileNameW"
end prototypes

type variables

end variables

on vpbautobuild.create
appname="vpbautobuild"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on vpbautobuild.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String ls_path, ls_pbyear
environment env
integer rtn
ulong lul_handle
Constant String ls_ExeFile="vpbautobuild.exe"
Constant String ls_DeploymentPath="C:\proyecto pw2022\Blog\PowerBuilder\vpbautobuild"
Boolean  lb_RunTime =FALSE
String ls_version, ls_build, ls_revision

rtn = GetEnvironment(env)

IF rtn <> 1 THEN 
	ls_pbyear= string(year(today()))
	gs_version = ls_pbyear
	gs_platform="32"
ELSE
	ls_pbyear = "20"+ string(env.pbmajorrevision)
	gs_version =ls_pbyear+ "." + string(env.pbbuildnumber)
	gs_platform=string(env.ProcessBitness)
END IF

gs_platform += " Bits"

ls_Path = space(1024)
SetNull(lul_handle)
GetModuleFilename(lul_handle, ls_Path, len(ls_Path))

if right(UPPER(ls_path), 7)="220.EXE" or right(UPPER(ls_path), 7)="X64.EXE" then
	ls_path=ls_DeploymentPath+"\"+ls_ExeFile
	lb_RunTime = TRUE
end if

gs_appdir=left(ls_path, len(ls_path) - (len(ls_ExeFile) + 1))  

gs_logo = gs_appdir+"/logo.jpg"

//Añado la Versión del Programa
IF lb_RunTime = FALSE THEN
	n_osversion in_osver
	in_osver.of_GetFileVersionInfo(gs_appdir+"\"+ls_exeFile)
	ls_version=in_osver.FixedProductVersion
	ls_revision = mid(ls_version, lastPos(ls_version, ".") + 1, len(ls_version) - lastPos(ls_version, "."))
	ls_build= gn_fn.of_replaceall(ls_version , "."+ls_revision, "")
	ls_build = mid(ls_build, lastPos(ls_build, ".") + 1, len(ls_build) - lastPos(ls_build, "."))
	gs_version =  ls_pbyear+"."+ls_build+"."+ls_revision
END IF

open(w_main)
end event

