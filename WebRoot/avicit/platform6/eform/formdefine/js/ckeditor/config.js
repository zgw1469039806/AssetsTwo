CKEDITOR.editorConfig = function( config ) {
	
	/*
	config.toolbarGroups = [
		{ name: 'document', groups: [  'document' ] },
		{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
		{ name: 'forms', groups: [ 'forms' ] },
		{ name: 'paragraph', groups: [    'align' ] },
		{ name: 'basicstyles', groups: [ 'basicstyles' ] },
		{ name: 'insert', groups: [ 'insert' ] },
		{ name: 'tools', groups: [ 'tools' ] }
	];
	*/
	var tmp = window.location.pathname,
    URL = "http://"+(window.location.host)+"/"+tmp.split("/")[1]+"/";
	config.filebrowserUploadUrl = URL + "avicit/platform6/eform/formdefine/js/ckeditor/plugins/image/imageUp.jsp";
	config.extraPlugins = 'newpreview,requirestar';
	config.toolbar = 'Full';
	config.allowedContent= true;
	config.resize_enabled = false
	config.removePlugins = 'elementspath';
	config.toolbar_Full =   
		[   
		    ['newpreview','requirestar','image','-'],   
		    ['Table','Checkbox', 'Radio', 'TextField', 'Textarea', 'Select','HiddenField','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],   
		    ['Bold','Italic','Underline','Strike'],   
		    ['SpecialChar'],   
		    ['Styles','Format','Font','FontSize'],   
		    ['TextColor','BGColor','Image']
		];

};