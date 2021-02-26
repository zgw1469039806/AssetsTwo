/**
 * 单表树
 * 
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @param afterInit
 * @param clickRowLoad
 * @returns
 */
function SysDbSubject(ztreeId, url, form, searchD, searchbtn, afterInit,
		clickRowLoad) {
	if (!ztreeId || typeof (ztreeId) !== 'string' && ztreeId.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	};
	this.addRetIdFlag = null; // 初始化添加节点标记
	this.firstAsyncSuccessFlag = 0; // 第一次加载
	this.tree = null;
	this.ztreeId = ztreeId;
	this._ztreeId = "#" + ztreeId;
	this.setting = {};
	this._doc = document;
	this._formId = "#" + form; // formId
	this._searchId = "#" + searchD;
	this._searchbtnId = "#" + searchbtn;
	this.afterInit = afterInit;
	this.clickRowLoad = clickRowLoad;
	this._rootId = "";
	this.init.call(this);
}
// 初始化操作
var issubinit = false;
SysDbSubject.prototype.init = function() {
	var _self = this;
	$(_self._searchId).on('keyup', function(e) {
		if (e.keyCode == 13) {
			_self.onseach(13, $(_self._searchId).val());
		}
	});
	$(_self._searchbtnId).on('click', function(e) {
		_self.onseach(13, $(_self._searchId).val());
	});
	_self.setting = {
		view : {
			selectedMulti : false
		},
		data : {
			key : {
				id : "id",
				name : "text",
				children : "children"
			},
			simpleData : {
				enable : true,
				idKey : "id",
				pIdKey : "pid",
				rootPId : -1
			}
		},
		async : {
			enable : true,
			url : _self.getUrl() + "/gettree/2",
			autoParam : [ "id" ],
			dataFilter : function(treeId, parentNode, childNodes) {
				if (!childNodes)
					return null;
				childNodes = eval(childNodes);
				if (childNodes.length > 0) {
					pId = childNodes[0].id;
				}
				return childNodes;
			}
		},
		callback : {
			onClick : function(event, treeId, treeNode) { // 绑定左右联动事件
				if (issubinit == false) {
					if (treeNode != null && treeNode != "") {
						_self.afterInit(treeNode.id);
						issubinit = true;
					} else {
						_self.afterInit("-1");
						issubinit = true;
					}
				} else {
					if (treeNode != null && treeNode != "") {
						_self.clickRowLoad(treeNode.id);

					} else {
						_self.clickRowLoad("");
					}
				}
			},
			onRightClick : function OnRightClick(event, treeId, treeNode) {
				// 在ztree上的右击事件
				if (treeNode != null && treeNode != "") {
					_self.tree.selectNode(treeNode);
					showRMenu(event.clientX, event.clientY);
				}
			},
			onAsyncError : function() {
				layer.alert('加载失败！', {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			},
			onAsyncSuccess : function(event, treeId, msg) {
				if (_self.firstAsyncSuccessFlag == 0) {
					var nodes = _self.tree.getNodes();
					if (nodes.length > 0) {
						if (nodes[0]._parentId === "-1") {
							_self._rootId = nodes[0].id;
						}
						_self.tree.expandNode(nodes[0], true);
						$("#" + nodes[0].tId + "_span").click();
						_self.firstAsyncSuccessFlag = 1;
						_self.addRetIdFlag = null; // 初始化添加节点标记
					} else {
						layer.confirm('未找到根节点,确定要初始化根节点吗?', {
							icon : 3,
							title : "提示",
							area : [ '400px', '' ]
						}, function(index) {
							if (index) {
								_self.insertRoot(); // 初始化根节点
							}
						});
					}
				}
			}
		}
	};
	_self.tree = $.fn.zTree.init($(_self._ztreeId), _self.setting, []);
};
// 显示右键菜单
function showRMenu(x, y) {
	$("#rMenu ul").show();
	$("#rMenu").css({
		"top" : y + "px",
		"left" : x + "px",
		"visibility" : "visible"
	}); // 设置右键菜单的位置、可见
	$("body").bind("mousedown", onBodyMouseDown);
}
// 隐藏右键菜单
function hideRMenu() {
	if ($("#rMenu"))
		$("#rMenu").css({
			"visibility" : "hidden"
		}); // 设置右键菜单不可见
	$("body").unbind("mousedown", onBodyMouseDown);
}
// 鼠标按下事件
function onBodyMouseDown(event) {
	if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
		$("#rMenu").css({
			"visibility" : "hidden"
		});
	}
}
// 查询框查询
SysDbSubject.prototype.onseach = function(ecode, value) {
	var _self = this;
	if (ecode == 13) {
		if (value == null || value == "") {
			_self.tree = $.fn.zTree.init($(_self._ztreeId), _self.setting, []);
			return;

		}
		avicAjax.ajax({
			cache : true,
			type : "post",
			url : _self.getUrl() + "/search",
			dataType : "json",
			data : {
				search_text : value
			},
			async : false,
			error : function(request) {
				throw new Error('操作失败，服务请求状态：' + request.status + ' '
						+ request.statusText + ' 请检查服务是否可用！');
			},
			success : function(data) {
				_self.tree = $.fn.zTree.init($(_self._ztreeId), {
					view : {
						selectedMulti : false,
						fontCss : function(treeId, treeNode) {
							if (treeNode.attributes && treeNode.attributes.s) {
								return {
									color : 'blue'
								};
							} else {
								return {};
							}
						}
					},
					data : {
						key : {
							id : "id",
							name : "text",
							children : "children"
						},
						simpleData : {
							enable : false,
							idKey : "id",
							pIdKey : "pid",
							rootPId : -1
						}
					},
					callback : {
						onClick : function(event, treeId, treeNode) { // 查询后绑定左右联动事件
							if (issubinit == false) {
								if (treeNode != null && treeNode != "") {
									_self.afterInit(treeNode.id);
									issubinit = true;
								} else {
									_self.afterInit("-1");
									issubinit = true;
								}
							} else {
								if (treeNode != null && treeNode != "") {
									_self.clickRowLoad(treeNode.id);

								} else {
									_self.clickRowLoad("");
								}
							}
						},
						onRightClick : function OnRightClick(event, treeId,
								treeNode) {
							// 在ztree上的右击事件
							if (treeNode != null && treeNode != "") {
								_self.tree.selectNode(treeNode);
								showRMenu(event.clientX, event.clientY);
							}
						}
					}
				}, data);
				var node = _self.tree.getNodeByParam("id", data[0].id);
				_self.tree.selectNode(node);
				_self.setting.callback.onClick(null, _self.tree.setting.treeId,
						node);// 调用点击事件 ;
			}
		});
	}
};
//添加平级节点
SysDbSubject.prototype.insert = function(){
	var _self = this;
	var selectedNodes = _self.tree.getSelectedNodes();
	if(null == selectedNodes[0] || undefined == selectedNodes[0]){
		layer.alert('请选择节点后进行操作', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
		);
		return;
	}
	if(selectedNodes[0]._parentId=== '-1'){
		layer.alert('不能添加与'+selectedNodes[0].text+'平级的节点！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
		);
		return;
	}
	this.insertIndex = layer.open({
	    type: 2,
	    area: ['30%', '30%'],
	    title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'/operation/Add/'+selectedNodes[0]._parentId
	});
};
// 添加子节点
SysDbSubject.prototype.insertSub = function() {
	var _self = this;
	_self.addRetIdFlag = 'sub';
	var selectedNodes = _self.tree.getSelectedNodes();
	if (null == selectedNodes[0]) {
		layer.alert('请选择节点后进行操作', {
			icon : 7,
			area : [ '400px', '' ], // 宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return;
	}
	this.insertIndex = layer.open({
		type : 2,
		area : [ '30%', '30%' ],
		title : '添加',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, // 开启最大化最小化按钮
		content : this.getUrl() + '/operation/Add/' + selectedNodes[0].id
	});
};

// 编辑节点
SysDbSubject.prototype.modify = function() {
	var _self = this;
	_self.addRetIdFlag = 'sub';
	var selectedNodes = _self.tree.getSelectedNodes();
	if (null == selectedNodes[0]) {
		layer.alert('请选择节点后进行操作', {
			icon : 7,
			area : [ '400px', '' ], // 宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return;
	}
	this.eidtIndex = layer.open({
		type : 2,
		area : [ '30%', '30%' ],
		title : '编辑',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, // 开启最大化最小化按钮
		content : this.getUrl() + '/operation/Edit/' + selectedNodes[0].id
	});
};

// 保存表单
SysDbSubject.prototype.save = function(form, dialog) {
	var _self = this;
	var selectedNodes = _self.tree.getSelectedNodes();
	if (null == selectedNodes[0] || undefined == selectedNodes[0]) {
		layer.alert('请选择节点后进行操作', {
			icon : 7,
			area : [ '400px', '' ], // 宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return;
	}
	avicAjax.ajax({
		url : _self.getUrl() + '/saveSysDbSubject',
		data : JSON.stringify(serializeObject(form)),
		type : 'post',
		contentType : 'application/json',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				if (r.type == '1') {// 新建成功
					var treeObj = $.fn.zTree.getZTreeObj(_self.ztreeId);
					if (selectedNodes[0].isParent == false) {
						selectedNodes[0].isParent = true;
					}
					if (_self.addRetIdFlag == 'sub') { // 添加子节点
						_self._rootId = r.data.id;
						treeObj.reAsyncChildNodes(selectedNodes[0], "refresh");
						if ($(_self._searchId).val() != "") {
							$(_self._searchId).val('');
							_self.onseach(13, $(_self._searchId).val());
						}
					} else {// 添加平级节点
						_self._rootId = r.data.id;
						treeObj.reAsyncChildNodes(selectedNodes[0]
								.getParentNode(), "refresh");
					}
					if (dialog == "insert") {
						layer.close(_self.insertIndex);
					}
					hideRMenu();
					layer.msg("添加成功");
				} else if (r.type == '2') {// 编辑成功
					if (selectedNodes.length > 0) {
						selectedNodes[0].text = r.data.text;
						_self.tree.updateNode(selectedNodes[0]);
						_self.setting.callback.onClick(null,
								_self.tree.setting.treeId, selectedNodes[0]);// 调用点击事件
																				// ;
					}
					if (dialog == "edit") {
						layer.close(_self.eidtIndex);
					}
					hideRMenu();
					layer.msg("编辑成功");
				}
			} else {
				layer.alert(r.error, {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			}
		}
	});
};
// 关闭对话框
SysDbSubject.prototype.closeDialog = function(id) {
	hideRMenu();
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
// 删除节点
SysDbSubject.prototype.del = function() {
	hideRMenu();
	var _self = this;
	var selectedNodes = _self.tree.getSelectedNodes();
	if (selectedNodes[0]._parentId === '-1') {
		layer.alert('不能删除根节点！', {
			icon : 7,
			area : [ '400px', '' ], // 宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return;
	}
	if ((selectedNodes[0].attributes && selectedNodes[0].attributes.count > 0)
			|| selectedNodes[0].children.length > 0) {
		layer.alert('当前选中节点含有子节点，请先删除子节点！', {
			icon : 7,
			area : [ '400px', '' ], // 宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return;
	}
	var ids = [];
	ids.push(selectedNodes[0].id);
	layer.confirm('确认要删除选中的节点吗?', {
		icon : 3,
		title : "提示",
		area : [ '400px', '' ]
	}, function(index) {
		if (index) {
			avicAjax.ajax({
				url : _self.getUrl() + '/delete',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						layer.msg("删除成功");

						_self.tree.removeNode(selectedNodes[0]);
						layer.close(index);
						// 删除当前节点，选择父节点
						var node = selectedNodes[0].getParentNode();
						if (node.attributes && node.attributes.count > 0) {
							node.attributes.count--;
						}
						_self.tree.selectNode(node);
						$("#" + node.tId + "_span").click();
					} else {
						layer.alert('删除失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0,
							btn : [ '关闭' ],
							title : "提示"
						});
					}
				}
			});
		}
	});
};

// 添加根节点(如果需要修改根节点数据通过前台页面设置)
SysDbSubject.prototype.insertRoot = function() {
	var _self = this;
	avicAjax.ajax({
		url : _self.getUrl() + '/insertRoot',
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.init();
				layer.msg('初始化根节点成功！');
			} else {
				layer.alert('初始化根节点失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			}
		}
	})
};

// 控件校验 规则：表单字段name与rules对象保持一致
SysDbSubject.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			name : {
				maxlength : 32,
				required : true
			},
			pid : {
				maxlength : 50
			},
			sysApplicationId : {
				maxlength : 32
			},
		}
	});
};
