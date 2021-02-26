var requestData = "";
var arrayRequest = [];
var returnData = "";
var arrayReturn = [];
var ApiDocId = "";
var AllData = "";
var colNamesData = [];
var len="";

$(document).ready(function() {
	initTestButton();
	var apiId=$("#apiId span").text();
	var businessDomain=$("#businessDomain span").text();
	var deptName=$("#deptName span").text();
	var serviceCode=$("#serviceCode").text();
	var appCode=$("#appCode").text();
	var appName=$("#appName span").text();
	var appVersion=$("#serviceVersion").text();
	var serviceCodeJudge=$("#serviceCodeValue").text();

	//判断业务域是否为空（为空则不显示）
	if(isEmpty(businessDomain)){ $("#businessDomain").css("display","none"); }
	//判断部门是否为空（为空则不显示）
	if(isEmpty(deptName)){ $("#deptName").css("display","none"); }
	//判断应用名称是否为空（为空则不显示）
	if(isEmpty(appName)){ $("#appName").css("display","none"); } 
	
	// 请求数据 初始化 
	var dataGridColModelr = [ {name : 'name',index : 'name',width : 30,formatter : formatNecessary
	}, {name : 'required',index : 'required',width : 30,formatter : formatValue
	}, {name : 'type',index : 'type',width : 30
	},{name : 'id1',index : 'type',hidden : true
	}, {name : 'paramType',index : 'paramType',width : 30
	}, {name : 'desc',index : 'desc',width : 30
	},{name : 'testinput',index : 'testinput',width : 30,hidden:true,editable:true,formatter : formatValueTest
	} ];
	

	//请求数据表格 初始化
	$("#requestDesGrid").jqGrid({
		datatype : "local",
		data : arrayRequest,
		height : "30%",
		altRows : true,
		colNames : [ "名称", "必填", "类型","主键", "参数类型", "说明","输入测试值" ],
		colModel : dataGridColModelr,
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiselect : false,
		multiboxonly : true,
		autowidth : true,
		responsive : true,
		cellEdit:true,
		rownumbers:true,
		rowNum: 10,
	    cellsubmit: 'clientArray'
	});

	// 返回信息 初始化
	var dataGridColModelc = [ 
		{name : 'name',index : 'name',width : 30
		}, {name : 'required',index : 'required',width : 30,hidden : true
		}, {name : 'type',index : 'type',width : 30
		}, {name : 'paramType',index : 'paramType',width : 30,hidden : true
		}, {name : 'desc',index : 'desc',width : 30
		} ];
	//返回信息表格初始化
	$("#callbacDesGrid").jqGrid({
		datatype : "local",
		data : arrayReturn,
		height : "30%",
		altRows : true,
		colNames : [ "名称", "必填", "类型", "参数类型", "说明" ],
		colModel : dataGridColModelc,
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiselect : false,
		multiboxonly : true,
		rownumbers:true,
		autowidth : true,
		responsive : true
	});
	
	//根据应用编码和服务编码获取 获取信息 生成左侧按钮
	$.ajax({
		url : 'apicenter/apiInfoManage/apiInfoManageController/operation/searchApiInfoManager',
		data : {
			appCode : appCode,
			serviceCode : serviceCode,
			appVersion : appVersion
		},
		type : 'POST',
		dataType : 'JSON',
		async:false, 
		success : function(r) {
			//生成左侧API按钮
			AllData = r.rows;
			for (var i = 0; i < r.rows.length; i++) {
				$(".leftMenu").append(
						'<a href="javascript:void(0);" class="list-group-item exactInfo"  id="'
						+ r.rows[i].id + '">'
						+ r.rows[i].apiName
						+ '</a>');
			};
			//点击左侧APIDoc按钮切换
			changeClickAPIDocMethod();
			//点击左侧按钮初始化 apiId
			$(".exactInfo").unbind('focus');
			if (serviceCodeJudge=="null") {
				$("#"+apiId).click();
			} else if(serviceCodeJudge=="serviceCode") {
				$(".leftMenu").find("a").first().click();
			}
		}
	});

	//示例代码展示
	$("#exampleShow").bind("click",function(){
		showExample = layer.open({
			type : 2,
			area : [ '90%', '90%' ],
			title : '示例代码',
			skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
			scrollbar: false,
			maxmin : false, // 开启最大化最小化按钮
			content : 'apicenter/apiInfoManage/apiInfoManageController/operation/toShowExample/' + ApiDocId
		});
	});
});


//判断 是否为整数型值
function isInteger(x) {
	if( $.isNumeric(x)&&x % 1 === 0){
		return "integer"
	} else{
		return "error"
	};
}
//判断值是否为浮点型
function isFloat(x){
	if(  $.isNumeric(x)&&x % 1 != 0){
		return "float"
	}else{
		return "error"
	};
}
//判断是否为布尔型
function isboolean(x){
	if(x=="true"||x=="false"){
		return "boolean"
	}else{
		return "error"
	}
}
//输入测试值校验
function formatValueTest(cellvalue, options, rowObject){
	$("#"+options.rowId).find("td[aria-describedby='requestDesGrid_testinput']").addClass(options.rowId+"testinput");
	if(cellvalue!=""){
		$("."+options.rowId).css("display","none");
	}
	//判断是否为特殊字符
	var regEn = /[`~!@#$%^&*()+<>?:"{},.\/;'[\]]/im,
    regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im;
	var rowData = $("#requestDesGrid").jqGrid('getRowData', options.rowId);
	var x;
	var getType=rowData.type;
	//判断输入值类型
	if(cellvalue){
		switch (getType)
		{
		case "string":
		  x=typeof(cellvalue);
		  break;
		case "boolean":
		  x=isboolean(cellvalue);
		  break;
		case "integer":
		  x=isInteger(cellvalue);
		  break;
		case "float":
			  x=isFloat(JSON.parse(cellvalue));
			  break;
		}
		//禁止输入特殊字符提示
		if(x == rowData.type&&!(regEn.test(cellvalue) || regCn.test(cellvalue))){
			return cellvalue;
			}else if(regEn.test(cellvalue) || regCn.test(cellvalue)){
				layer.tips('禁止输入特殊字符', '.'+options.rowId+"testinput", {
				  tips: [4, 'red']
				});
			return ;
		}else{
			//错误类型数据提示
			layer.tips('请输入'+getType+'类型数据', '.'+options.rowId+"testinput", {
				  tips: [4, 'red']
				});
			return ;
		}
	}else{
		return "";
	}
}

//必填红*标识
function formatNecessary(cellvalue, options, rowObject){
	if(rowObject["required"]==true){
		var requiredName="<span style='color:red'>*</span>"+cellvalue;
		return requiredName;
	}else{
		return cellvalue;
	}
}
//数据格式化方法
function htmlDecodeByRegExp(str) {
	var s = "";
	if(str){
		if (str.length == 0)
			return "";
		s = str.replace(/&amp;/g, "&");
		s = s.replace(/&lt;/g, "<");
		s = s.replace(/&gt;/g, ">");
		s = s.replace(/&nbsp;/g, " ");
		s = s.replace(/&#39;/g, "\'");
		s = s.replace(/&quot;/g, "\"");
	}
	return s;
}
//为空校验
function isEmpty(obj){
    if(typeof obj == "undefined" || obj == "null" || obj == ""){
        return true;
    }else{
        return false;
    }
}
//将true、false显示为必填和不必填
function formatValue(cellvalue, options, rowObject) {
	return cellvalue ? "必填" : "不必填";
}


//点击API测试
function APITestMethod(){
	$("#APITest").unbind('click').click(function(){
		var len=$("#requestDesGrid").getGridParam("width");
		$("#requestDesGrid").setGridParam().showCol("testinput"); 
		$("#requestDesGrid").setGridWidth(len);
		$(".returnMirror").css("width",len);
		for(var i=0;i<arrayRequest.length;i++){
			$("#"+(i+1)).find("td[aria-describedby='requestDesGrid_testinput']").addClass((i+1)+"testinput");
		}
		$("#tryIt").css("display","block");
	});
}

//点击提交测试按钮   
function tryItOutMethod(){
	$("#tryIt").unbind('click').click(function(){
		$(".returnMirror .CodeMirror").remove();
		$("#requestDesGrid").jqGrid('endEditCell');
		var ids=[];
		for(var i=0;i<arrayRequest.length;i++){
			if(arrayRequest[i].required){
				ids.push(i+1);
			}
		}
		var result1=true;
		var result2=true;
		for(var i=0;i<ids.length;i++){
			var rowData=$("#requestDesGrid").jqGrid('getRowData', ids[i]);
			if($.trim(rowData.testinput)==""||typeof($.trim(rowData.testinput)) == "undefined"){
				var topDistance=$("#"+ids[i]).offset().top+10+"px";
				var leftDistance=$("."+ids[i]+"testinput").offset().left+$("."+ids[i]+"testinput").width()+12+"px";
				$('body').append('<div class="tips '+ids[i]+'" style="position:absolute;left:'+leftDistance+';color:red;top:'+topDistance+'" ><i class="glyphicon glyphicon-exclamation-sign"></i><span style="color:red">必填</span></div>');
				$("#returnExample").val("");
				$("#returnExample").css("display","block");
				result1=false;
			}else{
				result2=true
			}
		}
		if(result2&result1){
		}else{return false;}
		
		var data = {};
	     var recs=$("#requestDesGrid").jqGrid("getRowData"); 
	     $.each(recs,function(i,row){
	    	// var name = row.name.replace('<span style=\"color:red\">*</span>','');
	    	 data[row.id1] = $.trim(row.testinput);
	     });
		$.ajax({
			type : 'POST',
			url : "apicenter/apiinvoking/ApiInfoInvokingController/operation/invokingApi/"+ApiDocId,
			data :data,
			dataType : 'json',
			success : function(r) {			
				$("#returnExample").val(htmlDecodeByRegExp(r.resultStr));
				if(testBrowerVersion()){
					//codemirror高亮
					var callbackeditor = CodeMirror.fromTextArea(document.getElementById("returnExample"), {
				        mode: "text/x-java", //实现Java代码高亮
				        lineNumbers:false,	//显示行号
				        matchBrackets: true	,//括号匹配
				        readOnly: true
				    });
				}
				
				//callbackeditor.setValue(htmlDecodeByRegExp(r.resultStr));
			}
		});
	
	});
}

function testBrowerVersion(){
	if(navigator.userAgent.indexOf("MSIE")>0)  
	{   
	    if(navigator.userAgent.indexOf("MSIE 6.0")>0)  
	    {   
	   return false;  
	    }   
	    if(navigator.userAgent.indexOf("MSIE 7.0")>0)  
	    {  
	    	return false;  
	    }   
	    if(navigator.userAgent.indexOf("MSIE 8.0")>0)  
	    {  
	    	return false;
	    }   
	    if(navigator.userAgent.indexOf("MSIE 9.0")>0)  
	    {  
	    	return true;
	    }   
	}else  
	{  
		return true;  
	}   
}

//获取点击APIDoc按钮后右侧页面数据
function getAPIDocInfoMethod(){
	$.ajax({
		url : 'apicenter/apiInfoManage/apiInfoManageController/operation/get/'+ ApiDocId,
		data : {},
		type : 'POST',
		dataType : 'JSON',
		success : function(rs) {
			//服务信息描述
			$("#reqUrl").html(rs.apiServiceUri);
			$("#apiDesc").html(rs.apiDesc);
			$(".head p").html(rs.serviceDesc);  
			$("#reqStyle").html(rs.apiRequestMethod);
//			if(rs.apiRequestMethod=="post"){
//				$("#APITest").css("display","none");
//				$(".fanhuiCode th").remove();
//				$(".fanhui th").remove();
//			}else{
				if($(".fanhui th").length<1){
					$("#APITest").css("display","block");
					$(".fanhui").append('<th colspan="2">返回示例：</th>');
					$(".fanhuiCode").append('<th colspan="2"><div class="returnMirror"><textarea id="returnExample"  style="width:'+
							len+'px;height: 90px;border-color:lightgray"></textarea></div></td>');
				}
//			}
			
			//获取服务数据（请求参数和返回参数）
			requestData = htmlDecodeByRegExp(rs.apiRequestParam);
			arrayRequest = $.parseJSON(requestData);
			var paramsArr = [];
			$.each(arrayRequest,function(i,e){
				e.id1 = e.name;
				paramsArr.push(e);
			});
			returnData = htmlDecodeByRegExp(rs.apiReturnParam);
			arrayReturn = $.parseJSON(returnData);
			
			 len=$("#requestDesGrid").getGridParam("width");
			 $("#requestDesGrid").setGridParam().hideCol("testinput");
			 $("#requestDesGrid").setGridWidth(len);
			
			//请求参数数据 表格
			$("#requestDesGrid").jqGrid('clearGridData');
			$("#requestDesGrid").jqGrid('setGridParam',{
				datatype : 'local',
				data : paramsArr,
				rowNum:arrayRequest.length
				}).trigger("reloadGrid");
			
			//返回参数数据 表格
			$("#callbacDesGrid").jqGrid('clearGridData');
			$("#callbacDesGrid").setGridWidth(len);
			$("#callbacDesGrid").jqGrid('setGridParam',{
				datatype : 'local',
				data : arrayReturn,
				rowNum:arrayReturn.length
				}).trigger("reloadGrid");
			
			//requestDesGrid 表展示
			/*var trs = '';
			for (var i = 0; i < arrayRequest.length; i++) {
				trs = trs
					+ '<tr><th width="10%"><label>'
					+ arrayRequest[i].name
					+ '</label></th><td width="39%"><input class="form-control input-sm" aria-describedby="'
					+arrayRequest[i].type
					+'" type="text"  name="' 
					+ arrayRequest[i].name
					+ '" id="" /></td><tr>';
			}
			$("#testTable").html(trs);*/
			//点击API测试按钮
			APITestMethod();
			//点击提交测试按钮
			tryItOutMethod();
		}
	});
}
//点击切换左侧API按钮
function changeClickAPIDocMethod(){
	$(".exactInfo").unbind('click').click(function(){
		ApiDocId = $(this)[0].id;
		$("#APIInfo").css("display","block");
		if($('#returnExample').css('display') === 'none' ){
			$("#returnExample").css("display","block");
		}
		$("#returnExample").val("");
		$(".returnMirror .CodeMirror").remove();
		$("#tryIt").css("display","none");
		$(".leftMenu").find("a").removeClass('chosen');
		$(".exactInfo").unbind('focus');
		$("#"+ApiDocId).addClass('chosen');

		getAPIDocInfoMethod();
		
	});
}

function initTestButton(){
	$.ajax({
		url : 'apicenter/apiInfoManage/apiInfoManageController/operation/getApiCenterInvoking',
		data : {},
		type : 'GET',
		dataType : 'JSON',
		async:false, 
		success : function(r) {
			if(r.result == '1'){
				$("#APITest").show();
			} else {
				$("#APITest").remove();
			}
		}
	});
}