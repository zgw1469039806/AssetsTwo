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
			<input type="hidden" name="id"
				value="<c:out  value='${mobileAppVersionDTO.id}'/>" /> <input
				type="hidden" name="version"
				value="<c:out  value='${mobileAppVersionDTO.version}'/>" /> <input
				type="hidden" name="appId"
				value="<c:out  value='${mobileAppVersionDTO.appId}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="platformType">版本类型:</label></th>
					<td width="39%"><select
							class="form-control input-sm" name="platformType"
							id="platformType" title="" isNull="true"data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="ios" <c:if test="${mobileAppVersionDTO.platformType == 'ios' }">selected</c:if>>ios</option>
							<option value="android" <c:if test="${mobileAppVersionDTO.platformType == 'android' }">selected</c:if>>android</option>
					</select></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="appVersion">应用版本号:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="appVersion" id="appVersion"
						value="<c:out  value='${mobileAppVersionDTO.appVersion}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="appStatus">版本状态:</label></th>
					<td width="39%"><select
							class="form-control input-sm" name="appStatus" id="appStatus"
							title="" isNull="true" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="2" <c:if test="${mobileAppVersionDTO.appStatus == '2' }">selected</c:if>>最新版</option>
							<option value="1" <c:if test="${mobileAppVersionDTO.appStatus == '1' }">selected</c:if>>旧版</option>
							<option value="0" <c:if test="${mobileAppVersionDTO.appStatus == '0' }">selected</c:if>>禁用</option>
					</select></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="downloadUrl">应用下载地址:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="downloadUrl" id="downloadUrl"
						value="<c:out  value='${mobileAppVersionDTO.downloadUrl}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="descript">应用描述:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="descript" id="descript"
						value="<c:out  value='${mobileAppVersionDTO.descript}'/>" /></td>
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
			parent.mobileAppVersion.closeDialog("edit");
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
			  parent.mobileAppVersion.save($('#form'),"eidt");
		}
	
		document.ready = function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
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
		};
	</script>
</body>
</html>