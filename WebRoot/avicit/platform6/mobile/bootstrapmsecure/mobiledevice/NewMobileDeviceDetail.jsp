<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/bootstrapmsecure/mobiledevice/NewmobileDeviceController/operation/Edit/id" -->
<title>详细</title>
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
						type="text" name="imei" id="imei" readonly="readonly"
						value="<c:out  value='${mobileDeviceDTO.imei}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="imsi">设备IMSI:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="imsi" id="imsi" readonly="readonly"
						value="<c:out  value='${mobileDeviceDTO.imsi}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="screen">屏幕分辨率:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="screen" id="screen" readonly="readonly"
						value="<c:out  value='${mobileDeviceDTO.screen}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="deviceName">设备名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="deviceName" id="deviceName" readonly="readonly"
						value="<c:out  value='${mobileDeviceDTO.deviceName}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="platform">设备平台:</label></th>
					<td width="39%"><pt6:h5select
							css_class="form-control input-sm" name="platform" id="platform"
							title="" isNull="true" lookupCode="PLATFORM_PLATFORM_APP_TYPE"
							defaultValue='${mobileDeviceDTO.platform}' /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="platformVersion">平台版本:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="platformVersion" id="platformVersion"
						readonly="readonly"
						value="<c:out  value='${mobileDeviceDTO.platformVersion}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="deviceStatus">设备状态:</label></th>
					<td width="39%"><pt6:h5select
							css_class="form-control input-sm" name="deviceStatus"
							id="deviceStatus" title="" isNull="true"
							lookupCode="PLATFORM_APP_DEVICE_STATUS"
							defaultValue='${mobileDeviceDTO.deviceStatus}' /></td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
			document.ready = function () {
			parent.mobileDevice.formValidate($('#form'));
		};
	//form控件禁用
	setFormDisabled();
	$(document).keydown(function(event){  
		event.returnValue = false;
		return false;
	});  
	</script>
</body>
</html>