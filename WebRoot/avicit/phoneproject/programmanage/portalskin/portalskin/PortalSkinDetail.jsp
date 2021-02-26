<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "phoneproject/programmanage/portalskin/portalskin/PortalSkinController/operation/Detail/id" -->
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
			<input type="hidden" name="id" value='${portalSkinDTO.id}' /> <input
				type="hidden" name="id" value='${portalSkinDTO.id}' />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right"><span style="color: red;">*</span> 皮肤名称:</th>
					<td><input title="皮肤名称" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="skinName" id="skinName" readonly="readonly"
						value='${portalSkinDTO.skinName}' /></td>
					<th align="right"><span style="color: red;">*</span>
						皮肤代码（唯一性标识）:</th>
					<td><input title="皮肤代码（唯一性标识）" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="skinCode" id="skinCode" readonly="readonly"
						value='${portalSkinDTO.skinCode}' /></td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 皮肤图标:</th>
					<td><input title="皮肤图标" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="skinImg" id="skinImg" readonly="readonly"
						value='${portalSkinDTO.skinImg}' /></td>
					<th align="right"><span style="color: red;">*</span>
						皮肤责任人（多选）:</th>
					<td><input title="皮肤责任人（多选）" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="skinResponsibles" id="skinResponsibles" readonly="readonly"
						value='${portalSkinDTO.skinResponsibles}' /></td>
				</tr>
				<tr>
					<th align="right">皮肤描述:</th>
					<td><input title="皮肤描述" class="inputbox" style="width: 180px;"
						type="text" name="skinDesc" id="skinDesc" readonly="readonly"
						value='${portalSkinDTO.skinDesc}' /></td>
					<th align="right"><span style="color: red;">*</span> 皮肤状态(0
						启用；1 禁用):</th>
					<td><input title="皮肤状态(0 启用；1 禁用)" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="skinState" id="skinState" readonly="readonly"
						value='${portalSkinDTO.skinState}' /></td>
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