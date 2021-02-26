<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,form,fileupload";	
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<head>
<!-- ControllerPath = "demo/demoreception/demoReceptionController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true,border:false">
		<form id='form'>
		    <input type="hidden" name="id" />
			<table class="form_commonTable">
				 <tr>
																																		 									 									 									 									 									 									 																	 																									<th width="10%">
						    						  	<label for="labName">实验室名称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labName"  id="labName" />
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labNameShort">实验室简称:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labNameShort"  id="labNameShort" />
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labNum">实验室编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labNum"  id="labNum" />
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="unifiedId">统一编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="unifiedId"  id="unifiedId" />
													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="assetId">资产编号:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="assetId"  id="assetId" />
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="majorCategory">专业类别:</label></th>
						    							<td width="15%">
															<pt6:h5select css_class="form-control input-sm" name="majorCategory" id="majorCategory" title="" isNull="true" lookupCode="MAJOR_TYPE" />
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labPosition">实验室位置:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labPosition"  id="labPosition" />
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labDeviceCount">实验室设备数量:</label></th>
						    							<td width="15%">
														   							     									<div class="input-group input-group-sm spinner" data-trigger="spinner">
									  <input  class="form-control"  type="text" name="labDeviceCount" id="labDeviceCount"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
									  <span class="input-group-addon">
									    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
									    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
									  </span>
									</div>	
															  													   </td>
															</tr>
								<tr>
																		   									 																	 																									<th width="10%">
						    						  	<label for="labInfo">实验室介绍:</label></th>
						    							<td width="15%">
														    <input class="form-control input-sm" type="text" name="labInfo"  id="labInfo" />
													   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="manageDeptAlias">实验室管理部门:</label></th>
						    							<td width="15%">
														    <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="manageDept" name="manageDept">
							      <input class="form-control" placeholder="请选择部门" type="text" id="manageDeptAlias" name="manageDeptAlias" >
							      <span class="input-group-addon" id="deptbtn">
							          <i class="glyphicon glyphicon-equalizer"></i>
							      </span>
						        </div>
						    						   </td>
																		   									 																	 																									<th width="10%">
						    						    <label for="managerIdAlias">实验室管理员:</label></th>
						    							<td width="15%">
															 <div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="managerId" name="managerId">
							      <input class="form-control" placeholder="请选择用户" type="text" id="managerIdAlias" name="managerIdAlias">
							      <span class="input-group-addon" id="userbtn">
							          <i class="glyphicon glyphicon-user"></i>
							      </span>
							    </div>
													   </td>
																		   									 																	 																									<th width="10%">
						    						  	<label for="createdDate">实验室创建日期:</label></th>
						    							<td width="15%">
														    <div class="input-group input-group-sm">
		                	      <input class="form-control date-picker" type="text" name="createdDate" id="createdDate" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
		              	        </div>
													   </td>
															</tr>
								<tr>
																		   									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 									 						</tr>
						<tr>
						  <th><label for="attachment">附件</label></th>
							<td colspan="<%=4 * 2 - 1%>">
								<div id="attachment"></div>
							</td>
						</tr>
				  </table>
			</form>
	</div>
	<div data-options="region:'south',border:false" style="height:60px;">
    	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>	
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0);" title="保存" id="saveButton" class="btn btn-primary form-tool-btn typeb btn-sm">保存</a>
						<a href="javascript:void(0);" title="返回" id="returnButton" class="btn btn-grey form-tool-btn btn-sm">返回</a>
					</td>	
				</tr>
			</table>
		</div>
	</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
// 关闭Dialog
function closeForm(){
	parent.assetsLabAccount.closeDialog('insert');
}

// 保存表单
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
   	$('#saveButton').addClass('disabled').unbind("click");
	parent.assetsLabAccount.save($('#form'), callback);
}

//上传附件
function callback(id) {
	var files = $('#attachment').uploaderExt('getUploadFiles');
	if(files == 0){
		closeForm();
	}else{
		$("#id").val(id);
		$('#attachment').uploaderExt('doUpload', id);
	}
}
//附件上传完后执行
function afterUploadEvent(){
	parent.assetsLabAccount.closeDialog('insert');
}

// 加载完后初始化
$(document).ready(function () {
	//初始化日期控件
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
	$('.date-picker').on('keydown',nullInput);
	$('.time-picker').on('keydown',nullInput);
	
	//初始化附件上传组件
	$('#attachment').uploaderExt({
		secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
		afterUpload: afterUploadEvent
	});
	
	//绑定表单验证规则
	parent.assetsLabAccount.formValidate($('#form'));
	
	//保存按钮绑定事件
	$('#saveButton').bind('click', function(){
		saveForm();
	}); 
	
	//返回按钮绑定事件
	$('#returnButton').bind('click', function(){
		closeForm();
	});
	
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  		        $('#manageDeptAlias').on('focus',function(e){
					new H5CommonSelect({type:'deptSelect', idFiled:'manageDept',textFiled:'manageDeptAlias'});
				    this.blur();
				    nullInput(e);
				});
				                                             		        $('#managerIdAlias').on('focus',function(e){
					new H5CommonSelect({type:'userSelect', idFiled:'managerId',textFiled:'managerIdAlias'});
				    this.blur();
				    nullInput(e);
				}); 
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  });
</script>
</body>
</html>