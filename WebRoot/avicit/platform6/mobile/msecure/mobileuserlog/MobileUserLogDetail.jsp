<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobileuserlog/MobileUserLogController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false"
		style="overflow: hidden; padding-bottom: 35px;">
		<form id='form'>
			<input type="hidden" name="id" value='${mobileUserLogDTO.id}' /> <input
				type="hidden" name="id" value='${mobileUserLogDTO.id}' />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right">用户ID:</th>
					<td><input title="用户ID" class="inputbox" style="width: 180px;"
						type="text" name="userId" id="userId" readonly="readonly"
						value='${mobileUserLogDTO.userId}' /></td>
					<th align="right">设备ID:</th>
					<td><input title="设备ID" class="inputbox" style="width: 180px;"
						type="text" name="deviceId" id="deviceId" readonly="readonly"
						value='${mobileUserLogDTO.deviceId}' /></td>
				</tr>
				<tr>
					<th align="right">版本ID:</th>
					<td><input title="版本ID" class="inputbox" style="width: 180px;"
						type="text" name="appVersionId" id="appVersionId"
						readonly="readonly" value='${mobileUserLogDTO.appVersionId}' /></td>
					<th align="right">日志类型:</th>
					<td><input title="日志类型" class="inputbox" style="width: 180px;"
						type="text" name="type" id="type" readonly="readonly"
						value='${mobileUserLogDTO.type}' /></td>
				</tr>
				<tr>
					<th align="right">日志内容:</th>
					<td><input title="日志内容" class="inputbox" style="width: 180px;"
						type="text" name="opContent" id="opContent" readonly="readonly"
						value='${mobileUserLogDTO.opContent}' /></td>
					<th align="right">是否归档：归档，未归档:</th>
					<td><input title="是否归档：归档，未归档" class="inputbox"
						style="width: 180px;" type="text" name="isArchive" id="isArchive"
						readonly="readonly" value='${mobileUserLogDTO.isArchive}' /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
		$(function() {
		});
	</script>
</body>
</html>