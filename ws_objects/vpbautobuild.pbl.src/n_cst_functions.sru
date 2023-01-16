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

on n_cst_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

