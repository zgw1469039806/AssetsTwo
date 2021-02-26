<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form,fileupload";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_acceptanceDeviceComponent{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsUstdtempAcceptanceDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsUstdtempAcceptanceDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																									 <table class="form_commonTable">
				<tr>
																																											 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="acceptanceId">验收单号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="acceptanceId"  id="acceptanceId" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.acceptanceId}'/>"/>
																	   </td>
																								   													 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByDeptAlias">申请人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept" value="<c:out  value='${assetsUstdtempAcceptanceDTO.createdByDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" readonly="readonly" name="createdByDeptAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.createdByDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByTel">申请人电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.createdByTel}'/>"/>
																	   </td>
																								   													 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formState">单据状态:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.formState}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="contractNum">合同编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="contractNum"  id="contractNum" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.contractNum}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceName">设备名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.deviceName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="unifiedId">统一编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.unifiedId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="secretLevel">密级:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL" defaultValue='${assetsUstdtempAcceptanceDTO.secretLevel}' />
								    								   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="manufacturerId">生产厂家:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="manufacturerId"  id="manufacturerId" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.manufacturerId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="competentChiefEngineerAlias">主管总师:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="competentChiefEngineer" name="competentChiefEngineer" value="<c:out  value='${assetsUstdtempAcceptanceDTO.competentChiefEngineer}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="competentChiefEngineerAlias" readonly="readonly" name="competentChiefEngineerAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.competentChiefEngineerAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="ownerDeptAlias">责任人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="ownerDept" name="ownerDept" value="<c:out  value='${assetsUstdtempAcceptanceDTO.ownerDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" readonly="readonly" name="ownerDeptAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.ownerDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="ownerIdAlias">责任人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="ownerId" name="ownerId" value="<c:out  value='${assetsUstdtempAcceptanceDTO.ownerId}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" readonly="readonly" name="ownerIdAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.ownerIdAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ownerTel">责任人联系方式:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="ownerTel"  id="ownerTel" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.ownerTel}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="setsCount">台(套)数:</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="setsCount" id="setsCount" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.setsCount}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="unitPrice">单价(元):</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="unitPrice" id="unitPrice" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.unitPrice}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="projectDirectorAlias">项目主管:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="projectDirector" name="projectDirector" value="<c:out  value='${assetsUstdtempAcceptanceDTO.projectDirector}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" readonly="readonly" name="projectDirectorAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.projectDirectorAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceCategory">设备类别:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title="" isNull="true" lookupCode="DEVICE_CATEGORY" defaultValue='${assetsUstdtempAcceptanceDTO.deviceCategory}' />
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifRegularCheck">是否定检:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifRegularCheck" id="ifRegularCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifRegularCheck}' />
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifSpotCheck">是否点检:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifSpotCheck" id="ifSpotCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifSpotCheck}' />
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifPrecisionInspection">是否精度检查:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifPrecisionInspection" id="ifPrecisionInspection" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifPrecisionInspection}' />
								    								   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifUpkeep">是否保养:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifUpkeep" id="ifUpkeep" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifUpkeep}' />
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="upkeepCycle">保养周期(天):</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="upkeepCycle" id="upkeepCycle" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.upkeepCycle}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="upkeepRequirements">保养要求:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3" readonly="readonly"  name="upkeepRequirements" id="upkeepRequirements"><c:out  value='${assetsUstdtempAcceptanceDTO.upkeepRequirements}'/></textarea> 
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="nextUpkeepDate">下次保养时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="nextUpkeepDate" id="nextUpkeepDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsUstdtempAcceptanceDTO.nextUpkeepDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifMeasure">是否计量:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifMeasure" id="ifMeasure" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifMeasure}' />
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifInstall">是否需要安装:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifInstall" id="ifInstall" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifInstall}' />
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifMeasureOnsite">是否现场计量:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifMeasureOnsite" id="ifMeasureOnsite" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifMeasureOnsite}' />
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="measureIdentify">计量标识:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="measureIdentify"  id="measureIdentify" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.measureIdentify}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="measureByAlias">计量人员:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="measureBy" name="measureBy" value="<c:out  value='${assetsUstdtempAcceptanceDTO.measureBy}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="measureByAlias" readonly="readonly" name="measureByAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.measureByAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meteringDate">计量时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="meteringDate" id="meteringDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsUstdtempAcceptanceDTO.meteringDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meteringCycle">计量周期(天):</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="meteringCycle" id="meteringCycle" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.meteringCycle}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="positionId">安装地点:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="positionId"  id="positionId" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.positionId}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifHasComputer">是否含计算机/无线模板:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifHasComputer" id="ifHasComputer" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifHasComputer}' />
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isSafetyProduction">是否涉及安全生产:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.isSafetyProduction}' />
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="financialResources">经费来源:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources" title="" isNull="true" lookupCode="FINANCIAL_RESOURCES" defaultValue='${assetsUstdtempAcceptanceDTO.financialResources}' />
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="belongProject">所属项目:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="belongProject"  id="belongProject" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.belongProject}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="projectNo">项目序号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="projectNo"  id="projectNo" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.projectNo}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="replyName">批复名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="replyName"  id="replyName" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.replyName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="projectApprovalNo">立项单号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="projectApprovalNo"  id="projectApprovalNo" readonly="readonly" value="<c:out  value='${assetsUstdtempAcceptanceDTO.projectApprovalNo}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="abcCategory">ABC分类:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="abcCategory" id="abcCategory" title="" isNull="true" lookupCode="ABC_CATEGORY" defaultValue='${assetsUstdtempAcceptanceDTO.abcCategory}' />
								    								   </td>
																			</tr>
										<tr>
																								   													 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
								<table id="acceptanceDeviceComponent"></table>
							</th>
						</tr>
						<tr>
						    <th><label for="attachment">附件</label></th>
							<td colspan="<%=4 * 2 - 1%>">
								<div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
							</td>
						</tr>
					</table>
			</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/device/assetsustdtempacceptance/js/AcceptanceDeviceComponent.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     									     			     			     			     			     			     																															var acceptanceDeviceComponent;
	var acceptanceDeviceComponentGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 			 			 			 			 			 			 								 											   				   													,{ label: '主设备ID', name: 'deviceId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '主设备统一编号', name: 'parentUnifiedId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '组件名称', name: 'componentName', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '组件类别', name: 'componentCategory', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '组件型号', name: 'componentModel', width: 150,editable:false}
																		  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 	];
				$(document).ready(function () {
		    var pid = "${assetsUstdtempAcceptanceDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/operation/sub/";
			acceptanceDeviceComponent = new AcceptanceDeviceComponent('acceptanceDeviceComponent', surl,
					"formSub",
					acceptanceDeviceComponentGridColModel,
					'searchDialogSub', pid,searchSubNames, 'acceptanceDeviceComponent_keyWord',isReload);
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.assetsUstdtempAcceptance.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsUstdtempAcceptanceDTO.id}',
				allowAdd: false,
				allowDelete: false
			});
		});
		//form控件禁用
		setFormDisabled();
		$(document).keydown(function(event){  
			event.returnValue = false;
			return false;
		});  
	</script>
</body>
</html>