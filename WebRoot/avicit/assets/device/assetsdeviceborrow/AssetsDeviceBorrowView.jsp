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
<!-- ControllerPath = "assets/device/assetsdeviceborrow/assetsDeviceBorrowController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
										   				<input type="hidden" name="id" value="<c:out  value='${assetsDeviceBorrowDTO.id}'/>" />		    
			   		    								   		    																																																																																																																																											<table class="form_commonTable">
				 <tr>
																																		 									 									 									 									 									 									 																	 																									<th width="10%">
						    						    <label for="createdByPersonAlias">申请人:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="createdByPerson" name="createdByPerson"  value="<c:out  value='${assetsDeviceBorrowDTO.createdByPerson}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias" name="createdByPersonAlias" readonly="readonly" value="<c:out  value='${assetsDeviceBorrowDTO.createdByPersonAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="createdByDeptAlias">申请人部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="createdByDept" name="createdByDept"  value="<c:out  value='${assetsDeviceBorrowDTO.createdByDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" readonly="readonly" value="<c:out  value='${assetsDeviceBorrowDTO.createdByDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="createdByTel">申请人电话:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.createdByTel}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="formState">单据状态:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.formState}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="procName">流程名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="procName"  id="procName" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.procName}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="procId">流程ID:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="procId"  id="procId" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.procId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="assetId">资产编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="assetId"  id="assetId" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.assetId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="unifiedId">统一编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.unifiedId}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceCategory">设备类别:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceCategory"  id="deviceCategory" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.deviceCategory}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceName">设备名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.deviceName}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceModel">设备型号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.deviceModel}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceSpec">设备规格:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.deviceSpec}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						    <label for="ownerIdAlias">责任人:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="ownerId" name="ownerId"  value="<c:out  value='${assetsDeviceBorrowDTO.ownerId}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias" readonly="readonly" value="<c:out  value='${assetsDeviceBorrowDTO.ownerIdAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="ownerDeptAlias">责任人部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="ownerDept" name="ownerDept"  value="<c:out  value='${assetsDeviceBorrowDTO.ownerDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" readonly="readonly" value="<c:out  value='${assetsDeviceBorrowDTO.ownerDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="userIdAlias">使用人:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="userId" name="userId"  value="<c:out  value='${assetsDeviceBorrowDTO.userId}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="userIdAlias" name="userIdAlias" readonly="readonly" value="<c:out  value='${assetsDeviceBorrowDTO.userIdAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="userDeptAlias">使用人部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="userDept" name="userDept"  value="<c:out  value='${assetsDeviceBorrowDTO.userDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="userDeptAlias" name="userDeptAlias" readonly="readonly" value="<c:out  value='${assetsDeviceBorrowDTO.userDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="borrowDate">实际借用时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="borrowDate" id="borrowDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsDeviceBorrowDTO.borrowDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="expectReturnDate">预计归还时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="expectReturnDate" id="expectReturnDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsDeviceBorrowDTO.expectReturnDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="returnDate">实际归还时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="returnDate" id="returnDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsDeviceBorrowDTO.returnDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="borrowLength">借用时长:</label></th>
						    							<td width="15%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="borrowLength" id="borrowLength" readonly="readonly" value="<c:out  value='${assetsDeviceBorrowDTO.borrowLength}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="manageState">统管设备状态:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="manageState"  id="manageState" readonly="readonly" value="<c:out value='${assetsDeviceBorrowDTO.manageState}'/>"/>
													   </td>
																		   									 						</tr>
						<tr>
						  <th><label for="attachment">附件</label></th>
							<td colspan="<%=4 * 2 - 1 %>">
								<div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
							</td>
						</tr>
				  </table>
		</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
//加载完后初始化
$(document).ready(function () {
	//初始化附件上传组件
    $('#attachment').uploaderExt({
		formId: '${assetsDeviceBorrowDTO.id}',
		allowAdd: false,
		allowDelete: false
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