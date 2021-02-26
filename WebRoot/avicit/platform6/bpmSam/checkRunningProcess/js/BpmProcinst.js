function BpmProcinst(datagrid, url, formSub, dataGridColModel, searchDialogSub, pid, nodeType,searchSubNames, bpmHistProcinst_KeyWord,pdId) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this.pageId = datagrid+"Pager";
	this._searchDialogId = "#" + searchDialogSub;
	this.searchForm = "#" + formSub;
	this.pid = pid;
	this.nodeType = nodeType;
	this._datagridId = "#" + datagrid;
	this.Toolbardiv = "#t_" + datagrid;
	this.Toolbar = "#toolbar_" + datagrid;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this._keyWordId = "#" + bpmHistProcinst_KeyWord;
	this._searchNames = searchSubNames;
	this.dataGridColModel = dataGridColModel;
	this.pdId = pdId;
	this.init.call(this);
}
;
//初始化操作
BpmProcinst.prototype.init = function(pid,nodeType) {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl(),
		postData : {
			pdIds:_self.pdId
		},
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height() - 120 - 17, //120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		scrollOffset : 10, //设置垂直滚动条宽度
		rowNum : 10,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		pagerpos : 'left',
		loadComplete : function() {
			$("#set_"+_self.pageId).remove();
            $("#exportExcel_"+_self.pageId).remove();
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		viewrecords : true, //
		styleUI : 'Bootstrap',
		multiselect : false,
		autowidth : true,
		rownumbers:true,//显示行号
		shrinkToFit : true,
		responsive : true, //开启自适应
		pager : _self.Pagerlbar
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
		oneLine : true, //单行显示时分秒
		closeText : '确定', //关闭按钮文案
		showButtonPanel : true, //是否展示功能按钮面板
		showSecond : false, //是否可以选择秒，默认否
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
//添加页面
BpmProcinst.prototype.insert = function(pid) {
	if (this.pid == null || this.pid == "") {
		layer.alert('请选择一条主表数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		}
		);
		return false;
	}
	this.insertIndex = layer.open({
		type : 2,
		title : '添加',
		skin : 'bs-modal',
		area : [ '100%', '100%' ],
		maxmin : false,
		content : this.getUrl() + 'Add/null'
	});
};
//修改页面
BpmProcinst.prototype.modify = function() {
	if (this.pid == null || this.pid == "") {
		layer.alert('请选择一条主表数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		}
		);
		return false;
	}
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	if (ids.length == 0) {
		layer.alert('请选择数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		}
		);
		return false;
	} else if (ids.length > 1) {
		layer.alert('请选择一条数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		}
		);
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
BpmProcinst.prototype.detail = function(id) {
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
BpmProcinst.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			
		}
	});
}

//重载数据
BpmProcinst.prototype.reLoad = function(pid,nodeType,pdId) {
	if (pid != undefined) {
		this.pid = pid;
	}
	if(nodeType!=undefined){
		this.nodeType = nodeType;
	}
	if(pdId != undefined){
		this.pdId = pdId;
	}
	
	var searchdata = {
		id : pid,
		nodeType:nodeType,
		pdId:pdId
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关闭对话框
BpmProcinst.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
//关键字段查询
BpmProcinst.prototype.searchByKeyWord = function() {
    var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder")? "" : $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for (var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}

	var searchdata = {
		keyWord : JSON.stringify(param),
		id : this.pid,
		pdId:this.pdId,
		param : null,
		nodeType:this.nodeType
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
}
//隐藏查询框
BpmProcinst.prototype.hideSearchForm = function() {
	layer.close(searchDialogindex);
};
/*清空查询条件*/
BpmProcinst.prototype.clearData = function() {
	clearFormData(this.searchForm);
	//this.searchData();
};

BpmProcinst.prototype.processVariable = function(processInstanceId){
	var url = "avicit/platform6/bpmreform/bpmmonitor/processVar.jsp?processInstanceId="+processInstanceId;
	
	processVariableDialog = layer.open({
        type: 2,
        title: '流程实例变量',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content:url
       });
	
};

BpmProcinst.prototype.processTrace = function(entryid){
	
	var url = "avicit/platform6/bpmreform/bpmdesigner/picture/picAndTracks.jsp?entryId="+entryid;
	
	processVariableDialog = layer.open({
        type: 2,
        title: '流程跟踪',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content:url
       });
};
