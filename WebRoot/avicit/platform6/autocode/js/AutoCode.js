/**
 * 自动编码用户组件
 */
//autoCode      自动编码代码，必须字段,对应sys_auto_code表的code字段 如：SYS_AUTO_CODE_TEST
//divId         自动编号所在的div的id，必须字段
//isEdit        是否可编辑，默认是true
//autoCodeInputName   自定义Input控件的name属性，默认是autoCodeValue
//businessId    业务ID，默认是空字符串，如果编码规则有函数的情况下，必须字段，否则将显示XXX
//callback      回调函数
//isEditPage    是否是编辑页面，默认false, 为true的情况下，autoCode和autoCodeValue必须有值
//autoCodeValue 自动编码值
function AutoCode(autoCode, divId, isEdit, autoCodeInputName, businessId, callback, isEditPage, autoCodeValue){
    this.autoCode = autoCode;
    this.divId =  $('#'+divId);
    this.isEdit = (isEdit === true || isEdit === false) ? isEdit : true;
    this.autoCodeInputName =  isNotEmpty(autoCodeInputName) ? autoCodeInputName : "autoCodeValue";
    this.businessId = isNotEmpty(businessId) ? businessId : "";
    this.callback = callback;
    this.isEditPage = (isEditPage === true || isEditPage === false) ? isEditPage : false;
    this.autoCodeValue = isNotEmpty(autoCodeValue) ? autoCodeValue : "";

    this.template = null;           //模板
    this.autoCodeData = null;       //保存用户提交后的编码值
    this.segmentData = null;        //保存编码规则
    this.autoIncreaseCode = null;   //关联自增长编号
    this.serialNumLength = null;    //流水码的长度
    this.jumpCodeLimitLength = 200;

    this.init.call(this);
};
//初始化操作
AutoCode.prototype.init = function () {
    var _this = this;

    if(!isNotEmpty(_this.autoCode)){
        layer.alert("请填入自动编码代码！" , {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
        return;
    }

    if(_this.divId.length <= 0){
        layer.alert("请填入自动编码所在位置的正确的DIV ID！", {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
        return;
    }

    var editHtml = $('<div id="" style="position: relative">'+
                        '<div class="input-group input-group-xs">'+
                            '<input type="hidden" name="autoCodeValue" id="autoCodeValue"/>'+
                            '<input class="form-control input-sm" type="text" name="autoCode" id="autoCode" readonly/>'+
                            '<span class="input-group-addon" id="autoCode_edit">'+
                                '<a href="javascript:;" class="spin-down" data-spin="down" ><i class="glyphicon glyphicon-triangle-bottom"></i></a>'+
                            '</span>'+
                        '</div>'+
                        '<div style="height:100px;border:1px solid #ccc;display:none;position:absolute;background-color:White;z-index:9999" id="displayContentDiv">'+
                            '<table class="" style="border: 0; height: 50px; margin:5px;" id="displayContentTable">' +
                           '<tr id="displayContentTr">'+
                               //'<td><input class="form-control input-sm" type="text" name="" id="editAutoCode_"/></td>'+
                               '</tr>'+
                            '</table>'+
                            '<table class="tableForm" style="border: 0; cellspacing: 1;height: 40px;">'+
                                '<tr>'+
                                    '<td width="260px" style="text-align: right;padding-right:0px; ">'+
                                        '<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"title="确认" id="autoCode_save" style="width: 25%;min-width:30px;max-width:78px;">确认</a>'+
                                        '<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="autoCode_close" style="width: 25%;min-width:30px;max-width:78px;">返回</a>'+
                                    '</td>'+
                                '</tr>'+
                            '</table>'+
                        '</div>'+
                    '</div>');

    var noEditHtml = $('<div>'+
                        '<input class="form-control input-sm" type="text" name="autoCode" id="autoCode" readonly/>'+
                        '<input type="hidden" name="autoCodeValue" id="autoCodeValue"/>'+
                        '</div>');

    if(_this.isEdit){
        _this.template = editHtml;
        
    }else{
        _this.template = noEditHtml;
    }

    //绘制HTML
     _this.drawHtml();

};

//绘制HTML
AutoCode.prototype.drawHtml = function () {
    var _this = this;

    var data = {"autoCode":_this.autoCode,
                "businessId":_this.businessId};
    //取得数据
    $.ajax({
		type: "post",
		url:  "platform/sysautocode/sysAutoCodeManageController/getAutoCodeData",
		data: data,
		dataType: "json",
		success: function (resp) { //ruls data //code data
			if(resp.flag == "success"){
                _this.setSegmentData(resp.data);
                if(_this.isEdit){
				    _this.drawEditHtml();
                    _this.appendToDiv();
                    _this.bindEvent();
                    //_this.setCodeValue(resp.inputFlag);
                    _this.setCodeValue(true);
                    _this.setCss();

                }else{
                    _this.drawNoEditHtml();
                }

                //回调函数
                if(typeof(_this.callback) === "function"){
                    _this.callback();
                }
			}
		}
	});

};

//setSegmentData
AutoCode.prototype.setSegmentData = function(data){
    var _this = this;
    
    _this.segmentData = data;

    $.each(data, function (idx, obj) { 
        if(obj.segmentType == "1"){//分类码
            $(JSON.parse(obj.codeValue)).each(function(i, elem){
                 _this.segmentData[idx].value = elem.name;
                 return false;
            });
        }else{
            _this.segmentData[idx].value = obj.codeValue;
        }

        if(obj.segmentType == "2"){//流水码
            var segmentValue = obj.segmentValue;
            if(segmentValue.indexOf(',')>-1){
                valueArray = segmentValue.split(',');
                segmentValue = valueArray[0];
                valueStart = valueArray[1];
            }
            _this.serialNumLength = segmentValue;
            _this.autoIncreaseFlag = obj.autoIncreaseFlag;
        }

    });

    _this.autoIncreaseCode = $.map(_this.segmentData, function (obj, idx){
        //不是流水码且是自动增长
        return obj.segmentType != "2" && obj.autoIncreaseFlag == "Y" ? obj.value : "";
    });

};

//通过编码值查询得到带##的编码值
AutoCode.prototype.getAutoCodeByValue = function(){
    var _this = this;
    var result = "";

    var data = {"autoCodeValue":_this.autoCodeValue,
                "autoCode":_this.autoCode};
    //取得数据
    $.ajax({
        type: "post",
        url:  "platform/sysautocode/sysAutoCodeManageController/getAutoCodeByValue",
        data: data,
        async: false,
        dataType: "json",
        success: function (resp) { //ruls data //code data
            if(resp.flag == "success"){
                result =  resp.result;
            }
        }
    });

    return result;
};

//绘制非编辑HTML
AutoCode.prototype.drawNoEditHtml = function () {
    var _this = this;
    var codeData = $.map(_this.segmentData, function (obj, idx){
        return obj.value;
    });

    _this.template.find("input[type='text']").val(codeData.join(""));
    _this.template.find("input[type='hidden']").val("$$" + codeData.join("$$") + "$$");
    _this.divId.empty();
    _this.divId.append(_this.template);
    //设定输入框的name属性
    if(isNotEmpty(_this.autoCodeInputName)){
        _this.divId.find('#autoCodeValue').attr("name", _this.autoCodeInputName);
    }
};


//绘制编辑HTML
AutoCode.prototype.drawEditHtml = function(){
	var _this = this;
    var trHtml = _this.template.find('#displayContentTr');
	var elemHtml;

    trHtml.empty();

	$.each(_this.segmentData, function (idx, obj) {
		if(obj.segmentType == "1"){//分类码
			elemHtml = $('<select class="form-control input-xs autocodeclass" style="width:100px" id="" name="classifCode"></select>');
			$(JSON.parse(obj.codeValue)).each(function(i, elem){
				var optionHtml = $("<option></option>");
				optionHtml.val(elem.name).text(elem.name);
				elemHtml.append(optionHtml);
			});
			//是否可编辑
			if(obj.autoCodeEditFlag == "2" ){
				elemHtml.prop("disabled",true);
			}else if(obj.autoCodeEditFlag == "3"){
				elemHtml.css("display","none");
			}

		}else if(obj.segmentType == "2"){//流水码
			if(obj.autoCodeEditFlag == "1"){
				elemHtml = $('<input class="form-control input-xs autocodeclass" style="width:100px" type="text" id="" name="serialCode" title="流水码"/>');
				elemHtml.val(obj.codeValue);
			}else if(obj.autoCodeEditFlag == "2"){
				elemHtml =  $('<span name="serialCode" class="autocodeclass" style="white-space:nowrap">' + obj.codeValue + '</span>');
			}else{
				elemHtml =  $('<span name="serialCode" class="autocodeclass" style="white-space:nowrap">' + obj.codeValue + '</span>');
				elemHtml.css("display","none");
			}

		}else if(obj.segmentType == "3"){//日期码 
			if(obj.autoCodeEditFlag == "1"){
                elemHtml = $('<input class="form-control input-xs autocodeclass" style="width:100px" type="text" id="" name="dateCode"  title="日期码"/>');
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
				elemHtml =  $('<span name="dateCode" class="autocodeclass" style="white-space:nowrap">' + obj.codeValue + '</span>');
			}else{
				elemHtml =  $('<span name="dateCode" class="autocodeclass" style="white-space:nowrap">' + obj.codeValue + '</span>');
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

			elemHtml =  $('<span ame="fixedCode" class="autocodeclass" style="white-space:nowrap">' + obj.codeValue + '</span>');
			
		}else if(obj.segmentType == "6"){//函数值 

			elemHtml =  $('<span name="funcCode" class="autocodeclass" style="white-space:nowrap">' + obj.codeValue + '</span>');

		}else{//SQL语句
			elemHtml =  $('<span name="sqlCode" class="autocodeclass" style="white-space:nowrap">' + obj.codeValue + '</span>');

		}

        if(elemHtml.find("input").length > 0){
            elemHtml.find("input").attr("id","editAutoCode_"+ (idx+1));
        }else{
            elemHtml.attr("id","editAutoCode_"+ (idx+1));
        }
		
		trHtml.append($("<td style='padding:2px'></td>").append(elemHtml));
        
	});

};

//邦定事件
AutoCode.prototype.bindEvent = function () {
    var _this = this;

   //邦定编辑按钮单击事件
    _this.template.find("#autoCode_edit").unbind("click").on("click", function(){
        var top;
        var displayContentDivHight = _this.divId.find('#displayContentDiv').outerHeight(true);
        var inputHeight = _this.divId.find('#autoCode').outerHeight(true);
        var divTopInWindos = _this.divId.offset().top;

        if($(window).height() - divTopInWindos - _this.divId.outerHeight(true) > displayContentDivHight + 20){
            top = inputHeight + 5;
            _this.divId.find('#displayContentDiv').css("left", 0);
            _this.divId.find('#displayContentDiv').css("top", top);
        }else{
            top = - displayContentDivHight + 5;
            _this.divId.find('#displayContentDiv').css("left", 0);
            _this.divId.find('#displayContentDiv').css("top", top);
        }

         _this.template.find('#displayContentDiv').toggle();
    });

   //邦定提交按钮单击事件
    _this.template.find("#autoCode_save").unbind("click").on("click", function(){
        if(_this.validate()){
            _this.submit();
        }
    });

   //邦定取消按钮单击事件
    _this.template.find("#autoCode_close").unbind("click").on("click", function(){
         _this.template.find('#displayContentDiv').hide();
    });

    //
    _this.template.find("select,input").unbind("change").on("change",function(event){
        _this.reloadSerialNumber(event);
    });
};

//提交按钮
AutoCode.prototype.submit = function () {
    var _this = this;

    var data = _this.getAutoCodeDataFromLocal();
    var codeData = "$$" + data.join("$$") + "$$";
    
    $.ajax({
		type: "post",
		url:  "platform/sysautocode/sysAutoCodeManageController/checkAutoCodeValue",
		data: {"autoCode":_this.autoCode,"autoCodeValue":codeData},
		dataType: "json",
		success: function (resp) { //ruls data //code data
			if(resp.flag == "success"){
                if(resp.result.isExists == "false"){
                    if(resp.result.isBiggerThenjumpCodeMaxCount == "false") {
                        _this.autoCodeData = codeData;
                        _this.template.find('#autoCodeValue').val(codeData);
                        _this.template.find('#autoCode').val(data.join(""));
                        _this.template.find('#displayContentDiv').hide();
                    }else{
                        layer.alert("当前流水码最大值不能超过【"+ resp.result.expectMaxCodeValue + "】，请修改！", {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
                    }
                }else{
                    layer.alert("该编码已经存在！", {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
                }
			}else{
                layer.alert("调用rest服务出错!", {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
            }
		}
	});

};

AutoCode.prototype.validate = function(){
    var _this = this;
    var validateResult = true;
    var data = _this.getAutoCodeDataFromLocal();
    var numberReg = /^[0]|[1-9]\d*$/;
    var dateReg_yyyy = /^(\d{4})$/;
    var dateReg_yyyyMM1 = /^(\d{4})(0\d{1}|1[0-2])$/;  //yyyyMM
    var dateReg_yyyyMM2 = /^(\d{4})-(0\d{1}|1[0-2])$/; //yyyy-MM
    var dateReg_yyyyMM3 = /^(\d{4})\/(0\d{1}|1[0-2])$/; //yyyy/MM
    var dateReg_yyyyMMdd1 =  /^(\d{4})(0\d{1}|1[0-2])(0\d{1}|[12]\d{1}|3[01])$/;  //yyyyMMdd
    var dateReg_yyyyMMdd2 =  /^(\d{4})-(0\d{1}|1[0-2])-(0\d{1}|[12]\d{1}|3[01])$/;  //yyyy-MM-dd
    var dateReg_yyyyMMdd3 =  /^(\d{4})年(0\d{1}|1[0-2])月(0\d{1}|[12]\d{1}|3[01])日$/;  //yyyy年MM月dd日
    var dateReg_yyyyMMddHH1 =  /^(\d{4})(0\d{1}|1[0-2])(0\d{1}|[12]\d{1}|3[01])(0\d{1}|1\d{1}|2[0-3])$/;  //yyyyMMddHH
    var dateReg_yyyyMMddHH2 =  /^(\d{4})-(0\d{1}|1[0-2])-(0\d{1}|[12]\d{1}|3[01]) (0\d{1}|1\d{1}|2[0-3])$/;  //yyyy-MM-dd HH
    var dateReg_yyyyMMddHH3 =  /^(\d{4})-(0\d{1}|1[0-2])-(0\d{1}|[12]\d{1}|3[01]) (0\d{1}|1\d{1}|2[0-3]):([0-5]\d{1})$/;  //yyyy-MM-dd HH:mm
    var dateReg_yyyyMMddHH4 =  /^(\d{4})-(0\d{1}|1[0-2])-(0\d{1}|[12]\d{1}|3[01]) (0\d{1}|1\d{1}|2[0-3]):[0-5]\d{1}:([0-5]\d{1})$/;  //yyyy-MM-dd HH:mm:ss

    $.each(_this.segmentData, function (idx, obj) { 
        if(obj.autoCodeEditFlag == "1"){//可编辑
            //流水码
            if(obj.segmentType == "2"){
                //是否为空
                var segmentValue = obj.segmentValue;
                var valueStart = '';
                if(segmentValue.indexOf(',')>-1){
                    valueArray = segmentValue.split(',');
                    segmentValue = valueArray[0];
                    valueStart = valueArray[1];
                }
                if(!isNotEmpty(data[idx])){
                    validateResult = false;
                    layer.alert("请输入流水码！", {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']}, function(index){
                            _this.divId.find("#editAutoCode_"+(idx+1)).focus();
                            layer.close(index);
                        });
                    return false;
                }

                //是否数字
                if(!$.isNumeric(data[idx])){ 
                    validateResult = false;
                    layer.alert("流水码只能输入数字！", {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']}, function(index){
                            _this.divId.find("#editAutoCode_"+(idx+1)).focus();
                            layer.close(index);
                        });
                    return false;
                }
                //是否补位
                if(obj.autoIncreaseFlag == "Y") {
                    //长度是否相等
                    if (segmentValue != data[idx].length) {
                        validateResult = false;
                        layer.alert("流水码的长度是" + segmentValue + "个数字！", {icon: 7,title: "提示",closeBtn: 0,area: ['400px', '']}, function (index) {
                            _this.divId.find("#editAutoCode_" + (idx + 1)).focus();
                            layer.close(index);
                        });
                        return false;
                    }
                }else{
                    if (segmentValue < data[idx].length) {
                        validateResult = false;
                        layer.alert("流水码的最大长度是" + segmentValue + "个数字！", {icon: 7,title: "提示",closeBtn: 0,area: ['400px', '']}, function (index) {
                            _this.divId.find("#editAutoCode_" + (idx + 1)).focus();
                            layer.close(index);
                        });
                        return false;
                    }
                }
                // 是否符合起始值
                if(valueStart != ''){
                    if(parseInt(data[idx]) < parseInt(valueStart)){
                        validateResult = false;
                        layer.alert("流水码应不小于" + valueStart + "！", {icon: 7,title: "提示",closeBtn: 0,area: ['400px', '']}, function (index) {
                            _this.divId.find("#editAutoCode_" + (idx + 1)).focus();
                            layer.close(index);
                        });
                        return false;
                    }
                }
            }

            //日期码 
            if(obj.segmentType == "3"){
                //是否为空
                if(!isNotEmpty(data[idx])){
                    validateResult = false;
                    layer.alert("请输入日期码！", {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']}, function(index){
                            _this.divId.find("#editAutoCode_"+(idx+1)).focus();
                            layer.close(index);
                        });
                    return false;
                }

                if(obj.segmentValue == "yyyy"){
                    validateResult = _this.validateDate(dateReg_yyyy, data[idx], obj.segmentValue, idx);
                    return validateResult;

                }else if(obj.segmentValue == "yyyyMM"){
                    validateResult = _this.validateDate(dateReg_yyyyMM1, data[idx], obj.segmentValue, idx);
                    return validateResult;
  
                }else if(obj.segmentValue == "yyyy-MM"){
                    validateResult = _this.validateDate(dateReg_yyyyMM2, data[idx], obj.segmentValue, idx);
                    return validateResult;

                }else if(obj.segmentValue == "yyyy/MM"){
                    validateResult = _this.validateDate(dateReg_yyyyMM3, data[idx], obj.segmentValue, idx);
                    return validateResult;
 
                }else if(obj.segmentValue == "yyyyMMdd"){
                    validateResult = _this.validateDate(dateReg_yyyyMMdd1, data[idx], obj.segmentValue, idx);
                    return validateResult;
  
                }else if(obj.segmentValue == "yyyy-MM-dd"){
                    validateResult = _this.validateDate(dateReg_yyyyMMdd2, data[idx], obj.segmentValue, idx);
                    return validateResult;
 
                }else if(obj.segmentValue == "yyyy年MM月dd日"){
                    validateResult = _this.validateDate(dateReg_yyyyMMdd3, data[idx], obj.segmentValue, idx);
                    return validateResult;
 
                }else if(obj.segmentValue == "yyyyMMddHH"){
                    validateResult = _this.validateDate(dateReg_yyyyMMddHH1, data[idx], obj.segmentValue, idx);
                    return validateResult;

                }else if(obj.segmentValue == "yyyy-MM-dd HH"){
                    validateResult = _this.validateDate(dateReg_yyyyMMddHH2, data[idx], obj.segmentValue, idx);
                    return validateResult;

                }else if(obj.segmentValue == "yyyy-MM-dd HH:mm"){
                    validateResult = _this.validateDate(dateReg_yyyyMMddHH3, data[idx], obj.segmentValue, idx);
                    return validateResult;

                }else if(obj.segmentValue == "yyyy-MM-dd HH:mm:ss"){
                    validateResult = _this.validateDate(dateReg_yyyyMMddHH4, data[idx], obj.segmentValue, idx);
                    return validateResult;
                }
            }

            //输入码
            if(obj.segmentType == "4"){
                //是否为空
                if(!isNotEmpty(data[idx])){
                    validateResult = false;
                    layer.alert("请输入输入码！", {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']}, function(index){
                                _this.divId.find("#editAutoCode_"+(idx+1)).focus();
                                layer.close(index);
                        });
                    return false;
                }

                if(obj.segmentValue == "1"){//字符

                    //是否包含$
                    if(data[idx].indexOf("$") != -1){
                        validateResult = false;
                        _this.divId.find("#editAutoCode_"+(idx+1)).focus();
                        layer.alert("输入码不能包含$字符!",{icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']}, function(index){
                            _this.divId.find("#editAutoCode_"+(idx+1)).focus();
                            layer.close(index);
                        });
                        return false;
                    }
                }

                if(obj.segmentValue == "2"){//数值
                    
                    //是否数字
                    if(! (/^[0]$/.test(data[idx]) || /^[1-9]\d*$/.test(data[idx]))){
                        validateResult = false;
                         _this.divId.find("#editAutoCode_"+(idx+1)).focus();
                        layer.alert("输入码只能输入数值！",{icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']}, function(index){
                                _this.divId.find("#editAutoCode_"+(idx+1)).focus();
                                layer.close(index);
                            });
                        return false;
                    }
                }
            }
        }
    });

    return validateResult;
};

//校验日期
AutoCode.prototype.validateDate = function (dateReg, data, dataFormat ,idx) {
    var _this = this;
    if(!dateReg.test(data)){
        layer.alert("输入的日期格式有误，正确格式应为:" + dataFormat, {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']}, function(index){
                _this.divId.find("#editAutoCode_"+(idx+1)).focus();
                layer.close(index);
            });
        return false;
    }
    return true;

};

//设定值
AutoCode.prototype.setCodeValue = function (inputFlag) {
    var _this = this;

    if(inputFlag === "false"){
        var data = _this.getAutoCodeDataFromLocal();
        _this.autoCodeData =  "$$" + data.join("$$") + "$$";
        _this.divId.find("#autoCodeValue").val(_this.autoCodeData);
        _this.divId.find("#autoCode").val(data.join(""));
    }

    //编辑页面的时候，通过编码值查询得到带##的编码值
    if(_this.isEditPage){
        var autoCode = _this.getAutoCodeByValue();
        var autoCodeArray = autoCode.split("$$");
        autoCodeArray.shift();
        autoCodeArray.pop();

        //设定值到输入框
        _this.autoCodeData =  autoCode;
        _this.divId.find("#autoCodeValue").val(autoCode);
        _this.divId.find("#autoCode").val(autoCodeArray.join(""));

        //设定值到控件上
        $.each(autoCodeArray, function (idx, value) {
            var elem = _this.divId.find("#editAutoCode_"+(idx+1));
            if(elem.tagName == "SPAN"){
                elem.text(value);
            }else{
                elem.val(value);
            }
        });
    }

};

//设定CSS
AutoCode.prototype.setCss = function () {
    var _this = this;
    var autoCode =  _this.template.find('#autoCode');

    //设定div宽度
    var divWidth = _this.divId.find('#displayContentDiv').css("width");
    if(parseInt(divWidth) < parseInt(autoCode.css("width"))){
        _this.divId.find('#displayContentDiv').css("width", autoCode.css("width"));
    }

    //设定输入框的name属性
    if(isNotEmpty(_this.autoCodeInputName)){
        _this.divId.find('#autoCodeValue').attr("name", _this.autoCodeInputName);
    }
};

//添加到页面
AutoCode.prototype.appendToDiv = function () {
    var _this = this;
    _this.divId.empty();
    _this.divId.append(_this.template);
    _this.divId.find(".date-picker[name='inputCode']").datepicker();
};

//添加到页面
AutoCode.prototype.getAutoCodeData = function () {
    var _this = this;
    return _this.autoCodeData;
};


//取得编码值
AutoCode.prototype.getAutoCodeDataFromLocal = function(){
    var _this = this;
    var data = [];
    $.each(_this.template.find(".autocodeclass"), function (idx, elem) { 
        if(elem.tagName == "SPAN"){
            data.push($.trim($(elem).text()));
        }else{
            data.push($.trim($(elem).val()));
        }
    });
    return data;
};

//重新加载流水号
AutoCode.prototype.reloadSerialNumber = function(event){
    var _this = this;

    var target = $(event.target);
    var dataIndex = target.attr("id").split("_")[1] - 1;

    //取得页面上的数据更新编码规则的value和自动增长编码
    _this.segmentData[dataIndex].value = target.val();
    if(_this.segmentData[dataIndex].segmentType != "2" && _this.segmentData[dataIndex].autoIncreaseFlag == "Y"){
        _this.autoIncreaseCode[dataIndex] =  target.val();

        var data = {"autoCode":_this.autoCode,
                    "autoIncreaseCode":"$$"+$.map(_this.autoIncreaseCode, function(obj, idx){ return isNotEmpty(obj) ? obj : null }).join("$$")+"$$",
                    "serialNumLength":_this.serialNumLength,
                    "autoIncreaseFlag": _this.autoIncreaseFlag};

        $.ajax({
            type: "post",
            url:  "platform/sysautocode/sysAutoCodeManageController/searchSerialNum",
            data: data,
            dataType: "json",
            success: function (resp) {
                if(resp.flag == "success"){
                    if(resp.result){
                    	if(_this.divId.find('input[name="serialCode"]').length > 0){
                    		_this.divId.find('input[name="serialCode"]').val(resp.result);
                    	}else{
                    		_this.divId.find('span[name="serialCode"]').text(resp.result);
                    	}
                    }
                }else{
                    layer.alert("调用rest服务出错!", {icon : 7 ,title: "提示",closeBtn:0,area: ['400px', '']});
                }
            }
        });
    }   

};


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

