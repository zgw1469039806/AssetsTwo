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
<!-- ControllerPath = "assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_attInventory{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsStdtempAcceptanceDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsStdtempAcceptanceDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="acceptanceId">验收单号 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="acceptanceId"  id="acceptanceId" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.acceptanceId}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByPersion">申请人:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="createdByPersion"  id="createdByPersion" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.createdByPersion}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByDept">申请人部门:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="createdByDept"  id="createdByDept" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.createdByDept}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formState">单据状态 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.formState}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="contractNum">合同号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="contractNum"  id="contractNum" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.contractNum}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="buyerDept">采购部门:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="buyerDept"  id="buyerDept" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.buyerDept}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="buyer">采购员:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="buyer"  id="buyer" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.buyer}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="stdId">申购单号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="stdId"  id="stdId" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.stdId}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="chargePerson">责任人 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="chargePerson"  id="chargePerson" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.chargePerson}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="chargeDept">责任部门 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="chargeDept"  id="chargeDept" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.chargeDept}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="chargePersonTel">责任人联系方式 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="chargePersonTel"  id="chargePersonTel" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.chargePersonTel}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceName">设备名称:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.deviceName}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="unifyId">统一编号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="unifyId"  id="unifyId" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.unifyId}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceType">设备类型 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="deviceType"  id="deviceType" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.deviceType}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceCategory">设备类别:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="deviceCategory"  id="deviceCategory" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.deviceCategory}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceModel">设备型号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.deviceModel}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceSpec">设备规格:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.deviceSpec}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="manufacturingNumber">出厂编号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="manufacturingNumber"  id="manufacturingNumber" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.manufacturingNumber}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="producingCountries">生产国家和地区:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="producingCountries"  id="producingCountries" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.producingCountries}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="productionManufacturer">生产厂家:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="productionManufacturer"  id="productionManufacturer" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.productionManufacturer}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deliveryTime">出厂时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="deliveryTime" id="deliveryTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsStdtempAcceptanceDTO.deliveryTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="contractSupplier">供应商:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="contractSupplier"  id="contractSupplier" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.contractSupplier}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="unitPrice">采购单价 :</label></th>
								    									<td width="39%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="unitPrice" id="unitPrice" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.unitPrice}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="totalPrice">采购金额:</label></th>
								    									<td width="39%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="totalPrice" id="totalPrice" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.totalPrice}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isAccuracyCheck">是否精度检查:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="isAccuracyCheck"  id="isAccuracyCheck" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.isAccuracyCheck}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isRegularCheck">是否定检:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="isRegularCheck"  id="isRegularCheck" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.isRegularCheck}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isInstall">是否安装:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="isInstall"  id="isInstall" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.isInstall}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="employUser">使用人 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="employUser"  id="employUser" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.employUser}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="employDept">使用人部门 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="employDept"  id="employDept" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.employDept}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="measuringTag">计量标识:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="measuringTag"  id="measuringTag" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.measuringTag}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="measuringUser">计量人员:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="measuringUser"  id="measuringUser" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.measuringUser}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="planMeasuring">计量计划员:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="planMeasuring"  id="planMeasuring" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.planMeasuring}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="measuringTime">计量时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="measuringTime" id="measuringTime" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsStdtempAcceptanceDTO.measuringTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="measuringPeriod">计量周期:</label></th>
								    									<td width="39%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="measuringPeriod" id="measuringPeriod" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.measuringPeriod}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isMeasuring">是否计量:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="isMeasuring"  id="isMeasuring" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.isMeasuring}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isSceneMeasuring">是否现场计量:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="isSceneMeasuring"  id="isSceneMeasuring" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.isSceneMeasuring}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isSpotCheck">是否点检:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="isSpotCheck"  id="isSpotCheck" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.isSpotCheck}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isPc">是否是计算机:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="isPc"  id="isPc" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.isPc}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="secretLevel">密级 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="secretLevel"  id="secretLevel" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.secretLevel}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isSafetyProduction">是否涉及安全生产:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="isSafetyProduction"  id="isSafetyProduction" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.isSafetyProduction}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="isMaintain">是否保养:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="isMaintain"  id="isMaintain" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.isMaintain}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="accuracyCheckResult">精度检查结果 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="accuracyCheckResult"  id="accuracyCheckResult" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.accuracyCheckResult}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="maintainResult">保养结果 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="maintainResult"  id="maintainResult" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.maintainResult}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="installResult">安装结果 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="installResult"  id="installResult" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.installResult}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="qualityResult">质量审查结果 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="qualityResult"  id="qualityResult" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.qualityResult}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="abarbeitungResult">整改结果 :</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="abarbeitungResult"  id="abarbeitungResult" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.abarbeitungResult}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByTel">联系电话:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.createdByTel}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="fid">申购父ID:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="fid"  id="fid" readonly="readonly" value="<c:out  value='${assetsStdtempAcceptanceDTO.fid}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 						</tr>
						<tr>
							<th width="99%" colspan="<%=2 * 2 %>">
								<table id="attInventory"></table>
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
	<script type="text/javascript" src="avicit/assets/device/assetsstdtempacceptance/js/AttInventory.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     			     					     							     			     			     		var attInventory;
	var attInventoryGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   				   													,{ label: 'DEVICE_MODEL', name: 'deviceModel', width: 150,editable:false}
																		  		   			 											   				   													,{ label: 'DEVICE_NAME', name: 'deviceName', width: 150,editable:false}
																		  		   			 			 			 											   				   													,{ label: 'DEVICE_CATEGORY', name: 'deviceCategory', width: 150,editable:false}
																		  		   			 			 			 			 			 											   				   													,{ label: 'DEVICE_SPEC', name: 'deviceSpec', width: 150,editable:false}
																		  		   			 											   				   													,{ label: 'DEVICE_NUM', name: 'deviceNum', width: 150,editable:false}
																		  		   			 								 			 	];
				$(document).ready(function () {
		    var pid = "${assetsStdtempAcceptanceDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/operation/sub/";
			attInventory = new AttInventory('attInventory', surl,
					"formSub",
					attInventoryGridColModel,
					'searchDialogSub', pid,searchSubNames, 'attInventory_keyWord',isReload);
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.assetsStdtempAcceptance.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsStdtempAcceptanceDTO.id}',
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