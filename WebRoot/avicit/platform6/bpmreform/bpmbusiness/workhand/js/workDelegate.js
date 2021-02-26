function WorkDelegate(datagrid, url, formSub, dataGridColModel) {
	if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
		throw new Error("datagrid不能为空！");
	}
	var _url = url;
	this.getUrl = function() {
		return _url;
	}
	this.pageId = datagrid+"Pager";
	this.searchForm = "#" + formSub;
	this._datagridId = "#" + datagrid;
	this.Toolbardiv = "#t_" + datagrid;
	this.Toolbar = "#toolbar_" + datagrid;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
}
;
//初始化操作
WorkDelegate.prototype.init = function() {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl(),
		postData : {
		},
		mtype : 'POST',
		datatype : "json",
		toolbar : [ true, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height() - 110, //120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
		scrollOffset : 10, //设置垂直滚动条宽度
		rowNum : 10,
		rowList : [ 200, 100, 50, 30, 20, 10 ],
		altRows : true,
		pagerpos : 'left',
		loadComplete : function(data) {
			$("#set_"+_self.pageId).remove();
            $("#exportExcel_"+_self.pageId).remove();
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		viewrecords : true, //
		styleUI : 'Bootstrap',
		multiselect : false,
		autowidth : true,
		shrinkToFit : true,
		responsive : true, //开启自适应
		pager : _self.Pagerlbar
	});
	
	$(_self.Toolbardiv).append($(_self.Toolbar));
};

//重载数据
WorkDelegate.prototype.reLoad = function(nodeId,nodeType,pdId) {
	var searchdata = {
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

WorkDelegate.prototype.workHandDetail = function(id){
	var url = "bpm/business/workhand/workHandDetail?id="+id;
	
	workHandDetailDialog = layer.open({
        type: 2,
        title: '委托详情',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content:url
       });
};

WorkDelegate.prototype.toUpdate = function(id){
	var url = "bpm/business/workhand/toUpdate?id="+id;
	this.insertIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '修改委托',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: url,
        btn: ['确定', '关闭'],
        yes: function(index, layero){
            var iframeWin = layero.find('iframe')[0].contentWindow;

            var isValidate = iframeWin.$("#form").validate();
            if (!isValidate.checkForm()) {
                isValidate.showErrors();
                return false;
            }
            // 校验是否选择了流程
            if(!iframeWin.$("#customTable").hasClass("hidden")) {
                var flag = false;
                if( iframeWin.$("#customTable").find("tr:gt(0)").length <= 0) {
                    layer.msg("您还没有添加流程委托范围");
                    return ;
                }

                iframeWin.$("#customTable").find("input").each(function(){
                    if($(this).val() == "") {
                        flag = true;
                        return false;
                    }
                });
                if(flag) {
                    layer.msg("您还没有选择流程委托范围或受托人");
                    return ;
                }
            }
            workDelegate.update(iframeWin.$("#form"),iframeWin.$("#moduleForm"));
        }
    });
};

WorkDelegate.prototype.update = function (form, moduleForm) {
	var _self = this;
	var hasCustom = false;
    var insertData = {};
    insertData.dataVo =  JSON.stringify(serializeObject(form));
    var insertIndex = this.insertIndex;
    // 检查是否勾选了自定义，如果勾选了，则需要封装流程委托范围
    if( form.find("#customWorkhand").is(":checked")) {
        var modules = []
        // "modelId":"402888f05c0ea156015c0ea476c40069","userId":"402888f95c34ec31015c3500018b0086"}
        // 先找到input，然后循环遍历之
        if(moduleForm.find("tr:gt(0)").length <= 0) {
            layer.msg("您确定不添加流程委托范围了？");
            return;
        }
        moduleForm.find("tr:gt(0)").each(function(){
            var moduleIdstr = $(this).find("input[id^='moduleId']").val();
            var myWorkHandIdstr = $(this).find("input[id^='myWorkHandId']").val();
            var workHandTypeStr = $(this).find("input[id^='workHandType']").val();
//            console.log(moduleIdstr);
//            console.log(myWorkHandIdstr);
            var moduleIdArr = moduleIdstr.split(",");
            var moduleTypeArr = workHandTypeStr.split(",");
            for(var i = 0 ; i < moduleIdArr.length ; i ++) {
                var moduleId = moduleIdArr[i];
                var workHandType = moduleTypeArr[i];
                var module = {modelId: moduleId, userId: myWorkHandIdstr, workHandType:workHandType};
                modules.push(module);
                hasCustom = true;
            }
        });
//        console.log(modules);
        insertData.modules = JSON.stringify(modules);
    }
    var receptUserId = form.find("#receptUserId").val();
    if((receptUserId=='' || receptUserId==undefined) && !hasCustom){
		layer.msg("默认受托人和自定义委托不能都为空!");
            return;
    }
    //遮罩
    var maskId = layer.load();
    $.ajax({
        url  : "bpm/business/workhand/updateWorkHand",
        data : insertData,
        type : 'post',
        dataType : 'json',
        async : false,
        success : function(r){
            if(r.error) {
                flowUtils.error(r.error);
                return;
            } else {
            	_self.reLoad();
                layer.close(insertIndex);
            }

        }
    });
    //去掉遮罩
    layer.close(maskId);
}

WorkDelegate.prototype.insert=function(){
    this.insertIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '新建委托',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'avicit/platform6/bpmreform/bpmbusiness/workhand/workDelegateAdd.jsp',
        btn: ['确定', '关闭'],
        yes: function(index, layero){
            var iframeWin = layero.find('iframe')[0].contentWindow;

            var isValidate = iframeWin.$("#form").validate();
            if (!isValidate.checkForm()) {
                isValidate.showErrors();
                return false;
            }
            // 校验是否选择了流程
            if(!iframeWin.$("#customTable").hasClass("hidden")) {
                var flag = false;
                if( iframeWin.$("#customTable").find("tr:gt(0)").length <= 0) {
                    layer.msg("您还没有添加流程委托范围");
                    return ;
                }

                iframeWin.$("#customTable").find("input").each(function(){
                    if($(this).val() == "") {
                        flag = true;
                        return false;
                    }
                });
                if(flag) {
                    layer.msg("您还没有选择流程委托范围或受托人");
                    return ;
                }
            }
            workDelegate.save(iframeWin.$("#form"),iframeWin.$("#moduleForm"));
        }
    });
};

WorkDelegate.prototype.save = function (form, moduleForm) {
	var _self = this;
	var hasCustom = false;
    var insertData = {};
    insertData.dataVo =  JSON.stringify(serializeObject(form));
    var insertIndex = this.insertIndex;
    // 检查是否勾选了自定义，如果勾选了，则需要封装流程委托范围
    if( form.find("#customWorkhand").is(":checked")) {
        var modules = []
        // "modelId":"402888f05c0ea156015c0ea476c40069","userId":"402888f95c34ec31015c3500018b0086"}
        // 先找到input，然后循环遍历之
        if(moduleForm.find("tr:gt(0)").length <= 0) {
            layer.msg("您确定不添加流程委托范围了？");
            return;
        }
        moduleForm.find("tr:gt(0)").each(function(){
            var moduleIdstr = $(this).find("input[id^='moduleId']").val();
            var myWorkHandIdstr = $(this).find("input[id^='myWorkHandId']").val();
            var workHandTypeStr = $(this).find("input[id^='workHandType']").val();
//            console.log(moduleIdstr);
//            console.log(myWorkHandIdstr);
            var moduleIdArr = moduleIdstr.split(",");
            var moduleTypeArr = workHandTypeStr.split(",");
            for(var i = 0 ; i < moduleIdArr.length ; i ++) {
                var moduleId = moduleIdArr[i];
                var workHandType = moduleTypeArr[i];
                var module = {modelId: moduleId, userId: myWorkHandIdstr, workHandType:workHandType};
                modules.push(module);
                hasCustom = true;
            }
        });
//        console.log(modules);
        insertData.modules = JSON.stringify(modules);
    }
    var receptUserId = form.find("#receptUserId").val();
    if((receptUserId=='' || receptUserId==undefined) && !hasCustom){
		layer.msg("默认受托人和自定义委托不能都为空!");
            return;
    }
    //遮罩
    var maskId = layer.load();
    $.ajax({
        url  : "platform/bpm/clientbpmWorkHandAction/doWorkHand",
        data : insertData,
        type : 'post',
        dataType : 'json',
        async : false,
        success : function(r){
            if(r.error) {
                flowUtils.error(r.error);
                return;
            } else {
            	_self.reLoad();
                layer.close(insertIndex);
            }

        }
    });
    //去掉遮罩
    layer.close(maskId);

}


WorkDelegate.prototype.deleteData=function(id) {
	var _self = this;
    var index = layer.confirm("确定删除这条委托？", {
        icon : 3,
        title : '提示'
    }, function(index) {
        $.ajax({
            url  : "bpm/business/workhand/deleteSysWorkHand",
            data : {workhandIds:id},
            type : 'post',
            dataType : 'json',
            success : function(r){
            	_self.reLoad();
//                console.log(r);
            }
        });
        layer.close(index);
    });
};

WorkDelegate.prototype.completeData = function(id) {
	var _self = this;
    var index = layer.confirm("您确定该条委托已经完成？", {
        icon : 3,
        title : '提示'
    }, function(index) {
        $.ajax({
            url  : "bpm/business/workhand/completeSysWorkHand",
            data : {workhandIds:id},
            type : 'post',
            dataType : 'json',
            success : function(r){
            	_self.reLoad();
//                console.log(r);
            }
        });
        layer.close(index);
    });
}


WorkDelegate.prototype.detail = function() {
    var _self = this;
    var rowData =  $(_self._datagridId).getRowData(
        $(_self._datagridId).getGridParam("selrow"));
//    console.log(rowData);
    if(rowData.length < 1) {
        layer.msg("请选择一条数据！", {
            icon : 7
        });
        return ;
    }
    layer.open({
        type: 2,
        area: ['80%', '80%'],
        title: '工作移交',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'avicit/platform6/bpmreform/bpmbusiness/workhand/workDelegateAdd.jsp?act=detail'
    });

}

WorkDelegate.prototype.fetch = function() {
    layer.open({
        type: 2,
        area: ['80%', '80%'],
        title: '工作移交',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'avicit/platform6/bpmreform/bpmbusiness/workhand/processWorkHandTask.jsp',
    });

}
WorkDelegate.prototype.fetchAction = function(data) {
    var _self = this;
    //遮罩
    var maskId = layer.load();
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
            }
        }
    });
    //去掉遮罩
    layer.close(maskId);
}
WorkDelegate.prototype.getDetail = function() {
    var _self = this;
    var rowData =  $(_self._datagridId).getRowData(
        $(_self._datagridId).getGridParam("selrow"));
    if(rowData.length < 1) {
        layer.msg("请选择一条数据！", {
            icon : 7
        });
        return ;
    }
    return rowData;
}

WorkDelegate.prototype.formValidate = function(form) {
   var  rules = {
		   /**
            receptUserName:{
            required:true
        },
       receptDeptName:{
            required:true
        },*/
       handEffectiveDate:{
                required : true
        },
       backDate:{
                 required : true
        }
    };
    form.validate({
        rules: rules,
        errorClass: "error",
        success: 'valid',
        unhighlight: function (element, errorClass, validClass) { //验证通过
            $(element).tooltip('destroy').removeClass(errorClass);
        },

        //自定义错误消息放到哪里
        errorPlacement: function (error, element) {
            if ($(element).next("div").hasClass("tooltip")) {
                $(element).attr("data-original-title", $(error).text()).tooltip("show");
            } else {
                $(element).attr("title", $(error).text()).tooltip("show");
            }
        }
    });
}

WorkDelegate.prototype.closeDialog=function(windowName){

    var index = layer.getFrameIndex(windowName); //先得到当前iframe层的索引
    layer.close(index);
};

/////////////////////////////////////////////////////////FUNCTION/////////////////////////////////////////////////////////

//判断字符串是否是uundefined null ""
function isNotEmpty(checkObject){
    if(!checkObject){
        return false;
    }
    if(checkObject ==  "undefined" || checkObject == null || checkObject == "" 
        || typeof(checkObject) == "undefined" || checkObject == "null"){
        return false;
    }
    return true;
}

//
function convertFormSerializeValueToJson(formSerializeValue) {
    var formDataArray = formSerializeValue.split("&");

    var formDataJson = "";
    formDataJson += "{";
    for (var i = 0; i < formDataArray.length; i++) {
        var key = formDataArray[i].split("=")[0];
        var value = formDataArray[i].split("=")[1];

        formDataJson += "\"" + key + "\"";
        formDataJson += ":";
        formDataJson += "\"" + value + "\"";

        if (i != formDataArray.length - 1) {
            formDataJson += ", ";
        }
    }
    formDataJson += "}";

    return formDataJson;
}

function serializeArrayObject(form){
	var r = [];
	var o = {};
    var a = form.serializeArray();
    $.each(a, function() {
		
        if (o[this.name] !== undefined) {
			r.push(o);
			o = {};
            o[this.name] = this.value || '';
        } else {
            o[this.name] = this.value || '';
        }
    });
	r.push(o);
    return r;
}

function serializeObject(b, a) {
    var c = {};
    $.each(b.serializeArray(), function(d) {
        if (typeof (a) == "undefined" || (a != null && a == false)) {
            if (c[this["name"]]) {
                c[this["name"]] = c[this["name"]] + "," + this["value"]
            } else {
                c[this["name"]] = this["value"]
            }
        } else {
            if (this["value"] != null && this["value"] != "") {
                if (c[this["name"]]) {
                    c[this["name"]] = c[this["name"]] + "," + this["value"]
                } else {
                    c[this["name"]] = this["value"]
                }
            }
        }
    });
    return c
}

Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}


