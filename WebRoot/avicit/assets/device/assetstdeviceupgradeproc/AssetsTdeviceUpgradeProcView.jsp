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
<!-- ControllerPath = "assets/device/assetstdeviceupgradeproc/assetsTdeviceUpgradeProcController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
										   				<input type="hidden" name="id" value="<c:out  value='${assetsTdeviceUpgradeProcDTO.id}'/>" />		    
			   		    								   		    																																																																																																																																											<table class="form_commonTable">
				 <tr>
																																		 									 									 									 									 									 									 																	 																									<th width="10%">
						    						    <label for="createdByPersonAlias">申请人:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="createdByPerson" name="createdByPerson"  value="<c:out  value='${assetsTdeviceUpgradeProcDTO.createdByPerson}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias" name="createdByPersonAlias" readonly="readonly" value="<c:out  value='${assetsTdeviceUpgradeProcDTO.createdByPersonAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="createdByDeptAlias">申请人部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="createdByDept" name="createdByDept"  value="<c:out  value='${assetsTdeviceUpgradeProcDTO.createdByDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" readonly="readonly" value="<c:out  value='${assetsTdeviceUpgradeProcDTO.createdByDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="createdByTel">申请人电话:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.createdByTel}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="formState">单据状态:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.formState}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="procName">流程名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="procName"  id="procName" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.procName}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="procId">流程ID:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="procId"  id="procId" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.procId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="unifiedId">统一编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.unifiedId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceName">设备名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.deviceName}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceCategory">设备类别:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title="" isNull="true" lookupCode="DEVICE_CATEGORY" defaultValue='${assetsTdeviceUpgradeProcDTO.deviceCategory}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceSpec">设备规格:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.deviceSpec}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="createdDate">立卡日期:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="createdDate" id="createdDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsTdeviceUpgradeProcDTO.createdDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="positionId">安装地点ID:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="positionId"  id="positionId" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.positionId}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="productNum">出厂编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="productNum"  id="productNum" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.productNum}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="productDate">出厂日期:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="productDate" id="productDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsTdeviceUpgradeProcDTO.productDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="ownerIdAlias">责任人:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="ownerId" name="ownerId"  value="<c:out  value='${assetsTdeviceUpgradeProcDTO.ownerId}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias" readonly="readonly" value="<c:out  value='${assetsTdeviceUpgradeProcDTO.ownerIdAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="ownerDeptAlias">责任人部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="ownerDept" name="ownerDept"  value="<c:out  value='${assetsTdeviceUpgradeProcDTO.ownerDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" readonly="readonly" value="<c:out  value='${assetsTdeviceUpgradeProcDTO.ownerDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="upgradeReason">升级内容及理由:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="upgradeReason" id="upgradeReason">${assetsTdeviceUpgradeProcDTO.upgradeReason}</textarea> 
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="upgradeProcess">升级过程:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="upgradeProcess" id="upgradeProcess">${assetsTdeviceUpgradeProcDTO.upgradeProcess}</textarea> 
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="remarks">备注:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="remarks" id="remarks">${assetsTdeviceUpgradeProcDTO.remarks}</textarea> 
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="planeModel">适用产品机型:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="planeModel"  id="planeModel" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.planeModel}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="productName">适用产品名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="productName"  id="productName" readonly="readonly" value="<c:out value='${assetsTdeviceUpgradeProcDTO.productName}'/>"/>
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
		formId: '${assetsTdeviceUpgradeProcDTO.id}',
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