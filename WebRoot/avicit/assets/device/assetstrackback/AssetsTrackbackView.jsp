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
<!-- ControllerPath = "assets/device/assetstrackback/assetsTrackbackController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
										   				<input type="hidden" name="id" value="<c:out  value='${assetsTrackbackDTO.id}'/>" />		    
			   		    								   		    																																																																																																																																																																																																																																																									<table class="form_commonTable">
				 <tr>
																																		 									 									 									 									 									 									 																	 																									<th width="10%">
						    						  	<label for="meteringId">关联计量单号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="meteringId"  id="meteringId" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.meteringId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="applicantIdAlias">申请人ID:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="applicantId" name="applicantId"  value="<c:out  value='${assetsTrackbackDTO.applicantId}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="applicantIdAlias" name="applicantIdAlias" readonly="readonly" value="<c:out  value='${assetsTrackbackDTO.applicantIdAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="applicantDepartAlias">APPLICANT_DEPART:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="applicantDepart" name="applicantDepart"  value="<c:out  value='${assetsTrackbackDTO.applicantDepart}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="applicantDepartAlias" name="applicantDepartAlias" readonly="readonly" value="<c:out  value='${assetsTrackbackDTO.applicantDepartAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="deviceUserIdAlias">DEVICE_USER_ID:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="deviceUserId" name="deviceUserId"  value="<c:out  value='${assetsTrackbackDTO.deviceUserId}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="deviceUserIdAlias" name="deviceUserIdAlias" readonly="readonly" value="<c:out  value='${assetsTrackbackDTO.deviceUserIdAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						    <label for="deviceUserDeptAlias">DEVICE_USER_DEPT:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="deviceUserDept" name="deviceUserDept"  value="<c:out  value='${assetsTrackbackDTO.deviceUserDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="deviceUserDeptAlias" name="deviceUserDeptAlias" readonly="readonly" value="<c:out  value='${assetsTrackbackDTO.deviceUserDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="formState">表单状态:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.formState}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="unifiedId">统一编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.unifiedId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceName">设备名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.deviceName}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceCategory">设备类别:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title="" isNull="true" lookupCode="DEVICE_CATEGORY" defaultValue='${assetsTrackbackDTO.deviceCategory}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceSpec">DEVICE_SPEC:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.deviceSpec}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceModel">DEVICE_MODEL:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.deviceModel}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="manufacturerId">MANUFACTURER_ID:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="manufacturerId"  id="manufacturerId" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.manufacturerId}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="lastMeteringDate">LAST_METERING_DATE:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="lastMeteringDate" id="lastMeteringDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsTrackbackDTO.lastMeteringDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="meterPersonAlias">METER_PERSON:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="meterPerson" name="meterPerson"  value="<c:out  value='${assetsTrackbackDTO.meterPerson}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="meterPersonAlias" name="meterPersonAlias" readonly="readonly" value="<c:out  value='${assetsTrackbackDTO.meterPersonAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="meterConclusion">METER_CONCLUSION:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="meterConclusion" id="meterConclusion" title="" isNull="true" lookupCode="METERING_CONCLUTION" defaultValue='${assetsTrackbackDTO.meterConclusion}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceMetrics">DEVICE_METRICS:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceMetrics"  id="deviceMetrics" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.deviceMetrics}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="calibrationResult">CALIBRATION_RESULT:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="calibrationResult"  id="calibrationResult" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.calibrationResult}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="effectAnalyse">EFFECT_ANALYSE:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="effectAnalyse"  id="effectAnalyse" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.effectAnalyse}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="qualitySafeOpinion">QUALITY_SAFE_OPINION:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="qualitySafeOpinion"  id="qualitySafeOpinion" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.qualitySafeOpinion}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="chiefOpinion">CHIEF_OPINION:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="chiefOpinion"  id="chiefOpinion" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.chiefOpinion}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 																	 																									<th width="10%">
						    						  	<label for="procId">超差追溯单编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="procId"  id="procId" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.procId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="data24">字段_24:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="data24"  id="data24" readonly="readonly" value="<c:out value='${assetsTrackbackDTO.data24}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="hasEffection">对产品是否有影响:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="hasEffection" id="hasEffection" title="" isNull="true" lookupCode="HAS_EFFECTION" defaultValue='${assetsTrackbackDTO.hasEffection}'/>
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
		formId: '${assetsTrackbackDTO.id}',
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