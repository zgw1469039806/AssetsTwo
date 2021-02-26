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
<!-- ControllerPath = "ims/portal/stat/portalprogram/portalProgramController/operation/Edit/id" -->
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
				value="<c:out  value='${portalProgramDTO.version}'/>" /> <input
				type="hidden" name="id"
				value="<c:out  value='${portalProgramDTO.id}'/>" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="programName">应用名称:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="programName" id="programName"
						readonly="readonly"
						value="<c:out  value='${portalProgramDTO.programName}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="programCode">应用代码:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="programCode" id="programCode"
						readonly="readonly"
						value="<c:out  value='${portalProgramDTO.programCode}'/>" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="programImg">应用图标上传:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="programImg" id="programImg" readonly="readonly"
						value="<c:out  value='${portalProgramDTO.programImg}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="programResponsibles">负责人（多选）:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="programResponsibles" id="programResponsibles"
						readonly="readonly"
						value="<c:out  value='${portalProgramDTO.programResponsibles}'/>" />
					</td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="programDesc">应用程序描述:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="programDesc" id="programDesc"
						readonly="readonly"
						value="<c:out  value='${portalProgramDTO.programDesc}'/>" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;"><label
						for="programState">应用程序状态:</label></th>
					<td width="39%"><input class="form-control input-sm"
						type="text" name="programState" id="programState"
						readonly="readonly"
						value="<c:out  value='${portalProgramDTO.programState}'/>" /></td>
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
			parent.portalProgram.formValidate($('#form'));
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