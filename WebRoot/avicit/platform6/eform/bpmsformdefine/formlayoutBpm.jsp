<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程表单</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/BpmJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script src="avicit/platform6/eform/formdefine/js/eformValidate.js"></script>
<script src="avicit/platform6/eform/formdefine/js/eformCustomDialog.js"></script>

<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';
var entryId = '${entryId}';
var executionId = '${executionId}';
var taskId = '${taskId}';
var formId = '${formId}';
var oTimer = 0;
$(function(){
	document.body.style.visibility = 'visible';
	//控制表单权限用这个
	initBpmInfoAndFormAccess(entryId,executionId,taskId,formId);
	oTimer = setTimeout(initCommonSelector,1500);
	var lrcc = '${result}';
	lrcc=lrcc.replace(/\n/g, "\\n").replace(/\r/g, "\\r").replace(/\t/g, "\\t");
	var results=$.parseJSON(lrcc);
	$('#fmedit').form('load', results);
});


/**
 * 保存表单方法
 * @param processInstanceId
 * @param executionId
 */
window.saveFormData = function(processInstanceId,executionId){
	var f=$('#fmedit');
	url = 'platform/eform/cbbCRUDClient/edit?isBpm=Y&version='+encodeURI("${version}")+'&id=' + '${id}'+'&tableId='+'${table.id}';
	f.form('submit', {
		url : url,
		onSubmit : function() {
			return $(this).form('validate');
		},
		success : function(result) {
			var result = eval('(' + result + ')');
			if (result.success) {
				$.messager.show({
					title : '提示',
					msg : "保存成功。"
				});
			} else {
				$.messager.show({
					title : '错误',
					msg : result.msg
				});
			}
		}
	});
};



function doBack(){
	if(parent!=null&&parent.$('#tabs')!=null){
		var currTab = parent.$('#tabs').tabs('getSelected');
		var currTitle = currTab.panel('options').title; 
		parent.$('#tabs').tabs('close',currTitle);
	}
}

function initCommonSelector(){
	<c:forEach items="${selectColumns}"   var="item"  >
		var ${item.colName}CommonSelector = new CommonSelector("${item.colRuleName}","${item.colRuleName}SelectCommonDialog","${item.colName}","${item.colName}Name",null,null,null,parseInt("${item.colCommonselectCount}"));
		${item.colName}CommonSelector.init();  
	</c:forEach>

	<c:forEach items="${customColumns}"   var="item"  >
		var ${item.colName}Custom = new CustomDialog("${item.colName}","${item.customPath}");
		${item.colName}Custom.init();
	</c:forEach>
}

function closeDlg(id){
	$('#'+id).dialog('close');
}

function printdiv() {
    var newstr = $("#fmedit").prop('outerHTML') + $("#idea").prop('outerHTML');
    window._printHtml = newstr;
    var lrcc = '${result}';
	lrcc=lrcc.replace(/\n/g, "\\n").replace(/\r/g, "\\r").replace(/\t/g, "\\t");
	window._printHtmlData = $.parseJSON(lrcc);
	var  dlg = new CommonDialog("printDlg","600","400","avicit/platform6/eform/formdefine/printPage.jsp","打印",false,false,false,null,true);
	dlg.show();
}

</script>
</head>
<body class="easyui-layout" fit="true" style="visibility:hidden;">
<div data-options="region:'center',split:true,border:false">
	<!-- 流程按钮区域开始 -->
		<div class=datagrid-toolbar>
			<div id=bpmToolBar></div>
			<!-- 自定义按钮放到这里 -->
			<a href="javascript:void(0)" iconCls="icon-print"  plain="true"  class="easyui-linkbutton"  onclick="printdiv();" href="javascript:void(0);" >打印</a>
			<a href="javascript:void(0)" iconCls="icon-undo"  plain="true"  class="easyui-linkbutton"  onclick="doBack();" href="javascript:void(0);" >返回</a>
		</div>
		<!-- 流程按钮区域结束 -->
	<!-- EDIT表单 start-->
		<form id="fmedit" method="post" novalidate>
		<input  id="comId"  value="${comId}" name="comId"   type="hidden" />
		<input  id="tableId"  value="${table.id}"   type="hidden"  />
			${layout}
		</form>
		
		
		<c:if test="${table.tableIsUpload== 'Y'  and  table.tableIsBpm== 'N'}">
		<div>
			<jsp:include page="/avicit/platform6/modules/system/swfupload/swfEditInclude.jsp">
				<jsp:param name="file_size_limit" value="5000MB" />
				<jsp:param name="file_types" value="*.*" />
				<jsp:param name="file_upload_limit" value="10" />
				<jsp:param name="save_type" value="true" /> 
				<jsp:param name="form_id" value="${id}" />
				<jsp:param name="form_code" value="${table.tableName}" />
				<jsp:param name="allowAdd" value="true" />
				<jsp:param name="allowDel" value="true" />
				<jsp:param name="cleanOnExit" value="true" />
				<jsp:param name="hiddenUploadBtn" value="true" />
				<jsp:param name="secret_level" value="PLATFORM_FILE_SECRET_LEVEL" />
			</jsp:include>
			</div>
		</c:if>
		
		
		
		<c:if test="${table.tableIsUpload== 'Y' and  table.tableIsBpm== 'Y'}">
			<jsp:include page="/avicit/platform6/modules/system/swfupload/swfBpmEditInclude.jsp">
					<jsp:param name="file_size_limit" value="5000MB" />
					<jsp:param name="file_types" value="*.*" />
					<jsp:param name="file_upload_limit" value="10" />
					<jsp:param name="save_type" value="true" /> 
					<jsp:param name="form_id" value="${formId}" />
					<jsp:param name="form_code" value="${table.tableName}" />
					<jsp:param name="form_field" value="" />
					<jsp:param name="allowAdd" value="process" />
					<jsp:param name="allowDel" value="false" />
					<jsp:param name="cleanOnExit" value="true" />
					<jsp:param name="secret_level" value="PLATFORM_FILE_SECRET_LEVEL" />
					<jsp:param name="entryId" value="${entryId}" />
					<jsp:param name="executionId" value="${executionId}" />
				</jsp:include>
		</c:if>
		
		<div id="idea"></div>
		
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
			</table>
		</div>
	<!-- EDIT表单 end-->
	</div>
	
	<!-- button js event -->
	<script type="text/javascript">
	
	function choosePhoto(colId,id,colName){
	}

	function closeDialog(id){
		$("#"+id).dialog('close');
	}
		
	</script>
</body>
</html>