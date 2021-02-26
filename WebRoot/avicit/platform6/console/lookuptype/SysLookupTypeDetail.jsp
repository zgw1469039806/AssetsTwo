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
<!-- ControllerPath = "ys/syslookuptype/sysLookupTypeController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value='<c:out  value='${sysLookupTypeDTO.version}'/>'/>
															<input type="hidden" name="id" value='<c:out  value='${sysLookupTypeDTO.id}'/>'/>
																																																																																																																									 <table class="form_commonTable">
				<tr>
																																											 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="sysApplicationId">应用ID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="sysApplicationId"  id="sysApplicationId" readonly="readonly" value='<c:out  value='${sysLookupTypeDTO.sysApplicationId}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lookupType">代码类型:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="lookupType"  id="lookupType" readonly="readonly" value='<c:out  value='${sysLookupTypeDTO.lookupType}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="systemFlag">是否为系统初始 Y 是 N 否:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="systemFlag"  id="systemFlag" readonly="readonly" value='<c:out  value='${sysLookupTypeDTO.systemFlag}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="validFlag">是否有效 1代表有效,0代表无效 默认为1:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="validFlag"  id="validFlag" readonly="readonly" value='<c:out  value='${sysLookupTypeDTO.validFlag}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="belongModule">所属模块:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="belongModule"  id="belongModule" readonly="readonly" value='<c:out  value='${sysLookupTypeDTO.belongModule}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="usageModifier">0 公有可用     1私有可用:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="usageModifier"  id="usageModifier" readonly="readonly" value='<c:out  value='${sysLookupTypeDTO.usageModifier}'/>'/>
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
			parent.sysLookupType.formValidate($('#form'));
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