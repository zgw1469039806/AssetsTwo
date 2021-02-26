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
<!-- ControllerPath = "assets/device/assetsdevicemetering/assetsDeviceMeteringController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_dynDeviceTool{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsDeviceMeteringDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsDeviceMeteringDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																											 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="applicantIdAlias">申请人ID:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="applicantId" name="applicantId" value="<c:out  value='${assetsDeviceMeteringDTO.applicantId}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="applicantIdAlias" name="applicantIdAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.applicantIdAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="applicantDepartAlias">申请人部门:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="applicantDepart" name="applicantDepart" value="<c:out  value='${assetsDeviceMeteringDTO.applicantDepart}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="applicantDepartAlias" name="applicantDepartAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.applicantDepartAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="ownerIdAlias">责任人:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="ownerId" name="ownerId" value="<c:out  value='${assetsDeviceMeteringDTO.ownerId}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.ownerIdAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="ownerDeptAlias">责任人部门:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="ownerDept" name="ownerDept" value="<c:out  value='${assetsDeviceMeteringDTO.ownerDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.ownerDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="senddevicePidAlias">送检人ID:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="senddevicePid" name="senddevicePid" value="<c:out  value='${assetsDeviceMeteringDTO.senddevicePid}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="senddevicePidAlias" name="senddevicePidAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.senddevicePidAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="senddeviceDeptAlias">送检人部门:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="senddeviceDept" name="senddeviceDept" value="<c:out  value='${assetsDeviceMeteringDTO.senddeviceDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="senddeviceDeptAlias" name="senddeviceDeptAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.senddeviceDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="takedevicePidAlias">取走人ID:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="takedevicePid" name="takedevicePid" value="<c:out  value='${assetsDeviceMeteringDTO.takedevicePid}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="takedevicePidAlias" name="takedevicePidAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.takedevicePidAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="takedeviceDeptAlias">取走人部门:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="takedeviceDept" name="takedeviceDept" value="<c:out  value='${assetsDeviceMeteringDTO.takedeviceDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="takedeviceDeptAlias" name="takedeviceDeptAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.takedeviceDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="deliveryPidAlias">外送员ID:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="deliveryPid" name="deliveryPid" value="<c:out  value='${assetsDeviceMeteringDTO.deliveryPid}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="deliveryPidAlias" name="deliveryPidAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.deliveryPidAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="deliveryDeptAlias">外送员部门:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="deliveryDept" name="deliveryDept" value="<c:out  value='${assetsDeviceMeteringDTO.deliveryDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="deliveryDeptAlias" name="deliveryDeptAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.deliveryDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formState">表单状态:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.formState}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="unifiedId">统一编号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.unifiedId}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceName">设备名称:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.deviceName}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceCategory">设备类别:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="deviceCategory"  id="deviceCategory" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.deviceCategory}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceSpec">设备规格:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.deviceSpec}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceModel">设备型号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.deviceModel}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="secretLevel">密级:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL" defaultValue='${assetsDeviceMeteringDTO.secretLevel}'/>
								    								   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="positionId">安装地点ID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="positionId"  id="positionId" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.positionId}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="manufacturer">生产厂家:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="manufacturer"  id="manufacturer" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.manufacturer}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isMetering">是否计量:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsDeviceMeteringDTO.isMetering}'/>
								    								   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meterMode">计量方式:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="meterMode" id="meterMode" title="" isNull="true" lookupCode="METERING_MODE" defaultValue='${assetsDeviceMeteringDTO.meterMode}'/>
								    								   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meterFinishDate">计量完成时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="meterFinishDate" id="meterFinishDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceMeteringDTO.meterFinishDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meterCycle">计量周期:</label></th>
								    									<td width="39%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="meterCycle" id="meterCycle" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.meterCycle}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lastMeteringDate">上次计量时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="lastMeteringDate" id="lastMeteringDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceMeteringDTO.lastMeteringDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="meterPersonAlias">计量员:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="meterPerson" name="meterPerson" value="<c:out  value='${assetsDeviceMeteringDTO.meterPerson}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="meterPersonAlias" name="meterPersonAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.meterPersonAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="meterPlanPersonAlias">计量计划员:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="meterPlanPerson" name="meterPlanPerson" value="<c:out  value='${assetsDeviceMeteringDTO.meterPlanPerson}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="meterPlanPersonAlias" name="meterPlanPersonAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.meterPlanPersonAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="meterTakeawayPersonAlias">外送员:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="meterTakeawayPerson" name="meterTakeawayPerson" value="<c:out  value='${assetsDeviceMeteringDTO.meterTakeawayPerson}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="meterTakeawayPersonAlias" name="meterTakeawayPersonAlias" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.meterTakeawayPersonAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meterConclusion">计量结论:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="meterConclusion" id="meterConclusion" title="" isNull="true" lookupCode="METERING_CONCLUTION" defaultValue='${assetsDeviceMeteringDTO.meterConclusion}'/>
								    								   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isDeriveOft">是否派生超差追溯:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="isDeriveOft" id="isDeriveOft" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsDeviceMeteringDTO.isDeriveOft}'/>
								    								   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="expressNumber">快递单号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="expressNumber"  id="expressNumber" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.expressNumber}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deliveryDate">预送检日期:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="deliveryDate" id="deliveryDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceMeteringDTO.deliveryDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="procedureFileId">计量文件受控号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="procedureFileId"  id="procedureFileId" readonly="readonly" value="<c:out  value='${assetsDeviceMeteringDTO.procedureFileId}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meteringOrigin">计量任务来源:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="meteringOrigin" id="meteringOrigin" title="" isNull="true" lookupCode="METERING_ORIGIN_TYPE" defaultValue='${assetsDeviceMeteringDTO.meteringOrigin}'/>
								    								   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isDeliveryAllowed">是否允许外送检:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="isDeliveryAllowed" id="isDeliveryAllowed" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsDeviceMeteringDTO.isDeliveryAllowed}'/>
								    								   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formCheckConclude">形式审核结论:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="formCheckConclude" id="formCheckConclude" title="" isNull="true" lookupCode="conclusion" defaultValue='${assetsDeviceMeteringDTO.formCheckConclude}'/>
								    								   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="managerConclude">计量室主任审核结论:</label></th>
								    									<td width="39%">
																			<pt6:h5select css_class="form-control input-sm" name="managerConclude" id="managerConclude" title="" isNull="true" lookupCode="conclusion" defaultValue='${assetsDeviceMeteringDTO.managerConclude}'/>
								    								   </td>
																			</tr>
										<tr>
																																								   													 						</tr>
						<tr>
							<th width="99%" colspan="<%=2 * 2 %>">
								<table id="dynDeviceTool"></table>
							</th>
						</tr>
						<tr>
						    <th><label for="attachment">附件</label></th>
							<td colspan="<%=2 * 2 - 1%>">
								<div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
							</td>
						</tr>
					</table>
			</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/device/assetsdevicemetering/js/DynDeviceTool.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     					     			     				     			     				     			     				     					     	var dynDeviceTool;
	var dynDeviceToolGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 			 			 											   				   													,{ label: '计量文件规范号', name: 'procedureFile', width: 150,editable:false}
																		  		   			 								 			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '生产厂家', name: 'manufacturerId', width: 150,editable:false}
																		  		   			 			 											   				   													,{ label: '统一编号', name: 'unifiedId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备类别', name: 'deviceCategory', width: 150,editable:false}
																		  		   			 			 											   				   													,{ label: '设备规格', name: 'deviceSpec', width: 150,editable:false}
																		  		   			 			 			 											   				   													,{ label: '设备型号', name: 'deviceModel', width: 150,editable:false}
																		  		   			 	];
				$(document).ready(function () {
		    var pid = "${assetsDeviceMeteringDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/device/assetsdevicemetering/assetsDeviceMeteringController/operation/sub/";
			dynDeviceTool = new DynDeviceTool('dynDeviceTool', surl,
					"formSub",
					dynDeviceToolGridColModel,
					'searchDialogSub', pid,searchSubNames, 'dynDeviceTool_keyWord',isReload);
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.assetsDeviceMetering.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsDeviceMeteringDTO.id}',
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