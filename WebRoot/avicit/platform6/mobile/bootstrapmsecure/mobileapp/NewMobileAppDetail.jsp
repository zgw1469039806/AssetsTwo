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
<!-- ControllerPath = "platform6/bootstrapmsecure/mobileapp/NewmobileAppController/operation/Edit/id" -->
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
				value="<c:out  value='${mobileAppDTO.version}'/>" /> <input
				type="hidden" name="id" value="<c:out  value='${mobileAppDTO.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="appName">应用名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="appName" id="appName" readonly="readonly"
						value="<c:out  value='${mobileAppDTO.appName}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="appStatus">应用状态:</label></th>
					<td width="39%"><pt6:h5select
							css_class="form-control input-sm" name="appStatus" id="appStatus"
							title="" isNull="true" lookupCode="PLATFORM_APP_STATUS"
							defaultValue='${mobileAppDTO.appStatus}' /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="descript">应用描述:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="descript" id="descript" readonly="readonly"
						value="<c:out  value='${mobileAppDTO.descript}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="appBindChose">应用是否需要绑定:</label></th>
					<td width="39%"><pt6:h5select
							css_class="form-control input-sm" name="appBindChose"
							id="appBindChose" title="" isNull="true"
							lookupCode="PLATFORM_APP_BIND_CHOSE"
							defaultValue='${mobileAppDTO.appBindChose}' /></td>
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
			document.ready = function () {
			parent.mobileApp.formValidate($('#form'));
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