function SysLookup(datagrid, url, formSub, dataGridColModel, searchDialogSub,
		pid, searchSubNames, demoSubUser_KeyWord) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this._searchDialogId = "#" + searchDialogSub;
	this.searchForm = "#" + formSub;
	this.pid = pid;
	this._datagridId = "#" + datagrid;
	this.Toolbardiv = "#t_" + datagrid;
	this.Toolbar = "#toolbar_" + datagrid;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this._keyWordId = "#" + demoSubUser_KeyWord;
	this._searchNames = searchSubNames;
	this.dataGridColModel = dataGridColModel;
	
	this.notnullFiled=["lookupCode","lookupName","displayOrder"];//非空字段
	this.notnullFiledComment=["代码编码","代码名称","显示顺序"]; //非空字段注释
	//除时间,数字等类型长度校验字段
	this.lengthValidFiled = ["lookupCode","lookupName","lookupDesc"];
	//除时间,数字等类型长度校验字段注释
	this.lengthValidFiledComment = ["代码编码","代码名称","代码描述"];
	//
	this.lengthValidFiledSize = [50,50,50];
	this.init.call(this);
};
//初始化操作
SysLookup.prototype.init = function(pid) {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl() + 'getSysLookup',
		postData : {
			pid : _self.pid
		},
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height() - 120 - 17,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		scrollOffset : 10, //设置垂直滚动条宽度
		altRows : true,
		pagerpos : 'left',
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		// rowNum : 2000,
		styleUI : 'Bootstrap',
		cellsubmit : 'clientArray',
		cellEdit : true,
		viewrecords : true, //
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
		sortname: 'displayOrder',
		sortorder: 'asc',  
		sortable:true,
        rowNum : 20,
        rowList : [ 200, 100, 50, 30, 20, 10 ],
        userDataOnFooter : true,
        hasTabExport:false, //导出
        hasColSet:false,  //设置显隐
        pager : _self.Pagerlbar,
		responsive : true
	});

	$(_self.Toolbardiv).append($(_self.Toolbar));

	$('.date-picker').datepicker({
		beforeShow : function() {
			setTimeout(function() {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
	});
	$('.time-picker').datetimepicker({
		oneLine : true,//单行显示时分秒
		closeText : '确定',//关闭按钮文案
		showButtonPanel : true,//是否展示功能按钮面板
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
	$(_self._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_self.searchByKeyWord();
		}
	});
};

var newRowIndex = 0;
var newRowStart = "new_row";
//添加页面
SysLookup.prototype.insert = function() {
	if (this.pid == null || this.pid == "") {
		layer.alert('请选择一个通用代码类型！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData');
	if(rowData.length > 0){
		$(this._datagridId).jqGrid('endEditCell');
	}
	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID : newRowId,
		initdata : {validFlag:'1',validFlagAlias:'有效'},
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
//打开语言选择
SysLookup.prototype.openLanguageForm=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择要设置的数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title:'提示'
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('只允许选择一条数据，进行设置！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title:'提示'
		});
		return false;
	}
	this.chooseL = layer.open({
		type : 2,
		area : [ '50%', '50%' ],
		title : '多语言设置',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : 'console/lookup/operation/chooseLanguage/2/'+ids[0]
	});
	
};
//修改页面
SysLookup.prototype.modify = function() {
	if (this.pid == null || this.pid == "") {
		layer.alert('请选择一条主表数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return false;
	}
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return false;
	} else if (ids.length > 1) {
		layer.alert('请选择一条数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
		return false;
	}

	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
		type : 2,
		title : '编辑',
		skin : 'bs-modal',
		area : [ '100%', '100%' ],
		maxmin : false,
		content : this.getUrl() + 'Edit/' + rowData.id
	});
};
//详细页
SysLookup.prototype.detail = function(id) {
	this.detailIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '详细页',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : this.getUrl() + 'Detail/' + id
	});
};
//控件校验   规则：表单字段name与rules对象保持一致
SysLookup.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			sysLookupTypeId : {
				maxlength : 50
			},
			displayOrder : {
				number : true
			},
			lookupCode : {
				maxlength : 1000
			},
			validFlag : {
				maxlength : 1
			},
			systemFlag : {
				maxlength : 1
			},
		}
	});
}

/**
 * 非空验证
 * @param 
 * @param 
 */
SysLookup.prototype.nullvalid = function(data, item, nullfiled,
		notnullFiledComment) {
	var msg = "";
	$.each(data, function(i, dataitem) {
		if (dataitem[item] == "") {
			temp = false;
			msg = notnullFiledComment[$.inArray(item, nullfiled)] + "不允许为空！请输入或选择";
		}
	})
	return msg;
}
/**
 * 长度验证
 * @param 
 * @param 
 */
SysLookup.prototype.lengthvalid = function(data, item, lengthValidFiled,
		lengthValidFiledComment, lengthValidFiledSize) {
	var msg = "";
	$.each(
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
		});
	return msg;
}
//保存功能
SysLookup.prototype.save = function() {
	var _self = this;	
	var rowData = $(this._datagridId).jqGrid('getRowData');
	if(rowData.length > 0){
		$(this._datagridId).jqGrid('endEditCell');
	}
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
				title:'提示'
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
					title:'提示'
				});
				hasvalidate = false;
				return false;
			}
		}
	});
	if (!hasvalidate) {
		return false;
	}
	if (data && data.length > 0 && rowData.length > 0) {
		for ( var i = 0; i < data.length; i++) {
			if (data[i].id.indexOf(newRowStart) > -1) {
				data[i].id = '';
			}
		}
		avicAjax.ajax({
			url : _self.getUrl() + "save",
			data : {
				data : JSON.stringify(data),
				typeid : _self.pid
			},
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag == "success") {
					_self.reLoad();
					layer.msg('保存成功！');
				} else {
					layer.alert('保存失败！' + r.error, {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0,
						title:'提示'
					});
				}
			}
		});
	} else {
		if(rowData.length > 0){
			layer.alert('请先修改数据！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
				title:'提示'
			});
		}else{
			layer.alert('请先添加数据！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
				title:'提示'
			});
		}
	}
};
//删除
SysLookup.prototype.del = function() {
	var _self = this;
	var hasNewRow = false;
	var rowsdata = $(_self._datagridId).jqGrid('getRowData');
	for(var k = 0 ; k< rowsdata.length; k++){
		if(rowsdata[k].id == ""){
			hasNewRow = true;
			break;
		}
	}
		
	var rows = $(_self._datagridId).jqGrid('getGridParam', 'selarrrow');
	var isAddRow = false; //是新增行
    var notAddRow = false; //不是新增行
    var ids = [];
	var l = rows.length;
	if (l > 0) {
		for (var i = 0; i < l;i++) {
			if(rows[i].indexOf("new_row") != -1){
				isAddRow = true;
			}else{
				notAddRow = true;
			}
			ids.push(rows[i]);
		}
	}
	if((isAddRow && notAddRow) || (hasNewRow)){
		layer.alert('请确保上一条数据修改完毕！', {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
				title:'提示'
			});	 
		return false;
	}else if(isAddRow && !notAddRow){
		for(var i = 0; i < ids.length;i++){
		   $(_self._datagridId).jqGrid('delRowData', ids[i]);
	    }
		return false;
	}
	if (l > 0) {
		layer.confirm('确认要删除选择的数据吗?', {
			icon : 3,
			title : "提示",
			area : [ '400px', '' ]
		}, function(index) {
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
							closeBtn : 0
						});
					}
				}
			});
			layer.close(index);
		});
	} else {
		layer.alert('请选择要删除的数据！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0,
			title:'提示'
		});
	}
};
//重载数据
SysLookup.prototype.reLoad = function(pid) {
	if (pid != undefined) {
		this.pid = pid;
	}
	var searchdata = {
		pid : pid
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关闭对话框
SysLookup.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else if(id="chooseL"){
		layer.close(this.chooseL);
	}else{
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
SysLookup.prototype.openSearchForm = function(searchDiv, par) {
	var _self = this;
	par = null;
	//if(!par) par = $(window);
	var contentWidth = 600; //(par.width()*.6 >= 600)?600:par.width()*.6;
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
			layer.close(index);
		},
		btn2 : function(index, layero) {
			_self.clearData();
			return false;
		},
		btn3 : function(index, layero) {

		}
	});
};
//高级查询
SysLookup.prototype.searchData = function() {
	var searchdata = {
		keyWord : null,
		pid : this.pid,
		param : JSON.stringify(serializeObject($(this.searchForm)))
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关键字段查询
SysLookup.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder") ? "" :  $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for ( var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}

	var searchdata = {
		keyWord : JSON.stringify(param),
		pid : this.pid,
		param : null
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
}
//隐藏查询框
SysLookup.prototype.hideSearchForm = function() {
	layer.close(searchDialogindex);
};
/*清空查询条件*/
SysLookup.prototype.clearData = function() {
	clearFormData(this.searchForm);
	this.searchData();
};
