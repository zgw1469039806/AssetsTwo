<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/bootstrapmsecure/mobileapp/NewmobileAppController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version"
				value="<c:out  value='${mobileAppDTO.version}'/>" /> <input
				type="hidden" name="id" value="<c:out  value='${mobileAppDTO.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="appName">应用名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="appName" id="appName"
						value="<c:out  value='${mobileAppDTO.appName}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="appStatus">应用状态:</label></th>
					<td width="39%"><select
							class="form-control input-sm" name="appStatus" id="appStatus"
							title="" isNull="true" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="1" <c:if test="${mobileAppDTO.appStatus == '1' }">selected</c:if>>正常</option>
							<option value="0" <c:if test="${mobileAppDTO.appStatus == '0' }">selected</c:if>>禁用</option>
					</select></td>
				</tr>
				<tr>		
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="appBindChose">应用是否需要绑定:</label></th>
					<td width="39%"><select
							class="form-control input-sm" name="appBindChose"
							id="appBindChose" title="" isNull="true"data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="1" <c:if test="${mobileAppDTO.appBindChose == '1' }">selected</c:if>>需要</option>
							<option value="0" <c:if test="${mobileAppDTO.appBindChose == '0' }">selected</c:if>>不需要</option>
					</select></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="descript">应用描述:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="descript" id="descript"
						value="<c:out  value='${mobileAppDTO.descript}'/>" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm"
				style="border: 0; cellspacing: 1; width: 100%">
				<tr>
					<td width="50%" style="padding-right: 4%;" align="right"><a
						href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="保存" id="mobileApp_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="mobileApp_closeForm">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.mobileApp.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	        //限制保存按钮多次点击
   			$('#mobileApp_saveForm').addClass('disabled');
			parent.mobileApp.save($('#form'),"eidt");
		}
	
		document.ready = function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.mobileApp.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mobileApp_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#mobileApp_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																														
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		};
	</script>
</body>
</html>