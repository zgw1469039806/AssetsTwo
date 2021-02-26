/**
 * 初始化对象
 * @param datagrid 表格Id
 * @param url URL参数
 * @param keyWordId 关键字查询框Id
 * @param dataGridColModel 表格列属性Array
 */
function Macro(datagrid, url, keyWordId, dataGridColModel, searchMainNames) {
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
	this._keyWordId = "#" + keyWordId;
	this._searchNames = searchMainNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};

/**
 * 初始化操作
 */
Macro.prototype.init = function() {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl() + '/getMacrosByPage.json',
		/*url : 'platform/sysPermissionLeaddeptController/getData',*/
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],//启用toolbar
		colModel : this.dataGridColModel,//表格列的属性
		height : $(window).height() - 120,//初始化表格高度
		scrollOffset : 20, //设置垂直滚动条宽度
		rowNum : 20,//每页条数
		rowList : [ 200, 100, 50, 30, 20, 10 ],//每页条数可选列表
		altRows : true,//斑马线
		pagerpos : 'left',//分页栏位置
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		hasTabExport : false, //导出
		hasColSet : false, //设置显隐
		styleUI : 'Bootstrap', //Bootstrap风格
		viewrecords : true, //是否要显示总记录数
		multiselect : true,//可多选
		autowidth : true,//列宽度自适应
		responsive : true,//开启自适应
		pager : "#jqGridPager",
		cellEdit : true,
		cellsubmit : 'clientArray'
	});
	//放入表格toolbar中
	$(this._jqgridToolbar).append($("#tableToolbar"));
};
/**
 * 添加页面
 */
/*var newRowIndex = 0;
 var newRowStart = "new_row";*/
Macro.prototype.insert = function() {
	this.insertIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '添加',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Add/null'
	});
};


/**
 * 保存功能
 * @param form
 * @param callback
 */
Macro.prototype.save = function(form, id) {
	var _self = this;
	var flag = form.find("#macroExp").val();
	if (!flag.startsWith("@{")||!flag.endsWith("}")) {
		layer.alert('请填写正确格式的宏表达式', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return false;
	}
	avicAjax.ajax({
		url : _self.getUrl() + "/save",
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
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
			}
		}
	});

};
//编辑页面
Macro.prototype.modify = function() {
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择要编辑的数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('只允许选择一条数据，进行编辑！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	if (rowData.sign_ == '是') {
		layer.alert('该数据为系统标识无法修改!', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return false;
	}
	this.eidtIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '编辑',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Edit/' + rowData.id
	});
};
/**
 * 删除
 */
Macro.prototype.del = function() {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('确定要删除该数据吗?', {
			icon : 3,
			title : "提示",
			area : [ '400px', '' ]
		}, function(index) {
			for (; l--;) {
				ids.push(rows[l]);
			}
			avicAjax.ajax({
				url : _self.getUrl() + '/delete',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.flag == "success") {
						_self.reLoad();
					} else {
						layer.alert('删除失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0
						});
					}
				}
			});
			layer.close(index);
		});
	} else {
		layer.alert('请选择要删除的记录！', {
			icon : 7,
			title : "提示",
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
	}
	_self.reLoad();
};

/**
 * 重载数据
 */
Macro.prototype.reLoad = function() {
	var searchdata = {
		//param : JSON.stringify(serializeObject($(this._formId)))
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
/**
 * 关键字查询
 */
Macro.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr(
			"placeholder") ? "" : $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for ( var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
		keyWord : JSON.stringify(param)
	}

	$(this._datagridId).jqGrid('setGridParam', {
		postData : searchdata
	}).trigger("reloadGrid");

};
//关闭对话框
Macro.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
//控件校验   规则：表单字段name与rules对象保持一致
Macro.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			macroName : {
				required : true,
				maxlength: 50
			},
			macroDesc : {
				required : true,
				maxlength: 1000
			},
			macroImpl : {
				required : true,
				maxlength: 200
			},
			macroType : {
				required : true,
			    maxlength: 50
			},
			macroExp: {
				required : true,
			    maxlength: 50
			},
		}
	});
};
