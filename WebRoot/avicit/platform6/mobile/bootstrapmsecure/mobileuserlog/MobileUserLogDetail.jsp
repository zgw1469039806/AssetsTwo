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
<!-- ControllerPath = "ims/portal/stat/mobileuserlog/mobileUserLogController/operation/Edit/id" -->
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
				value="<c:out  value='${mobileUserLogDTO.version}'/>" /> <input
				type="hidden" name="id"
				value="<c:out  value='${mobileUserLogDTO.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="userId">用户ID:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="userId" id="userId" readonly="readonly"
						value="<c:out  value='${mobileUserLogDTO.userId}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="deviceId">设备ID:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="deviceId" id="deviceId" readonly="readonly"
						value="<c:out  value='${mobileUserLogDTO.deviceId}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="appVersionId">版本ID:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="appVersionId" id="appVersionId"
						readonly="readonly"
						value="<c:out  value='${mobileUserLogDTO.appVersionId}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="type">日志类型:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="type" id="type" readonly="readonly"
						value="<c:out  value='${mobileUserLogDTO.type}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="opContent">OP_CONTENT:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="opContent" id="opContent" readonly="readonly"
						value="<c:out  value='${mobileUserLogDTO.opContent}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="isArchive">是否归档：归档，未归档:</label></th>
					<td width="39%"><pt6:h5select
							css_class="form-control input-sm" name="isArchive" id="isArchive"
							title="" isNull="true" lookupCode="IS_ARCHIVE"
							defaultValue='${mobileUserLogDTO.isArchive}' /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript">
		document.ready = function() {
			parent.mobileUserLog.formValidate($('#form'));
		};
		//form控件禁用
		setFormDisabled();
		$(document).keydown(function(event) {
			event.returnValue = false;
			return false;
		});
	</script>
</body>
</html>