/**
 * 初始化对象
 * @param datagrid 表格Id
 * @param url URL参数
 * @param searchDialogId 高级查询Id
 * @param form 高级查询formId
 * @param keyWordId 关键字查询框Id
 * @param searchNames 关键字查询项名称Array
 * @param dataGridColModel 表格列属性Array
 */
function SysLanguage(datagrid, url, searchDialogId, form, keyWordId,
		searchNames, dataGridColModel) {
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
	this.dataGridColModel = dataGridColModel;
	this.notnullFiled = [];//非空字段
	this.notnullFiledComment = []; //非空字段注释
	//除时间,数字等类型长度校验字段
	this.lengthValidFiled = [];
	//除时间,数字等类型长度校验字段注释
	this.lengthValidFiledComment = [];
	//除时间,数字等类型长度
	this.lengthValidFiledSize = [];
	this.init.call(this);
};

/**
 * 初始化操作
 */
SysLanguage.prototype.init = function() {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl() + 'getSysLanguagesByPage.json',
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
		onCellSelect: function(rowid,iCol,cellcontent,e){
			var isSystemDefault = $(this).jqGrid('getCell',rowid,"isSystemDefault");
			if(isSystemDefault == "是"){
				layer.msg('系统默认语言不允许修改！');
				$(this).jqGrid('setCell', rowid, $(this).jqGrid('getGridParam',"colModel")[iCol].name, '', 'not-editable-cell'); 
				return false;
			}
		},
		styleUI : 'Bootstrap', //Bootstrap风格
		viewrecords : true, //是否要显示总记录数
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
		multiselect : true,//可多选
		autowidth : true,//列宽度自适应
		responsive : true,//开启自适应
		pager : "#jqGridPager",
		cellEdit : true,
		cellsubmit : 'clientArray'
	});

	//放入表格toolbar中
	$(this._jqgridToolbar).append($("#tableToolbar"));

	//初始化时间控件
	$('.date-picker').datepicker({
		beforeShow : function() {
			setTimeout(function() {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
	});
	$('.time-picker').datetimepicker({
		oneLine : true,//单行显示时分秒
		showButtonPanel : true,//是否展示功能按钮面板
		closeText : '确定',
		showSecond : false,//是否可以选择秒，默认否
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
	//初始化校验字段
	_self.notnullFiled.push("languageCode");
	_self.notnullFiledComment.push("语言代码 比如：ZH,EN,GB");
	_self.lengthValidFiled.push("languageCode");
	_self.lengthValidFiledSize.push(50);
	_self.notnullFiled.push("languageName");
	_self.notnullFiledComment.push("语言名称");
	_self.lengthValidFiled.push("languageName");
	_self.lengthValidFiledSize.push(50);
};
/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
SysLanguage.prototype.insert = function() {
	$(this._datagridId).jqGrid('endEditCell');
	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID : newRowId,
		initdata : {isSystemDefault:0},
		position : "first",
		useDefValues : true,
		useFormatter : true,
		addRowParams : {
			extraparam : {}
		}
	}
	$(this._datagridId).jqGrid('addRow', parameters);
	newRowIndex++;
};

/**
 * 非空验证
 * @param 
 * @param 
 */
SysLanguage.prototype.nullvalid = function(data, item, nullfiled,
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
 * 长度验证
 * @param 
 * @param 
 */
SysLanguage.prototype.lengthvalid = function(data, item, lengthValidFiled,
		lengthValidFiledComment, lengthValidFiledSize) {
	var msg = "";
	$
			.each(
					data,
					function(i, dataitem) {
						if (dataitem[item] != ""
								&& dataitem[item]
										.replace(/[^\x00-\xff]/g, "**").length > lengthValidFiledSize[$
										.inArray(item, lengthValidFiled)]) {
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
 * @param form
 * @param callback
 */
SysLanguage.prototype.save = function() {
	var _self = this;
	$(this._datagridId).jqGrid('endEditCell');
	var data = $(this._datagridId).jqGrid('getChangedCells');
	var hasvalidate = true;
	$.each(_self.notnullFiled, function(i, item) {
		var msg = _self.nullvalid(data, item, _self.notnullFiled,
				_self.notnullFiledComment);
		if (msg && msg.length > 0) {
			layer.alert(msg, {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
				title : '提示'
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
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					title : '提示'
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
		for ( var i = 0; i < data.length; i++) {
			if (data[i].id.indexOf(newRowStart) > -1) {
				data[i].id = '';
			}
			if(data[i].isSystemDefault=="是"){
				data[i].isSystemDefault = 1;
			}else{
				data[i].isSystemDefault = 0;
			}
		}

		avicAjax.ajax({
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
				} else {
					layer.alert('保存失败！' + r.e, {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0,
						title : '提示'
						
					});
				}
			}
		});
	} else {
		layer.alert('没有修改数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			 title:'提示',
			closeBtn : 0
		});
	}
};

/**
 * 详细页
 * @param id
 */
SysLanguage.prototype.detail = function(id) {
	this.detailIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '详细',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //不显示最大化最小化按钮
		content : this.getUrl() + 'Detail/' + id
	});
};

/**
 * 删除
 */
SysLanguage.prototype.del = function() {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    var rowData = "";
    if(rows != null && rows != "" && rows !=undefined){
    	for (var i = 0; i < rows.length; i++) {
            //选中行完整数据
			rowData = $(this._datagridId).jqGrid('getRowData', rows[i]);
			if(rowData.isSystemDefault == "是"){
				layer.msg('系统默认语言不允许删除！');
				return false;
			}
    	}
	}
	var _self = this;
	var ids = [];
	var l = rows.length;
	var datas=$(this._datagridId).jqGrid('getRowData');//-获取所有数据
	if(datas.length==1){
		layer.msg('只有一条记录不允许删除！');
		return ;
	}
	if (l > 0) {
		layer.confirm('确认要删除选择的数据吗?', {
			icon : 3,
			closeBtn: 0,
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
							title : "提示",
						});
					}
				}
			});
			layer.close(index);
		});
	} else {
		layer.alert('请选择要删除的数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  title:'提示'
			}
		);
	}
};

/**
 * 重载数据
 */
SysLanguage.prototype.reLoad = function() {
	var searchdata = {
		keyWord : null,
		param : JSON.stringify(serializeObject($(this._formId)))
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

/**
 * 打开高级查询框
 * @param searchBtn 高级查询按钮HTMLObject对象
 * @param contentWidth 高级查询框宽度
 * @param contentHeight 高级查询框高度
 */
SysLanguage.prototype.openSearchForm = function(searchDiv) {
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
		},
		yes : function(index, layero) {
			_self.searchData();
			layer.close(index);//查询框关闭
		},
		btn2 : function(index, layero) {
			clearFormData(_self._formId); //清空数据
			_self.searchData(); //查询
			return false;
		},
		btn3 : function(index, layero) {

		}
	});
};

/**
 * 高级查询
 */
SysLanguage.prototype.searchData = function() {
	var searchdata = {
		keyWord : null,
		param : JSON.stringify(serializeObject($(this._formId)))
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

/**
 * 关键字查询
 */
SysLanguage.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val();
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
