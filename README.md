# VisualPbAutobuild220

VisualPbAutobuild220 en una programa para ayudar a usar de forma más cómoda el PbAutobuild220.exe incluido con PowerBuilder 2022

Este ejemplo permite cargar un archivo json de un Proyecto PowerBuilder Cliente/Servidor, PowerClient y PowerServer.

En el archivo de configuración Setup.ini hay que indicar algunos parametros:

En apartado [Setup]

json = --> Sirve para recordar el último json abierto y abrirlo al abrir el programa.

PbAutobuildPath = --> Parametro Opcional. Se puede incluir la ruta donde este PbAutobuild220.exe.

Ejemplo:

PbAutobuildPath = C:\Program Files (x86)\Appeon\PowerBuilderUtilities 22.0\pbautobuild220.exe

Para cada proyecto  (o json) hay que crear un apartado con los siguientes campos:
Si los proyectos tienen cosas en comun y no quieres duplicar la info, en el apartado Setup puedes poner los que quieras que sean comunes para todos los proyectos.
El rograma primero intenta leer del apartado del proyecto y si no mira en el apartado Setup.

[projectName.json]

// Esos tres parametros sólo se usan si el poryeto es PowerServer con JWT

version_control= -- > Si marcamos S, Necesitamos descargar un archivo con la Versión de GitHub. Habrá que rellenar lo siguientes parámetros:

ProfileVisibility = --> Private or Public: Si el repositorio es Privado nos hara falta el personal Token.
GitHubProfileName = --> Nombre del perfil de Github 
PersonalToken  = ---> Token de acceso personal al Perfil Privado
GitHubRepository = --> Nombre del repositorio
GitBranch =  --> Rama de donde bajaremos el archivo, normalemnte main o master.
Pbl = --> nombre del archivo pbl de PowerBuilder donde guardamos el proyecto.
filename = ---> Nombre del fichero exportado del proyecto (*.srj) ejemplo: projectName.srj


Para Proyectos PowerServer hay que indicar lo siguiente:

UserName = --> Usuario para Api PowerServer con seguridad JWT
UserPass = --> Password Codificado en Base64URL para Api PowerServer con seguridad JWT
PowerServerPath= ---> Ruta fisica del sitio web de la api en el servidor.

Parameros para generar los Claims de la Clase DefaultUserStore.cs si se usa Seguridar JWT.

Scope = serverapi
Name = Nombre y Apellido
GivenName = Nombre
FamilyName = Apellido
WebSite = SitioWeb
Email = Mail
EmailVerified = true

Para Proyectos Nativos Cliente/Servidor: 
PBNativePath= --> se puede indicar la ruta del servidor donde queremos dejar el programa compilado:


Para estar al tanto de lo que publico puedes seguir mi blog:

https://rsrsystem.blogspot.com/

