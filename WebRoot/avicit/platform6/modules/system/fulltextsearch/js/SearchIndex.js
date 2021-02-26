/**
 * 初始化对象
 * 
 * @param datagrid
 *            表格Id
 * @param url
 *            URL参数
 * @param searchDialogId
 *            高级查询Id
 * @param form
 *            高级查询formId
 * @param keyWordId
 *            关键字查询框Id
 * @param searchNames
 *            关键字查询项名称Array
 * @param dataGridColModel
 *            表格列属性Array
 */
function SysSearchIndex(datagrid, url, searchDialogId, form, keyWordId,
		searchNames, dataGridColModel,infoIdInit) {
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
	this._searchDialogId = "#" + searchDialogId;
	this._keyWordId = "#" + keyWordId;
	this._searchNames = searchNames;
	this._infoIdInit = infoIdInit;
	this.dataGridColModel = dataGridColModel;
	this.notnullFiled = [];// 非空字段
	this.notnullFiledComment = []; // 非空字段注释
	// 除时间,数字等类型长度校验字段
	this.lengthValidFiled = [];
	// 除时间,数字等类型长度校验字段注释
	this.lengthValidFiledComment = [];
	// 除时间,数字等类型长度
	this.lengthValidFiledSize = [];
	this.init.call(this);
};

/**
 * 初始化操作
 */
SysSearchIndex.prototype.init = function() {
	var _self = this;
	var param = {infoId:_self._infoIdInit};
	$(_self._datagridId).jqGrid({
		url : this.getUrl() + 'getFulltextSearchIndexsByPage.json',
		postData : param,
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],// 启用toolbar
		colModel : this.dataGridColModel,// 表格列的属性
		height : $(window).height() - 120,// 初始化表格高度
		scrollOffset : 20, // 设置垂直滚动条宽度
		rowNum : 20,// 每页条数
		rowList : [ 200, 100, 50, 30, 20, 10 ],// 每页条数可选列表
		altRows : true,// 斑马线
		pagerpos : 'left',// 分页栏位置
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		styleUI : 'Bootstrap', // Bootstrap风格
		viewrecords : true, // 是否要显示总记录数
		multiselect : true,// 可多选
		autowidth : true,// 列宽度自适应
		responsive : true,// 开启自适应
		pager : "#jqGridPager",
		cellEdit : true,
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
		cellsubmit : 'clientArray'
	});

	// 放入表格toolbar中
	$(this._jqgridToolbar).append($("#tableToolbar"));

	// 初始化时间控件
	$('.date-picker').datepicker({
		beforeShow : function() {
			setTimeout(function() {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
	});
	$('.time-picker').datetimepicker({
		oneLine : true,// 单行显示时分秒
		showButtonPanel : true,// 是否展示功能按钮面板
		closeText : '确定',
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
	// 初始化校验字段
	_self.lengthValidFiled.push("name");
	_self.lengthValidFiledSize.push(50);
	_self.lengthValidFiled.push("title");
	_self.lengthValidFiledSize.push(50);
	_self.lengthValidFiled.push("valid");
	_self.lengthValidFiledSize.push(2);
	_self.lengthValidFiled.push("hglight");
	_self.lengthValidFiledSize.push(2);
	_self.lengthValidFiled.push("secret");
	_self.lengthValidFiledSize.push(2);
	/*_self.lengthValidFiled.push("sort");
	_self.lengthValidFiledSize.push(50);*/
};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
SysSearchIndex.prototype.insert = function(infoId) {
	var _self = this;
	$(_self._datagridId).jqGrid('endEditCell');
	var hasvalidate = true;
	var data = $(_self._datagridId).jqGrid('getRowData');
	if (data.length > 0 && _self.notnullFiled.length > 0) {
		$.each(_self.notnullFiled, function(i, item) {
			var msg = _self.nullvalid(data, item, _self.notnullFiled,
					_self.notnullFiledComment);
			if (msg && msg.length > 0) {
				layer.alert(msg, {
					icon : 7,
					area : [ '400px', '' ], // 宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
				hasvalidate = false;
				return false;
			}
		});
	}
	if (!hasvalidate) {
		return false;
	}

	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID : newRowId,
		initdata : {title : "Y",valid : "Y",sort : "no"},
		position : "first",
		useDefValues : true,
		useFormatter : true,
		addRowParams : {
			extraparam : {}
		}
	};
	$(_self._datagridId).jqGrid('addRow', parameters);
	newRowIndex++;
	$(_self._datagridId).setCell(newRowId,'attribute01',infoId);
};

/**
 * 非空验证
 * 
 * @param
 * @param
 */
SysSearchIndex.prototype.nullvalid = function(data, item, nullfiled,
		notnullFiledComment) {
	var msg = "";
	$.each(data, function(i, dataitem) {
		if (dataitem[item] == "") {
			temp = false;
			msg = notnullFiledComment[$.inArray(item, nullfiled)] + "为必填字段";
		}
	})
	return msg;
}
/**
 * 获取sql查询字段
 * 
 * @param
 * @param
 */
getAllCol = function(id) {
	var _self = this;
	var ids = [];
	ids.push(id);
	var infoStr="";
	avicAjax.ajax({
		url : 'searchindex/searchIndexController/operation/' + 'listColumns',
		data : JSON.stringify(ids),
		contentType : 'application/json',
		async:false,
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if(r.flag=="figure"){
				$('#sysSearchIndex_insert').addClass('disabled');	
				layer.alert('请先保存基本信息，再进行索引配置！', {
					icon : 7,
					area : [ '400px', '' ], // 宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			}else if(r.flag=="noIndex"){
				$('#sysSearchIndex_insert').addClass('disabled');	
				layer.alert('磁盘类型不需要索引配置！', {
					icon : 7,
					area : [ '400px', '' ], // 宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			}else{
				var obj = jQuery.parseJSON(r.info);
				for(var i=0;i<obj.length-1;i++){
					infoStr = infoStr + obj[i].columnName + ":" + obj[i].columnName + ";";
				}
				if(obj.length>0){
					infoStr = infoStr + obj[obj.length-1].columnName + ":" + obj[obj.length-1].columnName;
				}
			}
		}
	});
	return infoStr;
}
/**
 * 长度验证
 * 
 * @param
 * @param
 */
SysSearchIndex.prototype.lengthvalid = function(data, item, lengthValidFiled,
		lengthValidFiledComment, lengthValidFiledSize) {
	var msg = "";
	$.each(
			data,
			function(i, dataitem) {
				if (dataitem[item] != ""&& dataitem[item].replace(/[^\x00-\xff]/g, "**").length > lengthValidFiledSize[$.inArray(item, lengthValidFiled)]) {
					msg = lengthValidFiledComment[$.inArray(item,
							lengthValidFiled)]
							+ "的输入长度超过预设长度"
							+ lengthValidFiledSize[$.inArray(item,
									lengthValidFiled)];
				}
	})
	return msg;
}

/**
 * 保存功能
 * 
 * @param form
 * @param callback
 */
SysSearchIndex.prototype.save = function() {
	var _self = this;
	$(this._datagridId).jqGrid('endEditCell');
	var data = $(this._datagridId).jqGrid('getRowData');
	var hasvalidate = true;
	$.each(_self.notnullFiled, function(i, item) {
		var msg = _self.nullvalid(data, item, _self.notnullFiled,
				_self.notnullFiledComment);
		if (msg && msg.length > 0) {
			layer.alert(msg, {
				icon : 7,
				area : [ '400px', '' ], // 宽高
				closeBtn : 0,
				btn : [ '关闭' ],
				title : "提示"
			});
			hasvalidate = false;
			return false;
		}
	});
	$.each(_self.lengthValidFiled, function(i, item) {
		if (hasvalidate) {
			var msg = _self.lengthvalid(data, item, _self.lengthValidFiled,
					_self.lengthValidFiledComment, _self.lengthValidFiledSize);
			if (msg && msg.length > 0) {
				layer.alert(msg, {
					icon : 7,
					area : [ '400px', '' ], // 宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
				hasvalidate = false;
				return false;
			}
		}
	});
	if (!hasvalidate) {
		return false;
	}
	if (data && data.length > 0) {
		for (var i = 0; i < data.length; i++) {
			if (data[i].id.indexOf(newRowStart) > -1) {
				data[i].id = '';
			}
		}

		$.ajax({
			url : _self.getUrl() + "save",
			data : {
				data : JSON.stringify(data)
			},
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag == "success") {
					_self.reLoad();
					layer.msg('保存成功！');
				} else if(r.flag == "failure"){
					layer.alert('保存失败！' + r.error, {
						icon : 7,
						area : [ '400px', '' ], // 宽高
						closeBtn : 0,
						btn : [ '关闭' ],
						title : "提示"
					});
				}else if(r.flag == "conflict"){
					layer.alert("保存失败！名称列存在相同的'" + r.col + "'字段，请修改后再进行保存！", {
						icon : 7,
						area : [ '400px', '' ], // 宽高
						closeBtn : 0,
						btn : [ '关闭' ],
						title : "提示"
					});
				}else if(r.flag == "colisnull"){
					layer.alert("保存失败！名称列不能为空值！", {
						icon : 7,
						area : [ '400px', '' ], // 宽高
						closeBtn : 0,
						btn : [ '关闭' ],
						title : "提示"
					});
				}
			}
		});
	} else {
		layer.alert('请先添加数据！', {
			icon : 7,
			area : [ '400px', '' ], // 宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
	}
};

/**
 * 详细页
 * 
 * @param id
 */
SysSearchIndex.prototype.detail = function(id) {
	this.detailIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '详细',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, // 不显示最大化最小化按钮
		content : this.getUrl() + 'Detail/' + id
	});
};

/**
 * 删除
 */
SysSearchIndex.prototype.del = function() {
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

/**
 * 重载数据
 */
SysSearchIndex.prototype.reLoad = function() {
	var searchdata = {
		keyWord : null,
		param : JSON.stringify(serializeObject($(this._formId)))
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
