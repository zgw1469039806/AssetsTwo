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
<!-- ControllerPath = "assets/device/assetsreconstructionproc/assetsReconstructionProcController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
										   				<input type="hidden" name="id" value="<c:out  value='${assetsReconstructionProcDTO.id}'/>" />		    
			   		    								   		    																																																																																																																																																																																																																																					<table class="form_commonTable">
				 <tr>
																																		 																	 																									<th width="10%">
						    						  	<label for="reconstructionId">改造申请单号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="reconstructionId"  id="reconstructionId" readonly="readonly" value="<c:out value='${assetsReconstructionProcDTO.reconstructionId}'/>"/>
													   </td>
																		   									 									 																	 																									<th width="10%">
						    						    <label for="createdByDeptAlias">申请人部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="createdByDept" name="createdByDept"  value="<c:out  value='${assetsReconstructionProcDTO.createdByDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" readonly="readonly" value="<c:out  value='${assetsReconstructionProcDTO.createdByDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="formState">单据状态:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out value='${assetsReconstructionProcDTO.formState}'/>"/>
													   </td>
																		   									 									 									 									 									 									 																	 																									<th width="10%">
						    						    <label for="ownerDeptAlias">责任部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="ownerDept" name="ownerDept"  value="<c:out  value='${assetsReconstructionProcDTO.ownerDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" readonly="readonly" value="<c:out  value='${assetsReconstructionProcDTO.ownerDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						    <label for="ownerIdAlias">责任人:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="ownerId" name="ownerId"  value="<c:out  value='${assetsReconstructionProcDTO.ownerId}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias" readonly="readonly" value="<c:out  value='${assetsReconstructionProcDTO.ownerIdAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="ownerTel">责任人联系方式:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="ownerTel"  id="ownerTel" readonly="readonly" value="<c:out value='${assetsReconstructionProcDTO.ownerTel}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceName">设备名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out value='${assetsReconstructionProcDTO.deviceName}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="secretLevel">密级:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL" defaultValue='${assetsReconstructionProcDTO.secretLevel}'/>
						    						   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="unifiedId">统一编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" readonly="readonly" value="<c:out value='${assetsReconstructionProcDTO.unifiedId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceModel">设备型号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" readonly="readonly" value="<c:out value='${assetsReconstructionProcDTO.deviceModel}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceSpec">设备规格:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" readonly="readonly" value="<c:out value='${assetsReconstructionProcDTO.deviceSpec}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="manufacturerId">生产厂家:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="manufacturerId"  id="manufacturerId" readonly="readonly" value="<c:out value='${assetsReconstructionProcDTO.manufacturerId}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="likaDate">立卡时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="likaDate" id="likaDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsReconstructionProcDTO.likaDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="originalValue">设备原值:</label></th>
						    							<td width="15%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="originalValue" id="originalValue" readonly="readonly" value="<c:out  value='${assetsReconstructionProcDTO.originalValue}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="existingPerformance">现有结构性能指标:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="existingPerformance" id="existingPerformance">${assetsReconstructionProcDTO.existingPerformance}</textarea> 
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="reformingReason">改造理由:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="reformingReason" id="reformingReason">${assetsReconstructionProcDTO.reformingReason}</textarea> 
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="afterPerformance">改造后结构性能指标:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="afterPerformance" id="afterPerformance">${assetsReconstructionProcDTO.afterPerformance}</textarea> 
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="transformWay">改造途径:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="transformWay" id="transformWay">${assetsReconstructionProcDTO.transformWay}</textarea> 
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="budget">经费预算:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="budget"  id="budget" readonly="readonly" value="<c:out value='${assetsReconstructionProcDTO.budget}'/>"/>
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
		formId: '${assetsReconstructionProcDTO.id}',
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