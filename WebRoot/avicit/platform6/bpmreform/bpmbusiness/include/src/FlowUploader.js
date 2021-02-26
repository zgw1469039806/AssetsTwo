/**
 * 引用文档
 */
function FlowUploader(flowEditor) {
	this.flowEditor = flowEditor;
};
/**
 * 流程操作对象
 */
FlowUploader.prototype.flowEditor = null;
/**
 * 上传控件
 */
FlowUploader.prototype.uploader = null;
/**
 * 引用文档的tbody的id
 */
FlowUploader.prototype.filesdiv = "bpm_files_div";
/**
 * 引用文档添加的id
 */
FlowUploader.prototype.filesaddId = "bpm_files_add";
/**
 * 引用文档上传的id
 */
FlowUploader.prototype.filesUploadId = "bpm_files_upload";

/**
 * 密级
 */
FlowUploader.prototype.secretLevelList = [];

FlowUploader.prototype.saveType = "DataBase"; //Fastfds

/**
 * 初始化
 */
FlowUploader.prototype.init = function() {
	var _self = this;
	$.ajax({
		type : "POST",
		data : {
			entryId : this.flowEditor.flowModel.entryId
		},
		url : "platform/bpm/business/getSecretLevelList",
		dataType : "JSON",
		success : function(data) {
			if (flowUtils.notNull(data.error)) {
				flowUtils.error(data.error);
			} else {
				_self.secretLevelList = data.result;
			}
		}
	});
	this.uploader = WebUploader.create({
		// swf文件路径
		swf : 'static/h5/webuploader-0.1.5/dist/Uploader.swf',
		// 文件接收服务端。
		server : 'platform/bpm/business/upload.json',
		// 选择文件的按钮。可选。
		// 内部根据当前运行是创建，可能是input元素，也可能是flash.
		pick : '#' + this.filesaddId,
		// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		resize : false,
		fileSingleSizeLimit: 10*1024*1024
	});
	// 暴漏为全局属性
	_flowUploader_uploader = this.uploader;
	this.uploader.on('ready', function() {
	});
	// 当有文件被添加进队列前执行。判断是否符合条件，否则返回false阻止
	this.uploader.on('beforeFileQueued', function(file) {
		if (flowUtils.notNull(_self.flowEditor.flowModel.entryId)) {
			return true;
		} else {
			flowUtils.warning("请保存表单后再添加文档");
			return false;
		}
	});
	this.uploader.on('fileQueued', function(file) {
		_self.addFile(file);
	});
	// 文件上传之前，传入自定义参数
	this.uploader.on('uploadBeforeSend', function(block, data) {
		// file为分块对应的file对象。
		var file = block.file;
		var fileDIV = $('#' + file.id);
		var secretLevel = fileDIV.find('select[name="secretLevel"]');
		// / 修改data可以控制发送哪些携带数据。
		data.secretLevel = secretLevel.val();
		data.entryId = _self.flowEditor.flowModel.entryId;
		data.saveType = _self.saveType;
	});
	// 文件上传过程中创建进度条实时显示。
	this.uploader.on('uploadProgress', function(file, percentage) {
		var $tr = $('#' + file.id);
		$tr.children().last().html('正在上传');
	});

	// 文件上传成功
	this.uploader.on('uploadSuccess', function(file, response) {
		if (flowUtils.notNull(response.error)) {
			flowUtils.error(response.error)
		} else {
			var $tr = $('#' + file.id);
			$tr.children().last().html('上传成功');
			_self.uploader.removeFile(file);
			setTimeout(function() {
				var $newTr = _self.getTr(response.bpmFiles);
				$tr.replaceWith($newTr);
			}, 500);
		}
	});
	// 文件上传失败
	this.uploader.on('uploadError', function(file, reason) {
		flowUtils.error("上传失败了");
	});
	// 错误
	this.uploader.on('error', function(handler, infos) {
		if(handler == 'F_EXCEED_SIZE'){
			flowUtils.warning("超过附件大小限制");
		}else if(handler == 'Q_TYPE_DENIED'){
			flowUtils.warning("不能上传空文件");
		}else{
			flowUtils.warning("附件不能上传");
		}
	});
	// 文件上传完毕(成功或失败后都会执行)
	this.uploader.on('uploadComplete', function(file) {
	});
	$("#" + this.filesUploadId).on("click", function() {
		var secretLevelArr = [];
		var secretLevelDoms = $("#"+_self.filesdiv).find('select[name="secretLevel"]');
		$.each(secretLevelDoms, function(i, n){
			secretLevelArr.push(n.value);
		});
		var validate = _self.flowEditor.defaultForm.validSecretLevel(secretLevelArr);
		if(validate){
			_self.uploader.upload();
		}
	});
};
FlowUploader.prototype.refresh = function() {
	var _self = this;
	if(!this.flowEditor.isStart && this.flowEditor.flowModel.userIdentityKey == "6"){
		$("#" + this.filesaddId).show();
		$("#" + this.filesUploadId).show();
	}else{
		$("#" + this.filesaddId).hide();
		$("#" + this.filesUploadId).hide();
	}
	$.ajax({
		type : "POST",
		data : {
			entryId : this.flowEditor.flowModel.entryId,
			defineId : this.flowEditor.flowModel.defineId,
			activityName : this.flowEditor.flowModel.activityname
		},
		url : "platform/bpm/business/getBpmFiles",
		dataType : "JSON",
		success : function(data) {
			if (flowUtils.notNull(data.error)) {
				flowUtils.error(data.error);
			} else {
				$("#" + _self.filesdiv).empty();
				$.each(data.result, function(i, n) {
					var $tr = _self.getTr(n);
					$("#" + _self.filesdiv).append($tr);
				});
			}
		}
	});
};
FlowUploader.prototype.addFile = function(file) {
	var tr = $("<tr></tr>");
	tr.attr("id", file.id);
	tr.append(this.getTd(file.name));
	tr.append(this.getTdSecretLevel());
	tr.append(this.getTd(''));
	tr.append(this.getTd(''));
	tr.append(this.getOperateTd(true, file.name, file.id));
	tr.append(this.getTd('等待上传'));
	$("#" + this.filesdiv).append(tr);
};
FlowUploader.prototype.getTr = function(bpmFile) {
	var tr = $("<tr></tr>");
	tr.attr("id", bpmFile.id);
	tr.append(this.getTd(bpmFile.attachName));
	tr.append(this.getTd(bpmFile.secretLevelString));
	tr.append(this.getTd(bpmFile.createdByString));
	tr.append(this.getTd(bpmFile.creationDateString));
	tr.append(this.getOperateTd(false, bpmFile.attachName, bpmFile.id, bpmFile.processDefineid));
	tr.append(this.getTd('已上传'));
	return tr;
};
FlowUploader.prototype.getOperateTd = function(isNew, attachName, id, processDefineid) {
	var td = $("<td></td>");
	var downloadA = $("<a href='javascript:void(0);'><i class='glyphicon glyphicon-download-alt'></i></a>");
	var deleteA = $("<a href='javascript:void(0);'><i class='glyphicon glyphicon-remove'></i></a>");
	if (isNew) {
		deleteA.on("click", function(){
			_flowUploader_removeFile(true, id);
		});
		td.append(deleteA);
	} else {
		if(flowUtils.notNull(processDefineid) || this.flowEditor.flowModel.userIdentityKey != "6"){
			downloadA.on("click", function(){
				_flowUploader_downloadFile(id);
			});
			td.append(downloadA);
		}else{
			downloadA.on("click", function(){
				_flowUploader_downloadFile(id);
			});
			td.append(downloadA);
			td.append("&nbsp;&nbsp;");
			deleteA.on("click", function(){
				_flowUploader_removeFile(false, id);
			});
			td.append(deleteA);
		}
	}
	return td;
};
FlowUploader.prototype.getTdSecretLevel = function() {
	var tempSecretLevelList = this.flowEditor.defaultForm.filterSecretLevel(flowUtils.clone(this.secretLevelList));
	var td = $("<td></td>");
	var select = $("<select></select>")
	select.attr("name", "secretLevel");
	$.each(tempSecretLevelList, function(i, secretLevel) {
		var option = $("<option></option>");
		option.attr("value", secretLevel.lookupCode);
		option.html(secretLevel.lookupName);
		select.append(option);
	});
	td.append(select);
	return td;
};
FlowUploader.prototype.getTd = function(s) {
	var td = $("<td></td>");
	td.html(s);
	return td;
};
// 暴漏为全局属性
var _flowUploader_uploader = null;
function _flowUploader_removeFile(isNew, id) {
	if (isNew) {
		_flowUploader_uploader.removeFile(_flowUploader_uploader.getFile(id));
		$("#" + id).remove();
	} else {
		flowUtils.confirm("确定删除？", function(){
			avicAjax.ajax({
				type : "POST",
				data : {
					id : id
				},
				url : "platform/bpm/business/deleteBpmFiles",
				dataType : "JSON",
				success : function(data) {
					if (flowUtils.notNull(data.error)) {
						flowUtils.error(data.error);
					} else {
						$("#" + id).remove();
					}
				}
			});
		});
	}
};
function _flowUploader_downloadFile(id) {
	var url = "platform/bpm/business/doDownload?id=" + id;
	var t = new FlowDownLoad4URL('iframe', 'form', null, url);
	t.downLoad();
};