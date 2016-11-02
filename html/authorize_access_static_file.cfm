<!--- Check access to static files from HTML generated file related to area file --->
<cfif isDefined("URL.file") AND URL.abb EQ SESSION.client_abb>

  <cfset fileName = GetFileFromPath(URL.file)>

  <cfif len(fileName) GT 0>

    <cfif isNumeric(listFirst(fileName, "."))><!--- .html files --->
      <cfset fileId = listFirst(fileName, ".")>
    <cfelse>
      <cfset fileId = listFirst(fileName,"_")><!--- .png files --->
    </cfif>

    <cfif len(fileId) GT 0 AND isNumeric(fileId)>

      <cfinvoke component="#APPLICATION.componentsPath#/FileManager" method="getFile" returnvariable="fileQuery">
      	<cfinvokeargument name="get_file_id" value="#fileId#">

      	<cfinvokeargument name="return_type" value="query">
      </cfinvoke>

      <cfset filePath = "#APPLICATION.path#/#SESSION.client_id#/temp/#URL.file#">

      <cfset fileType = fileGetMimeType(filePath,false)>

      <cfcontent file="#filePath#" deletefile="no" type="#fileType#" />

    </cfif>

  </cfif>

</cfif>
