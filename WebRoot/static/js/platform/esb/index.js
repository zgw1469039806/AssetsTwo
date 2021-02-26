$(function() {
	$.messager.defaults.ok = "确定";
	$.messager.defaults.cancel = "取消";
	//初始化主页面tab
	$("#mainTab").tabs({
		fit : true,
		border : false,
		onBeforeClose : function(title, index) {
//			var target = this;
//			$.messager.confirm('对话框', '确定关闭吗？', function(r) {
//				if (r) {
//					var opts = $(target).tabs('options');
//					var bc = opts.onBeforeClose;
//					opts.onBeforeClose = function() {};
//					$(target).tabs('close', index);
//					opts.onBeforeClose = bc;
//				}
//			});
//			return false;
		}
	});
	//禁止目录树双击时选中文字
	$('#catalogTree').parent().get(0).onselectstart=function(){return false;}
	
	//初始化目录树
	$('#catalogTree').tree({
	    url : _controlPath + 'getEsbFlowListByProjectId.json',
	    animate : true,
	    onContextMenu: function(e, node){
			e.preventDefault();
			$('#catalogTree').tree('select', node.target);
			var menuId;
			if(node.attributes.type == "root"){
				menuId = "root_menu";
			}else if(node.attributes.type == "project"){
				menuId = "project_menu";
			}else if(node.attributes.type == "flow"){
				menuId = "flow_menu";
			}else if(node.attributes.type == "jar"){
				menuId = "jar_menu";
			}else if(node.attributes.type == "src"){
				menuId = "src_menu";
			}else if(node.attributes.type == "flowNode"){
				menuId = "flow_package_menu";
			}else if(node.attributes.type == "jarNode"){
				menuId = "jar_package_menu";
			}else if(node.attributes.type == "srcNode"){
				menuId = "src_package_menu";
			}
			if($.notNull(menuId)){
				$('#' + menuId).menu('show', {
					left: e.pageX,
					top: e.pageY
				});
			}
		},
		onDblClick : function(node) {
			if (node.attributes.type == "flow") {
				toolBar.openEsbFlow();
			}
		}
	});  

});

/**
 * 工具
 */
function ToolBar() {
};
/**
 * 关闭所有
 */
ToolBar.prototype.closeAll = function() {
	var tabs = $('#mainTab').tabs('tabs');
	if (tabs.length > 0) {
		$.messager.confirm('关闭所有服务', '确定关闭所有服务吗？', function(r) {
			if (r) {
				var opts = $('#mainTab').tabs('options');
				var bc = opts.onBeforeClose;
				opts.onBeforeClose = function() {};
				for(var i = tabs.length - 1; i >=0; i--){
					$('#mainTab').tabs('close', i);
				}
				opts.onBeforeClose = bc;
			}
		});
	} else {
		easyHelp.showMsg('没有打开的窗口！');
	}
};
/**
 * 刷新
 */
ToolBar.prototype.reloadTree = function() {
	var root = $('#catalogTree').tree("getRoot");
	$('#catalogTree').tree("reload", root.target);
};
/**
 * 新建工程
 */
ToolBar.prototype.newEsbProject = function() {
	var data = $('#catalogTree').tree('getSelected');
	$('#prompt').window({
		title:"新建工程"
	});
	$('#promptMsg').html("<span style='color:red'>*</span>请输入名称（英文、数字和下划线）:");
	$("#promptValue").val("");
	$("#prompt").window("open");
	this.prompt = function(){
		var r = $("#promptValue").val();
		if ($.notNull(r)) {
			if(!r.isEn()){
				easyHelp.showMsg("名称只能使用英文、数字和下划线");
				return;
			}
			$.ajax({
				type : "POST",
				data : {
					name : r
				},
				url : _controlPath + "addEsbProject",
				dataType : "json",
				success : function(result) {
					$("#prompt").window('close');
					easyHelp.showResultMsg(result, '保存成功！', function() {
						$('#catalogTree').tree('append', {
							parent : data.target,
							data : result.node
						});
					});
				}
			});
		}else{
			easyHelp.showMsg("工程名字不能为空");
		}
	};
};
/**
 * 修改工程名称
 */
ToolBar.prototype.reNameEsbProject = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;
	$.messager.prompt('重命名工程', '<span style="color:red">注意：服务名称保存后不可更改！</span><br/>请输入新的工程名（英文、数字和下划线）:', function(r) {
		if ($.notNull(r)) {
			if(!r.isEn()){
				easyHelp.showMsg("名称只能使用英文、数字和下划线");
				return;
			}
			$.ajax({
				type : "POST",
				data : {
					name : r,
					id : id
				},
				url : _controlPath + "reNameEsbProject",
				dataType : "json",
				success : function(result) {
					easyHelp.showResultMsg(result, '修改成功！', function() {
						$('#catalogTree').tree('update', {
							target : data.target,
							text : r
						});
						//toolBar.refreshTitleByProjectId(id);//刷新页签显示名，页面有问题，不处理
						//或者是关闭已经打开的页签
					});
				}
			});
		}else{
			if (typeof(r) != "undefined") {
				easyHelp.showMsg("工程名字不能为空");
			}
		}
	});
};
/**
 * 删除工程
 */
ToolBar.prototype.deleteEsbProject = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;
	var name = data.text;
	$.messager.confirm('删除工程', '确定删除工程【' + name + '】吗？', function(r) {
		if (r) {
			$.ajax({
				type : "POST",
				data : {
					id : id
				},
				url : _controlPath + "deleteEsbProject",
				dataType : "json",
				success : function(result) {
					easyHelp.showResultMsg(result, '删除成功！', function(){
						$('#catalogTree').tree('remove', data.target);
					});
				}
			});
			
		}
	});
};
/**
 * 新建esb文件
 * flg true:false
 */
ToolBar.prototype.newEsbFlow = function(flg) {
	var _self = this;
	var data = $('#catalogTree').tree('getSelected');
	if(flg){
		data = $('#catalogTree').tree('getParent', data.target);
	}
	var projectId = data.id;
	$('#prompt').window({
		title:"新建服务"
	});
	$('#promptMsg').html('<span style="color:red">注意：服务名称保存后不可更改！</span><br/><span style="color:red">*</span>请输入名称（英文、数字和下划线）:');
	$("#promptValue").val("");
	$("#prompt").window("open");
	this.prompt = function(){
		var r = $("#promptValue").val();
		if ($.notNull(r)) {
			if(!r.isEn()){
				easyHelp.showMsg("名称只能使用英文、数字和下划线");
				return;
			}
			$.ajax({
				type : "POST",
				data : {
					name : r,
					projectId : projectId
				},
				url : _controlPath + "addEsbFlow",
				dataType : "json",
				success : function(result) {
					$("#prompt").window('close');
					easyHelp.showResultMsg(result, '新建成功！', function() {
						$('#catalogTree').tree("reload", data.target);
						setTimeout(function() {
							var node = $('#catalogTree').tree('find', result.id);
							if($.notNull(node)){
								$('#catalogTree').tree('select', node.target);
								_self.openEsbFlow();
							}
						}, 500);
					});
				}
			});
		}else{
			easyHelp.showMsg("服务名字不能为空");
		}
	};
};
/**
 * 打开esb文件
 */
ToolBar.prototype.openEsbFlow = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;
	var name = data.text;
	var parent = $('#catalogTree').tree('getParent', data.target);
	var project = $('#catalogTree').tree('getParent', parent.target);
	var projectName = project.text;
	var title = projectName + "-" + name;
	var exists = $("#mainTab").tabs("existsById", id);
	if (!exists) {
		var url = _controlPath + 'esbPanel?id=' + id;
		var content = '<iframe scrolling="no" frameborder="0"  src="' + url + '" style="width:100%;height:99%;"></iframe>';
		$("#mainTab").tabs('add', {
			id : id,
			title : title,
			content : content,
			closable : true,
			selected : true
		});
	} else {
		$("#mainTab").tabs("selectById", id);
		easyHelp.showMsg('文件已经是打开状态！');
	}
};
/**
 * 删除esb文件
 */
ToolBar.prototype.deleteEsbFlow = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;
	var name = data.text;
	$.messager.confirm('删除', '确定删除文件【' + name + '】吗？', function(r) {
		if (r) {
			$.ajax({
				type : "POST",
				data : {
					id : id
				},
				url : _controlPath + "deleteEsbFlow",
				dataType : "json",
				success : function(result) {
					easyHelp.showResultMsg(result, '删除成功！', function(){
						$('#catalogTree').tree('remove', data.target);
						//需要关闭已经打开，却被删除的tab页签
						toolBar.closeByIds([id]);
					});
				}
			});
		}
	});
};
/**
 * 关闭指定ID的页签
 * @param ids
 */
ToolBar.prototype.closeByIds = function(ids) {
	var opts = $('#mainTab').tabs('options');
	var bc = opts.onBeforeClose;
	opts.onBeforeClose = function() {};
	for(var i = 0; i < ids.length; i++){
		var id = ids[i];
		var tab = $('#mainTab').tabs('getTabById', id);
		if($.notNull(tab)){
			var index = $('#mainTab').tabs('getTabIndex', tab);
			$('#mainTab').tabs('close', index);
		}
	}
	opts.onBeforeClose = bc;
};
/**
 * 刷新指定projectId的页签
 * @param id
 */
ToolBar.prototype.refreshTitleByProjectId = function(id) {
	$.ajax({
		type : "POST",
		data : {
			id : id
		},
		url : _controlPath + "refreshTitleByProjectId",
		dataType : "json",
		success : function(result) {
			easyHelp.showResultMsg(result, null, function(){
				var maps = result.maps;
				for(var i = 0; i < maps.length; i++){
					var id = maps[i].ID;
					var projectName = maps[i].PROJECTNAME;
					var flowName = maps[i].FLOWNAME;
					var tab = $('#mainTab').tabs('getTabById', id);
					if($.notNull(tab)){
						$('#mainTab').tabs('update', {
							tab : tab,
							options : {
								title : projectName + "-" + flowName
							}
						});
					}
				}
			});
		}
	});
};
/**
 * 保存
 */
ToolBar.prototype.saveEsbFlow = function() {
	var _self = this;
	var tab = $('#mainTab').tabs('getSelected');
	if ($.notNull(tab)) {
		var iframe = $(tab).children("iframe");
		// 调用tab窗口方法
		var flowName = iframe[0].contentWindow.myAction.getFlowName();
		var id = iframe[0].contentWindow.myAction.getFlowId();
		if (!$.notNull(flowName)) {
			easyHelp.showMsg('名称不能为空！');
			return;
		}
		if(!flowName.isEn()){
			easyHelp.showMsg("名称只能使用英文、数字和下划线");
			return;
		}
		var xml = iframe[0].contentWindow.myAction.showEsbXml();
		var graph = iframe[0].contentWindow.myAction.showGraph();
		if(!$.notNull(xml)){
			return;
		}
		
		$.messager.confirm('保存服务', "确定保存文件？", function(r) {
			if (r) {
				$.ajax({
					url : _controlPath + "saveEsbFlow",
					type : "POST",
					data : {
						graph : graph,
						xml : xml,
						name : flowName,
						id : id
					},
					datatype : "json",
					success : function(r) {
						easyHelp.showResultMsg(r, '保存成功！', function(){
							var node = $('#catalogTree').tree('find', id);
							var flowNode = $('#catalogTree').tree('getParent', node.target);
							var parent = $('#catalogTree').tree('getParent', flowNode.target);
							$('#catalogTree').tree("reload", parent.target);
							//如果改了名字，刷新当前页签的名字
						});
					}
				});
			}
		});
	} else {
		easyHelp.showMsg('没有选中的窗口！');
	}
};
/**
 * 显示graph文件
 */
ToolBar.prototype.showGraph = function() {
	var tab = $('#mainTab').tabs('getSelected');
	if ($.notNull(tab)) {
		var iframe = $(tab).children("iframe");
		//调用tab窗口方法
		var graphText = iframe[0].contentWindow.myAction.showGraph();
		var html = "<textarea readonly class='myText'></textarea>";
		$("#graphWin").html(html);
		if(easyHelp.IS_IE8){
			graphText = graphText.replaceAll("\n", "\r");
		}
		$(".myText").text(graphText);
		$('#graphWin').window('open');
	} else {
		easyHelp.showMsg('没有选中的窗口！');
	}
};
/**
 * 显示exbXml文件
 */
ToolBar.prototype.showEsbXml = function() {
	var tab = $('#mainTab').tabs('getSelected');
	if ($.notNull(tab)) {
		var iframe = $(tab).children("iframe");
		//调用tab窗口方法
		var xmlText = iframe[0].contentWindow.myAction.showEsbXml();
		var flowId = iframe[0].contentWindow.myAction.getFlowId();
		if($.notNull(xmlText)){
			$.ajax({
				type : "POST",
				data : {
					flowId : flowId,
					muleString : xmlText
				},
				url : _controlPath + "getConnectorByFlowId",
				dataType : "json",
				success : function(r) {
					easyHelp.showResultMsg(r, "", function(){
						var text = r.obj;
						var html = "<textarea readonly class='myText'></textarea>";
						$("#xmlWin").html(html);
//						if(easyHelp.IS_IE8){
//							text = text.replaceAll("\n", "\r");
//						}
						$(".myText").text(text);
						$('#xmlWin').window('open');
					});
				}
			});
		}
	} else {
		easyHelp.showMsg('没有选中的窗口！');
	}
};
/**
 * 导出到本地
 */
ToolBar.prototype.exportZip2Local = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;

	var url = _controlPath + "exportZip2Local?id=" + id;
	var t = new exportData('iframe', 'form', {}, url);
	t.excuteExport();
};
/**
 * 导出到服务端
 */
ToolBar.prototype.exportZip = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;
	
	$.messager.prompt('导出服务', '请输入导出路径:', function(r) {
		if($.notNull(r)){
			$.ajax({
				type : "POST",
				data : {
					id : id,
					path : r
				},
				url : _controlPath + "exportZip",
				dataType : "json",
				success : function(result) {
					easyHelp.showResultMsg(result, '导出成功！');
				}
			});
		}
	});
};
/**
 * 上传jar
 * flg true:false
 */
ToolBar.prototype.uploadJar = function(flg) {
	var data = $('#catalogTree').tree('getSelected');
	if(flg){
		data = $('#catalogTree').tree('getParent', data.target);
	}
	var projectId = data.id;
	$('#uploadForm').children("div").remove();
	$('#uploadForm').children("#projectId").val(projectId);
	$('#uploadForm').children("#type").val("1");
	this.addFileBox();
	$('#upload').window({
		title:"上传jar窗口"
	});
	$('#upload').window('open');
};
/**
 * 上传源码包
 * @param flg
 */
ToolBar.prototype.uploadSrc = function(flg) {
	var data = $('#catalogTree').tree('getSelected');
	if(flg){
		data = $('#catalogTree').tree('getParent', data.target);
	}
	var projectId = data.id;
	$('#uploadForm').children("div").remove();
	$('#uploadForm').children("#projectId").val(projectId);
	$('#uploadForm').children("#type").val("2");
	this.addFileBox(false);
	$('#upload').window({
		title:"上传源码包窗口"
	});
	$('#upload').window('open');
};
/**
 * 增加一个上传input
 * @param flg
 */
ToolBar.prototype.addFileBox = function(flg) {
	var div = document.createElement("div");
	$(div).css("padding-bottom", "5px");
	var input = document.createElement("input");
	$(input).css("width", "470px");
	$(input).attr("name", "jarFile");
	$(div).append($(input));
	$(div).append("&nbsp;");
	var a = document.createElement("a");
	$(a).attr("href", "javascript:void(0);");
	$(div).append($(a));
	$("#uploadForm").append($(div));
	$(input).filebox({
		buttonText : "选择"
	});
	$(a).linkbutton({
		iconCls: 'icon-add',
		plain: true
	});
	$(a).on("click", function(){
		toolBar.addFileBox(true);
	});
	if(flg){
		var b = document.createElement("a");
		$(b).attr("href", "javascript:void(0);");
		$(div).append($(b));
		$(b).linkbutton({
			iconCls: 'icon-remove',
			plain: true
		});
		$(b).on("click", function(){
			$(div).remove();
		});
	}
	$("#uploadForm").find("input[type='file']").attr("accept", ".jar");
};
/**
 * 开始上传
 */
ToolBar.prototype.upload = function() {
	var flg = "";
	var fileInput = $("#uploadForm").find("input[type='file']");
	var zhReg = /^.*[\u4e00-\u9fa5]+.*$/;
	for (var i = 0; i < fileInput.length; i++) {
		var fileName = $(fileInput[i]).val();
		if ($.notNull(fileName)) {
			fileName = fileName.replaceAll("\\", "//");
			while (fileName.indexOf("//") != -1) {
				fileName = fileName.slice(fileName.indexOf("//") + 1);
			}
			var fileNameArr = fileName.split("\.");
			var ext = fileNameArr[fileNameArr.length - 1].toLowerCase();
			if (ext != "jar") {
				easyHelp.showMsg("只能上传jar文件！");
				return;
			}
			if(zhReg.test(fileName)){
				easyHelp.showMsg("jar包名称不能含有中文！");
				return;
			}
			flg += fileName;
		}
	}
	if(flg == ""){
		easyHelp.showMsg("没有选择任何文件！");
		return;
	}
	$.messager.confirm('上传JAR包', '确认上传？', function(r) {
		if(r){
			$('#uploadForm').form('submit', {
				url: _controlPath + 'uploadFile',
				success: function(result){
					if(result){
						easyHelp.showMsg(result);
					}else{
						easyHelp.showMsg("上传完成");
						$('#upload').window('close');
						var data = $('#catalogTree').tree('getSelected');
						if(data.attributes.type != "project"){
							data = $('#catalogTree').tree('getParent', data.target);
						}
						$('#catalogTree').tree("reload", data.target);
					}
				}
			});
		}
	});
};
/**
 * 关闭页面
 */
ToolBar.prototype.dialogClose = function(id) {
	$('#' + id).window('close');
};
/**
 * 删除jar
 */
ToolBar.prototype.deleteEsbJar = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;
	var name = data.text;
	$.messager.confirm('删除JAR', '确定删除jar【' + name + '】吗？', function(r) {
		if (r) {
			$.ajax({
				type : "POST",
				data : {
					id : id
				},
				url : _controlPath + "deleteEsbJar",
				dataType : "json",
				success : function(result) {
					easyHelp.showResultMsg(result, '删除成功！', function(){
						$('#catalogTree').tree('remove', data.target);
					});
				}
			});
			
		}
	});
};
/**
 * 删除源码包
 */
ToolBar.prototype.deleteEsbSrc = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;
	var name = data.text;
	$.messager.confirm('删除源码包', '确定删除源码包【' + name + '】吗？', function(r) {
		if (r) {
			$.ajax({
				type : "POST",
				data : {
					id : id
				},
				url : _controlPath + "deleteEsbSrc",
				dataType : "json",
				success : function(result) {
					easyHelp.showResultMsg(result, '删除成功！', function(){
						$('#catalogTree').tree('remove', data.target);
					});
				}
			});
			
		}
	});
};
/**
 * 下载jar
 */
ToolBar.prototype.downEsbJar = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;
	
	var url = _controlPath + "downEsbJar?id=" + id;
	var t = new exportData('iframe', 'form', {}, url);
	t.excuteExport();
};
/**
 * 下载源码包
 */
ToolBar.prototype.downEsbSrc = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;
	
	var url = _controlPath + "downEsbSrc?id=" + id;
	var t = new exportData('iframe', 'form', {}, url);
	t.excuteExport();
};

/**
 * 部署
 */
ToolBar.prototype.deploy = function() {
	var data = $('#catalogTree').tree('getSelected');
	var id = data.id;
	var name = data.text;
	var deploy = new CommonDialog("deployEsb","700","400","platform/esbservicestatallinfo/EsbDeploymentController/EsbServerGroupinfoInfo?treeId="+id+"&treeName="+name,"ESB部署",false,false,false);
	deploy.show();
};
var toolBar = new ToolBar();