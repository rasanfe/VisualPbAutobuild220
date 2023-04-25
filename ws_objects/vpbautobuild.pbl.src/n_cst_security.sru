$PBExportHeader$n_cst_security.sru
forward
global type n_cst_security from nonvisualobject
end type
end forward

global type n_cst_security from nonvisualobject
end type
global n_cst_security n_cst_security

forward prototypes
public function string of_encrypt (string as_source)
public function string of_decrypt (string as_source)
public function string of_decrypt (string as_source, string as_key, string as_iv)
public function boolean of_get_token (string as_token, string as_masterkey, string as_masteriv, ref string as_key, ref string as_iv)
public subroutine of_get_masterkeys (ref string as_masterkey, ref string as_masteriv)
end prototypes

public function string of_encrypt (string as_source);coderobject ln_coderobject
crypterobject ln_crypterobject
String ls_encoded
String ls_encrypted
String ls_key, ls_IV
Blob lblb_data, lblb_key, lblb_iv, lblb_Encrypted
Encoding lEncoding = EncodingUTF8!
String ls_token, ls_Masterkey, ls_MasterIV

If trim(as_source)="" then return ""

//Leemos el Token del Archivo INI
ls_token =ProfileString("setup.ini", "Setup", "AppSecurityToken", "")
ls_Masterkey =  "vpbautobuild"
ls_MasterIV = "IV002022"

//Obtenemos las Claves del Archivo INI
IF NOT of_get_token(ls_token, ls_MasterKey, ls_MasterIV, REF ls_key, REF ls_IV) THEN RETURN ""

//1- Encryp as_source 
lblb_data = Blob(as_source, lEncoding)
lblb_key  = Blob(ls_key, lEncoding)
lblb_iv    = Blob(ls_IV, lEncoding)

ln_crypterobject = Create crypterobject	
lblb_Encrypted = ln_crypterobject.SymmetricEncrypt(AES!, lblb_data, lblb_key, OperationModeCBC!, lblb_iv, PKCSPadding! )
destroy ln_crypterobject
	
//2- Encode ls_encrypted
ln_coderobject = Create coderobject
ls_encoded = ln_coderobject.Base64URLEncode(lblb_Encrypted)
destroy ln_coderobject


RETURN ls_encoded

end function

public function string of_decrypt (string as_source);String ls_decrypted, ls_key, ls_IV, ls_token, ls_masterKey, ls_masterIV

//Leemos el Token del Archivo INI
ls_token =ProfileString("setup.ini", "Setup", "AppSecurityToken", "")

of_get_masterkeys(REF ls_masterKey, REF ls_masterIV)

//Obtenemos las Claves del Archivo INI
IF NOT of_get_token(ls_token, ls_MasterKey, ls_MasterIV, REF ls_key, REF ls_IV) THEN RETURN ""

ls_decrypted = of_decrypt(as_source, ls_key, ls_IV)
 
RETURN ls_decrypted
end function

public function string of_decrypt (string as_source, string as_key, string as_iv);coderobject ln_coderobject
crypterobject ln_crypterobject
String ls_decode
String ls_decrypted
String ls_key, ls_IV
Encoding lEncoding = EncodingUTF8!
Blob lblb_data, lblb_key, lblb_iv, lblb_Decrypted

If trim(as_source)="" then return ""

//1- Decode as_source
ln_coderobject = Create coderobject
lblb_data = ln_coderobject.Base64URLDecode(as_source)
destroy ln_coderobject

//2- Decryp ls_decode 
lblb_key  = Blob(as_key, lEncoding)
lblb_iv    = Blob(as_IV, lEncoding)

ln_crypterobject = Create crypterobject
lblb_Decrypted = ln_crypterobject.SymmetricDecrypt(AES!, lblb_data, lblb_key, OperationModeCBC!, lblb_iv, PKCSPadding!)
destroy ln_crypterobject

ls_decrypted = String(lblb_Decrypted, lEncoding)

RETURN ls_decrypted
end function

public function boolean of_get_token (string as_token, string as_masterkey, string as_masteriv, ref string as_key, ref string as_iv);//Funcion para recuperar Clave y Vector de iniciación de archivo INI. La información está almacenada encriptada en un json. {"key":"clave", "IV":"vector"}
coderobject ln_coderobject
crypterobject ln_crypterobject
String ls_json
Blob  lb_json_decoded, lb_json_decrypted, lblb_key, lblb_iv
Encoding lEncoding = EncodingUTF8!
JsonParser lnv_JsonParser
Long ll_RootObject, ll_item

IF as_token = "" THEN
	gn_fn.of_error("Fail to get SecurityToken from setup.ini")
	RETURN FALSE
END IF	

as_Masterkey = as_Masterkey + fill("*", 16 - len(as_Masterkey))
as_MasterIV = as_MasterIV + fill("0", 16 - len(as_MasterIV))

//1- Decode as_source
ln_coderobject = Create coderobject
lb_json_decoded = ln_coderobject.Base64URLDecode(as_token)
destroy ln_coderobject

//2- Decryp ls_decode 
ln_crypterobject = Create crypterobject

lblb_key  = Blob(as_Masterkey, lEncoding)
lblb_iv    = Blob(as_MasterIV, lEncoding)
	
lb_json_decrypted= ln_crypterobject.SymmetricDecrypt(AES!, lb_json_decoded, lblb_key, OperationModeCBC!, lblb_iv, PKCSPadding!)
	
ls_json = String(lb_json_decrypted, lEncoding)

destroy ln_crypterobject

//3-Parseamos el Json Recibido en el Token.
lnv_JsonParser = Create JsonParser

lnv_JsonParser.LoadString(ls_Json)
ll_RootObject = lnv_JsonParser.GetRootItem()

as_key = lnv_JsonParser.GetItemString(ll_RootObject, "key")
as_IV =lnv_JsonParser.GetItemString(ll_RootObject, "IV")

//Retorno por Referencia Key y IV con tamaños corregidos.
as_key = as_key + fill("*", 16 - len(as_key))
as_IV = as_IV + fill("0", 16 - len(as_IV))

destroy lnv_JsonParser
RETURN TRUE
end function

public subroutine of_get_masterkeys (ref string as_masterkey, ref string as_masteriv);as_Masterkey =  "vpbautobuild"
as_MasterIV = "IV002022"
end subroutine

on n_cst_security.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_security.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

