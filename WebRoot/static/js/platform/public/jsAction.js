/**
 * Ajax操作封装&前台操作
 * @date 2016-03-21
 * @author 许波<xb39082119@163.com>
*/

/**
 * Ajax方式打开页面
 * @param {string} type 打开页面的类型，规定取值：DIV表示在普通页面打开，MODAL表示在bootstrap modal中打开
 * @param {string} divId 打开页面的div id
 * @param {string} pageUrl 打开页面的url
 * @param {string} parameters 需要传参的序列化参数
 * @returns void
*/
function ajaxOpenPage(type, divId, pageUrl, parameters) {
	$.ajaxSetup ({
		cache: false //关闭Ajax缓存
	});
	
    if (type == "DIV") {   	
		if (parameters == "") {
			$("#" + divId).load(pageUrl);
		}
		else {
			$.post(pageUrl, parameters,
				function(backData, status){
					$("#" + divId).html(backData);
				}
			);
		}
	}
	if (type == "MODAL") {
		//bootstrap默认会根据modal div的顺序来分层展示，div越靠后，modal越置前。因此设置：每打开一个modal前，将modal div内容附加到父div最后
		if (parameters == "") {
			$("#" + divId).find(".modal-content").load(pageUrl);
			$("#" + divId).appendTo($("#mainModal"));
			$("#" + divId).modal("show");
		}
		else {
			$.post(pageUrl, parameters,
				function(backData, status){
					$("#" + divId).find(".modal-content").html(backData);
					$("#" + divId).appendTo($("#mainModal"));
					$("#" + divId).modal("show");
				}
			);			
		}
	}
}

/**
 * Ajax方式执行操作，后台封装json格式数据返回前台解析处理
 * @param {string} actionUrl 执行操作的url
 * @param {string} parameters 需要传参的序列化参数
 * @returns void
*/
function ajaxToDo(actionUrl, parameters) {
	if (parameters == "") {
		$.get(actionUrl, 
			function(backData, status){
				//回调函数
				parsingBackJaon(backData);
			}
		);
	}
	else {
		$.post(actionUrl, parameters, 
			function(backData, status){
				//回调函数
				parsingBackJaon(backData);
			}
		);
	}
}

/**
 * 解析后台返回的自定义json格式数据
 * @param {string} backData 后台返回的json数据
 * @returns void
*/
function parsingBackJaon(backData){
	//var jsonObj = $.parseJSON(backData);//将返回的json字符串转换为JavaScript的json对象
	var jsonObj = backData;//【备注：后台controller使用ModelAndView给前台返回文本，已经是json格式，而不是字符串，因而不需要解析】
    
    var showMessage = "";
    if(jsonObj.statusCode == "200"){
    	showMessage = "<span class='label label-lg label-success label-white'>" +
		  			  "<i class='ace-icon fa fa-check'></i>成功" +
		  			  "</span>&nbsp;&nbsp;" +
		  			  jsonObj.message;
	}
    if(jsonObj.statusCode == "300"){
    	showMessage = "<span class='label label-lg label-warning label-white'>" +
  		  			  "<i class='ace-icon fa fa-exclamation-triangle'></i>警告" +
  		  			  "</span>&nbsp;&nbsp;" +
		  			  jsonObj.message;
	}
    
    //1.关闭modal
    if(jsonObj.closeModalDiv != ""){
    	$("#" + jsonObj.closeModalDiv).modal("hide");
    }
    
    //2.弹出提示框
    bootbox.dialog({
		title : "提示",
		message : showMessage,
		buttons : {
			main : {
				label : "确定",
				className : "btn-sm btn-primary"
			}
		}
	});
    
  	//3.根据需要刷新页面
    if (jsonObj.refreshType == "DIV") {
		ajaxOpenPage("DIV", jsonObj.refreshDiv, jsonObj.refreshUrl, "");
	}
	if (jsonObj.refreshType == "MODAL") {
		ajaxOpenPage("MODAL", jsonObj.refreshDiv, jsonObj.refreshUrl, "");
	}
}

/**
 * 封装"确认删除"弹出框与操作
 * @param {string} delUrl 删除操作的url
 * @returns void
*/
function confirmDelete(delUrl) {
	bootbox.setLocale("zh_CN");//使用中文
	bootbox.confirm("确认要删除吗？", function(result) {
		if (result == true) {
			ajaxToDo(delUrl, "");
		}
	});
}

/**
 * 封装"确认退出系统"弹出框与操作
 * @param {string} logoutUrl 登出操作的url
 * @returns void
*/
function confirmLogout(logoutUrl) {
	bootbox.setLocale("zh_CN");//使用中文
	bootbox.confirm("确认要退出系统吗？", function(result) {
		if (result == true) {
			window.open(logoutUrl, "_self");
		}
	});
}

/**
 * 封装"权限不足"弹出框与操作【仅使用jquery datatables获取数据列表时，根据后台返回值判断权限然后调用；其他权限控制均为后台返回json，前台jquery回调函数解析】
 * @returns void
*/
function permissionDenied(){
    bootbox.dialog({
		title : "提示",
		message : "<span class='label label-lg label-warning label-white'>" +
		  		  "<i class='ace-icon fa fa-exclamation-triangle'></i>警告" +
		  		  "</span>&nbsp;&nbsp;" +
		  		  "权限不足",
		buttons : {
			main : {
				label : "确定",
				className : "btn-sm btn-primary"
			}
		}
	});
}