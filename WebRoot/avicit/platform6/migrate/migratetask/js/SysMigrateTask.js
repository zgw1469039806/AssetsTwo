/**
 * 
 */
function SysMigrateTask(datagrid, keyWordId, searchNames) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	this.url = "platform/migrate/sysMigrateTaskController/";
	this._datagridId = "#" + datagrid;
	this._jqgridToolbar = "#t_" + datagrid;
	this._keyWordId = "#" + keyWordId;
	this._searchNames = searchNames;

    this.validateTaskOnChangeResult = true;

	this.init.call(this);
};
// 初始化操作
SysMigrateTask.prototype.init = function() {
	var _this = this;
	$(_this._datagridId).jqGrid({
		url : _this.url + 'getSysMigrateTasksByPage',
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : [ {label : 'id', name : 'id', key : true, width : 75, hidden : true},
					 {label : '名称', name : 'name', width : 150},
					 {label : '目标数据库名称', name : 'dbName', width : 150},
					 {label : '数据开始时间', name : 'dataStartDate', width : 150, align:"center"},
					 {label : '数据结束时间', name : 'dataEndDate', width : 150, align:"center"},
					 {label : '迁移类型', name : 'execType', width : 100, align:"center", formatter : _this.formatExecType},
					 {label : '迁移时间', name : 'execDate', width : 150, align:"center"},
					 {label : '执行状态', name : 'execStatus', width : 120, align:"center", formatter : _this.formatExecStatus, unformat: _this.unFormatExecStatus},
                     {label : '操作', name : '', width : 150,align:"center", formatter : _this.formatOperate}
					 ],
		height : $(window).height() - 120,
		scrollOffset : 20, // 设置垂直滚动条宽度
		rowNum : 20,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		userDataOnFooter : true,
		pagerpos : 'left',
		loadonce : false,
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiselect : true,
        multiboxonly: true,
		autowidth : true,
		shrinkToFit : true,
		responsive : true,// 开启自适应
        hasTabExport:false,
        hasColSet:false,
		pager : "#jqGridPager",
        subGrid: true,
        subGridWidth:0,
        subGridRowExpanded: _this.showChildGrid,
        loadComplete:function(){
            //$(_this._datagridId).jqGrid("setGridWidth",$(window).width());
            $(this).jqGrid('hideCol', 'subgrid');
            $(this).jqGrid('getColumnByUserIdAndTableName');
        }
	});
	$(this._jqgridToolbar).append($("#tableToolbar"));

	$('.dropdown-menu').click(function(e) {
		e.stopPropagation();
	});
	$(_this._keyWordId).on('keydown', function(e) {
		if (e.keyCode == '13') {
			_this.searchByKeyWord();
		}
	});
};
//修改执行类型的显示式样
SysMigrateTask.prototype.formatExecType = function(cellvalue, options, rowObject) {
    if(cellvalue == "1"){
        return "自动";
    }else{
        return "手动";
    }
};

//行类执行状态的显示式样
SysMigrateTask.prototype.formatExecStatus = function(cellvalue, options, rowObject) {
    if(cellvalue == "1"){
        return "未开始";
    }else if(cellvalue == "2"){
        return "进行中";
    }else{
        return "已结束";
    }
};

//行类执行状态的显示式样
SysMigrateTask.prototype.unFormatExecStatus = function(cellvalue, options, rowObject) {
    if(cellvalue == "未开始"){
        return "1";
    }else if(cellvalue == "进行中"){
        return "2";
    }else{
        return "3";
    }
};

//行类执行结果的显示式样
SysMigrateTask.prototype.formatExecResult = function(cellvalue, options, rowObject) {
    if(cellvalue == "1"){
        return "成功";
    }else{
        return "失败";
    }
};

//修改操作的显示式样
SysMigrateTask.prototype.formatOperate = function(cellvalue, options, rowObject) {
    var immediatelyMigrateStr = "";
    var delStr = "";
    if(rowObject.execStatus == "1"){
        immediatelyMigrateStr = '<a href="javascript:void(0);" role="button" onclick="sysMigrateTask.immediatelyMigrate(\'' + options.rowId + '\');">立即迁移</a> | ';
    }else{
        immediatelyMigrateStr = '立即迁移 | '
    }
    if(rowObject.execStatus == "2"){
        delStr = "删除";
    }else{
        delStr = '<a href="javascript:void(0);" role="button" onclick="sysMigrateTask.del(\'' + options.rowId + '\');">删除</a>';
    }
    return immediatelyMigrateStr + '<a href="javascript:void(0);" role="button" onclick="sysMigrateTask.lookupHistory(\'' + options.rowId + '\');">查看历史</a> | ' + delStr;
};

//立即迁移
SysMigrateTask.prototype.immediatelyMigrate = function(rowId){
    var _this = this;

    $.ajax({
        url : _this.url + "migrateData",
        data : {taskId:rowId},
        type : 'post',
        dataType : 'json',
        success : function(r) {
            if (r.flag == "success" ) {
                if( r.result == "1"){

                }else if(r.result == "2"){
                    layer.alert('请配置数据源！', {icon : 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                }else if(r.result == "3"){
                    layer.alert('迁移失败！', {icon : 2 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                }else if(r.result == "4"){
                    layer.alert('该数据正在迁移中！',{icon:7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                }
                _this.reLoad();
            }else{
                layer.alert('迁移失败！', {icon : 2 ,title: "提示",closeBtn: 0,area: ['400px', '']});
            }
        }
    });
};

//查看历史
SysMigrateTask.prototype.lookupHistory = function(rowId){
    var _this = this;
    $(_this._datagridId).toggleSubGridRow(rowId);
};

//log子表
SysMigrateTask.prototype.showChildGrid = function(subgrid_id, rowId)  {
    var _this = this;
    var subgrid_table_id = subgrid_id + "_t"; // (根据subgrid_id定义对应的子表格的table的id

    var subgrid_pager_id = subgrid_id + "_pgr" // 根据subgrid_id定义对应的子表格的pager的id

    // 动态添加子报表的table和pager
    $("#" + subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+subgrid_pager_id+"' class='scroll'></div>");

    // 创建jqGrid对象
    $("#" + subgrid_table_id).jqGrid({
        url : 'platform/migrate/sysMigrateTaskController/getSysMigrateTaskLogByPage',
        postData:{taskId:rowId},
        mtype : 'POST',
        datatype : "json",
        colModel : [ {label : 'id', name : 'id', key : true, hidden : true},
            {label : '数据开始时间', name : 'dataStartDate',width : 70, align:"center"},
            {label : '数据结束时间', name : 'dataEndDate',width : 70, align:"center"},
            {label : '执行类型', name : 'execType',width : 50, align:"center", formatter : sysMigrateTask.formatExecType},
            {label : '执行时间', name : 'execDate',width : 100, align:"center"},
            {label : '执行结果', name : 'execResult',width : 50, align:"center", formatter : sysMigrateTask.formatExecResult},
            //{label : '执行用户ID', name : 'execUser',hidden : true},
            {label : '执行用户', name : 'execUserName',width : 70,align:"center" },
            {label : '结果信息', name : 'info',width : 150,align:"left" },
            {label : '异常', name : 'exception',width : 100,align:"left" },
        ],
        height : "100%",
        scrollOffset : 20, // 设置垂直滚动条宽度
        rowNum : 5,
        rowList : [ 100, 50, 30, 20, 10, 5 ],
        altRows : true,
        userDataOnFooter : true,
        pagerpos : 'left',
        loadonce : false,
        styleUI : 'Bootstrap',
        viewrecords : true,
        multiselect : false,
        autowidth : true,
        shrinkToFit : true,
        responsive : true,// 开启自适应
        hasTabExport:false,
        hasColSet:false,
        pager : "#"+subgrid_pager_id,
        jsonReader: {
            root:"rows",
            page: "page",
            total: "total",
            records: "records",
            repeatitems: false
        },
        loadComplete:function(){
            $(this).jqGrid('getColumnByUserIdAndTableName');
        }
    });
};

// 模块配置
SysMigrateTask.prototype.setDataSource = function() {
    var _this = this;
    layer.open({
        type : 2,
        area : [ '100%', '100%' ],
        title : '数据源配置',
        skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin : false, // 开启最大化最小化按钮
        content : "avicit/platform6/migrate/migratedb/SysMigrateDbManage.jsp"
    });
};

// 模块配置
SysMigrateTask.prototype.setModel = function() {
	var _this = this;
	layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : '模块配置',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, // 开启最大化最小化按钮
		content : "avicit/platform6/migrate/migratemodel/SysMigrateModelManage.jsp"
	});
};

//任务配置
SysMigrateTask.prototype.setTask = function() {
	var _this = this;
	var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    if (ids.length > 1) {
        layer.alert('只允许选择一个任务进行配置！', {icon : 3 ,title: "提示",closeBtn: 0,area: ['400px', '']});
        return false;
    }else if (ids.length == 0) {
        layer.open({
            type: 2,
            area: ['100%', '100%'],
            //area: ['820px', '540px'],
            title: '任务配置',
            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            maxmin: false, // 开启最大化最小化按钮
            content: _this.url + 'initAddData'
        });
	}else {
        var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
        if(rowData.execStatus == "2") {
            layer.alert('该数据正在迁移中，不能编辑!', {icon : 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
        }else{
            $.ajax({
                url : _this.url + "getSysMigrateTask",
                data : {taskId:rowData.id},
                type : 'post',
                dataType : 'json',
                success : function(r) {
                    if (r.flag == "success") {
                        if(r.data.execStatus == "2"){
                            layer.alert('该数据正在迁移中，不能编辑！',{icon:7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                            _this.reLoad();
                        }else{
                            layer.open({
                                type: 2,
                                area: ['100%', '100%'],
                                //area: ['820px', '530px'],
                                title: '任务配置',
                                skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                                maxmin: false, // 开启最大化最小化按钮
                                content: _this.url + 'initEditData/' + rowData.id
                            });
                        }
                    }
                }
            });
        }
    }
};

// 保存功能
SysMigrateTask.prototype.save = function($form, windowName) {
	var _this = this;
	var formData = serializeObject($form);
	var data = {taskData : JSON.stringify(formData),
                modelTaskData: JSON.stringify(_this.getSelectedModelList($form.find(".right-box")))};
    if(formData.execType == "1" && !_this.compareSystemDate(formData.execDate)){
        layer.alert('迁移时间必须大于系统时间！',{icon:7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
        return;
    }

    $.ajax({
		url : _this.url + "save",
		data : data,
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if (r.flag == "success") {
				_this.reLoad();
				_this.closeDialog(windowName);
                layer.msg('保存成功！',{icon:1 ,title: "提示",closeBtn: 0,area: ['400px', '']});
			} else {
                layer.alert('保存失败！',{icon:2 ,title: "提示",closeBtn: 0,area: ['400px', '']});
			}
		}
	});
};
//更新功能
SysMigrateTask.prototype.update = function($form, windowName) {
	var _this = this;
    var formData = serializeObject($form);
    var data = {taskData : JSON.stringify(formData),
                modelTaskData:JSON.stringify(_this.getSelectedModelList($form.find(".right-box")))};

    if(formData.execType == "1" && !_this.compareSystemDate(formData.execDate)){
        layer.alert('迁移时间必须大于系统时间！',{icon:7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
        return;
    }
    $.ajax({
        url : _this.url + "update",
        data : data,
        type : 'post',
        dataType : 'json',
        success : function(r) {
            if (r.flag == "success") {
                if(r.result == -1){
                    layer.alert('该数据已经被其他程序更新，请刷新后再修改！',{icon:7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                }else{
                    _this.reLoad();
                    _this.closeDialog(windowName);
                    layer.msg('保存成功！',{icon:1 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                }
            } else {
                layer.alert('保存失败！',{icon:2 ,title: "提示",closeBtn: 0,area: ['400px', '']});
            }
        }
    });


};
// 删除
SysMigrateTask.prototype.del = function(id) {
	var _this = this;
    $.ajax({
        url : _this.url + "getSysMigrateTask",
        data : {taskId:id},
        type : 'post',
        dataType : 'json',
        success : function(r) {
            if (r.flag == "success") {
                if(r.data.execStatus == "2"){
                    layer.alert('该数据正在迁移中，不能删除！',{icon:7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                    _this.reLoad();
                }else{
                    layer.confirm('确认要删除选中的数据吗?', {icon : 3 ,title : "提示",closeBtn: 0,area : [ '400px', '' ]}, function(index) {
                        $.ajax({
                            url : _this.url + 'delete',
                            data : id,
                            contentType : 'application/json',
                            type : 'post',
                            dataType : 'json',
                            success : function(r) {
                                if (r.flag == "success") {
                                    _this.reLoad();
                                    layer.msg('删除成功！',{icon:1 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                                } else {
                                    layer.alert('删除失败！',{icon: 2 ,title: "提示",closeBtn: 0,area: ['400px', '']});
                                }
                            }
                        });
                        layer.close(index);
                    });
                }
            }
        }
    });



};

// 重载数据
SysMigrateTask.prototype.reLoad = function() {
	var _this = this;
	var searchdata = {keyWord:""};
	$(_this._datagridId).jqGrid("setGridParam",{postData: searchdata,datatype:"json"}).trigger("reloadGrid");
};

// 关闭对话框
SysMigrateTask.prototype.closeDialog = function(windowName) {
	var index = layer.getFrameIndex(windowName); //先得到当前iframe层的索引
    layer.close(index);
};

// 关键字段查询
SysMigrateTask.prototype.searchByKeyWord = function() {
    var _this = this;

    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for ( var i in names) {
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
		keyWord : JSON.stringify(param)
	};
	$(_this._datagridId).jqGrid("setGridParam",{postData: searchdata,datatype:"json"}).trigger("reloadGrid");
};

//邦定下一步按钮
SysMigrateTask.prototype.bindNextButton = function($taskForm, $ystep, $next, $prev, windowName) {
    var _this = this;
    var $step1 = $taskForm.find("#step1");
    var $step2 = $taskForm.find("#step2");
    var $step3 = $taskForm.find("#step3");
    var $step4 = $taskForm.find("#step4");

    if($next.text() == "确定"){
        if(_this.isNotEmpty($taskForm.find("#id").val())){
            _this.update($taskForm, windowName);
        }else{
            _this.save($taskForm, windowName);
        }

    }else {

        var step = $ystep.getStep();
        if (step == 1) {

        	//校验step1
            if(!_this.validateStep1($step1) || !_this.validateTaskOnChangeResult){
        		return;
			}

			//下一步
            $ystep.nextStep();

            //设置按钮样式
            $next.text("下一步");
            $prev.text("上一步");
            $prev.show();

            //设置页面显示
            $step1.hide();
            $step2.show();
            $step3.hide();
            $step4.hide();


        } else if (step == 2) {
            //校验step2
            if(!_this.validateStep2($step2)){
                return;
            }

            //下一步
            $ystep.nextStep();

            //设置按钮样式
            $next.text("下一步");
            $prev.text("上一步");

            //设置页面显示
            $step1.hide();
            $step2.hide();
            $step3.show();
            $step4.hide();


        } else if (step == 3) {

            //校验step3
            if(!_this.validateStep3($step3)){
                return;
            }

            //下一步
            $ystep.nextStep();

            //设置按钮样式
            $next.text("确定");
            $prev.text("上一步");

            //设置页面显示
            $step1.hide();
            $step2.hide();
            $step3.hide();
            $step4.show();

            //设置动画
			var dataStartDate = $step3.find("#dataStartDate").val();
			var dataEndDate = $step3.find("#dataEndDate").val();
			var execType =  $step3.find("input[name='execType']:checked").val();
			var execDate = $step3.find("#execDate").val();
            var content;
			if(execType == "1"){
                content = "选中模块的"+dataStartDate+"至"+dataEndDate+"之间的数据将于"+execDate+"自动迁移";
			}else{
                content = "选中模块的"+dataStartDate+"至"+dataEndDate+"之间的数据将手动迁移";
			}
            $step4.find("h3").text(content);

			var triangleWidth = parseInt($step4.find(".triangle").css("border-left-width"));
			var left = $step4.find(".target .databaseModel").offset().left - $step4.find(".source .databaseModel").offset().left;
			var sourceWidth =  $step4.find(".source .databaseModel .cylinder").width();
			var triangleLeft = left - triangleWidth;
            var processbarWidth = left - triangleWidth - sourceWidth;

            //保存开始的位置
            $step4.find(".triangle").data("triangle-left",$step4.find(".triangle").position().left);
            $step4.find(".process-bar").data("process-bar-width",$step4.find(".process-bar").width());

            //开始动画
			$step4.find(".triangle").animate({left: triangleLeft}, "slow");
            $step4.find(".process-bar").animate({width: processbarWidth}, "slow");
        }
    }
};

//邦定前一步按钮
SysMigrateTask.prototype.bindPrevButton = function($taskForm, $ystep, $next, $prev, windowName) {
	var _this = this;
    var $step1 = $taskForm.find("#step1");
    var $step2 = $taskForm.find("#step2");
    var $step3 = $taskForm.find("#step3");
    var $step4 = $taskForm.find("#step4");

    $ystep.prevStep();
    var step = $ystep.getStep();

    if(step == 2){
    	//设置按钮样式
        $next.text("下一步");
        $prev.text("上一步");
        $prev.hide();

        //设置页面显示
        $step1.show();
        $step2.hide();
        $step3.hide();
        $step4.hide();

    }else if(step == 3){
        //设置按钮样式
        $next.text("下一步");
        $prev.text("上一步");

        //设置页面显示
        $step1.hide();
        $step2.show();
        $step3.hide();
        $step4.hide();

    }else if(step == 4){
        //设置按钮样式
        $next.text("下一步");
        $prev.text("上一步");

        //设置页面显示
        $step1.hide();
        $step2.hide();
        $step3.show();
        $step4.hide();

        //设置动画开始的位置
        $step4.find(".triangle").css("left",$step4.find(".triangle").data("triangle-left"));
        $step4.find(".process-bar").css("width",$step4.find(".process-bar").data("process-bar-width"));

    }
};

//数据源信息展示
SysMigrateTask.prototype.displayDataSource = function(event) {
	var _this = this;

	var $target = $(event.target);
	var dataSourceId = $target.val();
	var siblings = $target.closest("tr").siblings();

	if(_this.isNotEmpty(dataSourceId)){
		//从数据库取值
        $.ajax({
            url: _this.url + "getMigrateDbData",
            data: {"id": dataSourceId},
            type: "post",
            dataType: "json",
            success: function (resp) {
                if (resp.flag == "success" && resp.data != "undefined") {
                    siblings.find("#dbType").text(resp.data.dbType);
                    siblings.find("#dbIp").text(resp.data.dbIp);
                    siblings.find("#dbPort").text(resp.data.dbPort);
                    siblings.find("#dbUser").text(resp.data.dbUser);
                    siblings.find("#testConnect").data("data-dbname",resp.data.dbName);
                    siblings.find("#testConnect").data("data-dbtype",resp.data.dbType);
                    siblings.find("#testConnect").data("data-dbip",resp.data.dbIp);
                    siblings.find("#testConnect").data("data-dbport",resp.data.dbPort);
                    siblings.find("#testConnect").data("data-dbuser",resp.data.dbUser);
                    siblings.find("#testConnect").data("data-dbpass",resp.data.dbPass);
                    siblings.find("#testConnect").off("click").on("click",function(event){
                    	_this.testDbConnect(event);
					});
                    siblings.show();
                }
            }
        });

	}else{
        siblings.hide();
	}

};

// 测试连接
SysMigrateTask.prototype.testDbConnect = function(event){
    var _this = this;
    var $target = $(event.target);
    var data = {dbName:$target.data("data-dbname"),
				dbType:$target.data("data-dbtype"),
				dbIp:$target.data("data-dbip"),
				dbPort:$target.data("data-dbport"),
				dbUser:$target.data("data-dbuser"),
				dbPass:$target.data("data-dbpass")
    };

    avicAjax.ajax({
        url : _this.url + "testDbConnect",
        data : {data : JSON.stringify(data)},
        type : 'post',
        dataType : 'json',
        success : function(r) {
            if (r.flag == "success" && r.result == "true") {
                layer.msg('连接成功！',{icon: 1 ,title: "提示",area: ['400px', '']});
            } else {
                layer.msg('连接失败！',{icon: 2 ,title: "提示",area: ['400px', '']});
            }
        }
    });
};

// 校验 step1
SysMigrateTask.prototype.validateStep1 = function($step1){
    var _this = this;
	var error;

	var $name = $step1.find("#name");
    if(!_this.isNotEmpty($name.val())){
        error = "请填写任务名称!";
        $name.attr("title", error).tooltip("show");
        $name.attr("data-original-title", error).tooltip("show");
        $name.addClass("error");

    }else{
    	if(_this.validateTaskOnChangeResult){
            $name.removeClass("error");
            $name.tooltip('destroy');
		}
    }

    var $model = $step1.find(".right-box");
    if($model.find(".item").length == 0){
        error = "请选择模块!";
        $model.attr("title", error).tooltip("show");
        $model.attr("data-original-title", error).tooltip("show");
        $model.addClass("error");

    }else{
        $model.removeClass("error");
        $model.tooltip('destroy');
    }

    if(_this.isNotEmpty(error)){
    	return false;
	}else{
    	return true;
	}

};

SysMigrateTask.prototype.validateTaskOnChange = function(event) {
    var _this = this;
    var $elem = $(event.target);
    var elemValue = $elem.val();
    var error = "";

    if (_this.isNotEmpty(elemValue)) {
        if($elem.attr("name") == "name"){
            if(elemValue.gblen() > 255){
                error = "最多可以输入255个字符(一个中文字符长度为2)";
                $elem.attr("title", error).tooltip("show");
                $elem.attr("data-original-title", error).tooltip("show");
                $elem.addClass("error");
                _this.validateTaskOnChangeResult = false;
            }else{
                //任务名称是否存在
                var taskData = $(_this._datagridId).jqGrid('getRowData');
                var isHasFlag = false;
                $.each(taskData, function(idx, obj){
                    if(obj.name == elemValue){
                        isHasFlag = true;
                        return false;
                    }
                });

                if (isHasFlag) {
                    error = "任务名称已经存在!";
                    $elem.attr("title", error).tooltip("show");
                    $elem.attr("data-original-title", error).tooltip("show");
                    $elem.addClass("error");
                    _this.validateTaskOnChangeResult = false;
                } else {
                    $elem.attr("title", "");
                    $elem.attr("data-original-title", "");
                    $elem.removeClass("error");
                    $elem.tooltip('destroy');
                    _this.validateTaskOnChangeResult = true;
                }

            }
        }

        if($elem.attr("name") == "dbId" ){
			$elem.attr("title", "");
			$elem.attr("data-original-title", "");
			$elem.removeClass("error");
			$elem.tooltip('destroy');

        }
        // if($elem.attr("name") == "dataStartDate"){
        // 	var $dataEndDate = $elem.closest("div.dataStartEndDate").find("#dataEndDate");
        // 	if(!_this.isNotEmpty($dataEndDate.val())){
        //         error = "请填写数据结束时间!";
        //         $elem.closest("div.dataStartEndDate").attr("title", error).tooltip("show");
        //         $elem.closest("div.dataStartEndDate").attr("data-original-title", error).tooltip("show");
        //         $dataEndDate.addClass("error");
        //         $elem.removeClass("error");
        //         _this.validateTaskOnChangeResult = false;
			// }else{
        //         $elem.closest("div.dataStartEndDate").attr("title", "");
        //         $elem.closest("div.dataStartEndDate").attr("data-original-title", "");
        //         $elem.removeClass("error");
        //         $elem.closest("div.dataStartEndDate").tooltip('destroy');
        //         _this.validateTaskOnChangeResult = true;
			// }
        // }
        // if($elem.attr("name") == "dataEndDate" ){
        //     var $dataStartDate = $elem.closest("div.dataStartEndDate").find("#dataStartDate");
        //     if(!_this.isNotEmpty($dataStartDate.val())){
        //         error = "请填写数据开始时间!";
        //         $elem.closest("div.dataStartEndDate").attr("title", error).tooltip("show");
        //         $elem.closest("div.dataStartEndDate").attr("data-original-title", error).tooltip("show");
        //         $dataStartDate.addClass("error");
        //         $elem.removeClass("error");
        //         _this.validateTaskOnChangeResult = false;
        //     }else{
        //         $elem.closest("div.dataStartEndDate").attr("title", "");
        //         $elem.closest("div.dataStartEndDate").attr("data-original-title", "");
        //         $elem.removeClass("error");
        //         $elem.closest("div.dataStartEndDate").tooltip('destroy');
        //         _this.validateTaskOnChangeResult = true;
        //     }
        // }
        if($elem.attr("name") == "dataStartDate" || $elem.attr("name") == "dataEndDate" ){
            $elem.closest("div.dataStartEndDate").attr("title", "");
            $elem.closest("div.dataStartEndDate").attr("data-original-title", "");
            $elem.removeClass("error");
            $elem.closest("div.dataStartEndDate").tooltip('destroy');
        }
        if($elem.attr("name") == "execDate"){
            if(!_this.compareSystemDate(elemValue)){
                error = "迁移时间必须大于系统时间！!";
                $elem.closest("div").attr("title", error).tooltip("show");
                $elem.closest("div").attr("data-original-title", error).tooltip("show");
                $elem.addClass("error");
                _this.validateTaskOnChangeResult = false;
            }else {
                $elem.closest("div").attr("title", "");
                $elem.closest("div").attr("data-original-title", "");
                $elem.removeClass("error");
                $elem.closest("div").tooltip('destroy');
                _this.validateTaskOnChangeResult = true;
            }
        }

    }
}

// 校验step2
SysMigrateTask.prototype.validateStep2 = function($step2){
    var _this = this;
    var error;

    var $dbName = $step2.find("#dbId");
    if(!_this.isNotEmpty($dbName.val())){
        error = "请选择目标数据库!";
        $dbName.attr("title", error).tooltip("show");
        $dbName.attr("data-original-title", error).tooltip("show");
        $dbName.addClass("error");

    }else{
        $dbName.removeClass("error");
        $dbName.tooltip('destroy');
    }

    if(_this.isNotEmpty(error)){
        return false;
    }else{
        return true;
    }

};

// 校验step3
SysMigrateTask.prototype.validateStep3 = function($step3){
    var _this = this;
    var error;

    var $dataStartDate = $step3.find("#dataStartDate");
    var $dataEndDate = $step3.find("#dataEndDate");
    if(!_this.isNotEmpty($dataStartDate.val()) && !_this.isNotEmpty($dataEndDate.val())){
        error = "请填写数据起止时间!";
        $dataStartDate.closest("div.dataStartEndDate").attr("title", error).tooltip("show");
        $dataStartDate.closest("div.dataStartEndDate").attr("data-original-title", error).tooltip("show");
        $dataStartDate.addClass("error");
        $dataEndDate.addClass("error");

    }else if(!_this.isNotEmpty($dataStartDate.val()) && _this.isNotEmpty($dataEndDate.val())){
        error = "请填写数据开始时间!";
        $dataStartDate.closest("div.dataStartEndDate").attr("title", error).tooltip("show");
        $dataStartDate.closest("div.dataStartEndDate").attr("data-original-title", error).tooltip("show");
        $dataStartDate.addClass("error");
	}else if(_this.isNotEmpty($dataStartDate.val()) && !_this.isNotEmpty($dataEndDate.val())){
        error = "请填写数据结束时间!";
        $dataStartDate.closest("div.dataStartEndDate").attr("title", error).tooltip("show");
        $dataStartDate.closest("div.dataStartEndDate").attr("data-original-title", error).tooltip("show");
        $dataEndDate.addClass("error");
    }else{
        $dataStartDate.removeClass("error");
        $dataEndDate.removeClass("error");
        $dataStartDate.closest("div.dataStartEndDate").tooltip('destroy');
    }

    if($step3.find('input[name="execType"][value="1"]').is(":checked")){
        var $execDatee = $step3.find("#execDate");
        if(!_this.isNotEmpty($execDatee.val())){
            error = "请填写迁移时间!";
            $execDatee.closest("div").attr("title", error).tooltip("show");
            $execDatee.closest("div").attr("data-original-title", error).tooltip("show");
            $execDatee.addClass("error");

        }else{
            if(!_this.compareSystemDate($execDatee.val())){
                error = "迁移时间必须大于系统时间！";
                $execDatee.closest("div").attr("title", error).tooltip("show");
                $execDatee.closest("div").attr("data-original-title", error).tooltip("show");
                $execDatee.addClass("error");

            }else{
                $execDatee.removeClass("error");
                $execDatee.closest("div").tooltip('destroy');
            }

        }

	}

    if(_this.isNotEmpty(error)){
        return false;
    }else{
        return true;
    }


};

//取得选择的模块列表
SysMigrateTask.prototype.getSelectedModelList = function($uiBox){
    var _this = this;
    var data = $.map( $uiBox.find(".item"), function(elem, idx){
        return {modelId: $(elem).attr("data-id")};
    });
    return data;
};


//判断字符串是否是uundefined null ""
SysMigrateTask.prototype.isNotEmpty = function(checkObject){
    if(!checkObject){
        return false;
    }
    if(checkObject ==  "undefined" || checkObject == null || checkObject == ""
        || typeof(checkObject) == "undefined" || checkObject == "null"){
        return false;
    }
    return true;
};

SysMigrateTask.prototype.compareSystemDate = function(d1) {
    var date = new Date();
    return ((new Date(d1.replace(/-/g,"\/"))) > date);
};

//计算字符串长度(英文占1个字符，中文汉字占2个字符)
String.prototype.gblen = function() {
    var len = 0;
    for (var i=0; i<this.length; i++) {
        if (this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {
            len += 2;
        } else {
            len ++;
        }
    }
    return len;
};

