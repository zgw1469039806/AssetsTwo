<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobiledevice/MobileDeviceController/operation/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<style type="text/css">
.switch-btn {
	width: 144px;
	display: block;
	padding: 1px;
	background: #E0FFFF;
	overflow: hidden;
	margin-bottom: 5px;
	border: 1px solid #AFEEEE;
	border-radius: 18px;
	cursor: pointer;
}

.switch-btn span {
	width: 60px;
	font-size: 14px;
	height: 18px;
	padding: 4px 5px 2px 5px;
	display: block;
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#f6f6f6,
		endColorstr=#B0E0E6, grandientType=1);
	background: -webkit-gradient(linear, 0 0, 0 100%, from(#f6f6f6),
		to(#B0E0E6));
	background: -moz-linear-gradient(top, #f6f6f6, #B0E0E6);
	border-radius: 18px;
	float: left;
	color: #000000;
	text-align: center;
}

.switch-btn:hover span {
	background: #fff;
}

.switch-btn span.off {
	float: right;
}

input[type='submit'] {
	padding: 5px 10px;
	cursor: pointer;
}
</style>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" value='${mobileDeviceDTO.id}' />
			<table class="form_commonTable">
				<tr>
					<th width="10%">设备IMEI:</th>
					<td width="40%"><input title="设备IMEI" class="inputbox easyui-validatebox" data-options="validType:'maxLength[50]',required:true" style="width: 180px;" type="text" name="imei" id="imei" value='<c:out value='${mobileDeviceDTO.imei}'/>' /></td>
					<th width="10%">设备IMSI:</th>
					<td width="40%"><input title="设备IMSI" class="inputbox easyui-validatebox" data-options="validType:'maxLength[50]'" style="width: 180px;" type="text" name="imsi" id="imsi" value='<c:out value='${mobileDeviceDTO.imsi}'/>' /></td>
				</tr>
				<tr>
					<th width="10%">屏幕分辨率</th>
					<td width="40%"><input title="屏幕分辨率" class="inputbox easyui-validatebox" data-options="validType:'maxLength[50]'" style="width: 180px;" type="text" name="screen" id="screen" value='<c:out value='${mobileDeviceDTO.screen}'/>' /></td>
					<th width="10%">设备名称:</th>
					<td width="40%"><input title="设备名称" class="inputbox easyui-validatebox" data-options="validType:'maxLength[50]'" style="width: 180px;" type="text" name="deviceName" id="deviceName" value='<c:out value='${mobileDeviceDTO.deviceName}'/>' /></td>
				</tr>
				<tr>
					<th width="10%">设备平台:</th>
					<td width="40%">
						<select class="easyui-combobox" name="platform" id="platform" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="ios" <c:if test="${mobileDeviceDTO.platform == 'ios' }">selected</c:if>>ios</option>
							<option value="android" <c:if test="${mobileDeviceDTO.platform == 'android' }">selected</c:if>>android</option>
						</select>
					</td>
					<th width="10%">平台版本:</th>
					<td width="40%"><input title="平台版本" class="inputbox easyui-validatebox" data-options="validType:'maxLength[50]'" style="width: 180px;" type="text" name="platformVersion" id="platformVersion" value='<c:out value='${mobileDeviceDTO.platformVersion}'/>' /></td>
				</tr>
				<tr>
					<th width="10%">设备状态:</th>
					<td width="40%">
						<select class="easyui-combobox" name="deviceStatus" id="deviceStatus" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="1" <c:if test="${mobileDeviceDTO.deviceStatus == '1' }">selected</c:if>>正常</option>
							<option value="0" <c:if test="${mobileDeviceDTO.deviceStatus == '0' }">selected</c:if>>禁止</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveForm();" href="javascript:void(0);">保存</a> <a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {
			maxLength : {
				validator : function(value, param) {
					return param[0] >= value.length;

				},
				message : '请输入最多 {0} 字符.'
			}
		});
		$(function() {
		})
		function closeForm() {
			parent.mobileDevice.closeDialog("#edit");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.mobileDevice.save(serializeObject($('#form')), "#edit");
		}
	</script>
</body>
</html>