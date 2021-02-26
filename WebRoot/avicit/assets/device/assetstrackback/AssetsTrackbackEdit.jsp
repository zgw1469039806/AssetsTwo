<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,form,fileupload";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "assets/device/assetstrackback/assetsTrackbackController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsTrackbackDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsTrackbackDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																																																																																																																																																						 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meteringId">关联计量单号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="meteringId"  id="meteringId" value="<c:out  value='${assetsTrackbackDTO.meteringId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="applicantIdAlias">申请人ID:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="applicantId" name="applicantId" value="<c:out  value='${assetsTrackbackDTO.applicantId}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="applicantIdAlias" name="applicantIdAlias" value="<c:out  value='${assetsTrackbackDTO.applicantIdAlias}'/>">
										       <span class="input-group-addon" >
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="applicantDepartAlias">APPLICANT_DEPART:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="applicantDepart" name="applicantDepart" value="<c:out  value='${assetsTrackbackDTO.applicantDepart}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="applicantDepartAlias" name="applicantDepartAlias" value="<c:out  value='${assetsTrackbackDTO.applicantDepartAlias}'/>">
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="deviceUserIdAlias">DEVICE_USER_ID:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="deviceUserId" name="deviceUserId" value="<c:out  value='${assetsTrackbackDTO.deviceUserId}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="deviceUserIdAlias" name="deviceUserIdAlias" value="<c:out  value='${assetsTrackbackDTO.deviceUserIdAlias}'/>">
										       <span class="input-group-addon" >
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="deviceUserDeptAlias">DEVICE_USER_DEPT:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="deviceUserDept" name="deviceUserDept" value="<c:out  value='${assetsTrackbackDTO.deviceUserDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="deviceUserDeptAlias" name="deviceUserDeptAlias" value="<c:out  value='${assetsTrackbackDTO.deviceUserDeptAlias}'/>">
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formState">表单状态:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formState"  id="formState" value="<c:out  value='${assetsTrackbackDTO.formState}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="unifiedId">统一编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" value="<c:out  value='${assetsTrackbackDTO.unifiedId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceName">设备名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" value="<c:out  value='${assetsTrackbackDTO.deviceName}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceCategory">设备类别:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title="" isNull="true" lookupCode="DEVICE_CATEGORY" defaultValue='${assetsTrackbackDTO.deviceCategory}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceSpec">DEVICE_SPEC:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" value="<c:out  value='${assetsTrackbackDTO.deviceSpec}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceModel">DEVICE_MODEL:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" value="<c:out  value='${assetsTrackbackDTO.deviceModel}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="manufacturerId">MANUFACTURER_ID:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="manufacturerId"  id="manufacturerId" value="<c:out  value='${assetsTrackbackDTO.manufacturerId}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="lastMeteringDate">LAST_METERING_DATE:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="lastMeteringDate" id="lastMeteringDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsTrackbackDTO.lastMeteringDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="meterPersonAlias">METER_PERSON:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="meterPerson" name="meterPerson" value="<c:out  value='${assetsTrackbackDTO.meterPerson}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="meterPersonAlias" name="meterPersonAlias" value="<c:out  value='${assetsTrackbackDTO.meterPersonAlias}'/>">
										       <span class="input-group-addon" >
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="meterConclusion">METER_CONCLUSION:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="meterConclusion" id="meterConclusion" title="" isNull="true" lookupCode="METERING_CONCLUTION" defaultValue='${assetsTrackbackDTO.meterConclusion}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceMetrics">DEVICE_METRICS:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceMetrics"  id="deviceMetrics" value="<c:out  value='${assetsTrackbackDTO.deviceMetrics}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="calibrationResult">CALIBRATION_RESULT:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="calibrationResult"  id="calibrationResult" value="<c:out  value='${assetsTrackbackDTO.calibrationResult}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="effectAnalyse">EFFECT_ANALYSE:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="effectAnalyse"  id="effectAnalyse" value="<c:out  value='${assetsTrackbackDTO.effectAnalyse}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="qualitySafeOpinion">QUALITY_SAFE_OPINION:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="qualitySafeOpinion"  id="qualitySafeOpinion" value="<c:out  value='${assetsTrackbackDTO.qualitySafeOpinion}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="chiefOpinion">CHIEF_OPINION:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="chiefOpinion"  id="chiefOpinion" value="<c:out  value='${assetsTrackbackDTO.chiefOpinion}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="procId">超差追溯单编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="procId"  id="procId" value="<c:out  value='${assetsTrackbackDTO.procId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="data24">字段_24:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="data24"  id="data24" value="<c:out  value='${assetsTrackbackDTO.data24}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="hasEffection">对产品是否有影响:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="hasEffection" id="hasEffection" title="" isNull="true" lookupCode="HAS_EFFECTION" defaultValue='${assetsTrackbackDTO.hasEffection}'/>
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
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="assetsTrackback_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsTrackback_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">
			function closeForm(){
			parent.assetsTrackback.closeDialog(window.name);
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            $(isValidate.errorList[0].element).focus();
	            return false;
	        }
	        //验证附件密级
		   	var files = $('#attachment').uploaderExt('getUploadFiles');
		   	for(var i = 0; i < files.length; i++){
		   		var name = files[i].name;
		   		var secretLevel = files[i].secretLevel;
		   		//这里验证密级
		   	}
		   	//限制保存按钮多次点击
   			$('#assetsTrackback_saveForm').addClass('disabled').unbind("click");
			parent.assetsTrackback.save($('#form'),window.name,callback);
		}
		//附件操作
		function callback(id){
			var files = $('#attachment').uploaderExt('getUploadFiles');
			if(files == 0){
				closeForm();
			}else{
				$("#id").val(id);
				$('#attachment').uploaderExt('doUpload', id);
			}
		}//上传附件完成后操作
		function afterUploadEvent(){
			closeForm();
		}
		/**
		 * 加载完后初始化
		 */
		$(document).ready(function () {
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
			    formId: '${assetsTrackbackDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: afterUploadEvent
			});
			//绑定表单验证规则
			parent.assetsTrackback.formValidate($('#form'));
			//保存按钮绑定事件
			$('#assetsTrackback_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#assetsTrackback_closeForm').bind('click', function(){
				closeForm();
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