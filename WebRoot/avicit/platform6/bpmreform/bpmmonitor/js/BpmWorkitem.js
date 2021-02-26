function BpmWorkitem(datagrid, url,dataGridColModel,processInstanceId,executionid,processState) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this.pageId = datagrid+"Pager";
	this._datagridId = "#" + datagrid;
	this.Toolbardiv = "#t_" + datagrid;
	this.Toolbar = "#toolbar_" + datagrid;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this.dataGridColModel = dataGridColModel;
	this.processInstanceId = processInstanceId;
	this.executionid = executionid;
	this.processState = processState;
	this.init.call(this);
};
//初始化操作
BpmWorkitem.prototype.init = function() {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl(),
		postData : {
		},
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height() - 120 - 17, //120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		scrollOffset : 10, //设置垂直滚动条宽度
		rowNum : 20,
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
		multiselect : true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true, //开启自适应
		pager : _self.Pagerlbar
	});

	$(_self.Toolbardiv).append($(_self.Toolbar));

};

//重载数据
BpmWorkitem.prototype.reLoad = function() {
	var searchdata = {

	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

BpmWorkitem.prototype.addPerformer = function(){
	var _self = this;
	var idDatas = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='') {
		layer.alert('请选择一条记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}

	if(idDatas.length>1){
		layer.alert('只能选择一条记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}

	var rowData = $(_self._datagridId).jqGrid('getRowData', idDatas[0]);
	var taskId = rowData.dbid_;
	var todoType = rowData.task_type_;
	var executionId = rowData.execution_;
	selectedTaskName = rowData.task_name_;
	//var todoState = data.task_state_;
	var state = rowData.state_;
	//var todoFinished = data.task_finished_;
	if (state != 'completed' && todoType == 0) {

	} else {
		layer.alert('不能选择已经完成的或者待阅工作项!', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return false;
	}
	if (_self.state == 'ended' || _self.state == 'suspended') {
		layer.alert('结束和挂起的流程不能操作！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return false;
	}
	var flowButtons = new FlowButtons();
	flowButtons.adduser(_self.processInstanceId, executionId, taskId, '', '');

};

BpmWorkitem.prototype.delPerformer = function(){
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
	if(idDatas.length>1){
		layer.alert('只能选择一条要删除的记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}

	var rowData = $(_self._datagridId).jqGrid('getRowData', idDatas[0]);
	var userid = rowData.assignee_;
	var todoType = rowData.task_type_;
	var processState = rowData.state_;
    var executionId = rowData.execution_;
	if (!((processState == null || processState == '') && todoType == 0)) {
		layer.alert('该工作项不能删除！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}

	var datas = $(_self._datagridId).jqGrid('getRowData');
	var executeCountArr = [];
	for (var i = 0; i < datas.length; i++) {

		var todoType = datas[i].task_type_;
		var processState = datas[i].state_;
		var execution_ = datas[i].execution_;
		if (processState != '已办(completed)' && todoType == 0) {
			if(executeCountArr.length<1){
				var execute = {};
				execute.execution_ = execution_;
				execute.count = 1;
				executeCountArr.push(execute);
			}else{
				var hasExist = false;
				for(var j=0;j<executeCountArr.length;j++){
					if(executeCountArr[j].execution_ ==  execution_){
						executeCountArr[j].count = executeCountArr[j].count+1;
						hasExist = true;
					}
				}
				if(!hasExist){
					var execute = {};
					execute.execution_ = execution_;
					execute.count = 1;
					executeCountArr.push(execute);
				}
			}
		}
	}
	for(var m=0;m<executeCountArr.length;m++){
		//判断当前删除的待办是不是只有一条
		if(executionId==executeCountArr[m].execution_ && executeCountArr[m].count<2){
			layer.alert('当前流程或分支只剩一条待办任务，不能删除！', {
				icon : 7,
				area : [ '400px', '' ],
				closeBtn : 0
			});
			return;
		}
	}

	/*if (counts == 1) {
		layer.alert('只剩最后一条未完成记录，不能操作此项！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}*/


	flowUtils.confirm('您确认要删除吗?', function (index) {
        avicAjax.ajax({
            url: "platform/bpm/bpmConsoleAction/doDeleteProcessTask",
            data: "userIds=" + userid+"&executionId="+executionId+"&processInstanceId="+_self.processInstanceId,
            type: "post",
            dataType: "json",
            success: function (backData) {
            	if (backData != null && (backData.mes == true || backData.success == true)) {
            		 layer.msg('操作成功');
            		 _self.reLoad();

            	} else {
            		layer.msg('操作失败');
            	}
            }
        });
    });
};

BpmWorkitem.prototype.addReader = function(){
	var _self = this;
	var idDatas = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='') {
		layer.alert('请您选择一条记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}

	var rowData = $(_self._datagridId).jqGrid('getRowData', idDatas[0]);
	var taskId = rowData.dbid_;
	var assignee = rowData.assignee_;
    var executionId = rowData.execution_;
	var flowButtons = new FlowButtons();
	flowButtons.dotaskreader(_self.processInstanceId, executionId, taskId, '', '');
};

BpmWorkitem.prototype.delReader = function(){
	var _self = this;
	var idDatas = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='') {
		layer.alert('请您选择一条记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}
	if(idDatas.length>1){
		layer.alert('只能选择一条要删除的记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}
	var rowData = $(_self._datagridId).jqGrid('getRowData', idDatas[0]);
	var taskId = rowData.dbid_;
	var state = rowData.state_;
	if(!('读者(reader)'==state)){
		layer.alert('只能删除读者！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}
	flowUtils.confirm('您确认要删除吗?', function (index) {
        avicAjax.ajax({
            url: "bpm/monitor/deleteHistoryTask",
            data: {
            	processInstanceId:_self.processInstanceId,
            	taskId:taskId
            },
            type: "post",
            dataType: "json",
            success: function (backData) {
            	if (backData != null && backData.success == true) {
            		 layer.msg('操作成功');
            		 _self.reLoad();

            	} else {
            		layer.msg('操作失败');
            	}
            }
        });
    });
};

BpmWorkitem.prototype.addTransfer = function(){
	var _self = this;
	var idDatas = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='') {
		layer.alert('请您选择一条记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}

	var rowData = $(_self._datagridId).jqGrid('getRowData', idDatas[0]);
	var taskId = rowData.dbid_;
	var assignee = rowData.assignee_;
    var executionId = rowData.execution_;
	var flowButtons = new FlowButtons();
	flowButtons.dotransmit(_self.processInstanceId, executionId, taskId, '', '',assignee);
};

BpmWorkitem.prototype.delTransfer = function(){
	var _self = this;
	var idDatas = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	if (idDatas == null || idDatas=='') {
		layer.alert('请您选择一条记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}
	if(idDatas.length>1){
		layer.alert('只能选择一条要删除的记录！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}
	var rowData = $(_self._datagridId).jqGrid('getRowData', idDatas[0]);
	var state = rowData.state_;
	if(!('传阅(transmit)'==state)){
		layer.alert('只能删除传阅人！', {
			icon : 7,
			area : [ '400px', '' ],
			closeBtn : 0
		});
		return;
	}
	var taskId = rowData.dbid_;
	flowUtils.confirm('您确认要删除吗?', function (index) {
        avicAjax.ajax({
            url: "bpm/monitor/deleteHistoryTask",
            data: {
            	processInstanceId:_self.processInstanceId,
            	taskId:taskId
            },
            type: "post",
            dataType: "json",
            success: function (backData) {
            	if (backData != null && backData.success == true) {
            		 layer.msg('操作成功');
            		 _self.reLoad();

            	} else {
            		layer.msg('操作失败');
            	}
            }
        });
    });
};
