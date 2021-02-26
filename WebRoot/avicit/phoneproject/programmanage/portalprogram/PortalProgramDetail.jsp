<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "pdmt/programmanage/portalprogram/PortalProgramController/operation/Detail/id" -->
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
			<input type="hidden" name="id" value='${portalProgramDTO.id}' /> <input
				type="hidden" name="id" value='${portalProgramDTO.id}' />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right">应用程序名称:</th>
					<td><input title="应用程序名称" class="inputbox"
						style="width: 180px;" type="text" name="programName"
						id="programName" readonly="readonly"
						value='${portalProgramDTO.programName}' /></td>
					<th align="right">应用程序代码（菜单的唯一性标识）:</th>
					<td><input title="应用程序代码（菜单的唯一性标识）" class="inputbox"
						style="width: 180px;" type="text" name="programCode"
						id="programCode" readonly="readonly"
						value='${portalProgramDTO.programCode}' /></td>
				</tr>
				<tr>
					<th align="right">应用程序图标:</th>
					<td><input title="应用程序图标" class="inputbox"
						style="width: 180px;" type="text" name="programImg"
						id="programImg" readonly="readonly"
						value='${portalProgramDTO.programImg}' /></td>
					<th align="right">责任人（多选）:</th>
					<td><input title="责任人（多选）" class="inputbox"
						style="width: 180px;" type="text" name="programResponsibles"
						id="programResponsibles" readonly="readonly"
						value='${portalProgramDTO.programResponsibles}' /></td>
				</tr>
				<tr>
					<th align="right">应用程序描述:</th>
					<td><input title="应用程序描述" class="inputbox"
						style="width: 180px;" type="text" name="programDesc"
						id="programDesc" readonly="readonly"
						value='${portalProgramDTO.programDesc}' /></td>
					<th align="right">应用程序状态(0 启用；1 禁用):</th>
					<td><input title="应用程序状态(0 启用；1 禁用)" class="inputbox"
						style="width: 180px;" type="text" name="programState"
						id="programState" readonly="readonly"
						value='${portalProgramDTO.programState}' /></td>
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