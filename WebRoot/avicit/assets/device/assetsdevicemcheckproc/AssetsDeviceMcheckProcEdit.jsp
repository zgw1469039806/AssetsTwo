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
<!-- ControllerPath = "assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_assetsDeviceMcheckPlan{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsDeviceMcheckProcDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsDeviceMcheckProcDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																																																																																																																		 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="maintainCode">年度保养单号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="maintainCode"  id="maintainCode" value="<c:out  value='${assetsDeviceMcheckProcDTO.maintainCode}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="planName">计划名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="planName"  id="planName" value="<c:out  value='${assetsDeviceMcheckProcDTO.planName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="maintainNumber">年度保养数量:</label></th>
								    									<td width="15%">
																		   									 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="maintainNumber" id="maintainNumber" value="<c:out  value='${assetsDeviceMcheckProcDTO.maintainNumber}'/>" data-min="-<%=Math.pow(10,11)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,11)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
									 										 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="generateDate">生成时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="generateDate" id="generateDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceMcheckProcDTO.generateDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="implementationDepartmentAlias">实施部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="implementationDepartment" name="implementationDepartment" value="<c:out  value='${assetsDeviceMcheckProcDTO.implementationDepartment}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="implementationDepartmentAlias" name="implementationDepartmentAlias" value="<c:out  value='${assetsDeviceMcheckProcDTO.implementationDepartmentAlias}'/>">
									      <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="generateByAlias">计划生成人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="generateBy" name="generateBy" value="<c:out  value='${assetsDeviceMcheckProcDTO.generateBy}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="generateByAlias" name="generateByAlias" value="<c:out  value='${assetsDeviceMcheckProcDTO.generateByAlias}'/>">
										       <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="nextMaintainDateBegin">年度保养开始时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="nextMaintainDateBegin" id="nextMaintainDateBegin" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceMcheckProcDTO.nextMaintainDateBegin}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="nextMaintainDateEnd">年度保养结束时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="nextMaintainDateEnd" id="nextMaintainDateEnd" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceMcheckProcDTO.nextMaintainDateEnd}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="attachment">附件:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="attachment"  id="attachment" value="<c:out  value='${assetsDeviceMcheckProcDTO.attachment}'/>"/>
																	   </td>
																								   													 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
								<div id="toolbar_assetsDeviceMcheckPlan" class="toolbar">
									<div class="toolbar-left">
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_assetsDeviceMcheckPlan_button_add"
											permissionDes="添加">
											<a id="assetsDeviceMcheckPlan_insert" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="添加"><i class="fa fa-plus"></i> 添加</a>
										</sec:accesscontrollist>
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_assetsDeviceMcheckPlan_button_delete"
											permissionDes="删除">
											<a id="assetsDeviceMcheckPlan_del" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="删除"><i class="fa fa-trash-o"></i> 删除</a>
										</sec:accesscontrollist>
									</div>
								</div>
								<table id="assetsDeviceMcheckPlan"></table>
							</th>
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="assetsDeviceMcheckProc_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsDeviceMcheckProc_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/device/assetsdevicemcheckproc/js/AssetsDeviceMcheckPlan.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     																																							     			     			 var deviceCategoryData = ${deviceCategoryData};
             			     			     			     			     			     			     			 var maintainItemData = ${maintainItemData};
             			 var maintainModeData = ${maintainModeData};
             			     			     			     			     			     			     	var afterUploadEvent = null;
	var assetsDeviceMcheckPlan;
	var assetsDeviceMcheckPlanGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 											   																		,{ label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150,editable:true}
																		  		   			 											   																		,{ label: '<span style="color:red;">*</span>设备名称', name: 'deviceName', width: 150,editable:true}
																		  		   			 											   				   			           							,{ label: '设备类别id', name: 'deviceCategory', width: 75, hidden:true}
   	                        ,{ label: '设备类别', name: 'deviceCategoryName', width: 150, editable:true, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'deviceCategory', value: deviceCategoryData}}
									        							  		   			 											   				   													,{ label: '设备型号', name: 'deviceModel', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '责任人', name: 'ownerIdAlias', width: 150, editable:true,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'ownerId'}}
                            ,{ label: '责任人id', name: 'ownerId', width: 75, hidden:true , editable:true}
																		  		   			 											   				   													,{ label: '责任人部门', name: 'ownerDeptAlias', width: 150, editable:true,edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'ownerDept'}}
                            ,{ label: '责任人部门id', name: 'ownerDept', width: 75, hidden:true , editable:true}
																		  		   			 											   				   													,{ label: '安装地点', name: 'positionId', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '保养部位', name: 'maintainPosition', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '保养内容', name: 'maintainContent', width: 150,editable:true}
																		  		   			 											   				   			           							,{ label: '保养项目id', name: 'maintainItem', width: 75, hidden:true}
   	                        ,{ label: '保养项目', name: 'maintainItemName', width: 150, editable:true, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'maintainItem', value: maintainItemData}}
									        							  		   			 											   				   			           							,{ label: '保养方式id', name: 'maintainMode', width: 75, hidden:true}
   	                        ,{ label: '保养方式', name: 'maintainModeName', width: 150, editable:true, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'maintainMode', value: maintainModeData}}
									        							  		   			 											   				   													,{ label: '保养周期', name: 'maintainCycle', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '上次保养时间', name: 'lastMaintainDate', width: 150,editable:true, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 											   				   													,{ label: '下次保养时间', name: 'nextMaintainDate', width: 150,editable:true, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 								 											   				   													,{ label: '台账年度保养表ID', name: 'maintainId', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '保养时间', name: 'maintainDate', width: 150,editable:true, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 	];
			function closeForm(){
			parent.assetsDeviceMcheckProc.closeDialog(window.name);
		}
		function saveForm(){
			//主表表单校验
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
	            $(isValidate.errorList[0].element).focus();
	            return false;
	        }
	        //子表校验
			var msg = assetsDeviceMcheckPlan.valid();
			if(msg && msg != ""){
				layer.alert(msg, {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
				return false;
			}
			//子表数据
			$(assetsDeviceMcheckPlan._datagridId).jqGrid('endEditCell');
		 	var dataSubVo = $(assetsDeviceMcheckPlan._datagridId).jqGrid('getRowData');	
			var dataSub = JSON.stringify(dataSubVo);
	        //验证附件密级
		   	var files = $('#attachment').uploaderExt('getUploadFiles');
		   	for(var i = 0; i < files.length; i++){
		   		var name = files[i].name;
		   		var secretLevel = files[i].secretLevel;
		   		//这里验证密级
		   	}
	       	//限制保存按钮多次点击
   			$('#assetsDeviceMcheckProc_saveForm').addClass('disabled').unbind("click"); 
		    parent.assetsDeviceMcheckProc.save($('#form'),window.name,dataSub);
		}
	
		$(document).ready(function () {
		    var pid = "${assetsDeviceMcheckProcDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/operation/sub/";
			assetsDeviceMcheckPlan = new AssetsDeviceMcheckPlan('assetsDeviceMcheckPlan', surl,
					"formSub",
					assetsDeviceMcheckPlanGridColModel,
					'searchDialogSub', pid,searchSubNames, 'assetsDeviceMcheckPlan_keyWord',isReload);
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
			
			parent.assetsDeviceMcheckProc.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsDeviceMcheckProcDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
			});
			//保存按钮绑定事件
			$('#assetsDeviceMcheckProc_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#assetsDeviceMcheckProc_closeForm').bind('click', function(){
				closeForm();
			});
			//添加按钮绑定事件
			$('#assetsDeviceMcheckPlan_insert').bind('click', function() {
				assetsDeviceMcheckPlan.insert();
			});
			//删除按钮绑定事件
			$('#assetsDeviceMcheckPlan_del').bind('click', function() {
				assetsDeviceMcheckPlan.del();
			});
			
																																																																																																																																																																																																																			$('#implementationDepartmentAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'implementationDepartment',textFiled:'implementationDepartmentAlias'});
					    this.blur();
					    nullInput(e);
					});
																								$('#generateByAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'generateBy',textFiled:'generateByAlias'});
					    this.blur();
					    nullInput(e);
					}); 
				
																																																																						
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>