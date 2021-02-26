<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
	String importlibs = "common,form,table,fileupload,tree";
	String pid = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/operation/toDetailJsp" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>详细</title>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 当前页 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/editForm.css">
<!-- 定制tab标签样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/avictabs.css">
<!-- 流程标签 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/workflow.css">
<!-- 时间轴 样式 -->
<link rel="stylesheet" type="text/css" href="static/h5/timeliner/css/timeliner.css">
<style type="text/css">
#t_attInventory{
   display:none;
}
</style>
</head>
<body>
	<div class="main">
		<!-- 右侧工具栏 Start -->
		<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttons.jsp"%>
		<!-- 右侧工具栏 End -->
		<!-- 正文内容 Start -->
		<div class="content">
			<!-- 简单tab Start -->
			<div class="avic-tab">
				<div class="tab-bar">
					<ul>
						<li class="on">表单信息</li>
						<li>流程跟踪</li>
						<li>引用文档</li>
						<li>关联流程</li>
					</ul>
				</div>
				<div class="btn-bar on">
					<!-- 暂存 关注 正文 等流程代理的按钮 -->
					<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttonBar.jsp" %>
				</div>
				<div class="tab-panel">
					<div class="panel-body on">
						<div class="panel-main">
					<!-- 业务表单 Start -->
					<form id='form'>
						<input type="hidden" name="id" />
						<input type="hidden" name="version"/>
						<table class="form_commonTable">
							<tr>
																																																							 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 																										 																			<th width="10%">
									    									  	<label for="acceptanceId">验收单号 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="acceptanceId"  id="acceptanceId" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="createdByPersion">申请人:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="createdByPersion"  id="createdByPersion" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="createdByDept">申请人部门:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="createdByDept"  id="createdByDept" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="formState">单据状态 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="formState"  id="formState" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="contractNum">合同号:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="contractNum"  id="contractNum" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="buyerDept">采购部门:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="buyerDept"  id="buyerDept" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="buyer">采购员:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="buyer"  id="buyer" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="stdId">申购单号:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="stdId"  id="stdId" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="chargePerson">责任人 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="chargePerson"  id="chargePerson" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="chargeDept">责任部门 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="chargeDept"  id="chargeDept" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="chargePersonTel">责任人联系方式 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="chargePersonTel"  id="chargePersonTel" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deviceName">设备名称:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="unifyId">统一编号:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="unifyId"  id="unifyId" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deviceType">设备类型 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="deviceType"  id="deviceType" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deviceCategory">设备类别:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="deviceCategory"  id="deviceCategory" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deviceModel">设备型号:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deviceSpec">设备规格:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="manufacturingNumber">出厂编号:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="manufacturingNumber"  id="manufacturingNumber" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="producingCountries">生产国家和地区:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="producingCountries"  id="producingCountries" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="productionManufacturer">生产厂家:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="productionManufacturer"  id="productionManufacturer" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deliveryTime">出厂时间:</label></th>
									    										<td width="39%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="deliveryTime" id="deliveryTime" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="contractSupplier">供应商:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="contractSupplier"  id="contractSupplier" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="unitPrice">采购单价 :</label></th>
									    										<td width="39%">
																				  												     													<div class="input-group input-group-sm spinner" data-trigger="spinner">
													  <input  class="form-control"  type="text" name="unitPrice" id="unitPrice"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
													  <span class="input-group-addon">
													    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
													    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
													  </span>
													</div>	
																							  																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="totalPrice">采购金额:</label></th>
									    										<td width="39%">
																				  												     													<div class="input-group input-group-sm spinner" data-trigger="spinner">
													  <input  class="form-control"  type="text" name="totalPrice" id="totalPrice"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
													  <span class="input-group-addon">
													    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
													    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
													  </span>
													</div>	
																							  																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isAccuracyCheck">是否精度检查:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="isAccuracyCheck"  id="isAccuracyCheck" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isRegularCheck">是否定检:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="isRegularCheck"  id="isRegularCheck" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isInstall">是否安装:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="isInstall"  id="isInstall" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="employUser">使用人 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="employUser"  id="employUser" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="employDept">使用人部门 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="employDept"  id="employDept" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="measuringTag">计量标识:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="measuringTag"  id="measuringTag" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="measuringUser">计量人员:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="measuringUser"  id="measuringUser" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="planMeasuring">计量计划员:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="planMeasuring"  id="planMeasuring" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="measuringTime">计量时间:</label></th>
									    										<td width="39%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="measuringTime" id="measuringTime" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="measuringPeriod">计量周期:</label></th>
									    										<td width="39%">
																				  												     													<div class="input-group input-group-sm spinner" data-trigger="spinner">
													  <input  class="form-control"  type="text" name="measuringPeriod" id="measuringPeriod"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
													  <span class="input-group-addon">
													    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
													    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
													  </span>
													</div>	
																							  																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isMeasuring">是否计量:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="isMeasuring"  id="isMeasuring" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isSceneMeasuring">是否现场计量:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="isSceneMeasuring"  id="isSceneMeasuring" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isSpotCheck">是否点检:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="isSpotCheck"  id="isSpotCheck" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isPc">是否是计算机:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="isPc"  id="isPc" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="secretLevel">密级 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="secretLevel"  id="secretLevel" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isSafetyProduction">是否涉及安全生产:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="isSafetyProduction"  id="isSafetyProduction" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isMaintain">是否保养:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="isMaintain"  id="isMaintain" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="accuracyCheckResult">精度检查结果 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="accuracyCheckResult"  id="accuracyCheckResult" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="maintainResult">保养结果 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="maintainResult"  id="maintainResult" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="installResult">安装结果 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="installResult"  id="installResult" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="qualityResult">质量审查结果 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="qualityResult"  id="qualityResult" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="abarbeitungResult">整改结果 :</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="abarbeitungResult"  id="abarbeitungResult" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="createdByTel">联系电话:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="fid">申购父ID:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="fid"  id="fid" />
																			   </td>
																					</tr>
											<tr>
																																													   															 									</tr>
									<tr>
										<th width="99%" colspan="<%=2 * 2 %>">
											<div id="toolbar_AttInventory" class="toolbar">
												<div class="toolbar-left">
													<sec:accesscontrollist hasPermission="3"
														domainObject="formdialog_AttInventory_button_add"
														permissionDes="添加">
														<a id="attInventory_insert" href="javascript:void(0)"
															class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button"
															title="添加"><i class="fa fa-plus"></i> 添加</a>
													</sec:accesscontrollist>
													<sec:accesscontrollist hasPermission="3"
														domainObject="formdialog_AttInventory_button_delete"
														permissionDes="删除">
														<a id="attInventory_del" href="javascript:void(0)"
															class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button"
															title="删除"><i class="fa fa-trash-o"></i> 删除</a>
													</sec:accesscontrollist>
														<a class="btn btn-default form-tool-btn btn-sm bpm_self_class" style="display:none" title="子表数据是否可编辑" name="attInventory_editable" id="attInventory_editable" >是否可编辑</a>
												</div>
											</div>
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
							<!-- 业务表单 End -->
					   </div>
				 </div>
				 <div class="panel-body">
					 <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/tracks.jsp"%>
				 </div>
				 <div class="panel-body">
					 <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/files.jsp"%>
				 </div>
				 <div class="panel-body">
					<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/processlevel.jsp"%>
				</div>
	  		 </div>
	 	 </div>
		 <!-- 简单tab End -->
   	  </div>
   	  <!-- 正文内容 End -->
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<!-- 页面脚本 avictabs.js-->
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/avictabs.js"></script>
	<!-- 时间轴组件 timeliner.js-->
	<script type="text/javascript" src="static/h5/timeliner/js/timeliner.js"></script>
	<!-- 页面脚本 editForm.js-->
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/editForm.js"></script>
	<!-- 流程的js -->
	<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowEditor.js"></script>
	<!-- 业务的js -->
	<script type="text/javascript" src="avicit/assets/device/assetsstdtempacceptance/js/AssetsStdtempAcceptanceDetail.js"></script>
	<script type="text/javascript" src="avicit/assets/device/assetsstdtempacceptance/js/AttInventory.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     			     					     							     			     			     	  //初始化通用代码值
  function initOnceInAdd(){
		avicAjax.ajax({
			 url:"platform/assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/getLookUpCode",
			 type : 'post',
			 dataType : 'json',
			 async:false,
			 success : function(r){
				 if (r.flag == "success"){
				     																		 							 					    																		 					    																		 					    																																								 					    																																																														 					    																		 					    																		 					    																				 }else{
					 layer.alert('获取失败！' + r.error,{
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0,
						  btn: ['关闭'],
				          title:"提示"
					    }
			         );
				 } 
			 }
		 });
    };
    
	var afterUploadEvent = null;
	var attInventoryGridColModel = null;
			$(document).ready(function () {
		    var pid = "<%=pid%>";
			var isReload = "true";
			var searchSubNames = "";
			initOnceInAdd(); //初始化通用代码值
			attInventoryGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   				   													,{ label: 'DEVICE_MODEL', name: 'deviceModel', width: 150}
																		  		   			 											   				   													,{ label: 'DEVICE_NAME', name: 'deviceName', width: 150}
																		  		   			 			 			 											   				   													,{ label: 'DEVICE_CATEGORY', name: 'deviceCategory', width: 150}
																		  		   			 			 			 			 			 											   				   													,{ label: 'DEVICE_SPEC', name: 'deviceSpec', width: 150}
																		  		   			 											   				   													,{ label: 'DEVICE_NUM', name: 'deviceNum', width: 150}
																		  		   			 								 			 	];
			var surl = "platform/assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/operation/sub/";
			var attInventory = new AttInventory('attInventory', surl,
					"formSub",
					attInventoryGridColModel,
					'searchDialogSub', pid,searchSubNames, 'attInventory_keyWord',isReload);
			//创建业务操作JS
			var assetsStdtempAcceptanceDetail = new AssetsStdtempAcceptanceDetail('form',attInventory);
			//创建流程操作JS
			new FlowEditor(assetsStdtempAcceptanceDetail);
			
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
			$('.date-picker').datepicker({yearRange:"c-100:c+10"}); //时间控件增加年度选择
			
			//绑定表单验证规则
			assetsStdtempAcceptanceDetail.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
				formId: '<%=pid%>',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
			});
			//添加按钮绑定事件
			$('#attInventory_insert').bind('click', function() {
				attInventory.insert();
			});
			//删除按钮绑定事件
			$('#attInventory_del').bind('click', function() {
				attInventory.del();
			});
			
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																														
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>