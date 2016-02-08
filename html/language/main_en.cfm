<cfsilent>
<cfscript>
curLangTextEn = structNew();
curLangTextEn = {
  "token": {
		/*common*/
		"Salir":"Logout",
		"Volver":"Return",
		"Guardar":"Save",
		"Enviar":"Send",
		"Cancelar":"Cancel",
		"Sí":"Yes",
		"No":"No",
		"Aceptar":"Accept",
		/*END common*/


		/*login*/
		"Entrar":"Enter",
		"Acceder a la aplicación":"Access the application",
		"Resetear contraseña":"Reset password",
		"¿Olvidó su contraseña?":"Forgot your password?",
		"Acceso a DoPlanning":"Access of DoPlanning",
		"Ayuda DoPlanning":"DoPlanning Help",
		"Identificar con usuario y contraseña de:":"Identify with user and password of:",
		"Usuario o contraseña incorrecta.":"Incorrect user or password",
		"Para una mejor experiencia con DoPlanning recomendamos el uso de un navegador moderno distinto a Internet Explorer":"For the best experience with DoPlanning we recommend using a different browser than Internet Explorer",
		/*END login*/

		/*remember_password.cfm*/
		"es" : "en",
		"Obtener una nueva contraseña para DoPlanning":"Get a new password for DoPlanning",
		"Introduzca los siguientes números":"Enter the following numbers",
		"Su nueva contraseña ha sido enviada a su dirección de email":"Your new password has been sent to your email address",
		"Cuenta de usuario deshabilitada":"Disabled user account",
		/*END remember_password.cfm*/


		/*main_en.js*/
		"Árbol de áreas":"Areas tree",
		"Árbol":"Tree",
		"Área":"Area",
		"Búsqueda":"Search",
		"Papelera":"Bin",
		"Usuario":"User",
		"Cerrar sesión":"Exit",
		"Buscar":"Search",
		"Búsqueda de área":"Area search",
		"Actualizar":"Refresh",
		"Expandir":"Expand",
		"Colapsar":"Collapse",
		"Buscar área en el árbol":"Search area in the tree",
		"Expandir todo el árbol":"Expand whole tree",
		"Colapsar todo el árbol":"Collapse whole tree",

		"Administración":"Administration",
		"Datos personales":"Personal data",
		"Notificaciones":"Notifications",

		"Lo último":"Last items",
		"VER":"VIEW",
		"Filtrar":"Filter",
		"Ver en área":"View in area",
		"Ir al área":"Go to area",
		"Mostrar":"Show",
		"Elementos de áreas":"Areas items",
		"Áreas con actividad reciente":"Areas with recent activity",
		"Messages":"Messages",

		/*Este grupo se tiene que borrar al incluir area_item_en.js*/
		"Tareas pendientes":"Pending tasks",
		"Eventos próximos":"Upcoming Events",
		"No hay eventos próximos":"There are no upcoming events",
		"No tiene tareas pendientes":"You don't have pending tasks",
		"No hay listas":"No lists",
		"Caduca hoy":"Expires today",
		"Caducada":"Expired",
		"Hoy":"Today",
		"Nueva versión":"New version",
		"Modificación":"Edited",

		"No hay elementos":"No items",

		/*Este grupo se tiene que borrar al incluir area_item_en.js*/
		"Abrir en nueva ventana":"Open in new window",
		"Responder":"Reply",

		"Fecha de inicio":"Start date",
		"Fecha de fin":"End date",
		"Realizada":"Done",

		"Nueva área":"New area",
		"Mover":"Move",
		"Mover área":"Area move",
		"Modificar":"Modify",
		"Modificar área":"Area modify",
		"Exportar":"Export",
		"Exportar áreas":"Export areas",
		"Importar":"Import",
		"Importar áreas":"Import areas",
		"Eliminar":"Delete",
		"Eliminar área":"Delete area",
		"Volver":"Return",

		"Accede a las áreas de la organización a través de la pestaña":"You can access the areas of the organization through the tab",
		"para crear nuevos elementos":"to create new items",

		"No hay resultados":"No results",
		"resultados":"results",
		/*END main_en.js*/

		/*area_menu*/
		"Mostrar información del área":"Show area information",
		"Ocultar información del área":"Hide area information",
		"Tipo de área:":"Area type:",
		"No hay descripción del área":"No description of the area",
		"URL del área en DoPlanning:":"URL of the area in DoPlanning:",
		"URL relativa en la <b>web</b>:":"Relative URL on the <b>web</b>:",
		"URL relativa en la <b>intranet</b>:":"Relative URL on the <b>intranet</b>:",
		"Ruta:":"Path:",
		"Mostrar subareas":"Show subareas",

		"Todos los elementos del área":"All area elements",
		"Mensajes del área":"Area messages",
		"Archivos del área":"Area files",
		"Eventos del área":"Area events",
		"Tareas del área":"Area tasks",
		"Consultas del área":"Area consultations",
		"Listas del área":"Area lists",
		"Formularios del área":"Area forms",
		"Publicaciones del área":"Area publications",
		"Documentos DoPlanning del área":"Area DoPlanning Documents",
		"Usuarios del área":"Area users",
		"Elementos de contenidos WEB del área":"Area Generic content elements",
		"Noticias WEB del área":"Area Web News",
		"Enlaces del área":"Area links",
		"Acceder a reunión virtual del área":"Virtual meeting",
		"Messenger del área":"Area messenger",
		"Acceder a Reunión virtual del área (SOLO para PCs)":"Virtual meeting (only for PCs)",
		"Acceder a Presentación virtual del área (SOLO PCs)":"Virtual presentation (only for PCs)",

		"Nuevo elemento":"New element",
		"Nuevo Mensaje":"New Message",
		"Nuevo Archivo":"New File",
		"Nuevo Archivo de área":"New area File",
		"Nuevo Evento":"New Event",
		"Nueva Tarea":"New Task",
		"Nueva Consulta":"New Consultation",
		"Nuevo Elemento web":"New web element",
		"Nueva Noticia":"New News item",
		"Nueva Lista":"New List",
		"Nuevo Formulario":"New Form",
		"Nueva Publicación":"New Publication",
		"Nuevo Documento DoPlanning":"New DoPlanning Document",

		"Subir nuevo archivo":"Upload new file",
		"Asociar Archivo":"Associate File",
		"Asociar archivo existente":"Associate existing file",

		"Modo árbol":"Tree mode",
		"Modo lista":"List mode",
		"Modo completo":"Full mode",
		"Actualizar":"Refresh",
		"Abrir en nueva ventana":"Open in new window",
		"URL del área en DoPlanning":"URL of the area in DoPlanning",
		"Elementos del área":"Area elements",
		"CSV":"CSV",
		"PDF":"PDF",
		/*END area_menu*/


		/*area.cfm*/
		"Seleccione un área del árbol para acceder a su contenido.":"Select an area of the tree to access its contents.",
		"No tiene acceso a los contenidos de esta área.":"You can not access to the contents of this area.",
		/*END area.cfm*/

		/*area_content.cfm*/
		"Árbol de la organización":"Organization tree",
		"No hay más áreas dentro de esta.":"No more areas within this",
		/*END area_content.cfm*/

		"Todos los elementos de área":"All area items",
		"Áreas":"Areas",
		"Mensaje":"Message",
		"Mensajes":"Messages",
		"Archivo":"File",
		"Archivos":"Files",
		"Archivo de área":"Area file",
		"Archivos de area":"Area files",
		"Evento":"Event",
		"Eventos":"Events",
		"Tarea":"Task",
		"Tareas":"Tasks",
		"Consulta":"Consultation",
		"Consultas":"Consultations",
		"Elemento web":"Web element",
		"Elementos web":"Web elements",
		"Noticia":"News",
		"Noticias":"News",
		"Usuario":"User",
		"Usuarios":"Users",
		"Imagen":"Image",
		"Imágenes":"Images",
		"Lista":"List",
		"Listas":"Lists",
		"Vista de Lista":"List view",
		"Vistas de Listas":"Lists views",
		"Formulario":"Form",
		"Formularios":"Forms",
		"Vista de Formulario":"Form view",
		"Vistas de Formularios":"Forms views",
		"Publicación":"Publication",
		"Publicaciones":"Publications",
		"Documento DoPlanning":"DoPlanning Document",
		"Documentos DoPlanning":"DoPlanning Documents",
		"Tipología de archivo":"File typology",
		"Tipologías de archivos":"File typologies",
		"Tipología de usuario":"User typology",
		"Tipologías de usuarios":"Users typologies",
		"Boletín":"Newsletter",
		"Boletines":"Newsletters",

		"Ver":"View",



		/*area_item_new_content*/
		"Nuevo Mensaje":"New Message",
		"Nuevo Evento":"New Event",
		"Nueva Tarea":"New Task",
		"Nueva Consulta":"New Consultation",
		"Nuevo Elemento web":"New Generic content element",
		"Nueva Noticia":"New News item",
		"Nueva Lista":"New List",
		"Nuevo Formulario":"New Form",
		"Nueva Publicación":"New Publication",
		"Nuevo Documento DoPlanning":"New DoPlanning Document",
		"Nueva Tipología de archivo":"New File Typology",
		"Nuevo Boletín":"New Newsletter",
		/*END area_item_new_content*/

		/*area_item_modify_content*/
		"Modificar Mensaje":"Modify Message",
		"Modificar Evento":"Modify Event",
		"Modificar Tarea":"Modify Task",
		"Modificar Consulta":"Modify Consultation",
		"Modificar Elemento web":"Modify web content element",
		"Modificar Noticia":"Modify News item",
		"Modificar Lista":"New List",
		"Modificar Formulario":"New Form",
		"Modificar Publicación":"Modify Publication",
		"Modificar Boletín":"Modify Newsletter",
		"PubMed":"PubMed",

		"Modificar Documento DoPlanning":"Modify DoPlanning Document",
		"Archivo eliminado.":"File deleted.",
		"Imagen eliminada.":"Image deleted.",
		/*END area_item_modify_content*/

		"Asunto":"Subject",
		"Título":"Title",
		"Fecha de creación":"Creation date",
		"Formato DD-MM-AAAA. Ejemplo:":"DD-MM-YYYY format. Example:",
		"Fecha de publicación":"Publication date",
		"Si está definida, este contenido se mostrará en la web en la fecha especificada.":"If defined, this content will be accessible from the web on the specified date",
		"Si está definida, este contenido se mostrará en la intranet en la fecha especificada.":"If defined, this content will be accessible from the intranet on the specified date",
		"Publicación aprobada":"Publication approved",
		"Usuario destinatario":"Destination user:",
		"Seleccionar usuario":"Select user",
		"Usuario al que se le asignará la tarea":"The user who will have to do the task",
		"Fecha de inicio":"Start date",
		"Fecha de fin":"End date",
		"Hora de fin":"End hour",
		"Valor estimado":"Estimated value",
		"Valor real":"Real value",
		"Tarea realizada":"Task done",
		"Tarea encargada por":"From user",
		"Lugar":"Place",
		"URL más información:":"URL more information:",
		"URL más información (enlace)":"URL more information (link)",
		"Abrir URL en":"Open URL in",
		"Nueva ventana":"New window",
		"Misma ventana":"Same window",
		"Incrustar contenido":"Embed content",
		"(Sólo para publicar en web)":"(Only for web publication)",
		"Tamaño contenido incrustado":"Embed content size",
		"Posición":"Position",
		"Tipo de visualización":"Visualization type",
		"Identificador":"Identifier",
		"Identificador/Número":"Identifier/Number",
		"Tipo":"Type",
		"Tipo de":"Type of",
		"Revista":"Journal",
		"Ver en PubMed":"Open in PubMed",
		"Obtener datos de PubMed":"Get data from PubMed",
		"PubMed Id no válido":"Invalid PubMed Id",
		"Precio":"Price",
		"Valor":"Value",

		"Registros":"Records",
		"Campos":"Fields",
		"Campo":"Field",
		"Vistas":"Views",
		"Editores":"Editors",
		"Nuevo registro":"New record",
		"Nuevo Registro":"New Record",
		"Mostrar/ocultar columnas":"Show/hide columns",
		"Exportar registros":"Export records",
		"Importar registros":"Import records",
		"Selecciona las columnas que quieres ver":"Select the columns you want to show",
		"Más":"More",
		"Registro guardado":"Record saved",
		"Se generará un archivo con codificación iso-8859-1 con el contenido de los registros.":"A file with iso-8859-1 codification will be generated with the content of the records",
		"Delimitador de campos":"Field delimiter",
		"Punto y coma ;":"Semicolon ;",
		"Tabulación":"Tab",
		"Incluir las siguientes columnas:":"Include the following columns",
		"Fecha de última modificación":"Last modified date",
		"Usuario creación":"Creation user",
		"Usuario última modificación":"Last modification user",
		"Aplicar máscaras a los valores decimales exportados.":"Apply masks to exported decimal values",
		"Use esta opción para poder exportar los valores decimales delimitados por coma en lugar de punto para que sean interpretados correctamente en Excel":"Use this option to export comma instead of dot-delimited decimal values, for them to be correctly interpreted in Excel",
		"Habilitar compatibilidad de apertura con las nuevas versiones de Microsoft Office Excel (versiones a partir de 2010)":"Enable opening compatibility with new versions of Microsoft Office Excel (2010 versions and newer)",
		"Mover Lista a otra área":"Move List to other area",
		"Área actual":"Current area",
		"Cambiar área":"Change area",
		"Se enviará notificación por email del del cambio de área del Lista.":"An email notification will be sent informing about the area change",
		"Selección de área":"Area selection",
		"Nueva vista":"New view",
		"Haga clic en Nueva vista para crear una nueva vista.":"Click in New view to create a new view.",

		"El archivo utilizado para realizar esta importación deberá tener las siguientes características:":"The import file must have the following features:",
		"-Tipo de archivo:":"-File type:",
		".csv o .txt":".csv or .txt",
		"delimitado por ; o por tabulaciones.":"delimited by ; or by tabs.",
		"Punto y coma es la delimitación por defecto en el SO Windows en España (esto varía en configuraciones por defecto de otros paises o idiomas).":"Semicolon is the default delimitation in Spain for Windows OS (these default configurations change for other countries or languages).",
		"Codificación":"Codification",
		"(codificación por defecto en Windows)":"(codification by default in Windows)",
		"Número de columnas":"Number of columns",
		"Orden de las columnas":"Column order",
		"Campos listas":"Lists fields",
		"para que la importación de los campos de listas se realice correctamente, el valor importado de estos campos deberá coincidir exactamente con uno de los valores existentes en la lista.":"for correct performance of list import, the imported value of these fields must match exactly with one of the values already existing in the list.",
		"Campos Sí/No":"Yes/No fields",
		"los valores válidos para estos campos son Sí/No, Yes/No, true/false, 0/1":"Valid values for these fields are Sí/No, Yes/No, true/false, 0/1",
		"Campos fecha":"Date fields",
		"formatos válidos las fechas:":"valid date formats:",
		"DD-MM-AAAA, DD/MM/AAAA":"DD-MM-YYYY, DD/MM/YYYY",
		"Campos de listas con selección múltiple":"Multiple selection list fields",
		'los valores seleccionados de estos campos deberán delimitarse por ; y delimitando a su vez el campo que contiene estos valores por "':'the selected values for these fields must be delimited with ; and conversely delimiting the field containing these values with \',
		"Borrar registros existentes en el Formulario":"Delete existing fields in the Form",

		"aplicándole una máscara, y posteriormente seleccionar esta opción en la importación para que se tenga en cuenta la máscara al realizar la importación.":"by applying a mask and afterwards selecting this option in the import, in order to use the mask during the import process.",
		"definición de los campos":"field definition",
		"Si los decimales usan otro formato distinto, como por ejemplo separar la cifra decimal por coma en lugar de punto, debe especificarlo primero en la":"If decimals use a different format, such as comma separation of the decimal cypher, you must specify it first in the",
		"Por defecto los campos decimales deben estar en el siguiente formato: 9999.99":"By default, decimal fields must be in this format: 9999.99",
		"Use esta opción para poder importar valores decimales delimitados por coma en lugar de punto": "Use this option to import decimal values separated by comma instead of dot",
		"(No hay campos decimales definidos con máscara, esta opción se ignorará)":"(There are no defined decimal value fields with mask, this option will be ingnored)",
		"Los valores decimales usan las máscaras especificadas en la definición de los campos":"Decimal values use the masks specified in the field definition",
		"Por defecto no se importa la primera fila del archivo (fila para los títulos de las columnas)":"The first row of the file is not imported by default (row for the column titles)",
		"Importar primera fila del archivo":"Import first row of the file",
		"No cancelar si hay errores en importación de registros":"Do not cancel if there are errors in record import",
		"Borrar registros existentes en la Lista":"Delete previous records from the List",
		"Archivo CSV con los registros a importar":"CSV file with records to import",
		"-Si el orden de las columnas no corresponde con el anterior la importación no se realizará correctamente.":"-If column order does not correspond with that from the list, import will not be made properly",
		"-Si no se cumplen las características anteriores, la importación no se podrá realizar correctamente.":"If these conditions are not met, import will not perform correctly.",
		"No se enviará notificación instantánea de los nuevos registros a los usuarios.":"No notification of the new records will be sent to users.",
		'Una vez pulsado el botón "Importar registros" debe esperar hasta que se complete la operación.':'Once the "Import records" button has been clicked, you must wait until the process is completed.',


		"Archivo adjunto:":"Attached file:",
		"Archivo adjunto":"Attached file",
		"Imagen":"Image",
		"Imagen (jpg, png, gif)":"Image (jpg, png, gif)",
		"Imagen adjunta:":"Attached image:",
		"Imagen adjunta":"Attached image",
		"Eliminar archivo adjunto":"Delete attached file",
		"Eliminar imagen adjunta":"Delete attached image",

		"* Campos obligatorios.":"* Required fields.",

		"Enviando...":"Sending...",
		"Cargando...":"Loading...",
		"Fechas incorrectas. Compruebe que la fecha de fin del evento es igual o posterior a la fecha de inicio y tiene el formato adecuado.":"Incorrect dates. Make sure the event ending date is on or after the start date and has the proper format.",

		"Tiene texto sin enviar, si abandona esta página lo perderá":"You have text without send, if you leave this page you will lose it",

		"Documento editable por los usuarios del área":"The document can be edited by area users",
		"Permite que los usuarios del área puedan editar el documento y habilita el sistema de bloqueo del documento":"Allows area users to edit the document and enables document locking system",
		"Si el archivo está bloqueado no puede ser editado por otros usuarios":"If the file is locked it can not be edited by other users",
		"Mover Documento DoPlanning a otra área":"Move DoPlanning Document to other area",
		"Se enviará notificación por email del del cambio de área del Documento DoPlanning.":"An email notification will be sent informing about the area change",
		"Propietario actual":"Current owner",
		"Nuevo propietario":"New owner",
		"Se enviará notificación por email del cambio al nuevo propietario y al anterior.":"An email notification will be sent both to the new owner and to the preceding one",


		/*functions.js*/
		"¿Seguro que desea ":"Are you sure you want ",
		"?. Esta acción no es reversible.":"?. This action is not reversible.",

		"eliminar":"to delete",
		"eliminar el archivo adjunto":"to delete the attached file",
		"eliminar la imagen adjunta":"to delete the attached image",
		"cerrar la Consulta":"to close the Consultation",
		/*END functions.js*/

		/*area_item_content*/
		"Modificar":"Modify",
		"Responder":"Reply",
		"Cerrar":"Close",
		"Cerrar Consulta":"Close Consultation",
		"Realizada":"Done",
		"Eliminar":"Delete",
		"Ampliar":"Enlarge",
		"Abrir en nueva ventana":"Open in new window",
		"Adjunto":"Attached",
		"Copiar como":"Copy as",
		"Cambiar propietario":"Change owner",
		"Mover a otra área":"Move to other area",
		"Bloquear":"Lock",
		"Desbloquear":"Unlock",
		"Exportar para calendario externo":"Export to external calendar",
		"Eportar en formato iCalendar (.ics)":"Export in iCalendar format (.ics)",

		"Asignada a:":"Asigned to:",
		"Estado:":"State:",
		"Enviada":"Sent",
		"Leída":"Read",
		"Respondida":"Answered",
		"Cerrada":"Closed",
		"Fecha de envío:":"Sent date:",
		"Fecha de lectura:":"Read date:",
		"Fecha de respuesta:":"Answer date:",
		"Fecha de cierre:":"Closing date:",
		"Fecha de última modificación:":"Last modification date:",
		"Fecha de inicio del evento:":"Event start date:",
		"Fecha de fin del evento:":"Event end date:",
		"Última modificación por:":"Last update by:",
		"Fecha de bloqueo:":"Lock date:",
		"Hora":"Hour",
		"Realizada:":"Done:",
		"Hecha:":"Done:",
		"Archivo:":"File:",
		"Imagen:":"Image:",
		"URL del enlace:":"Link URL:",
		"Más información:":"More information:",
		"Identificador:":"Identifier:",
		"Descripción:":"Description:",
		"Contenido:":"Content:",
		"URL en DoPlanning:":"DoPlanning URL:",
		"Tipo:":"Type:",
		"Enlace a PubMed:":"PubMed link:",
		/*END area_item_content*/

		/*area_item_copy.cfm*/
		"Copiar":"Copy",
		"a áreas":"to areas",

		"Copiar Mensaje a áreas seleccionadas":"Copy Message to selected areas",
		"Copiar Evento a áreas seleccionadas":"Copy Event to selected areas",
		"Copiar Tarea a áreas seleccionadas":"Copy Task to selected areas",
		"Copiar Consulta a áreas seleccionadas":"Copy Consultation to selected areas",
		"Copiar Elemento de contenido a áreas seleccionadas":"Copy Content element to selected areas",
		"Copiar Noticia a áreas seleccionadas":"Copy News item to selected areas",
		"Copiar Publicación a áreas seleccionadas":"Copy Publication to selected areas",
		"Copiar Documento DoPlanning a áreas seleccionadas":"Copy DoPlanning Document to selected areas",

		"Seleccione las áreas a las que desea copiar el":"Select the areas you want to copy the",
		"Seleccione las áreas a las que desea copiar la":"Select the areas you want to copy the",

		"Editar contenido":"Edit content",
		"Áreas a las que copiar":"Áreas to copy",
		"Debe seleccionar al menos un área":"You must select at least one area",
		/*END area_item_copy.cfm*/

		/*item_change_area.cfm*/

		"Mover Mensaje a otra área":"Move Message to other area",
		"Mover Imagen a otra área":"Move Image to other area",
		"Mover Evento a otra área":"Move Event to other area",
		"Mover Tarea a otra área":"Move Task to other area",
		"Mover Consulta a otra área":"Move Consultation to other area",
		"Mover Elemento web a otra área":"Move Web element to other area",
		"Mover Noticia a otra área":"Move News to other area",
		"Mover Publicación a otra área":"Move Publication to other area",
		"Mover Documento DoPlanning a otra área":"Move DoPlanning Document to other area",
		"Mover Formulario a otra área":"Move Form to other area",


		"Se enviará notificación por email del cambio de área del Mensaje.":"An email notification will be sent informing of the area change of the Message.",
		"Se enviará notificación por email del cambio de área de la Imagen.":"An email notification will be sent informing of the area change of the Image.",
		"Se enviará notificación por email del cambio de área del Evento.":"An email notification will be sent informing of the area change of the Event.",
		"Se enviará notificación por email del cambio de área del Elemento web":"An email notification will be sent informing of the area change of the Web element.",
		"Se enviará notificación por email del cambio de área de la Tarea":"An email notification will be sent informing of the area change of the Task.",
		"Se enviará notificación por email del cambio de área de la Noticia":"An email notification will be sent informing of the area change of the News.",
		"Se enviará notificación por email del cambio de área de la Consulta":"An email notification will be sent informing of the area change of the Consultation.",
		"Se enviará notificación por email del cambio de área de la Publicación":"An email notification will be sent informing of the area change of the Publication.",
		"Se enviará notificación por email del cambio de área del Documento DoPlanning":"An email notification will be sent informing of the area change of the DoPlanning DOcument.",
		"Se enviará notificación por email del cambio de área del Formulario":"An email notification will be sent informing of the area change of the Form.",

		/*area_items_content*/
		"No tiene acceso para ver los mensajes de esta área":"You do not have access to view messages from this area",
		"No tiene acceso para ver los archivos de esta área":"You do not have access to view files from this area",
		"No tiene acceso para ver los eventos de esta área":"You do not have access to view events from this area",
		"No tiene acceso para ver las tareas de esta área":"You do not have access to view tasks from this area",
		"No tiene acceso para ver los usuarios de esta área":"You do not have access to view users from this area",

		"De":"From",
		"Para":"To",
		"Fecha":"Date",
		"Inicio":"Start",
		"Fin":"End",
		"Área":"Area",
		"VE":"EV",
		"VR":"RV",
		"Estado":"State",
		"Tipo":"Type",
		"Fecha asociación":"Association date",
		"Fecha de asociación":"Association date",
		"Última versión":"Last version",
		"Archivo sin nombre":"Unnamed file",
		"Nombre":"Name",
		"Apellidos":"Last name",
		"Email":"Email",
		"De esta área":"From this area",
		"Responsable del área":"Area manager",
		"Reunión virtual":"Virtual meeting",
		"Fecha desde":"Date from",
		"Fecha hasta":"Date to",

		"No hay messages en esta área.":"There are no messages in this area.",
		"No hay eventos en esta área.":"There are no events in this area.",
		"No hay tareas en esta área.":"There are no tasks in this area.",
		"No hay consultas en esta área.":"There are no consultations in this area.",
		"No hay noticias en esta área.":"There are no news in this area.",
		"No hay elementos de contenido web en esta área.":"There are no web content elements in this area.",
		"No hay archivos en esta área.":"There area no files in this area.",
		"No hay usuarios.":"There are no users.",
		/*"No hay elementos en esta área.":"There are no elements in this area.",*/
		"Aún nadie ha puesto información aquí, ¿por qué no ser el primero?":"No one has posted information here yet, why not be the first?",
		"Exportar contenido":"Export content",

		/*search*/
		"Rellene el formulario y haga click en BUSCAR":"Enter search parameters and click Search",
		"Todos":"All",
		"Nº resultados":"Number of results",
		"Estado actual":"Current state",
		"Buscar":"Search",
		"Resultado:":"Result:",
		"Buscar en":"Search",
		"Buscar texto":"Search text",
		"Tipo de elemento a buscar":"Type of element to search",
		"Estructura compartida":"Shared structure",
		/*END search*/


		/*AreaItem.cfc*/
		"Mensaje enviado.":"Message sent.",
		"Evento enviado.":"Event sent.",
		"Tarea enviada.":"Task sent.",
		"Consulta enviada.":"Consultation sent.",
		"Elemento web enviado.":"Generic content element sent.",
		"Noticia enviada.":"News item sent",
		"Respuesta a Consulta enviada.":"Consultation response sent.",

		"Evento modificado.":"Event modified.",
		"Tarea modificada.":"Task modified.",
		"Elemento web modificado.":"Generic content element modified.",
		"Noticia modificada.":"News item modified",

		"Mensaje copiado a las áreas seleccionadas.":"Message copied to selected areas.",
		"Evento copiado a las áreas seleccionadas.":"Event copied to selected areas.",
		"Tarea copiada a las áreas seleccionadas.":"Task copied to selected areas.",
		"Consulta copiada a las áreas seleccionadas.":"Consultation copied to selected areas.",
		"Elemento web copiado a las áreas seleccionadas.":"Generic content element copied to selected areas.",
		"Noticia copiada a las áreas seleccionadas.":"News item copied to selected areas.",
		"Consulta copiada a las áreas seleccionadas.":"Consultation copied to selected areas.",

		"Mensaje eliminado.":"Message deleted.",
		"Evento eliminado.":"Event deleted.",
		"Tarea eliminada.":"Task deleted.",
		"Consulta eliminada.":"Consultation deleted.",
		"Elemento web eliminado.":"Generic content element deleted.",
		"Noticia eliminada.":"News item deleted",

		"Mensaje incorrecto.":"Incorrect message.",
		"Evento incorrecto.":"Incorrect event.",
		"Tarea incorrecta.":"Incorrect task.",
		"Consulta incorrecta.":"Incorrect consultation.",
		"Elemento web incorrecto.":"Incorrect web content element.",
		"Noticia incorrecta.":"Incorrect news item.",

		"Archivo eliminado.":"Deleted file.",
		"Imagen eliminada.":"Image deleted.",

		"Error al crear la imagen.":"Failed to create the image.",
		"Ha ocurrido un error al subir el archivo adjunto.":"Failed to upload attachment.",
		"Ha ocurrido un error al subir la imagen.":"Failed to upload image.",

		"Tarea marcada como realizada":"Task marked as done",
	  	"Tarea no realizada": "Undone task",
		/*END AreaItem.cfc*/

		"Cambiar propietario del Documento DoPlanning":"Change owner of the DoPlanning Document",
		"Cambiar propietario del Elemento web":"Change owner of the Web Element",
		"Cambiar propietario de la Noticia":"Change owner of the news",
		"Cambiar propietario de la Imagen":"Change owner of the Image",
		"Cambiar usuario propietario":"Change owner user",
		"Convertir en archivo del área":"Convert to area file",
		"Cambiar propietario del archivo":"Change owner fo the file",
		"Cambiar propietario del Evento":"Change owner of the Event",
		"Cambiar propietario de la Tarea":"Change owner of the Task",
		"Cambiar propietario de la Lista":"Change owner of the List",
		"Cambiar propietario del Formulario":"Change owner of the Form",
		"Cambiar propietario de la Consulta":"Change owner of the Consultation",
		"Cambiar propietario de la Publicación":"Change owner of the Publication",

		/*File.cfc*/
		"Archivo asociado al área.":"File added to area.",
		"Archivo asociado a las áreas.":"File added to areas.",
		"Archivo asociado a las áreas. En una o varias de las areas seleccionadas ya estaba asociado.":"File added to areas. In one or more of the selected areas the file already was associated.",
		"Archivo quitado del área.":"File removed from area.",
		"Archivo modificado.":"File modified.",
		"Archivo eliminado.":"File deleted.",
		/*END File.cfc*/

		/*area_file_upload.cfm, area_file_replace_upload.cfm*/
		"Ha ocurrido un error al subir el archivo.":"Failed to upload the file",
		"Archivo reemplazado correctamente.":"File replaced",
		/*END area_file_upload.cfm, area_file_replace_upload.cfm*/


		"Si ELIMINA el archivo, se borrará de TODAS las áreas a las que esté asociado. ¿Seguro que desea borrar el archivo?":"If you DELETE the file, it will be deleted from ALL areas to which it is associated. Are you sure you want to delete the file?",

		"Descargar":"Download",
		"Abrir":"Open",
		"Visualizar":"View",
		"Reemplazar":"Replace",
		"Asociar a áreas":"Associate to areas",
		"Modificar datos":"Modify data",
		"Quitar del área":"Remove from area",
		"Visualizar en":"View in",
		"Versiones":"Versions",
		"Validar versión":"Validate version",
		"Rechazar versión":"Reject version",
		"Cancelar revisión":"Cancel revision",
		"Bloquear":"Lock",
		"Desbloquear":"Unlock",

		"Propiedad del área":"Property of area",
		"Creado por":"Created by",
		"Último reemplazo por":"Last version by",
		"Última version por":"Last version by",
		"Revisor":"Reviser user",
		"Aprobador":"Approval user",
		"Nombre de archivo":"File name",
		"Fecha de reemplazo":"Replacement date",
		"Fecha de última versión":"Last version date",
		"Fecha de publicación":"Publication date",
		"Fecha de envío a revisión":"Send to revision date",
		"Tipo de archivo":"File type",
		"Tamaño":"Size",
		"Generando archivo...":"Generating file...",
		"Tipología":"Typology",
		"Ámbito de publicación":"Publication scope",
		"Nombre físico":"Physical name",
		"Motivo de rechazo en aprobación":"Reason for rejection on approval",
		"Motivo de rechazo en revisión":"Reason for rejection on revision",
		"Analizado por Antivirus":"Analyzed by Antivirus",
		"URL para enlazar a":"URL link to",
		"URL para compartir el archivo con":"URL to share the file with",
		"usuarios de DoPlanning":"Doplanning users",
		"descargar el archivo desde DoPlanning":"download the file from DoPlanning",
		"URL pública para": "Public URL to",
		"enlazar el archivo en la web":"link the file in the web",
		"URL relativa para":"Relative URL to",
		"Última versión de archivo analizada por Antivirus":"Last file version analysed with antivirus",
		"Archivo en proceso de revisión y aprobación":"File in process of revision and approval",
		"Estado actual":"Current state",
		"pendiente de ser revisado por":"pending of review by:",
		"Debe validar o rechazar la versión de este archivo":"You must validate or reject this version of the file",
		"Archivo bloqueado por el usuario":"File blocked by user",
		"Fecha de bloqueo":"Blocking date",
		"Publicar versión":"Publish version",
		"Convertir en archivo de área":"Convert to area file",
		"Área propietaria del archivo":"Owner area of the file",
		"El archivo pasará a ser propiedad del área seleccionada y podrá ser modificado por cualquier usuario de la misma.":"The file will become property of the selected area and will be modifiable by any user of that area.",
		"El archivo seguirá estando accesible desde el área actual.":"The file will still be accesible from the current area.",
		"Se enviará notificación por email del cambio a los usuarios del área propietaria.":"An email notification with this change will be sent to users of the owner area.",


		"Subir varios archivos":"Upload multiple files",
		"Añadir archivos":"Add files",
		"Iniciar todos":"Start all",
		"Cancelar todos":"Cancel all",
		"Iniciar":"Start",
		"Puede arrastrar aquí los archivos que desea subir.":"You can drag here files to upload",
		"Archivo de usuario":"User file",
		"Archivo de área sin circuito de calidad":"Area file without quality circuit",
		"Archivo de área con circuito de calidad":"Area file with quality circuit",
		"Subido":"Uploaded",
		"Quitar de la lista":"Remove from list",

		/*area_file_new.cfm*/
		"Nombre":"Name",
		"Número de versión":"Version number",
		"Una vez pulsado el botón, la solicitud tardará dependiendo del tamaño del archivo.":"After clicking the button, the request will take some time depending on the file size.",
		"Enviando archivo...":"Sending file...",

		"Este archivo te pertenecerá a ti y sólo tú podrás modificarlo. Cada vez que subas una versión del archivo se sobreescribirá la anterior.":"This file will belong to you and only you can change it. Each time you upload a file version the previous version will be overwritten.",

		"Este archivo pertenecerá a esta":"This file will belong to this",
		"área":"area",
		"y podrá ser modificado por cualquier usuario con acceso a la misma.":"and anyone with access to this area will be able to modify it.",

		"Define las áreas del árbol donde se podrá asociar el documento.":"This defines the areas of the tree in which the document can be associated",
		"Importante":"Important",
		"los archivos con el ámbito WEB PÚBLICA o INTRANET pueden ser accedidos mediante su URL a través de la web o intranet sin necesidad de que sean asociados a las áreas web o aprobada su publicación.":" files with scope PUBLIC WEB or INTRANET may be accessed by their URL through web or intranet without having to associate them to areas or approving their publication.",

		"-Sin circuito de calidad: cada vez que se suba una versión del archivo se sobreescribirá la anterior (no se guardan las versiones previas del archivo)<br><br>-Con circuito de calidad: se guardan las distintas versiones del archivo y es requerido un proceso de revisión y aprobación de las versiones.":
		"-Without quality circuit: each time a file is uploaded, the previous version will be overwritten(previous versions of the file are not saved)<br><br>-With quality circuit: different versions of the file are saved and it is required a process of review and approval of the versions",

		"Área de publicación":"Publication area",
		"Seleccionar área":"Select area",
		"Tipo de documento de área":"Area document type",
		"Sin circuito de calidad":"Without quality circuit",
		"Con circuito de calidad":"With quality circuit",
		"Esta opción no se puede cambiar una vez creado el documento":"This option can not be changed after the creation of the document",
		"Usuario revisor":"Reviser user",
		"Usuario aprobador":"Approval user",
		"Seleccionar usuario":"Select user",
		"Básica":"Basic",

		"Define dónde se podrá publicar el documento":"This sets the areas where the document can be published",

		"Si está definida, el archivo se publicará en la fecha especificada (sólo para publicación en web e intranet).":"If set, the file will be published on the specified date (for publication on web and intranet only).",

		"Aprobar publicación":"Approve publication",
		"Valida el archivo para que pueda ser publicado (sólo para publicación en web e intranet).":"Validates the file so that it can be published (only for publication on website and intranet)",
		"Habilitar URL pública para poder":"Enable public URL to",
		"compartir el archivo con cualquier usuario":"share the file with any user",
		"El archivo estará público y podrá ser accedido por cualquier usuario que tenga esta URL":"The file will be public and acccesible to any user knowing this URL",
		"Seleccionar elemento":"Select element",
		"Quitar elemento seleccionado":"Remove selected element",
		"Utilice la tecla Ctrl para seleccionar varios elementos de la lista":"Use the CTRL key to select several elements from the list",
		"Fecha formato DD-MM-AAAA":"Date format DD-MM-YYYY",
		"Los decimales se deben introducir con un punto, ejemplo: 9999.99<br>Al valor introducido se le aplicará posteriormente la siguiente máscara para mostrarlo: 9.999,99":"Decimals must be entered as dots, for instance: 9999.99<br>The inserted value will be transformed using the following mask to show it: 9.999,99",
		"Campo 1 de la tipología *":"Field 1 of the typology",
		"Este es el primer campo de esta tipología":"This is the first field of this typology",
		"Fecha *":"Date *",
		"¿Esto es una prueba?":"Is this a test?",
		"Número entero":"Integer",
		"Texto plano obligatorio *":"Oblicatory plain text",
		"Lista desplegable":"Dropdown list",
		"Lista selección múltiple *":"Multiple-selection list",
		"Usuario *":"User *",
		"Tarea":"Task",
		"Mensaje":"Message",
		"Decimal con máscara":"Masked decimal number",
		"URL petición":"URL request",

		/*END area_file_new.cfm*/

		/*area_file_modify.cfm*/
		"Modificar Archivo":"Modify File",
		/*END area_file_modify.cfm*/

		/*area_file_replace.cfm*/
		"Reemplazar Archivo":"Replace File",
		/*END area_file_replace.cfm*/

		/*area_file_upload.cfm, area_file_replace_upload.cfm*/
		"Ha ocurrido un error al subir el archivo.":"Failed to upload the file",
		"Archivo reemplazado correctamente.":"File replaced.",
		/*END area_file_upload.cfm, area_file_replace_upload.cfm*/

		/*file_associate.cfm*/
		"Asociar archivo al área":"Associate file to area",
		/*END file_associate.cfm*/

		/*file_view_content.cfm*/
		"Visualizar archivo":"View file",
		"Volver":"Back",
		/*END file_view_content.cfm*/

		/*file.cfm*/
		"Debe bloquear el archivo para poder realizar cualquier modificación.":"You have to lock the file to make any changes.",
		"URL del archivo en DoPlanning":"File URL in DoPlanning",
		"URL de descarga desde DoPlanning":"Download URL from DoPlanning",
		/*END file.cfm*/

		/*search_2_bar.cfm*/
		"Todas":"All",
		"Se muestran las tipologías usadas en al menos un archivo":"The typologies listed are used at least in one file",
		/*END search_2_bar.cfm*/

		/*admin/main.cfm*/
		"Preferencias del usuario":"User preferences",
		"Administración general":"General administration",
		"Administración de áreas":"Areas administration",
		"No cambiar de pestaña al seleccionar área":"Do not change tab when an area is selected",
		"Administradores":"Administrators",
		"Nuevo usuario":"New user",
		"Opciones de la organización":"Organization options",
		"En esta área se pueden crear los siguientes elementos:":"In this area you can create the following elements:",
		"Archivos y archivos de área":"Files and area files",
		"Esta definición se puede modificar posteriormente de forma individual para cada área.":"This definition can be modified later individually for each area",
		"Aplicar selección anterior de opciones a todas las áreas inferiores":"Apply area options to all lower areas",
		"Área de sólo lectura":"Read only area",
		"Esta opción no afecta a los elementos en los que es necesario acceder a la lista de usuarios del área para su creación y edición como: tareas, archivos de área, listas y formularios.":"This option does not affect those elements in which it is necessary to access the user list for their creation and edition, such as: tasks, area files, lists and forms.",
		"Esta opción no afecta a los elementos en los que es necesario acceder a la lista de usuarios del área para su creación y edición como: tareas y archivos de área.":"This option does not affect those elements in which it is necessary to access the user list for their creation and edition, such as: tasks and area files.",
		"Mostrar visible el listado de usuarios del área":"Show list of area users",
		"Esta selección no afecta a los elementos ya existentes en el área":"This selection does not affect those elements already existing in the area",
		"Seleccionar/quitar todos":"Select/unselect all",
		"Cambiar imagen":"Change image",
		"La imagen que se muestra es la heredada de las áreas superiores. Puede asignar una imagen a esta área y pasará a ser la que se muestre en esta y en las áreas inferiores, siempre que las inferiores no tengan una imagen definida.":"The image shown is the one inherited from upper areas. You can assing an image to this area; it will become the one shown in this and the lower areas, provided that lower areas do not already have an assigned image.",
		"Quitar de administrador del área":"Remove as area administrator",
		"Exportar usuarios":"Export users",
		"Buscar usuario":"Search user",
		"Introduzca un texto y haga click en Buscar para listar usuarios de la organización.":"Enter a text and click on Search to list organization users",
		"Logs":"Logs",
		"Usuarios de la organización":"Users of the organization",
		"Asociar estos usuarios a otra área":"Associate these users to other area",
		"Selecciona las áreas a las que quieres añadir el usuario. Ten en cuenta que un usuario asociado a un área tendrá acceso a todas las áreas que haya dentro de ésta, sin necesidad de asociarlo también a esas áreas. Si no asocias el usuario a ningún área no podrá utilizar DoPlanning.":"Select the areas you want to add the user. Keep in mind that a user associated with an area will have access to all areas within it without also associate with those areas. If you do not associate the user to any area he can not use DoPlanning.",
		"Seleccione un área del árbol para ver sus usuarios.":"Select an area from the tree to view its users.",
		"Se muestra en negrita el responsable del área":"Area manager is shown in bold",
		"Usuario interno":"Internal user",
		"Perfil de cabecera":"Header profile",
		"Quitar administrador":"Remove administrator",
		"Quitar Usuario":"Remove User",
		"Eliminar usuario":"Remove User",
		"Ver árbol":"View tree",
		"De administración":"From administration",
		"De áreas":"From áreas",
		"Modificar usuario":"Modify user",
		"Asociar como administrador del área":"Associate as area administrator",
		"Asociar al área":"Associate to area",

		/*END admin/main.cfm*/

		/*admin - new/modify user window form*/
		"Activo":"Active",
		"Si el usuario se marca como activo, se le enviará una":"If user is marked as active, he/she will receive a",
		"con los datos de acceso a la aplicación, incluyendo la contraseña.":"with data to access the application, including the password.",
		"Información":"Information",
		"Los usuarios internos pueden ver todo el árbol de la organización, y no sólo las áreas a las que tienen acceso.":"Internal users can see the whole organization tree, and not only the areas to which they have access.",
		"Los usuarios no activos no podrán acceder a la aplicación ni recibirán notificaciones por email y seguirán siendo visibles en todos los listados de la aplicación.":"Non-active users will not be able to access the application and they will not receive email alerts, though they will ramein visible in all application listings.",
		"Sólo visible desde la administración para todos los usuarios administradores.":"Only visible from administration for all administrators",
		"Guardar cambios":"Save changes",
		"Quitar":"Remove",
		"Puede añadir o quitar administradores accediendo al área correspondiente":"You can add or remove administrators accessing the corresponding area",
		"Usuarios administradores de áreas": "Area administrators",
		"URL:":"URL:",
		"Fecha de creación:":"Creation date:",
		"Fecha de última conexión:":"Last connection date:",
		"Número de conexiones:":"Number of connections:",
		"Usuario creado. Seleccione a continuación las áreas a las que desea asociarlo.":"User created. Now select the areas to add the user.",
		/*END admin - new user window form*/

		"Fecha de última modificación":"Last modification date",


		/*Admin - organization options form*/
		"Opciones de la organización":"Organization options",
		"Título de la aplicación":"Application title",
		"Título que aparece en la parte superior de la aplicación y en la pantalla de login.":"Title that appears in the upper part of the application and in the login screen.",
		"Una vez modificado es necesario salir y volver acceder a la aplicación para que el cambio se vea reflejado.":"Once modified it is necessary to log out and access again to the application to view the change.",
		"Idioma por defecto de la aplicación":"Application's default language",
		"Idioma en el que se muestra por defecto la pantalla de login de la aplicación y el que se define por defecto al crear un nuevo usuario.":"Language shown by default in the login screeen and used by default to create a new user.",
		"Cada usuario tiene definido su propio idioma, que puede cambiarlo en cualquier momento.":"Each user has a defined language, which can be changed by the user at any time.",
		"Notificaciones automáticas por email":"Automatic email notifications",
		"Habilitar a todos los usuarios todas las notificaciones por email de forma obligatoria":"Enable obligatory automatic email notifications for all users",
		"Los usuarios no podrán deshabilitar las notificaciones que envía la aplicación":"Users will not be able to disable notifications sent by the application.",
		"Habilitar notificaciones para recordar tareas":"Enable task expiration notifications",
		"Se enviará una notificación por email el número de días antes especificado a continuación y el mismo día que caduque la tarea.":"An email notification will be sent the number of days before expiration that are specified in the following field and another one in the task's expiration date.",
		"Número de días previos a caducidad para enviar recordatorio de tareas":"Number of days to send the notification before task expiration",
		"Habilitar papelera":"Enable bin",
		"Los archivos se mantendrán en la papelera el número de días especificados a continuación.":"Files will be maintained in the bin for the number of days specified in the following field.",
		"Si se deshabilita la papelera después de habilitarla, los usuarios dejarán de tener acceso a los elementos almacenados en la misma.":"If the bin is disabled after enabling it, users will stop having access to the elements stored in it.",
		"English":"English",
		"Español":"Español",
		"Número de días que se mantendrán los archivos en la papelera":"Number of days to maintain files in the bin",
		/*END Admin - organization options form*/

		/*Admin - image modify form*/
		"Modificar imagen de área":"Modify area image",
		"Si no se asigna una imagen a esta área se mostrará la heredada de las áreas superiores.":"If no image is selected, the area will show the inherited image from upper areas.",
		"El tamaño que se muestra en la previsualización no es el tamaño en el que se mostrará la imagen.":"The previsualization size is not the final size at which the image will be shown.",
		"Debe subir la imagen al tamaño que desea que aparezca en DoPlanning o en la web.":"You must upload the image at the final size you want it to appear in DoPlanning or in the web.",
		"URL a la que se enlazará al hacer clic en la imagen (opcional).":"URL to which the image will be linked on click (optional).",
		"Ningún archivo seleccionado":"No file selected",
		"Eliminar imagen actual":"Delete current image",
		/*END Admin - image modify form*/



		/*user*/
		"Usuario":"User",
		"Nombre":"Name",
		"Apellidos":"Last name",
		"Email":"Email",
		"Número de identificación":"Identification number",
		"DNI":"ID card",
		"Teléfono":"Phone",
		"Teléfono móvil":"Mobile phone",
		"Dirección":"Address",
		"URL LinkedIn":"LinkedIn URL",
		"URL Twitter":"Twitter URL",
		"Activo":"Active",

		"Reunión virtual":"Virtual meeting",
		"URL de acceso a reunión virtual con este usuario:":"URL to virtual meeting with this person:",
		/*END user*/


		/*area_user_select*/
		"Selección de usuario":"User selection",
		"Asignar usuario seleccionado":"Assign selected user",

		"No hay usuarios":"No users",
		"En esta lista solo se incluyen los usuarios con acceso al área actual.":"This list only includes users with access to the current area.",

		"No se ha seleccionado ningún usuario":"There is not a selected user",
		" ya está en la lista":" is already in the list",
		"Error: no se puede asignar el usuario seleccionado":"Error: can not assign the selected user",
		/*END area_user_select*/


		/*preferences_user_data.cfm*/
		"Idioma":"Language:",
		"Imagen del usuario":"User image:",
		"Eliminar":"Delete",
		"Eliminar imagen":"Delete image",
		"Usuario sin imagen":"User without image",
		"Nueva contraseña":"New password:",
		"Confirmar contraseña":"Confirm new password:",
		"Modificación guardada.":"Modification saved.",
		"Mostrar sólo áreas con acceso":"Show only areas with access permission",
		"En el árbol de áreas sólo se mostrarán las áreas con permiso de acceso.":"The areas tree will only show the areas with access permission.",
		"Login Portal del Empleado":"Employee Portal login",
		/*END preferences_user_data.cfm*/

		/*preferences_alerts.cfm*/
		"Preferencias de notificaciones":"Notifications preferences",
		"Enviar un email cuando:":"Send an email when:",
		"Seleccionar/quitar todas":"Select / remove all",
		"Un mensaje ha sido creado o eliminado":"A message has been created or deleted",
		"Un enlace ha sido creado, modificado o eliminado":"A link has been created, modified or deleted",
		"Un elemento de contenido web ha sido creado, modificado o eliminado":"A web content item has been created, modified or deleted",
		"Una noticia ha sido creada, modificada o eliminada":"A news item has been created, modified or deleted",
		"Un evento ha sido creado, modificado o eliminado":"An event has been created, modified or deleted",
		"Una tarea ha sido creada, modificada o eliminada":"A task has been created, modified or deleted",
		"Una consulta ha sido creada, respondida, cerrada o eliminada":"A consultation has been created, modified or deleted",
		"Una publicación ha sido creada, modificada o eliminada":"A publication has been created, modified or deleted",
		"Un archivo ha sido asociado a un área":"A file has been added to an area",
		"Un archivo asociado a un área ha sido reemplazado":"A file has been replaced",
		"Un área nueva ha sido creada":"A new area has been created",
		"Un formulario ha sido creado, modificado o eliminado":"A form has been created, modified or deleted",
		"Una vista de lista ha sido creada, modificada o eliminada":"A list view has been created, modified or deleted",
		"Un registro de lista ha sido creado, modificado o eliminado":"A list record has been created, modified or deleted",
		"Una lista ha sido creada, modificada o eliminada":"A list has been created, modified or deleted",
		"Una vista de formulario ha sido creada, modificada o eliminada":"A form view has been created, modified or deleted",
		"Un registro de formulario ha sido creado, modificado o eliminado":"A form record has been created, modified or deleted",
		"Un archivo de área ha sido bloqueado/desbloqueado":"An area file has been locked/unlocked",
		"Un archivo ha sido eliminado/quitado de un área": "A file has been deleted/removed from an area",
		"Un archivo ha sido reemplazado o ha cambiado su estado (ha sido validado, rechazado, ...)":"A file has been replaced or changed",
		"He sido asociado como usuario a un área":"I have been associated as user to an area",
		"Un usuario ha sido asociado a un área":"A user has been associated to an area",
		"Una tipología ha sido creada, modificada o eliminada":"A typology has been created, modified or deleted",
		"Una imagen ha sido creada, modificada o eliminada":"A typology has been created, modified or deleted",
		"Su organización tiene deshabilitadas las opciones de preferencias de notificaciones. Contacte con el administrador pará más información.":"Your organization disabled the notifications options. Contact the administrator for more information.",
		/*END preferences_alerts*/


		/*area_table_form*/
		"Nueva Lista":"New List",
		"Nuevo Formulario":"New Form",
		"Nueva Típología":"New Tipology",

		"Modificar Lista":"Modify List",
		"Modificar Formulario":"Modify Form",
		"Modificar Típología":"Modify Tipology",

		"Nombre":"Name",
		"Descripción":"Description",
		"Ámbito de publicación":"Publication scope",

		"Permitir copiar la estructura de campos de esta lista":"Allow to copy the field structure from this list",
		"Permitir copiar la estructura de campos de este formulario":"Allow to copy the field structure from this form",
		"Permitir copiar la estructura de campos de esta tipología":"Allow to copy the field structure from this typology",
		"Permitir copiar la estructura de campos de esta tipología de usuario":"Allow to copy the field structure from this user typology",

		"Valida el Formulario para que pueda ser publicado.":"Mark checkbox if you want the Form to be published",
		"Si está definida, el Formulario se publicará en la fecha especificada.":"If defined, the Form will be published in the specified date.",
		"Valida la Lista para que pueda ser publicada.":"Mark checkbox if you want the List to be published",
		"Si está definida, la Lista se publicará en la fecha especificada.":"If defined, the List will be published in the specified date.",
		"Valida el Evento para que pueda ser publicado.":"Mark checkbox if you want the Event to be published",
		"La publicación del elemento deberá ser aprobada en cada una de las áreas en las que se publique.":"Publication of the element must be approved in every area in which it is published.",

		"Indica si la definición de campos de esta lista está disponible para ser usada como plantilla por cualquier usuario de la organización.":"Mark checkbox if field definition of this list is available to be used as a template by any user in the organization",
		"Indica si la definición de campos de este formulario está disponible para ser usada como plantilla por cualquier usuario de la organización.":"Mark checkbox if field definition of this form is available to be used as a template by any user in the organization",
		"Indica si la definición de campos de esta tipología está disponible para ser usada como plantilla por cualquier usuario de la organización.":"Mark checkbox if field definition of this typology is available to be used as a template by any user in the organization",
		"Indica si la definición de campos de esta tipología de usuario está disponible para ser usada como plantilla por cualquier usuario de la organización.":"Mark checkbox if field definition of this user typology is available to be used as a template",

		"Habilitar como tipología global":"Enable as global typology",
		"Se podrá utilizar esta tipología en cualquier área de la organización.":"This typology may be used in any area of the organization",
		"Define dónde se podrán publicar vistas de la Lista":"Set the area type where views of this List can be published",
		"Define dónde se podrán publicar vistas del Formulario":"Set the area type where views of this Form can be published",

		"Añadir campo":"Add field",
		"Copiar de plantilla":"Copy from template",
		"Haga clic en Añadir campo para crear un nuevo campo.":"Click in ADD FIELD to create a new field.",

		"Nuevo campo":"New field",
		"Texto plano 1 línea (máx. 255 caracteres)":"Plain text, 1 line (255 characters max.)",
		"Texto plano varias líneas (máx. 21000 caracteres)":"Plain text, several lines (21000 characters max.)",
		"Texto varias líneas con formato (máx. 21000 caracteres)":"Formatted text, several lines (21000 characters max.)",
		"Texto muy grande con formato":"Very large formatted text",
		"Número decimal":"Decimal number",
		"Fecha (formato DD-MM-AAAA)":"Date (DD-MM-YYYY)",
		"Booleano (Sí/No)":"Boolean (Yes/No)",
		"Lista de opciones con selección simple":"List of options, single selection",
		"Lista de opciones con selección múltiple":"List of options, multiple selection",
		"Lista de opciones con selección simple a partir de área":"List of options, single selection from an area",
		"Lista de opciones con selección múltiple a partir de área":"List of options, multiple selection from an area",
		"Usuario de DoPlanning":"DoPlanning user",
		"Elemento de DoPlanning":"DoPlanning element",
		"No se puede modificar el tipo una vez creado el campo.":"Type cannot be modified once the field is created",

		"Obligatorio":"Obligatory",
		"Indica si el campo deber rellenarse de forma obligatoria":"Mark checkbox if this field must be necessarily filled in",

		"Ordenar por defecto por este campo":"Order by default from this field",

		"Orden descendente":"Descending order",
		"Orden ascendente":"Ascending order",
		"Se mostrarán ordenados los registros en el orden especificado por el primer campo que tenga seleccionada esta opción":"Records will be ordered in the order specified by the first field having this option enabled",

		"Valor por defecto":"Default value",

		"Quitar usuario seleccionado":"Remove selected user",
		"Introduce cada valor de la lista en una línea distinta":"Enter each value of the list in a different line",
		"Valores de la lista":"Values of the list",
		"Área a para generar la lista":"Area to generate the list",
		"Checkbox (se muestran visibles todas las opciones)":"Checkbox (all options are shown)",
		"Mostrar opciones en":"Show options in",
		"Radio (se muestran visibles todas las opciones)":"Radio (all options are shown)",
		"Permite definir como se mostrará el valor numérico introducido.":"Allows to define how the numeric value will be entered",
		"$9,999.99 (Moneda $ con comas en los miles, puntos en los decimales y se muestran dos decimales)":"$9,999.99 ($ currency with commas in thousands, dot in decimals, two decimals shown)",
		"9.999,99 € (Moneda € con puntos en los miles, comas en los decimales y se muestran dos decimales)":"9.999,99 € (€ currency with dots in thousands, comma in decimals, two decimals shown)",
		"9.999,99 (Puntos en los miles, comas en los decimales y se muestran dos decimales)":"9.999,99 (dots in thousands, comma in decimals, two decimals shown)",
		"9999.99 (Sólo puntos en los decimales y se muestran dos decimales)":"9999.99 (dots only in decimals, two decimals shown)",
		"Máscara":"Mask",
		"Sin máscara":"No mask",
		"No se puede modificar el tipo de elemento DoPlanning una vez creado el campo.":"Element type cannot be modified once field is created",
		"Tipo de elemento de DoPlanning":"Type of DoPlanning element",
		"URL":"URL",

		"Selección de Mensaje":"Message selection",
		"Selección de Elemento web":"Web element selection",
		"Selección de Noticia":"News selection",
		"Selección de Imagen":"Image selection",
		"Selección de Archivo":"File selection",
		"Selección de Evento":"Event selection",
		"Selección de Tarea":"Task selection",
		"Selección de Lista":"List selection",
		"Selección de Formulario":"Form selection",
		"Selección de Consulta":"Consultation selection",
		"Selección de Publicación":"Publication selection",


		"Texto a buscar":"Text to search",
		"Nº resultados a mostrar":"No. of results to show",

		"Introduzca el nombre, apellidos o email del usuario y haga click en ""Buscar"".":"Enter the user's name, family name or email and click on ""Search"".",
		"Campo creado":"Field created",
		"Nombre del campo":"Field name",
		"Tipo de campo":"Field type",

		"Lista de la que copiar los campos:":"List from which to copy fields",
		"Copiar campos":"Copy fields",

		"Formulario creado, ahora debe definir los campos.":"Form created. Now you must define the fields.",

		"Desaprobar publicación":"Disapprove publication",
		"Fecha de publicación:":"Publication date",
		"Publicación aprobada:":"Approved publication",
		"Ámbito de publicación:":"Publication scope",
		"Publicación invalidada":"Void publication",
		"Tipo de área":"Area type",
		"Nueva Imagen":"New Image",
		"Ver en web":"Watch in web",
		"Vista previa en web (incluye elementos no publicados)":"Preview in web (includes unpublished elements)",
		"URL relativa en la":"Relative URL in the",
		"El ámbito de publicación seleccionado no es compatible con el área actual":"The publication scope is not compatible with the current area",
		"Formulario modificado.":"Form modified.",
		 "No hay datos introducidos.":"No data introduced.",
		 "No hay campos definidos para rellenar.":"There are no defined fields to fill.",
		 "Formulario del que copiar los campos:":"Form from which to copy the fields",


		/*END area_table_form*/



		/*user_meeting_opentok.cfm*/
		"Reunión virtual":"Virtual meeting",
		"¡Ha iniciado una reunión consigo mismo!":"You have started a meeting with yourself!",
		"Esperando conexión del usuario solicitado...":"Waiting requested user's connection...",
		"El usuario debe acceder a la siguiente dirección para entrar en esta reunión:":"The user must access the following URL to enter this meeting:",

		"Email:":"Email",
		"Teléfono:":"Phone:",
		"Teléfono móvil:":"Mobile phone:",

		"Detener retransmisión":"Stop broadcasting",
		"Iniciar retransmisión":"Start broadcasting",
		"Detener webcam":"Stop webcam",
		"Retransmitir webcam":"Start webcam",
		"Desactivar micrófono":"Mute",
		"Activar micrófono":"Unmute",
		"No está retransmitiendo su webcam, sólo está retransmitiento su audio.":"You are not broadcasting your webcam, audio only.",
		"Para retransmitir su webcam, haga clic en el botón Retransmitir webcam.":"To broadcast your webcam, click the Start webcam button.",
		"El usuario está conectado a la reunión pero no está retransmitiendo su cámara ni su audio.":"The user is connected to the meeting but does not broadcast his camera and audio",
		/*END user_meeting_opentok.cfm*/

		/*bin*/
		"Eliminar definitivamente":"Remove permanently",
		"Restaurar":"Restore",
		"elementos":"elements",
		"Eliminar todo definitivamente":"Remove all permanently",
		"Restaurar todo":"Restore all",
		"Todos los de la organización":"All from the organization",
		"Eliminados por mi":"Removed by me",
		"elemento":"element",
		"Elemento eliminado.":"Element removed.",
		/*END bin*/

		"Error inesperado":"Unexpected error",
		"Respondiendo a:":"Answering to",

		"Añadir editores":"Add editors",
		"Haga clic en Añadir editores parar añadir un nuevo usuario.":"Click on Add editors to add a new editor.",
		"Los usuarios responsables de este área tienen el permiso de editores por defecto.":"Users that are managers of this area have edition rights by default.",

		/*associate users*/
		"Asociar usuarios a otra área":"Associate users to other area",
		"Selecciona el área de destino:":"Select target area",
		"Asociar usuarios al área seleccionada":"Associate users to selected area",
		"Estos usuarios no se muestran visibles en esta área":"These users are not shown as visible in this area",
		"Asociar usuarios seleccionados al área":"Associate selected users to area",
		"Debe seleccionar un área para asociar los usuarios":"You must select an area to associate users",
		"Asociar usuario a área":"Associate user to area",
		"Este usuario ya está asociado a esta área":"This user is already associated to this area",
		"Asociar usuario a área":"Associate user to area",
		"¿Seguro que desea asociar este usuario a esta área?":"Are you sure you want to associate this user to this area?",
		"Se enviará notificación por email al usuario asociado y a los usuarios del área.":"An email notification will be sent to the associated user and to area users.",
		"Asociar usuario":"Associate user",
		"Asociar usuarios a área":"Associate users to area",
		"Comprueba los usuarios seleccionados:":"Check selected users:",
		"Se enviará notificación a los usuarios asociados y a los usuarios del área.":"A notification will be sent to associated users and to area users.",
		"Asociar usuarios":"Associate users",
		"Asociar usuario a áreas":"Associate user to areas",
		"Asociar usuario a áreas seleccionadas":"Associate user to selected areas",
		"Al área seleccionada":"To selected area",
		"A varias áreas":"To several areas",
		"Confirma las áreas seleccionadas:":"Confirm the selected areas",
		"Si se selecciona esta opción se enviará notificación por email al usuario asociado y a los usuarios del área.":"If you select this option, selected user and users of the area will be notified by email.",
		/*END associate users to areas*/

		/*associate area administrator*/
		"Asociar administrador de área":"Associate area administrator",
		"¿Seguro que desea asociar este usuario como":"Are you sure you want to associate this user as",
		"administrador de esta área":"administrator of this area",
		"Asociar administrador":"Associate administrator",
		"Perfil cabecera":"Header profile",

		/*remove users form area*/
		"Quitar usuario del área":"Remove user from area",
		"¿Seguro que desea quitar este usuario de esta área?:":"Are you sure you want to remove this user form this area?",

		/*remove area administrator*/
		"CUIDADO":"WARNING",
		"Quitar administrador de área":"Remove area administrator",
		"¿Seguro que desea quitar este usuario de administrador de esta área?:":"Are you sure you want to remove this user as administrator of this area?:",
		"Ruta del área":"Area route",
		"Este usuario no está asociado como administrador directamente a esta área, ha sido asociado a la siguiente área superior":"This user is not directly associated as administrator to this area, he/she has been associated in the preceding upper area",
		"Este usuario es el administrador general, tiene acceso de administración por defecto a todas las áreas.":"This user is the general administrator, and has administration access by default to all areas.",
		"No se enviará notificación por email de esta acción":"No email notification will be sent from this action",
		"Area superior":"Upper area",
		"Quitar administrador del área superior":"Remove administrator from upper area",
		"Debe quitar al usuario de administrador en el área anterior para que deje de tener acceso en la actual.":"You must remove user as administrator in the upper area so as to remove access from the current area.",

		/*area documetn approval*/
		"Menú principal":"Main menu",
		"Ruta del área:":"Area route:",
		"Abrir árbol con ruta expandida":"Open tree with expanded route",
		"Solicitar aprobación de documento":"Request document approval",
		"Iniciar proceso de aprobación":"Start approval process",
		"Proceso de aprobación:":"Approval process",
		"Nombre del archivo:":"File name:",
		"Usuario revisor:":"Reviewer user:",
		"Usuario aprobador:":"Approver user:",
		"1º Se enviará el archivo al usuario revisor.":"1st The file will be sent to reviewer user.",
		"2º El usuario revisor debe validar el documento.":"2nd The reviewer user must validate the document.",
		"3º Si el usuario revisor valida el documento, se envía el documento al usuario aprobador.":"3rd If the reviewer user validates the document, it is sent to the approver user.",
		"4º El usuario aprobador debe validar el documento.":"4th Tha approver user must validate the document.",
		"Si el documento no es validado por el revisor o el aprobador, se debe iniciar de nuevo el proceso de aprobación con una nueva versión del archivo.":"If the document is not validated by the reviewer or the approver, the process must start again with a new version of the file.",

		/*actions*/
		"Acciones":"Actions",
		"Añadir acción":"Add action",
		"Nombre de la acción":"Name of the action",
		"Tipo de acción":"Type of action",
		"Enviar email":"Send email",
		"Nuevo registro rellenado en Formulario":"New record added in form",
		"Registro eliminado en Formulario":"Record deleted from form",
		"Nueva acción":"New action",
		"No se puede modificar el tipo una vez creada la acción":"Type cannot be modified once the action has been created",
		"Evento que lanza la acción":"Event that triggers the action",
		"Se realizará la acción cuando ocurra este evento":"Action will be performed when the event occurs",
		"Campo del Formulario con la dirección de email":"Field from the Form with the email address",
		"Sólo están disponibles para seleccionar los campos del tipo Email":"Only fields with type Email are available to select",
		"Asunto del email":"Email subject",
		"Contenido del email":"Email content",

		/*logs*/
		"Acción":"Action",
		"Rellene el formulario y haga click en FILTRAR.":"Enter filter parameters and click FILTER",
		"No hay logs.":"There is no log.",
		"Detalles del log":"Log details",
		"Id:":"Id:",
		"Componente:":"Component:",
		"Usuario:":"User:",
		"Fecha:":"Date:",
		"Petición:":"Request:",
		"No se ha seleccionado ningún log":"There is no log selected",

		/*statistics*/
		"Estadísticas":"Statistics",
		"Generales":"General",
		"Estadísticas generales":"General statistics",
		"Estadísticas de descarga archivos":"Files downloads statistics",
		"Total elementos de área":"Area elements total",
		"Elemento":"Item",
		"Descargas":"Downloads",
		"Adjunto de":"Attached of",
		"Accesos a la aplicación":"Access to the application",
		"Login fallidos":"Failed login",

		"Tipologías":"Typologies",
		"Tipología de usuario":"User typology",
		"Nueva tipología de usuario":"New user typology",
		"Si sólo se crea una tipología de usuario, ésta será la que quede seleccionada por defecto para todos los usuarios y la que se asignará de forma automática a los nuevos usuarios que se den de alta en la aplicación.":"If there is only one typology of user defined, it will be shown by default selected for all users and will not be optional.",
		"Las tipologías de archivos se gestionan en las áreas a las que pertenecen por los usuarios con permiso.":"The typologies of files are managed in their areas by the users with permission",
		"Eliminar Tipología":"Delete typology",

		"Categorías":"Categories",
		"Categorías de elementos de área":"Area elements categories",
		"Debe seleccionar al menos una categoría para poder subir el archivo":"You must select at least one category to upload the file",
		"No hay categorías definidas en tu organización":"No defined categories in your organization",

		"La dirección de email introducida ya está asociada a otro usuario de la aplicación":"The email address is already registered",
		"Registro de usuarios deshabilitado.":"User registration disabled.",
		"Datos del usuario":"User data",
		"Registrarse":"Send",
		"Usuario registrado.":"User successfully registered.",
		"Para completar el registro deberá acceder al enlace que recibirá en su cuenta de correo para la validación de la misma.":"To complete the registration you must access the link you will receive in your email account",
		"Usuario verificado correctamente. Puede acceder a la aplicación.":"User verified. You can now access the application.",
		"Verificación de usuario ya realizada previamente.":"User verification already done previously.",

	}

};
</cfscript>
</cfsilent>

<cfset dtExpires = (Now() + 1) />
<cfset strExpires = GetHTTPTimeString( dtExpires ) />

<!--- Set the expires header. --->
<!---<cfheader name="expires" value="#strExpires#"/>--->

<cfcontent type="application/json">
<cfoutput>#SerializeJSON(curLangTextEn)#</cfoutput>
