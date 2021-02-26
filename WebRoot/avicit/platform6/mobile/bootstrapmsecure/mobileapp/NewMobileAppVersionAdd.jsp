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
<!-- ControllerPath = "platform6/bootstrapmsecure/mobileapp/NewmobileAppController/operation/sub/Add/null" -->
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
			<input type="hidden" name="id" /> <input type="hidden" name="appId"
				id="appId" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="platformType">版本类型:</label></th>
					<td width="39%"><select
							class="form-control input-sm" name="platformType"
							id="platformType" title="" isNull="true" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="ios">ios</option>
							<option value="android">android</option>
					</select></td>
					<th width="10%"><label for="appVersion">应用版本号:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="appVersion" id="appVersion" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="appStatus">版本状态:</label></th>
					<td width="39%"><select
							class="form-control input-sm" name="appStatus" id="appStatus"
							title="" isNull="false" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="2">最新版</option>
							<option value="1">旧版</option>
							<option value="0">禁用</option>
					</select></td>
					<th width="10%"><label for="downloadUrl">应用下载地址:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="downloadUrl" id="downloadUrl" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="descript">应用描述:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="descript" id="descript" /></td>
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
						title="保存" id="mobileAppVersion_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="mobileAppVersion_closeForm">返回</a></td>
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
			parent.mobileAppVersion.closeDialog("insert");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	          $("#appId").val(parent.mobileAppVersion.pid);
	          //限制保存按钮多次点击
   			  $('#mobileAppVersion_saveForm').addClass('disabled');
			  parent.mobileAppVersion.save($('#form'),"insert");
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
			
			parent.mobileAppVersion.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mobileAppVersion_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#mobileAppVersion_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																																				
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>