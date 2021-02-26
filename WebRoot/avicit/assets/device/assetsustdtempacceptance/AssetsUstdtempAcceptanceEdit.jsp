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
																		    <input class="form-control input-sm" type="text" name="acceptanceId"  id="acceptanceId" value="<c:out  value='${assetsUstdtempAcceptanceDTO.acceptanceId}'/>"/>
																	   </td>
																								   													 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByDeptAlias">申请人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept" value="<c:out  value='${assetsUstdtempAcceptanceDTO.createdByDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.createdByDeptAlias}'/>">
									      <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByTel">申请人电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" value="<c:out  value='${assetsUstdtempAcceptanceDTO.createdByTel}'/>"/>
																	   </td>
																								   													 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formState">单据状态:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formState"  id="formState" value="<c:out  value='${assetsUstdtempAcceptanceDTO.formState}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="contractNum">合同编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="contractNum"  id="contractNum" value="<c:out  value='${assetsUstdtempAcceptanceDTO.contractNum}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceName">设备名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" value="<c:out  value='${assetsUstdtempAcceptanceDTO.deviceName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="unifiedId">统一编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" value="<c:out  value='${assetsUstdtempAcceptanceDTO.unifiedId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="secretLevel">密级:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL" defaultValue='${assetsUstdtempAcceptanceDTO.secretLevel}'/>
								    								   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="manufacturerId">生产厂家:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="manufacturerId"  id="manufacturerId" value="<c:out  value='${assetsUstdtempAcceptanceDTO.manufacturerId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="competentChiefEngineerAlias">主管总师:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="competentChiefEngineer" name="competentChiefEngineer" value="<c:out  value='${assetsUstdtempAcceptanceDTO.competentChiefEngineer}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="competentChiefEngineerAlias" name="competentChiefEngineerAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.competentChiefEngineerAlias}'/>">
										       <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="ownerDeptAlias">责任人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="ownerDept" name="ownerDept" value="<c:out  value='${assetsUstdtempAcceptanceDTO.ownerDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.ownerDeptAlias}'/>">
									      <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="ownerIdAlias">责任人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="ownerId" name="ownerId" value="<c:out  value='${assetsUstdtempAcceptanceDTO.ownerId}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.ownerIdAlias}'/>">
										       <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ownerTel">责任人联系方式:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="ownerTel"  id="ownerTel" value="<c:out  value='${assetsUstdtempAcceptanceDTO.ownerTel}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="setsCount">台(套)数:</label></th>
								    									<td width="15%">
																		   									 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="setsCount" id="setsCount" value="<c:out  value='${assetsUstdtempAcceptanceDTO.setsCount}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
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
											  <input  class="form-control"  type="text" name="unitPrice" id="unitPrice" value="<c:out  value='${assetsUstdtempAcceptanceDTO.unitPrice}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
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
										      <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.projectDirectorAlias}'/>">
										       <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceCategory">设备类别:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title="" isNull="true" lookupCode="DEVICE_CATEGORY" defaultValue='${assetsUstdtempAcceptanceDTO.deviceCategory}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifRegularCheck">是否定检:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifRegularCheck" id="ifRegularCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifRegularCheck}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifSpotCheck">是否点检:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifSpotCheck" id="ifSpotCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifSpotCheck}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifPrecisionInspection">是否精度检查:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifPrecisionInspection" id="ifPrecisionInspection" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifPrecisionInspection}'/>
								    								   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifUpkeep">是否保养:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifUpkeep" id="ifUpkeep" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifUpkeep}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="upkeepCycle">保养周期(天):</label></th>
								    									<td width="15%">
																		   									 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="upkeepCycle" id="upkeepCycle" value="<c:out  value='${assetsUstdtempAcceptanceDTO.upkeepCycle}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="upkeepRequirements">保养要求:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3"   name="upkeepRequirements" id="upkeepRequirements"><c:out  value='${assetsUstdtempAcceptanceDTO.upkeepRequirements}'/></textarea> 
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="nextUpkeepDate">下次保养时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="nextUpkeepDate" id="nextUpkeepDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsUstdtempAcceptanceDTO.nextUpkeepDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifMeasure">是否计量:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifMeasure" id="ifMeasure" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifMeasure}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifInstall">是否需要安装:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifInstall" id="ifInstall" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifInstall}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifMeasureOnsite">是否现场计量:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifMeasureOnsite" id="ifMeasureOnsite" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifMeasureOnsite}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="measureIdentify">计量标识:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="measureIdentify"  id="measureIdentify" value="<c:out  value='${assetsUstdtempAcceptanceDTO.measureIdentify}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="measureByAlias">计量人员:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="measureBy" name="measureBy" value="<c:out  value='${assetsUstdtempAcceptanceDTO.measureBy}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="measureByAlias" name="measureByAlias" value="<c:out  value='${assetsUstdtempAcceptanceDTO.measureByAlias}'/>">
										       <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meteringDate">计量时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="meteringDate" id="meteringDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsUstdtempAcceptanceDTO.meteringDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meteringCycle">计量周期(天):</label></th>
								    									<td width="15%">
																		   									 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="meteringCycle" id="meteringCycle" value="<c:out  value='${assetsUstdtempAcceptanceDTO.meteringCycle}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="positionId">安装地点:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="positionId"  id="positionId" value="<c:out  value='${assetsUstdtempAcceptanceDTO.positionId}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="ifHasComputer">是否含计算机/无线模板:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="ifHasComputer" id="ifHasComputer" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.ifHasComputer}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isSafetyProduction">是否涉及安全生产:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempAcceptanceDTO.isSafetyProduction}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="financialResources">经费来源:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources" title="" isNull="true" lookupCode="FINANCIAL_RESOURCES" defaultValue='${assetsUstdtempAcceptanceDTO.financialResources}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="belongProject">所属项目:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="belongProject"  id="belongProject" value="<c:out  value='${assetsUstdtempAcceptanceDTO.belongProject}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="projectNo">项目序号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="projectNo"  id="projectNo" value="<c:out  value='${assetsUstdtempAcceptanceDTO.projectNo}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="replyName">批复名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="replyName"  id="replyName" value="<c:out  value='${assetsUstdtempAcceptanceDTO.replyName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="projectApprovalNo">立项单号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="projectApprovalNo"  id="projectApprovalNo" value="<c:out  value='${assetsUstdtempAcceptanceDTO.projectApprovalNo}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="abcCategory">ABC分类:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="abcCategory" id="abcCategory" title="" isNull="true" lookupCode="ABC_CATEGORY" defaultValue='${assetsUstdtempAcceptanceDTO.abcCategory}'/>
								    								   </td>
																			</tr>
										<tr>
																								   													 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
								<div id="toolbar_acceptanceDeviceComponent" class="toolbar">
									<div class="toolbar-left">
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_acceptanceDeviceComponent_button_add"
											permissionDes="添加">
											<a id="acceptanceDeviceComponent_insert" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="添加"><i class="fa fa-plus"></i> 添加</a>
										</sec:accesscontrollist>
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_acceptanceDeviceComponent_button_delete"
											permissionDes="删除">
											<a id="acceptanceDeviceComponent_del" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="删除"><i class="fa fa-trash-o"></i> 删除</a>
										</sec:accesscontrollist>
									</div>
								</div>
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
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="assetsUstdtempAcceptance_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsUstdtempAcceptance_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/device/assetsustdtempacceptance/js/AcceptanceDeviceComponent.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     									     			     			     			     			     			     																															var afterUploadEvent = null;
	var acceptanceDeviceComponent;
	var acceptanceDeviceComponentGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 			 			 			 			 			 			 								 											   				   													,{ label: '主设备ID', name: 'deviceId', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '主设备统一编号', name: 'parentUnifiedId', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '组件名称', name: 'componentName', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '组件类别', name: 'componentCategory', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '组件型号', name: 'componentModel', width: 150,editable:true}
																		  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 	];
			function closeForm(){
			parent.assetsUstdtempAcceptance.closeDialog(window.name);
		}
		function saveForm(){
			//主表表单校验
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            $(isValidate.errorList[0].element).focus();
	            return false;
	        }
	        //子表校验
			var msg = acceptanceDeviceComponent.valid();
			if(msg && msg != ""){
				layer.alert(msg, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
				return false;
			}
			//子表数据
			$(acceptanceDeviceComponent._datagridId).jqGrid('endEditCell');
		 	var dataSubVo = $(acceptanceDeviceComponent._datagridId).jqGrid('getRowData');	
			var dataSub = JSON.stringify(dataSubVo);
	        //验证附件密级
		   	var files = $('#attachment').uploaderExt('getUploadFiles');
		   	for(var i = 0; i < files.length; i++){
		   		var name = files[i].name;
		   		var secretLevel = files[i].secretLevel;
		   		//这里验证密级
		   	}
	       	//限制保存按钮多次点击
   			$('#assetsUstdtempAcceptance_saveForm').addClass('disabled').unbind("click"); 
		    parent.assetsUstdtempAcceptance.save($('#form'),window.name,dataSub);
		}
	
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
				beforeShow: function(selectedDate) {
					if($('#'+selectedDate.id).val()==""){
						$(this).datetimepicker("setDate", new Date());
						$('#'+selectedDate.id).val('');
					}
				}
			});
			
			parent.assetsUstdtempAcceptance.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsUstdtempAcceptanceDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
			});
			//保存按钮绑定事件
			$('#assetsUstdtempAcceptance_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#assetsUstdtempAcceptance_closeForm').bind('click', function(){
				closeForm();
			});
			//添加按钮绑定事件
			$('#acceptanceDeviceComponent_insert').bind('click', function() {
				acceptanceDeviceComponent.insert();
			});
			//删除按钮绑定事件
			$('#acceptanceDeviceComponent_del').bind('click', function() {
				acceptanceDeviceComponent.del();
			});
			
																																																	$('#createdByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'createdByDept',textFiled:'createdByDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																																																																																																																																																												$('#competentChiefEngineerAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'competentChiefEngineer',textFiled:'competentChiefEngineerAlias'});
					    this.blur();
					    nullInput(e);
					}); 
				
																								$('#ownerDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'ownerDept',textFiled:'ownerDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																								$('#ownerIdAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'ownerId',textFiled:'ownerIdAlias'});
					    this.blur();
					    nullInput(e);
					}); 
				
																																																																																	$('#projectDirectorAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'projectDirector',textFiled:'projectDirectorAlias'});
					    this.blur();
					    nullInput(e);
					}); 
				
																																																																																																																																																																																																																																																												$('#measureByAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'measureBy',textFiled:'measureByAlias'});
					    this.blur();
					    nullInput(e);
					}); 
				
																																																																																																																																																																																																																																																																																																																								
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>