function WorkHand(id, url, title, index) {
	this.url = url;
	this.title = title;
	this.index = index;
	this.id = id;
	this.idGrid = "#" + id + "Grid";
	this.queryParams = null;
	this.grid = null;
};
WorkHand.prototype.init = function() {
	var _self = this;
	this.grid = $(this.idGrid).datagrid({
		url : this.url,
		queryParams : this.queryParams,
		height : $(window).height() - 120-17
	});
};
WorkHand.prototype.setQueryParams = function(queryParams){
	this.queryParams = queryParams;
};
WorkHand.prototype.realod1 = function() {
	if (this.grid == null) {
		this.init();
	} else {
		this.grid.datagrid('load', this.queryParams).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	}
};
//打开详情页
WorkHand.prototype.workHandDetail = function(id){
	var url = "bpm/business/workhand/workHandDetailPage?id="+id;	
	workHandDetailDialog = layer.open({
        type: 2,
        title: '委托详情',
        area: ['100%', '100%'],
        maxmin: false,
        content:url
       });
};
//打开添加页
WorkHand.prototype.insert=function(){
    this.insertIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '新建委托',
        maxmin: false, //开启最大化最小化按钮
        content: 'avicit/platform6/bpmfixie/bpmbusiness/workhand/workDelegateAdd.jsp'
    });
};
//打开工作移交页
WorkHand.prototype.fetch = function() {
	this.fetchIndex = layer.open({
        type: 2,
        area: ['80%', '80%'],
        title: '工作移交',
        maxmin: false, //开启最大化最小化按钮
        scrollbar: false,
        content: 'avicit/platform6/bpmfixie/bpmbusiness/workhand/processWorkHandTask.jsp'
    });
}
//删除
WorkHand.prototype.deleteData=function(id) {
	var _self = this;
	$.messager.confirm('请确认','确定删除这条委托？',function(b){
		if(b){
        $.ajax({
            url  : "bpm/business/workhand/deleteSysWorkHand",
            data : {workhandIds:id},
            type : 'post',
            dataType : 'json',
            success : function(r){
            	$("#entrustGrid").datagrid("reload").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
            }
        });
        }
    });
};
//完成
WorkHand.prototype.completeData = function(id) {
	var _self = this;
	$.messager.confirm('请确认','您确定该条委托已经完成？',function(b){
		if(b){
        $.ajax({
            url  : "bpm/business/workhand/completeSysWorkHand",
            data : {workhandIds:id},
            type : 'post',
            dataType : 'json',
            success : function(r){
            	$("#entrustGrid").datagrid("reload").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
            }
        });
		}
    });
}
//驳回
WorkHand.prototype.rejectWorkhand = function(id) {
	var _self = this;
	$.messager.confirm('请确认','您确定驳回该委托吗？',function(b) {
		if(b){
        $.ajax({
            url  : "bpm/business/workhand/rejectWorkhand",
            data : {workhandIds:id},
            type : 'post',
            dataType : 'json',
            success : function(r){
            	$("#trusteeGrid").datagrid("reload").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
            }
        });
		}
    });
}
//保存
WorkHand.prototype.save = function (form, moduleForm) {
	var _self = this;
    var insertData = {};
    insertData.dataVo =  JSON.stringify(serializeObject(form));
    // 检查是否勾选了自定义，如果勾选了，则需要封装流程委托范围
    if( form.find("#customWorkhand").is(":checked")) {
        var modules = []
        if(moduleForm.find("tr:gt(0)").length <= 0) {
            layer.msg("您确定不添加流程委托范围了？");
            return;
        }
        moduleForm.find("tr:gt(0)").each(function(){
            var moduleIdstr = $(this).find("input[id^='moduleId']").val();
            var myWorkHandIdstr = $(this).find("input[id^='myWorkHandId']").val();
            var moduleIdArr = moduleIdstr.split(",");
            for(var i = 0 ; i < moduleIdArr.length ; i ++) {
                var moduleId = moduleIdArr[i];
                var module = {modelId: moduleId, userId: myWorkHandIdstr, workHandType:"1"};
                modules.push(module);
            }
        });
        insertData.modules = JSON.stringify(modules);
    }

    $.ajax({
        url  : "platform/bpm/clientbpmWorkHandAction/doWorkHand",
        data : insertData,
        type : 'post',
        dataType : 'json',
        success : function(r){
            if(r.error) {
                flowUtils.error(r.error);
                return;
            } else {
            	layer.close(_self.insertIndex);
               	$("#entrustGrid").datagrid("reload",{});

            }

        }
    });
}
//我的受托 拿回方法
WorkHand.prototype.fetchAction = function(data) {
    var _self = this;
    $.ajax({
        type : "POST",
        data : {
            deleteRows : data
        },
        async : false,//同步请求，防止连续点击按钮
        url : "platform/bpm/clientbpmWorkHandAction/deleteSysWorkHandPass",
        dataType : "json",
        success : function(r) {
            if (r.error) {
                flowUtils.error(r.error);
            }else{
                flowUtils.success("操作成功");
                layer.close(_self.fetchIndex);
            }
        }
    });
}
//关闭页面
WorkHand.prototype.closeDialog=function(windowName){
    var index = layer.getFrameIndex(windowName); //先得到当前iframe层的索引
    layer.close(index);
};