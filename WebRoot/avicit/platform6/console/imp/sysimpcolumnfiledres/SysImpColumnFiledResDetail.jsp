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
<!-- ControllerPath = "platform6/modules/system/imp/sysimpcolumnfiledres/sysImpColumnFiledResController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${sysImpColumnFiledResDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${sysImpColumnFiledResDTO.id}'/>"/>
																																																																																																																																																																																																																																					 <table class="form_commonTable">
				<tr>
																																											 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="sheetid">sheetId:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="sheetid"  id="sheetid" readonly="readonly" value="<c:out  value='${sysImpColumnFiledResDTO.sheetid}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="columnTitle">列标题:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="columnTitle"  id="columnTitle" readonly="readonly" value="<c:out  value='${sysImpColumnFiledResDTO.columnTitle}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="columnIndex">列序号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="columnIndex"  id="columnIndex" readonly="readonly" value="<c:out  value='${sysImpColumnFiledResDTO.columnIndex}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="field">字段属性:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="field"  id="field" readonly="readonly" value="<c:out  value='${sysImpColumnFiledResDTO.field}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="fieldDesc">字段名称:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="fieldDesc"  id="fieldDesc" readonly="readonly" value="<c:out  value='${sysImpColumnFiledResDTO.fieldDesc}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="required">是否必填:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="required"  id="required" readonly="readonly" value="<c:out  value='${sysImpColumnFiledResDTO.required}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="remark">备注:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="remark"  id="remark" readonly="readonly" value="<c:out  value='${sysImpColumnFiledResDTO.remark}'/>"/>
																	   </td>
																																								   													 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="checkType">格式校验 1：数值 2：日期 3:邮箱 4：手机 5：ip地址:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="checkType"  id="checkType" readonly="readonly" value="<c:out  value='${sysImpColumnFiledResDTO.checkType}'/>"/>
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
		parent.sysImpColumnFiledRes.formValidate($('#form'));
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