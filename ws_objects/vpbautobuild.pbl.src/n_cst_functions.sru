$PBExportHeader$n_cst_functions.sru
forward
global type n_cst_functions from nonvisualobject
end type
end forward

global type n_cst_functions from nonvisualobject autoinstantiate
end type

type variables
Private:
n_runandwait in_rwait
end variables

forward prototypes
public function boolean of_run_bat (string as_script, string as_filename)
public function boolean of_create_bat (string as_script, string as_filepath)
public subroutine of_copy_pbautobuild_logs (string as_pbautobuillog, string as_mylog)
public subroutine of_log (string as_text)
public subroutine of_error (string as_text)
public function string of_replaceall (string as_source, string as_replaced, string as_new)
public function string of_decodebase64url (string as_value)
public function string of_download_file (string as_personaltoken, string as_url, string as_filepath)
public function string of_profilestring (string as_section, string as_key, string as_default)
public function boolean of_iin (any aa_value, any aa_check[])
public function any of_get_ini_sections ()
end prototypes

public function boolean of_run_bat (string as_script, string as_filename);Boolean lb_rtn
String ls_error
String ls_batFile

SetPointer(HourGlass!)

ls_batFile = gs_appdir+"\"+as_filename

lb_rtn  = of_create_bat(as_script, ls_batFile)

IF lb_rtn = FALSE THEN	RETURN FALSE

lb_rtn  = in_rwait.of_runandcapture(ls_batFile, ls_error)
//lb_rtn  = in_rwait.of_runandwait(ls_batFile,  in_rwait.SW_SHOWNORMAL)

// check return code
IF lb_rtn = FALSE THEN
	//ls_error = "Run "+as_filename+" Error."
	of_error( ls_error)
	RETURN lb_rtn
END IF

FileDelete(ls_batFile)
	
SetPointer(Arrow!)
end function

public function boolean of_create_bat (string as_script, string as_filepath);Integer li_file

li_file = fileopen(as_FilePath, linemode!, write!, lockwrite!, replace!, EncodingANSI!)

as_script = "@Echo off" +"~r~n"+ as_script

if li_file > 0 then
	if filewriteex(li_file, as_script) < 0 then
		of_error("Error writing File")
		RETURN FALSE
	end if
	fileclose(li_file)
else
	of_error("Error opening the file to write")
	RETURN FALSE
end if

RETURN TRUE
end function

public subroutine of_copy_pbautobuild_logs (string as_pbautobuillog, string as_mylog);Integer li_myFile, li_PCfile, li_indx, li_rtn
blob lb_data

li_PCfile = FileOpen(as_pbautobuillog, StreamMode!, Read!)
li_myFile= FileOpen(as_mylog, StreamMode!, Write!)

if li_PCfile = -1 then
	of_error("Error abriendo "+as_pbautobuillog)
	RETURN
end if	

if li_myFile = -1 then
	of_error("Error abriendo "+as_mylog)
	RETURN
end if	

li_indx = 0  

li_rtn = FileReadex(li_PCfile, lb_data)  

IF li_rtn = -1 then
	of_error("Escribiendo Copiando Log"+as_pbautobuillog+" a "+as_mylog)
	RETURN
end if	

FileWriteex(li_myFile, lb_data)

FileClose(li_myFile)
FileClose(li_PCfile)

Filedelete(as_pbautobuillog)
end subroutine

public subroutine of_log (string as_text);Integer li_file

li_file = FileOpen(gs_appdir +"\Log_Build.log", LineMode!, Write!, Shared!, Append!, EncodingUTF16LE!)

FileWrite(li_file, string(now(), "hh:mm:ss")+" [Normal] "+ as_text)
FileClose(li_file)
RETURN
end subroutine

public subroutine of_error (string as_text);Integer li_file

//Solo Mostramos Mensajes Visuales si el Programa Se ejecuta manualmente.
IF gb_auto = FALSE THEN	
	MessageBox("Error", as_text,  Exclamation!, OK!)
ELSE
	//En el Log general se Graba Todo
	of_log(as_text)
END IF

li_file = FileOpen(gs_appdir +"\Log_Error.log", LineMode!, Write!, Shared!, Append!, EncodingUTF16LE!)

FileWrite(li_file, string(now(), "hh:mm:ss")+" [Error] "+ as_text)
FileClose(li_file)
end subroutine

public function string of_replaceall (string as_source, string as_replaced, string as_new);long ll_StartPos=1

// Find the first occurrence of as_replaced.
ll_StartPos = Pos(as_source, as_replaced, ll_StartPos)

// Only enter the loop if you find as_replaced.
DO WHILE ll_StartPos > 0
	   // Replace as_replaced with as_new.
    as_source = Replace(as_source, ll_StartPos, Len(as_replaced), as_new)
      // Find the next occurrence of as_replaced. 
	ll_StartPos = Pos(as_source, as_replaced, ll_StartPos+Len(as_new))
LOOP

RETURN as_source  
end function

public function string of_decodebase64url (string as_value);Coderobject lnv_coderobject
Blob lb_value
ULong lul_len
String ls_decoded
Encoding lEncoding = EncodingUTF8!

//Decode as_value
lnv_coderobject = Create coderobject

// allocate decoded buffer
lul_len = Len(as_value)
lb_value = Blob(Space(lul_len))

lb_value = lnv_coderobject.base64urldecode(as_value)

ls_decoded = String(BlobMid(lb_value, 1, lul_len), lEncoding)

Destroy lnv_coderobject

RETURN ls_decoded
end function

public function string of_download_file (string as_personaltoken, string as_url, string as_filepath);Integer li_rc, li_ResponseStatusCode, li_FileNum
Blob lblb_file, lblb_NextData
HttpClient lnv_HttpClient 
String ls_FilePath

ls_FilePath = as_FilePath
lnv_HttpClient = Create HttpClient

// Send request using GET method
// Not to read data automatically after sending request (default is true)
lnv_HttpClient.AutoReadData = FALSE

IF as_PersonalToken <> "" THEN lnv_HttpClient.SetRequestHeader("Authorization", "token "+ as_PersonalToken)

li_rc = lnv_HttpClient.SendRequest("GET", as_url)

li_ResponseStatusCode = lnv_HttpClient.GetResponseStatusCode()

// Receive large data
if li_rc = 1 and li_ResponseStatusCode = 200 then
	do while TRUE
	li_rc = lnv_HttpClient.ReadData(lblb_NextData, 1000)
	if li_rc = 0 then exit // Finish receiving data
	if li_rc = -1 then exit // Error occurred
	lblb_file += lblb_NextData
	loop
else
	of_error("HttpClient Result Code: "+string(li_rc )+"~r~n"+"HttpClient Response Status Code: "+string(li_ResponseStatusCode))
	RETURN ""
end if

if li_rc <> 0 then
	of_error("HttpClient Result Code: "+string(li_rc ))
	RETURN ""
end if

//Write File blob to disk
li_FileNum = FileOpen(ls_FilePath, StreamMode!, Write!, LockWrite!, Replace!)
li_rc = FileWriteEx(li_FileNum,  lblb_file )
FileClose(li_FileNum)

if li_rc = -1 then
	of_error( "Error Writting "+ls_FilePath)
	RETURN ""
end if

RETURN ls_FilePath
end function

public function string of_profilestring (string as_section, string as_key, string as_default);//Leemos Primer el Valor de la Sección Especifica y si no de la General
String ls_value

ls_value = ProfileString(gs_SetupFile, as_section, as_key, ProfileString(gs_SetupFile, "setup", as_key, as_default))

RETURN ls_value
end function

public function boolean of_iin (any aa_value, any aa_check[]);Integer		li_loop																					// Work Var
Integer		li_max																						// Work Var
String			ls_type																					// Work Var
Boolean		lb_rc = FALSE																			// Work Var
ls_type		=	ClassName (aa_value)															// Get 1st arg's data type
li_max			=	UpperBound (aa_check[])														// Get # of 2nd Arg's.

FOR  li_loop		=	1  to  li_max																		// Loop thru data
	IF  ClassName (aa_check[li_loop] )  <>  ls_type THEN								// Data type match?
		Continue																								// NO=>Continue the loop!
	ELSE
		IF  aa_check[li_loop]	=	aa_value THEN													// YES=>Values Equal?
			lb_rc	=	 TRUE																					// YES=>Set RC
			EXIT																									// Exit the Loop!
		END IF
	END IF
NEXT

RETURN	lb_rc 																						// RETURN RC to caller

end function

public function any of_get_ini_sections ();String ls_line
Integer li_FileNum, li_rtn, li_indx, li_Sections
String ls_section[]

li_FileNum = FileOpen(gs_SetupFile, LineMode!, Read!, Shared!, Replace!, EncodingANSI!)

IF li_FileNum > 0 THEN
	DO WHILE  li_indx > -1
		li_rtn = FileReadex(li_FileNum, ls_line)  
			IF  li_rtn  = -1 THEN
				EXIT
			ELSE
				li_indx ++  
				IF left(trim(ls_line), 1)="[" THEN
					li_Sections ++
					ls_section[li_Sections] = mid(ls_line, 2, pos(ls_line, "]") - 2)
				END IF	
			END IF	
	LOOP  
	FileClose(li_FileNum)
END IF

RETURN ls_Section[]
end function

on n_cst_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

