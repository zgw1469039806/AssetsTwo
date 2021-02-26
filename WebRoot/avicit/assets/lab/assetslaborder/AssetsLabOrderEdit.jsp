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
<!-- ControllerPath = "assets/lab/assetslaborder/assetsLabOrderController/operation/Edit/id" -->
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
						<input type="hidden" name="version" value="<c:out  value='${assetsLabOrderDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsLabOrderDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																							 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="orderNumber">预约单号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="orderNumber"  id="orderNumber" value="<c:out  value='${assetsLabOrderDTO.orderNumber}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="applyIdAlias">申请人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="applyId" name="applyId" value="<c:out  value='${assetsLabOrderDTO.applyId}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="applyIdAlias" name="applyIdAlias" value="<c:out  value='${assetsLabOrderDTO.applyIdAlias}'/>">
										       <span class="input-group-addon" >
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="applyDeptAlias">申请部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="applyDept" name="applyDept" value="<c:out  value='${assetsLabOrderDTO.applyDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="applyDeptAlias" name="applyDeptAlias" value="<c:out  value='${assetsLabOrderDTO.applyDeptAlias}'/>">
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="telephone">联系电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="telephone"  id="telephone" value="<c:out  value='${assetsLabOrderDTO.telephone}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tdeviceName">试件名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="tdeviceName"  id="tdeviceName" value="<c:out  value='${assetsLabOrderDTO.tdeviceName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tdeviceCode">试件代号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="tdeviceCode"  id="tdeviceCode" value="<c:out  value='${assetsLabOrderDTO.tdeviceCode}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tdeviceModel">试件型号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="tdeviceModel"  id="tdeviceModel" value="<c:out  value='${assetsLabOrderDTO.tdeviceModel}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tdeviceNum">试件编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="tdeviceNum"  id="tdeviceNum" value="<c:out  value='${assetsLabOrderDTO.tdeviceNum}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="belongModel">所属机型:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="belongModel"  id="belongModel" value="<c:out  value='${assetsLabOrderDTO.belongModel}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="testType">试验类型:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="testType" id="testType" title="" isNull="true" lookupCode="TEST_TYPE" defaultValue='${assetsLabOrderDTO.testType}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="testNature">试验性质:</label></th>
								    									<td width="15%">
																			<pt6:h5select css_class="form-control input-sm" name="testNature" id="testNature" title="" isNull="true" lookupCode="TEST_NATURE" defaultValue='${assetsLabOrderDTO.testNature}'/>
								    								   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="testCondition">试验条件:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="testCondition"  id="testCondition" value="<c:out  value='${assetsLabOrderDTO.testCondition}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="supportTool">配套工装:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="supportTool"  id="supportTool" value="<c:out  value='${assetsLabOrderDTO.supportTool}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="orderStartTime">预约开始时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="orderStartTime" id="orderStartTime" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsLabOrderDTO.orderStartTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="orderFinishTime">预约结束时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="orderFinishTime" id="orderFinishTime" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsLabOrderDTO.orderFinishTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="labDeviceId">实验设备ID:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="labDeviceId"  id="labDeviceId" value="<c:out  value='${assetsLabOrderDTO.labDeviceId}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="labDeviceUid">实验设备统一编号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="labDeviceUid"  id="labDeviceUid" value="<c:out  value='${assetsLabOrderDTO.labDeviceUid}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="labDeviceName">实验设备名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="labDeviceName"  id="labDeviceName" value="<c:out  value='${assetsLabOrderDTO.labDeviceName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="approvalStartTime">审核开始时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="approvalStartTime" id="approvalStartTime" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsLabOrderDTO.approvalStartTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="approvalFinishTime">审核结束时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="approvalFinishTime" id="approvalFinishTime" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsLabOrderDTO.approvalFinishTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="actualStartTime">实际开始时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="actualStartTime" id="actualStartTime" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsLabOrderDTO.actualStartTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="actualFinishTime">实际结束时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="actualFinishTime" id="actualFinishTime" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsLabOrderDTO.actualFinishTime}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="assetsLabOrder_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsLabOrder_closeForm">返回</a>
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
			parent.assetsLabOrder.closeDialog(window.name);
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
   			$('#assetsLabOrder_saveForm').addClass('disabled').unbind("click");
			parent.assetsLabOrder.save($('#form'),window.name,callback);
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
			    formId: '${assetsLabOrderDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: afterUploadEvent
			});
			//绑定表单验证规则
			parent.assetsLabOrder.formValidate($('#form'));
			//保存按钮绑定事件
			$('#assetsLabOrder_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#assetsLabOrder_closeForm').bind('click', function(){
				closeForm();
			});
			
																																																																$('#applyIdAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'applyId',textFiled:'applyIdAlias'});
					    this.blur();
					    nullInput(e);
					}); 
																								$('#applyDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'applyDept',textFiled:'applyDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>