<!---
Required variables:
source
file_name
file_type
--->
<!---<cfset filename = replace(filename," ","_","ALL")>--->
<cfset filename = replaceList(file_name," ,á,é,í,ó,ú,ñ,Á,É,Í,Ó,Ú,Ñ", "_,a,e,i,o,u,n,A,E,I,O,U,N")><!---Necesita esto para que no falle en IE si el nombre tiene acentos--->
	
<cfset filetype = fileGetMimeType(filename,false)>

<cfset fileInfo = getFileInfo(source)>
<!---
Esto no funciona en Railo con Tomcat
<cfset mimeType = getPageContext().getServletContext().getMimeType(source)>--->

<!---
Esto quitado porque por ahora no se puede usar gzip para esta aplicación
<cfif CGI.HTTP_ACCEPT_ENCODING CONTAINS "gzip"> 
	<cfheader name="Content-Encoding" value="gzip">
</cfif>--->

<!---<cfheader name="Expires" value="#GetHttpTimeString(DateAdd('m', 1, Now()))#">--->

<!---Para poder cargar un swf desde otra página o swf hay que quitar esto--->
<cfheader name="Content-Disposition" value="attachment; filename=""#filename#""" charset="UTF-8">

<!---<cfheader name="Accept-Ranges" value="bytes">--->
<cfheader name="Content-Length" value="#fileInfo.size#">

<cfcontent file="#source#" deletefile="no" type="#filetype#" /><!---if the file attribute is specified, ColdFusion attempts to get the content type from the file, but it fail with many extensions (like .pdf)--->