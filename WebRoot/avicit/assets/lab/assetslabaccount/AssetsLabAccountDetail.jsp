<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<HEAD>
<title>详细</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- ControllerPath = "assets/lab/assetslabaccount/assetsLabAccountController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
										   				<input type="hidden" name="id" value="<c:out  value='${assetsLabAccountDTO.id}'/>" />		    
			   		    								   		    																																																																																																																																																																																																																																																				<table class="form_commonTable">
				 <tr>
																																		 									 									 									 									 									 									 																	 																									<th width="10%">
						    						  	<label for="labName">实验室名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labName"  id="labName" readonly="readonly" value="<c:out value='${assetsLabAccountDTO.labName}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labNameShort">实验室简称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labNameShort"  id="labNameShort" readonly="readonly" value="<c:out value='${assetsLabAccountDTO.labNameShort}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labNum">实验室编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labNum"  id="labNum" readonly="readonly" value="<c:out value='${assetsLabAccountDTO.labNum}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="unifiedId">统一编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" readonly="readonly" value="<c:out value='${assetsLabAccountDTO.unifiedId}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="assetId">资产编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="assetId"  id="assetId" readonly="readonly" value="<c:out value='${assetsLabAccountDTO.assetId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="majorCategory">专业类别:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="majorCategory" id="majorCategory" title="" isNull="true" lookupCode="MAJOR_TYPE" defaultValue='${assetsLabAccountDTO.majorCategory}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labPosition">实验室位置:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labPosition"  id="labPosition" readonly="readonly" value="<c:out value='${assetsLabAccountDTO.labPosition}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labDeviceCount">实验室设备数量:</label></th>
						    							<td width="15%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="labDeviceCount" id="labDeviceCount" readonly="readonly" value="<c:out  value='${assetsLabAccountDTO.labDeviceCount}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labInfo">实验室介绍:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labInfo"  id="labInfo" readonly="readonly" value="<c:out value='${assetsLabAccountDTO.labInfo}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="manageDeptAlias">实验室管理部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="manageDept" name="manageDept"  value="<c:out  value='${assetsLabAccountDTO.manageDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="manageDeptAlias" name="manageDeptAlias" readonly="readonly" value="<c:out  value='${assetsLabAccountDTO.manageDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="managerIdAlias">实验室管理员:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="managerId" name="managerId"  value="<c:out  value='${assetsLabAccountDTO.managerId}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="managerIdAlias" name="managerIdAlias" readonly="readonly" value="<c:out  value='${assetsLabAccountDTO.managerIdAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="createdDate">实验室创建日期:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="createdDate" id="createdDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsLabAccountDTO.createdDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr>
								<tr>
																		   									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 						</tr>
						<tr>
						  <th><label for="attachment">附件</label></th>
							<td colspan="<%=4 * 2 - 1 %>">
								<div id="attachment"></div>
							</td>
						</tr>
				  </table>
		</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
//关闭Dialog
function closeForm(){
	parent.assetsLabAccount.closeDialog();
}
//加载完后初始化
$(document).ready(function () {
	//初始化附件上传组件
   $('#attachment').uploaderExt({
		formId: '${assetsLabAccountDTO.id}',
		allowAdd: false,
		allowDelete: false
   });
	//返回按钮绑定事件
	$('#returnButton').bind('click', function(){
		closeForm();
	});
	//form控件禁用
	setFormDisabled();
	$(document).keydown(function(event){  
		event.returnValue = false;
		return false;
	});  
});
</script>
</body>
</html>