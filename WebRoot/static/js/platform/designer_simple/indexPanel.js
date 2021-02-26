var _myLayout;// 布局
var _myWins;// 窗口
var _myMenu;// 菜单
var _myShowHeader = false;// 窗口header，views no Header if false
var _myAction;// 函数
var _maxHeight;
var _openWinForFile;//文件上传窗口
var _myStore;//复制粘贴时使用，保存在变量中
$(function() {
	_maxHeight = $(document).height();
	if(_maxHeight > 500){
		_maxHeight = 500;
	}
	// 函数
	_myAction = new MyAction();
	// 布局
	_myLayout = new dhtmlXLayoutObject({
		parent : document.body,
		pattern : "1C"
	});
	_myLayout.cells("a").hideHeader();
	_myLayout.cells("a").attachObject("myWindows");
	// 窗口
	_myWins = new dhtmlXWindows();
	_myWins.attachViewportTo("myWindows");
	// 菜单
	// 扩展实现自定义流程
	if ($.notNull(_formCode)) {
		_myMenu = _myLayout.attachMenu({
			icons_path : _iconPath,
			xml : _designerPath + "config/myMenu_ext_self.xml"
		});
		_myMenu.attachEvent("onClick", function(id, zoneId, cas) {
			if (id == "save") {
				_myAction.saveAndDeployment();
			} else if (id == "showGraph") {
				_myAction.showGraph();
			} else if (id == "showProcess") {
				_myAction.showProcess();
			} else if (id == "showPng") {
				_myAction.showPng();
			} else if (id == "align-left") {
				_myAction.alignCells("left");
			} else if (id == "align-right") {
				_myAction.alignCells("right");
			} else if (id == "align-top") {
				_myAction.alignCells("top");
			} else if (id == "align-bottom") {
				_myAction.alignCells("bottom");
			} else if (id == "com-width") {
				_myAction.comWidth();
			} else if (id == "com-height") {
				_myAction.comHeight();
			} else {
				_myAction.selectView(id);
			}
		});
		$.ajax({
			type : "POST",
			data : {
				formCode : _formCode
			},
			url : _controlPath + "validFormCode",
			dataType : "json",
			success : function(r) {
				if($.notNull(r.error)){
					dhtmlxUtils.error(r.error);
				}else{
					if(r.result.length > 0){
						_myAction.openForDeployment(r.result);					
					}else{
						_myAction.newFile();
					}
				}
			}
		});
	}else{
		_myMenu = _myLayout.attachMenu({
			icons_path : _iconPath,
			xml : _designerPath + "config/myMenu.xml"
		});
		_myMenu.attachEvent("onClick", function(id, zoneId, cas) {
			if (id == "new") {
				_myAction.newFile();
			} else if (id == "open") {
				_myAction.open();
			} else if (id == "save") {
				_myAction.save();
			} else if (id == "showHeader") {
				_myAction.showHeader();
			} else if (id == "hideHeader") {
				_myAction.hideHeader();
			} else if (id == "closeAll") {
				_myAction.closeAll();
			} else if (id == "showGraph") {
				_myAction.showGraph();
			} else if (id == "showProcess") {
				_myAction.showProcess();
			} else if (id == "showPng") {
				_myAction.showPng();
			} else if (id == "close") {
				_myAction.close();
			} else if (id == "align-left") {
				_myAction.alignCells("left");
			} else if (id == "align-right") {
				_myAction.alignCells("right");
			} else if (id == "align-top") {
				_myAction.alignCells("top");
			} else if (id == "align-bottom") {
				_myAction.alignCells("bottom");
			} else if (id == "com-width") {
				_myAction.comWidth();
			} else if (id == "com-height") {
				_myAction.comHeight();
			} else {
				_myAction.selectView(id);
			}
		});
	}
	if(mxClient.IS_IE8){
		dhtmlxUtils.message("设计器对IE8支持程度有限，如条件允许，请使用IE8以上版本或使用chrome、firefox！");
	}
});
/**
 * 定义函数
 */
function MyAction() {
};
/**
 * 新建按钮功能
 */
MyAction.prototype.newFile = function() {
	$.ajax({
		type : "GET",
		url : _controlPath + "getId",
		dataType : "json",
		success : function(r) {
			var id = r.result;
			var newWin = _myAction.createWin(id, "新建流程", "");
			newWin.attachURL(_controlPath + "frameSimple.html?id=" + id);
		}
	});
};
/**
 * 打开按钮功能
 */
MyAction.prototype.open = function() {
	var openWin = dhtmlxUtils.createModalWin("open", "流程选择", 420, _maxHeight - 100);
	// 流程树
	var tree = openWin.attachTree();
	tree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
	$.ajax({
		type : "GET",
		url : _controlPath + "getAllProcessDefList",
		dataType : "json",
		success : function(node) {
			var treeXml = ComUtils.createElement("tree");
			treeXml.setAttribute("id", "0");
			_myAction.addCatalog(treeXml, node);
			tree.loadXMLString(ComUtils.getPrettyXml(treeXml));
		}
	});
	tree.attachEvent("onClick", function(id) {
		var type = tree.getUserData(id, "type");
		if ($.notNull(type)) {
			type = $.trim(type);
			toolbar.enableItem("open");
			toolbar.enableItem("exportXml");
			toolbar.enableItem("importXml");
			if (type == 1) {
				toolbar.enableItem("delete");
			} else {
				toolbar.disableItem("delete");
			}
			toolbar.setItemText("importXml", "导入覆盖");
			toolbar.enableItem("copyXml");
			toolbar.disableItem("pasteXml");
		} else {
			toolbar.disableItem("delete");
			toolbar.disableItem("open");
			toolbar.disableItem("exportXml");
			toolbar.enableItem("importXml");
			toolbar.setItemText("importXml", "导入新增");
			toolbar.disableItem("copyXml");
			if($.notNull(_myStore)){
				toolbar.enableItem("pasteXml");
			}else{
				toolbar.disableItem("pasteXml");
			}
		}
	});
	tree.attachEvent("onDblClick", function(id) {
		var type = tree.getUserData(id, "type");
		if ($.notNull(type)) {
			_myAction.loadFile(tree, id, id);
			openWin.close();
		}
	});
	// 功能按钮
	var toolbar = openWin.attachToolbar({
		icons_path : _iconPath,
		items : [ {
			id : "open",
			type : "button",
			text : "打开",
			img : "open.gif",
			img_disabled : "open_dis.gif",
			disabled : "true"
		}, {
			id : "delete",
			type : "button",
			text : "删除",
			img : "delete.gif",
			img_disabled : "delete_dis.gif",
			disabled : "true"
		} , {
			id : "exportXml",
			type : "button",
			text : "导出",
			img : "paste.gif",
			img_disabled : "paste_dis.gif",
			disabled : "true"
		} , {
			id : "importXml",
			type : "button",
			text : "导入",
			img : "page_setup.gif",
			img_disabled : "page_setup_dis.gif",
			disabled : "true"
		} , {
			id : "copyXml",
			type : "button",
			text : "复制",
			img : "paste.gif",
			img_disabled : "paste_dis.gif",
			disabled : "true"
		}  , {
			id : "pasteXml",
			type : "button",
			text : "粘贴",
			img : "page_setup.gif",
			img_disabled : "page_setup_dis.gif",
			disabled : "true"
		} ]
	});
	toolbar.attachEvent("onClick", function(id) {
		var nodeId = tree.getSelectedItemId();
		if (id == "open") {
			_myAction.loadFile(tree, nodeId, nodeId);
			openWin.close();
		} else if (id == "delete") {
			var key = $.trim(tree.getUserData(nodeId, "key"));
			dhtmlx.confirm({
				title : "删除流程模板",
				text : "确定删除吗？",
				callback : function(result) {
					if (result) {
						_myAction.deleteFile(tree, nodeId);
					}
				}
			});
		}else if (id == "exportXml") {
			var type = $.trim(tree.getUserData(nodeId, "type"));
			var nodeName = $.trim(tree.getSelectedItemText());
			dhtmlx.confirm({
				title : "导出流程模板",
				text : "<span style='color:red;font-weight:bold;'>推荐导出jpdlx格式。</span><br/>为兼容低版本平台，保留导出原（jpdl）格式的功能。<br/>导出的新（jpdlx）格式比原格式增加了流程图的数据流内容，导入时不需要再手动保存流程图。",
				ok:"jpdlx格式(新)",
				cancel:"jpdl格式(旧)",
				callback : function(result) {
					if (result) {
						var url = _controlPath + "downJpdl?id=" + nodeId + "&type=" + type + "&name=" + nodeName + "&extName=jpdlx";
						var t = new exportData('iframe', 'form', {}, url);
						t.excuteExport();
					}else{
						var url = _controlPath + "downJpdl?id=" + nodeId + "&type=" + type + "&name=" + nodeName + "&extName=jpdl";
						var t = new exportData('iframe', 'form', {}, url);
						t.excuteExport();
					}
				}
			});
		}else if (id == "importXml") {
			//导入数据分为导入新增的数据和导入覆盖现有的数据，只导入jpdl文件，流程图需要导入成功后手动打开再保持一下。
			//导入时会验证key和name，保证一一对应。导入新增数据时，如果已经有发布数据，则默认挂在同意目录下。
			var type = $.trim(tree.getUserData(nodeId, "type"));
//			$("#uploadForm").off("change");
//			$("#jpdl").val("");
//			$("#jpdlId").val(nodeId);
//			if ($.notNull(type)) {//type不为空说明点击的是流程节点，表示覆盖
//				$("#jpdlType").val(type);
//			} else {//type为空标识点击的是目录节点，标识导入新增数据
//				$("#jpdlType").val("");
//			}
			if (!$.notNull(type)) {//type不为空说明点击的是流程节点，表示覆盖
				type = "";
			} 
			_openWinForFile = dhtmlxUtils.createModalWin("open", "流程文件选择", 400, _maxHeight - 300);
			_openWinForFile.attachURL(_basePath+"avicit/platform6/bpmdesigner_simple/upload.jsp", true,{jpdlId:nodeId,type:type});
//			$("#jpdl").click();
//			$("#uploadForm").on("change", function(){
//				var fileInput = $("#uploadForm").find("#jpdl");
//				for (var i = 0; i < fileInput.length; i++) {
//					var fileName = $(fileInput[i]).val();
//					if ($.notNull(fileName)) {
//						fileName = fileName.replaceAll("\\", "//");
//						while (fileName.indexOf("//") != -1) {
//							fileName = fileName.slice(fileName.indexOf("//") + 1);
//						}
//						var fileNameArr = fileName.split("\.");
//						var ext = fileNameArr[fileNameArr.length - 1].toLowerCase();
//						if (ext != "jpdl") {
//							dhtmlxUtils.error("只能导入jpdl文件！");
//							return;
//						}
//					}
//				}
//				dhtmlx.confirm({
//					title : "导入",
//					text : "请慎重操作，确定导入吗？",
//					callback : function(result) {
//						if (result) {
//							$('#uploadForm').form('submit', {
//								url: _controlPath + 'uploadFile',
//								success: function(result){
//									if ($.notNull(result)) {
//										dhtmlxUtils.error(result);
//									} else {
//										dhtmlxUtils.message("导入成功!流程图更新需要打开后重新保存一下！");
//									}
//								}
//							});
//						}
//					}
//				});
//			});
		}else if(id == "copyXml"){
			var type = $.trim(tree.getUserData(nodeId, "type"));
			$.ajax({
				type : "POST",
				data : {
					id : nodeId,
					type : type
				},
				url : _controlPath + "copyXml",
				dataType : "json",
				success : function(r) {
					if($.notNull(r.error)){
						dhtmlxUtils.error(r.error);
					}else{
						_myStore = r.result;
						dhtmlxUtils.message("复制成功！");
					}
				}
			});
		}else if(id == "pasteXml"){
			$.ajax({
				type : "POST",
				data : {
					id : nodeId,
					str : _myStore
				},
				url : _controlPath + "pasteXml",
				dataType : "json",
				success : function(r) {
					if($.notNull(r.error)){
						dhtmlxUtils.error(r.error);
					}else{
						tree.insertNewItem(nodeId, r.newKey, r.newName, null, 'start_event_empty.png','start_event_empty.png','start_event_empty.png');
						tree.setUserData(r.newKey, "type", "1");
						tree.setUserData(r.newKey, "key", r.newKey);
						tree.setUserData(r.newKey, "versiontext", "");
						dhtmlxUtils.message("粘贴成功！");
					}
				}
			});
		}
	});
};
/**
 * 执行打开流程的功能
 * 
 * @param id
 *            流程ID
 * @param text
 *            流程标题
 */
MyAction.prototype.loadFile = function(tree, id) {
	if (_myWins.isWindow(id)) {
		_myAction.selectView(id);
		dhtmlxUtils.message("该流程已经是打开的！");
		return;
	}
	var nodeText = tree.getSelectedItemText();
	var type = $.trim(tree.getUserData(id, "type"));
	var versiontext = tree.getUserData(id, "versiontext");
	if ($.notNull(versiontext)) {
		versiontext = " " + $.trim(versiontext);
	} else {
		versiontext = "";
	}
	var newWin = _myAction.createWin(id, nodeText, versiontext);
	newWin.attachURL(_controlPath + "frameSimple.html?id=" + id + "&type=" + type);
};
/**
 * 执行删除流程的功能
 * 
 * @param id
 *            流程ID
 */
MyAction.prototype.deleteFile = function(tree, nodeId) {
	var key = $.trim(tree.getUserData(nodeId, "key"));
	$.ajax({
		url : _controlPath + "deleteByKey",
		type : "POST",
		data : {
			key : key
		},
		datatype : "json",
		success : function(r) {
			if ($.notNull(r.error)) {
				dhtmlxUtils.error(r.error);
			} else {
				dhtmlxUtils.message(r.msg);
				tree.deleteItem(nodeId, true);
			}
		}
	});
};
/**
 * 保存按钮功能 首先获取当前窗口，调用窗口中对应的方法获取返回值
 */
MyAction.prototype.save = function() {
	var win = _myWins.getTopmostWindow(true);
	if ($.notNull(win)) {
		var _id = win.getFrame().contentWindow._id;
		var _processKey = win.getFrame().contentWindow._processKey;
		var flowName = win.getFrame().contentWindow._myAction.getFlowName();
		if (!$.notNull(flowName)) {
			dhtmlxUtils.alter("流程名称不能为空！");
			return;
		}

		//保存时没有选开始、结束节点提示 by xb
        var allCell = win.getFrame().contentWindow._myCellMap.values();
        var existStartNode = false;
        var existEndNode = false;
        for (var i in allCell) {
            var theCell = allCell[i];
            if(theCell.tagName != "task") {
                continue;
            }

            if (win.getFrame().contentWindow.$("#" + theCell.id).find("#task_type_start").prop("checked") == true) {
                existStartNode = true;
            }
            if (win.getFrame().contentWindow.$("#" + theCell.id).find("#task_type_end").prop("checked") == true) {
                existEndNode = true;
            }
        }
        if(existStartNode == false) {
            dhtmlxUtils.alter("请选择开始节点！");
            return;
		}
        if(existEndNode == false) {
            dhtmlxUtils.alter("请选择结束节点！");
            return;
        }

		var flg = "0";// 局部变量，0表示新建流程，1表示未发布的流程，2表示以及发布的流程
		var type = "1";// 像后台传递，1表示写入未发布表，2表示更新已发布表
		$.ajax({
			url : _controlPath + "validByIdAndKey",
			type : "POST",
			data : {
				id : _id,
				key : _processKey
			},
			datatype : "json",
			async : false,
			success : function(r) {
				if ($.notNull(r.error)) {
					dhtmlxUtils.error(r.error);
					flg = null;
				} else {
					flg = r.result;
				}
			}
		});
		if (!$.notNull(flg)) {
			return false;
		} else if (flg == "2") {
			var lobWin = dhtmlxUtils.createModalWin("lobWin", "保存方式选择", 200,
					150);
			lobWin.denyResize();
			var formData = [ {
				type : "block",
				inputWidth : "auto",
				offsetTop : 12,
				list : [ {
					type : "radio",
					name : "lobWin",
					value : "2",
					label : "覆盖原设计",
					labelWidth : "auto",
					position : "label-right",
					checked : true
				}, {
					type : "radio",
					name : "lobWin",
					value : "1",
					label : "存为未发布模板",
					labelWidth : "auto",
					position : "label-right",
					checked : false
				} ]
			} ];
			var myForm = lobWin.attachForm(formData);
			// 功能按钮
			var toolbar = lobWin.attachToolbar({
				icons_path : _iconPath,
				items : [ {
					id : "save",
					type : "button",
					text : "保存",
					img : "save.gif",
					img_disabled : "save_dis.gif"
				} ]
			});
			toolbar.attachEvent("onClick", function(id) {
				if (id == "save") {
					type = myForm.getCheckedValue("lobWin");
					_myAction.save_xml(win, null, type, type == 2 ? true
							: false);
					lobWin.close();
				}
			});
			return true;
		} else if (flg == "1") {
			dhtmlx.confirm({
				title : "保存",
				text : "将存为未发布模板，确定保存吗？",
				callback : function(result) {
					if (result) {
						_myAction.save_xml(win, null, type, true);
					}
				}
			});
			return true;
		}
		var openWin = dhtmlxUtils.createModalWin("save", "流程目录选择", 300, _maxHeight - 100);
		// 流程树
		var tree = openWin.attachTree();
		tree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		$.ajax({
			type : "GET",
			url : _controlPath + "getAllBpmCatalogList",
			dataType : "json",
			success : function(node) {
				var treeXml = ComUtils.createElement("tree");
				treeXml.setAttribute("id", "0");
				_myAction.addCatalog(treeXml, node);
				tree.loadXMLString(ComUtils.getPrettyXml(treeXml));
			}
		});
		// 功能按钮
		var toolbar = openWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "save",
				type : "button",
				text : "保存",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		toolbar.attachEvent("onClick", function(id) {
			var nodeId = tree.getSelectedItemId();
			if (id == "save" && $.notNull(nodeId)) {
				_myAction.save_xml(win, nodeId, type, true);
				openWin.close();
			}
		});
	} else {
		dhtmlxUtils.message("没有打开或选择的流程！");
	}
};
/**
 * 使所选视图置顶
 * 
 * @param id
 *            视图ID
 */
MyAction.prototype.selectView = function(id) {
	if ($.notNull(id) && _myWins.isWindow(id)) {
		_myWins.window(id).show();
		_myWins.window(id).bringToTop();
	}
};
/**
 * 显示视图header,可以使用关闭隐藏等按钮
 */
MyAction.prototype.showHeader = function() {
	_myShowHeader = true;
	_myWins.forEachWindow(function(win) {
		if (win.isHidden()) {
			// 窗口在隐藏状态下显示或隐藏header,会导致界面显示异常
			win.show();
			win.showHeader();
			win.hide();
		} else {
			win.showHeader();
		}
	});
};
/**
 * 隐藏视图header,尽量视图最大化
 */
MyAction.prototype.hideHeader = function() {
	_myShowHeader = false;
	_myWins.forEachWindow(function(win) {
		if (win.isHidden()) {
			// 窗口在隐藏状态下显示或隐藏header,会导致界面显示异常
			win.show();
			win.hideHeader();
			win.hide();
		} else {
			win.hideHeader();
		}
	});
};
/**
 * 关闭所有视图
 */
MyAction.prototype.closeAll = function() {
	var win = _myWins.getTopmostWindow(true);
	if ($.notNull(win)) {
		dhtmlx.confirm({
			title : "关闭所有窗口",
			text : "确定关闭所有窗口吗？",
			callback : function(result) {
				if (result) {
					_myWins.forEachWindow(function(fWin) {
						fWin.close();
					});
				}
			}
		});
	} else {
		dhtmlxUtils.message("没有打开或选择的流程！");
	}
};
/**
 * 显示graph文件 首先获取当前窗口，调用窗口中对应的方法获取返回值 创建显示窗口显示返回值
 */
MyAction.prototype.showGraph = function() {
	var win = _myWins.getTopmostWindow(true);
	if ($.notNull(win)) {
		// 调用窗口中对应方法
		var xmlText = win.getFrame().contentWindow._myAction.showGraph();
		var graphWin = dhtmlxUtils.createModalWin("graphWin", "GraphXml", 500,
				_maxHeight);
		var html = "<textarea readonly class='showWin'>";
		html += xmlText;
		html += "</textarea>";
		graphWin.attachHTMLString(html);
	} else {
		dhtmlxUtils.message("没有打开或选择的流程！");
	}
};
/**
 * 显示流程文件 首先获取当前窗口，调用窗口中对应的方法获取返回值 创建显示窗口显示返回值
 */
MyAction.prototype.showProcess = function() {
	var win = _myWins.getTopmostWindow(true);
	if ($.notNull(win)) {
		var xmlText = win.getFrame().contentWindow._myAction.showProcess();
		var processhWin = dhtmlxUtils.createModalWin("processhWin",
				"ProcessXml", 500, _maxHeight);
		var html = "<textarea readonly class='showWin'>";
		html += xmlText;
		html += "</textarea>";
		processhWin.attachHTMLString(html);
	} else {
		dhtmlxUtils.message("没有打开或选择的流程！");
	}
};
/**
 * 显示流程图 首先获取当前窗口，调用窗口中对应的方法
 */
MyAction.prototype.showPng = function() {
	var win = _myWins.getTopmostWindow(true);
	if ($.notNull(win)) {
		win.getFrame().contentWindow._myAction.showPng();
	} else {
		dhtmlxUtils.message("没有打开或选择的流程！");
	}
};
/**
 * 删除graph中选中的节点 首先获取当前窗口，调用窗口中对应的方法
 */
MyAction.prototype.close = function() {
	var win = _myWins.getTopmostWindow(true);
	if ($.notNull(win)) {
		dhtmlx.confirm({
			title : "关闭窗口",
			text : "确定关闭当前窗口吗？",
			callback : function(result) {
				if (result) {
					win.close();
				}
			}
		});
	} else {
		dhtmlxUtils.message("没有打开或选择的流程！");
	}
};
/**
 * 对齐
 * @param align
 */
MyAction.prototype.alignCells = function(align) {
	var win = _myWins.getTopmostWindow(true);
	if ($.notNull(win)) {
		win.getFrame().contentWindow._myAction.alignCells(align);
	} else {
		dhtmlxUtils.message("没有打开或选择的流程！");
	}
};
/**
 * 等宽
 */
MyAction.prototype.comWidth = function() {
	var win = _myWins.getTopmostWindow(true);
	if ($.notNull(win)) {
		win.getFrame().contentWindow._myAction.comWidth();
	} else {
		dhtmlxUtils.message("没有打开或选择的流程！");
	}
};
/**
 * 等高
 */
MyAction.prototype.comHeight = function() {
	var win = _myWins.getTopmostWindow(true);
	if ($.notNull(win)) {
		win.getFrame().contentWindow._myAction.comHeight();
	} else {
		dhtmlxUtils.message("没有打开或选择的流程！");
	}
};
/**
 * 创建一个新视图
 * 
 * @param id
 *            视图ID
 * @param text
 *            视图标题
 * @returns
 */
MyAction.prototype.createWin = function(id, text, versiontext) {
	var newWin = _myWins.createWindow(id, 0, 0, 0, 0);
	newWin.setText(text);
	newWin.keepInViewport(true);// 使视图不超过区域
	newWin.maximize();// 最大化
	newWin.denyMove();// 禁用移动
	newWin.denyResize();// 禁用改变大小
	newWin.button("minmax").hide();// 隐藏最大还原按钮
	// 是否显示header
	if (!_myShowHeader) {
		newWin.hideHeader();
	}
	// 更改最小化按钮功能为隐藏视图
	newWin.button("park").attachEvent("onClick", function(win) {
		win.hide();
	});
	// 重写关闭按钮点击事件
	newWin.button("close").attachEvent("onClick", function(win) {
		dhtmlxUtils.closeWin("_myWins", win);
	});
	// 添加onClose事件，删除菜单栏对应的视图按钮，返回true不阻止后续事件
	newWin.attachEvent("onClose", function(win) {
		if(dhtmlxUtils.hasMenuItemId(_myMenu)){
			_myMenu.removeItem(win.getId());
		}
		return true;
	});
	// 往菜单栏添加相应视图按钮
	if(dhtmlxUtils.hasMenuItemId(_myMenu)){
		_myMenu.addNewChild("view", null, id, text, false, "page.gif", "page.gif");
		_myMenu.setUserData(id, "versiontext", versiontext);
	}
	return newWin
};
/**
 * 目录树
 * 
 * @param tree
 */
MyAction.prototype.addCatalog = function(parentXml, node) {
	for (var i = 0; i < node.length; i++) {
		var nodeXml = ComUtils.createElement("item");
		nodeXml.setAttribute("id", node[i].id);
		nodeXml.setAttribute("text", node[i].bpmCatalogName);
		nodeXml.setAttribute("open", "1");
		nodeXml.setAttribute("im0", "folderClosed.gif");
		nodeXml.setAttribute("im1", "folderClosed.gif");
		nodeXml.setAttribute("im2", "folderOpen.gif");
		_myAction.addProcess(nodeXml, node[i].flowDefineModelList);
		_myAction.addCatalog(nodeXml, node[i].bpmCatalogList);
		parentXml.appendChild(nodeXml);
	}
};
/**
 * 流程树
 * 
 * @param tree
 */
MyAction.prototype.addProcess = function(parentXml, node) {
	for (var i = 0; i < node.length; i++) {
		var nodeXml = ComUtils.createElement("item");
		nodeXml.setAttribute("id", node[i].id);
		nodeXml.setAttribute("text", node[i].displayName);
		if (node[i].type == "1") {// 未发布
			nodeXml.setAttribute("im0", "start_event_empty.png");
			nodeXml.setAttribute("im1", "start_event_empty.png");
			nodeXml.setAttribute("im2", "start_event_empty.png");
		} else {
			nodeXml.setAttribute("im0", "end_event_terminate.png");
			nodeXml.setAttribute("im1", "end_event_terminate.png");
			nodeXml.setAttribute("im2", "end_event_terminate.png");
		}
		var userdata_type = ComUtils.createElement("userdata");
		userdata_type.setAttribute("name", "type");
		userdata_type.appendChild(ComUtils.createTextNode(node[i].type));
		nodeXml.appendChild(userdata_type);

		var userdata_key = ComUtils.createElement("userdata");
		userdata_key.setAttribute("name", "key");
		userdata_key.appendChild(ComUtils.createTextNode(node[i].key));
		nodeXml.appendChild(userdata_key);

		var userdata_versiontext = ComUtils.createElement("userdata");
		userdata_versiontext.setAttribute("name", "versiontext");
		userdata_versiontext.appendChild(ComUtils
				.createTextNode(node[i].versionText));
		nodeXml.appendChild(userdata_versiontext);

		parentXml.appendChild(nodeXml);
	}
};
MyAction.prototype.save_xml = function(win, catalogId, type, change) {
	_myLayout.progressOn();
	var postData = win.getFrame().contentWindow._myAction.getSaveData();
	var flowName = win.getFrame().contentWindow._myAction.getFlowName();
	postData.catalogId = catalogId;
	postData.type = type;
	if (!change) {
		// 如果是已经发布的流程保存为新模板，id应该改变
		postData.id = null;
	}
	$.ajax({
		url : _controlPath + "saveFlowModel",
		type : "POST",
		data : postData,
		datatype : "json",
		success : function(r) {
			_myLayout.progressOff();
			if ($.notNull(r.error)) {
				dhtmlxUtils.error(r.error);
			} else {
				dhtmlxUtils.message(r.msg);
				if (change) {
					var versiontext = _myMenu.getUserData(win.getId(),
							"versiontext");
					win.setText(flowName + versiontext);
					_myMenu.setItemText(win.getId(), flowName + versiontext);
				}
			}
		}
	});
};
//以下是用户自定义流程的扩展方法
MyAction.prototype.saveAndDeployment = function(){
	var win = _myWins.getTopmostWindow(true);
	if ($.notNull(win)) {
		var _id = win.getFrame().contentWindow._id;
		var _processKey = win.getFrame().contentWindow._processKey;
		var flowName = win.getFrame().contentWindow._myAction.getFlowName();
		if (!$.notNull(flowName)) {
			dhtmlxUtils.alter("流程名称不能为空！");
			return;
		}
		var flg = "0";// 局部变量，0表示新建流程，1表示未发布的流程，2表示以及发布的流程
		var type = "1";// 像后台传递，1表示写入未发布表，2表示更新已发布表
		$.ajax({
			url : _controlPath + "validByIdAndKey",
			type : "POST",
			data : {
				id : _id,
				key : _processKey
			},
			datatype : "json",
			async : false,
			success : function(r) {
				if ($.notNull(r.error)) {
					dhtmlxUtils.error(r.error);
					flg = null;
				} else {
					flg = r.result;
				}
			}
		});
		if (!$.notNull(flg)) {
			return false;
		} else if (flg == "2") {
			dhtmlx.confirm({
				title : "保存",
				text : "确定保存吗？",
				callback : function(result) {
					if (result) {
						type = 2;
						_myAction.saveAndDeployment_xml(win, null, type);
					}
				}
			});
			return true;
		} else if (flg == "1") {
			return false;
		}
		var openWin = dhtmlxUtils.createModalWin("save", "流程目录选择", 300, _maxHeight - 100);
		// 流程树
		var tree = openWin.attachTree();
		tree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		$.ajax({
			type : "GET",
			url : _controlPath + "getAllBpmCatalogList",
			dataType : "json",
			success : function(node) {
				var treeXml = ComUtils.createElement("tree");
				treeXml.setAttribute("id", "0");
				_myAction.addCatalog(treeXml, node);
				tree.loadXMLString(ComUtils.getPrettyXml(treeXml));
			}
		});
		// 功能按钮
		var toolbar = openWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "save",
				type : "button",
				text : "保存",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		toolbar.attachEvent("onClick", function(id) {
			var nodeId = tree.getSelectedItemId();
			if (id == "save" && $.notNull(nodeId)) {
				_myAction.saveAndDeployment_xml(win, nodeId, type);
				openWin.close();
			}
		});
	} else {
		dhtmlxUtils.message("没有打开或选择的流程！");
	}
};
MyAction.prototype.saveAndDeployment_xml = function(win, catalogId, type) {
	_myLayout.progressOn();
	var postData = win.getFrame().contentWindow._myAction.getSaveData();
	var flowName = win.getFrame().contentWindow._myAction.getFlowName();
	postData.catalogId = catalogId;
	postData.type = type;
	postData.formCode = _formCode;
	$.ajax({
		url : _controlPath + "saveFlowModel",
		type : "POST",
		data : postData,
		datatype : "json",
		success : function(r) {
			_myLayout.progressOff();
			if ($.notNull(r.error)) {
				dhtmlxUtils.error(r.error);
				_myWins.forEachWindow(function(fWin) {
					fWin.close();
				});
			} else {
				dhtmlxUtils.message(r.msg);
				_myWins.forEachWindow(function(fWin) {
					fWin.close();
				});
				var newWin = _myAction.createWin(r.id, "", "");
				newWin.attachURL(_controlPath + "frameSimple.html?id=" + r.id + "&type=2");
				//自定义流程时的刷新界面
				if(_refreshFlg == "1"){
					if(window.opener && typeof(window.opener.refreshFlg) == "function"){
						window.opener.refreshFlg();
					}
				}
			}
		}
	});
};
/**
 * 打开按钮功能
 */
MyAction.prototype.openForDeployment = function(json) {
	var openWin = dhtmlxUtils.createModalWin("open", "流程选择", 300, _maxHeight - 100);
	// 流程树
	var tree = openWin.attachTree();
	tree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
	var treeXml = ComUtils.createElement("tree");
	treeXml.setAttribute("id", "0");
	_myAction.addCatalog(treeXml, json);
	tree.loadXMLString(ComUtils.getPrettyXml(treeXml));
	tree.attachEvent("onClick", function(id) {
		var type = tree.getUserData(id, "type");
		if ($.notNull(type)) {
			toolbar.enableItem("open");
		} else {
			toolbar.disableItem("open");
		}
	});
	// 功能按钮
	var toolbar = openWin.attachToolbar({
		icons_path : _iconPath,
		items : [ {
			id : "open",
			type : "button",
			text : "修改",
			img : "open_wf_file.gif",
			img_disabled : "open_dis.gif",
			disabled : "true"
		}, {
			id : "new",
			type : "button",
			text : "新建",
			img : "new.gif",
			img_disabled : "new_dis.gif",
		} ]
	});
	toolbar.attachEvent("onClick", function(id) {
		var nodeId = tree.getSelectedItemId();
		if (id == "open") {
			var newWin = _myAction.createWin(nodeId, "", "");
			newWin.attachURL(_controlPath + "frameSimple.html?id=" + nodeId + "&type=2");
			openWin.close();
		} else if(id == "new"){
			_myAction.newFile();
			openWin.close();
		}
	});
};