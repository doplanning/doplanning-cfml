function postUserDataForm(requestUrl) {

	$('body').modalmanager('loading');
	$("#userSubmitButton").button('loading');

	var formId = "#updateUserData";


	var launchOpenAreasAssociateModal = function(event) { //Esto es necesario porque si no se hace así se cuelga la aplicación porque se accede a $modal para volver a mostrarlo cuando no está terminado de ocultar
	  	
		$($modal).unbind( "hidden.bs.modal", launchOpenAreasAssociateModal );

		openAreasAssociateModal(event.data.userId);
		
	};

	if( $('#file').val().length == 0) { //Sin archivo


		$.ajax({
			  type: "POST",
			  //url: $(formId).attr("action"),
			  url: requestUrl,
			  data: $(formId).serialize(),
			  success: function(data, status) {

			  	if(status == "success"){		
			  		var message = data.message;

			  		$('body').modalmanager('removeLoading');

			  		if(data.result == true) {

						var userId = data.user_id;
			  			//openUrl("all_users.cfm?user="+userId, "allUsersIframe");
			  			openUrl("user.cfm?user="+userId, "userAdminIframe");

			  			if( requestUrl.indexOf("createUser") > 0 ){

			  				$($modal).on('hidden.bs.modal', { userId: userId }, launchOpenAreasAssociateModal);

			  			}

			  			hideDefaultModal();
			  			showAlertMessage(message, data.result);	  	

			  		} else {
			  			/*$("#errorMessageModal").modal();	
			  			$("#modalErrorMessage").text(message);*/
			  			showAlertErrorModal(message);	
			  			$("#userSubmitButton").button("reset");	  			
			  		}
			  			
			  	}else
					showAlertModal(status);
				
			  },
			  dataType: "json"
			});

	} else {

		$(formId).fileupload('send', {fileInput: $('#file'), url: requestUrl})
			.success(function ( data, status ) {

				if(status == "success"){
			  		var result = $.parseJSON(data);
			  		var message = result.message;

			  		$('body').modalmanager('removeLoading');

			  		if(result.result == true) {
			  			var userId = result.user_id;
			  			//openUrl("all_users.cfm?user="+userId, "allUsersIframe");
			  			openUrl("user.cfm?user="+userId, "userAdminIframe");

			  			if( requestUrl.indexOf("createUser") > 0 ){

			  				$($modal).on('hidden.bs.modal', { userId: userId }, launchOpenAreasAssociateModal);

			  			}

			  			hideDefaultModal();
			  			showAlertMessage(message, result.result);
			  			
			  		} else {
						/*$("#errorMessageModal").modal();	
			  			$("#modalErrorMessage").text(message);*/
			  			showAlertErrorModal(message);
			  			$("#userSubmitButton").button("reset");					  			
			  		}			  		

			  	}else
			  		showAlertModal(status);

			}).error(function ( data, status )  {

				showAlertModal("Error: "+status);

			}).complete(function ( data, status )  { });

	}
	
	return false;

}