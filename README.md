# VisualPbAutobuild220

Release 3 13-02-2023:

- Añadimos w_setup para facilitar la configuración de Archivo setup.ini.
- Añadimos dw_ini Para manejar el archivo .ini en forma de Datawindow.
- Añadimos dw_iniparams para DroDownDatawindow de ayuda de selección de Parametros.
- Añadimos Objeto de Topwiz n_osversion para controlar la versión de la aplicación.
- Añadimos of_profilestring en objeto n_cst_functions para leer los parámetros de alrchivo setup.ini
 de forma que si no está en el apartado especificado busque en el apartado setup.
- Elimino wf_version de w_main para controlar la versión de la app en objeto aplicación.
- Pasamos algunas variables de Instancia de w_main a variables globales para poder utilizarlas en  w_setup.
- Creo variables de instancia is_JsonFile y is_JsonPath para simplificar parámetros en funciones de  w_main.
- Contemplo la posibilidad de que No haya configurado un archivo .ini para Guardar Credenciales en Proyectos PowerServer o guardar cadenas de conexión en el resto de proyectos.

Release 2 07-02-2023:
- Parametrizamos archivos ini de cada proyecto, para no suponer que las credenciales estarán en CloudSetting.ini en proyectos PowerServer o en Setting.ini en el resto de proyectos.
- Ahora descargamos archivo ini parametrizado de Github, en vez de usar una plantilla en blanco y lo rellenamos dinámicamente de la configuración del archivo setup.ini.
- Modificamos wf_download_version_control en w_main para extraer la parte de descargar el archivo de github.
- Creamos of_download_file en n_cst_functions para descargar los archivos de GitHub.
- Creamos wf_download_inifile en w_main para descargar los archivos ini parametrizados en parámetro iniFile.
- Ahora la w_build en vez de resetear las plantillas al terminar, elimina los archivos .ini descargados.

Release 1 27-01-2023: 

VisualPbAutobuild220 es un programa para ayudar a usar de forma más cómoda el PbAutobuild220.exe incluido con PowerBuilder 2022
Este ejemplo permite cargar un archivo json de un Proyecto PowerBuilder Cliente/Servidor, PowerClient y PowerServer.


En el archivo de configuración Setup.ini hay que indicar algunos parámetros:

En apartado [Setup]

json =  		---> Parámetro para Recordar último Json Abierto.
PbAutobuildPath =  	---> Parámetro para indicar rura instalación PbAutobuild220.exe.
PBNativePath =  	---> Párametro para indicar ruta de programa compilado en Proyectos Nativos.

Para cada proyecto (o json) hay que crear un apartado con los siguientes campos:

Si los proyectos tienen cosas en común en el apartado Setup puedes poner los que quieras que sean comunes para todos los proyectos.
El programa primero intenta leer del apartado del proyecto y si no mira en el apartado Setup.

[projectName.json]

Párametros cadena conexión Base de Datos (Protyectos Nativos / PowerClient)

DBMS =  	
LogPass =  	
ServerName =  
LogId =  	
AutoCommit =  	
DBParm =

Párametros Para Indicar Información del archivo ini de cada Proyecto:

IniFie =  		---> Parámetro para indicar nombre archivo Ini donde Almacenar Pámetros de Conexión (TODOS LOS PROYECTOS)
IniConnectionKey =  	---> Párametro para inidcar la Sección del Archivo Indicado en Parámetro iniFile donde Guardar la Cadena de Conexión (NATIVOS/POWERCLIENT)

IniUsersKey =  		---> Párametro para inidcar la Sección del Archivo Indicado en Parámetro iniFile donde Guardar las credenciales en Proyectos PowerServer
IniTokenKey =  		---> Párametro para inidcar la Sección del Archivo Indicado en Parámetro iniFile donde Guardar la URL del Token en Proyectos PowerServer
UserName =  		---> Parámetro para indicar el Nombre de Usuario en la Plantilla JWT de los proyectos PowerServer
UserPass =  		---> Parámetro para indicar el Password en la Plantilla JWT de los proyectos PowerServer

Párametros Para Configurar la Cuenta de Git (necesarios si indicamos version_control='S' o que el proyecto usa una IniFile para guardar credenciales:

version_control =  	---> Parámetro para inicar si se controlan las Versiones (S/N)
GitHubProfileName =  	---> Parámetro para indicar el Perfil de GitHub donde está el repositorio
ProfileVisibility = 	---> Parámetro para indicar si un repositorio es Privado o Público (Private/Public)
PersonalToken = 	---> Parámetro para almacenar el Token de acceso personal al repositorio. Necesario en repositorios privados.
GitHubRepository  =  	---> Parámetro para almacenar el nombre del Repositorio de Github
GitBranch =  		---> Parámetro para almacenar la rama del repositorio de GitHub. Normalmente (main o master)
Pbl =  			---> Parámetro para almacenar el nombre de la librería pbl donde está el archivo *.srj del Proyecto
filename =  		---> Parámetro para indicar el nombre del archivo *.srj del Proyecto

Parámetros exclusivos de los Proyectos PowerServer:

PowerServerPath =  	---> Parámetro para indicar la ruta física en el servidor donde está guardado el sitio web de PowerServer

Parámetros para indicar reclamos adicionales de autorización en la Plantilla JWT en los proyectos PowerServer:

Scope =  		 
Name =  		 
GivenName =  		 
FamilyName =  		 
WebSite =  		
Email =  		
EmailVerified =  	


Para estar al tanto de lo que publico puedes seguir mi blog:

https://rsrsystem.blogspot.com/

Os dejo enlace de un video demostrativo:

youtu.be/pruqqhBwN2Q
