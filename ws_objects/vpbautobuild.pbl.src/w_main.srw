$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type pb_setup from picturebutton within w_main
end type
type p_logo from picture within w_main
end type
type st_copyright from statictext within w_main
end type
type sle_project_type from singlelineedit within w_main
end type
type st_project_type from statictext within w_main
end type
type sle_projectname from singlelineedit within w_main
end type
type st_projectname from statictext within w_main
end type
type st_minimum_revision from statictext within w_main
end type
type sle_minimum from singlelineedit within w_main
end type
type st_minimum from statictext within w_main
end type
type st_expiration from statictext within w_main
end type
type st_availale from statictext within w_main
end type
type dp_expiration from datepicker within w_main
end type
type dp_availale from datepicker within w_main
end type
type st_revision from statictext within w_main
end type
type st_build from statictext within w_main
end type
type st_minor from statictext within w_main
end type
type st_major from statictext within w_main
end type
type sle_revision from singlelineedit within w_main
end type
type sle_build from singlelineedit within w_main
end type
type sle_minor from singlelineedit within w_main
end type
type sle_major from singlelineedit within w_main
end type
type pb_build from picturebutton within w_main
end type
type st_myversion from statictext within w_main
end type
type st_platform from statictext within w_main
end type
type st_3 from statictext within w_main
end type
type sle_json from singlelineedit within w_main
end type
type pb_abrir_json from picturebutton within w_main
end type
type gb_product_version from groupbox within w_main
end type
type gb_powerclient from groupbox within w_main
end type
type r_2 from rectangle within w_main
end type
type pb_exit from picturebutton within w_main
end type
type lb_json from listbox within w_main
end type
end forward

global type w_main from window
integer width = 2894
integer height = 1788
boolean titlebar = true
string title = "Visual PbAutobuild220"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_setup pb_setup
p_logo p_logo
st_copyright st_copyright
sle_project_type sle_project_type
st_project_type st_project_type
sle_projectname sle_projectname
st_projectname st_projectname
st_minimum_revision st_minimum_revision
sle_minimum sle_minimum
st_minimum st_minimum
st_expiration st_expiration
st_availale st_availale
dp_expiration dp_expiration
dp_availale dp_availale
st_revision st_revision
st_build st_build
st_minor st_minor
st_major st_major
sle_revision sle_revision
sle_build sle_build
sle_minor sle_minor
sle_major sle_major
pb_build pb_build
st_myversion st_myversion
st_platform st_platform
st_3 st_3
sle_json sle_json
pb_abrir_json pb_abrir_json
gb_product_version gb_product_version
gb_powerclient gb_powerclient
r_2 r_2
pb_exit pb_exit
lb_json lb_json
end type
global w_main w_main

type prototypes

end prototypes

type variables
Private:
String is_JWTClassTemplateName
String is_projectName, is_project_type, is_authtemplate, is_solutionname, is_RuntimeVersion, is_WebAPIURL
String is_DeploymentVersion,  is_iniFile
n_runandwait in_rwait
String is_JsonFile, is_JsonPath
end variables

forward prototypes
private subroutine wf_modify_class (string as_classfilepath)
private function boolean wf_save_json ()
private subroutine wf_build ()
private function boolean wf_load_json ()
private function string wf_download_version_control ()
public function string wf_download_inifile ()
private function boolean wf_load_version (string as_filepathcontrol)
end prototypes

private subroutine wf_modify_class (string as_classfilepath);integer li_FileNum, li_rtn
blob lbl_data
String ls_Emp_Input
String ls_classname
String ls_UserName, ls_UserPass, ls_Scope, ls_Name, ls_GivenName, ls_FamilyName, ls_WebSite, ls_Email, ls_EmailVerified

li_FileNum = FileOpen(as_ClassFilePath,  TextMode!)
FileReadEx(li_FileNum,lbl_data)
FileClose(li_FileNum)

ls_Emp_Input= String(lbl_data, EncodingANSI!)

SetNull(lbl_data)

ls_UserName = gn_fn.of_ProfileString( is_JsonFile, "UserName", "")
ls_UserPass =  gn_fn.of_decodebase64url(gn_fn.of_ProfileString( is_JsonFile, "UserPass", ""))

//La información del Claim se puede guardar en general para todos los proyectos o especificar indiviualmente.
ls_Scope = gn_fn.of_ProfileString( is_JsonFile, "Scope", "")
ls_Name =  gn_fn.of_ProfileString( is_JsonFile, "Name","")
ls_GivenName  = gn_fn.of_ProfileString( is_JsonFile, "GivenName", "")
ls_FamilyName =  gn_fn.of_ProfileString( is_JsonFile, "FamilyName", "")
ls_WebSite =  gn_fn.of_ProfileString( is_JsonFile, "WebSite", "")
ls_Email  =  gn_fn.of_ProfileString( is_JsonFile, "Email", "")
ls_EmailVerified =  gn_fn.of_ProfileString( is_JsonFile, "EmailVerified","")

ls_Emp_Input = gn_fn.of_replaceall(ls_Emp_Input, char(34)+"UserName"+char(34), char(34)+ls_UserName+char(34))
ls_Emp_Input = gn_fn.of_replaceall(ls_Emp_Input, char(34)+"UserPass"+char(34), char(34)+ls_UserPass+char(34))
ls_Emp_Input = gn_fn.of_replaceall(ls_Emp_Input, char(34)+"Scope"+char(34), char(34)+ls_Scope+char(34))
ls_Emp_Input = gn_fn.of_replaceall(ls_Emp_Input, char(34)+"Name"+char(34), char(34)+ls_Name+char(34))
ls_Emp_Input = gn_fn.of_replaceall(ls_Emp_Input, char(34)+"GivenName"+char(34), char(34)+ls_GivenName+char(34))
ls_Emp_Input = gn_fn.of_replaceall(ls_Emp_Input, char(34)+"FamilyName"+char(34), char(34)+ls_FamilyName+char(34))
ls_Emp_Input = gn_fn.of_replaceall(ls_Emp_Input, char(34)+"WebSite"+char(34), char(34)+ls_WebSite+char(34))
ls_Emp_Input = gn_fn.of_replaceall(ls_Emp_Input, char(34)+"Email"+char(34), char(34)+ls_Email+char(34))
ls_Emp_Input = gn_fn.of_replaceall(ls_Emp_Input, char(34)+"EmailVerified"+char(34), char(34)+ls_EmailVerified+char(34))

FileDelete(as_ClassFilePath)

li_FileNum = FileOpen(as_ClassFilePath, StreamMode!, Write!)

lbl_data = Blob(ls_Emp_Input, EncodingANSI!)

li_rtn = FileWriteEx(li_FileNum, lbl_data)

FileClose(li_FileNum)
end subroutine

private function boolean wf_save_json ();String ls_ProductVersion1, ls_ProductVersion2, ls_ProductVersion3, ls_ProductVersion4
Datetime ldt_AvailabeTime, ldt_ExpirationTime
String ls_ProductVersion, ls_FileVersion, ls_MinimumCompatibleVersion, ls_DeploymentVersion
Boolean lb_return=TRUE
Boolean lb_ClearSrcBeforeDownload =TRUE // Pongo este Valor en TRUE Para que se borre el contenido de la carpeta de descarga antes.
String ls_dir, ls_target, ls_ApiPath, ls_exe
String ls_AuthTemplate
u_json lu_jsonObject

lu_jsonObject = create u_json

ls_ProductVersion1 = sle_major.Text 
ls_ProductVersion2 = sle_minor.Text 
ls_ProductVersion3 = sle_build.Text 
ls_ProductVersion4 = sle_revision.Text
ldt_AvailabeTime =dp_availale.value
ldt_ExpirationTime  = dp_expiration.value 
ls_MinimumCompatibleVersion = sle_minimum.Text

ls_DeploymentVersion = ls_ProductVersion4

ls_ProductVersion=ls_ProductVersion1+"."+ls_ProductVersion2+"."+ls_ProductVersion3+"."+ls_ProductVersion4
ls_FileVersion = ls_ProductVersion

try
	lu_jsonObject.of_load_file(is_JsonPath)
	
	//Actualizo el Runtime:
	lu_jsonObject.of_get_node("MetaInfo").of_get_node("RuntimeVersion").of_set_value(is_RunTimeVersion)
	
	//Obtengo el Directorio y el Target
	ls_target = lu_jsonObject.of_get_node("BuildPlan").of_get_node("SourceControl").of_get_node("Merging").of_get_node(1).of_get_node("Target").of_get_value_string()
	ls_dir = 	lu_jsonObject.of_get_node("BuildPlan").of_get_node("SourceControl").of_get_node("Merging").of_get_node(1).of_get_node("LocalProjectPath").of_get_value_string()
	ls_target = gn_fn.of_replaceall(ls_target, ls_dir+"\", "")
	
	//MOdificamos las rutas
	ls_dir = gs_appdir+"\src"
	ls_target = ls_dir +"\"+ls_target 
	
	
	lu_jsonObject.of_get_node("BuildPlan").of_get_node("SourceControl").of_get_node("ClearSrcBeforeDownload").of_set_value(lb_ClearSrcBeforeDownload)
	lu_jsonObject.of_get_node("BuildPlan").of_get_node("SourceControl").of_get_node("Git").of_get_node(1).of_get_node("DestPath").of_set_value(ls_dir)
	lu_jsonObject.of_get_node("BuildPlan").of_get_node("SourceControl").of_get_node("Merging").of_get_node(1).of_get_node("Target").of_set_value(ls_target)
	lu_jsonObject.of_get_node("BuildPlan").of_get_node("SourceControl").of_get_node("Merging").of_get_node(1).of_get_node("LocalProjectPath").of_set_value(ls_dir)
	lu_jsonObject.of_get_node("BuildPlan").of_get_node("BuildJob").of_get_node("Projects").of_get_node(1).of_get_node("Target").of_set_value(ls_target)	
	
	
	IF is_project_type ="PowerClient" or is_project_type = "PowerServer" THEN
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("General").of_get_node("PropertiesDisplayedForExecutable").of_get_node("ProductVersion").of_set_value(ls_ProductVersion)
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("General").of_get_node("PropertiesDisplayedForExecutable").of_get_node("FileVersion").of_set_value(ls_FileVersion)
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("General").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(4).of_set_value(integer(ls_DeploymentVersion))
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("General").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("FileVersion").of_get_node(4).of_set_value(integer(ls_DeploymentVersion))

		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("ClientDeployment").of_get_node("DeploymentVersion").of_set_value(ls_DeploymentVersion)
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("ClientDeployment").of_get_node("MinimumCompatibleVersion").of_set_value(ls_MinimumCompatibleVersion)
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("ClientDeployment").of_get_node("AvailabeTime").of_set_value(ldt_AvailabeTime, "yyyy-m-d h:m:s")
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("ClientDeployment").of_get_node("ExpirationTime").of_set_value(ldt_ExpirationTime, "yyyy-m-d h:m:s")
	ELSE
		ls_exe = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("General").of_get_node("ExecutableFileName").of_get_value_string()
		ls_exe  = mid(ls_exe, lastpos(ls_exe , "\") +1 , len(ls_exe ) - lastpos(ls_exe , "\"))
		ls_exe = ls_dir +"\"+ls_exe
		
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("General").of_get_node("ExecutableFileName").of_set_value(ls_exe)
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Run").of_get_node("Application").of_set_value(ls_exe)
		
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Version").of_get_node("PropertiesDisplayedForExecutable").of_get_node("ProductVersion").of_set_value(ls_ProductVersion)
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Version").of_get_node("PropertiesDisplayedForExecutable").of_get_node("FileVersion").of_set_value(ls_FileVersion)
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Version").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(4).of_set_value(integer(ls_DeploymentVersion))
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Version").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("FileVersion").of_get_node(4).of_set_value(integer(ls_DeploymentVersion))
	END IF
	
	
	IF is_project_type = "PowerServer" THEN
		//ls_SolutionName= lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("WebAPIs").of_get_node("SolutionGeneration").of_get_node("SolutionName").of_get_value_string()
		ls_ApiPath = ls_dir +"\repos"
		lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("WebAPIs").of_get_node("SolutionGeneration").of_get_node("SolutionLocation").of_set_value(ls_ApiPath)
		ls_AuthTemplate = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("WebAPIs").of_get_node("SolutionGeneration").of_get_node("AuthTemplate").of_get_value_string()
		//Añadimos comando para copiar INI de configuracion JWT de la API no subido a repositorio por seguridad.
		IF is_iniFile <> "" AND ls_AuthTemplate = "IncludeCustomJWTServer" THEN
			lu_jsonObject.of_get_node("BuildPlan").of_get_node("SourceControl").of_get_node("PostCommand").of_set_value(gs_appdir+"\copiarini.bat")	
		END IF
	ELSE
		//Añadimos en Proyectos Nativos C/S y PowerClient archivo de configuración con conexion a Base de Datos
		IF is_iniFile <> "" THEN
			lu_jsonObject.of_get_node("BuildPlan").of_get_node("SourceControl").of_get_node("PostCommand").of_set_value(gs_appdir+"\copiarini.bat")	
		END IF
	END IF	
	
	IF FileDelete(is_JsonPath) THEN	
		lu_jsonObject.of_save_to_file(is_JsonPath)
	ELSE
		gn_fn.of_error("File locked by another process")
	END IF	

catch (exception le_ex)
	gn_fn.of_error(le_ex.getmessage())
	lb_return = FALSE
end try

destroy lu_jsonObject

RETURN lb_return
end function

private subroutine wf_build ();Boolean lb_rtn
String  ls_script, ls_result, ls_error, ls_JWTClassPath, ls_PowerServerPath, ls_PBNativePath, ls_pbAutobuildPath, ls_TokenURL
String ls_iniFilePath,  ls_IniUsersKey,  ls_IniTokenKey,  ls_IniConnectionKey

SetPointer(HourGlass!)

IF is_JsonPath="" THEN RETURN

IF NOT wf_save_json() THEN
	RETURN
END IF	

//Crear Bat para copiar INI con credenciales API en Proyectos PowerServer / Datos Conexion Base de Datos en Proyectos PowerClient y Nativos
is_iniFile = gn_fn.of_ProfileString( is_JsonFile, "IniFie", "")

IF is_iniFile <> "" THEN
	IF is_project_type = "PowerServer" THEN
		 ls_IniUsersKey= gn_fn.of_ProfileString( is_JsonFile, "IniUsersKey", "Users")
		 ls_IniTokenKey= gn_fn.of_ProfileString( is_JsonFile, "IniTokenKey", "Setup")
		//Revisamos las plantillas de Segurdidad de la API.
		IF is_AuthTemplate <>"Default" and is_AuthTemplate<> "IncludeCustomJWTServer" THEN
			gn_fn.of_error("Plantilla de Seguridad Powerserver "+is_AuthTemplate+" no Implementada !" )
			RETURN
		END IF	
		//Crear Bat para copiar ini de configuración de PowerServer no Publicado en Repositorio	
		 IF is_AuthTemplate = "IncludeCustomJWTServer" THEN
			ls_iniFilePath = wf_download_iniFile()
			IF ls_iniFilePath = "" THEN RETURN
			SetProfileString ( ls_iniFilePath,  ls_IniUsersKey , "UserName",  gn_fn.of_ProfileString( is_JsonFile, "UserName", ""))
			SetProfileString ( ls_iniFilePath,  ls_IniUsersKey , "UserPass",  gn_fn.of_ProfileString( is_JsonFile, "UserPass", ""))
			ls_TokenURL = is_WebAPIURL +"/connect/token"
			SetProfileString ( ls_iniFilePath,  ls_IniTokenKey , "TokenURL",  ls_TokenURL)
			ls_script = "copy /y "+char(34)+ls_iniFilePath+char(34)+ " "+char(34)+gs_appdir+"\src\CloudSetting.ini"+char(34) 
			lb_rtn  = gn_fn.of_create_bat(ls_script,  gs_appdir+"\copiarini.bat")
		END IF	
	ELSE
		ls_IniConnectionKey = gn_fn.of_ProfileString( is_JsonFile, "IniConnectionKey", "Setup")
		
		//Si Indicamos archivo ini de Configuracion de Base de Datos Habrá que descargarlos para rellenarlo.
		IF 	is_iniFile <> "" THEN
			ls_iniFilePath = wf_download_iniFile()
			IF ls_iniFilePath = "" THEN RETURN
			
			//Crear Bat para copiar ini de configuración de base de dastos Cliente/Servidor no Publicado en Repositorio	
			SetProfileString ( ls_iniFilePath, ls_IniConnectionKey, "DBMS",  gn_fn.of_ProfileString( is_JsonFile, "DBMS", ""))
			SetProfileString ( ls_iniFilePath, ls_IniConnectionKey, "LogPass",  gn_fn.of_ProfileString( is_JsonFile, "LogPass", ""))
			SetProfileString ( ls_iniFilePath, ls_IniConnectionKey, "ServerName",  gn_fn.of_ProfileString( is_JsonFile, "ServerName", ""))
			SetProfileString ( ls_iniFilePath, ls_IniConnectionKey, "LogId",  gn_fn.of_ProfileString( is_JsonFile, "LogId", ""))
			SetProfileString ( ls_iniFilePath, ls_IniConnectionKey, "AutoCommit",  gn_fn.of_ProfileString( is_JsonFile, "AutoCommit", ""))
			SetProfileString ( ls_iniFilePath, ls_IniConnectionKey, "DBParm",  gn_fn.of_ProfileString( is_JsonFile, "DBParm", ""))
			ls_script = "copy /y "+char(34)+ls_iniFilePath+char(34)+ " "+char(34)+gs_appdir+"\src\"+is_iniFile+char(34) 
			lb_rtn  = gn_fn.of_create_bat(ls_script,  gs_appdir+"\copiarini.bat")
		END IF
	END IF
END IF

//1 - Ejecutamos PbAutobuild 2022:
ls_pbAutobuildPath = 	ProfileString(gs_SetupFile, "setup", "PbAutobuildPath", "")
if trim(ls_pbAutobuildPath)<>"" and right(ls_pbAutobuildPath, 1) <> "\" then  ls_pbAutobuildPath += "\" 
ls_pbAutobuildPath+="pbautobuild220.exe"

ls_script = char(34)+ls_pbAutobuildPath+char(34)+" /f "+char(34)+is_JsonPath+char(34)+" /l "+char(34)+gs_appdir+"\Log_PCBuild.log"+char(34)+ " /le "+char(34)+gs_appdir+"\Log_PCError.log"+char(34)

gn_fn.of_log("Start "+ls_pbAutobuildPath)
lb_rtn  = in_rwait.of_run(ls_script, Normal!)
//lb_rtn  =  gn_fn.of_run_bat(ls_script, "build.bat")

// check return code
IF lb_rtn = FALSE THEN
	gn_fn.of_error( "¡ Pbautobuild220 Error !")
	 RETURN
END IF

//Copy Pb Autobuild Logs to my log
gn_fn.of_copy_pbautobuild_logs(gs_appdir+"\Log_PCBuild.log", gs_appdir +"\Log_Build.log")
gn_fn.of_copy_pbautobuild_logs(gs_appdir+"\Log_PCError.log", gs_appdir +"\Log_Error.log")
gn_fn.of_log("End "+ls_pbAutobuildPath)

//2 -Revisamos Opciones en Proyectos PowerServer
IF is_project_type = "PowerServer" THEN

	//2.1.1- Detener el Servicio de la Api
	ls_script = "%windir%\system32\inetsrv\appcmd stop site /site.name:"+is_SolutionName
	
	lb_rtn  = gn_fn.of_run_bat(ls_script, "stop_api.bat")

	IF lb_rtn = FALSE THEN	RETURN
	
	gn_fn.of_log("Stop Site Name: "+is_SolutionName)
	//2.1.2- Borrar la Carpera del sitio Web
		
	ls_PowerServerPath=gn_fn.of_ProfileString( is_JsonFile, "PowerServerPath", "")
	
	if right(ls_PowerServerPath, 1) <> "\" then  ls_PowerServerPath += "\" 
	ls_script = "RMDIR /s /q "+char(34)+ls_PowerServerPath +lower(is_SolutionName)+char(34)
	
	lb_rtn  = gn_fn.of_run_bat(ls_script, "delete_repos.bat")

	IF lb_rtn = FALSE THEN	RETURN
	
	gn_fn.of_log("Delete Site Path: "+ls_PowerServerPath +lower(is_SolutionName))
	
	//2.1.3- Copiar Archivo DefaultUserStore.cs
	IF is_AuthTemplate = "IncludeCustomJWTServer" THEN
		
		ls_script = "copy /y "+char(34)+gs_appdir+"\"+is_JWTClassTemplateName+char(34)+ " "+char(34)+gs_appdir+"\src\repos\"+lower(is_SolutionName)+"\ServerAPIs\Authentication\JWT\Impl\"+is_JWTClassTemplateName+char(34) 
				
		lb_rtn  = gn_fn.of_run_bat(ls_script, "copy_class.bat")
	
		IF lb_rtn = FALSE THEN	RETURN
		
		//Inyecto las credenciales de Archivo Ini de la app y la info de los Claims de mi archivo Setup.ini
		ls_JWTClassPath = gs_appdir+"\src\repos\"+lower(is_SolutionName)+"\ServerAPIs\Authentication\JWT\Impl\"+is_JWTClassTemplateName
		wf_modify_class(ls_JWTClassPath)
		gn_fn.of_log("Add JWT Class Template: "+is_JWTClassTemplateName)
	END IF
	//2.1.4- Publicar Sitio Web
	ls_script = "dotnet.exe publish "+char(34)+gs_appdir+"\src\repos\"+lower(is_SolutionName)+"\ServerAPIs\ServerAPIs.csproj"+char(34)+" -c release -o "+ls_PowerServerPath+lower(is_SolutionName)
	
	lb_rtn  = gn_fn.of_run_bat(ls_script, "publish_api.bat")

	IF lb_rtn = FALSE THEN	RETURN
	
	gn_fn.of_log("Publish Site Name: "+is_SolutionName)
	//2.1.5- Reactivar el Servicio de la Api
	ls_script = "%windir%\system32\inetsrv\appcmd start site /site.name:"+is_SolutionName
	
	lb_rtn  = gn_fn.of_run_bat(ls_script, "start_api.bat")

	IF lb_rtn = FALSE THEN	RETURN
	
		gn_fn.of_log("Start Site Name: "+is_SolutionName)
	 //2.1.6- Borrar el archivo Copiarini.bat
	 IF  is_iniFile <> "" AND is_AuthTemplate = "IncludeCustomJWTServer" THEN
		Filedelete(gs_appdir+"\copiarini.bat")
	//2.1.7 Eliminar archivo INI Panltilla 
		Filedelete(ls_iniFilePath)
	END IF
ELSE
	IF is_iniFile <> "" THEN
		//2.2.1 Borrar el archivo Copiarini.bat 
		Filedelete(gs_appdir+"\copiarini.bat")
		//2.2.2 Eliminar archivo INI descargado de Git
		Filedelete(ls_iniFilePath)
	END IF
END IF


//3- Eminiar Fuentes Descargadas
IF  is_project_type <> "PB Native" THEN 
	//3.1   Eliminar Directorio Completo src en aplicaciones PowerClient/PowerServer Publicadas.
	ls_script = "RMDIR /s /q "+char(34)+gs_appdir+"\src"+char(34)
	
	lb_rtn  = gn_fn.of_run_bat(ls_script, "delete_source.bat")
	gn_fn.of_log("Delete Source Code: "+gs_appdir+"\src")
ELSE
	//3.2- Eliminar fuentes y dejar Programa Nativo Compilado en Directorio con nombre del proyecto.
	
	ls_PBNativePath=gn_fn.of_ProfileString( is_JsonFile, "PBNativePath", gs_appdir)
	
	if trim(ls_PBNativePath)= "" then ls_PBNativePath = gs_appdir
	if right(ls_PBNativePath, 1) <> "\" then  ls_PBNativePath += "\" 
	
	ls_script = "RMDIR /s /q "+char(34)+ls_PBNativePath +is_projectName+char(34)
	
	lb_rtn  = gn_fn.of_run_bat(ls_script, "delete_nativepath.bat")

	IF lb_rtn = FALSE THEN	RETURN

	ls_script = "RD "+char(34)+gs_appdir+"\src\ws_objects\"+char(34)+" /S /Q" +"~r~n"
	ls_script += "RD "+char(34)+gs_appdir+"\src\.git\"+char(34)+" /S /Q" +"~r~n"
	ls_script += "DEL "+char(34)+gs_appdir+"\src\*.pbl"+char(34)+" /S /Q /F" +"~r~n"
	ls_script += "DEL "+char(34)+gs_appdir+"\src\*.pbt"+char(34)+" /S /Q /F" +"~r~n"
	ls_script += "DEL "+char(34)+gs_appdir+"\src\*.pbw"+char(34)+" /S /Q /F" +"~r~n"
	ls_script += "DEL "+char(34)+gs_appdir+"\src\*.pbp"+char(34)+" /S /Q /F" +"~r~n"
	ls_script += "DEL "+char(34)+gs_appdir+"\src\*.opt"+char(34)+" /S /Q /F" +"~r~n"
	ls_script += "DEL "+char(34)+gs_appdir+"\src\CloudSetting.ini"+char(34)+" /S /Q /F" +"~r~n"
	ls_script += "MOVE "+char(34)+gs_appdir+"\src"+char(34)+" "+char(34)+ls_PBNativePath+is_projectName+char(34)

	lb_rtn  = gn_fn.of_run_bat(ls_script, "delete_source.bat")
	gn_fn.of_log("Delete Source Code: "+gs_appdir+"\src")
	gn_fn.of_log("Compiled Path: "+gs_appdir+"\"+is_projectName)

END IF
SetPointer(Arrow!)
gn_fn.of_log(fill("*", 60))
end subroutine

private function boolean wf_load_json ();//La función sólo devuelve False si se ejecuta el programa de forma autómatica y está activado el Parametro version_control="S" en setup.ini
// Y al descargar el archivo *.srj se comprubea que la versión no es superior.

String ls_DeploymentVersion
Datetime ldt_AvailabeTime, ldt_ExpirationTime
String ls_MinimumCompatibleVersion
Integer li_ProductVersion1,  li_ProductVersion2,  li_ProductVersion3,  li_ProductVersion4
Integer li_ProjectType 
u_json lu_jsonObject
Boolean lb_rtn
String ls_auto, ls_control, ls_FilePathControl

gn_fn.of_log("Load Json: "+is_JsonFile)
lu_jsonObject = create u_json
try
	lu_jsonObject.of_load_file(is_JsonPath)
	
	is_RuntimeVersion =  lu_jsonObject.of_get_node("MetaInfo").of_get_node("RuntimeVersion").of_get_value_string()
	is_projectName =  lu_jsonObject.of_get_node("Projects").of_get_node(1).of_get_key()
	li_ProjectType = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("ProjectType").of_get_value_number()
	IF li_ProjectType = 0 then
		
		//Esto no sirve mas que para hacer bonito en la pantalla
		ls_DeploymentVersion =  string(lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Version").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(4).of_get_value_number())
		ls_MinimumCompatibleVersion=  string(lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Version").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(4).of_get_value_number())
		ldt_AvailabeTime =  datetime(today(), now())
		ldt_ExpirationTime= datetime(date("31-12-"+string(year(today()))), time("23:59"))
		//---------------------------------------------------------------------------------------------------------
		
		li_ProductVersion1 = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Version").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(1).of_get_value_number()
		li_ProductVersion2 = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Version").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(2).of_get_value_number()
		li_ProductVersion3 = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Version").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(3).of_get_value_number()
		li_ProductVersion4 = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("Version").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(4).of_get_value_number()
	ELSE	
		ls_DeploymentVersion =  lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("ClientDeployment").of_get_node("DeploymentVersion").of_get_value_string()
		ls_MinimumCompatibleVersion=  lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("ClientDeployment").of_get_node("MinimumCompatibleVersion").of_get_value_string()
		ldt_AvailabeTime = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("ClientDeployment").of_get_node("AvailabeTime").of_get_value_datetime()
		ldt_ExpirationTime= lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("ClientDeployment").of_get_node("ExpirationTime").of_get_value_datetime()
		li_ProductVersion1 = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("General").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(1).of_get_value_number()
		li_ProductVersion2 = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("General").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(2).of_get_value_number()
		li_ProductVersion3 = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("General").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(3).of_get_value_number()
		li_ProductVersion4 = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("General").of_get_node("ExecutableVersionUsedByInstaller").of_get_node("ProductVersion").of_get_node(4).of_get_value_number()
	END IF
	
	if li_ProjectType = 2 then
		is_SolutionName =  lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("WebAPIs").of_get_node("SolutionGeneration").of_get_node("SolutionName").of_get_value_string()
		is_AuthTemplate = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("WebAPIs").of_get_node("SolutionGeneration").of_get_node("AuthTemplate").of_get_value_string()
		is_WebAPIURL = lu_jsonObject.of_get_node("Projects").of_get_node(is_projectName ).of_get_node("WebAPIs").of_get_node("WebAPIURL").of_get_node("WebAPIURL").of_get_value_string()
	else
		is_SolutionName =  ""
	end if	
catch (exception le_ex)
	gn_fn.of_error(le_ex.getmessage())
	RETURN FALSE
end try

//Para el PowerClient
ls_DeploymentVersion = string(dec(ls_DeploymentVersion))

sle_major.Text = string(li_ProductVersion1)
sle_minor.Text = string(li_ProductVersion2)
sle_build.Text = string(li_ProductVersion3)
sle_revision.Text =  string(li_ProductVersion4)
sle_minimum.Text = ls_MinimumCompatibleVersion
dp_availale.value = ldt_AvailabeTime
dp_expiration.value = ldt_ExpirationTime 
sle_projectName.text = is_projectName

//Guardo Versioón de De PowerClient para Control Automatico de Vesiónes de GIT
is_DeploymentVersion = ls_DeploymentVersion

choose case li_Projecttype
	case 0
		is_project_type = "PB Native"
		gb_powerclient.enabled=FALSE
		dp_availale.enabled=FALSE
		dp_expiration.enabled=FALSE
		sle_minimum.enabled=FALSE
	case 1
		is_project_type= "PowerClient"
		gb_powerclient.enabled=TRUE
		dp_availale.enabled=TRUE
		dp_expiration.enabled=TRUE
		sle_minimum.enabled=TRUE
	case 2
		is_project_type = "PowerServer"
		gb_powerclient.enabled=TRUE
		dp_availale.enabled=TRUE
		dp_expiration.enabled=TRUE
		sle_minimum.enabled=TRUE
end choose		

sle_project_type.text  = is_project_type
gb_powerclient.text  = is_project_type

destroy lu_jsonObject

ls_control = upper(gn_fn.of_ProfileString( is_JsonFile, "version_control", "N"))

//El control de Versiones sólo cuando s eejecuta en Automático.
IF gb_auto= TRUE AND ls_control="S" THEN
	ls_FilePathControl=  wf_download_version_control()
	if ls_FilePathControl <> "" then lb_rtn = wf_load_version(ls_FilePathControl)
	FileDelete(ls_FilePathControl)
ELSE
	lb_rtn =TRUE
END IF	

RETURN lb_rtn
end function

private function string wf_download_version_control ();String ls_ProjectFileName, ls_ProjectFilePath,  ls_FilePath, ls_Pbl, ls_GitHubProfileName, ls_GitHubRepository, ls_GitBranch
String ls_ProfileVisibility, ls_PersonalToken
String ls_url 

ls_ProfileVisibility = gn_fn.of_ProfileString( is_JsonFile, "ProfileVisibility", "Public")
ls_GitHubProfileName = gn_fn.of_ProfileString( is_JsonFile, "GitHubProfileName", "")
ls_GitHubRepository = gn_fn.of_ProfileString( is_JsonFile, "GitHubRepository", "")
ls_GitBranch = gn_fn.of_ProfileString( is_JsonFile, "GitBranch", "main")
ls_Pbl = gn_fn.of_ProfileString( is_JsonFile, "Pbl" , "")

IF lower(ls_ProfileVisibility) = "private" THEN
	ls_PersonalToken = gn_fn.of_decodebase64url(gn_fn.of_ProfileString( is_JsonFile, "PersonalToken", ""))
ELSE
	ls_PersonalToken = ""
END IF

ls_ProjectFileName = gn_fn.of_ProfileString( is_JsonFile, "ProjectFileName", "")

gn_fn.of_log("Downloand Version Control from Git Repository: "+ls_GitHubRepository)
gn_fn.of_log("Branch: "+ls_GitBranch +" PbLibrary: "+ls_Pbl+ " Project: "+ls_ProjectFileName)

ls_url =  "https://raw.githubusercontent.com/"+ls_GitHubProfileName+"/"+ls_GitHubRepository+"/"+ls_GitBranch+"/ws_objects/"+ls_pbl+".src/"+ls_ProjectFileName

ls_FilePath = gn_fn.of_replaceall(is_JsonPath, is_JsonFile,  ls_ProjectFileName)
 
ls_ProjectFilePath = gn_fn.of_download_file(ls_PersonalToken, ls_url,  ls_FilePath)

RETURN ls_ProjectFilePath






end function

public function string wf_download_inifile ();String ls_iniFilePath, ls_FilePath, ls_GitHubProfileName, ls_GitHubRepository, ls_GitBranch
String ls_url, ls_ProfileVisibility, ls_PersonalToken

ls_ProfileVisibility = gn_fn.of_ProfileString( is_JsonFile, "ProfileVisibility", "Public")
ls_GitHubProfileName = gn_fn.of_ProfileString( is_JsonFile, "GitHubProfileName", "")
ls_GitHubRepository = gn_fn.of_ProfileString( is_JsonFile, "GitHubRepository", "")
ls_GitBranch = gn_fn.of_ProfileString( is_JsonFile, "GitBranch", "main")

IF lower(ls_ProfileVisibility) = "private" THEN
	ls_PersonalToken = gn_fn.of_decodebase64url(gn_fn.of_ProfileString( is_JsonFile, "PersonalToken", ""))
ELSE
	ls_PersonalToken = ""
END IF

gn_fn.of_log("Downloand "+is_iniFile+" from Git Repository: "+ls_GitHubRepository)

ls_url = "https://raw.githubusercontent.com/"+ls_GitHubProfileName+"/"+ls_GitHubRepository+"/"+ls_GitBranch+"/"+is_iniFile

 ls_FilePath = gn_fn.of_replaceall(is_JsonPath, is_JsonFile,  is_iniFile)

ls_iniFilePath = gn_fn.of_download_file(ls_PersonalToken, ls_url,  ls_FilePath)

RETURN ls_iniFilePath
end function

private function boolean wf_load_version (string as_filepathcontrol);Integer li_Filenum
integer li_indx, li_rtn
string ls_line, ls_data
Blob lblb_file 
u_json lu_jsonObject
Datetime ldt_AvailabeTime, ldt_ExpirationTime
String ls_MinimumCompatibleVersion
Integer li_ProductVersion1,  li_ProductVersion2,  li_ProductVersion3,  li_ProductVersion4
String ls_RuntimeVersion, ls_DeployVersion

li_FileNum = FileOpen(as_FilePathControl, LineMode!, Read!, LockRead!)

IF li_FileNum < 0 THEN
	gn_fn.of_error("FileOpen "+as_filepathcontrol+" Error")
	RETURN FALSE
END IF	

li_indx = 0  
IF is_project_type="PB Native" THEN
	//Tomo como versión Product Version (PVN en fichero .srj)
	DO WHILE li_indx > -1
		li_rtn = FileReadex(li_FileNum, ls_line)  
		IF  li_rtn  = -1 THEN
			gn_fn.of_error("FileRead Error")
			EXIT
		ELSE
			li_indx ++  
			IF left(ls_line, 4)="EXE:" THEN
				ls_RuntimeVersion =  Mid(ls_line, pos(ls_line, "Runtime ") + len("Runtime "), len(ls_line))
			END IF	
			IF left(ls_line, 4)<>"PVN:" THEN
				CONTINUE
			ELSE
				EXIT
			END IF	
		END IF	
	LOOP
	
	FileClose(li_FileNum)
	
	li_ProductVersion1 = integer( mid(ls_line, pos(ls_line, ":") + 1, pos(ls_line, ",") - pos(ls_line, ":")  - 1) )
	
	ls_line = gn_fn.of_replaceall(ls_line, "PVN:"+string(li_ProductVersion1)+",", "")
	
	li_ProductVersion2 =  integer(left(ls_line, pos(ls_line, ",") - 1)) 
	
	ls_line = gn_fn.of_replaceall(ls_line, string(li_ProductVersion2)+",", "")
	
	li_ProductVersion3 = integer( left(ls_line, pos(ls_line, ",") - 1))
	
	ls_line = gn_fn.of_replaceall(ls_line, string(li_ProductVersion3)+",", "")
	
	li_ProductVersion4 = integer(ls_line)
	ls_DeployVersion = ls_line
	
	ls_MinimumCompatibleVersion = ls_DeployVersion
	ldt_AvailabeTime = dp_availale.value
	ldt_ExpirationTime =dp_expiration.value
ELSE	
	// Para PowerClient y PowerServer es lo mismo: Tomo la Versión de Publicación
	//Extraemos Json del fichero del proyecto usado como Control de Versión.
	do while li_indx > -1
		li_rtn = FileReadex(li_FileNum, ls_line)  
		IF  li_rtn  = -1 THEN
			gn_fn.of_error("FileRead Error")
			EXIT
		ELSE
			li_indx ++  
			IF left(ls_line, 12)<>"POWERCLIENT:" THEN CONTINUE
			IF left(ls_line, 12)="POWERCLIENT:" THEN ls_data = gn_fn.of_replaceall(ls_line, "POWERCLIENT:", "")
			IF left(ls_line, 4)="PBD:" THEN EXIT
		END IF	
	loop  
	 FileClose(li_FileNum)
	 
	
	lu_jsonObject = create u_json
		 
	try
		lu_jsonObject.of_load_string(ls_data)
			
		ls_MinimumCompatibleVersion=lu_jsonObject.of_get_node(is_projectName).of_get_node("MinimumValidVersion").of_get_value_string()
		ldt_AvailabeTime =  lu_jsonObject.of_get_node(is_projectName).of_get_node("OnlineTime").of_get_value_datetime()
		ldt_ExpirationTime =  lu_jsonObject.of_get_node(is_projectName).of_get_node("OfflineTime").of_get_value_datetime()
		li_ProductVersion1 = lu_jsonObject.of_get_node(is_projectName ).of_get_node("ProductVersionMajor").of_get_value_number()
		li_ProductVersion2 = lu_jsonObject.of_get_node(is_projectName ).of_get_node("ProductVersionMinor").of_get_value_number()
		li_ProductVersion3 = lu_jsonObject.of_get_node(is_projectName ).of_get_node("ProductVersionBuild").of_get_value_number()
		li_ProductVersion4 = lu_jsonObject.of_get_node(is_projectName ).of_get_node("ProductVersionRevision").of_get_value_number()
		ls_DeployVersion =  lu_jsonObject.of_get_node(is_projectName ).of_get_node("DeployVersion").of_get_value_string()
		ls_RuntimeVersion = lu_jsonObject.of_get_node(is_projectName).of_get_node("RuntimeVersion").of_get_value_string()
		
	
	catch (exception le_ex)
		gn_fn.of_error(le_ex.getmessage())
		RETURN FALSE
	end try
END IF

//Actualizo los Datos de Pantalla con la Versión del archivo *.srj ya que de aqui se tomarán los valores para guardar el Json.
sle_major.Text = string(li_ProductVersion1)
sle_minor.Text = string(li_ProductVersion2)
sle_build.Text = string(li_ProductVersion3)
sle_revision.Text =  string(li_ProductVersion4)
sle_minimum.Text = ls_MinimumCompatibleVersion
dp_availale.value = ldt_AvailabeTime
dp_expiration.value = ldt_ExpirationTime 
		
IF ls_RuntimeVersion <> is_RunTimeVersion THEN
	gn_fn.of_error("Git RunTime Version: "+ls_RuntimeVersion+ " inconsistent with Json RunTime Version: "+is_RuntimeVersion )
	//Lo actualizo para intentar continuar así:
	is_RuntimeVersion = ls_RuntimeVersion
END IF	

//Si la versión es Mayor Retorno TRUE para que haga la compilación si no Retorno False para que no la haga.
IF dec(ls_DeployVersion) > dec(is_DeploymentVersion) THEN
	gn_fn.of_log("GitHub Version: "+ls_DeployVersion+" "+"Local Version:"+is_DeploymentVersion+ " Start the update...")
	RETURN TRUE
ELSE
	gn_fn.of_log("GitHub Version: "+ls_DeployVersion+" "+"Local Version:"+is_DeploymentVersion+" Nothing to update.")
	RETURN FALSE
END IF
end function

on w_main.create
this.pb_setup=create pb_setup
this.p_logo=create p_logo
this.st_copyright=create st_copyright
this.sle_project_type=create sle_project_type
this.st_project_type=create st_project_type
this.sle_projectname=create sle_projectname
this.st_projectname=create st_projectname
this.st_minimum_revision=create st_minimum_revision
this.sle_minimum=create sle_minimum
this.st_minimum=create st_minimum
this.st_expiration=create st_expiration
this.st_availale=create st_availale
this.dp_expiration=create dp_expiration
this.dp_availale=create dp_availale
this.st_revision=create st_revision
this.st_build=create st_build
this.st_minor=create st_minor
this.st_major=create st_major
this.sle_revision=create sle_revision
this.sle_build=create sle_build
this.sle_minor=create sle_minor
this.sle_major=create sle_major
this.pb_build=create pb_build
this.st_myversion=create st_myversion
this.st_platform=create st_platform
this.st_3=create st_3
this.sle_json=create sle_json
this.pb_abrir_json=create pb_abrir_json
this.gb_product_version=create gb_product_version
this.gb_powerclient=create gb_powerclient
this.r_2=create r_2
this.pb_exit=create pb_exit
this.lb_json=create lb_json
this.Control[]={this.pb_setup,&
this.p_logo,&
this.st_copyright,&
this.sle_project_type,&
this.st_project_type,&
this.sle_projectname,&
this.st_projectname,&
this.st_minimum_revision,&
this.sle_minimum,&
this.st_minimum,&
this.st_expiration,&
this.st_availale,&
this.dp_expiration,&
this.dp_availale,&
this.st_revision,&
this.st_build,&
this.st_minor,&
this.st_major,&
this.sle_revision,&
this.sle_build,&
this.sle_minor,&
this.sle_major,&
this.pb_build,&
this.st_myversion,&
this.st_platform,&
this.st_3,&
this.sle_json,&
this.pb_abrir_json,&
this.gb_product_version,&
this.gb_powerclient,&
this.r_2,&
this.pb_exit,&
this.lb_json}
end on

on w_main.destroy
destroy(this.pb_setup)
destroy(this.p_logo)
destroy(this.st_copyright)
destroy(this.sle_project_type)
destroy(this.st_project_type)
destroy(this.sle_projectname)
destroy(this.st_projectname)
destroy(this.st_minimum_revision)
destroy(this.sle_minimum)
destroy(this.st_minimum)
destroy(this.st_expiration)
destroy(this.st_availale)
destroy(this.dp_expiration)
destroy(this.dp_availale)
destroy(this.st_revision)
destroy(this.st_build)
destroy(this.st_minor)
destroy(this.st_major)
destroy(this.sle_revision)
destroy(this.sle_build)
destroy(this.sle_minor)
destroy(this.sle_major)
destroy(this.pb_build)
destroy(this.st_myversion)
destroy(this.st_platform)
destroy(this.st_3)
destroy(this.sle_json)
destroy(this.pb_abrir_json)
destroy(this.gb_product_version)
destroy(this.gb_powerclient)
destroy(this.r_2)
destroy(this.pb_exit)
destroy(this.lb_json)
end on

event open;Long ll_TotalItems

st_myversion.text=gs_version
st_platform.text=gs_platform
p_logo.PictureName = gs_logo

gs_SetupFile=gs_appdir+"\"+"setup.ini"
gs_AutoPath =  gs_appdir+"\auto"
is_JWTClassTemplateName = "DefaultUserStore.cs"

//Borro los Log Anteriores
FileDelete(gs_appdir +"\Log_Build.log")
FileDelete(gs_appdir +"\Log_Error.log")

 // Cargo todos los Json que hay en el direcciorio de la App
lb_json.Reset()
lb_json.DirList(gs_AutoPath+"\*.json", 0 )
ll_TotalItems = lb_json.TotalItems()

IF ll_TotalItems > 0 THEN 
	gb_auto=TRUE  //Si tenemos json en la carpeta auto el programa funcionará de forma automática.
	lb_json.visible=TRUE
	sle_json.visible=FALSE
	pb_abrir_json.visible=FALSE
	pb_setup.visible=FALSE
	pb_build.visible=FALSE
	pb_exit.x = pb_exit.x  - 288
ELSE
	gb_auto= FALSE //Si no hay archivos en la Carpeta auto intentará abrir el ultimo json que se abrio y funcionará de forma manual.
	lb_json.visible= FALSE
	sle_json.visible= TRUE
END IF	

//Si no existe fichero de Configuración hay que crearlo.
IF FileExists(gs_SetupFile) =  FALSE THEN
	OPEN(w_setup)
	Close(THIS)
	RETURN
ELSE
	IF gb_auto=TRUE  THEN 
		pb_build.TriggerEvent(clicked!)
	ELSE
		is_JsonPath=ProfileString(gs_SetupFile, "setup", "json", "")
		is_JsonFile = mid(is_JsonPath, lastpos(is_JsonPath, "\") +1 , len(is_JsonPath) - lastpos(is_JsonPath, "\"))
		sle_json.text = is_JsonPath
		if trim(is_JsonPath) <> "" then
			wf_load_json()
		end if	
	END IF
END IF	
end event

event closequery;
SetProfileString(gs_SetupFile, "setup", "json", is_JsonPath)
end event

type pb_setup from picturebutton within w_main
integer x = 2702
integer y = 276
integer width = 110
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
string picturename = "Options1!"
alignment htextalign = left!
string powertiptext = "Configurar Setup.ini"
end type

event clicked;
IF trim(is_JsonPath) <> "" THEN wf_save_json()	
open(w_setup)
close(parent)
end event

type p_logo from picture within w_main
integer x = 18
integer y = 8
integer width = 1253
integer height = 248
boolean originalsize = true
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type st_copyright from statictext within w_main
integer x = 1298
integer y = 1608
integer width = 1531
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 553648127
string text = "Copyright © Ramón San Félix Ramón  rsrsystem.soft@gmail.com"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_project_type from singlelineedit within w_main
integer x = 1751
integer y = 520
integer width = 654
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
borderstyle borderstyle = styleraised!
end type

type st_project_type from statictext within w_main
integer x = 1440
integer y = 532
integer width = 334
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Project Type:"
boolean focusrectangle = false
end type

type sle_projectname from singlelineedit within w_main
integer x = 727
integer y = 520
integer width = 654
integer height = 88
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
borderstyle borderstyle = styleraised!
end type

type st_projectname from statictext within w_main
integer x = 384
integer y = 532
integer width = 334
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Project Name:"
boolean focusrectangle = false
end type

type st_minimum_revision from statictext within w_main
integer x = 1431
integer y = 1252
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8421504
long backcolor = 67108864
string text = "Revision"
boolean focusrectangle = false
end type

type sle_minimum from singlelineedit within w_main
integer x = 1431
integer y = 1316
integer width = 448
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_minimum from statictext within w_main
integer x = 777
integer y = 1340
integer width = 640
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Minimum Compatible Version:"
boolean focusrectangle = false
end type

type st_expiration from statictext within w_main
integer x = 777
integer y = 1176
integer width = 366
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Expiration Time:"
boolean focusrectangle = false
end type

type st_availale from statictext within w_main
integer x = 777
integer y = 1060
integer width = 366
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Availale Time:"
boolean focusrectangle = false
end type

type dp_expiration from datepicker within w_main
integer x = 1198
integer y = 1152
integer width = 686
integer height = 100
integer taborder = 70
boolean border = true
borderstyle borderstyle = stylelowered!
datetimeformat format = dtfcustom!
string customformat = "yyyy-MM-dd HH:mm:ss"
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2023-02-15"), Time("09:56:21.000000"))
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
integer calendarfontweight = 400
weekday firstdayofweek = monday!
boolean todaysection = true
boolean todaycircle = true
end type

type dp_availale from datepicker within w_main
integer x = 1193
integer y = 1028
integer width = 686
integer height = 100
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
datetimeformat format = dtfcustom!
string customformat = "yyyy-MM-dd HH:mm:ss"
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2023-02-15"), Time("09:56:21.000000"))
integer textsize = -8
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
integer calendarfontweight = 400
weekday firstdayofweek = monday!
boolean todaysection = true
boolean todaycircle = true
end type

type st_revision from statictext within w_main
integer x = 1842
integer y = 720
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Revision"
boolean focusrectangle = false
end type

type st_build from statictext within w_main
integer x = 1385
integer y = 720
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Build"
boolean focusrectangle = false
end type

type st_minor from statictext within w_main
integer x = 923
integer y = 720
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Minor"
boolean focusrectangle = false
end type

type st_major from statictext within w_main
integer x = 462
integer y = 720
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Major"
boolean focusrectangle = false
end type

type sle_revision from singlelineedit within w_main
integer x = 1842
integer y = 792
integer width = 448
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_build from singlelineedit within w_main
integer x = 1385
integer y = 792
integer width = 448
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_minor from singlelineedit within w_main
integer x = 923
integer y = 792
integer width = 448
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_major from singlelineedit within w_main
integer x = 462
integer y = 792
integer width = 448
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type pb_build from picturebutton within w_main
integer x = 937
integer y = 1472
integer width = 402
integer height = 112
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Build"
boolean originalsize = true
vtextalign vtextalign = vcenter!
string powertiptext = "Ejecutar"
long textcolor = 16777215
long backcolor = 33521664
end type

event clicked;Long ll_Items, ll_TotalItems

gn_fn.of_log(fill("*", 19)+" Build Date: "+string(today(), "dd-mm-yy")+" "+fill("*", 19))

IF gb_auto = FALSE THEN 
	is_JsonPath= sle_json.text
	is_JsonFile = mid(is_JsonPath, lastpos(is_JsonPath, "\") +1 , len(is_JsonPath) - lastpos(is_JsonPath, "\"))
	wf_build()	
ELSE
	ll_TotalItems = lb_json.TotalItems()
	FOR ll_Items = 1 TO  ll_TotalItems
		lb_json.SelectItem(ll_Items)
		is_JsonFile =lb_json.Text(ll_Items)
		is_JsonPath = gs_AutoPath +"\"+ is_JsonFile
		IF wf_load_json() THEN
			wf_build()	
		ELSE
			gn_fn.of_log(fill("*", 60))
		END IF
		IF ll_Items = ll_TotalItems THEN pb_exit.PostEvent(Clicked!)
	NEXT
END IF	

end event

type st_myversion from statictext within w_main
integer x = 1353
integer y = 44
integer width = 1445
integer height = 84
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Versión"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_platform from statictext within w_main
integer x = 2309
integer y = 132
integer width = 489
integer height = 84
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 33521664
string text = "Bits"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_main
integer x = 119
integer y = 332
integer width = 1554
integer height = 80
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 67108864
string text = "Json  PbAutobuild Client Deployment"
boolean focusrectangle = false
end type

type sle_json from singlelineedit within w_main
integer x = 119
integer y = 416
integer width = 2569
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type pb_abrir_json from picturebutton within w_main
integer x = 2702
integer y = 408
integer width = 110
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
string picturename = "Open!"
alignment htextalign = left!
string powertiptext = "Abrir Proyecto Json"
end type

event clicked;String ls_current

ChangeDirectory (gs_appdir)

IF GetFileOpenName ( "Proyecto Json", is_JsonPath, is_JsonFile, "*.*","(*.json),*.json" ) < 1 THEN Return

ChangeDirectory (gs_appdir)
 
sle_json.text=is_JsonPath

//Cargamos los dartos de Json
 wf_load_json()
end event

type gb_product_version from groupbox within w_main
integer x = 325
integer y = 640
integer width = 2112
integer height = 344
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "Product Version"
end type

type gb_powerclient from groupbox within w_main
integer x = 325
integer y = 988
integer width = 2112
integer height = 456
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "PowerClient"
end type

type r_2 from rectangle within w_main
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 33521664
integer x = -9
integer width = 3301
integer height = 272
end type

type pb_exit from picturebutton within w_main
integer x = 1477
integer y = 1472
integer width = 402
integer height = 108
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Exit"
boolean originalsize = true
vtextalign vtextalign = vcenter!
string powertiptext = "Salir"
long textcolor = 16777215
long backcolor = 33521664
end type

event clicked;close(parent)
end event

type lb_json from listbox within w_main
boolean visible = false
integer x = 119
integer y = 416
integer width = 2688
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

