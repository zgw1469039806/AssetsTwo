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
<!-- ControllerPath = "assets/device/assetsdevicescrap/assetsDeviceScrapController/operation/Edit/id" -->
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
						<input type="hidden" name="version" value="<c:out  value='${assetsDeviceScrapDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsDeviceScrapDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																															 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByPersonAlias">申请人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="createdByPerson" name="createdByPerson" value="<c:out  value='${assetsDeviceScrapDTO.createdByPerson}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias" name="createdByPersonAlias" value="<c:out  value='${assetsDeviceScrapDTO.createdByPersonAlias}'/>">
										       <span class="input-group-addon" >
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByDeptAlias">申请人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept" value="<c:out  value='${assetsDeviceScrapDTO.createdByDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" value="<c:out  value='${assetsDeviceScrapDTO.createdByDeptAlias}'/>">
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByTel">申请人电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" value="<c:out  value='${assetsDeviceScrapDTO.createdByTel}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formState">单据状态:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formState"  id="formState" value="<c:out  value='${assetsDeviceScrapDTO.formState}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="procName">流程名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="procName"  id="procName" value="<c:out  value='${assetsDeviceScrapDTO.procName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="procId">流程ID:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="procId"  id="procId" value="<c:out  value='${assetsDeviceScrapDTO.procId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="assetId">资产编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="assetId"  id="assetId" value="<c:out  value='${assetsDeviceScrapDTO.assetId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="unifiedId">统一编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" value="<c:out  value='${assetsDeviceScrapDTO.unifiedId}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceCategory">设备类别:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceCategory"  id="deviceCategory" value="<c:out  value='${assetsDeviceScrapDTO.deviceCategory}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceName">设备名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" value="<c:out  value='${assetsDeviceScrapDTO.deviceName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceModel">设备型号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceModel"  id="deviceModel" value="<c:out  value='${assetsDeviceScrapDTO.deviceModel}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deviceSpec">设备规格:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="deviceSpec"  id="deviceSpec" value="<c:out  value='${assetsDeviceScrapDTO.deviceSpec}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="ownerIdAlias">责任人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="ownerId" name="ownerId" value="<c:out  value='${assetsDeviceScrapDTO.ownerId}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias" value="<c:out  value='${assetsDeviceScrapDTO.ownerIdAlias}'/>">
										       <span class="input-group-addon" >
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="ownerDeptAlias">责任人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="ownerDept" name="ownerDept" value="<c:out  value='${assetsDeviceScrapDTO.ownerDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" value="<c:out  value='${assetsDeviceScrapDTO.ownerDeptAlias}'/>">
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="userIdAlias">使用人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="userId" name="userId" value="<c:out  value='${assetsDeviceScrapDTO.userId}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="userIdAlias" name="userIdAlias" value="<c:out  value='${assetsDeviceScrapDTO.userIdAlias}'/>">
										       <span class="input-group-addon" >
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="userDeptAlias">使用人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="userDept" name="userDept" value="<c:out  value='${assetsDeviceScrapDTO.userDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="userDeptAlias" name="userDeptAlias" value="<c:out  value='${assetsDeviceScrapDTO.userDeptAlias}'/>">
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="manufacturerId">生产厂家:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="manufacturerId"  id="manufacturerId" value="<c:out  value='${assetsDeviceScrapDTO.manufacturerId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdDate">立卡日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="createdDate" id="createdDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceScrapDTO.createdDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="positionId">安装地点:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="positionId"  id="positionId" value="<c:out  value='${assetsDeviceScrapDTO.positionId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="originalValue">原值:</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="originalValue" id="originalValue" value="<c:out  value='${assetsDeviceScrapDTO.originalValue}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-step="1" data-precision="2">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="totalDepreciation">累计折旧:</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="totalDepreciation" id="totalDepreciation" value="<c:out  value='${assetsDeviceScrapDTO.totalDepreciation}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="netValue">净值:</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="netValue" id="netValue" value="<c:out  value='${assetsDeviceScrapDTO.netValue}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-step="1" data-precision="2">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="netSalvage">净残值:</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="netSalvage" id="netSalvage" value="<c:out  value='${assetsDeviceScrapDTO.netSalvage}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-step="1" data-precision="2">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="secretLevel">密级:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL" defaultValue='${assetsDeviceScrapDTO.secretLevel}'/>
								    								   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="scrapReason">报废原因:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3"   name="scrapReason" id="scrapReason"><c:out  value='${assetsDeviceScrapDTO.scrapReason}'/></textarea> 
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="productRiskAnalyse">有关产品风险分析:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3"   name="productRiskAnalyse" id="productRiskAnalyse"><c:out  value='${assetsDeviceScrapDTO.productRiskAnalyse}'/></textarea> 
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="scrapMoney">净报废金额:</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="scrapMoney" id="scrapMoney" value="<c:out  value='${assetsDeviceScrapDTO.scrapMoney}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-step="1" data-precision="2">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="recoveryStore">回收库:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="recoveryStore" id="recoveryStore" title="" isNull="true" lookupCode="RECOVERY_STORE" defaultValue='${assetsDeviceScrapDTO.recoveryStore}'/>
								    								   </td>
																			</tr>
										<tr>
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="assetsDeviceScrap_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsDeviceScrap_closeForm">返回</a>
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
			parent.assetsDeviceScrap.closeDialog(window.name);
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
   			$('#assetsDeviceScrap_saveForm').addClass('disabled').unbind("click");
			parent.assetsDeviceScrap.save($('#form'),window.name,callback);
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
			    formId: '${assetsDeviceScrapDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: afterUploadEvent
			});
			//绑定表单验证规则
			parent.assetsDeviceScrap.formValidate($('#form'));
			//保存按钮绑定事件
			$('#assetsDeviceScrap_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#assetsDeviceScrap_closeForm').bind('click', function(){
				closeForm();
			});
			
																																													$('#createdByPersonAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'createdByPerson',textFiled:'createdByPersonAlias'});
					    this.blur();
					    nullInput(e);
					}); 
																								$('#createdByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'createdByDept',textFiled:'createdByDeptAlias'});
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
																								$('#userIdAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'userId',textFiled:'userIdAlias'});
					    this.blur();
					    nullInput(e);
					}); 
																								$('#userDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'userDept',textFiled:'userDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																																																																																																																																																																																																																																	
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>