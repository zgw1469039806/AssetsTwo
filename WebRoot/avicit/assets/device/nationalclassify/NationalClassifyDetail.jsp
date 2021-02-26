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
<!-- ControllerPath = "demo/baseinfo/nationalclassify/nationalClassifyController/operation/Edit/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${nationalClassifyDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${nationalClassifyDTO.id}'/>"/>
																																																																												 <table class="form_commonTable">
				<tr>
																																											 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="parentid">PARENTID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="parentid"  id="parentid" readonly="readonly" value="<c:out  value='${nationalClassifyDTO.parentid}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="name">NAME:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="name"  id="name" readonly="readonly" value="<c:out  value='${nationalClassifyDTO.name}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="itemNum">ITEM_NUM:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="itemNum"  id="itemNum" readonly="readonly" value="<c:out  value='${nationalClassifyDTO.itemNum}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="sn">SN:</label></th>
								    									<td width="39%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="sn" id="sn" readonly="readonly" value="<c:out  value='${nationalClassifyDTO.sn}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="fatherNum">FATHER_NUM:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="fatherNum"  id="fatherNum" readonly="readonly" value="<c:out  value='${nationalClassifyDTO.fatherNum}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isvalid">ISVALID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="isvalid"  id="isvalid" readonly="readonly" value="<c:out  value='${nationalClassifyDTO.isvalid}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="treePath">TREE_PATH:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="treePath"  id="treePath" readonly="readonly" value="<c:out  value='${nationalClassifyDTO.treePath}'/>"/>
																	   </td>
																																								   													 						</tr>
					</table>
			</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
		document.ready = function () {
		parent.nationalClassify.formValidate($('#form'));
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