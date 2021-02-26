<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/bootstrapmsecure/mobiledevice/NewmobileDeviceController/operation/sub/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" /> <input type="hidden"
				name="deviceId" id="deviceId" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="userId">用户ID:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="userId" id="userId" /></td>
					<th width="10%"><label for="appId">应用名称:</label></th>
					<td width="39%"><select class="form-control input-sm" name="appId" id="appId" editable="false" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<c:forEach var="item" items="${apps }">
								<option value="${item.id }">${item.appName }</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<th width="10%"><label for="bindStatus">状态:</label></th>
					<td width="39%"><select
							class="form-control" name="bindStatus"
							id="bindStatus" title="" isNull="false">
							<option value="1">正常</option>
							<option value="0">禁止</option>
					</select></td>
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
						title="保存" id="mobileUseDeviceBind_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="mobileUseDeviceBind_closeForm">返回</a></td>
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
			parent.mobileUseDeviceBind.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	          $("#deviceId").val(parent.mobileUseDeviceBind.pid);
	          //限制保存按钮多次点击
   			  $('#mobileUseDeviceBind_saveForm').addClass('disabled');
			  parent.mobileUseDeviceBind.save($('#form'),"insert");
		}
	
		$(document).ready(function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
				beforeShow: function(selectedDate) {
					if($('#'+selectedDate.id).val()==""){
						$(this).datetimepicker("setDate", new Date());
						$('#'+selectedDate.id).val('');
					}
				}
			});
			
			parent.mobileUseDeviceBind.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mobileUseDeviceBind_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#mobileUseDeviceBind_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																														
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>