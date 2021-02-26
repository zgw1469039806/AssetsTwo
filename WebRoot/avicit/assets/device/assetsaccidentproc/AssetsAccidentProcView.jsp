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
<!-- ControllerPath = "assets/device/assetsaccidentproc/assetsAccidentProcController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
										   				<input type="hidden" name="id" value="<c:out  value='${assetsAccidentProcDTO.id}'/>" />		    
			   		    								   		    																																																																																																																																																																																																																																																																																																						<table class="form_commonTable">
				 <tr>
																																		 																	 																									<th width="10%">
						    						  	<label for="accidentNo">事故编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="accidentNo"  id="accidentNo" readonly="readonly" value="<c:out value='${assetsAccidentProcDTO.accidentNo}'/>"/>
													   </td>
																		   									 									 																	 																									<th width="10%">
						    						    <label for="createdByDeptAlias">申请人部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="createdByDept" name="createdByDept"  value="<c:out  value='${assetsAccidentProcDTO.createdByDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" readonly="readonly" value="<c:out  value='${assetsAccidentProcDTO.createdByDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="createdByTel">申请人电话:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" readonly="readonly" value="<c:out value='${assetsAccidentProcDTO.createdByTel}'/>"/>
													   </td>
																		   									 									 									 									 									 									 																	 																									<th width="10%">
						    						  	<label for="formState">单据状态:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out value='${assetsAccidentProcDTO.formState}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						    <label for="assetsOperatorAlias">设备操作者:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="assetsOperator" name="assetsOperator"  value="<c:out  value='${assetsAccidentProcDTO.assetsOperator}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="assetsOperatorAlias" name="assetsOperatorAlias" readonly="readonly" value="<c:out  value='${assetsAccidentProcDTO.assetsOperatorAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="operatorDeptAlias">操作人单位:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="operatorDept" name="operatorDept"  value="<c:out  value='${assetsAccidentProcDTO.operatorDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="operatorDeptAlias" name="operatorDeptAlias" readonly="readonly" value="<c:out  value='${assetsAccidentProcDTO.operatorDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="unifiedId">统一编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" readonly="readonly" value="<c:out value='${assetsAccidentProcDTO.unifiedId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceName">设备名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out value='${assetsAccidentProcDTO.deviceName}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceModel">设备型号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" readonly="readonly" value="<c:out value='${assetsAccidentProcDTO.deviceModel}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceSpec">设备规格:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" readonly="readonly" value="<c:out value='${assetsAccidentProcDTO.deviceSpec}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="occurTime">事故发生时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="occurTime" id="occurTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsAccidentProcDTO.occurTime}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="reportLeaderTime">报告单位领导时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="reportLeaderTime" id="reportLeaderTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsAccidentProcDTO.reportLeaderTime}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="reportTime">报告时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="reportTime" id="reportTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsAccidentProcDTO.reportTime}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="accidentProcess">事故发生经过:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="accidentProcess" id="accidentProcess">${assetsAccidentProcDTO.accidentProcess}</textarea> 
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="accidentConsequence">事故后果:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="accidentConsequence" id="accidentConsequence">${assetsAccidentProcDTO.accidentConsequence}</textarea> 
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="reasonAnalysis">事故原因分析:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="reasonAnalysis" id="reasonAnalysis">${assetsAccidentProcDTO.reasonAnalysis}</textarea> 
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="preventionMeasures">防止事故措施:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="preventionMeasures" id="preventionMeasures">${assetsAccidentProcDTO.preventionMeasures}</textarea> 
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="repairTime">修复时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="repairTime" id="repairTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsAccidentProcDTO.repairTime}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="stopWorkDays">停工天数:</label></th>
						    							<td width="15%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="stopWorkDays" id="stopWorkDays" readonly="readonly" value="<c:out  value='${assetsAccidentProcDTO.stopWorkDays}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="directEconomicLoss">直接经济损失:</label></th>
						    							<td width="15%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="directEconomicLoss" id="directEconomicLoss" readonly="readonly" value="<c:out  value='${assetsAccidentProcDTO.directEconomicLoss}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="accidentProperty">事故性质:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="accidentProperty"  id="accidentProperty" readonly="readonly" value="<c:out value='${assetsAccidentProcDTO.accidentProperty}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="assetsManAlias">设备员:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="assetsMan" name="assetsMan"  value="<c:out  value='${assetsAccidentProcDTO.assetsMan}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="assetsManAlias" name="assetsManAlias" readonly="readonly" value="<c:out  value='${assetsAccidentProcDTO.assetsManAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
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
		formId: '${assetsAccidentProcDTO.id}',
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