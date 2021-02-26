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
<!-- ControllerPath = "assets/lab/assetslaborder/assetsLabOrderController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
										   				<input type="hidden" name="id" value="<c:out  value='${assetsLabOrderDTO.id}'/>" />		    
			   		    								   		    																																																																																																																																																																																																																																																																																																						<table class="form_commonTable">
				 <tr>
																																		 									 									 									 									 									 									 																	 																									<th width="10%">
						    						  	<label for="orderNumber">预约单号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="orderNumber"  id="orderNumber" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.orderNumber}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="applyIdAlias">申请人:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="applyId" name="applyId"  value="<c:out  value='${assetsLabOrderDTO.applyId}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="applyIdAlias" name="applyIdAlias" readonly="readonly" value="<c:out  value='${assetsLabOrderDTO.applyIdAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="applyDeptAlias">申请部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="applyDept" name="applyDept"  value="<c:out  value='${assetsLabOrderDTO.applyDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="applyDeptAlias" name="applyDeptAlias" readonly="readonly" value="<c:out  value='${assetsLabOrderDTO.applyDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="telephone">联系电话:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="telephone"  id="telephone" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.telephone}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="tdeviceName">试件名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="tdeviceName"  id="tdeviceName" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.tdeviceName}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="tdeviceCode">试件代号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="tdeviceCode"  id="tdeviceCode" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.tdeviceCode}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="tdeviceModel">试件型号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="tdeviceModel"  id="tdeviceModel" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.tdeviceModel}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="tdeviceNum">试件编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="tdeviceNum"  id="tdeviceNum" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.tdeviceNum}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="belongModel">所属机型:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="belongModel"  id="belongModel" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.belongModel}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="testType">试验类型:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="testType" id="testType" title="" isNull="true" lookupCode="TEST_TYPE" defaultValue='${assetsLabOrderDTO.testType}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="testNature">试验性质:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="testNature" id="testNature" title="" isNull="true" lookupCode="TEST_NATURE" defaultValue='${assetsLabOrderDTO.testNature}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="testCondition">试验条件:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="testCondition"  id="testCondition" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.testCondition}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="supportTool">配套工装:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="supportTool"  id="supportTool" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.supportTool}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="orderStartTime">预约开始时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="orderStartTime" id="orderStartTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsLabOrderDTO.orderStartTime}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="orderFinishTime">预约结束时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="orderFinishTime" id="orderFinishTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsLabOrderDTO.orderFinishTime}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labDeviceId">实验设备ID:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labDeviceId"  id="labDeviceId" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.labDeviceId}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labDeviceUid">实验设备统一编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labDeviceUid"  id="labDeviceUid" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.labDeviceUid}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labDeviceName">实验设备名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labDeviceName"  id="labDeviceName" readonly="readonly" value="<c:out value='${assetsLabOrderDTO.labDeviceName}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="approvalStartTime">审核开始时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="approvalStartTime" id="approvalStartTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsLabOrderDTO.approvalStartTime}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="approvalFinishTime">审核结束时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="approvalFinishTime" id="approvalFinishTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsLabOrderDTO.approvalFinishTime}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="actualStartTime">实际开始时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="actualStartTime" id="actualStartTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsLabOrderDTO.actualStartTime}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="actualFinishTime">实际结束时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="actualFinishTime" id="actualFinishTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsLabOrderDTO.actualFinishTime}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
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
		formId: '${assetsLabOrderDTO.id}',
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