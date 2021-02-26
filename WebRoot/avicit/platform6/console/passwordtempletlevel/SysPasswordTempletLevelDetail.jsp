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
<!-- ControllerPath = "demo/syspasswordtempletlevel/sysPasswordTempletLevelController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value='<c:out  value='${sysPasswordTempletLevelDTO.version}'/>'/>
															<input type="hidden" name="id" value='<c:out  value='${sysPasswordTempletLevelDTO.id}'/>'/>
																																																																																																							 <table class="form_commonTable">
				<tr>
																																											 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="sysApplicationId">应用ID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="sysApplicationId"  id="sysApplicationId" readonly="readonly" value='<c:out  value='${sysPasswordTempletLevelDTO.sysApplicationId}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="key">模板名称:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="key"  id="key" readonly="readonly" value='<c:out  value='${sysPasswordTempletLevelDTO.key}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="code">模板编码:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="code"  id="code" readonly="readonly" value='<c:out  value='${sysPasswordTempletLevelDTO.code}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="userLevelCode">人员密级 关联数据字典:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="userLevelCode" id="userLevelCode" title="" isNull="true" lookupCode="DEPT_TYPE" defaultValue='${sysPasswordTempletLevelDTO.userLevelCode}'/>
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
			parent.sysPasswordTempletLevel.formValidate($('#form'));
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