<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
	String importlibs = "common,form,table,fileupload,tree";
	String formId  = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "assets/device/assetsreconacceptance/assetsReconAcceptanceController/operation/toDetailJsp" -->
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
									    									  	<label for="acceptanceNo">验收单号:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="acceptanceNo"  id="acceptanceNo" />
																			   </td>
																											   															 															 																										 																																					<th width="10%">
									    									    <label for="createdByDeptAlias">创建人部门:</label></th>
									    										<td width="15%">
																				    <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="createdByDept" name="createdByDept">
										      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" >
										       <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
									        </div>
									    									   </td>
																											   															 															 															 															 															 															 																										 																																					<th width="10%">
									    									  	<label for="formState">单据状态:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="formState"  id="formState" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									    <label for="applyByAlias">申请人:</label></th>
									    										<td width="15%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="applyBy" name="applyBy">
										      <input class="form-control" placeholder="请选择用户" type="text" id="applyByAlias" name="applyByAlias">
										      <span class="input-group-addon" >
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
										   	  <input type="hidden"  id="applyByDept" name="applyByDept">
										      <input class="form-control" placeholder="请选择部门" type="text" id="applyByDeptAlias" name="applyByDeptAlias" >
										       <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
									        </div>
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="reconstructionNo">申购单号:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="reconstructionNo"  id="reconstructionNo" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="deviceName">设备名称:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="unifiedId">统一编号:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" />
																			   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="secretLevel">密级:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL" />
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="manufacturerId">生产厂家:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="manufacturerId"  id="manufacturerId" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									    <label for="competentChiefEngineerAlias">主管总师:</label></th>
									    										<td width="15%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="competentChiefEngineer" name="competentChiefEngineer">
										      <input class="form-control" placeholder="请选择用户" type="text" id="competentChiefEngineerAlias" name="competentChiefEngineerAlias">
										      <span class="input-group-addon" >
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									    <label for="ownerDeptAlias">责任人部门:</label></th>
									    										<td width="15%">
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
									    									    <label for="ownerIdAlias">责任人:</label></th>
									    										<td width="15%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="ownerId" name="ownerId">
										      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias">
										      <span class="input-group-addon" >
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="ownerTel">责任人联系方式:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="ownerTel"  id="ownerTel" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="setsCount">台(套)数:</label></th>
									    										<td width="15%">
																				  												     													<div class="input-group input-group-sm spinner" data-trigger="spinner">
													  <input  class="form-control"  type="text" name="setsCount" id="setsCount"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
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
													  <input  class="form-control"  type="text" name="unitPrice" id="unitPrice"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
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
										   	  <input type="hidden"  id="projectDirector" name="projectDirector">
										      <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias">
										      <span class="input-group-addon" >
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="deviceCategory">设备类别:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="deviceCategory"  id="deviceCategory" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="ifRegularCheck">是否定检:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="ifRegularCheck" id="ifRegularCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="ifSpotCheck">是否点检:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="ifSpotCheck" id="ifSpotCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
									    									   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="ifPrecisionInspection">是否精度检查:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="ifPrecisionInspection" id="ifPrecisionInspection" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="ifUpkeep">是否保养:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="ifUpkeep" id="ifUpkeep" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="upkeepCycle">保养周期(天):</label></th>
									    										<td width="15%">
																				  												     													<div class="input-group input-group-sm spinner" data-trigger="spinner">
													  <input  class="form-control"  type="text" name="upkeepCycle" id="upkeepCycle"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
													  <span class="input-group-addon">
													    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
													    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
													  </span>
													</div>	
																							  																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="upkeepRequirements">保养要求:</label></th>
									    										<td width="15%">
																				    <textarea class="form-control input-sm" rows="3"   name="upkeepRequirements" id="upkeepRequirements"></textarea> 
																			   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="nextUpkeepDate">下次保养时间:</label></th>
									    										<td width="15%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="nextUpkeepDate" id="nextUpkeepDate" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="ifMeasure">是否计量:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="ifMeasure" id="ifMeasure" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="ifInstall">是否需要安装:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="ifInstall" id="ifInstall" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="ifMeasureOnsite">是否现场计量:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="ifMeasureOnsite" id="ifMeasureOnsite" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
									    									   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="measureIdentify">计量标识:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="measureIdentify"  id="measureIdentify" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									    <label for="measureByAlias">计量人员:</label></th>
									    										<td width="15%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="measureBy" name="measureBy">
										      <input class="form-control" placeholder="请选择用户" type="text" id="measureByAlias" name="measureByAlias">
										      <span class="input-group-addon" >
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="meteringDate">计量时间:</label></th>
									    										<td width="15%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="meteringDate" id="meteringDate" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="meteringCycle">计量周期(天):</label></th>
									    										<td width="15%">
																				  												     													<div class="input-group input-group-sm spinner" data-trigger="spinner">
													  <input  class="form-control"  type="text" name="meteringCycle" id="meteringCycle"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
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
																				    <input class="form-control input-sm" type="text" name="positionId"  id="positionId" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="ifHasComputer">是否含计算机/无线模板:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="ifHasComputer"  id="ifHasComputer" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="isSafetyProduction">是否涉及安全生产:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="isSafetyProduction"  id="isSafetyProduction" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="financialResources">经费来源:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources" title="" isNull="true" lookupCode="FINANCIAL_RESOURCES" />
									    									   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="belongProject">所属项目:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="belongProject"  id="belongProject" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="projectNo">项目序号:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="projectNo"  id="projectNo" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="replyName">批复名称:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="replyName"  id="replyName" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="projectApprovalNo">立项单号:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="projectApprovalNo"  id="projectApprovalNo" />
																			   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="abcCategory">ABC分类:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="abcCategory" id="abcCategory" title="" isNull="true" lookupCode="ABC_CATEGORY" />
									    									   </td>
																											   															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 									</tr>
									<tr>
										<th><label for="attachment">附件</label></th>
										<td colspan="<%=4 * 2 - 1%>">
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
	<script src="avicit/assets/device/assetsreconacceptance/js/AssetsReconAcceptanceDetail.js"></script>
	<script type="text/javascript">
			//注册附件上传完毕后执行的方法
		var afterUploadEvent = null;
		$(document).ready(function () {
			//创建业务操作JS
			var assetsReconAcceptanceDetail = new AssetsReconAcceptanceDetail('form');
			//创建流程操作JS
			new FlowEditor(assetsReconAcceptanceDetail);
			
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
			//初始化附件上传组件
			$('#attachment').uploaderExt({
				formId: '<%=formId%>',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
			});
			//绑定表单验证规则
			assetsReconAcceptanceDetail.formValidate($('#form'));
			
																																																	$('#createdByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'createdByDept',textFiled:'createdByDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																																										$('#applyByAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'applyBy',textFiled:'applyByAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#applyByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'applyByDept',textFiled:'applyByDeptAlias'});
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