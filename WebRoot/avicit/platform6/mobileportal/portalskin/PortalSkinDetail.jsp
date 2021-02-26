<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<!-- ControllerPath = "ims/portal/stat/portalskin/portalSkinController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${portalSkinDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${portalSkinDTO.id}'/>"/>
																																																																																																																																																																																																																																																																 <table class="form_commonTable">
				<tr>
																																											 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="skinName">皮肤名称:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="skinName"  id="skinName" readonly="readonly" value="<c:out  value='${portalSkinDTO.skinName}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="skinCode">皮肤代码:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="skinCode"  id="skinCode" readonly="readonly" value="<c:out  value='${portalSkinDTO.skinCode}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="skinImg">皮肤图标地址:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="skinImg"  id="skinImg" readonly="readonly" value="<c:out  value='${portalSkinDTO.skinImg}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="skinResponsibles">???????????????:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="skinResponsibles"  id="skinResponsibles" readonly="readonly" value="<c:out  value='${portalSkinDTO.skinResponsibles}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="skinDesc">皮肤描述:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="skinDesc"  id="skinDesc" readonly="readonly" value="<c:out  value='${portalSkinDTO.skinDesc}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="skinState">皮肤状态:</label></th>
								    									<td width="39%">
																			<pt6:h5radio css_class="radio-inline"  name="skinState"  title=""  canUse="0" lookupCode="SKIN_STATE" defaultValue='${portalSkinDTO.skinState}'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 						</tr>
					</table>
			</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
			document.ready = function () {
			parent.portalSkin.formValidate($('#form'));
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