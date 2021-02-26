function MyWorkDelegate(datagrid, url, formSub, dataGridColModel) {
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
	this.Pagerlbar = "#" + datagrid + "Pager";
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
}
;
//初始化操作
MyWorkDelegate.prototype.init = function() {
	var _self = this;
	$(_self._datagridId).jqGrid({
		url : this.getUrl(),
		postData : {
		},
		mtype : 'POST',
		datatype : "json",
		toolbar : [ false, 'top' ],
		colModel : this.dataGridColModel,
		height : $(window).height() - 70, //120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
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
MyWorkDelegate.prototype.reLoad = function(nodeId,nodeType,pdId) {
	var searchdata = {
	};
	$(this._datagridId).jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};

MyWorkDelegate.prototype.workHandDetail = function(id){
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

MyWorkDelegate.prototype.rejectWorkhand = function(id) {
	var _self = this;
    var index = layer.confirm("您确定驳回该委托吗？", {
        icon : 3,
        title : '提示'
    }, function(index) {
        $.ajax({
            url  : "bpm/business/workhand/rejectWorkhand",
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



MyWorkDelegate.prototype.getDetail = function() {
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

MyWorkDelegate.prototype.formValidate = function(form) {
   var  rules = {
            receptUserName:{
            required:true
        },
       receptDeptName:{
            required:true
        },
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

MyWorkDelegate.prototype.closeDialog=function(windowName){

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


