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
<!-- ControllerPath = "platform6/mda/mdafieldsconfig/mdaFieldsconfigController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value='<c:out  value='${mdaFieldsconfigDTO.version}'/>'/>
															<input type="hidden" name="id" value='<c:out  value='${mdaFieldsconfigDTO.id}'/>'/>
																																																																																																																 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="itemid">ITEMID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="itemid"  id="itemid" readonly="readonly" value='<c:out  value='${mdaFieldsconfigDTO.itemid}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="fieldname">FIELDNAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="fieldname"  id="fieldname" readonly="readonly" value='<c:out  value='${mdaFieldsconfigDTO.fieldname}'/>'/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="fieldvalue">FIELDVALUE:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="fieldvalue"  id="fieldvalue" readonly="readonly" value='<c:out  value='${mdaFieldsconfigDTO.fieldvalue}'/>'/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="fieldtype">FIELDTYPE:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="fieldtype"  id="fieldtype" readonly="readonly" value='<c:out  value='${mdaFieldsconfigDTO.fieldtype}'/>'/>
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
		parent.mdaFieldsconfig.formValidate($('#form'));
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