function BpmDocUploader(option) {
	// html模板id
	this.tplId = option.id;
	// 流程设计器模板id
	this.defineId = option.defineId;
	// 节点标识， global:全局节点   
	this.activityName = option.activityName;
	
	// 该id用于追加上传文档模板
	this.uploaderId = option.uploaderId || "bpm-designer-upload";
	
	this.$parent = $("#"+this.tplId);
	// 文档的tbody的id
	this.filesDiv = option.filesDiv || "bpm_files_div";
	// 文档添加的id
	this.filesAddId = option.filesAddId || "bpm_files_add";
	// 文档上传的id
	this.filesUploadId = option.filesUploadId || "bpm_files_upload";
	// 密级
	this.secretLevelList = [];
	this.initTpl.call(this, this.uploaderId);
	this.init.call(this);
	return this;
}
BpmDocUploader.prototype.saveType = "DataBase"; //Fastfds
BpmDocUploader.prototype.initTpl = function(uploaderId) {
	$("#"+this.tplId).find("#"+uploaderId).html(
	'<div class="form-group">'
		+'<div class="col-xs-6 " id="bpm_files_add">选择文件</div>'
		+ '<div class="col-xs-6">'
		+ '<button type="button" id="bpm_files_upload" class="btn btn-default form-tool-btn btn-sm">开始上传</button>'
		+ '</div>'
		+ '</div>'
	  // <div class="form-group">
   //              <label for="cao_zuo_ren" class="col-xs-3 control-label form-process-properties-label">上传状态:</label>
   //              <div class="col-xs-8 clear-left-right-padding" id="bpm-upload-state">
   //                   <p class="form-control-static"></p>
   //                   <div class="progress">
			// 			  <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
			// 			    60%
			// 			  </div>
			// 			</div> 
   //              </div>
   //  </div> 
		+ '<table class="table table-hover table-bordered table-fix bpm-table" >'
		+	'<thead>	'
		+	'<tr>'
		+		'	<td>名称</td>'
		+		'	<td>密级</td>'
		+			'<td style="width:20%">状态</td>'
		+			'<td style="width:20%">操作</td>'
		+		'</tr>'
		+	'</thead>'
		+	'<tbody id="bpm_files_div">'
		+	'</tbody>'
		+	'</table>'
	);
}

BpmDocUploader.prototype.init = function() {
	var _self = this;
	$.ajax({
		type : "POST",
		data : {
			filter : "false"
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
		pick : {id : $('#' +this.tplId + ' #' +this.filesAddId).get(0),
			innerHTML : "上传文档"
		},
		// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		resize : false,
		fileSingleSizeLimit: 10*1024*1024
	});
	
	this.uploader.on('ready', function() {
			_self.refresh();
	});
	
	// 当有文件被添加进队列前执行。判断是否符合条件，否则返回false阻止
	this.uploader.on('beforeFileQueued', function(file) {
		if (flowUtils.notNull(_self.tplId)) {
			return true;
		} else {
			flowUtils.error("上传id不能为空");
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
		var fileDIV = _self.$parent.find('#' + file.id);
		var secretLevel = fileDIV.find('select[name="secretLevel"]');
		// / 修改data可以控制发送哪些携带数据。
		data.secretLevel = secretLevel.val();
		data.defineId = _self.defineId;
		data.activityName = _self.activityName;
		data.saveType = _self.saveType;
	});
	// 文件上传过程中创建进度条实时显示。
	this.uploader.on('uploadProgress', function(file, percentage) {
		var $tr = _self.$parent.find('#' + file.id);
		$tr.find("td:nth-child(3)").html('正在上传');
	});

	// 文件上传成功
	this.uploader.on('uploadSuccess', function(file, response) {
		if (flowUtils.notNull(response.error)) {
			flowUtils.error(response.error);
			var $tr = _self.$parent.find('#' + file.id);
			$tr.find("td:nth-child(3)").html('上传失败');
		} else {
			var $tr = _self.$parent.find('#' + file.id);
			$tr.find("td:nth-child(3)").html('上传成功');
			_self.uploader.removeFile(file);
			setTimeout(function() {
				$tr.replaceWith(_self.getTr(response.bpmFiles));
			}, 2000);
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
	_self.$parent.find("#" + this.filesUploadId).on("click", function() {
		if(_self.uploader.getFiles().length <= 0) {
			flowUtils.error("请先选择需要上传的文件");
		}
		_self.uploader.upload();
	});
	
}

BpmDocUploader.prototype.refresh = function() {
	var _self = this;
	$.ajax({
		type : "POST",
		data : {
			defineId : _self.defineId,
			activityName : _self.activityName
		},
		url : "platform/bpm/business/designer/getBpmFiles",
		dataType : "JSON",
		success : function(data) {
			if (flowUtils.notNull(data.error)) {
				flowUtils.error(data.error);
			} else {
				_self.$parent.find("#" + _self.filesDiv).empty();
				$.each(data.result, function(i, n) {
					_self.$parent.find("#" + _self.filesDiv).append(_self.getTr(n));
				});
			}
		}
	});
}

BpmDocUploader.prototype.addFile = function(file) {
	var _self = this;
	var tr = $("<tr></tr>");
	tr.attr("id", file.id);
	var td0 = $("<td></td>");
	td0.html(file.name);
	var td1 = $("<td></td>");
	var select = $("<select class='form-control'></select>");
	select.attr("name", "secretLevel");
	$.each(_self.secretLevelList, function(i, secretLevel) {
		var option = $("<option></option>");
		option.attr("value", secretLevel.lookupCode);
		option.html(secretLevel.lookupName);
		select.append(option);
	});
	td1.append(select);
/*	var td2 = $("<td></td>");
	var td3 = $("<td></td>");*/
	var td4 = $("<td>等待上传</td>");
	var td5 = $("<td></td>");
	var delBut = $("<a href='javascript:void(0)' name=''><i class='iconfont icon-delete'></i></a>");
	delBut.on("click", function() {
		_self.uploader.removeFile(_self.uploader.getFile(file.id));
		tr.remove();
	});
	td5.append(delBut);
	tr.append(td0);
	tr.append(td1);
/*	tr.append(td2);
	tr.append(td3);*/
	tr.append(td4);
	tr.append(td5);
	_self.$parent.find("#" + this.filesDiv).append(tr);
};


BpmDocUploader.prototype.getTr = function(bpmFile) {
	var tr = $("<tr></tr>");
	var td0 = $("<td></td>");
	var downloadA = $("<a></a>");
	downloadA.html(bpmFile.attachName);
	downloadA.attr("href", "platform/bpm/business/doDownload?id=" + bpmFile.id);
	td0.append(downloadA);
	var td1 = $("<td></td>");
	td1.html(bpmFile.secretLevelString);
/*	var td2 = $("<td></td>");
	td2.html(bpmFile.createdByString);
	var td3 = $("<td></td>");
	td3.html(bpmFile.creationDateString);*/
	var td4 = $("<td>已上传</td>");
	var delBut = $("<a href='javascript:void(0)' name=''><i class='iconfont icon-delete'></i></a>");
	delBut.on("click", function() {
		$.ajax({
			type : "POST",
			data : {
				id : bpmFile.id
			},
			url : "platform/bpm/business/deleteBpmFiles?isDesigner=1",
			dataType : "JSON",
			success : function(data) {
				if (flowUtils.notNull(data.error)) {
					flowUtils.error(data.error);
				} else {
					tr.remove();
				}
			}
		});
	});
	var td5 = $("<td></td>");
	td5.append(delBut);
	tr.append(td0);
	tr.append(td1);
	/*tr.append(td2);
	tr.append(td3);*/
	tr.append(td4);
	tr.append(td5);
	return tr;
};