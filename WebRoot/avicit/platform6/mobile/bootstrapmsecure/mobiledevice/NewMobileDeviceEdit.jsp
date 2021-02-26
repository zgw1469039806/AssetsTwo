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
<!-- ControllerPath = "platform6/bootstrapmsecure/mobiledevice/NewmobileDeviceController/operation/Edit/id" -->
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
				value="<c:out  value='${mobileDeviceDTO.version}'/>" /> <input
				type="hidden" name="id"
				value="<c:out  value='${mobileDeviceDTO.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="imei">设备IMEI:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="imei" id="imei"
						value="<c:out  value='${mobileDeviceDTO.imei}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="imsi">设备IMSI:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="imsi" id="imsi"
						value="<c:out  value='${mobileDeviceDTO.imsi}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="screen">屏幕分辨率:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="screen" id="screen"
						value="<c:out  value='${mobileDeviceDTO.screen}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="deviceName">设备名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="deviceName" id="deviceName"
						value="<c:out  value='${mobileDeviceDTO.deviceName}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="platform">设备平台:</label></th>
					<td width="39%"><select
							class="form-control" name="platform" id="platform"
							title="" isNull="true" >
							<option value="ios" <c:if test="${mobileDeviceDTO.platform == 'ios' }">selected</c:if>>ios</option>
							<option value="android" <c:if test="${mobileDeviceDTO.platform == 'android' }">selected</c:if>>android</option>
						</select></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="platformVersion">平台版本:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="platformVersion" id="platformVersion"
						value="<c:out  value='${mobileDeviceDTO.platformVersion}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="deviceStatus">设备状态:</label></th>
					<td width="39%"><select
							class="form-control input-sm" name="deviceStatus"
							id="deviceStatus" title="" isNull="true">
							<option value="1" <c:if test="${mobileDeviceDTO.deviceStatus == '1' }">selected</c:if>>正常</option>
							<option value="0" <c:if test="${mobileDeviceDTO.deviceStatus == '0' }">selected</c:if>>禁止</option>
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
						title="保存" id="mobileDevice_saveForm">保存</a> <a
						href="javascript:void(0)"
						class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
						id="mobileDevice_closeForm">返回</a></td>
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
			parent.mobileDevice.closeDialog("edit");
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            return false;
	        }
	        //限制保存按钮多次点击
   			$('#mobileDevice_saveForm').addClass('disabled');
			parent.mobileDevice.save($('#form'),"eidt");
		}
	
		document.ready = function () {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.mobileDevice.formValidate($('#form'));
			//保存按钮绑定事件
			$('#mobileDevice_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#mobileDevice_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																																																																																																																							
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		};
	</script>
</body>
</html>