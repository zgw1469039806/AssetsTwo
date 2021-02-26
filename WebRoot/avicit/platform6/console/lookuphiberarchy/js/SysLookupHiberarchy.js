/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @returns
 */
function SysLookupHiberarchy(ztreeId, url, form, searchD, searchbtn) {
	if (!ztreeId || typeof (ztreeId) !== 'string' && ztreeId.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	};
	this.addRetIdFlag = null; //初始化添加节点标记
	this.firstAsyncSuccessFlag = 0; //第一次加载
	this.tree = null;
	this.ztreeId = ztreeId;
	this._ztreeId = "#" + ztreeId;
	this.setting = {};
	this._doc = document;
	this._formId = "#" + form; //formId
	this._searchId = "#" + searchD;
	this._searchbtnId = "#" + searchbtn;
	this.lookuptypevalue = null;
};
//初始化操作
SysLookupHiberarchy.prototype.init = function() {
	var _self = this;
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
				pIdKey : "parentId",
				rootPId : -1
			}
		},
		async : {
			enable : true,
			url : _self.getUrl() + "gettree/2",
			autoParam : [ "id" ],
			dataFilter : function(treeId, parentNode, childNodes) {
				if (!childNodes)
					return null;
				childNodes = eval(childNodes);
				return childNodes;
			}
		},
		callback : {
			onClick : function(event, treeId, treeNode) { //绑定左右联动事件
				var node = treeNode.getParentNode();
				_self.lookuptypevalue = null;
				$('#lookupType').css("visibility","visible");
				$('#sysLookupHiberarchy_ceshi').css("visibility","visible");
				$('#hidelookuptype').css("visibility","visible");
				avicAjax.ajax({
					cache : true,
					type : "post",
					url : _self.getUrl() + "Edit/" + treeNode.id,
					dataType : "json",
					async : false,
					success : function(data) {
						_self.setForm($(_self._formId),data.sysLookupHiberarchyDTO);
						_self.lookuptypevalue = data.sysLookupHiberarchyDTO.lookupType;
						if (_self.firstAsyncSuccessFlag == 0) {
							$("select").attr("disabled","disabled");
							$('input').attr("disabled","disabled");
							$('textarea').attr("disabled","disabled");
						}else{
							if(treeNode._parentId === '-1'){
								$("select").attr("disabled","disabled");
								$('input').attr("disabled","disabled");
								$('textarea').attr("disabled","disabled");
								$('#lookupType').css("visibility","visible");
								$('#sysLookupHiberarchy_ceshi').css("visibility","visible");
								$('#hidelookuptype').css("visibility","visible");
								$('#lookupType').attr('disabled',true);
							}else{
								$("select").removeAttr("disabled");
								$('input').removeAttr("disabled");
								$('textarea').removeAttr("disabled");
								if(node != null){
									   if(node._parentId != -1){
										 $('#lookupType').css("visibility","hidden");
										 $('#hidelookuptype').css("visibility","hidden");
										 $('#sysLookupHiberarchy_ceshi').css("visibility","hidden");
									   }
									}
								$('#sysLanguageCode').attr('disabled',true);
							}
						}
					}
				});
			},
			onAsyncError : function() {
				layer.alert('加载失败！', {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					title : '提示'
				});
			},
			onAsyncSuccess : function(event, treeId, msg) {
				if (_self.firstAsyncSuccessFlag == 0) {
					var nodes = _self.tree.getNodes();
					if (nodes.length > 0) {
						_self.tree.expandNode(nodes[0], true);
						$("#" + nodes[0].tId + "_span").click();
						_self.firstAsyncSuccessFlag = 1;
					} else {
						layer.alert('未找到根节点', {
							icon : 7,
							area : [ '400px', '' ], //宽高
							closeBtn : 0,
							title : '提示'
						});
						return;
					}
				}
				var node = _self.tree.getNodeByParam("id", $('#id').val());
				_self.tree.selectNode(node);
				_self.addRetIdFlag = null; //初始化添加节点标记
				_self.lookuptypevalue = null;
			}
		}
	};
	_self.tree = $.fn.zTree.init($(_self._ztreeId), _self.setting, []);
};

//表单加载json对象数据
SysLookupHiberarchy.prototype.setForm = function(formObj, jsonValue) {
	var obj = formObj;
	$.each(jsonValue, function(name, ival) {
				var oinput = obj.find("input[name=" + name + "]");
				if (oinput.attr("type") == "checkbox") {
					if (ival !== null) {
						var checkboxObj = $("[name=" + name + "]");
						var checkArray = ival.length > 0 ? ival.split(",") : ival;
						for ( var i = 0; i < checkboxObj.length; i++) {
							checkboxObj[i].checked = false;
							for ( var j = 0; j < checkArray.length; j++) {
								if (checkboxObj[i].value == checkArray[j]) {
									checkboxObj[i].checked = true;
									$(checkboxObj[i]).parent().parent().find('div.errDom').remove();
								}
							}
						}
					}
				} else if (oinput.attr("type") == "radio") {
					oinput.each(function() {
						var radioObj = $("[name=" + name + "]");
						for ( var i = 0; i < radioObj.length; i++) {
							if (radioObj[i].value == ival) {
								radioObj[i].checked = true;
								$(radioObj[i]).parent().parent().find('div.errDom').remove();
							}
						}
					});
				} else if (oinput.attr("type") == "textarea") {
					obj.find("[name=" + name + "]").html(ival);
					obj.find("[name=" + name + "]").blur();
				} else if ($(oinput).attr('class') == "form-control date-picker hasDatepicker" || $(oinput).attr('class') == "form-control date-picker hasDatepicker error") {
					obj.find("[name=" + name + "]").datepicker("setDate", new Date(ival));
					obj.find("[name=" + name + "]").blur();

				} else if ($(oinput).attr('class') == "form-control time-picker hasDatepicker") {
					obj.find("[name=" + name + "]").val(ival);
					obj.find("[name=" + name + "]").blur();
				} else {
					obj.find("[name=" + name + "]").val(ival);
					obj.find("[name=" + name + "]").blur();
				}
			})
}
//添加平级节点
SysLookupHiberarchy.prototype.insert = function() {
	var _self = this;
	var selectedNodes = _self.tree.getSelectedNodes();
	if (null == selectedNodes[0] || undefined == selectedNodes[0]) {
		layer.alert('请选择节点后进行操作', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return;
	}
	if (selectedNodes[0]._parentId === '-1') {
		layer.alert('不能添加与' + selectedNodes[0].text + '平级的节点！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return;
	}
	_self.clearData(_self._formId);
	this.lookuptypevalue = null;
	_self.edit();
}
//添加子节点
SysLookupHiberarchy.prototype.insertSub = function() {
	var _self = this;
	_self.addRetIdFlag = 'sub';
	var selectedNodes = _self.tree.getSelectedNodes();
	if (null == selectedNodes[0]) {
		layer.alert('请选择节点后进行操作', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return;
	}
	_self.clearData(_self._formId);
	this.lookuptypevalue = null;
	_self.edit(1);
}

//编辑节点
SysLookupHiberarchy.prototype.edit = function(flag) {
	//select的禁用方法
	$("select").removeAttr("disabled");
	//input的禁用方法
	$('input').removeAttr("disabled");
	$('textarea').removeAttr("disabled");
	$('#lookupType').css("visibility","visible");
	$('#sysLookupHiberarchy_ceshi').css("visibility","visible");
	$('#hidelookuptype').css("visibility","visible");
	$('#sysLanguageCode').attr('disabled',true);
	var _self = this;
	var selectedNodes = _self.tree.getSelectedNodes();
	if (selectedNodes.length > 0) {
		var node = selectedNodes[0].getParentNode();
		avicAjax.ajax({
				cache : true,
				type : "post",
				url : _self.getUrl() + "Edit/"+ selectedNodes[0].id,
				dataType : "json",
				async : false,
				success : function(data) {
					if(selectedNodes[0]._parentId == -1){
						$('#parentId').val(selectedNodes[0].id);
					}else{
						if (flag == '1') {//添加子节点
							$('#parentId').val(selectedNodes[0].id);
							$('#lookupType').css("visibility","hidden");
							$('#sysLookupHiberarchy_ceshi').css("visibility","hidden");
							$('#hidelookuptype').css("visibility","hidden");
						}else {
							$('#parentId').val(selectedNodes[0]._parentId);
							if(node != null){
							   if(node._parentId != -1){
								 $('#lookupType').css("visibility","hidden");
								 $('#sysLookupHiberarchy_ceshi').css("visibility","hidden");
								 $('#hidelookuptype').css("visibility","hidden");
							   }
							}
						}
					}
					$('#sysLanguageCode').val(data.sysLookupHiberarchyDTO.sysLanguageCode);
				}
		
		});
	}
}

//保存表单
SysLookupHiberarchy.prototype.save = function() {
	var _self = this;
	var selectedNodes = _self.tree.getSelectedNodes();
	if (null == selectedNodes[0] || undefined == selectedNodes[0]) {
		layer.alert('请选择节点后进行操作', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return;
	}
	if(selectedNodes[0]._parentId === '-1'){
		if(_self.addRetIdFlag != 'sub'){
			layer.alert('根节点不能编辑', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
				title : '提示'
			});
			return;
		}
	}
	var isValidate = $(_self._formId).validate();//校验表单
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		return false;
	}
	var newlookupType = $('#lookupType').val().replace(/(^\s*)/g,""); //去除左侧空格
	if(newlookupType != ""){
		if((_self.lookuptypevalue != newlookupType && $('#id').val() != "")|| $('#id').val() == ""){
			  avicAjax.ajax({
				cache : true,
				type : "post",
				url : _self.getUrl() + 'searchlookuptype/'+newlookupType,
				dataType : "json",
				async : false,
				success : function(r) {
					if (r.flag == "success") {
						if(r.count > 0){
							layer.alert('系统代码类型重复', {
								icon : 7,
								area : [ '400px', '' ], //宽高
								closeBtn : 0,
								title : '提示'
							});
							return false;
						}else{
							_self.savemain(selectedNodes[0]);
						}
					}
				}
			 });
		}else{
			if(selectedNodes[0].level == '1' && _self.lookuptypevalue == null){
				layer.alert('一级系统代码类型不能为空!', {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					title : '提示'
				});
				return;
			}else{
				_self.savemain(selectedNodes[0]);
			}
		}
	}else{
		if(selectedNodes[0]._parentId === '-1'){
			layer.alert('一级系统代码类型不能为空!', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
				title : '提示'
			});
			return;
		}else if(selectedNodes[0].level == '1'){
			if(_self.addRetIdFlag == 'sub'){
				_self.savemain(selectedNodes[0]);
			}else{
				layer.alert('一级系统代码类型不能为空!', {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					title : '提示'
				});
				return;
			}
		}else{
			_self.savemain(selectedNodes[0]);
		}
	 }
}
//保存主要方法
SysLookupHiberarchy.prototype.savemain=function (selectedNodes){
	var _self = this;
	avicAjax.ajax({
		url : _self.getUrl() + 'save',
		data : JSON.stringify(serializeObject($(_self._formId))),
		type : 'post',
		contentType : 'application/json',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
                if(r.typeKeyExist != null && r.typeKeyExist != "" && r.typeKeyExist != undefined){
                    layer.msg('该类型下系统代码【' + r.typeKeyExist + "】已存在，请重新填写！",{
                        icon: 7,
                        area: ['500px', ''],
                        time: 4000,
                        closeBtn: 0
                    });
                    return false;
                }
				if (r.type == '1') {//新建成功
					var treeObj = $.fn.zTree.getZTreeObj(_self.ztreeId);
					if (selectedNodes.isParent == false) {
						selectedNodes.isParent = true;
					}
					$('#id').val(r.data.id);
					if (_self.addRetIdFlag == 'sub') { //添加子节点
						treeObj.reAsyncChildNodes(selectedNodes, "refresh");
					} else {//添加平级节点
						treeObj.reAsyncChildNodes(selectedNodes.getParentNode(), "refresh");
					}
                    layer.msg('添加成功！',{
                        icon: 1,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
				} else if (r.type == '2') {//编辑成功
					  selectedNodes.text = r.data.text;
					  _self.tree.updateNode(selectedNodes);
					  _self.setting.callback.onClick(null, _self.tree.setting.treeId, selectedNodes);//调用点击事件 ;
                    layer.msg('编辑成功！',{
                        icon: 1,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
				}
			} else {
				layer.alert(r.error, {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					title : '提示'
				});
			}
		}
	});
	
}
//删除节点
SysLookupHiberarchy.prototype.del = function() {
	var _self = this;
	var selectedNodes = _self.tree.getSelectedNodes();
	if (selectedNodes[0]._parentId === '-1') {
		layer.alert('不允许删除根节点！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return;
	}
	if ((selectedNodes[0].attributes && selectedNodes[0].attributes.count > 0)
			|| selectedNodes[0].children.length > 0) {
		layer.alert('当前选中节点含有子节点，请先删除子节点！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return;
	}
	var ids = [];
	ids.push(selectedNodes[0].id);
	layer.confirm('确认要删除该数据吗?', {
		icon : 3,
		title : "提示",
		closeBtn : 0,
		area : [ '400px', '' ]
	}, function(index) {
		if (index) {
			avicAjax.ajax({
				url : _self.getUrl() + 'delete',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						_self.tree.removeNode(selectedNodes[0]);
						layer.close(index);
						//删除当前节点，选择父节点
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
							title : '提示'
						});
					}
				}
			});
		}
	});
}
//清除表单数据
SysLookupHiberarchy.prototype.clearData = function(form) {
	clearFormData(form);
}
//控件校验   规则：表单字段name与rules对象保持一致
SysLookupHiberarchy.prototype.formvaliad = function() {
	var _self = this;
	$(_self._formId).validate({
		rules : {
			sysApplicationId : {
				maxlength : 50
			},
			lookupType : {
				maxlength : 50
			},
			systemFlag : {
				required : true,
				maxlength : 1
			},
			validFlag : {
				required : true,
				maxlength : 1
			},
			parentId : {
				maxlength : 32
			},
			typeKey : {
				required : true,
				maxlength : 255
			},
			typeValue : {
				required : true,
				maxlength : 255
			},
			orderBy : {
				required : true,
				number : true
			},
			remark : {
				maxlength : 1000
			},
			sysLanguageCode : {
				required : true,
				maxlength : 255
			},
		}
	});
};
SysLookupHiberarchy.prototype.test = function(lookupTypeCode){
	this.testL = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '测试多维通用代码',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : 'avicit/platform6/console/lookuphiberarchy/LookupHiberarchyDemo.jsp?lookupTypeCode='+lookupTypeCode
	});
}
