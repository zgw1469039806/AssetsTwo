<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobileconfig/mobilefilepathconfig/MobileFilePathConfigController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
									<input type="hidden" name="id" value='${mobileFilePathConfigDTO.id}'/>
												<input type="hidden" name="id" value='${mobileFilePathConfigDTO.id}'/>
																																																				<table width="100%" style="padding-top: 10px;">
		<tr>
																																<th align="right">
															FILE_PATH_NAME:</th>
					<td>
																		<input title="FILE_PATH_NAME" class="inputbox" style="width: 180px;" type="text" name="filePathName" id="filePathName" readonly="readonly" value='${mobileFilePathConfigDTO.filePathName}'/>
																</td>
																										<th align="right">
															FILE_PATH:</th>
					<td>
																		<input title="FILE_PATH" class="inputbox" style="width: 180px;" type="text" name="filePath" id="filePath" readonly="readonly" value='${mobileFilePathConfigDTO.filePath}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															DESCRIPTION:</th>
					<td>
																		<input title="DESCRIPTION" class="inputbox" style="width: 180px;" type="text" name="description" id="description" readonly="readonly" value='${mobileFilePathConfigDTO.description}'/>
																</td>
																																														</tr>
		</table>
		</form>
	</div>
	<script type="text/javascript">
	$(function(){
																																																																																																																																																							});
	</script>
</body>
</html>