<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "cape/meidi/mobilepushconfig/MobilePushConfigController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
									<input type="hidden" name="id" value='${mobilePushConfigDTO.id}'/>
												<input type="hidden" name="id" value='${mobilePushConfigDTO.id}'/>
																																																									<table width="100%" style="padding-top: 10px;">
		<tr>
																					<th align="right">
															PUSH_NAME:</th>
					<td>
																		<input title="PUSH_NAME" class="inputbox" style="width: 180px;" type="text" name="pushName" id="pushName" readonly="readonly" value='${mobilePushConfigDTO.pushName}'/>
																</td>
																										<th align="right">
															PUSH_URL:</th>
					<td>
																		<input title="PUSH_URL" class="inputbox" style="width: 180px;" type="text" name="pushUrl" id="pushUrl" readonly="readonly" value='${mobilePushConfigDTO.pushUrl}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															PUSH_APP:</th>
					<td>
																		<input title="PUSH_APP" class="inputbox" style="width: 180px;" type="text" name="pushApp" id="pushApp" readonly="readonly" value='${mobilePushConfigDTO.pushApp}'/>
																</td>
																										<th align="right">
															DESCRIPTION:</th>
					<td>
																		<input title="DESCRIPTION" class="inputbox" style="width: 180px;" type="text" name="description" id="description" readonly="readonly" value='${mobilePushConfigDTO.description}'/>
																</td>
											</tr>
						<tr>
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