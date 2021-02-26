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
<!-- ControllerPath = "assets/device/assetsaccidentproc/assetsAccidentProcController/operation/Edit/id" -->
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
						<input type="hidden" name="version" value="<c:out  value='${assetsAccidentProcDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsAccidentProcDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							 <table class="form_commonTable">
				<tr>
																																											 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="accidentNo">事故编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="accidentNo"  id="accidentNo" value="<c:out  value='${assetsAccidentProcDTO.accidentNo}'/>"/>
																	   </td>
																								   													 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByDeptAlias">申请人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept" value="<c:out  value='${assetsAccidentProcDTO.createdByDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" value="<c:out  value='${assetsAccidentProcDTO.createdByDeptAlias}'/>">
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByTel">申请人电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" value="<c:out  value='${assetsAccidentProcDTO.createdByTel}'/>"/>
																	   </td>
																								   													 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formState">单据状态:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formState"  id="formState" value="<c:out  value='${assetsAccidentProcDTO.formState}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="assetsOperatorAlias">设备操作者:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="assetsOperator" name="assetsOperator" value="<c:out  value='${assetsAccidentProcDTO.assetsOperator}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="assetsOperatorAlias" name="assetsOperatorAlias" value="<c:out  value='${assetsAccidentProcDTO.assetsOperatorAlias}'/>">
										       <span class="input-group-addon" >
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="operatorDeptAlias">操作人单位:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="operatorDept" name="operatorDept" value="<c:out  value='${assetsAccidentProcDTO.operatorDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="operatorDeptAlias" name="operatorDeptAlias" value="<c:out  value='${assetsAccidentProcDTO.operatorDeptAlias}'/>">
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="unifiedId">统一编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" value="<c:out  value='${assetsAccidentProcDTO.unifiedId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceName">设备名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" value="<c:out  value='${assetsAccidentProcDTO.deviceName}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceModel">设备型号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" value="<c:out  value='${assetsAccidentProcDTO.deviceModel}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceSpec">设备规格:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" value="<c:out  value='${assetsAccidentProcDTO.deviceSpec}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="occurTime">事故发生时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="occurTime" id="occurTime" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsAccidentProcDTO.occurTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="reportLeaderTime">报告单位领导时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="reportLeaderTime" id="reportLeaderTime" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsAccidentProcDTO.reportLeaderTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="reportTime">报告时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="reportTime" id="reportTime" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsAccidentProcDTO.reportTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="accidentProcess">事故发生经过:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3"   name="accidentProcess" id="accidentProcess"><c:out  value='${assetsAccidentProcDTO.accidentProcess}'/></textarea> 
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="accidentConsequence">事故后果:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3"   name="accidentConsequence" id="accidentConsequence"><c:out  value='${assetsAccidentProcDTO.accidentConsequence}'/></textarea> 
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="reasonAnalysis">事故原因分析:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3"   name="reasonAnalysis" id="reasonAnalysis"><c:out  value='${assetsAccidentProcDTO.reasonAnalysis}'/></textarea> 
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="preventionMeasures">防止事故措施:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3"   name="preventionMeasures" id="preventionMeasures"><c:out  value='${assetsAccidentProcDTO.preventionMeasures}'/></textarea> 
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="repairTime">修复时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="repairTime" id="repairTime" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsAccidentProcDTO.repairTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="stopWorkDays">停工天数:</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="stopWorkDays" id="stopWorkDays" value="<c:out  value='${assetsAccidentProcDTO.stopWorkDays}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="directEconomicLoss">直接经济损失:</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="directEconomicLoss" id="directEconomicLoss" value="<c:out  value='${assetsAccidentProcDTO.directEconomicLoss}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="accidentProperty">事故性质:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="accidentProperty"  id="accidentProperty" value="<c:out  value='${assetsAccidentProcDTO.accidentProperty}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="assetsManAlias">设备员:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="assetsMan" name="assetsMan" value="<c:out  value='${assetsAccidentProcDTO.assetsMan}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="assetsManAlias" name="assetsManAlias" value="<c:out  value='${assetsAccidentProcDTO.assetsManAlias}'/>">
										       <span class="input-group-addon" >
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="assetsAccidentProc_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsAccidentProc_closeForm">返回</a>
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
			parent.assetsAccidentProc.closeDialog(window.name);
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
   			$('#assetsAccidentProc_saveForm').addClass('disabled').unbind("click");
			parent.assetsAccidentProc.save($('#form'),window.name,callback);
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
			    formId: '${assetsAccidentProcDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: afterUploadEvent
			});
			//绑定表单验证规则
			parent.assetsAccidentProc.formValidate($('#form'));
			//保存按钮绑定事件
			$('#assetsAccidentProc_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#assetsAccidentProc_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																	$('#createdByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'createdByDept',textFiled:'createdByDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																																																													$('#assetsOperatorAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'assetsOperator',textFiled:'assetsOperatorAlias'});
					    this.blur();
					    nullInput(e);
					}); 
																								$('#operatorDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'operatorDept',textFiled:'operatorDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																																																																																																																																																																																																																																																																																																					$('#assetsManAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'assetsMan',textFiled:'assetsManAlias'});
					    this.blur();
					    nullInput(e);
					}); 
																																																																																																							
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>