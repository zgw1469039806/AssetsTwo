<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "phoneproject/portalimage/PortalImageController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow: hidden; padding-bottom: 35px;">
		<form id='form'>
			<input type="hidden" name="id" value='${portalImageDTO.id}' /> <input type="hidden" name="id"
				value='${portalImageDTO.id}' />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right">图片名称:</th>
					<td><input title="图片名称" class="inputbox" style="width: 180px;" type="text" name="imageName" id="imageName"
						readonly="readonly" value='${portalImageDTO.imageName}' /></td>
					<th align="right">图片路径:</th>
					<td><input title="图片路径" class="inputbox" style="width: 180px;" type="text" name="imagePath" id="imagePath"
						readonly="readonly" value='${portalImageDTO.imagePath}' /></td>
				</tr>
				<tr>
					<th align="right">显示顺序:</th>
					<td><input title="显示顺序" class="easyui-numberbox" style="width: 180px;" type="text" name="imageOrder"
						id="imageOrder" readonly="readonly" value='${portalImageDTO.imageOrder}' /></td>
				</tr>
			</table>
		</form>
		<fieldset>
		<legend>附件</legend>
		<div class="formExtendBase">
			<jsp:include page="/avicit/platform6/modules/system/swfupload/swfViewInclude.jsp">
				<jsp:param name="form_id" value="${portalImageDTO.id}"/>
				<jsp:param name="save_type" value="true"/>
				<jsp:param name="file_category" value="PLATFORM_SEX"/>
				<jsp:param name="secret_level" value="PLATFORM_FILE_SECRET_LEVEL"/> 
			</jsp:include>
		</div>
</fieldset>
	</div>
	<script type="text/javascript">
		$(function() {
		});
	</script>
</body>
</html>