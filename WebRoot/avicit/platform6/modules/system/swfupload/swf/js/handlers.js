/* Demo Note:  This demo uses a FileProgress class that handles the UI for displaying the file name and percent complete.
The FileProgress class is not part of SWFUpload.
*/


/* **********************
   Event Handlers
   These are my custom event handlers to make my
   web application behave the way I went when SWFUpload
   completes different tasks.  These aren't part of the SWFUpload
   package.  They are part of my application.  Without these none
   of the actions SWFUpload makes will show up in my application.
   ********************** */
var files = [];
function swfUploadPreLoad() {
	var self = this;
	var loading = function () {
		document.getElementById("divLoadingContent").style.display = "";

		var longLoad = function () {
			document.getElementById("divLoadingContent").style.display = "none";
			document.getElementById("divLongLoading").style.display = "";
		};
		this.customSettings.loadingTimeout = setTimeout(function () {
				longLoad.call(self)
			},
			15 * 1000
		);
	};
	
	this.customSettings.loadingTimeout = setTimeout(function () {
			loading.call(self);
		},
		1*1000
	);
}
   
function swfUploadLoadFailed() {
	clearTimeout(this.customSettings.loadingTimeout);
	document.getElementById("divLoadingContent").style.display = "none";
	document.getElementById("divLongLoading").style.display = "none";
	document.getElementById("divAlternateContent").style.display = "";
}
   
   
function fileQueued(file) {
	try {
		new FileProgress(file, this.customSettings.myFileListTarget,this,this.customSettings.selectHtml,this.customSettings.userName);
	} catch (ex) {
		this.debug(ex);
	}
}

function fileQueueError(file, errorCode, message) {
	try {
		
		if (errorCode === SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
			if(message > 1){
				alert(SWFUpload_I18N.queueError.limitExceeded1.replace('{number}', message));
			}else{
				alert(SWFUpload_I18N.queueError.limitExceeded2);
			}
			return;
		}
		
		FileProgress(file, this.customSettings.myFileListTarget,this);
		var tr = document.getElementById(file.id);
		tr.style.color="red";
		var bar = document.getElementById(file.id+"_bar");
		var errInfo = SWFUpload_I18N.queueError.errInfo;

		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			//progress.setStatus("File is too big.");
			errInfo = errInfo + SWFUpload_I18N.queueError.fileExceededSizeLimit;
			this.debug("Error Code: File too big, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			//progress.setStatus("Cannot upload Zero Byte files.");
			errInfo = errInfo + SWFUpload_I18N.queueError.zeroByteFile;
			this.debug("Error Code: Zero byte file, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			//progress.setStatus("Invalid File Type.");
			errInfo = errInfo + SWFUpload_I18N.queueError.invalidFiletype;
			this.debug("Error Code: Invalid File Type, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		default:
			if (file !== null) {
				//progress.setStatus("Unhandled Error");
				errInfo = errInfo + SWFUpload_I18N.queueError.unhandledError;
			}
			this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		}
		//根据表格样式属性
		if(file_style == 'table'){
			bar.parentNode.innerHTML="<center>"+errInfo+"</center>";
		}else if(file_style == 'span'){
			bar.parentNode.parentNode.innerHTML=errInfo;
		}
		
		var delObject = document.getElementById(file.id+"_del");
		delObject.parentNode.innerHTML="&nbsp;";
		swfUploadInstance.cancelUpload(file.id);
	} catch (ex) {
        this.debug(ex);
    }
}

function fileDialogComplete(numFilesSelected, numFilesQueued) {
	try {
		if (numFilesSelected > 0) {
			//document.getElementById(this.customSettings.cancelButtonId).disabled = false;
		}
		
		/* I want auto start the upload and I can do that here */
		//add by stephen
		if(this.settings.auto_upload){//是否要上传
			this.startUpload();
		}
	} catch (ex)  {
        this.debug(ex);
	}
}

function uploadStart(file) {
	try {
		/* I don't want to do any file validation or anything,  I'll just update the UI and
		return true to indicate that the upload should start.
		It's important to update the UI here because in Linux no uploadProgress events are called. The best
		we can do is say we are uploading.
		 */
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setStatus("Uploading...");
		progress.toggleCancel(true, this);
	}
	catch (ex) {}
	
	return true;
}

function uploadProgress(file, bytesLoaded, bytesTotal) {
	try {
		var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
		var bar = document.getElementById(file.id+"_bar");
		//根据表格样式属性
		if(file_style == 'table'){
			if($(bar).is(":hidden")){
				$(bar).show();
			}
			bar.style.width=percent+"%";
			var per = document.getElementById(file.id+"_per");
			per.innerHTML = "("+percent+"%)";
		}else if(file_style == 'span'){
			if($(bar).parent('.perbar').is(":hidden")){
				$(bar).parent('.perbar').show();
			}
			bar.style.width=percent+"%";
			var per = document.getElementById(file.id+"_per");
			per.innerHTML = percent+"%";
		}
		var tr = document.getElementById(file.id);
	} catch (ex) {
		this.debug(ex);
	}
}

function uploadSuccess(file, serverData) {
	var isSuccess = (serverData.indexOf("successed")!=-1?true:false);
	try {
		if(isSuccess){
			var icon = au.countImage(file.name);
			var tr = document.getElementById(file.id);
			//根据表格样式属性
			if(file_style == 'table'){
				tr.style.color="green";
				var attId = serverData.substring("successed".length,serverData.indexOf("<"));
                file.post.attachId = attId;
				//dingrc  增加afterUploadGetFileId回调方法传fileid回去
				if(typeof(afterUploadGetFileId)=="function"){
					afterUploadGetFileId(attId,file);
				}
	           // document.getElementById(file.id+"_id").value =attId; 
				var bar = document.getElementById(file.id+"_id");
				bar.parentNode.innerHTML= "<INPUT TYPE='hidden' id= '"+file.id+"_id'"+" NAME='attName"+form_code+"' value='"+file.name+"'><img src='"+icon+"' class='new-ico-file'/>"
					+"<a href='platform/swfUploadController/doDownload?fileuploadBusinessId="+attId+"&fileuploadBusinessTableName="+form_code+"&encryption="+encryption+"&fileuploadIsSaveToDatabase="+save_type+"&fileId="+attId+"'  class='link-black'>"+file.name+"</a>";
				var bar = document.getElementById(file.id+"_bar");
				bar.parentNode.innerHTML="<center>"+SWFUpload_I18N.uploadSuccess+"</center>";
				var delObject = document.getElementById(file.id+"_del");
				delObject.parentNode.innerHTML="<span id='lb"+attId+"'><label  class='link-red' onclick='deleteFile(\""+attId+"\",\""+file.name+"\",this)'>"+SWFUpload_I18N.del+"</label></span>";
				document.getElementById(this.customSettings.myFileListTarget+"Count").innerHTML=this.getStats().files_queued;
		
				//document.getElementById("shengyu").innerHTML = (file_upload_limit - swfu.getStats().successful_uploads);
				$("#uploadLimit").text(SWFUpload_I18N.uploadLimit.replace('{limit}', file_upload_limit).replace('{permit}', parseInt(file_upload_limit) - parseInt(swfu.getStats().successful_uploads)));
				if(file_category!=""){
					var sc = document.getElementById("category_"+file.id);
					var tsc = sc.options[sc.options.selectedIndex].text;
					sc.parentNode.innerHTML=tsc;
				}
				if(secret_level!=""){
					var lc = document.getElementById("secret_"+file.id);
					var tlc = lc.options[lc.options.selectedIndex].text;
					lc.parentNode.innerHTML=tlc;
				}
				tr.setAttribute("id", attId);
			}else if(file_style == 'span'){
				//tr.style.color="green";
				var attId = serverData.substring("successed".length,serverData.indexOf("<"));
                file.post.attachId = attId;
				//dingrc  增加afterUploadGetFileId回调方法传fileid回去
				if(typeof(afterUploadGetFileId)=="function"){
					afterUploadGetFileId(attId,file);
				}
	           // document.getElementById(file.id+"_id").value =attId; 
				var bar = document.getElementById(file.id+"_id");
				bar.parentNode.innerHTML= "<INPUT TYPE='hidden' id= '"+attId+"_id'"+" NAME='attName"+form_code+"' value='"+file.name+"'><img src='"+icon+"' class='new-ico-file'/>"
					+"<a href='platform/swfUploadController/doDownload?fileuploadBusinessId="+attId+"&fileuploadBusinessTableName="+form_code+"&encryption="+encryption+"&fileuploadIsSaveToDatabase="+save_type+"&fileId="+attId+"' class='link-black'>"+file.name+"</a>";
				var bar = document.getElementById(file.id+"_bar");
				bar.parentNode.parentNode.innerHTML="";
				var delObject = document.getElementById(file.id+"_del");
				delObject.parentNode.innerHTML="<span id='lb"+attId+"'><label class='link-red' onclick='deleteFile(\""+attId+"\",\""+file.name+"\",this)'>"+SWFUpload_I18N.del+"</label></span>";
				document.getElementById(this.customSettings.myFileListTarget+"Count").innerHTML=this.getStats().files_queued;
				//document.getElementById("shengyu").innerHTML = (file_upload_limit - swfu.getStats().successful_uploads);
				$("#uploadLimit").text(SWFUpload_I18N.uploadLimit.replace('{limit}', file_upload_limit).replace('{permit}', parseInt(file_upload_limit) - parseInt(swfu.getStats().successful_uploads)));
				if(file_category!=""){
					var sc = document.getElementById("category_"+file.id);
					var tsc = sc.options[sc.options.selectedIndex].text;
					sc.parentNode.setAttribute('title', SWFUpload_I18N.tableTitle.attachCategory);
					sc.parentNode.innerHTML = "["+ tsc +"]";
				}
				if(secret_level!=""){
					var lc = document.getElementById("secret_"+file.id);
					var tlc = lc.options[lc.options.selectedIndex].text;
					lc.parentNode.setAttribute('title', SWFUpload_I18N.tableTitle.secretLevel);
					lc.parentNode.innerHTML = "["+ tlc +"]";
				}
				
				tr.setAttribute("id", attId);
			}
		}else{
			var tr = document.getElementById(file.id);
			tr.style.color="red";
			var bar = document.getElementById(file.id+"_bar");
			//根据表格样式属性
			if(file_style == 'table'){
				bar.parentNode.innerHTML="<center>"+SWFUpload_I18N.uploadFailed+"</center>";
			}else if(file_style == 'span'){
				bar.parentNode.parentNode.innerHTML=SWFUpload_I18N.uploadFailed;
			}
			var delObject = document.getElementById(file.id+"_del");
			delObject.parentNode.innerHTML="&nbsp;";
		}
	} catch (ex) {
		this.debug(ex);
	}
    files.push(file);
	/*
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setComplete();
		progress.setStatus("Complete.");
		progress.toggleCancel(false);

	} catch (ex) {
		this.debug(ex);
	}
	*/
}

function uploadError(file, errorCode, message) {
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setError();
		progress.toggleCancel(false);

		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
			progress.setStatus(SWFUpload_I18N.uploadError.httpError + message);
			this.debug("Error Code: HTTP Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
			progress.setStatus(SWFUpload_I18N.uploadError.missingUploadUrl);
			this.debug("Error Code: No backend file, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
			progress.setStatus(SWFUpload_I18N.uploadError.uploadFailed);
			this.debug("Error Code: Upload Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.IO_ERROR:
			progress.setStatus(SWFUpload_I18N.uploadError.ioError);
			this.debug("Error Code: IO Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
			progress.setStatus(SWFUpload_I18N.uploadError.securityError);
			this.debug("Error Code: Security Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			progress.setStatus(SWFUpload_I18N.uploadError.uploadLimitExceeded);
			this.debug("Error Code: Upload Limit Exceeded, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND:
			progress.setStatus(SWFUpload_I18N.uploadError.specifiedFileIdNotFound);
			this.debug("Error Code: The file was not found, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
			progress.setStatus(SWFUpload_I18N.uploadError.fileValidationFailed);
			this.debug("Error Code: File Validation Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			if (this.getStats().files_queued === 0) {
				//document.getElementById(this.customSettings.cancelButtonId).disabled = true;
			}
			progress.setStatus(SWFUpload_I18N.uploadError.fileCancelled);
			progress.setCancelled();
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			progress.setStatus(SWFUpload_I18N.uploadError.uploadStopped);
			break;
		default:
			progress.setStatus(SWFUpload_I18N.uploadError.unhandledError + error_code);
			this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		}
	} catch (ex) {
        this.debug(ex);
    }
}

function uploadComplete(file) {

}

// This event comes from the Queue Plugin
function queueComplete(numFilesUploaded) {
	document.getElementById(this.customSettings.myFileListTarget+"SuccessUploadCount").innerHTML=this.getStats().successful_uploads;//add by stephen
	if(typeof(afterUploadBaseEvent)=="function"){
		//dingrc  增加file参数  file.name可以拿到文件名称
        afterUploadBaseEvent(files);
	}
	/* comment by stephen
	var status = document.getElementById("divStatus");
	status.innerHTML = numFilesUploaded + " file" + (numFilesUploaded === 1 ? "" : "s") + " uploaded.";
	*/
}

//add by stephen 
//version 2.2 why remove follow function, i must add again.
var _K = 1024;
var _M = _K*1024;
function getNiceFileSize(bitnum){
	if(bitnum<_M){
		if(bitnum<_K){
			return bitnum+'B';
		}else{
			return Math.ceil(bitnum/_K)+'K';
		}
		
	}else{
		return Math.ceil(100*bitnum/_M)/100+'M';
	}
}

