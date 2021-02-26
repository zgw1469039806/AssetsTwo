function BpmProcInst(datagrid, url, formSub, dataGridColModel, searchDialogSub, nodeId, nodeType,searchSubNames, bpmHistProcinst_KeyWord,pdId,tabId,tabName) {
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
	this.nodeId = nodeId;
	this.nodeType = nodeType;
	this._datagridId = "#" + datagrid;
	this.Toolbardiv = "#t_" + datagrid;
	this.Toolbar = "#toolbar_" + datagrid;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this._keyWordId = "#" + bpmHistProcinst_KeyWord;
	this._searchNames = searchSubNames;
	this.dataGridColModel = dataGridColModel;
	this.pdId = pdId;
	this.tabId = tabId;
	this.tabName = tabName;
	this.init.call(this);
}
;
//初始化操作
BpmProcInst.prototype.init = function() {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl(),
		postData : {
			nodeId : _self.nodeId,
			nodeType:_self.nodeType,
			pdId:_self.pdId,
			isInit:'1'
		},
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height() - 115 , //120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		scrollOffset : 10, //设置垂直滚动条宽度
		rowNum : 10,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		pagerpos : 'left',
		loadComplete : function(data) {
			$("#set_"+_self.pageId).remove();
			$("#exportExcel_"+_self.pageId).remove();
			_self.afterQuery(data);
		},
		viewrecords : true, //
		styleUI : 'Bootstrap',
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true, //开启自适应
		forceFit: true,
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

BpmProcInst.prototype.afterQuery = function(data){
	if(data.records!=undefined && data.records!=null){
		if(this.tabId == "tab1"){
			var tabName = '我的草稿'+'(<span style="color:red">'+data.records+'</span>)';
			$('#tab1', window.parent.document).html(tabName);
		}else if(this.tabId == "tab2"){
			var tabName = '我的申请'+'(<span style="color:red">'+data.records+'</span>)';
			$('#tab2', window.parent.document).html(tabName);
		}else if(this.tabId == "tab3"){
			var tabName = '我的经办'+'(<span style="color:red">'+data.records+'</span>)';
			$('#tab3', window.parent.document).html(tabName);
		}
	}
};

BpmProcInst.prototype.del = function(){
	var _self = this;
	var idDatas = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='') {
		layer.alert('请选择要删除的记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}	
	var entryIds = '';
	var ids = '';
	for ( var i = 0; i < idDatas.length; i++) {
		var rowData = $(_self._datagridId).jqGrid('getRowData', idDatas[i]);
		entryIds += rowData.dbId + ',';
		ids += rowData.executionId + ',';
	}
	
	flowUtils.confirm('您确认要删除流程实例吗?', function (index) {
        avicAjax.ajax({
            url: "platform/bpm/bpmConsoleAction/deleteProcessEntry",
            data: "processInstanceId=" + ids+"&entryId=" + entryIds,
            type: "post",
            dataType: "json",
            success: function (backData) {
            	if (backData != null && backData.success == true) {
            		 layer.msg('操作成功');     
            		 _self.reLoad(_self.nodeId,_self.nodeType,_self.pdId);
            	} else {
            		layer.msg('操作失败');
            	}	               
            }
        });
    });	
};

BpmProcInst.prototype.update = function(){
	var idDatas = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='' || idDatas.length>1) {
		layer.alert('请选择一条要修改的记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}	
	var rowData = $(this._datagridId).jqGrid('getRowData', idDatas[0]);
	flowUtils.detailByManager(rowData.dbId);
};

//控件校验   规则：表单字段name与rules对象保持一致
BpmProcInst.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			
		}
	});
};

//重载数据
BpmProcInst.prototype.reLoad = function(nodeId,nodeType,pdId) {
	if (nodeId != undefined) {
		this.nodeId = nodeId;
	}
	if(nodeType!=undefined){
		this.nodeType = nodeType;
	}
	if(pdId != undefined){
		this.pdId = pdId;
	}
	
	var searchdata = {
		nodeId : nodeId,
		nodeType:nodeType,
		pdId:pdId
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关闭对话框
BpmProcInst.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
BpmProcInst.prototype.openSearchForm = function(searchDiv, par) {
	var _self = this;
	par = null;
	//if(!par) par = $(window);
	var contentWidth = 600; //(par.width()*.6 >= 600)?600:par.width()*.6;
	var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
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
		area : [ contentWidth + 'px', '350px' ],
		offset : [ top + 'px', left + 'px' ],
		closeBtn : 0,
		shadeClose : true,
		btn : [ '查询', '清空', '取消' ],
		content : $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $('<div class="serachLabel"><span>' + text + '</span><span class="caret"></span></div>').appendTo(layero);
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
		btn3 : function(index, layero) {}
	});
};
//高级查询
BpmProcInst.prototype.searchData = function() {
	var searchdata = {
		nodeId : this.nodeId,
		nodeType:this.nodeType,
		pdId:this.pdId,
		searchParam : JSON.stringify(serializeObject($(this.searchForm)))
	};
	var startDateBegin = $(this.searchForm).find("#startDateBegin").val();
	var startDateEnd = $(this.searchForm).find("#startDateEnd").val();
	if(startDateBegin!=null && startDateBegin!=''
		&& startDateEnd!=null && startDateEnd!=''){
		if(startDateBegin>startDateEnd){
			layer.alert('开始日期不能大于截止日期！', {
				icon : 7,
				area : [ '400px', '' ],
				closeBtn : 0
			});
			return;
		}
	}
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
//关键字段查询
BpmProcInst.prototype.searchByKeyWord = function() {
	var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder")? "" : $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for (var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}

	var searchdata = {
		keyWord : JSON.stringify(param),
		nodeId : this.nodeId,
		nodeType:this.nodeType,
		pdId:this.pdId
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

//关键字段查询
BpmProcInst.prototype.queryByState = function(state) {
	var searchdata = {
		businessState : state,
        nodeId : this.nodeId,
        nodeType:this.nodeType,
        pdId:this.pdId
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

BpmProcInst.prototype.searchByStartDate = function(startDateBegin,startDateEnd) {
	
	var searchdata = {
		startDateBegin : startDateBegin,
		startDateEnd:startDateEnd,
		nodeId : this.nodeId,
		param : null,
		nodeType:this.nodeType,
		pdId:this.pdId
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

//隐藏查询框
BpmProcInst.prototype.hideSearchForm = function() {
	layer.close(searchDialogindex);
};
/*清空查询条件*/
BpmProcInst.prototype.clearData = function() {
	clearFormData(this.searchForm);
	//this.searchData();
};


BpmProcInst.prototype.processTrace = function(entryid){
	flowUtils.detail(entryid);
};

