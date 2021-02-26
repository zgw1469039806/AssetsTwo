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
<!-- ControllerPath = "assets/device/assetstrackback/assetsTrackbackController/operation/toDetailJsp" -->
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
									    									  	<label for="meteringId">关联计量单号:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="meteringId"  id="meteringId" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									    <label for="applicantIdAlias">申请人ID:</label></th>
									    										<td width="15%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="applicantId" name="applicantId">
										      <input class="form-control" placeholder="请选择用户" type="text" id="applicantIdAlias" name="applicantIdAlias">
										      <span class="input-group-addon" >
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									    <label for="applicantDepartAlias">APPLICANT_DEPART:</label></th>
									    										<td width="15%">
																				    <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="applicantDepart" name="applicantDepart">
										      <input class="form-control" placeholder="请选择部门" type="text" id="applicantDepartAlias" name="applicantDepartAlias" >
										       <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
									        </div>
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									    <label for="deviceUserIdAlias">DEVICE_USER_ID:</label></th>
									    										<td width="15%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="deviceUserId" name="deviceUserId">
										      <input class="form-control" placeholder="请选择用户" type="text" id="deviceUserIdAlias" name="deviceUserIdAlias">
										      <span class="input-group-addon" >
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
										   	  <input type="hidden"  id="deviceUserDept" name="deviceUserDept">
										      <input class="form-control" placeholder="请选择部门" type="text" id="deviceUserDeptAlias" name="deviceUserDeptAlias" >
										       <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
									        </div>
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="formState">表单状态:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="formState"  id="formState" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="unifiedId">统一编号:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="deviceName">设备名称:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" />
																			   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="deviceCategory">设备类别:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title="" isNull="true" lookupCode="DEVICE_CATEGORY" />
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="deviceSpec">DEVICE_SPEC:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="deviceModel">DEVICE_MODEL:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="manufacturerId">MANUFACTURER_ID:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="manufacturerId"  id="manufacturerId" />
																			   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="lastMeteringDate">LAST_METERING_DATE:</label></th>
									    										<td width="15%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="lastMeteringDate" id="lastMeteringDate" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									    <label for="meterPersonAlias">METER_PERSON:</label></th>
									    										<td width="15%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="meterPerson" name="meterPerson">
										      <input class="form-control" placeholder="请选择用户" type="text" id="meterPersonAlias" name="meterPersonAlias">
										      <span class="input-group-addon" >
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="meterConclusion">METER_CONCLUSION:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="meterConclusion" id="meterConclusion" title="" isNull="true" lookupCode="METERING_CONCLUTION" />
									    									   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="deviceMetrics">DEVICE_METRICS:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="deviceMetrics"  id="deviceMetrics" />
																			   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="calibrationResult">CALIBRATION_RESULT:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="calibrationResult"  id="calibrationResult" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="effectAnalyse">EFFECT_ANALYSE:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="effectAnalyse"  id="effectAnalyse" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="qualitySafeOpinion">QUALITY_SAFE_OPINION:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="qualitySafeOpinion"  id="qualitySafeOpinion" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="chiefOpinion">CHIEF_OPINION:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="chiefOpinion"  id="chiefOpinion" />
																			   </td>
																					</tr>
											<tr>
																											   															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 															 																										 																																					<th width="10%">
									    									  	<label for="procId">超差追溯单编号:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="procId"  id="procId" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="data24">字段_24:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="data24"  id="data24" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="hasEffection">对产品是否有影响:</label></th>
									    										<td width="15%">
																					<pt6:h5select css_class="form-control input-sm" name="hasEffection" id="hasEffection" title="" isNull="true" lookupCode="HAS_EFFECTION" />
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
	<script src="avicit/assets/device/assetstrackback/js/AssetsTrackbackDetail.js"></script>
	<script type="text/javascript">
			//注册附件上传完毕后执行的方法
		var afterUploadEvent = null;
		$(document).ready(function () {
			//创建业务操作JS
			var assetsTrackbackDetail = new AssetsTrackbackDetail('form');
			//创建流程操作JS
			new FlowEditor(assetsTrackbackDetail);
			
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
			assetsTrackbackDetail.formValidate($('#form'));
			
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
																								$('#deviceUserIdAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'deviceUserId',textFiled:'deviceUserIdAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#deviceUserDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'deviceUserDept',textFiled:'deviceUserDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																																																																																																																																																																$('#meterPersonAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'meterPerson',textFiled:'meterPersonAlias'});
						this.blur();
						nullInput(e);
					}); 
																																																																																																																																																																																																																																																				
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>