<!---Copyright Era7 Information Technologies 2007-2013

	Date of file creation: 18-11-2008
	File created by: alucena
	ColdFusion version required: 8
	Last file change by: alucena
	Date of last file change: 09-04-2013
	
	29-01-2013 alucena: modificado createClient para versión 2.0
	15-03-2013 alucena: añadidas tablas consultations
	18-03-2013 alucena: modificado createClientFolders
	09-04-2013 alucena: añadidas modificaciones de tablas
	
--->
<cfcomponent output="false">

	<cfset component = "ClientManager">
	
	<!--- ----------------------- XML CLIENT -------------------------------- --->
	
	<cffunction name="xmlClient" returntype="string" output="false" access="public">		
		<cfargument name="objectClient" type="struct" required="yes">
		
		<cfset var method = "xmlClient"> 
		
		<cftry>
		
			<cfprocessingdirective suppresswhitespace="true">
			<cfsavecontent variable="xmlResult">
				<cfoutput>
					<client id="#objectClient.id#"
						 administrator_id="#objectClient.administrator_id#"
						 root_area_id="#objectClient.root_area_id#"
						 number_of_users="#objectClient.number_of_users#"
						<cfif len(objectClient.space) GT 0>
						 space="#objectClient.space#"
						</cfif>
						<cfif len(objectClient.abbreviation) GT 0>
						 abbreviation="#objectClient.abbreviation#"
						</cfif>
						<cfif len(objectClient.creation_date) GT 0>
						 creation_date="#objectClient.creation_date#"
						</cfif>
						<cfif len(objectClient.number_of_sms_used) GT 0>
						 number_of_sms_used="#objectClient.number_of_sms_used#"
						</cfif>
						<cfif len(objectClient.number_of_sms_paid) GT 0>
						 number_of_sms_paid="#objectClient.number_of_sms_paid#"
						</cfif>>
						<name><![CDATA[#objectClient.name#]]></name>
					</client>
				</cfoutput>
			</cfsavecontent>
			</cfprocessingdirective>
			
			<cfreturn xmlResult>
		
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
				<cfreturn null>
			</cfcatch>
		</cftry>
		
	</cffunction>
	
	
	<!--- ----------------------- CLIENT OBJECT -------------------------------- --->
	
	<cffunction name="objectClient" returntype="any" output="false" access="public">	
		
		<cfargument name="xml" type="string" required="no">
		
		<cfargument name="id" type="string" required="no" default="">
		<cfargument name="name" type="string" required="no" default="">		
		<cfargument name="administrator_id" type="string" required="no" default="">		
		<cfargument name="root_area_id" type="string" required="no" default="">
		<cfargument name="number_of_users" type="string" required="no" default="">
		<cfargument name="space" type="string" required="no" default="">
		<cfargument name="abbreviation" type="string" required="no" default="">
		<cfargument name="creation_date" type="string" required="no" default="">
		<cfargument name="number_of_sms_used" type="string" required="no" default="">
		<cfargument name="number_of_sms_paid" type="string" required="no" default="">		
		
		<cfargument name="return_type" type="string" required="no">
		
		<cfset var method = "objectClient">
		
		<cftry>
			
			<cfif isDefined("arguments.xml")>
			
				<cfxml variable="xmlClient">
				<cfoutput>
				#arguments.xml#
				</cfoutput>
				</cfxml>
				
				<cfif isDefined("xmlClient.client.XmlAttributes.id")>
					<cfset id=xmlClient.client.XmlAttributes.id>
				</cfif>		
					
				<cfif isDefined("xmlClient.client.name")>
					<cfset name=xmlClient.client.name.xmlText>
				</cfif>
				
				<cfif isDefined("xmlClient.client.XmlAttributes.administrator_id")>
					<cfset administrator_id=xmlClient.client.XmlAttributes.administrator_id>
				</cfif>
				
				<cfif isDefined("xmlClient.client.XmlAttributes.root_area_id")>
					<cfset root_area_id=xmlClient.client.XmlAttributes.root_area_id>
				</cfif>
				
				<cfif isDefined("xmlClient.client.XmlAttributes.number_of_users")>
					<cfset number_of_users=xmlClient.client.XmlAttributes.number_of_users>
				</cfif>
				
				<cfif isDefined("xmlClient.client.XmlAttributes.space")>
					<cfset space=xmlClient.client.XmlAttributes.space>
				</cfif>
				
				<cfif isDefined("xmlClient.client.XmlAttributes.abbreviation")>
					<cfset abbreviation=xmlClient.client.XmlAttributes.abbreviation>
				</cfif>
				
				<cfif isDefined("xmlClient.client.XmlAttributes.creation_date")>
					<cfset creation_date=xmlClient.client.XmlAttributes.creation_date>
				</cfif>
				
				<cfif isDefined("xmlClient.client.XmlAttributes.number_of_sms_used")>
					<cfset number_of_sms_used=xmlClient.client.XmlAttributes.number_of_sms_used>
				</cfif>
				
				<cfif isDefined("xmlClient.client.XmlAttributes.number_of_sms_paid")>
					<cfset number_of_sms_paid=xmlClient.client.XmlAttributes.number_of_sms_paid>
				</cfif>
			
			<cfelseif NOT isDefined("arguments.id")>
				<cfreturn null>
			</cfif>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringDate">
				<cfinvokeargument name="timestamp_date" value="#creation_date#">
			</cfinvoke>
			<cfset creation_date = stringDate>
					
			<cfset object = {
				id="#id#",
				name="#name#",
				administrator_id="#administrator_id#",
				root_area_id="#root_area_id#",
				number_of_users="#number_of_users#",
				space="#space#",
				abbreviation="#abbreviation#",
				creation_date="#creation_date#",
				number_of_sms_used="#number_of_sms_used#",
				number_of_sms_paid="#number_of_sms_paid#"
				}>
				
			
			<cfif isDefined("arguments.return_type") AND arguments.return_type EQ "xml">
				
				<cfinvoke component="ClientManager" method="xmlClient" returnvariable="xmlResult">
					<cfinvokeargument name="objectClient" value="#object#">
				</cfinvoke>
				<cfreturn xmlResult>

			<cfelse>
			
				<cfreturn object>
				
			</cfif>
		
			<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
				<cfreturn null>
			</cfcatch>
		</cftry>
		
	</cffunction>
	
	
	<!--- ------------------------------ createClient ----------------------------- --->
	
	<cffunction name="createClient" returntype="string" access="public">
		<cfargument name="request" type="string" required="yes">
		<!---<cfargument name="objectClient" type="string" required="yes">--->
		
		<cfset var method = "createClient">
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
		<cftry>
			
			<cfinclude template="includes/functionStart.cfm">
			
			<!---<cfinclude template="includes/checkApplicationAdminAccess.cfm">--->
			
			
			<cfinvoke component="ClientManager" method="objectClient" returnvariable="objectClient">
				<cfinvokeargument name="xml" value="#xmlRequest.request.parameters.client#">
				
				<cfinvokeargument name="return_type" value="object">
			</cfinvoke>
			
			<cfinvoke component="DateManager" method="getCurrentDateTime" returnvariable="current_date">
			</cfinvoke>
			
			<cfinvoke component="DateManager" method="timestampToString" returnvariable="stringCurrentDate">
				<cfinvokeargument name="timestamp_date" value="#current_date#">
			</cfinvoke>
			
			<!---<cfset client_id = "NULL">
			<cfset name = "NULL">
			<cfset administrator_id = 1>
			<cfset number_of_users = 100>
			<cfset space = 0>
			<cfset abbreviation = "NULL">
			<cfset creation_date = current_date>
			<cfset number_of_sms_used = 0>
			<cfset number_of_sms_paid = 100>--->
			
			<cfset objectClient.administrator_id = 1>
			<cfset objectClient.root_area_id = 1><!--- root area id which will always be 1 --->
			<cfset objectClient.number_of_users = 1>
			<cfset objectClient.space = 0>
			<cfset objectClient.number_of_sms_used = 0>
			<cfset objectClient.creation_date = stringCurrentDate>
			
			<cfset new_client_abb = objectClient.abbreviation>
			
			<!---<cfoutput>
			<cfdump var="#objectClient#">
			<cfdump var="#xmlRequest.request.parameters.user#">
			</cfoutput>--->
			
			<cfquery name="insertClientQuery" datasource="#APPLICATION.dsn#" >							
				INSERT INTO `APP_clients` (`id`, `name`, `administrator_id`, `root_area_id`, `number_of_users`, `space`, `abbreviation`, `creation_date`, `number_of_sms_used`, `number_of_sms_paid`, `email_support`) VALUES 
					(<cfqueryPARAM value="#objectClient.id#" CFSQLType="CF_SQL_varchar">,
					<cfqueryPARAM value="#objectClient.name#" CFSQLType="CF_SQL_varchar">,					
					<cfqueryPARAM value="#objectClient.administrator_id#" CFSQLType = "CF_SQL_varchar">,
					<cfqueryparam value="#objectClient.root_area_id#" cfsqltype="cf_sql_integer">, 
					<cfqueryPARAM value="#objectClient.number_of_users#" CFSQLType = "CF_SQL_integer">,
					<cfqueryPARAM value="#objectClient.space#" CFSQLType = "CF_SQL_integer">,						
					<cfqueryPARAM value="#objectClient.abbreviation#" CFSQLType = "CF_SQL_varchar">,
					<cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">,
					<cfqueryPARAM value="#objectClient.number_of_sms_used#" cfsqltype="cf_sql_integer">,
					<cfqueryPARAM value="#objectClient.number_of_sms_paid#" cfsqltype="cf_sql_integer">,
					<cfqueryPARAM value="no-reply@doplanning.net" cfsqltype="cf_sql_varchar">
					);			
			</cfquery>
			
			<cfset client_datasource = APPLICATION.identifier&"_"&objectClient.abbreviation>
			
			
			<!--- Now we have to create all the tables --->
			
			<cftransaction>
			
				<cfquery name="createTableAlertMessages" datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_alert_messages` (
					  `id` int(11) NOT NULL auto_increment,
					  `content` text collate utf8_unicode_ci NOT NULL,
					  `creation_date` timestamp NOT NULL default CURRENT_TIMESTAMP,
					  `expiration_date` datetime NOT NULL,
					  PRIMARY KEY  (`id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
				
				<cfquery name="insertAlertMessage" datasource="#client_datasource#">
					INSERT INTO `#new_client_abb#_alert_messages` (`id`, `content`, `expiration_date`) VALUES
	(1, '¡Bienvenido a #APPLICATION.title#!', ADDDATE(<cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">,3));
				</cfquery>
					
				
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_areas` (
					  `id` int(11) NOT NULL auto_increment,
					  `name` text collate utf8_unicode_ci,
					  `parent_id` int(11) default NULL,
					  `user_in_charge` int(11) NOT NULL,
					  `creation_date` datetime NOT NULL,
					  `description` text collate utf8_unicode_ci,
					  `image_id` int(11) default NULL,
					  `link` varchar(255) collate utf8_unicode_ci default NULL,
					  `space_used` int(10) unsigned NOT NULL default '0',
					  `type` varchar(10) collate utf8_unicode_ci default NULL,
					  PRIMARY KEY  (`id`),
					  KEY `image_id` (`image_id`),
					  KEY `user_in_charge` (`user_in_charge`),
					  KEY `parent_id` (`parent_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
				
				<!---ROOT AREA--->
				<cfquery datasource="#client_datasource#">	
					INSERT INTO `#new_client_abb#_areas` (`id`, `name`, `parent_id`, `user_in_charge`, `creation_date`, `description`, `image_id`, `link`, `space_used`) VALUES
					(1, '#objectClient.name#', NULL, 1, <cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">, NULL, NULL, NULL, 0);
				</cfquery>
				
				<!---DP AREA--->
				<cfquery datasource="#client_datasource#">	
					INSERT INTO `#new_client_abb#_areas` (`id`, `name`, `parent_id`, `user_in_charge`, `creation_date`, `description`, `image_id`, `link`, `space_used`) VALUES
					(2, '#objectClient.name#', 1, 1, <cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">, NULL, NULL, NULL, 0);
				</cfquery>
					
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_areas_administrators` (
					  `user_id` int(11) NOT NULL,
					  `area_id` int(11) NOT NULL,
					  PRIMARY KEY  (`user_id`,`area_id`),
					  KEY `area_id` (`area_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
					
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_areas_files` (
					  `area_id` int(11) NOT NULL,
					  `file_id` int(11) NOT NULL,
					  `association_date` datetime NOT NULL,
					  PRIMARY KEY  (`area_id`,`file_id`),
					  KEY `file_id` (`file_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
					
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_areas_images` (
					  `id` int(11) NOT NULL auto_increment,
					  `physical_name` varchar(200) collate utf8_unicode_ci default NULL,
					  `file_size` int(11) default NULL,
					  `file_type` varchar(10) collate utf8_unicode_ci default NULL,
					  `uploading_date` datetime NOT NULL,
					  `replacement_date` datetime default NULL,
					  `file_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `image_background_color` varchar(10) collate utf8_unicode_ci default NULL,
					  `status` varchar(10) collate utf8_unicode_ci NOT NULL,
					  `status_replacement` varchar(100) collate utf8_unicode_ci default NULL,
					  PRIMARY KEY  (`id`),
					  UNIQUE KEY `image_src` (`physical_name`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;	
				</cfquery>			
				
				<cfquery datasource="#client_datasource#">	
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_areas_users` (
					  `area_id` int(11) NOT NULL,
					  `user_id` int(11) NOT NULL,
					  PRIMARY KEY  (`area_id`,`user_id`),
					  KEY `user_id` (`user_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>	
					
				<!---<cfquery datasource="#client_datasource#">
					INSERT INTO `#new_client_abb#_areas_users` (`area_id`, `user_id`) VALUES
					(1, 1);
				</cfquery>--->	
					
				<cfquery datasource="#client_datasource#">	
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_contacts` (
					  `user_id` int(11) NOT NULL,
					  `id` int(11) NOT NULL auto_increment,
					  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
					  `telephone` varchar(255) collate utf8_unicode_ci default NULL,
					  `address` varchar(255) collate utf8_unicode_ci default NULL,
					  `email` varchar(255) collate utf8_unicode_ci default NULL,
					  `family_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `mobile_phone` varchar(255) collate utf8_unicode_ci default NULL,
					  `organization` varchar(255) collate utf8_unicode_ci default NULL,
					  `telephone_ccode` int(11) default NULL,
					  `mobile_phone_ccode` int(11) default NULL,
					  PRIMARY KEY  (`id`),
					  KEY `user_id` (`user_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
				
				<cfquery datasource="#client_datasource#">
					 CREATE TABLE IF NOT EXISTS `#new_client_abb#_errors_log` (
					  `id` int(11) NOT NULL auto_increment,
					  `code` int(11) NOT NULL,
					  `method_id` int(11) default NULL,
					  `time` timestamp NOT NULL default CURRENT_TIMESTAMP,
					  `user_id` int(11) default NULL,
					  `content` text collate utf8_unicode_ci,
					  `method` varchar(255) collate utf8_unicode_ci default NULL,
					  `component` varchar(255) collate utf8_unicode_ci default NULL,
					  PRIMARY KEY  (`id`),
					  KEY `user_id` (`user_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>	
				
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_files` (
					  `id` int(11) NOT NULL auto_increment,
					  `physical_name` text collate utf8_unicode_ci,
					  `name` text collate utf8_unicode_ci,
					  `user_in_charge` int(11) NOT NULL,
					  `file_size` int(11) default NULL,
					  `file_type` varchar(255) collate utf8_unicode_ci default NULL,
					  `uploading_date` datetime NOT NULL,
					  `description` text collate utf8_unicode_ci,
					  `replacement_date` datetime default NULL,
					  `file_name` text collate utf8_unicode_ci,
					  `status` varchar(255) collate utf8_unicode_ci default NULL,
					  `status_replacement` varchar(100) collate utf8_unicode_ci default NULL,
					  PRIMARY KEY  (`id`),
					  KEY `user_in_charge` (`user_in_charge`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
					
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_folders` (
					  `id` int(11) NOT NULL auto_increment,
					  `name` text collate utf8_unicode_ci NOT NULL,
					  `creation_date` datetime NOT NULL,
					  `user_in_charge` int(11) NOT NULL,
					  `parent_id` int(11) default NULL,
					  `description` text collate utf8_unicode_ci,
					  PRIMARY KEY  (`id`),
					  KEY `parent_id` (`parent_id`),
					  KEY `user_in_charge` (`user_in_charge`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>	
					
				<!---<cfquery datasource="#client_datasource#">
					INSERT INTO `#new_client_abb#_folders` (`id`, `name`, `creation_date`, `user_in_charge`, `parent_id`, `description`) VALUES
					(1, 'Mis documentos', <cfqueryparam value="#current_date#" cfsqltype="cf_sql_timestamp">, 1, NULL, NULL);
				</cfquery>--->
					
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_folders_files` (
					  `folder_id` int(11) NOT NULL,
					  `file_id` int(11) NOT NULL,
					  PRIMARY KEY  (`folder_id`,`file_id`),
					  KEY `file_id` (`file_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
					
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_logs` (
					  `id` bigint(20) NOT NULL auto_increment,
					  `user_id` int(11) default NULL,
					  `time` timestamp NOT NULL default CURRENT_TIMESTAMP,
					  `method_id` int(11) default NULL,
					  `request_content` text collate utf8_unicode_ci,
					  `method` varchar(255) collate utf8_unicode_ci default NULL,
					  `component` varchar(255) collate utf8_unicode_ci default NULL,
					  PRIMARY KEY  (`id`),
					  KEY `user_id` (`user_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
				
				
				
				
				<cfquery datasource="#client_datasource#">
					CREATE TABLE `#new_client_abb#_display_types` (
					  `display_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					  `enabled` tinyint(1) NOT NULL DEFAULT '1',
					  `display_type_title_es` varchar(100) NOT NULL,
					  `display_type_title_en` varchar(100) NOT NULL,
					  PRIMARY KEY (`display_type_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8;
				</cfquery>
				
				<cfquery datasource="#client_datasource#">
					INSERT INTO `#new_client_abb#_display_types` (`display_type_id`,`enabled`,`display_type_title_es`,`display_type_title_en`) VALUES
					 (1,1,'Por defecto','By default'),
					 (2,1,'Listado de elementos','Elements list'),
					 (3,1,'Imagen a la derecha','Image to right'),
					 (4,1,'Imagen a la izquierda','Image to left'),
					 (5,1,'Figura con pie','Image with footnote');
				</cfquery>
				
				
				<cfquery datasource="#client_datasource#">
					CREATE TABLE `#new_client_abb#_iframes_display_types` (
					  `iframe_display_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					  `width` int(10) unsigned NOT NULL,
					  `width_unit` varchar(10) NOT NULL,
					  `height` int(10) unsigned NOT NULL,
					  `height_unit` varchar(10) NOT NULL,
					  `enabled` tinyint(1) NOT NULL DEFAULT '1',
					  `iframe_display_type_title_es` varchar(100) NOT NULL,
					  `iframe_display_type_title_en` varchar(100) NOT NULL,
					  PRIMARY KEY (`iframe_display_type_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8;		
				</cfquery>
				
				<cfquery datasource="#client_datasource#">
					INSERT INTO `#new_client_abb#_iframes_display_types` (`iframe_display_type_id`,`width`,`width_unit`,`height`,`height_unit`,`enabled`,`iframe_display_type_title_es`,`iframe_display_type_title_en`) VALUES
		 (1,100,'%',400,'px',1,'Ancho de página x 400','100% x 400px'),
		 (2,560,'px',315,'px',1,'560 x 315','560 x 315');
				</cfquery>
				
				
				
					
				<cfquery datasource="#client_datasource#">	
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_messages` (
					  `id` int(11) NOT NULL auto_increment,
					  `title` text collate utf8_unicode_ci,
					  `description` text collate utf8_unicode_ci,
					  `parent_id` int(11) NOT NULL,
					  `parent_kind` varchar(255) collate utf8_unicode_ci default NULL,
					  `user_in_charge` int(11) NOT NULL,
					  `attached_file_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `attached_file_id` int(11) default NULL,
					  `creation_date` datetime NOT NULL,
					  `message_read` tinyint(1) default NULL,
					  `status` varchar(255) collate utf8_unicode_ci NOT NULL,
					  `area_id` int(11) NOT NULL,
					  `link` varchar(1000) collate utf8_unicode_ci NOT NULL,
					  PRIMARY KEY  (`id`),
					  KEY `user_in_charge` (`user_in_charge`),
					  KEY `attached_file_id` (`attached_file_id`),
					  KEY `area_id` (`area_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
				
					
				<!---ESTA TABLA EN DP 2 NO ES NECESARIA
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_sms` (
					  `id` int(11) NOT NULL auto_increment,
					  `text` varchar(255) collate utf8_unicode_ci NOT NULL,
					  `user_id` int(11) NOT NULL,
					  `recipients` text collate utf8_unicode_ci,
					  `response` varchar(255) collate utf8_unicode_ci default NULL,
					  `msgid` varchar(255) collate utf8_unicode_ci default NULL,
					  `date` datetime NOT NULL,
					  PRIMARY KEY  (`id`),
					  KEY `user_id` (`user_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>--->	
					
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_users` (
					  `id` int(11) NOT NULL auto_increment,
					  `name` varchar(255) collate utf8_unicode_ci default NULL,
					  `telephone` varchar(255) collate utf8_unicode_ci default NULL,
					  `address` varchar(255) collate utf8_unicode_ci default NULL,
					  `password` varchar(255) collate utf8_unicode_ci default NULL,
					  `space_used` BIGINT UNSIGNED DEFAULT 0,
					  `number_of_connections` int(11) default '0',
					  `connected` tinyint(1) default '0',
					  `session_id` varchar(255) collate utf8_unicode_ci default NULL,
					  `creation_date` datetime NOT NULL,
					  `internal_user` tinyint(1) default NULL,
					  `root_folder_id` int(11) default NULL,
					  `family_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `sms_allowed` tinyint(1) default '0',
					  `mobile_phone` varchar(255) collate utf8_unicode_ci default NULL,
					  `last_connection` datetime default NULL,
					  `space_downloaded` BIGINT UNSIGNED DEFAULT 0,
					  `validated` tinyint(1) default '0',
					  `email` varchar(255) collate utf8_unicode_ci NOT NULL,
					  <!---`image_id` int(11) default NULL,--->
					  `telephone_ccode` int(11) default NULL,
					  `mobile_phone_ccode` int(11) default NULL,
					  `dni` varchar(45) collate utf8_unicode_ci default NULL,
					  `language` varchar(10) collate utf8_unicode_ci NOT NULL default 'es',
					  `notify_new_message` tinyint(1) NOT NULL default '1',
					  `notify_new_file` tinyint(1) NOT NULL default '1',
					  `notify_replace_file` tinyint(1) NOT NULL default '1',
					  `notify_new_area` tinyint(1) NOT NULL default '1',
					  `notify_new_event` tinyint(1) NOT NULL default '1',
					  `notify_new_task` tinyint(1) NOT NULL default '1',
					  `notify_new_entry` tinyint(1) NOT NULL default '1',
					  `notify_new_news` tinyint(1) NOT NULL default '1',
					  `notify_new_consultation` tinyint(1) NOT NULL default '1',
					  `image_file` varchar(255) collate utf8_unicode_ci default NULL,
					  `image_type` varchar(45) collate utf8_unicode_ci default NULL,
					  PRIMARY KEY  (`id`),
					  UNIQUE KEY `email` (`email`)
					  <!---, KEY `image_id` (`image_id`)--->
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
				
				
				<cfquery datasource="#client_datasource#">	
					CREATE TABLE  `#new_client_abb#_tasks` (
					  `id` int(11) NOT NULL AUTO_INCREMENT,
					  `title` text COLLATE utf8_unicode_ci,
					  `description` text COLLATE utf8_unicode_ci,
					  `parent_id` int(11) NOT NULL,
					  `parent_kind` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
					  `user_in_charge` int(11) NOT NULL,
					  `attached_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
					  `attached_file_id` int(11) DEFAULT NULL,
					  `creation_date` datetime NOT NULL,
					  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
					  `area_id` int(11) NOT NULL,
					  `attached_image_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
					  `attached_image_id` int(11) DEFAULT NULL,
					  `link` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
					  `start_date` date NOT NULL,
					  `end_date` date NOT NULL,
					  `recipient_user` int(11) NOT NULL,
					  `done` tinyint(1) NOT NULL,
					  `estimated_value` decimal(12,2) NOT NULL,
					  `real_value` decimal(12,2) NOT NULL,
					  `last_update_date` datetime NOT NULL,
					  PRIMARY KEY (`id`),
					  KEY `user_in_charge` (`user_in_charge`),
					  KEY `attached_file_id` (`attached_file_id`),
					  KEY `area_id` (`area_id`),
					  KEY `FK_#new_client_abb#_tasks_4` (`attached_image_id`),
					  KEY `FK_#new_client_abb#_tasks_5` (`recipient_user`),
					  CONSTRAINT `FK_#new_client_abb#_tasks_4` FOREIGN KEY (`attached_image_id`) REFERENCES `#new_client_abb#_files` (`id`),
					  CONSTRAINT `FK_#new_client_abb#_tasks_5` FOREIGN KEY (`recipient_user`) REFERENCES `#new_client_abb#_users` (`id`),
					  CONSTRAINT `#new_client_abb#_tasks_ibfk_1` FOREIGN KEY (`user_in_charge`) REFERENCES `#new_client_abb#_users` (`id`),
					  CONSTRAINT `#new_client_abb#_tasks_ibfk_2` FOREIGN KEY (`attached_file_id`) REFERENCES `#new_client_abb#_files` (`id`),
					  CONSTRAINT `#new_client_abb#_tasks_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `#new_client_abb#_areas` (`id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>			
				
				
				<cfquery datasource="#client_datasource#">	
					CREATE TABLE  `#new_client_abb#_events` (
					  `id` int(11) NOT NULL auto_increment,
					  `title` text collate utf8_unicode_ci,
					  `description` text collate utf8_unicode_ci,
					  `parent_id` int(11) NOT NULL,
					  `parent_kind` varchar(10) collate utf8_unicode_ci default NULL,
					  `user_in_charge` int(11) NOT NULL,
					  `attached_file_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `attached_file_id` int(11) default NULL,
					  `creation_date` datetime NOT NULL,
					  `status` varchar(255) collate utf8_unicode_ci NOT NULL,
					  `area_id` int(11) NOT NULL,
					  `attached_image_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `attached_image_id` int(11) default NULL,
					  `link` varchar(1000) collate utf8_unicode_ci NOT NULL,
					  `start_date` date NOT NULL,
					  `end_date` date NOT NULL,
					  `place` varchar(255) collate utf8_unicode_ci NOT NULL,
					  `last_update_date` datetime default NULL,
					  `start_time` time NOT NULL,
					  `end_time` time NOT NULL,
					  `iframe_url` varchar(1000) collate utf8_unicode_ci NOT NULL,
					  `iframe_display_type_id` int(10) unsigned NOT NULL default '1',
					  PRIMARY KEY  (`id`),
					  KEY `user_in_charge` (`user_in_charge`),
					  KEY `attached_file_id` (`attached_file_id`),
					  KEY `area_id` (`area_id`),
					  KEY `FK_#new_client_abb#_events_4` (`attached_image_id`),
					  KEY `FK_#new_client_abb#_events_5` (`iframe_display_type_id`),
					  CONSTRAINT `FK_#new_client_abb#_events_5` FOREIGN KEY (`iframe_display_type_id`) REFERENCES `#new_client_abb#_iframes_display_types` (`iframe_display_type_id`),
					  CONSTRAINT `#new_client_abb#_events_ibfk_1` FOREIGN KEY (`user_in_charge`) REFERENCES `#new_client_abb#_users` (`id`),
					  CONSTRAINT `#new_client_abb#_events_ibfk_2` FOREIGN KEY (`attached_file_id`) REFERENCES `#new_client_abb#_files` (`id`),
					  CONSTRAINT `#new_client_abb#_events_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `#new_client_abb#_areas` (`id`),
					  CONSTRAINT `FK_#new_client_abb#_events_4` FOREIGN KEY (`attached_image_id`) REFERENCES `#new_client_abb#_files` (`id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
				
				
				<cfquery datasource="#client_datasource#">
					CREATE TABLE  `#new_client_abb#_news` (
					  `id` int(11) NOT NULL auto_increment,
					  `title` text collate utf8_unicode_ci,
					  `description` text collate utf8_unicode_ci,
					  `parent_id` int(11) NOT NULL,
					  `parent_kind` varchar(10) collate utf8_unicode_ci default NULL,
					  `user_in_charge` int(11) NOT NULL,
					  `attached_file_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `attached_file_id` int(11) default NULL,
					  `creation_date` datetime NOT NULL,
					  `status` varchar(255) collate utf8_unicode_ci NOT NULL,
					  `area_id` int(11) NOT NULL,
					  `attached_image_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `attached_image_id` int(11) default NULL,
					  `link` varchar(1000) collate utf8_unicode_ci NOT NULL,
					  `last_update_date` datetime default NULL,
					  `iframe_url` varchar(1000) collate utf8_unicode_ci NOT NULL,
					  `iframe_display_type_id` int(10) unsigned NOT NULL default '1',
					  `position` int(10) unsigned NOT NULL,
					  PRIMARY KEY  (`id`),
					  KEY `user_in_charge` (`user_in_charge`),
					  KEY `attached_file_id` (`attached_file_id`),
					  KEY `area_id` (`area_id`),
					  KEY `FK_#new_client_abb#_news_4` (`attached_image_id`),
					  KEY `FK_#new_client_abb#_news_5` (`iframe_display_type_id`),
					  CONSTRAINT `FK_#new_client_abb#_news_5` FOREIGN KEY (`iframe_display_type_id`) REFERENCES `#new_client_abb#_iframes_display_types` (`iframe_display_type_id`),
					  CONSTRAINT `#new_client_abb#_news_ibfk_1` FOREIGN KEY (`user_in_charge`) REFERENCES `#new_client_abb#_users` (`id`),
					  CONSTRAINT `#new_client_abb#_news_ibfk_2` FOREIGN KEY (`attached_file_id`) REFERENCES `#new_client_abb#_files` (`id`),
					  CONSTRAINT `#new_client_abb#_news_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `#new_client_abb#_areas` (`id`),
					  CONSTRAINT `FK_#new_client_abb#_news_4` FOREIGN KEY (`attached_image_id`) REFERENCES `#new_client_abb#_files` (`id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>	
				
				
				
				<cfquery datasource="#client_datasource#">
					CREATE TABLE  `#new_client_abb#_entries` (
					  `id` int(11) NOT NULL auto_increment,
					  `title` text collate utf8_unicode_ci,
					  `description` text collate utf8_unicode_ci,
					  `parent_id` int(11) NOT NULL,
					  `parent_kind` varchar(10) collate utf8_unicode_ci default NULL,
					  `user_in_charge` int(11) NOT NULL,
					  `attached_file_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `attached_file_id` int(11) default NULL,
					  `creation_date` datetime NOT NULL,
					  `status` varchar(255) collate utf8_unicode_ci NOT NULL,
					  `area_id` int(11) NOT NULL,
					  `attached_image_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `attached_image_id` int(11) default NULL,
					  `link` varchar(1000) collate utf8_unicode_ci NOT NULL,
					  `last_update_date` datetime default NULL,
					  `position` int(10) unsigned NOT NULL,
					  `display_type_id` int(10) unsigned NOT NULL default '1',
					  `iframe_url` varchar(1000) collate utf8_unicode_ci NOT NULL,
					  `iframe_display_type_id` int(10) unsigned NOT NULL default '1',
					  PRIMARY KEY  (`id`),
					  KEY `user_in_charge` (`user_in_charge`),
					  KEY `attached_file_id` (`attached_file_id`),
					  KEY `area_id` (`area_id`),
					  KEY `FK_#new_client_abb#_entries_4` (`attached_image_id`),
					  KEY `FK_#new_client_abb#_entries_5` (`iframe_display_type_id`),
					  KEY `FK_#new_client_abb#_entries_6` (`display_type_id`),
					  CONSTRAINT `FK_#new_client_abb#_entries_6` FOREIGN KEY (`display_type_id`) REFERENCES `#new_client_abb#_display_types` (`display_type_id`),
					  CONSTRAINT `#new_client_abb#_entries_ibfk_1` FOREIGN KEY (`user_in_charge`) REFERENCES `#new_client_abb#_users` (`id`),
					  CONSTRAINT `#new_client_abb#_entries_ibfk_2` FOREIGN KEY (`attached_file_id`) REFERENCES `#new_client_abb#_files` (`id`),
					  CONSTRAINT `#new_client_abb#_entries_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `#new_client_abb#_areas` (`id`),
					  CONSTRAINT `FK_#new_client_abb#_entries_4` FOREIGN KEY (`attached_image_id`) REFERENCES `#new_client_abb#_files` (`id`),
					  CONSTRAINT `FK_#new_client_abb#_entries_5` FOREIGN KEY (`iframe_display_type_id`) REFERENCES `#new_client_abb#_iframes_display_types` (`iframe_display_type_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
				
				
				
				<cfquery datasource="#client_datasource#">
					CREATE TABLE `#new_client_abb#_consultations` (
					  `id` int(10) unsigned NOT NULL auto_increment,
					  `title` text collate utf8_unicode_ci,
					  `description` text collate utf8_unicode_ci,
					  `parent_id` int(11) NOT NULL,
					  `parent_kind` varchar(15) collate utf8_unicode_ci default NULL,
					  `user_in_charge` int(11) NOT NULL,
					  `attached_file_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `attached_file_id` int(11) default NULL,
					  `creation_date` datetime NOT NULL,
					  `status` varchar(45) collate utf8_unicode_ci NOT NULL,
					  `area_id` int(11) NOT NULL,
					  `attached_image_name` varchar(255) collate utf8_unicode_ci default NULL,
					  `attached_image_id` int(11) default NULL,
					  `link` varchar(255) collate utf8_unicode_ci NOT NULL,
					  `last_update_date` datetime NOT NULL,
					  `read_date` datetime default NULL,
					  `answer_date` datetime default NULL,
					  `close_date` datetime default NULL,
					  `state` varchar(10) collate utf8_unicode_ci NOT NULL,
					  `identifier` varchar(100) collate utf8_unicode_ci NOT NULL,
					  PRIMARY KEY  (`id`),
					  KEY `user_in_charge` (`user_in_charge`),
					  KEY `attached_file_id` (`attached_file_id`),
					  KEY `area_id` (`area_id`),
					  KEY `FK_#new_client_abb#_consultations_4` (`attached_image_id`),
					  CONSTRAINT `FK_#new_client_abb#_consultations_4` FOREIGN KEY (`attached_image_id`) REFERENCES `#new_client_abb#_files` (`id`),
					  CONSTRAINT `#new_client_abb#_consultations_ibfk_1` FOREIGN KEY (`user_in_charge`) REFERENCES `#new_client_abb#_users` (`id`),
					  CONSTRAINT `#new_client_abb#_consultations_ibfk_2` FOREIGN KEY (`attached_file_id`) REFERENCES `#new_client_abb#_files` (`id`),
					  CONSTRAINT `#new_client_abb#_consultations_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `#new_client_abb#_areas` (`id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
		
				<cfquery datasource="#client_datasource#">
					CREATE TABLE  `#new_client_abb#_consultations_readings` (
					  `consultation_id` int(10) unsigned NOT NULL,
					  `user_id` int(11) NOT NULL,
					  `date` datetime NOT NULL,
					  KEY `FK_#new_client_abb#_consultations_readings_consultations` (`consultation_id`),
					  KEY `FK_#new_client_abb#_consultations_readings_users` (`user_id`),
					  CONSTRAINT `FK_#new_client_abb#_consultations_readings_consultations` FOREIGN KEY (`consultation_id`) REFERENCES `#new_client_abb#_consultations` (`id`) ON DELETE CASCADE,
					  CONSTRAINT `FK_#new_client_abb#_consultations_readings_users` FOREIGN KEY (`user_id`) REFERENCES `#new_client_abb#_users` (`id`) ON DELETE CASCADE
					) ENGINE=InnoDB DEFAULT CHARSET=utf8;
				</cfquery>
				
				
				
				<!---<cfquery datasource="#client_datasource#">
					INSERT INTO `#new_client_abb#_users` (`id`, `name`, `telephone`, `address`, `password`, `space_used`, `number_of_connections`, `connected`, `session_id`, `creation_date`, `internal_user`, `root_folder_id`, `family_name`, `sms_allowed`, `mobile_phone`, `space_downloaded`, `validated`, `email`, `image_id`, `telephone_ccode`, `mobile_phone_ccode`) VALUES
					(1, 'Support', NULL, NULL, '6f2a7325a9966a6a135e0bf5e2126430', 0, 3, 1, '1a3024245e9921e08a2e746c3a35221443c5', '#current_date#', NULL, 1, NULL, 0, NULL, 0, 0, 'support@era7.com', NULL, NULL, NULL);
				</cfquery>--->	
					
				<!---
				ESTA TABLA EN DP 2.0 NO ES NECESARIA
				<cfquery datasource="#client_datasource#">	
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_user_images` (
					  `id` int(11) NOT NULL,
					  `image_src` varchar(200) collate utf8_unicode_ci NOT NULL,
					  `image_size` int(11) NOT NULL,
					  PRIMARY KEY  (`id`),
					  UNIQUE KEY `image_src` (`image_src`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>--->	
					
				<!---<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_user_preferences` (
					  `user_id` int(11) NOT NULL,
					  `notify_new_message` tinyint(1) default '1',
					  `notify_new_file` tinyint(1) default '1',
					  `language` varchar(255) collate utf8_unicode_ci default NULL,
					  `notify_replace_file` tinyint(1) default '1',
					  `notify_new_area` tinyint(1) default '1',
					  PRIMARY KEY  (`user_id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>--->	
				
				
				<cfquery datasource="#client_datasource#">
					CREATE TABLE IF NOT EXISTS `#new_client_abb#_incidences` (
					  `id` int(11) NOT NULL auto_increment,
					  `title` varchar(255) collate utf8_unicode_ci NOT NULL,
					  `description` text collate utf8_unicode_ci NOT NULL,
					  `user_in_charge` int(11) NOT NULL,
					  `creation_date` datetime NOT NULL,
					  `type_id` int(11) NOT NULL,
					  `related_to` varchar(255) collate utf8_unicode_ci NOT NULL,
					  `status` varchar(100) collate utf8_unicode_ci NOT NULL,
					  `resolution_date` datetime default NULL,
					  `resolution_description` text collate utf8_unicode_ci,
					  PRIMARY KEY  (`id`)
					) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
				</cfquery>
				
				
				<!---CREATE TABLE IF NOT EXISTS `#new_client_abb#_incidences` (
				  `id` int(11) NOT NULL auto_increment,
				  `title` varchar(255) collate utf8_unicode_ci NOT NULL,
				  `description` text collate utf8_unicode_ci NOT NULL,
				  `user_in_charge` int(11) NOT NULL,
				  `creation_date` datetime NOT NULL,
				  `type_id` int(11) NOT NULL,
				  `related_to` varchar(255) collate utf8_unicode_ci NOT NULL,
				  `status` varchar(100) collate utf8_unicode_ci NOT NULL,
				  `resolution_date` datetime default NULL,
				  `resolution_description` text collate utf8_unicode_ci,
				  PRIMARY KEY  (`id`)
				) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;--->
				
					
				<!---<cfquery datasource="#client_datasource#">	
					INSERT INTO `#new_client_abb#_user_preferences` (`user_id`, `notify_new_message`, `notify_new_file`, `language`, `notify_replace_file`) VALUES
					(1, 1, 1, 'es', 1);
				</cfquery>--->
				
				<!---Aquí hay que llamar a un método que ponga como sesion actual la del cliente recien creado,
				para que las siguientes peticiones afecten a ese cliente. Lo que habría que hacer en ese método sería:
				SESSION.client_abb = #new_client_abb#
				Estaría bien que al logearse con un usuario para entrar en esta área de crear clientes,
				no se definiera un #client_abb# o algo parecido, y que solo se definiera para hacer determinadas
				cosas sobre un cliente.--->
				
				
				<!---create AdministratorUser--->
				<!---<cfinvoke component="#APPLICATION.componentsPath#/RequestManager" method="createRequest" returnvariable="createUserRequest">
					<cfinvokeargument name="request_parameters" value="#xmlRequest.request.parameters.user#">
				</cfinvoke>--->
			
			</cftransaction>
		
		
			
			<cfinvoke component="UserManager" method="objectUser" returnvariable="objectUser">
				<cfinvokeargument name="xml" value="#xmlRequest.request.parameters.user#">
					
				<cfinvokeargument name="return_type" value="object">
			</cfinvoke>	
			
			<cfif len(objectUser.whole_tree_visible) IS 0>
				<cfset objectUser.whole_tree_visible = "false">
			</cfif> 
			
			<cfif len(objectUser.sms_allowed) IS 0>
				<cfset objectUser.sms_allowed = "false">
			</cfif>
			
			<cfset objectUser.email = Trim(objectUser.email)>
			<cfset objectUser.mobile_phone = Trim(objectUser.mobile_phone)>
			
			<cftransaction>
				
				<!---checkEmail--->
				<!---<cfquery name="checkEmail" datasource="#client_dsn#">
					SELECT id
					FROM #client_abb#_users
					WHERE email=<cfqueryparam value="#objectUser.email#" cfsqltype="cf_sql_varchar">;
				</cfquery>
				
				<cfif checkEmail.recordCount GT 0><!---User email already used--->
					<cfset error_code = 205>
				
					<cfthrow errorcode="#error_code#">
				</cfif>--->
				
				<cfset objectUser.language = "es">
				
				<!---Insert User in DataBase--->			
				<cfquery name="insertUserQuery" datasource="#client_datasource#" result="insertUserResult">
					INSERT INTO #new_client_abb#_users
					(email,name,family_name,telephone,address,password, internal_user, sms_allowed, mobile_phone, creation_date, telephone_ccode, mobile_phone_ccode, language)
					VALUES(
						<cfqueryparam value="#objectUser.email#" cfsqltype="cf_sql_varchar">,
						<cfqueryPARAM value="#objectUser.name#" CFSQLType = "CF_SQL_varchar">,
						<cfqueryPARAM value="#objectUser.family_name#" CFSQLType = "CF_SQL_varchar">,
						<cfqueryPARAM value="#objectUser.telephone#" CFSQLType = "CF_SQL_varchar">,
						<cfqueryPARAM value="#objectUser.address#" CFSQLType = "CF_SQL_varchar">,
						<cfqueryPARAM value="#objectUser.password#" CFSQLType = "CF_SQL_varchar">,
						<cfqueryPARAM value="#objectUser.whole_tree_visible#" CFSQLType = "CF_SQL_bit">,
						<cfqueryPARAM value="#objectUser.sms_allowed#" CFSQLType = "CF_SQL_bit">,
						<cfqueryPARAM value="#objectUser.mobile_phone#" CFSQLType = "CF_SQL_varchar">,
						NOW(),
						<cfif len(objectUser.telephone_ccode) GT 0>
							<cfqueryPARAM value="#objectUser.telephone_ccode#" cfsqltype="cf_sql_integer">,
						<cfelse>
							<cfqueryparam null="true" cfsqltype="cf_sql_numeric">,
						</cfif>
						<cfif len(objectUser.mobile_phone_ccode) GT 0>
							<cfqueryPARAM value="#objectUser.mobile_phone_ccode#" cfsqltype="cf_sql_integer">
						<cfelse>
							<cfqueryparam null="true" cfsqltype="cf_sql_numeric">
						</cfif>,
						<cfqueryparam value="#objectUser.language#" cfsqltype="cf_sql_varchar">
						);
				</cfquery>
				
				<!---Aquí se obtiene el id del usuario insertado en base de datos--->
				<cfquery name="getLastInsertId" datasource="#client_datasource#">
					SELECT LAST_INSERT_ID() AS last_insert_id FROM #new_client_abb#_users;
				</cfquery>
				<cfset objectUser.id = getLastInsertId.last_insert_id>
				
				<!---Insert User Root Folder--->
				<cfquery name="insertRootFolderQuery" datasource="#client_datasource#" result="insertRootFolderResult">
					INSERT INTO #new_client_abb#_folders
					(name, creation_date, user_in_charge, description)
					VALUES(
						'Mis documentos', 
						NOW(),
						<cfqueryPARAM value="#objectUser.id#" CFSQLType="cf_sql_integer">,
						'Directorio raiz'
						);
				</cfquery>	
				
				<cfquery name="getLastInsertId" datasource="#client_datasource#">
					SELECT LAST_INSERT_ID() AS last_insert_id FROM #new_client_abb#_folders;
				</cfquery>
				<cfset root_folder_id = getLastInsertId.last_insert_id>
				
				<cfquery name="insertRootFolderInUser" datasource="#client_datasource#">
					UPDATE #new_client_abb#_users
					SET root_folder_id = #root_folder_id#
					WHERE id = <cfqueryPARAM value="#objectUser.id#" CFSQLType="cf_sql_integer">;
				</cfquery>
				
				
				<!---Add user to areas--->
				
				<cfquery name="assignUser" datasource="#client_datasource#">
					INSERT INTO #new_client_abb#_areas_users (area_id, user_id)
					VALUES(<cfqueryparam value="1" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#objectUser.id#" cfsqltype="cf_sql_integer">);
				</cfquery>
				
				<cfquery name="assignUser2" datasource="#client_datasource#">
					INSERT INTO #new_client_abb#_areas_users (area_id, user_id)
					VALUES(<cfqueryparam value="2" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#objectUser.id#" cfsqltype="cf_sql_integer">);
				</cfquery>
				
			</cftransaction>			
				
			
			<!---Esto es provisional--->
			<!---<cfset current_client_abb = SESSION.client_abb>
			<cfset SESSION.client_abb = "#new_client_abb#">
			
			<cfinvoke component="UserManager" method="createUser">
				<cfinvokeargument name="request" value="#xmlRequest#">
			</cfinvoke>
			
			<!---assign User To Root Area--->
			<cfinvoke component="#APPLICATION.componentsPath#/RequestManager" method="createRequest" returnvariable="assignUserToAreaRequest">
				<cfinvokeargument name="request_parameters" value='<user id="1"/><area id="1"/>'>
			</cfinvoke>
		
			<cfinvoke component="UserManager" method="assignUserToArea">
				<cfinvokeargument name="request" value="#assignUserToAreaRequest#">
			</cfinvoke>
			
			
			<!---Esto es provisional--->
			<cfset SESSION.client_abb = current_client_abb>--->
		
		
		
		
			<cftransaction>
			
				<!--- --------------------------------- FOREIGN KEYS -------------------------------- --->
					
				<cfquery datasource="#client_datasource#">	
					ALTER TABLE `#new_client_abb#_areas`
					  ADD CONSTRAINT `#new_client_abb#_areas_ibfk_11` FOREIGN KEY (`image_id`) REFERENCES `#new_client_abb#_areas_images` (`id`),
					  ADD CONSTRAINT `#new_client_abb#_areas_ibfk_10` FOREIGN KEY (`user_in_charge`) REFERENCES `#new_client_abb#_users` (`id`),
					  ADD CONSTRAINT `#new_client_abb#_areas_ibfk_9` FOREIGN KEY (`parent_id`) REFERENCES `#new_client_abb#_areas` (`id`);
				</cfquery>
				
				<cfquery datasource="#client_datasource#">				
					ALTER TABLE `#new_client_abb#_areas_administrators`
					  ADD CONSTRAINT `#new_client_abb#_areas_administrators_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `#new_client_abb#_users` (`id`) ON DELETE CASCADE,
					  ADD CONSTRAINT `#new_client_abb#_areas_administrators_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `#new_client_abb#_areas` (`id`) ON DELETE CASCADE;
				</cfquery>	
					
				<cfquery datasource="#client_datasource#">
					ALTER TABLE `#new_client_abb#_areas_files`
					  ADD CONSTRAINT `#new_client_abb#_areas_files_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `#new_client_abb#_areas` (`id`) ON DELETE CASCADE,
					  ADD CONSTRAINT `#new_client_abb#_areas_files_ibfk_2` FOREIGN KEY (`file_id`) REFERENCES `#new_client_abb#_files` (`id`) ON DELETE CASCADE;
				</cfquery>
					
				<cfquery datasource="#client_datasource#">
					ALTER TABLE `#new_client_abb#_areas_users`
					  ADD CONSTRAINT `#new_client_abb#_areas_users_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `#new_client_abb#_areas` (`id`) ON DELETE CASCADE,
					  ADD CONSTRAINT `#new_client_abb#_areas_users_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `#new_client_abb#_users` (`id`) ON DELETE CASCADE;
				</cfquery>	
					
				<cfquery datasource="#client_datasource#">
					ALTER TABLE `#new_client_abb#_contacts`
					  ADD CONSTRAINT `#new_client_abb#_contacts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `#new_client_abb#_users` (`id`) ON DELETE CASCADE;
				</cfquery>
				
				
				<cfquery datasource="#client_datasource#">
					ALTER TABLE `#new_client_abb#_files`
					  ADD CONSTRAINT `#new_client_abb#_files_ibfk_1` FOREIGN KEY (`user_in_charge`) REFERENCES `#new_client_abb#_users` (`id`);
				</cfquery>
				
				
				<cfquery datasource="#client_datasource#">
					ALTER TABLE `#new_client_abb#_folders`
					  ADD CONSTRAINT `#new_client_abb#_folders_ibfk_8` FOREIGN KEY (`parent_id`) REFERENCES `#new_client_abb#_folders` (`id`),
					  ADD CONSTRAINT `#new_client_abb#_folders_ibfk_7` FOREIGN KEY (`user_in_charge`) REFERENCES `#new_client_abb#_users` (`id`);
				</cfquery>
					
				<cfquery datasource="#client_datasource#">
					ALTER TABLE `#new_client_abb#_folders_files`
					  ADD CONSTRAINT `#new_client_abb#_folders_files_ibfk_1` FOREIGN KEY (`folder_id`) REFERENCES `#new_client_abb#_folders` (`id`),
					  ADD CONSTRAINT `#new_client_abb#_folders_files_ibfk_2` FOREIGN KEY (`file_id`) REFERENCES `#new_client_abb#_files` (`id`) ON DELETE CASCADE;
				</cfquery>
					
				<cfquery datasource="#client_datasource#">
					ALTER TABLE `#new_client_abb#_messages`
					  ADD CONSTRAINT `#new_client_abb#_messages_ibfk_1` FOREIGN KEY (`user_in_charge`) REFERENCES `#new_client_abb#_users` (`id`),
					  ADD CONSTRAINT `#new_client_abb#_messages_ibfk_2` FOREIGN KEY (`attached_file_id`) REFERENCES `#new_client_abb#_files` (`id`),
					  ADD CONSTRAINT `#new_client_abb#_messages_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `#new_client_abb#_areas` (`id`);
				</cfquery>
					
				<!---
				ESTA TABLA EN DP 2.0 NO ES NECESARIA
				<cfquery datasource="#client_datasource#">
					ALTER TABLE `#new_client_abb#_sms`
					  ADD CONSTRAINT `#new_client_abb#_sms_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `#new_client_abb#_users` (`id`) ON DELETE CASCADE;
				</cfquery>--->
					
				<!---
				ESTA TABLA EN DP 2.0 NO ES NECESARIA
				<cfquery datasource="#client_datasource#">
					ALTER TABLE `#new_client_abb#_users`
					  ADD CONSTRAINT `#new_client_abb#_users_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `#new_client_abb#_user_images` (`id`);
				</cfquery>--->
					
				<!---
				ESTA TABLA EN DP 2.0 NO ES NECESARIA
				<cfquery datasource="#client_datasource#">
					ALTER TABLE `#new_client_abb#_user_preferences`
					  ADD CONSTRAINT `#new_client_abb#_user_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `#new_client_abb#_users` (`id`) ON DELETE CASCADE;
				</cfquery>--->
			
			</cftransaction>
			
			
			
			<!---createClientFolders--->
			<cfinvoke component="ClientManager" method="createClientFolders">
				<cfinvokeargument name="cur_client_abb" value="#new_client_abb#">
			</cfinvoke>	
			
			
			<cfset xmlResponseContent = arguments.request>
			
			<cfinclude template="includes/functionEndNoLog.cfm">
			
			<cfcatch>
				<cfset xmlResponseContent = arguments.request>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>										
			
		</cftry>
		
		<cfreturn xmlResponse>
		
	</cffunction>
	
	
	<!--- ------------------------------ createClientFolders ----------------------------- --->
	
	<cffunction name="createClientFolders" returntype="void" access="public">
		<cfargument name="cur_client_abb" type="string" required="yes">
		
		<cfset var method = "createClientFolders">
		
		<cfset var dirDelim = "/">
		<cfset var modePer = 777>
		
		<cfset var arrayDir = arrayNew(1)>
		
		<!---<cfinclude template="includes/initVars.cfm">--->	
			
			<cfinclude template="includes/functionStartOnlySession.cfm">
			
			<!---<cfset APPLICATION.filesPath = "/home/administrador/doplanning">--->
		
			<cfif server.OS.Name contains "Windows">
				<cfset dirDelim = "\">
			</cfif>
			
			<cfset arrayAppend(arrayDir,"#arguments.cur_client_abb#")>
			<cfset arrayAppend(arrayDir,"#arguments.cur_client_abb##dirDelim#files")>
			<cfset arrayAppend(arrayDir,"#arguments.cur_client_abb##dirDelim#areas_images")>
			<cfset arrayAppend(arrayDir,"#arguments.cur_client_abb##dirDelim#users_images")>
			

			<cfloop index="current_directory" array="#arrayDir#">
				
				<cfset full_current_directory = "#APPLICATION.filesPath##dirDelim##current_directory#">
				<cfif NOT directoryExists(full_current_directory)>
					<cfdirectory action="create" directory="#full_current_directory#" mode="#modePer#">
				<cfelse>
					<cfset error_code = 305><!---Client directory already exists--->
			
					<cfthrow errorcode="#error_code#">
				</cfif>
				
			</cfloop>
	
			<!---<cfcatch>
				<cfinclude template="includes/errorHandler.cfm">
			</cfcatch>
		</cftry>--->
		
	</cffunction>
	
</cfcomponent>