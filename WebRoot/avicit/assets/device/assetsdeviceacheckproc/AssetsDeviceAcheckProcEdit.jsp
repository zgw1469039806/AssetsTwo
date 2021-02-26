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
<!-- ControllerPath = "assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_assetsDeviceAcheckPlan{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsDeviceAcheckProcDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsDeviceAcheckProcDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																																																																																																 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="acheckCode">精度检查单号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="acheckCode"  id="acheckCode" value="<c:out  value='${assetsDeviceAcheckProcDTO.acheckCode}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="planName">计划名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="planName"  id="planName" value="<c:out  value='${assetsDeviceAcheckProcDTO.planName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="acheckNumber">精度检查数量:</label></th>
								    									<td width="15%">
																		   									  	<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input  class="form-control"  type="text" name="acheckNumber" id="acheckNumber" value="<c:out  value='${assetsDeviceAcheckProcDTO.acheckNumber}'/>" data-min="-999999999999" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										</div>
									 																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="implementationDepartmentAlias">实施部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="implementationDepartment" name="implementationDepartment" value="<c:out  value='${assetsDeviceAcheckProcDTO.implementationDepartment}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="implementationDepartmentAlias" name="implementationDepartmentAlias" value="<c:out  value='${assetsDeviceAcheckProcDTO.implementationDepartmentAlias}'/>">
									      <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="nextAccCheckDateBegin">精度检查开始时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="nextAccCheckDateBegin" id="nextAccCheckDateBegin" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAcheckProcDTO.nextAccCheckDateBegin}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="nextAccCheckDateEnd">精度检查结束时间:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="nextAccCheckDateEnd" id="nextAccCheckDateEnd" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAcheckProcDTO.nextAccCheckDateEnd}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="generateByAlias">计划生成人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="generateBy" name="generateBy" value="<c:out  value='${assetsDeviceAcheckProcDTO.generateBy}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="generateByAlias" name="generateByAlias" value="<c:out  value='${assetsDeviceAcheckProcDTO.generateByAlias}'/>">
										       <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
								<div id="toolbar_assetsDeviceAcheckPlan" class="toolbar">
									<div class="toolbar-left">
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_assetsDeviceAcheckPlan_button_add"
											permissionDes="添加">
											<a id="assetsDeviceAcheckPlan_insert" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="添加"><i class="fa fa-plus"></i> 添加</a>
										</sec:accesscontrollist>
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_assetsDeviceAcheckPlan_button_delete"
											permissionDes="删除">
											<a id="assetsDeviceAcheckPlan_del" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="删除"><i class="fa fa-trash-o"></i> 删除</a>
										</sec:accesscontrollist>
									</div>
								</div>
								<table id="assetsDeviceAcheckPlan"></table>
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="assetsDeviceAcheckProc_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsDeviceAcheckProc_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/device/assetsdeviceacheckproc/js/AssetsDeviceAcheckPlan.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     																																							     			     			 var deviceCategoryData = ${deviceCategoryData};
             			     			     			     			     			     			     			     			     			     			     			     			     			     	var afterUploadEvent = null;
	var assetsDeviceAcheckPlan;
	var assetsDeviceAcheckPlanGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 											   																		,{ label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150,editable:true}
																		  		   			 											   																		,{ label: '<span style="color:red;">*</span>设备名称', name: 'deviceName', width: 150,editable:true}
																		  		   			 											   				   			           							,{ label: '设备类别id', name: 'deviceCategory', width: 75, hidden:true}
   	                        ,{ label: '设备类别', name: 'deviceCategoryName', width: 150, editable:true, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'deviceCategory', value: deviceCategoryData}}
									        							  		   			 											   				   													,{ label: '设备型号', name: 'deviceModel', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '产地', name: 'productArea', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '安装地点', name: 'positionId', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '出厂日期', name: 'productDate', width: 150,editable:true, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 											   				   													,{ label: '使用人', name: 'userIdAlias', width: 150, editable:true,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'userId'}}
                            ,{ label: '使用人id', name: 'userId', width: 75, hidden:true , editable:true}
																		  		   			 											   				   													,{ label: '使用人部门', name: 'userDeptAlias', width: 150, editable:true,edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'userDept'}}
                            ,{ label: '使用人部门id', name: 'userDept', width: 75, hidden:true , editable:true}
																		  		   			 											   				   													,{ label: '上次精度检查时间', name: 'lastAccCheckDate', width: 150,editable:true, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 											   				   										     								   	                        ,{ label: '精度检查周期', name: 'accCheckCycle', width: 150, editable:true, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-0)%>,max:<%=Math.pow(10,12)-Math.pow(10,-0)%>,step:1,precision:0}}
																		  												  		   			 											   				   													,{ label: '下次精度检查时间', name: 'nextAccCheckDate', width: 150,editable:true, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 											   				   													,{ label: '附件', name: 'attachment', width: 150,editable:true}
																		  		   			 								 											   																		,{ label: '<span style="color:red;">*</span>台账的定检信息ID', name: 'checkId', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '精度检查时间', name: 'accCheckDate', width: 150,editable:true, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 	];
			function closeForm(){
			parent.assetsDeviceAcheckProc.closeDialog(window.name);
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
			var msg = assetsDeviceAcheckPlan.valid();
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
			$(assetsDeviceAcheckPlan._datagridId).jqGrid('endEditCell');
		 	var dataSubVo = $(assetsDeviceAcheckPlan._datagridId).jqGrid('getRowData');	
			var dataSub = JSON.stringify(dataSubVo);
	        //验证附件密级
		   	var files = $('#attachment').uploaderExt('getUploadFiles');
		   	for(var i = 0; i < files.length; i++){
		   		var name = files[i].name;
		   		var secretLevel = files[i].secretLevel;
		   		//这里验证密级
		   	}
	       	//限制保存按钮多次点击
   			$('#assetsDeviceAcheckProc_saveForm').addClass('disabled').unbind("click"); 
		    parent.assetsDeviceAcheckProc.save($('#form'),window.name,dataSub);
		}
	
		$(document).ready(function () {
		    var pid = "${assetsDeviceAcheckProcDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController/operation/sub/";
			assetsDeviceAcheckPlan = new AssetsDeviceAcheckPlan('assetsDeviceAcheckPlan', surl,
					"formSub",
					assetsDeviceAcheckPlanGridColModel,
					'searchDialogSub', pid,searchSubNames, 'assetsDeviceAcheckPlan_keyWord',isReload);
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
			
			parent.assetsDeviceAcheckProc.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsDeviceAcheckProcDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
			});
			//保存按钮绑定事件
			$('#assetsDeviceAcheckProc_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#assetsDeviceAcheckProc_closeForm').bind('click', function(){
				closeForm();
			});
			//添加按钮绑定事件
			$('#assetsDeviceAcheckPlan_insert').bind('click', function() {
				assetsDeviceAcheckPlan.insert();
			});
			//删除按钮绑定事件
			$('#assetsDeviceAcheckPlan_del').bind('click', function() {
				assetsDeviceAcheckPlan.del();
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