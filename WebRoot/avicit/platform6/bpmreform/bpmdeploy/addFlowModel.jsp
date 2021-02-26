<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.api.sysshirolog.utils.SecurityUtil"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "aa/bpmcatalog/bpmCatalogController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='addForm'>
			<input type="hidden" name="selectedNodeId" id="selectedNodeId" value="${selectedNodeId }"/>
			<input type="hidden" name="location" id="location" value="${location }"/>
			<table class="form_commonTable">
				<tr>
					<th width="20%"><label for="flowName">流程名称:</label></th>
					<td width="80%"><input class="form-control input-sm"
						type="text" name="flowName" id="flowName" /></td>					
				</tr>
				<tr>
					<th><label for="flowCatalog">流程库:</label></th>
					<td>${location }</td>		
				</tr>	
				<tr>
					<th><label for="flowType">流程类型:</label></th>
					<td><input 
						type="radio" name="isUflow" value="1" checked id="isUflow_1"/>&nbsp;<label for="isUflow_1" style="font-weight:normal;">固定流程</label>
						&nbsp;&nbsp;
						<input 
						type="radio" name="isUflow" value="2" id="isUflow_2"/>&nbsp;<label for="isUflow_2" style="font-weight:normal;">自由流程</label>
						</td>				
				</tr>
				<%if(!SecurityUtil.fixieBrowser$IE_67()){ %>			
				<tr>
					<th><label for="iconType">图标类型:</label></th>
					<td><input 
						type="radio" name="iconType" value="1" id="iconType_1"/>&nbsp;<label for="iconType_1" style="font-weight:normal;">BPMN2.0规范图标</label>
						&nbsp;&nbsp;
						<input 
						type="radio" name="iconType" value="2" checked id="iconType_2"/>&nbsp;<label for="iconType_2" style="font-weight:normal;">简化图标</label>
						</td>				
				</tr>
				<%}else{ %>
				<tr>
					<th><label for="iconType">图标类型:</label></th>
					<td>
						<input 
						type="radio" name="iconType" value="2" checked id="iconType_2"/>&nbsp;<label for="iconType_2" style="font-weight:normal;">简化图标</label>
						</td>				
				</tr>
				<%} %>	
				<tr>
					<th><label for="activities">初始化节点:</label></th>
					<td><input class="form-control input-sm"
						type="text" name="activities" id="activities" /></td>								
				</tr>		
				<tr>
					<th>&nbsp;</th>
					<td>初始化节点以空格分割</td>								
				</tr>		
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="新建" id="bpmCatalog_saveForm">新建</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消"
						id="bpmCatalog_closeForm">取消</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript">
		function closeForm() {
			parent.unDeployedFlow.closeDialog("add");
		}
		function saveForm() {
		    var isValidate = $('#addForm').validate();
		    if (!isValidate.checkForm()) {
		        isValidate.showErrors();
		        return false;
		    }
		    var tit = $('#flowName').val();
		    if(tit.indexOf("#") != -1 || tit.indexOf("&") != -1 || tit.indexOf("+") != -1 ){
		    	layer.msg('流程名称不能含有 #或&或+')
		    	return null;
		    }
		    var node = $('#activities').val();
		    if(node.indexOf("#") != -1 || node.indexOf("&") != -1 || node.indexOf("+") != -1 ){
		    	layer.msg('初始化节点不能含有 #或&或+')
		    	return null;
		    }
		    
			var location = encodeURI(encodeURI($("#location").val()));
			var name = encodeURI(encodeURI($("#flowName").val()));
			var selectedNodeId = encodeURI(encodeURI($("#selectedNodeId").val()));
			var activities = encodeURI(encodeURI($("#activities").val()));
			var isUflow = $('input:radio[name="isUflow"]:checked').val();
			isUflow = encodeURI(encodeURI(isUflow));
			var iconType=$('input:radio[name="iconType"]:checked').val();
			iconType = encodeURI(encodeURI(iconType));
			var url = "bpm/designer/index?type=3&catalog="+selectedNodeId+"&location="
					+location+"&name="+name+"&swimlane="+activities+"&isUflow="+isUflow
					+"&iconType="+iconType;
			parent.flowUtils.open(url, name + "_designer");
		    closeForm();
		}

		$(document).ready(function() {			
			parent.unDeployedFlow.formValidate($('#addForm'));
			//保存按钮绑定事件
			$('#bpmCatalog_saveForm').bind('click', function() {
				saveForm();
			});
			//返回按钮绑定事件
			$('#bpmCatalog_closeForm').bind('click', function() {
				closeForm();
			});
			$('input:radio[name="isUflow"]').on("click", function(){
				var value = $('input:radio[name="isUflow"]:checked').val();
				if(value == 1){
					var trs = $(this).parent().parent().siblings();
					trs.eq(-1).show();
					trs.eq(-2).show();
				}else{
					var trs = $(this).parent().parent().siblings();
					trs.eq(-1).hide();
					trs.eq(-2).hide();
				}
			});
		});
	</script>
</body>
</html>