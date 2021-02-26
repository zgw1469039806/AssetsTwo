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
<!-- ControllerPath = "assets/device/assetsdevicemetering/assetsDeviceMeteringController/operation/toDetailJsp" -->
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
#t_dynDeviceTool{
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
						<input type="hidden" name="id" id="id"/>
						<input type="hidden" name="version" id="version"/>
						<table class="form_commonTable">
							<tr>
																																																							 															 															 															 															 															 															 																										 																			<th width="10%">
									    									    <label for="applicantIdAlias">申请人ID:</label></th>
									    										<td width="39%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="applicantId" name="applicantId">
										      <input class="form-control" placeholder="请选择用户" type="text" id="applicantIdAlias" name="applicantIdAlias">
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									    <label for="applicantDepartAlias">申请人部门:</label></th>
									    										<td width="39%">
																				    <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="applicantDepart" name="applicantDepart">
										      <input class="form-control" placeholder="请选择部门" type="text" id="applicantDepartAlias" name="applicantDepartAlias" >
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
									        </div>
									    									   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									    <label for="ownerIdAlias">责任人:</label></th>
									    										<td width="39%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="ownerId" name="ownerId">
										      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias">
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									    <label for="ownerDeptAlias">责任人部门:</label></th>
									    										<td width="39%">
																				    <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="ownerDept" name="ownerDept">
										      <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" >
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
									        </div>
									    									   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									    <label for="senddevicePidAlias">送检人ID:</label></th>
									    										<td width="39%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="senddevicePid" name="senddevicePid">
										      <input class="form-control" placeholder="请选择用户" type="text" id="senddevicePidAlias" name="senddevicePidAlias">
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									    <label for="senddeviceDeptAlias">送检人部门:</label></th>
									    										<td width="39%">
																				    <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="senddeviceDept" name="senddeviceDept">
										      <input class="form-control" placeholder="请选择部门" type="text" id="senddeviceDeptAlias" name="senddeviceDeptAlias" >
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
									        </div>
									    									   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									    <label for="takedevicePidAlias">取走人ID:</label></th>
									    										<td width="39%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="takedevicePid" name="takedevicePid">
										      <input class="form-control" placeholder="请选择用户" type="text" id="takedevicePidAlias" name="takedevicePidAlias">
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									    <label for="takedeviceDeptAlias">取走人部门:</label></th>
									    										<td width="39%">
																				    <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="takedeviceDept" name="takedeviceDept">
										      <input class="form-control" placeholder="请选择部门" type="text" id="takedeviceDeptAlias" name="takedeviceDeptAlias" >
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
									        </div>
									    									   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									    <label for="deliveryPidAlias">外送员ID:</label></th>
									    										<td width="39%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="deliveryPid" name="deliveryPid">
										      <input class="form-control" placeholder="请选择用户" type="text" id="deliveryPidAlias" name="deliveryPidAlias">
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									    <label for="deliveryDeptAlias">外送员部门:</label></th>
									    										<td width="39%">
																				    <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="deliveryDept" name="deliveryDept">
										      <input class="form-control" placeholder="请选择部门" type="text" id="deliveryDeptAlias" name="deliveryDeptAlias" >
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
									        </div>
									    									   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="formState">表单状态:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="formState"  id="formState" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="unifiedId">统一编号:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deviceName">设备名称:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deviceCategory">设备类别:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="deviceCategory"  id="deviceCategory" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deviceSpec">设备规格:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deviceModel">设备型号:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="secretLevel">密级:</label></th>
									    										<td width="39%">
																					<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL" />
									    									   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="positionId">安装地点ID:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="positionId"  id="positionId" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="manufacturer">生产厂家:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="manufacturer"  id="manufacturer" />
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isMetering">是否计量:</label></th>
									    										<td width="39%">
																					<pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
									    									   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="meterMode">计量方式:</label></th>
									    										<td width="39%">
																					<pt6:h5select css_class="form-control input-sm" name="meterMode" id="meterMode" title="" isNull="true" lookupCode="METERING_MODE" />
									    									   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="meterFinishDate">计量完成时间:</label></th>
									    										<td width="39%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="meterFinishDate" id="meterFinishDate" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="meterCycle">计量周期:</label></th>
									    										<td width="39%">
																				  												     													<div class="input-group input-group-sm spinner" data-trigger="spinner">
													  <input  class="form-control"  type="text" name="meterCycle" id="meterCycle"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
													  <span class="input-group-addon">
													    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
													    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
													  </span>
													</div>	
																							  																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="lastMeteringDate">上次计量时间:</label></th>
									    										<td width="39%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="lastMeteringDate" id="lastMeteringDate" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									    <label for="meterPersonAlias">计量员:</label></th>
									    										<td width="39%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="meterPerson" name="meterPerson">
										      <input class="form-control" placeholder="请选择用户" type="text" id="meterPersonAlias" name="meterPersonAlias">
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									    <label for="meterPlanPersonAlias">计量计划员:</label></th>
									    										<td width="39%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="meterPlanPerson" name="meterPlanPerson">
										      <input class="form-control" placeholder="请选择用户" type="text" id="meterPlanPersonAlias" name="meterPlanPersonAlias">
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									    <label for="meterTakeawayPersonAlias">外送员:</label></th>
									    										<td width="39%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="meterTakeawayPerson" name="meterTakeawayPerson">
										      <input class="form-control" placeholder="请选择用户" type="text" id="meterTakeawayPersonAlias" name="meterTakeawayPersonAlias">
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="meterConclusion">计量结论:</label></th>
									    										<td width="39%">
																					<pt6:h5select css_class="form-control input-sm" name="meterConclusion" id="meterConclusion" title="" isNull="true" lookupCode="METERING_CONCLUTION" />
									    									   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isDeriveOft">是否派生超差追溯:</label></th>
									    										<td width="39%">
																					<pt6:h5select css_class="form-control input-sm" name="isDeriveOft" id="isDeriveOft" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
									    									   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="expressNumber">快递单号:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="expressNumber"  id="expressNumber" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="deliveryDate">预送检日期:</label></th>
									    										<td width="39%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="deliveryDate" id="deliveryDate" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																																													   															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 																										 																			<th width="10%">
									    									  	<label for="procedureFileId">计量文件受控号:</label></th>
									    										<td width="39%">
																				    <input class="form-control input-sm" type="text" name="procedureFileId"  id="procedureFileId" />
																			   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="meteringOrigin">计量任务来源:</label></th>
									    										<td width="39%">
																					<pt6:h5select css_class="form-control input-sm" name="meteringOrigin" id="meteringOrigin" title="" isNull="true" lookupCode="METERING_ORIGIN_TYPE" />
									    									   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="isDeliveryAllowed">是否允许外送检:</label></th>
									    										<td width="39%">
																					<pt6:h5select css_class="form-control input-sm" name="isDeliveryAllowed" id="isDeliveryAllowed" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
									    									   </td>
																					</tr>
											<tr>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="formCheckConclude">形式审核结论:</label></th>
									    										<td width="39%">
																					<pt6:h5select css_class="form-control input-sm" name="formCheckConclude" id="formCheckConclude" title="" isNull="true" lookupCode="conclusion" />
									    									   </td>
																																													   															 																										 																			<th width="10%">
									    									  	<label for="managerConclude">计量室主任审核结论:</label></th>
									    										<td width="39%">
																					<pt6:h5select css_class="form-control input-sm" name="managerConclude" id="managerConclude" title="" isNull="true" lookupCode="conclusion" />
									    									   </td>
																					</tr>
											<tr>
																																													   															 									</tr>
									<tr>
										<th width="99%" colspan="<%=2 * 2 %>">
											<div id="toolbar_DynDeviceTool" class="toolbar">
												<div class="toolbar-left">
													<sec:accesscontrollist hasPermission="3"
														domainObject="formdialog_DynDeviceTool_button_add"
														permissionDes="添加">
														<a id="dynDeviceTool_insert" href="javascript:void(0)"
															class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button"
															title="添加"><i class="fa fa-plus"></i> 添加</a>
													</sec:accesscontrollist>
													<sec:accesscontrollist hasPermission="3"
														domainObject="formdialog_DynDeviceTool_button_delete"
														permissionDes="删除">
														<a id="dynDeviceTool_del" href="javascript:void(0)"
															class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button"
															title="删除"><i class="fa fa-trash-o"></i> 删除</a>
													</sec:accesscontrollist>
														<a class="btn btn-default form-tool-btn btn-sm bpm_self_class" style="display:none" title="子表数据是否可编辑" name="dynDeviceTool_editable" id="dynDeviceTool_editable" >是否可编辑</a>
												</div>
											</div>
											<table id="dynDeviceTool" name="DYN_DEVICE_TOOL" class="customform_subtable_bpm_auth"></table>
																																															 													 											    																																																																																		 											         	<pt6:h5resource label="计量文件规范号" name="procedureFile" ref_table="DYN_DEVICE_TOOL"></pt6:h5resource>
											         											    																																				 													 											    																																																											 											         	<pt6:h5resource label="设备名称" name="deviceName" ref_table="DYN_DEVICE_TOOL"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="生产厂家" name="manufacturerId" ref_table="DYN_DEVICE_TOOL"></pt6:h5resource>
											         											    																																																											 											         	<pt6:h5resource label="统一编号" name="unifiedId" ref_table="DYN_DEVICE_TOOL"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="设备类别" name="deviceCategory" ref_table="DYN_DEVICE_TOOL"></pt6:h5resource>
											         											    																																																											 											         	<pt6:h5resource label="设备规格" name="deviceSpec" ref_table="DYN_DEVICE_TOOL"></pt6:h5resource>
											         											    																																																																																		 											         	<pt6:h5resource label="设备型号" name="deviceModel" ref_table="DYN_DEVICE_TOOL"></pt6:h5resource>
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
	<script type="text/javascript" src="avicit/assets/device/assetsdevicemetering/js/AssetsDeviceMeteringDetail.js"></script>
	<script type="text/javascript" src="avicit/assets/device/assetsdevicemetering/js/DynDeviceTool.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     					     			     				     			     				     			     				     					       //初始化通用代码值
  function initOnceInAdd(){
		avicAjax.ajax({
			 url:"platform/assets/device/assetsdevicemetering/assetsDeviceMeteringController/getLookUpCode",
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
	var dynDeviceToolGridColModel = null;
			$(document).ready(function () {
		    var pid = "<%=pid%>";
			var isReload = "true";
			var searchSubNames = "";
			initOnceInAdd(); //初始化通用代码值
			dynDeviceToolGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 			 			 											   				   													,{ label: '计量文件规范号', name: 'procedureFile', width: 150}
																		  		   			 								 			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150}
																		  		   			 											   				   													,{ label: '生产厂家', name: 'manufacturerId', width: 150}
																		  		   			 			 											   				   													,{ label: '统一编号', name: 'unifiedId', width: 150}
																		  		   			 											   				   													,{ label: '设备类别', name: 'deviceCategory', width: 150}
																		  		   			 			 											   				   													,{ label: '设备规格', name: 'deviceSpec', width: 150}
																		  		   			 			 			 											   				   													,{ label: '设备型号', name: 'deviceModel', width: 150}
																		  		   			 	];
			var surl = "platform/assets/device/assetsdevicemetering/assetsDeviceMeteringController/operation/sub/";
			var dynDeviceTool = new DynDeviceTool('dynDeviceTool', surl,
					"formSub",
					dynDeviceToolGridColModel,
					'searchDialogSub', pid,searchSubNames, 'dynDeviceTool_keyWord',isReload);
			//创建业务操作JS
			var assetsDeviceMeteringDetail = new AssetsDeviceMeteringDetail('form',dynDeviceTool);
			//创建流程操作JS
			new FlowEditor(assetsDeviceMeteringDetail);
			
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
			assetsDeviceMeteringDetail.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
				formId: '<%=pid%>',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
			});
			//添加按钮绑定事件
			$('#dynDeviceTool_insert').bind('click', function() {
				dynDeviceTool.insert();
			});
			//删除按钮绑定事件
			$('#dynDeviceTool_del').bind('click', function() {
				dynDeviceTool.del();
			});
			
																																													$('#applicantIdAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'applicantId',textFiled:'applicantIdAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#applicantDepartAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'applicantDepart',textFiled:'applicantDepartAlias'});
					    this.blur();
					    nullInput(e);
					});
																								$('#ownerIdAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'ownerId',textFiled:'ownerIdAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#ownerDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'ownerDept',textFiled:'ownerDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																								$('#senddevicePidAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'senddevicePid',textFiled:'senddevicePidAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#senddeviceDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'senddeviceDept',textFiled:'senddeviceDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																								$('#takedevicePidAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'takedevicePid',textFiled:'takedevicePidAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#takedeviceDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'takedeviceDept',textFiled:'takedeviceDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																								$('#deliveryPidAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'deliveryPid',textFiled:'deliveryPidAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#deliveryDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'deliveryDept',textFiled:'deliveryDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																																																																																																																																																																																																																																																																																		$('#meterPersonAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'meterPerson',textFiled:'meterPersonAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#meterPlanPersonAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'meterPlanPerson',textFiled:'meterPlanPersonAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#meterTakeawayPersonAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'meterTakeawayPerson',textFiled:'meterTakeawayPersonAlias'});
						this.blur();
						nullInput(e);
					}); 
																																																																																																																																																																																																																																																				
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>