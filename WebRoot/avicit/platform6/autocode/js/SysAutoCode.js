/**
 * 自动编码
 */
function SysAutoCode(datagrid,keyWordId,searchNames){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    this._url = "platform/sysautocode/sysAutoCodeManageController/";
	this._segmentLabel = ["通用编码","长度","格式化","输入类型","码段值","函数路径","SQL脚本","服务名","服务URL"];
	this._datagridId="#"+datagrid;
	this._jqgridToolbar="#t_"+datagrid;
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this._saveFlag = true;
	this._validateSegmentResult  = true;
	this._validateSegmentFormResult  = true;
	this._oldSegmentDivHeight = null;
	this._vlookupData = null;

	this.init.call(this);
};
//初始化操作
SysAutoCode.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: _self._url +'getSysAutoCodesByPage',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: [	{label : 'id', name : 'id', key : true, width : 75,hidden : true},
					{label : '编码代码', name : 'code', width : 150},
					{label : '编码名称', name : 'name', width : 150},
					{label : '编码样式', name : 'style', width : 200},
					{label : '绑定表', name : 'tableName', width : 150 },
					{label : '绑定字段', name : 'columnName', width : 150},
					{label : '创建时间', name : 'creationDate', width : 150, align:"center"},
					{label : '是否有效', name : 'validFlag', width : 100, align:"center", formatter:_self.formatterValidFlag, unformat:_self.unFormatterValidFlag}
				 ],
        height:$(window).height()-120,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        userDataOnFooter: true,
        pagerpos:'left',
        loadonce: false,
        loadComplete:function(){
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
        styleUI : 'Bootstrap',
		viewrecords: true,
		multiselect: true,
        multiboxonly: true,
		autowidth: true,
		shrinkToFit: true,
        hasTabExport:false,
        hasColSet:false,
		responsive:true,//开启自适应
        pager: "#jqGridPager"
    });
    $(this._jqgridToolbar).append($("#tableToolbar"));

	$('.dropdown-menu').click(function(e) {
		    e.stopPropagation();
	});
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};

//编码的格式化
SysAutoCode.prototype.formatterCode = function(cellvalue, options, rowObject, isExpoot) {
		if (isExpoot) {
			return '<a href="javascript:void(0);" onclick="sysAutoCode.detail(\''
					+ rowObject.id + '\');">' + cellvalue + '</a>';
		} else {
			return cellvalue;
		}
}

//修改是否有效的显示式样
SysAutoCode.prototype.formatterValidFlag = function(cellvalue, options, rowObject) {
	var validString;
    if(cellvalue == "Y"){
		validString = "有效";
	}else{
		validString = "无效";
	}
    return validString;
};

//返回是否有效的值
SysAutoCode.prototype.unFormatterValidFlag = function(cellvalue, options, cellobject) {
		var validString;
    if(cellvalue == "有效"){
		validString = "Y";
	}else{
		validString = "N";
	}
    return validString;
};


//添加页面
SysAutoCode.prototype.insert=function(){
	this.insertIndex = layer.open({
	    type: 2,
        area: ['90%', '70%'],
	    title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this._url +'initInsertPageData'
	});
};

//编辑页面
SysAutoCode.prototype.modify=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择要编辑的数据！', {icon : 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
		return false;
	}else if(ids.length > 1){
		layer.alert('只允许选择一条数据进行编辑！', {icon : 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
	    type: 2,
	    area: ['90%', '70%'],
	    title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this._url +'initEditPageData/'+rowData.id
	});
};


//控件校验   规则：表单字段name与rules对象保持一致
SysAutoCode.prototype.formValidate=function(form,type){
	var _self = this;
	var rules, messages;
	if(type == "add"){
		rules = {
					code:{
							required:true,
							maxlength: 32,
							alnum:true,
							remote: {
								type: "POST",
								url: _self._url + "getSysAutoCodeByCode", //请求地址
								data:{
									code:function(){ return form.find("#code").val(); }
								}
							}
						},
					name:{
							required:true,
							maxlength: 100
						},
					tableName:{
							maxlength: 32,
							alnum:true,
                        	together:true
						},
					columnName:{
							maxlength: 32,
							alnum:true,
                        	together2:true
						}
					};
		messages = {
					code:{
							required:"请填写编码代码",
							maxlength:"最多可以输入32个字符(一个中文字符长度为2)",//"输入长度最多是5的字符串(汉字算一个字符)",
							alnum:"只能输入英文,数字,下划线",
							remote:"编号代码已存在"
					},
					name:{
							required:"请填写编码名称",
							maxlength:"最多可以输入100个字符(一个中文字符长度为2)"
					},
					tableName:{
							maxlength:"最多可以输入32个字符(一个中文字符长度为2)",
							alnum:"只能输入英文,数字,下划线",
						    together:"请填写绑定表"
					},
					columnName:{
							maxlength:"最多可以输入32个字符(一个中文字符长度为2)",
							alnum:"只能输入英文,数字,下划线",
                        	together2:"请填写绑定字段"
					}
				};
	}else{
				rules = {
					code:{
							required:true,
							maxlength: 32,
							alnum:true
						},
					name:{
							required:true,
							maxlength: 100
						},
					tableName:{
							maxlength: 32,
							alnum:true,
                        	together:true
						},
					columnName:{
							maxlength: 32,
							alnum:true,
                        	together2:true
						}
					};
		messages = {
					code:{
							required:"请填写编号代码",
							maxlength:"最多可以输入32个字符(一个中文字符长度为2)",//"输入长度最多是5的字符串(汉字算一个字符)",
							alnum:"只能输入英文,数字,下划线"
					},
					name:{
							required:"请填写编号名称",
							maxlength:"最多可以输入100个字符(一个中文字符长度为2)"
					},
					tableName:{
							maxlength:"最多可以输入32个字符(一个中文字符长度为2)",
							alnum:"只能输入英文,数字,下划线",
                        	together:"请填写绑定表"
					},
					columnName:{
							maxlength:"最多可以输入32个字符(一个中文字符长度为2)",
							alnum:"只能输入英文,数字,下划线",
                        	together2:"请填写绑定字段"
					}
				};
	}
	form.validate({
		rules: rules,
		messages: messages,
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
//保存功能
SysAutoCode.prototype.save=function(codeForm,codeSegmentForm,windowName){
	var _self = this;
	codeSegmentForm.find(":disabled").each(function(idx,elem){
		$(this).prop("disabled",false);
	});

    var segmentArray = serializeArrayObject(codeSegmentForm);
    for(var i = 0; i < segmentArray.length ; i++){
        var segment  = segmentArray[i];
        if(segment.segmentType === '2'){
            var start = segment.valueStart;
            if(start){
                var value = segment.segmentValue;
                segment.segmentValue = value + ',' + start;
            }
            delete segment['valueStart'];
            continue;
        }
        if(segment.segmentType === '8'){
            var restServicesURL = segment.restServicesURL;
            if(restServicesURL){
                var value = segment.segmentValue;
                segment.segmentValue = value + ',' + restServicesURL;
            }
            delete segment['restServicesURL'];
            continue;
        }
    }

	var data = {code :JSON.stringify(serializeObject(codeForm)),
				codeSegment:JSON.stringify(segmentArray)};
	$.ajax({
		 url:_self._url +"save",
		 data : data,
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 _self.closeDialog(windowName);
                 layer.msg('保存成功！', {
                     icon: 1,
                     area: ['200px', ''],
                     closeBtn: 0
                 });
			 }else{
			 	if(r.error=="1")
                    layer.alert('保存失败！绑定表不存在！', {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
			 	else if(r.error=="2")
                    layer.alert('保存失败！绑定字段不存在！', {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
			 	else
				 layer.alert('保存失败！', {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
			 }
		 }
	 });
};
//更新功能
SysAutoCode.prototype.update=function(codeForm,codeSegmentForm,windowName){
	var _self = this;
	codeSegmentForm.find(":disabled").each(function(idx,elem){
		$(this).prop("disabled",false);
	});

    var segmentArray = serializeArrayObject(codeSegmentForm);
    for(var i = 0; i < segmentArray.length ; i++){
        var segment  = segmentArray[i];
        if(segment.segmentType === '2'){
            var start = segment.valueStart;
            if(start){
                var value = segment.segmentValue;
                segment.segmentValue = value + ',' + start;
            }
            delete segment['valueStart'];
            continue;
        }
		if(segment.segmentType === '8'){
			var restServicesURL = segment.restServicesURL;
			if(restServicesURL){
				var value = segment.segmentValue;
				segment.segmentValue = value + ',' + restServicesURL;
			}
			delete segment['restServicesURL'];
			continue;
		}
    }
	var data = {code :JSON.stringify(serializeObject(codeForm)),
				codeSegment:JSON.stringify(segmentArray)};
	$.ajax({
		 url:_self._url +"update",
		 data : data,
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 _self.closeDialog(windowName);
                 layer.msg('保存成功！', {
                     icon: 1,
                     area: ['200px', ''],
                     closeBtn: 0
                 });
			 }else{
                 if(r.error=="1")
                     layer.alert('保存失败！绑定表不存在！', {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
                 else if(r.error=="2")
                     layer.alert('保存失败！绑定字段不存在！', {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
                 else
                     layer.alert('保存失败！', {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
			 }
		 }
	 });
};
//删除
SysAutoCode.prototype.del=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确认要删除选择的数据吗?',  {icon: 3, title:"提示",closeBtn: 0, area: ['400px', '']}, function(index){
				for(;l--;){
					 ids.push(rows[l]);
				 }
				 $.ajax({
					 url:_self._url +'delete',
					 data:	JSON.stringify(ids),
					 contentType : 'application/json',
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						if (r.flag == "success") {
							 _self.reLoad();
                            layer.msg('删除成功！', {
                                icon: 1,
                                area: ['200px', ''],
                                closeBtn: 0
                            });
						}else{
							layer.alert('删除失败！', {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
						}
					 }
				 });
				 layer.close(index);
			});
	}else{
	    layer.alert('请选择要删除的数据！', {icon : 7 ,title: "提示",closeBtn: 0,area: ['400px', '']});
	}
};
//重载数据
SysAutoCode.prototype.reLoad=function(){
	var searchdata = {keyWord:""}
	$(this._datagridId).jqGrid("setGridParam",{postData: searchdata,datatype:"json"}).trigger("reloadGrid");
};
//关闭对话框
SysAutoCode.prototype.closeDialog=function(windowName){
	var index = layer.getFrameIndex(windowName); //先得到当前iframe层的索引
    layer.close(index);
};

//关键字段查询
SysAutoCode.prototype.searchByKeyWord =function(){
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
			keyWord: JSON.stringify(param)
		}
	$(this._datagridId).jqGrid("setGridParam",{postData: searchdata,datatype:"json"}).trigger("reloadGrid");
};


//行添加
SysAutoCode.prototype.addTr = function(event, html, codeSegmentForm){
	var _self = this;
	var currentTr;
	if(event.target.tagName == "SPAN"){
		currentTr = $(event.target).parent().parent().parent();
	}else{
		currentTr = $(event.target).parent().parent();
	}

	var currentIdArray = currentTr.attr("id").split("_");
	var addTrHtml = "<tr id='segmentTr_" +  (parseInt(currentIdArray[1]) + 1) + "' style='height: 50px'>"+ html + "</tr>";
	var addTr = $(addTrHtml);
	addTr.find("input,select").val("");//清空值


	addTr.find("input,select,a,td>div").each(function(index,e){
		var eIdArray = $(this).attr("id").split("_");
		$(this).attr("id", eIdArray[0] + "_" + (parseInt(currentIdArray[1]) + 1));
		//设定排序的值
		if($(this).attr("id") == "segmentOrder_" + (parseInt(currentIdArray[1]) + 1)){
			$(this).val(parseInt(currentIdArray[1]) + 1);
		}
		//邦定事件
		//邦定添加按钮
		if($(this).attr("id") == "segmentAdd_" + (parseInt(currentIdArray[1]) + 1)){
			$(this).on("click", function (event) {
				_self.addTr(event, html, codeSegmentForm);
			});
		}
		//邦定删除按钮
		if($(this).attr("id") == "segmentDel_" + (parseInt(currentIdArray[1]) + 1)){
			$(this).on("click", function (event) {
				_self.delTr(event);
			});
		}
		//邦定向上按钮
		if($(this).attr("id") == "segmentUp_" + (parseInt(currentIdArray[1]) + 1)){
			$(this).on("click", function (event) {
				_self.upTr(event);
			});
		}
		//邦定向下按钮
		if($(this).attr("id") == "segmentDown_" + (parseInt(currentIdArray[1]) + 1)){
			$(this).on("click", function (event) {
				_self.downTr(event);
			});
		}

		//邦定编码类型字段onchange事件
		if($(this).attr("id") == "segmentType_" + (parseInt(currentIdArray[1]) + 1)){
			$(this).on("change", function (event, initFlag) {
				_self.layoutSetting(event,initFlag, codeSegmentForm)
			});
		}

		//邦定编码字段onchange事件
		if($(this).attr("id") == "segmentValue_" + (parseInt(currentIdArray[1]) + 1)){
			$(this).off("change").on("change", function (event) {
				_self.validateSegmentValue(event);
			});
		}

        if($(this).attr("id") == "valueStart_" + (parseInt(currentIdArray[1]) + 1)){
            $(this).off("change").on("change", function (event) {
                _self.validateValueStart(event);
            });
        }
		if($(this).attr("id") == "restServicesURL_1"){
			$(this).off("change").on("change", function (event) {
				_self.validateRestServicesURL(event);
			});
		}

		//绑定事通用代码下拉
        if($(this).attr("id") == "vlookupCode_" + (parseInt(currentIdArray[1]) + 1)) {
			var $vlookupCode = $(this);
            $(this).find("input[id^='segmentCode_'],span").off("click").on("click", function (event) {
                new LookupTypeSelect({
                    type: 'lookupSelect',
                    idField: $vlookupCode.find('input[id^="vlookupCodeTypeId_"]'),
                    codeField: $vlookupCode.find('input[id^="segmentValue_"]'),
                    textField: $vlookupCode.find('input[id^="segmentCode_"]'),
                    callBack: function(rowdata){
                    	$vlookupCode.find('input[id^="segmentCode_"]').val(rowdata.lookupTypeName);
                        $vlookupCode.find('input[id^="segmentValue_"]').val(rowdata.lookupType);
                        $vlookupCode.find('input[id^="vlookupCodeTypeId_"]').val(rowdata.id);
                    }
                });
            });
        }
	});

	//修改后面所有行的ID属性
	currentTr.nextAll().each(function(idx,e){
		var eIdArray = $(this).attr("id").split("_");
		$(this).attr("id", eIdArray[0] + "_" + (parseInt(eIdArray[1]) + 1));
		//设定segmentOrder的id
		$(this).find("input,select,a,td>div").each(function(index,elem){
			var elemIdArray = $(this).attr("id").split("_");
			$(this).attr("id", elemIdArray[0] + "_" + (parseInt(elemIdArray[1]) + 1));
			//设定排序的值
			if($(this).attr("id") == "segmentOrder_" + (parseInt(elemIdArray[1]) + 1)){
				$(this).val(parseInt(elemIdArray[1]) + 1);
			}
		});

	});

	//添加新行
	currentTr.after(addTr);

	//动态设置高度
	if((currentTr.siblings().length + 2) * 50 > _self._oldSegmentDivHeight){
		currentTr.closest("div.panel").height( currentTr.closest("div.panel").height() + currentTr.outerHeight(true) );
	}

};

//行删除
SysAutoCode.prototype.delTr = function(event){
	var _self = this;

	var currentTr;
	if(event.target.tagName == "SPAN"){
		currentTr = $(event.target).parent().parent().parent();
	}else{
		currentTr = $(event.target).parent().parent();
	}

	if(currentTr.siblings().length > 0){
		//修改后面所有行的ID属性
		currentTr.nextAll().each(function(idx,e){
			var eIdArray = $(this).attr("id").split("_");
			$(this).attr("id", eIdArray[0] + "_" + (parseInt(eIdArray[1]) - 1));
			$(this).find("input,select,a,td>div").each(function(index,elem){
				var elemIdArray = $(this).attr("id").split("_");
				$(this).attr("id", elemIdArray[0] + "_" + (parseInt(elemIdArray[1]) - 1));
				//设定排序的值
				if($(this).attr("id") == "segmentOrder_" + (parseInt(elemIdArray[1]) - 1)){
					$(this).val(parseInt(elemIdArray[1]) - 1);
				}
			});
		});

		//动态设置高度
		if((currentTr.siblings().length+1) * 50 < _self._oldSegmentDivHeight){
			currentTr.closest("div.panel").height(_self._oldSegmentDivHeight);
		}

		//删除当前行
		currentTr.remove();



	}
};

//行向上
SysAutoCode.prototype.upTr = function(event){
	var currentTr;
	if(event.target.tagName == "SPAN"){
		currentTr = $(event.target).parent().parent().parent();
	}else{
		currentTr = $(event.target).parent().parent();
	}
	var currentIdArray = currentTr.attr("id").split("_");

	var prevTr = currentTr.prev();
	var currentTrTop = currentTr.position().top;
	if(prevTr.length > 0){
		var prevTrTop = prevTr.position().top;
		var prevIdArray = prevTr.attr("id").split("_");

		//修改上一行的ID属性
		prevTr.attr("id", prevIdArray[0] + "_" + (parseInt(prevIdArray[1]) + 1));
		prevTr.find("input,select,a,td>div").each(function(idx,e){
			var eIdArray = $(this).attr("id").split("_");
			$(this).attr("id", eIdArray[0] + "_" + (parseInt(eIdArray[1]) + 1));
			//设定排序的值
			if($(this).attr("id") == "segmentOrder_" + (parseInt(eIdArray[1]) + 1)){
				$(this).val(parseInt(eIdArray[1]) + 1);
			}
		});

		//修改当前行的ID属性
		currentTr.attr("id", currentIdArray[0] + "_" + (parseInt(currentIdArray[1]) - 1));
		currentTr.find("input,select,a,td>div").each(function(idx,e){
			var eIdArray = $(this).attr("id").split("_");
			$(this).attr("id", eIdArray[0] + "_" + (parseInt(eIdArray[1]) - 1));
			//设定排序的值
			if($(this).attr("id") == "segmentOrder_" + (parseInt(eIdArray[1]) - 1)){
				$(this).val(parseInt(eIdArray[1]) - 1);
			}

		});

		//交换动画
		currentTr.css('visibility','hidden');
		prevTr.css('visibility','hidden');
		currentTr.clone()
				 .insertAfter(currentTr)
				 .css({position:'absolute',visibility:'visible',top:currentTrTop})
				 .animate(	{top:prevTrTop},
				 			200,
							function(){
								$(this).remove();
								currentTr.insertBefore(prevTr).css('visibility','visible');
							});
		prevTr.clone()
			  .insertAfter(prevTr)
			  .css({position:'absolute',visibility:'visible',top:prevTrTop})
			  .animate(	{top:currentTrTop},
			  			200,
						function(){
							$(this).remove();
							prevTr.css('visibility','visible');
                            prevTr.insertAfter(currentTr).css('visibility','visible')
						});

		//行交换
		//currentTr.after(prevTr);
	}

};

//行向下
SysAutoCode.prototype.downTr = function(event){
	var currentTr;
	if(event.target.tagName == "SPAN"){
		currentTr = $(event.target).parent().parent().parent();
	}else{
		currentTr = $(event.target).parent().parent();
	}
	var currentIdArray = currentTr.attr("id").split("_");

	var nextTr = currentTr.next();
	var currentTrTop = currentTr.position().top;
	if(nextTr.length > 0){
		var nextTrTop = nextTr.position().top;
		var nextIdArray = nextTr.attr("id").split("_");

		//修改下一行的ID属性
		nextTr.attr("id", nextIdArray[0] + "_" + (parseInt(nextIdArray[1]) - 1));
		nextTr.find("input,select,a,td>div").each(function(idx,e){
			var eIdArray = $(this).attr("id").split("_");
			$(this).attr("id", eIdArray[0] + "_" + (parseInt(eIdArray[1]) - 1));
			//设定排序的值
			if($(this).attr("id") == "segmentOrder_" + (parseInt(eIdArray[1]) - 1)){
				$(this).val(parseInt(eIdArray[1]) - 1);
			}
		});

		//修改当前行的ID属性
		currentTr.attr("id", currentIdArray[0] + "_" + (parseInt(currentIdArray[1]) + 1));
		currentTr.find("input,select,a,td>div").each(function(idx,e){
			var eIdArray = $(this).attr("id").split("_");
			$(this).attr("id", eIdArray[0] + "_" + (parseInt(eIdArray[1]) + 1));
			//设定排序的值
			if($(this).attr("id") == "segmentOrder_" + (parseInt(eIdArray[1]) + 1)){
				$(this).val(parseInt(eIdArray[1]) + 1);
			}
		});

		//交换动画
		currentTr.css('visibility','hidden');
		nextTr.css('visibility','hidden');
		currentTr.clone()
				 .insertAfter(currentTr)
				 .css({position:'absolute',visibility:'visible',top:currentTrTop})
				 .animate(	{top:nextTrTop},
							200,
							function(){
								$(this).remove();
								currentTr.insertAfter(nextTr).css('visibility','visible');
			  				});
		nextTr.clone()
			  .insertAfter(nextTr)
			  .css({position:'absolute',visibility:'visible',top:nextTrTop})
			  .animate(	{top:currentTrTop},
			  			200,
						function(){
							$(this).remove();
                            nextTr.insertBefore(currentTr).css('visibility','visible');
			  		});

		//行交换
		//currentTr.before(nextTr);
	}
};

//根据编码分类来设定后面项目的样式
SysAutoCode.prototype.layoutSetting = function(event,initFlag,codeSegmentForm){
	var _self = this;
	var segmentType = $(event.target);
	var idArray = segmentType.attr("id").split("_");
	var segmentTypeValue = segmentType.val();// 码段类别 1、分类码、2、流水码 3、日期码 4、输入码 5、固定值 6、函数值 7、SQL语句
	var siblings = segmentType.parent().siblings();
	var optionHtml, segmentValueParent, segmentValue, segmentCode,vlookupCodeTypeId, valueStart,restService;
	var segmentValueHtml = $('<input class="form-control input-sm segmentValue" type="text" id="segmentValue_1" name="segmentValue"/>');

	segmentValueHtml.attr("id","segmentValue_" + idArray[1]);
	if(initFlag){
		segmentValue = siblings.find("#segmentValue_" + idArray[1]).val();
        segmentCode = siblings.find("#segmentCode_" + idArray[1]).val();
        if(segmentTypeValue == "1"){//分类码
            vlookupCodeTypeId = siblings.find("#vlookupCodeTypeId_" + idArray[1]).val();
		}
		if(segmentTypeValue === '2' && segmentValue.indexOf(',')>-1){
			valueArray = segmentValue.split(',');
            segmentValue = valueArray[0];
            valueStart = valueArray[1];
		}
		if(segmentTypeValue === '8' && segmentValue.indexOf(',')>-1){
			valueArray = segmentValue.split(',');
			segmentValue = valueArray[0];
			restService = valueArray[1];
		}
		segmentValueHtml.val(segmentValue);

	}

	segmentValueHtml.off("change").on("change", function (event) {
		_self.validateSegmentValue(event);
	});

    segmentValueParent = siblings.find("#segmentValue_" + idArray[1]).closest("td");
	segmentValueParent.empty();

	// 如果有的话，删除起始值设置
	var startTD = siblings.find("#valueStart_" + idArray[1]).closest("td");
	if(startTD.length != 0){
		var startTH = startTD.prev();
		// var segmentRow = startTD.parent();
        startTH.empty();
        startTD.empty();
	}
	//删除服务URL的输入框
    var startTD = siblings.find("#restServicesURL_" + idArray[1]).closest("td");
    if(startTD.length != 0){
        var startTH = startTD.prev();
        // var segmentRow = startTD.parent();
        startTH.empty();
        startTD.empty();
    }


	if(segmentTypeValue == "1"){//分类码

		//通用编码
		siblings.find("[for='segmentValue']").text("通用编码");
        segmentValueHtml.attr("id","segmentCode_" + idArray[1]);
        segmentValueHtml.attr("name","segmentCode");
		var segmentValueSelectHtml =
			$('<div id="vlookupCode" class="input-group input-group-sm avicselect"></div>')
			.append(segmentValueHtml)
			.append('<input type="hidden" name="segmentValue" id="segmentValue_">'+
					'<input type="hidden" name="vlookupCodeTypeId" id="vlookupCodeTypeId_1">'+
            		'<span class="input-group-addon avicselect-act"><i class="glyphicon glyphicon-list"></i></span>');
		segmentValueSelectHtml.attr("id", "vlookupCode_"+idArray[1]);
		segmentValueSelectHtml.find("input[type='hidden'][name='segmentValue']").attr("id", "segmentValue_"+idArray[1]);
		segmentValueSelectHtml.find("input[type='hidden'][name='vlookupCodeTypeId']").attr("id", "vlookupCodeTypeId_"+idArray[1]);
        if(initFlag) {
            segmentValueSelectHtml.find("input[type='text']").val(segmentCode);
            segmentValueSelectHtml.find("input[type='hidden'][name='segmentValue']").val(segmentValue);
            segmentValueSelectHtml.find("input[type='hidden'][name='vlookupCodeTypeId']").val(vlookupCodeTypeId);
        }

        //重新绑定通用代码框
        segmentValueSelectHtml.find("#segmentCode_"+(parseInt(idArray[1]))+",span").off("click").on("click", function (event) {
            new LookupTypeSelect({type:'lookupSelect',
                idField:segmentValueSelectHtml.find('#vlookupCodeTypeId_'+(parseInt(idArray[1]))),
                codeField:segmentValueSelectHtml.find('#segmentValue_'+(parseInt(idArray[1]))),
                textField:segmentValueSelectHtml.find('#segmentCode_'+(parseInt(idArray[1]))),
				callBack: function(rowdata){
                    segmentValueSelectHtml.find('#segmentCode_'+(parseInt(idArray[1]))).val(rowdata.lookupTypeName);
                }
            });
        });

		segmentValueParent.append(segmentValueSelectHtml);

		//可编辑
		if(!initFlag){
			siblings.find("#autoCodeEditFlag_" + idArray[1]).val("1");//设置为可编辑
		}
		siblings.find("#autoCodeEditFlag_" + idArray[1]).prop("disabled", false);

		//关联流水码
		siblings.find("[for='autoIncreaseFlag']").text("关联流水码");
		if(!initFlag){
			siblings.find("#autoIncreaseFlag_" + idArray[1]).val("Y");
		}
		siblings.find("#autoIncreaseFlag_" + idArray[1]).prop("disabled", false);

	}else if(segmentTypeValue == "2"){//流水码

		//通用编码
		siblings.find("[for='segmentValue']").text("长度");
		segmentValueParent.append(segmentValueHtml);

		// 插入起始值输入框

        var valueStartTH = segmentValueParent.next();
        valueStartTH.append('<label for="valueStart">起始值</label>');
		var valueStartTD = valueStartTH.next();
        var valueStartHtml = $('<input class="form-control input-sm valueStart" type="text" id="valueStart_1" name="valueStart"/>');
        valueStartHtml.attr('id', 'valueStart_' + idArray[1]);
        if(initFlag && valueStart){
            valueStartHtml.val(valueStart);
        }
        valueStartHtml.off("change").on("change", function (event) {
            _self.validateValueStart(event);
        });
		valueStartTD.append(valueStartHtml);

		//可编辑
		if(!initFlag){
			siblings.find("#autoCodeEditFlag_" + idArray[1]).val("1");//设置为可编辑
		}
		siblings.find("#autoCodeEditFlag_" + idArray[1]).prop("disabled", false);

		//关联流水码
		siblings.find("[for='autoIncreaseFlag']").text("是否补位");
		if(!initFlag){
			siblings.find("#autoIncreaseFlag_" + idArray[1]).val("Y");
		}
		siblings.find("#autoIncreaseFlag_" + idArray[1]).prop("disabled", false);

	}else if(segmentTypeValue == "3"){//日期码

		//通用编码
		siblings.find("[for='segmentValue']").text("格式化");
		optionHtml = "<select class='form-control input-sm segmentValue' id='segmentValue_" + idArray[1] + "' name='segmentValue' title='格式化'>" +
							"<option value='yyyy'>yyyy</option>" +
							"<option value='yyyyMM'>yyyyMM</option>" +
							"<option value='yyyy-MM'>yyyy-MM</option>" +
							"<option value='yyyy/MM'>yyyy/MM</option>" +
							"<option value='yyyyMMdd'>yyyyMMdd</option>" +
							"<option value='yyyy-MM-dd'>yyyy-MM-dd</option>" +
							"<option value='yyyy年MM月dd日'>yyyy年MM月dd日</option>" +
							"<option value='yyyyMMddHH'>yyyyMMddHH</option>" +
							"<option value='yyyy-MM-dd HH'>yyyy-MM-dd HH</option>" +
							"<option value='yyyy-MM-dd HH:mm'>yyyy-MM-dd HH:mm</option>" +
							"<option value='yyyy-MM-dd HH:mm:ss'>yyyy-MM-dd HH:mm:ss</option>" +
						 "</select>";

		segmentValueParent.append(optionHtml);
		if(initFlag){
			segmentValueParent.find("option[value='"+segmentValue+"']").prop("selected",true);
		}

		//可编辑
		if(!initFlag){
			siblings.find("#autoCodeEditFlag_" + idArray[1]).val("2");//设置为可编辑
		}
		siblings.find("#autoCodeEditFlag_" + idArray[1]).prop("disabled", false);

		//关联流水码
		siblings.find("[for='autoIncreaseFlag']").text("关联流水码");
		if(!initFlag){
			siblings.find("#autoIncreaseFlag_" + idArray[1]).val("Y");
		}
		siblings.find("#autoIncreaseFlag_" + idArray[1]).prop("disabled", false);

	}else if(segmentTypeValue == "4"){ //输入码

		//通用编码
		siblings.find("[for='segmentValue']").text("输入类型");
		optionHtml = "<select class='form-control input-sm segmentValue' id='segmentValue_" + idArray[1] + "' name='segmentValue' title='输入类型'>" +
							"<option value='1'>字符串</option>" +
						 	"<option value='2'>数值</option>" +
							"<option value='3'>日期</option>" +
						 "</select>";

		segmentValueParent.append(optionHtml);
		if(initFlag){
			segmentValueParent.find("option[value='"+segmentValue+"']").prop("selected",true);
		}

		//可编辑
		if(!initFlag){
			siblings.find("#autoCodeEditFlag_" + idArray[1]).val("1");//设置为可编辑
		}
		siblings.find("#autoCodeEditFlag_" + idArray[1]).prop("disabled", true);

		//关联流水码
		if(!initFlag){
			siblings.find("#autoIncreaseFlag_" + idArray[1]).val("N");//设置为否
		}
		siblings.find("#autoIncreaseFlag_" + idArray[1]).prop("disabled", false);

	}else if(segmentTypeValue == "5"){ //固定值

		//通用编码
		siblings.find("[for='segmentValue']").text("码段值");
		segmentValueParent.append(segmentValueHtml);

		//可编辑
		if(!initFlag){
			siblings.find("#autoCodeEditFlag_" + idArray[1]).val("2");//设置为否
		}
		siblings.find("#autoCodeEditFlag_" + idArray[1]).prop("disabled", true);

		//关联流水码
		if(!initFlag){
			siblings.find("#autoIncreaseFlag_" + idArray[1]).val("N");//设置为否
		}
		siblings.find("#autoIncreaseFlag_" + idArray[1]).prop("disabled", true);

	}else if(segmentTypeValue == "6"){ //函数值

		//通用编码
		siblings.find("[for='segmentValue']").text("函数路径");
		segmentValueParent.append(segmentValueHtml);

		//可编辑
		if(!initFlag){
			siblings.find("#autoCodeEditFlag_" + idArray[1]).val("2");//设置为否
		}
		siblings.find("#autoCodeEditFlag_" + idArray[1]).prop("disabled", true);

		//关联流水码
		if(!initFlag){
			siblings.find("#autoIncreaseFlag_" + idArray[1]).val("N");//设置为否
		}
		siblings.find("#autoIncreaseFlag_" + idArray[1]).prop("disabled", false);

	}else if(segmentTypeValue == "7"){ //SQL语句

		//通用编码
		siblings.find("[for='segmentValue']").text("SQL脚本");
		segmentValueParent.append(segmentValueHtml);

		//可编辑
		if(!initFlag){
			siblings.find("#autoCodeEditFlag_" + idArray[1]).val("2");//设置为否
		}
		siblings.find("#autoCodeEditFlag_" + idArray[1]).prop("disabled", true);

		//关联流水码
		if(!initFlag){
			siblings.find("#autoIncreaseFlag_" + idArray[1]).val("N");//设置为否
		}
		siblings.find("#autoIncreaseFlag_" + idArray[1]).prop("disabled", false);

	}else if (segmentTypeValue == "8"){//rest服务 restService
		//通用编码
		siblings.find("[for='segmentValue']").text("服务名");
		segmentValueParent.append(segmentValueHtml);

		//通用编码
		var restServicesURLTH = segmentValueParent.next();
		restServicesURLTH.append('<th width="10%" style="white-space:nowrap;">');
		restServicesURLTH.append('<i class="required">*</i>');
		restServicesURLTH.append('<label for="restServicesURL">服务URL</label>');
		restServicesURLTH.append(' </th>');
		var restServicesURLTD = restServicesURLTH.next();
		var restServicesURLHTML = $('<input class="form-control input-xs restServicesURL" type="text" id="restServicesURL_1" name="restServicesURL"/>');
		restServicesURLHTML.attr('id', 'restServicesURL_' + idArray[1]);
		if(initFlag && restService){
			restServicesURLHTML.val(restService);
		}
		restServicesURLTD.append(restServicesURLHTML);
		//可编辑
		restServicesURLHTML.off("change").on("change", function (event) {
			_self.validateRestServicesURL(event);
		});
		if(!initFlag){
			siblings.find("#autoCodeEditFlag_" + idArray[1]).val("2");//设置为否
		}
		siblings.find("#autoCodeEditFlag_" + idArray[1]).prop("disabled", true);

		//关联流水码
		if(!initFlag){
			siblings.find("#autoIncreaseFlag_" + idArray[1]).val("N");//设置为否
		}
		siblings.find("#autoIncreaseFlag_" + idArray[1]).prop("disabled", false);
	}
};

//根据编码分类来设定后面项目的样式
SysAutoCode.prototype.preview = function(codeSegmentForm, previewContent){
	var _self = this;

	var disabledElem = codeSegmentForm.find(":disabled");
	disabledElem.each(function(idx,elem){
		$(this).prop("disabled",false);
	});
	var segmentArray = serializeArrayObject(codeSegmentForm);
    for(var i = 0; i < segmentArray.length ; i++){
    	var segment  = segmentArray[i];
    	if(segment.segmentType === '2'){
            var start = segment.valueStart;
            if(start){
                var value = segment.segmentValue;
                segment.segmentValue = value + ',' + start;
            }
            delete segment['valueStart'];
            continue;
		}
		if(segment.segmentType === '8'){
			var restServicesURL = segment.restServicesURL;
			if(restServicesURL){
				var value = segment.segmentValue;
				segment.segmentValue = value + ',' + restServicesURL;
			}
			delete segment['restServicesURL'];
			continue;
		}
	}
    var data = {codeSegment:JSON.stringify(segmentArray)};
	// var data = {codeSegment:JSON.stringify(serializeArrayObject(codeSegmentForm))};

	disabledElem.each(function(idx,elem){
		$(this).prop("disabled",true);
	});

	$.ajax({
		type: "post",
		url: _self._url + "previewAutoCode",
		data: data,
		dataType: "json",
		success: function (resp) {
			if(resp.flag == "success"){
				if(isNotEmpty(resp.data)){
					_self.previewResult(resp.data, previewContent);
				}
			}else{
				 layer.alert('预览失败！', {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
			}

		}
	});
};

//预览结果
SysAutoCode.prototype.previewResult = function(data, previewContent){
	var _self = this;
	//var html = $('<form class="form-inline" role="form" id="previewForm"></form>');
	var tableHtml = $('<table class="" id="displayContentTable"></table>');
	var trHtml = $("<tr></tr>");
	var elemHtml;
	trHtml.append('<td style="padding:2px"><span class="glyphicon glyphicon-zoom-in" style="min-width: 30px;padding:0 5px"></span></td>');
	$.each(data, function (idx, obj) {
		if(obj.segmentType == "1"){//分类码
			elemHtml = $('<select class="form-control input-xs autocodeclass" id="classif" name="classifCode"></select>');
			$.each(JSON.parse(obj.codeValue),function(i, elem){
				var optionHtml = $("<option></option>");
				optionHtml.val(elem.name).text(elem.name);
				elemHtml.append(optionHtml)
			});
			//是否可编辑
			if(obj.autoCodeEditFlag == "2" ){
				elemHtml.prop("disabled",true);
			}else if(obj.autoCodeEditFlag == "3"){
				elemHtml.css("display","none");
			}

		}else if(obj.segmentType == "2"){//流水码
			if(obj.autoCodeEditFlag == "1"){
				elemHtml = $('<input class="form-control input-xs autocodeclass" style="width:100px" type="text" id="serialCode" name="serialCode" title="流水码" value="' + obj.codeValue + '"/>');
				//elemHtml.val(obj.codeValue);
			}else if(obj.autoCodeEditFlag == "2"){
				elemHtml =  $('<span name="serialCode" class="autocodeclass">' + obj.codeValue + '</span>');
			}else{
				elemHtml =  $('<span name="serialCode" class="autocodeclass">' + obj.codeValue + '</span>');
				elemHtml.css("display","none");
			}

		}else if(obj.segmentType == "3"){//日期码
			if(obj.autoCodeEditFlag == "1"){
				elemHtml = $('<input class="form-control input-xs autocodeclass" style="width:100px" type="text" id="" name="dateCode" title="日期码"/>');
				elemHtml.val(obj.codeValue);
				if(obj.segmentValue == "yyyy" ){
                    elemHtml.css("width", "70px");
                }else if(obj.segmentValue == "yyyyMM" || obj.segmentValue == "yyyy-MM" || obj.segmentValue == "yyyy/MM"){
                    elemHtml.css("width", "90px");
                }else if(obj.segmentValue == "yyyyMMdd" || obj.segmentValue == "yyyy-MM-dd" || obj.segmentValue == "yyyyMMddHH"){
                    elemHtml.css("width", "110px");
                }else if(obj.segmentValue == "yyyy年MM月dd日" || obj.segmentValue == "yyyy-MM-dd HH" || obj.segmentValue == "yyyy-MM-dd HH:mm"){
                    elemHtml.css("width", "150px");
                }else{
                    elemHtml.css("width", "170px");
                }
			}else if(obj.autoCodeEditFlag == "2"){
				elemHtml =  $('<span name="dateCode" class="autocodeclass">' + obj.codeValue + '</span>');
			}else{
				elemHtml =  $('<span name="dateCode" class="autocodeclass">' + obj.codeValue + '</span>');
				elemHtml.css("display","none");
			}

		}else if(obj.segmentType == "4"){//输入码
			if(obj.segmentValue == "1"){
				elemHtml = $('<input class="form-control input-xs autocodeclass" style="width:100px" type="text" id="" name="inputCode" title="输入码-字符串"/>');
			}else if(obj.segmentValue == "2"){
				elemHtml = $('<input class="form-control input-xs autocodeclass" style="width:100px" type="text" id="" name="inputCode" title="输入码-数值"/>');
			}else{
				elemHtml = $('<div class="input-group input-group-xs" style="width:200px"> ' +
		                	    '<input class="form-control date-picker autocodeclass" type="text" name="inputCode" id="" readonly title="输入码-日期"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>' +
		              	    '</div>');

			}

		}else if(obj.segmentType == "5"){//固定值

			elemHtml =  $('<span ame="fixedCode" class="autocodeclass">' + obj.codeValue + '</span>');

		}else if(obj.segmentType == "6"){//函数值

			elemHtml =  $('<span name="funcCode" class="autocodeclass">' + obj.codeValue + '</span>');

		}else if (obj.segmentType == "7"){//SQL语句
			elemHtml =  $('<span name="sqlCode" class="autocodeclass">' + obj.codeValue + '</span>');

		}else if(obj.segmentType == "8"){//rest服务
            elemHtml =  $('<span name="sqlCode" class="autocodeclass">' + obj.codeValue + '</span>');
        }


		trHtml.append($("<td style='white-space:nowrap;padding:2px'></td>").append(elemHtml));

	});

	previewContent.empty();
	previewContent.append(tableHtml.append(trHtml));
	previewContent.find(".date-picker[name='inputCode']").datepicker();
	previewContent.find(".spinner [name='inputCode']").spinner();
    layer.open({
        area: ['60%', 'auto'],
        title: '预览',
        skin: 'bs-modal',
        content: previewContent.html()
    });

};

//校验编码明细
SysAutoCode.prototype.validateSegmentForm = function(codeSegmentForm){
	var _self = this;

	var data = serializeArrayObject(codeSegmentForm);
	var error = "";
	var seiralNumCount = 0;

	$.each(data, function (idx, elem) {
		//非空判断

		if(elem.segmentType=="8"){
            if(!isNotEmpty(elem.restServicesURL)){
                error ="服务URL是必须字段!";
                codeSegmentForm.find("#restServicesURL_"+(idx+1)).attr("title", error).tooltip("show");
                codeSegmentForm.find("#restServicesURL_"+(idx+1)).attr("data-original-title", error).tooltip("show");
                codeSegmentForm.find("#restServicesURL_"+(idx+1)).addClass("error");
             }
        }
        if(!isNotEmpty(elem.segmentValue)){
            error = _self._segmentLabel[parseInt(elem.segmentType)-1]+"是必须字段!";
            if(elem.segmentType == "1"){
                codeSegmentForm.find("#segmentCode_"+(idx+1)).attr("title", error).tooltip("show");
                codeSegmentForm.find("#segmentCode_"+(idx+1)).attr("data-original-title", error).tooltip("show");
                codeSegmentForm.find("#segmentCode_"+(idx+1)).addClass("error");
            }else{
                codeSegmentForm.find("#segmentValue_"+(idx+1)).attr("title", error).tooltip("show");
                codeSegmentForm.find("#segmentValue_"+(idx+1)).attr("data-original-title", error).tooltip("show");
                codeSegmentForm.find("#segmentValue_"+(idx+1)).addClass("error");
            }

            return true;
        }

        //分类码
        if(elem.segmentType == "1"){

            $.ajax({
                type: "post",
                url: _self._url + "checkLooukupCode",
                data: {"looukupCode":elem.segmentValue},
                dataType: "json",
                async:false,
                success: function (resp) {
                    if(resp.flag == "success"){
                        if(resp.result !== "true"){
							error = "通用代码不能为空类型!";
							codeSegmentForm.find("#segmentCode_" + (idx + 1)).attr("title", error).tooltip("show");
							codeSegmentForm.find("#segmentCode_" + (idx + 1)).attr("data-original-title", error).tooltip("show");
							codeSegmentForm.find("#segmentCode_" + (idx + 1)).addClass("error");
                            return true;
                        }
                    }
                }
            });
        }

        //流水码
        if(elem.segmentType == "2"){
            seiralNumCount = seiralNumCount + 1;
        }

        if(!isNotEmpty(error)){
            if(_self._validateSegmentResult){
                if(elem.segmentType == "1") {
                    codeSegmentForm.find("#segmentCode_"+(idx+1)).attr("title", "");
                    codeSegmentForm.find("#segmentCode_"+(idx+1)).attr("data-original-title", "");
                    codeSegmentForm.find("#segmentCode_" + (idx + 1)).removeClass("error");
                    codeSegmentForm.find("#segmentCode_" + (idx + 1)).tooltip('destroy');
                }else{
                    codeSegmentForm.find("#segmentValue_"+(idx+1)).attr("title", "");
                    codeSegmentForm.find("#segmentValue_"+(idx+1)).attr("data-original-title", "");
                    codeSegmentForm.find("#segmentValue_" + (idx + 1)).removeClass("error");
                    codeSegmentForm.find("#segmentValue_" + (idx + 1)).tooltip('destroy');
                }
            }
        }
	});

	if(!isNotEmpty(error) && seiralNumCount == 0){
		error = "请添加一个流水码！";
		layer.alert(error, {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
	}else if(!isNotEmpty(error) && seiralNumCount !== 1){
		error = "流水码只能添加一个！";
		layer.alert(error, {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
	}

	if(isNotEmpty(error)){
		_self._validateSegmentFormResult = false;
	}else{
		_self._validateSegmentFormResult = true;
	}
};
SysAutoCode.prototype.validateRestServicesURL = function(event){
	var _self = this;
	var RestServicesURLValue = $(event.target).val();
	var restNameExp = $(event.target).parent().parent().parent().find('.segmentValue').val();
  		$.ajax({
			type: "post",
			url: _self._url + "checkRestServicesURL",
			data: {"restNameExp":restNameExp,"restUrlExp":RestServicesURLValue},
			dataType: "json",
			success: function (resp) {
				if(resp.flag == "success"){
					if(resp.result !== "true"){
						var error = "rest服务URL有误!";
						$(event.target).attr("title", error).tooltip("show");
						$(event.target).attr("data-original-title", error).tooltip("show");
						$(event.target).addClass("error");
						_self._validateSegmentResult = false;
					}else{
						$(event.target).attr("title", "");
						$(event.target).attr("data-original-title", "");
						$(event.target).removeClass("error");
						$(event.target).tooltip('destroy');
						_self._validateSegmentResult = true;
					}
				}
			}
		});

}
SysAutoCode.prototype.validateValueStart = function(event){
	var _self = this;
    var valueStart = $(event.target);
    var idArray = valueStart.attr("id").split("_");

    var error = "";
    var validated = true;
    if(valueStart.val() === ''){

    }else if(!/^[1-9]\d*$/.test(valueStart.val())){
        error = "请输入有效的起始值!";
        validated = false;
    }else{
        var startLen = valueStart.val().length;
        var siblings = valueStart.parent().siblings();
        var segmentValue = siblings.find("#segmentValue_" + idArray[1]).val();
        var valueLen = parseInt(segmentValue);

        if(startLen > valueLen){
            error = "请输入有效的起始值!";
            validated = false;
        }
    }
    if(!validated){
        valueStart.attr("title", error).tooltip("show");
        valueStart.attr("data-original-title", error).tooltip("show");
        valueStart.addClass("error");
        _self._validateSegmentResult = false;
    }else{
        valueStart.attr("title", "");
        valueStart.attr("data-original-title", "");
        valueStart.removeClass("error");
        valueStart.tooltip('destroy');
        _self._validateSegmentResult = true;
    }
}

//校验编码明细
SysAutoCode.prototype.validateSegmentValue = function(event){
	var _self = this;

	var segmentValue = $(event.target);
	var segmentType = segmentValue.closest("tr").find("select[id^='segmentType']");
	var segmentValueValue = segmentValue.val();
	var segmentTypeValue = segmentType.val();

	var error = "";
	var seiralNumCount = 0;

	//流水码
	if(segmentTypeValue == "2"){

		if(!/^[1-9]\d*$/.test(segmentValueValue)){
			error = "请输入大于1的数字!";
			segmentValue.attr("title", error).tooltip("show");
			segmentValue.attr("data-original-title", error).tooltip("show");
			segmentValue.addClass("error");
			_self._validateSegmentResult = false;
		}else{
			segmentValue.attr("title", "");
			segmentValue.attr("data-original-title", "");
			segmentValue.removeClass("error");
			segmentValue.tooltip('destroy');
			_self._validateSegmentResult = true;
		}

	}

    //固定值
    if(segmentTypeValue == "5"){

        if(segmentValueValue.indexOf("$") != -1){
            error = "不能输入$字符!";
            segmentValue.attr("title", error).tooltip("show");
            segmentValue.attr("data-original-title", error).tooltip("show");
            segmentValue.addClass("error");
            _self._validateSegmentResult = false;
        }else{
            segmentValue.attr("title", "");
            segmentValue.attr("data-original-title", "");
            segmentValue.removeClass("error");
            segmentValue.tooltip('destroy');
            _self._validateSegmentResult = true;
        }
    }

	//函数值
	if(segmentTypeValue == "6"){
		$.ajax({
			type: "post",
			url: _self._url + "checkFuncExp",
			data: {"funcExp":segmentValueValue},
			dataType: "json",
			success: function (resp) {
				if(resp.flag == "success"){
					if(resp.result !== "true"){
						error = "函数路径有误!";
						segmentValue.attr("title", error).tooltip("show");
						segmentValue.attr("data-original-title", error).tooltip("show");
						segmentValue.addClass("error");
						_self._validateSegmentResult = false;
					}else{
						segmentValue.attr("title", "");
						segmentValue.attr("data-original-title", "");
						segmentValue.removeClass("error");
						segmentValue.tooltip('destroy');
						_self._validateSegmentResult = true;
					}
				}
			}
		});
	}

	//SQL语句
	if(segmentTypeValue == "7"){
		$.ajax({
			type: "post",
			url: _self._url + "checkSqlExp",
			data: {"sqlExp":segmentValueValue},
			dataType: "json",
			success: function (resp) {
				if(resp.flag == "success"){
					if(resp.result !== "true"){
						error = "SQL脚本有误!";
						segmentValue.attr("title", error).tooltip("show");
						segmentValue.attr("data-original-title", error).tooltip("show");
						segmentValue.addClass("error");
						_self._validateSegmentResult = false;
					}else{
						segmentValue.attr("title", "");
						segmentValue.attr("data-original-title", "");
						segmentValue.removeClass("error");
						segmentValue.tooltip('destroy');
						_self._validateSegmentResult = true;
					}
				}
			}
		});
	}
	//rest 服务名验证
	if(segmentTypeValue == "8"){
		$.ajax({
			type: "post",
			url: _self._url + "checkRestServicesName",
			data: {"restNameExp":segmentValueValue},
			dataType: "json",
			success: function (resp) {
				if(resp.flag == "success"){
					if(resp.result !== "true"){
						error = "rest服务名有误!";
						segmentValue.attr("title", error).tooltip("show");
						segmentValue.attr("data-original-title", error).tooltip("show");
						segmentValue.addClass("error");
						_self._validateSegmentResult = false;
					}else{
						segmentValue.attr("title", "");
						segmentValue.attr("data-original-title", "");
						segmentValue.removeClass("error");
						segmentValue.tooltip('destroy');
						_self._validateSegmentResult = true;
					}
				}
			}
		});
	}

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

function LookupTypeSelect(option) {
    // 用户参数
    this.type = option.type;
    this.idField = option.idField;
    this.codeField = option.codeField;
    this.textField = option.textField;
    this.callBack = option.callBack;
    this.beferClose = option.beferClose;
    if (this.type == "lookupSelect") {
        this.lookupTypeSelectUrl = "avicit/platform6/h5component/common/LookupTypeSelect.jsp";
    }
    this.init.call(this);
    return this;
};
LookupTypeSelect.prototype.init = function() {
    var _self = this;
    var selectDialog = openDialog({
        type : 'selectWindow',
        title : "请选择通用代码类型",
        url : _self.lookupTypeSelectUrl,
        width : "800px",
        height : "450px",
        opentype : 2,
        shade : true,
        submit : function(index, layer) {
            var iframeWin = layer.find('iframe')[0].contentWindow;
            var objData = iframeWin.rowObjData;
			_self.idField.val(objData.id);
			_self.codeField.val(objData.lookupType);
            _self.textField.val(objData.lookupTypeName);
            if(_self.callBack!=null && _self.callBack!='undefined'){
                if(typeof(_self.callBack) === 'function'){
                    _self.callBack(objData);
                }
            }
        },
        beferClose: function(index, layer){
            if(typeof(_self.beferClose) === 'function'){
                _self.beferClose(index, layer);
            }
        },
        init : function(index, layer) {
            var iframeWin = layer.find('iframe')[0].contentWindow;
            var lookuptypeid = _self.idField.val();
            iframeWin.init({
                lookuptypeid:lookuptypeid,
                idField : _self.idField,
                textField :_self.textField,
                callBack:_self.callBack
            });
        }
    });
}

