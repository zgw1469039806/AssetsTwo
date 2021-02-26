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
<!-- ControllerPath = "assets/device/assetsreconacceptance/assetsReconAcceptanceController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
										   				<input type="hidden" name="id" value="<c:out  value='${assetsReconAcceptanceDTO.id}'/>" />		    
			   		    								   		    																																																																																																																																																																																																																																																																																																																																																																																																					<table class="form_commonTable">
				 <tr>
																																		 																	 																									<th width="10%">
						    						  	<label for="acceptanceNo">验收单号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="acceptanceNo"  id="acceptanceNo" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.acceptanceNo}'/>"/>
													   </td>
																		   									 									 																	 																									<th width="10%">
						    						    <label for="createdByDeptAlias">创建人部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="createdByDept" name="createdByDept"  value="<c:out  value='${assetsReconAcceptanceDTO.createdByDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.createdByDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 									 									 									 									 									 																	 																									<th width="10%">
						    						  	<label for="formState">单据状态:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.formState}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="applyByAlias">申请人:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="applyBy" name="applyBy"  value="<c:out  value='${assetsReconAcceptanceDTO.applyBy}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="applyByAlias" name="applyByAlias" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.applyByAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						    <label for="applyByDeptAlias">申请人部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="applyByDept" name="applyByDept"  value="<c:out  value='${assetsReconAcceptanceDTO.applyByDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="applyByDeptAlias" name="applyByDeptAlias" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.applyByDeptAlias}'/>">
							      <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
						        </div>
						     						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="reconstructionNo">申购单号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="reconstructionNo"  id="reconstructionNo" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.reconstructionNo}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceName">设备名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.deviceName}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="unifiedId">统一编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.unifiedId}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="secretLevel">密级:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL" defaultValue='${assetsReconAcceptanceDTO.secretLevel}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="manufacturerId">生产厂家:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="manufacturerId"  id="manufacturerId" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.manufacturerId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="competentChiefEngineerAlias">主管总师:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="competentChiefEngineer" name="competentChiefEngineer"  value="<c:out  value='${assetsReconAcceptanceDTO.competentChiefEngineer}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="competentChiefEngineerAlias" name="competentChiefEngineerAlias" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.competentChiefEngineerAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="ownerDeptAlias">责任人部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="ownerDept" name="ownerDept"  value="<c:out  value='${assetsReconAcceptanceDTO.ownerDept}'/>">
							      <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.ownerDeptAlias}'/>">
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
							   	  <input type="hidden"  id="ownerId" name="ownerId"  value="<c:out  value='${assetsReconAcceptanceDTO.ownerId}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.ownerIdAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="ownerTel">责任人联系方式:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="ownerTel"  id="ownerTel" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.ownerTel}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="setsCount">台(套)数:</label></th>
						    							<td width="15%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="setsCount" id="setsCount" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.setsCount}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="unitPrice">单价(元):</label></th>
						    							<td width="15%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="unitPrice" id="unitPrice" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.unitPrice}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						    <label for="projectDirectorAlias">项目主管:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="projectDirector" name="projectDirector"  value="<c:out  value='${assetsReconAcceptanceDTO.projectDirector}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.projectDirectorAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="deviceCategory">设备类别:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="deviceCategory"  id="deviceCategory" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.deviceCategory}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="ifRegularCheck">是否定检:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="ifRegularCheck" id="ifRegularCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsReconAcceptanceDTO.ifRegularCheck}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="ifSpotCheck">是否点检:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="ifSpotCheck" id="ifSpotCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsReconAcceptanceDTO.ifSpotCheck}'/>
						    						   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="ifPrecisionInspection">是否精度检查:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="ifPrecisionInspection" id="ifPrecisionInspection" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsReconAcceptanceDTO.ifPrecisionInspection}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="ifUpkeep">是否保养:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="ifUpkeep" id="ifUpkeep" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsReconAcceptanceDTO.ifUpkeep}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="upkeepCycle">保养周期(天):</label></th>
						    							<td width="15%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="upkeepCycle" id="upkeepCycle" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.upkeepCycle}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="upkeepRequirements">保养要求:</label></th>
						    							<td width="15%">
														    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="upkeepRequirements" id="upkeepRequirements">${assetsReconAcceptanceDTO.upkeepRequirements}</textarea> 
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="nextUpkeepDate">下次保养时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="nextUpkeepDate" id="nextUpkeepDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsReconAcceptanceDTO.nextUpkeepDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="ifMeasure">是否计量:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="ifMeasure" id="ifMeasure" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsReconAcceptanceDTO.ifMeasure}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="ifInstall">是否需要安装:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="ifInstall" id="ifInstall" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsReconAcceptanceDTO.ifInstall}'/>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="ifMeasureOnsite">是否现场计量:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="ifMeasureOnsite" id="ifMeasureOnsite" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsReconAcceptanceDTO.ifMeasureOnsite}'/>
						    						   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="measureIdentify">计量标识:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="measureIdentify"  id="measureIdentify" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.measureIdentify}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="measureByAlias">计量人员:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="measureBy" name="measureBy"  value="<c:out  value='${assetsReconAcceptanceDTO.measureBy}'/>">
							      <input class="form-control" placeholder="请选择用户" type="text" id="measureByAlias" name="measureByAlias" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.measureByAlias}'/>">
							      <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="meteringDate">计量时间:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="meteringDate" id="meteringDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${assetsReconAcceptanceDTO.meteringDate}"/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="meteringCycle">计量周期(天):</label></th>
						    							<td width="15%">
														  									 									 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="meteringCycle" id="meteringCycle" readonly="readonly" value="<c:out  value='${assetsReconAcceptanceDTO.meteringCycle}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
																	 													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="positionId">安装地点:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="positionId"  id="positionId" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.positionId}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="ifHasComputer">是否含计算机/无线模板:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="ifHasComputer"  id="ifHasComputer" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.ifHasComputer}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="isSafetyProduction">是否涉及安全生产:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="isSafetyProduction"  id="isSafetyProduction" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.isSafetyProduction}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="financialResources">经费来源:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources" title="" isNull="true" lookupCode="FINANCIAL_RESOURCES" defaultValue='${assetsReconAcceptanceDTO.financialResources}'/>
						    						   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="belongProject">所属项目:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="belongProject"  id="belongProject" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.belongProject}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="projectNo">项目序号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="projectNo"  id="projectNo" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.projectNo}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="replyName">批复名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="replyName"  id="replyName" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.replyName}'/>"/>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="projectApprovalNo">立项单号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="projectApprovalNo"  id="projectApprovalNo" readonly="readonly" value="<c:out value='${assetsReconAcceptanceDTO.projectApprovalNo}'/>"/>
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="abcCategory">ABC分类:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="abcCategory" id="abcCategory" title="" isNull="true" lookupCode="ABC_CATEGORY" defaultValue='${assetsReconAcceptanceDTO.abcCategory}'/>
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
		formId: '${assetsReconAcceptanceDTO.id}',
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