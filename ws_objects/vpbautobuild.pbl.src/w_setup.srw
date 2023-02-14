$PBExportHeader$w_setup.srw
forward
global type w_setup from window
end type
type st_3 from statictext within w_setup
end type
type ddlb_filtro from dropdownlistbox within w_setup
end type
type dw_1 from datawindow within w_setup
end type
type p_logo from picture within w_setup
end type
type st_copyright from statictext within w_setup
end type
type pb_save from picturebutton within w_setup
end type
type st_myversion from statictext within w_setup
end type
type st_platform from statictext within w_setup
end type
type r_2 from rectangle within w_setup
end type
type pb_exit from picturebutton within w_setup
end type
type lb_json from listbox within w_setup
end type
end forward

global type w_setup from window
integer width = 3685
integer height = 3124
boolean titlebar = true
string title = "Setup"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_3 st_3
ddlb_filtro ddlb_filtro
dw_1 dw_1
p_logo p_logo
st_copyright st_copyright
pb_save pb_save
st_myversion st_myversion
st_platform st_platform
r_2 r_2
pb_exit pb_exit
lb_json lb_json
end type
global w_setup w_setup

type prototypes

end prototypes

type variables
String is_Path
end variables

forward prototypes
public subroutine wf_save ()
public function integer wf_load_json (string as_jsonpath)
public subroutine wf_load_ini ()
public subroutine wf_fill_ini ()
public function long wf_dddw_select (long al_row)
end prototypes

public subroutine wf_save ();//Optamos Por crear Un Fichero Nevo Para poder Grabar con formatos (Un Salto de linea entre apartados) y para que no se graben claves en blanco (Clave="")
//Ya que si hay una clave en blanco en un proyecto y esta está parametrizada en el apartado Setup, en vez de leer el apartado Setup leeria un string en blanco.

Long ll_Row, ll_RowCount
String ls_section, ls_key, ls_value, ls_text, ls_section_ant="", ls_filter
Integer li_file

dw_1.SetRedraw(False)
dw_1.AcceptText()
ls_filter = dw_1.Object.DataWindow.Table.Filter

IF isnull(ls_filter) or Trim(ls_filter)="" THEN ls_filter=""

//Quitamos los Filtros Para Guardar Correctamente todos los apartados.
dw_1.SetFilter("")
dw_1.Filter()
ll_RowCount = dw_1.RowCount()

//Elimino el Fichero y creo uno Nuevo ANSI, para que las funciones ProfileString y SetProfileString funcionen correctamente.
FileDelete(gs_SetupFile)

li_file = FileOpen(gs_SetupFIle, linemode!, write!, lockwrite!, replace!, EncodingANSI!)

IF li_file < 0 THEN
	gn_fn.of_error("Error opening the file to write")
	RETURN
END IF

//Ahora si Grabamos las Lineas del Fichero
FOR ll_Row = 1 To ll_RowCount
	ls_section = dw_1.Object.Section[ll_Row]
	ls_key = dw_1.Object.Key[ll_Row]
	ls_value = dw_1.Object.Value[ll_Row]
		
	IF ls_section_ant <> ls_section THEN
	
		IF dw_1.Object.c_groupcount[ll_Row] > 0 THEN
			IF ll_Row = 1 THEN
				ls_text = "["+ls_section+"]"
			ELSE	
				ls_text="~r~n"+"["+ls_section+"]"
			END IF
			IF FileWriteEx(li_file, ls_text) < 0 THEN
				gn_fn.of_error("Error writing File")
				EXIT
			END IF
		END IF
	END IF	
	
	ls_text = ls_key+"="+ls_value
	
	IF trim(ls_value) <> "" THEN
		IF FileWriteEx(li_file, ls_text) < 0 THEN
			gn_fn.of_error("Error writing File")
			EXIT
		END IF
	END IF
	
	ls_section_ant = ls_section
NEXT	

FileClose(li_file)
dw_1.SetFilter(ls_filter)
dw_1.Filter()
dw_1.SetRedraw(True)
end subroutine

public function integer wf_load_json (string as_jsonpath);String ls_JsonFile, ls_ProjectName
Integer li_ProjectType
u_json lu_jsonObject

ls_JsonFile = mid(as_JsonPath, lastpos(as_JsonPath, "\") +1 , len(as_JsonPath) - lastpos(as_JsonPath, "\"))

lu_jsonObject = create u_json
try
	lu_jsonObject.of_load_file(as_JsonPath)

	ls_projectName =  lu_jsonObject.of_get_node("Projects").of_get_node(1).of_get_key()
	li_ProjectType = lu_jsonObject.of_get_node("Projects").of_get_node(ls_projectName ).of_get_node("ProjectType").of_get_value_number()
catch (exception le_ex)
	messagebox("Error", le_ex.getmessage(), stopsign!)
	RETURN -1
end try

DESTROY lu_jsonObject

RETURN li_ProjectType
end function

public subroutine wf_load_ini ();Long ll_Items,  ll_TotalItems, ll_row, ll_RowCount, ll_new
String ls_JsonFile, ls_JsonPath
String ls_section, ls_key, ls_value
Integer li_ProjectType
String ls_ProjectControl

dw_1.SetRedraw(False)

//Cargo en Un Datastore Todos los parametros configurables de la aplicación.
DataStore ds_Data
ds_Data =  CREATE DataStore
ds_Data.DataObject="dw_iniparams"
ll_RowCount =ds_Data.RowCount()

//Insertamos los Parametros del Apartado Setup
FOR ll_Row = 1 to ll_RowCount
	ls_section = "setup"
	ls_key=ds_Data.object.Key[ll_Row]
	ls_value =  ProfileString(gs_SetupFile, ls_section, ls_key, "")
	li_ProjectType =  -1	
	ls_ProjectControl = ds_Data.Object.setup[ll_Row] 
		
  	IF ls_ProjectControl <> "S"  THEN CONTINUE
	
	IF ls_value  <> "" THEN
		ll_new = dw_1.InsertRow(0)
		dw_1.Object.id[ll_new] = ll_new
		dw_1.Object.Section[ll_new] = ls_section
		dw_1.Object.Key[ll_new] = ls_key
		dw_1.Object.Value[ll_new] = ls_value 
		dw_1.Object.Project_Type[ll_new] =li_ProjectType
	END IF
NEXT	

 // Cargo todos los Json que hay en el direcciorio de la App
lb_json.Reset()
lb_json.DirList(is_Path+"\"+"*.json", 0 )

ll_TotalItems = lb_json.TotalItems()

//Insertamos los Paramentros de Cada Proyecto
FOR ll_items = 1 to  ll_TotalItems
	lb_json.SelectItem(ll_Items)
	ls_JsonFile =lb_json.Text(ll_Items)
	ls_JsonPath =  is_Path+"\" + ls_JsonFile
	li_ProjectType = wf_load_json(ls_JsonPath)
	
	ddlb_filtro.InsertItem(ls_JsonFile, 0)
	
	ls_section = ls_JsonFile 
	
	FOR ll_Row = 1 to ll_RowCount
		
		CHOOSE CASE li_ProjectType
			CASE 0
				ls_ProjectControl = ds_Data.Object.nativecsapp[ll_Row] 
			CASE 1
				ls_ProjectControl = ds_Data.Object.powerclient[ll_Row] 
			CASE 2
				ls_ProjectControl = ds_Data.Object.powerserver[ll_Row] 
		END CHOOSE
				
		
		if   ls_ProjectControl = "S" then
			
			ls_key=ds_Data.object.Key[ll_Row]
			ls_value =  ProfileString(gs_SetupFile, ls_section, ls_key, "")
		
			IF ls_value  <> "" THEN
				ll_new = dw_1.InsertRow(0)
				dw_1.Object.id[ll_new] = ll_new
				dw_1.Object.Section[ll_new] = ls_section
				dw_1.Object.Key[ll_new] = ls_key
				dw_1.Object.Value[ll_new] = ls_value 
				dw_1.Object.Project_Type[ll_new] = li_ProjectType 
			END IF
		end if
	NEXT	
NEXT	

dw_1.GroupCalc()
dw_1.SetRedraw(True)
ddlb_filtro.SelectItem(1)

IF dw_1.RowCount() = 0 THEN wf_fill_ini()
end subroutine

public subroutine wf_fill_ini ();Long ll_Items,  ll_TotalItems, ll_row, ll_RowCount, ll_new
String ls_JsonFile, ls_JsonPath
String ls_section, ls_key, ls_value
Integer li_ProjectType
String ls_ProjectControl


dw_1.SetRedraw(False)

 // Cargo todos los Json que hay en el direcciorio de la App
lb_json.Reset()
lb_json.DirList(is_Path+"\"+"*.json", 0 )
ll_TotalItems = lb_json.TotalItems()

//Cargo en Un Datastore Todos los parametros configurables de la aplicación.
DataStore ds_Data
ds_Data =  CREATE DataStore
ds_Data.DataObject="dw_iniparams"
ll_RowCount =ds_Data.RowCount()

//Insertamos los Parametros Exclusivos del Apartado Setup
FOR ll_Row = 1 to ll_RowCount
	ls_section = "setup"
	ls_key=ds_Data.object.Key[ll_Row]
	ls_value =  ""
	li_ProjectType = -1
		
	IF ds_Data.Object.setup[ll_Row]  <> "S"  THEN CONTINUE
	
	IF ll_TotalItems > 0 THEN
		IF ds_Data.Object.nativecsapp[ll_Row]  = "S"  THEN CONTINUE
		IF ds_Data.Object.powerclient[ll_Row]  = "S"  THEN CONTINUE
		IF ds_Data.Object.powerserver[ll_Row]  = "S"  THEN CONTINUE
	END IF	
	
	ll_new = dw_1.InsertRow(0)
	dw_1.Object.id[ll_new] = ll_new
	dw_1.Object.Section[ll_new] = ls_section
	dw_1.Object.Key[ll_new] = ls_key
	dw_1.Object.Value[ll_new] = ls_value 
	dw_1.Object.Project_Type[ll_new] =li_ProjectType

NEXT	

//Insertamos los Paramentros de Cada Proyecto
FOR ll_items = 1 to  ll_TotalItems
	lb_json.SelectItem(ll_Items)
	ls_JsonFile =lb_json.Text(ll_Items)
	ls_JsonPath =  is_Path+"\" + ls_JsonFile
	li_ProjectType = wf_load_json(ls_JsonPath)
	
	ddlb_filtro.InsertItem(ls_JsonFile, 0)
	
	ls_section = ls_JsonFile 
	
	FOR ll_Row = 1 to ll_RowCount
		
		CHOOSE CASE li_ProjectType 
			CASE 0
				ls_ProjectControl = ds_Data.Object.nativecsapp[ll_Row] 
			CASE 1
				ls_ProjectControl = ds_Data.Object.powerclient[ll_Row] 
			CASE 3
				ls_ProjectControl = ds_Data.Object.powerserver[ll_Row] 
		END CHOOSE
					
		if  ls_ProjectControl="S" then
			
			ls_key=ds_Data.object.Key[ll_Row]
			ls_value =  ""
			
			ll_new = dw_1.InsertRow(0)
			dw_1.Object.id[ll_new] = ll_new
			dw_1.Object.Section[ll_new] = ls_section
			dw_1.Object.Key[ll_new] = ls_key
			dw_1.Object.Value[ll_new] = ls_value 
			dw_1.Object.Project_Type[ll_new] = li_ProjectType
		end if
	NEXT	
NEXT	

dw_1.GroupCalc()
dw_1.SetRedraw(True)
ddlb_filtro.SelectItem(1)
end subroutine

public function long wf_dddw_select (long al_row);Integer li_ProjectType
String ls_ProjectControl
DataWindowChild dw_child
String ls_filter
long ll_Row, ll_RowCount
long ll_item, ll_itemCount
String ls_key

dw_1.Accepttext()
ll_RowCount = dw_1.RowCount() 

IF ll_RowCount <= 0 THEN RETURN 0

dw_1.GetChild("key", dw_child)
dw_child.SetFilter("")
dw_child.Filter()

IF dw_child.RowCount() <= 0 THEN RETURN 0	

li_ProjectType =  dw_1.object.project_type[al_row]
	
ll_itemCount = dw_child.RowCount() 

CHOOSE CASE li_ProjectType
	CASE -1
		ls_filter ="setup = 'S'"
	CASE 0
		ls_filter ="nativecsapp = 'S'"
	CASE 1
		ls_filter ="powerclient = 'S'"
	CASE 2  
		ls_filter = "powerserver = 'S'"
END CHOOSE	
		
//Recorremos el DwChild Para ver si cada Key se han usado o no corresponde con el Tipo de Proyecto	
FOR ll_item = ll_itemCount to 1 step -1
	
	ls_key = dw_child.GetItemString( ll_item, "key")
	
	ls_ProjectControl = string(li_ProjectType)
	
	//Eliminamos las Key usadas en cada apartado para que no se repitan.
	ll_row = dw_1.Find("key = '"+ls_key+"' and project_type = "+ls_ProjectControl, 1, ll_RowCount)
	
	IF ll_row > 0 THEN
		//dw_child.DeleteRow(ll_item)
		if ls_filter="" then
				ls_filter = "key <> '"+ls_key+"'"
		else
				ls_filter += " and key <> '"+ls_key+"'"
		end if
	END IF	
NEXT	

dw_child.SetFilter(ls_filter)
dw_child.Filter()
dw_child.SetSort("project_type a, key_order a")
dw_child.Sort()

RETURN dw_child.RowCount()
end function

on w_setup.create
this.st_3=create st_3
this.ddlb_filtro=create ddlb_filtro
this.dw_1=create dw_1
this.p_logo=create p_logo
this.st_copyright=create st_copyright
this.pb_save=create pb_save
this.st_myversion=create st_myversion
this.st_platform=create st_platform
this.r_2=create r_2
this.pb_exit=create pb_exit
this.lb_json=create lb_json
this.Control[]={this.st_3,&
this.ddlb_filtro,&
this.dw_1,&
this.p_logo,&
this.st_copyright,&
this.pb_save,&
this.st_myversion,&
this.st_platform,&
this.r_2,&
this.pb_exit,&
this.lb_json}
end on

on w_setup.destroy
destroy(this.st_3)
destroy(this.ddlb_filtro)
destroy(this.dw_1)
destroy(this.p_logo)
destroy(this.st_copyright)
destroy(this.pb_save)
destroy(this.st_myversion)
destroy(this.st_platform)
destroy(this.r_2)
destroy(this.pb_exit)
destroy(this.lb_json)
end on

event open;
st_myversion.text=gs_version
st_platform.text=gs_platform
p_logo.PictureName = gs_logo

this.title=gs_SetupFile

IF gb_auto = TRUE THEN
	is_Path =  gs_AutoPath
ELSE
	is_Path = gs_AppDir
END IF	

//Si no Existe Archivo ni Auto-Rellenamos uno en Blanco
IF FileExists(gs_SetupFile) = FALSE THEN
	wf_fill_ini()
ELSE
	wf_load_ini()
END IF


end event

event closequery;open(w_main)

end event

type st_3 from statictext within w_setup
integer x = 78
integer y = 336
integer width = 247
integer height = 80
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 67108864
string text = "Filtro:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_filtro from dropdownlistbox within w_setup
integer x = 352
integer y = 328
integer width = 622
integer height = 592
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Todo","Setup"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_filtro, ls_JsonPath
Integer li_projectType
Long ll_Row, ll_RowCOunt
DataWindowChild dw_child

Choose case index
	case 1
		ls_filtro = ""
	case 2
		li_projectType = -1
		ls_filtro = "project_type = "+string(li_projectType)
	case else
		ls_JsonPath =  is_Path+"\" + ddlb_filtro.text
		li_ProjectType = wf_load_json(ls_JsonPath)
		ls_filtro = "project_type = "+string(li_projectType)
end choose	

dw_1.setfilter(ls_filtro)
dw_1.Filter()

IF dw_1.RowCount() = 0 THEN
	IF lower(ddlb_filtro.text)="todo" THEN
		wf_fill_ini()
	ELSE	
		ll_Row = dw_1.InsertRow(0)
		dw_1.Object.id[ ll_Row] = ll_Row + dw_1.FilteredCount()
		dw_1.Object.Section[ ll_Row] = lower(ddlb_filtro.text)
		dw_1.Object.Project_Type[ ll_Row] = li_ProjectType
		dw_1.Object.Value[ ll_Row] = ""
		wf_dddw_select(ll_row)
		dw_1.GetChild("key", dw_child)
		dw_1.object.key[ll_Row] = dw_child.GetItemString(1, "key")
	END IF	
END IF	

dw_1.SetSort("id a")
dw_1.Sort()
dw_1.GroupCalc()
end event

type dw_1 from datawindow within w_setup
integer x = 27
integer y = 436
integer width = 3607
integer height = 2244
integer taborder = 10
string title = "none"
string dataobject = "dw_ini"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;if dwo.name = "key" then
	dw_1.object.value[row] = ""
	dw_1.accepttext()
end if	
end event

event rowfocuschanged;//wf_dddw_select(currentrow)


end event

event getfocus;//wf_dddw_select(dw_1.GetRow())

end event

event clicked;long ll_row, ll_rowcount
string ls_section, ls_objeto
Integer li_ProjectType
DataWindowChild dw_child

IF dwo.name="p_deletesection" THEN
	ls_objeto = this.GetObjectAtPointer()
	ll_Row = integer(trim(mid(ls_objeto,pos(ls_objeto,"~t")+1)))
	ls_section = dw_1.object.section[ll_row] 
		
	ll_RowCount = dw_1.RowCount()
	dw_1.SetRedraw(FALSE)
	FOR ll_Row = ll_RowCount TO 1 step -1
		IF  dw_1.object.section[ll_row]  = ls_section THEN
			dw_1.DeleteRow(ll_Row)
		END IF
	NEXT	
	ll_RowCount = dw_1.RowCount()
	FOR ll_Row = 1 TO ll_RowCount
		dw_1.object.id[ll_row] = ll_Row + dw_1.FilteredCount()
	NEXT	
	dw_1.SetRedraw(TRUE)
END IF

IF row < 1 THEN RETURN
dw_1.AcceptText()

IF dwo.name="key" THEN
	wf_dddw_select(row)
END IF	

IF dwo.name="p_new" THEN
	IF wf_dddw_select(row)= 0 THEN RETURN
	ls_Section = dw_1.object.Section[row]
	li_ProjectType = dw_1.object.Project_Type[row]
	ll_row= dw_1.InsertRow(row + 1)
	dw_1.object.Section[ll_row] = ls_Section
	dw_1.object.Project_Type[ll_row] = li_ProjectType 
	wf_dddw_select(ll_row)
	dw_1.GetChild("key", dw_child)
	dw_1.object.key[ll_Row] = dw_child.GetItemString(1, "key")
	dw_1.SetRow( ll_row)
	dw_1.SetRedraw(FALSE)
	ll_RowCount = dw_1.RowCount()
	FOR ll_Row = 1 TO ll_RowCount
		dw_1.object.id[ll_row] = ll_Row + dw_1.FilteredCount()
	NEXT	
	dw_1.SetRedraw(TRUE)
	dw_1.SetColumn("key")
END IF

IF dwo.name="p_deleterow" THEN
	dw_1.DeleteRow(row)
	dw_1.SetRedraw(FALSE)
	ll_RowCount = dw_1.RowCount()
	FOR ll_Row = 1 TO ll_RowCount
		dw_1.object.id[ll_row] = ll_Row + dw_1.FilteredCount()
	NEXT	
	dw_1.SetRedraw(TRUE)
END IF




end event

type p_logo from picture within w_setup
integer x = 18
integer y = 8
integer width = 1253
integer height = 248
boolean originalsize = true
string picturename = "logo.jpg"
boolean focusrectangle = false
end type

type st_copyright from statictext within w_setup
integer x = 1883
integer y = 2920
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

type pb_save from picturebutton within w_setup
integer x = 1339
integer y = 2728
integer width = 402
integer height = 112
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Save"
boolean originalsize = true
vtextalign vtextalign = vcenter!
long textcolor = 16777215
long backcolor = 33521664
end type

event clicked;wf_save()
close(parent)

end event

type st_myversion from statictext within w_setup
integer x = 3077
integer y = 44
integer width = 489
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

type st_platform from statictext within w_setup
integer x = 3077
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

type r_2 from rectangle within w_setup
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 33521664
integer width = 3630
integer height = 272
end type

type pb_exit from picturebutton within w_setup
integer x = 1879
integer y = 2728
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
long textcolor = 16777215
long backcolor = 33521664
end type

event clicked;close(parent)

end event

type lb_json from listbox within w_setup
boolean visible = false
integer x = 178
integer y = 876
integer width = 2688
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

