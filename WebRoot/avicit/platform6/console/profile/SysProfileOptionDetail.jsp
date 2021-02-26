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
<!-- ControllerPath = "ys/sysprofileoption/sysProfileOptionController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value='<c:out  value='${sysProfileOptionDTO.version}'/>'/>
															<input type="hidden" name="id" value='<c:out  value='${sysProfileOptionDTO.id}'/>'/>
																																																																																																																																																																																																																			 <table class="form_commonTable">
				<tr>
																																											 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="sysApplicationId">应用ID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="sysApplicationId"  id="sysApplicationId" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.sysApplicationId}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="profileOptionCode">配置文件代码:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="profileOptionCode"  id="profileOptionCode" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.profileOptionCode}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="profileOptionName">配置文件名称:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="profileOptionName"  id="profileOptionName" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.profileOptionName}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="description">描述:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="description"  id="description" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.description}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ynMultiValue">是否多值 Y 是 N 否:</label></th>
								    									<td width="39%">
																			<pt6:h5radio css_class="radio-inline"  name="ynMultiValue"  title=""  canUse="0" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${sysProfileOptionDTO.ynMultiValue}'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="userChangeableFlag">用户可更新标识 Y代表可以，N代表不可以，默认为Y:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="userChangeableFlag"  id="userChangeableFlag" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.userChangeableFlag}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="userVisibleFlag">用户可查看标识 Y代表可以，N代表不可以，默认为Y:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="userVisibleFlag"  id="userVisibleFlag" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.userVisibleFlag}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="siteEnabledFlag">地点层可见 Y代表可以，N代表不可以，默认为Y:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="siteEnabledFlag"  id="siteEnabledFlag" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.siteEnabledFlag}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="appEnabledFlag">应用程序层可见 Y代表可以，N代表不可以，默认为Y:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="appEnabledFlag"  id="appEnabledFlag" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.appEnabledFlag}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="roleEnabledFlag">角色层可见 Y代表可以，N代表不可以，默认为Y:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="roleEnabledFlag"  id="roleEnabledFlag" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.roleEnabledFlag}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="userEnabledFlag">用户层可见 Y代表可以，N代表不可以，默认为Y:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="userEnabledFlag"  id="userEnabledFlag" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.userEnabledFlag}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deptEnabledFlag">部门启用标记 Y代表可以，N代表不可以，默认为Y:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="deptEnabledFlag"  id="deptEnabledFlag" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.deptEnabledFlag}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="sqlValidation">SQL校验 用于配置文件选项的值列表的SQL验证:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="sqlValidation"  id="sqlValidation" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.sqlValidation}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="validFlag">状态 1代表有效,0代表无效 默认为1:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="validFlag"  id="validFlag" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.validFlag}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="systemFlag">是否为系统初始 Y 是 N 否:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="systemFlag"  id="systemFlag" readonly="readonly" value='<c:out  value='${sysProfileOptionDTO.systemFlag}'/>'/>
																	   </td>
																																								   													 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="usageModifier">0 公有可用     1私有可用:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="usageModifier" id="usageModifier" title="" isNull="true" lookupCode="DEPT_TYPE" defaultValue='${sysProfileOptionDTO.usageModifier}'/>
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
			parent.sysProfileOption.formValidate($('#form'));
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