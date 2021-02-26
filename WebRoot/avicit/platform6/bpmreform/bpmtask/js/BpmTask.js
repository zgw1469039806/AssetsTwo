function BpmTask(datagrid, url, formSub, dataGridColModel, searchDialogSub, nodeId, nodeType,searchSubNames, bpmHistProcinst_KeyWord,pdId,tabId,tabName,multiselect) {
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
	this.multiselect = multiselect;//是否显示复选框 true:显示 false：不显示
	this.init.call(this);
}
;
//初始化操作
BpmTask.prototype.init = function() {
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
		height : $(window).height() - 115, //120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		scrollOffset : 10, //设置垂直滚动条宽度
		rowNum : 10,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		pagerpos : 'left',
		loadComplete : function(data) {
			$("#set_"+_self.pageId).remove();
            $("#exportExcel_"+_self.pageId).remove();
			$(this).jqGrid('getColumnByUserIdAndTableName');
			_self.afterQuery(data);
		},
		viewrecords : true, //
		styleUI : 'Bootstrap',
		multiselect : _self.multiselect,
		autowidth : true,
		shrinkToFit : true,
		forceFit: true,
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

BpmTask.prototype.afterQuery = function(data){	
	//设置待阅的条数
	if(data.readCount!=undefined && data.readCount!=null){
		var tabName = '我的待阅'+'(<span style="color:red">'+data.readCount+'</span>)';
		$('#tab2', window.parent.document).html(tabName);
	}
	
	//设置待办的条数
	if(data.todoCount!=undefined && data.todoCount!=null){
		var tabName = '我的待办'+'(<span style="color:red">'+data.todoCount+'</span>)';
		$('#tab1', window.parent.document).html(tabName);
	}
	$("[data-toggle='popover']").popover({html:true,trigger:'hover'});
};


//控件校验   规则：表单字段name与rules对象保持一致
BpmTask.prototype.formValidate = function(form) {
	form.validate({
		rules : {
			
		}
	});
};

//重载数据
BpmTask.prototype.reLoad = function(nodeId,nodeType,pdId) {
	$(".popover").remove();
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
BpmTask.prototype.closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
BpmTask.prototype.openSearchForm = function(searchDiv, par) {
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
BpmTask.prototype.searchData = function() {
	var searchdata = {
		nodeId : this.nodeId,
		nodeType:this.nodeType,
		pdId:this.pdId,
		searchParam : JSON.stringify(serializeObject($(this.searchForm)))
	};
	var processStartTimeBegin = $(this.searchForm).find("#processStartTimeBegin").val();
	var processStartTimeEnd = $(this.searchForm).find("#processStartTimeEnd").val();
	if(processStartTimeBegin!=null && processStartTimeBegin!=''
	  && processStartTimeEnd!=null && processStartTimeEnd!=''){
		if(processStartTimeBegin>processStartTimeEnd){
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
BpmTask.prototype.searchByKeyWord = function() {
	//var keyWord = $(this._keyWordId).val();
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
BpmTask.prototype.searchByPriority = function(priority) {
	

	var searchdata = {
		priority : priority,
		nodeId : this.nodeId,
		nodeType:this.nodeType,
		pdId:this.pdId
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

BpmTask.prototype.searchByAcceptDate = function(acceptDateBegin,acceptDateEnd) {
	
	var searchdata = {
		acceptDateBegin : acceptDateBegin,
		acceptDateEnd:acceptDateEnd,
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
BpmTask.prototype.hideSearchForm = function() {
	layer.close(searchDialogindex);
};
/*清空查询条件*/
BpmTask.prototype.clearData = function() {
	clearFormData(this.searchForm);
	//this.searchData();
};


BpmTask.prototype.processTrace = function(entryid){
	
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

BpmTask.prototype.batchExecuteTask = function(){
	var idDatas = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='' || idDatas.length<1) {
		layer.alert('请选择要办理的记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}	
	var ids = '';
	var entryIds = '';
	var executionIds = '';
	var businessIds = '';
	var urls = '';
	var taskNames = '';

	for ( var i = 0; i < idDatas.length; i++) {
		var rowData = $(this._datagridId).jqGrid('getRowData', idDatas[i]);
		if(ids==''){
			ids = rowData.dbid;
			entryIds = rowData.processInstance;
			executionIds = rowData.executionId;
			businessIds = rowData.businessId;
			urls = rowData.formResourceName;
			taskNames = rowData.taskName;
		}else{
			ids = ids + ',' + rowData.dbid;
			entryIds = entryIds +','+ rowData.processInstance;
			executionIds = executionIds +','+ rowData.executionId;
			businessIds = businessIds +','+ rowData.businessId;
			urls = urls +','+ rowData.formResourceName;
			taskNames = taskNames +','+ rowData.taskName;
		}
	}
	
	flowUtils.doBatchHandleRequired(entryIds,executionIds,ids,businessIds,urls,taskNames);
};

BpmTask.prototype.del = function(){
	var _self = this;
	var idDatas = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='') {
		layer.alert('请选择要取消的关注！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}	
	var dbids = '';
	for ( var i = 0; i < idDatas.length; i++) {
		var rowData = $(_self._datagridId).jqGrid('getRowData', idDatas[i]);
		dbids += rowData.dbid + ',';
	}
	
	flowUtils.confirm('您确认要取消关注吗?', function (index) {
        avicAjax.ajax({
            url: "platform/bpm/clientbpmoperateaction/delete",
            data: "dbids=" + dbids,
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

BpmTask.prototype.cleanAll = function(){
	/*var _self = this;
	var idDatas = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='') {
		layer.alert('请选择要清空的记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}*/
	flowUtils.cleanAll();
};



BpmTask.prototype.del1 = function(){
	var _self = this;
	var idDatas = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='') {
		layer.alert('请选择要取消的关注！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}	
	var dbids = '';
	for ( var i = 0; i < idDatas.length; i++) {
		var rowData = $(_self._datagridId).jqGrid('getRowData', idDatas[i]);
		dbids += rowData.task_dbid_ + ',';
	}
	
	flowUtils.confirm('您确认要取消关注吗?', function (index) {
        avicAjax.ajax({
            url: "platform/bpm/clientbpmoperateaction/delete",
            data: "dbids=" + dbids,
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

BpmTask.prototype.attTask = function(dbid){
	var _self = this;
	flowUtils.confirm("确定取消关注吗？", function(){
		avicAjax.ajax({
			type : "POST",
			data : {
				dbid : dbid,
			},
			url : "bpm/clientbpmoperateaction/cancelFocusedTask",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					flowUtils.success("操作成功！", function() {
						_self.reLoad(_self.nodeId,_self.nodeType,_self.pdId);
					}, true);
				}
			}
		});
	});
}

BpmTask.prototype.batchReadTask = function(){
	var idDatas = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='' || idDatas.length<1) {
		layer.alert('请选择要阅读的记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}	
	var ids = '';
	var entryIds = '';
	var executionIds = '';
	for ( var i = 0; i < idDatas.length; i++) {
		var rowData = $(this._datagridId).jqGrid('getRowData', idDatas[i]);
		if(ids==''){
			ids = rowData.dbid;
			entryIds = rowData.processInstance;
			executionIds = rowData.executionId;
		}else{
			ids = ids + ',' + rowData.dbid;
			entryIds = entryIds +','+ rowData.processInstance;
			executionIds = executionIds +','+ rowData.executionId;
		}
	}
	
	flowUtils.doBatchRead(entryIds,executionIds,ids);
	
};
