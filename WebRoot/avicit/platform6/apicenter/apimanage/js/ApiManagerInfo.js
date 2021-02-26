/**
 * 
 */
function MonitorApiInfo(datagrid, url, searchD, form, keyWordId, searchNames,
		dataGridColModel) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this._datagridId = "#" + datagrid;
	this._jqgridToolbar = "#t_" + datagrid;
	this._doc = document;
	this._formId = "#" + form;
	this._searchDialogId = "#" + searchD;
	this._keyWordId = "#" + keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
// 初始化操作
MonitorApiInfo.prototype.init = function() {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl() + 'getApiInfoManagersByPage.json',
		mtype : 'POST',
		datatype : "json",
//		scroll : true,
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height() - 120,
		scrollOffset : 20, // 设置垂直滚动条宽度
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : false,
		pagerpos : 'left',
		hasColSet:false,
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true,// 开启自适应
		pager : "#jqGridPager"
	});
	$(this._jqgridToolbar).append($("#tableToolbar"));

	$('.date-picker').datepicker({
		beforeShow : function() {
			setTimeout(function() {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
	});
	$('.time-picker').datetimepicker({
		oneLine : true,// 单行显示时分秒
		closeText : '确定',// 关闭按钮文案
		showButtonPanel : true,// 是否展示功能按钮面板
		showSecond : false,// 是否可以选择秒，默认否
		beforeShow : function(selectedDate) {
			if ($('#' + selectedDate.id).val() == "") {
				$(this).datetimepicker("setDate", new Date());
				$('#' + selectedDate.id).val('');
			}
			setTimeout(function() {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
	});
	// 禁止时间和日期格式手输
	$('.date-picker').on('keydown', nullInput);
	$('.time-picker').on('keydown', nullInput);
	// 回车查询
	$(_self._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_self.searchByKeyWord();
		}
	});
	$('.businessDomainValue').on('click', function(e) {
		layer.open({
				type : 2,
				area : [ '300px', '450px' ],
				title : '请选择业务域',
				btn: ['确定', '取消'],
				maxmin : false, // 开启最大化最小化按钮
				content : 'apicenter/apiorganization/apiOrganizationController/toApiOrganizationManage/businessDomain/businessDomainValue',
				yes: function(index){//layer.msg('yes');    //点击确定回调
			        layer.close(index);
			    },
			    btn2: function(){
			    	$("#businessDomainValue").val("");
					$("#businessDomain").val("");
			    },
			    cancel: function(){
			    	$("#businessDomainValue").val("");
					$("#businessDomain").val("");
			      }
			});
	});
};
// 添加页面
MonitorApiInfo.prototype.insert = function() {
	this.insertIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '添加',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, // 开启最大化最小化按钮
		content : this.getUrl() + 'Add/null'
	});
};
// 编辑页面
MonitorApiInfo.prototype.modify = function() {
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择要编辑的数据！', {
			icon : 7,
			area : [ '400px', '' ], // 宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('只允许选择一条数据！', {
			icon : 7,
			area : [ '400px', '' ], // 宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '编辑',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, // 开启最大化最小化按钮
		content : this.getUrl() + 'Edit/' + rowData.id
	});
};
// 详细页
MonitorApiInfo.prototype.detail = function(id) {
	this.detailIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '详细页',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, // 开启最大化最小化按钮
		content : this.getUrl() + 'Detail/' + id
	});
};
// 打开高级查询框
MonitorApiInfo.prototype.openSearchForm = function(searchDiv) {
	var _self = this;
	var contentWidth = 800;
	var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var left = $(searchDiv).offset().left + $(searchDiv).outerWidth()
			- contentWidth;
	var text = $(searchDiv).text();
	var width = $(searchDiv).innerWidth();

	layer.config({
		extend : 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});

	layer.open({
		type : 1,
		shift : 5,
		title : false,
		scrollbar : false,
		move : false,
		area : [ contentWidth + 'px', '400px' ],
		offset : [ top + 'px', left + 'px' ],
		closeBtn : 0,
		shadeClose : true,
		btn : [ '查询', '清空', '取消' ],
		content : $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $(
					'<div class="serachLabel"><span>' + text
							+ '</span><span class="caret"></span></div>')
					.appendTo(layero);
			serachLabel.bind('click', function() {
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
			
			// 回车查询
			 this.enterConfirm = function(event){
                if(event.keyCode === 13){
                    _self.searchData();
                    layer.close(index);
                }
            };
            $(document).on('keydown', this.enterConfirm);
		},
		yes : function(index, layero) {
			_self.searchData();
			layer.close(index);// 查询框关闭
		},
		btn2 : function(index, layero) {
			_self.clearData();
			return false;
		},
		btn3 : function(index, layero) {

		},
        end:function(){
            $(document).off('keydown', this.enterConfirm); //解除键盘事件
        }
	});
};
// 控件校验 规则：表单字段name与rules对象保持一致
MonitorApiInfo.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			businessDomain : {
				maxlength : 50,
				required : true
			},
			deptName : {
				maxlength : 50,
				required : true
			},
			appCode : {
				maxlength : 50,
				required : true
			},
			appDesc : {
				maxlength : 255
			},
			appVersion : {
				maxlength : 50,
				required : true
			},
			apiTechSupport : {
				maxlength : 50,
				required : true
			}
		}
	});
}

MonitorApiInfo.prototype.merageFormValidate = function(form) {
	form.validate({
		rules : {
			/*businessDomain : {
				maxlength : 50,
				required : false
			},
			deptNameAlias : {
				maxlength : 50,
				required : false
			},
			appName : {
				maxlength : 50,
				required : false
			},
			appCode : {
				maxlength : 50,
				required : false
			},
			appDesc : {
				maxlength : 255,
				required : false
			},
			apiTechSupport : {
				maxlength : 50,
				required : true
			}*/
		}
	});
}

// 保存功能
MonitorApiInfo.prototype.save = function(form, id) {
	var _self = this;
	avicAjax.ajax({
		url : _self.getUrl() + "save",
		data : {
			data : JSON.stringify(serializeObject(form))
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad();
				if (id == "insert") {
					layer.close(_self.insertIndex);
				} else {
					layer.close(_self.eidtIndex);
				}
				layer.msg('保存成功！');
			} else {
				layer.alert('保存失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ], // 宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			}
		}
	});
};

/*特殊字符反转义（jaxkson转json时转义）*/
MonitorApiInfo.prototype.htmlDecodeByRegExp=function (str){  
      var s = "";
      if(str.length == 0) return "";
      s = str.replace(/&amp;/g,"&");
      s = s.replace(/&lt;/g,"<");
      s = s.replace(/&gt;/g,">");
      s = s.replace(/&nbsp;/g," ");
      s = s.replace(/&#39;/g,"\'");
      s = s.replace(/&quot;/g,"\"");
      return s;  
}

//特殊字符转义
MonitorApiInfo.prototype.htmlEncodeByRegExp=function (str){  
    var s = "";
    if(str.length == 0) return "";
    s = str.replace(/&/g,"&amp;");
    s = s.replace(/</g,"&lt;");
    s = s.replace(/>/g,"&gt;");
    s = s.replace(/ /g,"&nbsp;");
    s = s.replace(/\'/g,"&#39;");
    s = s.replace(/\"/g,"&quot;");
    return s;  
}

MonitorApiInfo.prototype.merageSave = function(form, id,editor) {
	var _self = this;
	var data = serializeObject(form);
	if(editor){
	   data['apiSampleCode'] = editor.getValue();
	}
	avicAjax.ajax({
		url : _self.getUrl() + "merageSave",
		data : {
			data : JSON.stringify(data)
		},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_self.reLoad();
				if (id == "insert") {
					layer.close(_self.insertIndex);
				} else {
					layer.close(_self.eidtIndex);
				}
				layer.msg('保存成功！');
			} else {
				layer.alert('保存失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ], // 宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			}
		}
	});
};

// 删除
MonitorApiInfo.prototype.del = function() {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('确认要删除选中的数据吗?', {
			icon : 3,
			title : "提示",
			area : [ '400px', '' ]
		}, function(index) {
			for (; l--;) {
				ids.push(rows[l]);
			}
			avicAjax.ajax({
				url : _self.getUrl() + 'delete',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						_self.reLoad();
						layer.msg("删除成功！");
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
			layer.close(index);
		});
	} else {
		layer.alert('请选择要删除的数据！', {
			icon : 7,
			area : [ '400px', '' ], // 宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
	}
};
// 重载数据
MonitorApiInfo.prototype.reLoad = function() {
	var searchdata = {
		param : JSON.stringify(serializeObject($(this._formId)))
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
// 关闭对话框
MonitorApiInfo.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
// 高级查询
MonitorApiInfo.prototype.searchData = function() {
	var searchdata = {
		keyWord : null,
		param : JSON.stringify(serializeObject($(this._formId)))
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
// 关键字段查询
MonitorApiInfo.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr(
			"placeholder") ? "" : $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for ( var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
		keyWord : JSON.stringify(param),
		param : null
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
}
// 隐藏查询框
MonitorApiInfo.prototype.hideSearchForm = function() {
	layer.close(searchDialogindex);
};
/* 清空查询条件 */
MonitorApiInfo.prototype.clearData = function() {
	clearFormData(this._formId);
	this.searchData();
};

MonitorApiInfo.prototype.quickFormValidate = function() {
	$('#quick_form').validate({
		rules : {
			quick_appCode : {
				required : true
			},
			quick_businessDomainValue : {
				maxlength : 50,
				required : true
			},
			quick_appName : {
				maxlength : 50,
				required : true
			},
			quick_deptNameAlias : {
				required : true
			}
		}
	});
}

MonitorApiInfo.prototype.openQuickForm = function(searchDiv) {
	var _self = this;
	var contentWidth = 800;
    var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
	var text = $("#updateApiInfoQuickDialog").html();
	var width = $(searchDiv).innerWidth();

	layer.config({
		extend : 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});

	layer.open({
		type : 1,
//		shift : 5,
		title : "API信息维护",
		scrollbar : false,
		move : false,
		area : [ contentWidth + 'px', '300px' ],
		offset : [ top + 'px', '200px' ],
		closeBtn : 0,
		shadeClose : true,
		btn : [ '确认', '清空', '取消' ],
		content : $("#updateApiInfoQuickDialog"),
		success : function(layero, index) {
			//_self.merageFormValidate();
		},
		yes : function(index, layero) {
			
			var appCode = $("#quick_appCode").val();
			var businessDomain = $("#quick_businessDomain").val();
			var appVersion = $("#quick_appVersion").val();
			var deptName = $("#quick_deptName").val();
			var appName = $("#quick_appName").val();
			var mark = true;
			if(!appCode){
				layer.msg("请选择应用编码！");
				return;
			}
			if(!businessDomain){
				layer.msg("请选择业务域！");
				return;
			}
			if(!appVersion){
				layer.msg("请选择应用版本！");
				return;
			}
			if(!deptName){
				layer.msg("请选择责任部门！");
				return;
			}
			if(!appName){
				layer.msg("请输入应用名称！");
				return;
			}
			
			var formData = {
				appCode : appCode,
				appVersion : appVersion,
				appDesc : $("#quick_appDesc").val(),
				businessDomain : businessDomain,
				appName : appName,
				deptName : deptName
			};
			
			avicAjax.ajax({
				url : _self.getUrl() + 'updateApiInfoQuick',
				data : {
					data : JSON.stringify(formData)
				},
				type : 'post',
				dataType : 'json',
				success : function(r) {
					$(".quick").val("");
					if (r.flag == "success") {
						layer.msg('保存成功！');
						_self.reLoad();
					} else {
						layer.alert('维护API数据失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0,
							btn : [ '关闭' ],
							title : "提示"
						});
					}
				}
			});
			layer.close(index);// 查询框关闭
		},
		btn2 : function(index, layero) {
			$(".quick").val("");
			return false;
		},
		btn3 : function(index, layero) {

		}
	});
};