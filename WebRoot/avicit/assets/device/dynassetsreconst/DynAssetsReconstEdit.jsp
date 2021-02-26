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
<!-- ControllerPath = "assets/device/dynassetsreconst/dynAssetsReconstController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_assetsReconstructionCheck{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${dynAssetsReconstDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${dynAssetsReconstDTO.id}'/>"/>
																																																																																																																																		 <table class="form_commonTable">
				<tr>
																																											 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="authorAlias">上报人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="author" name="author" value="<c:out  value='${dynAssetsReconstDTO.author}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias" value="<c:out  value='${dynAssetsReconstDTO.authorAlias}'/>">
										       <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="releasedate">上报日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="releasedate" id="releasedate" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${dynAssetsReconstDTO.releasedate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="deptAlias">上报单位:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="dept" name="dept" value="<c:out  value='${dynAssetsReconstDTO.dept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias" value="<c:out  value='${dynAssetsReconstDTO.deptAlias}'/>">
									      <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tel">电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="tel"  id="tel" value="<c:out  value='${dynAssetsReconstDTO.tel}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="collectYear">年度:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="collectYear"  id="collectYear" value="<c:out  value='${dynAssetsReconstDTO.collectYear}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="collectSelect">关联征集单:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="collectSelect"  id="collectSelect" value="<c:out  value='${dynAssetsReconstDTO.collectSelect}'/>"/>
																	   </td>
																								   													 												 												 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
								<div id="toolbar_assetsReconstructionCheck" class="toolbar">
									<div class="toolbar-left">
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_assetsReconstructionCheck_button_add"
											permissionDes="添加">
											<a id="assetsReconstructionCheck_insert" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="添加"><i class="fa fa-plus"></i> 添加</a>
										</sec:accesscontrollist>
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_assetsReconstructionCheck_button_delete"
											permissionDes="删除">
											<a id="assetsReconstructionCheck_del" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="删除"><i class="fa fa-trash-o"></i> 删除</a>
										</sec:accesscontrollist>
									</div>
								</div>
								<table id="assetsReconstructionCheck"></table>
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="dynAssetsReconst_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="dynAssetsReconst_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/device/dynassetsreconst/js/AssetsReconstructionCheck.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     				     			     								     			     			     			     			     			     			     			     			     			     			     			     			     			     			     			     																							     			 var deviceCategoryData = ${deviceCategoryData};
             			     	var afterUploadEvent = null;
	var assetsReconstructionCheck;
	var assetsReconstructionCheckGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   																		,{ label: '<span style="color:red;">*</span>改造申请单号', name: 'reconstructionId', width: 150,editable:true}
																		  		   			 			 											   				   													,{ label: '申请人部门', name: 'createdByDeptAlias', width: 150, editable:true,edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'createdByDept'}}
                            ,{ label: '申请人部门id', name: 'createdByDept', width: 75, hidden:true , editable:true}
																		  		   			 											   				   													,{ label: '单据状态', name: 'formState', width: 150,editable:true}
																		  		   			 			 			 			 			 			 											   				   													,{ label: '责任部门', name: 'ownerDeptAlias', width: 150, editable:true,edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'ownerDept'}}
                            ,{ label: '责任部门id', name: 'ownerDept', width: 75, hidden:true , editable:true}
																		  		   			 											   				   													,{ label: '责任人', name: 'ownerIdAlias', width: 150, editable:true,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'ownerId'}}
                            ,{ label: '责任人id', name: 'ownerId', width: 75, hidden:true , editable:true}
																		  		   			 											   				   													,{ label: '责任人联系方式', name: 'ownerTel', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '密级', name: 'secretLevel', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '统一编号', name: 'unifiedId', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '设备型号', name: 'deviceModel', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '设备规格', name: 'deviceSpec', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '生产厂家', name: 'manufacturerId', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '立卡时间', name: 'likaDate', width: 150,editable:true, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 											   				   										     								   	                        ,{ label: '设备原值', name: 'originalValue', width: 150, editable:true, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   													,{ label: '现有结构性能指标', name: 'existingPerformance', width: 150,editable:true}
																		  		   			 											   				   			               	                        ,{ label: '改造理由', name: 'reformingReason', width: 150,editable : true,   edittype:"textarea", editoptions : {rows:'1', maxlength : "1024"}}
																		  		   			 											   				   													,{ label: '改造后结构性能指标', name: 'afterPerformance', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '改造途径', name: 'transformWay', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '经费预算', name: 'budget', width: 150,editable:true}
																		  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 											   				   										     								   	                        ,{ label: '净值', name: 'netValue', width: 150, editable:true, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   			           							,{ label: '设备类别id', name: 'deviceCategory', width: 75, hidden:true}
   	                        ,{ label: '设备类别', name: 'deviceCategoryName', width: 150, editable:true, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'deviceCategory', value: deviceCategoryData}}
									        							  		   			 											   				   													,{ label: '申请人', name: 'createdByPerson', width: 150,editable:true}
																		  		   			 	];
			function closeForm(){
			parent.dynAssetsReconst.closeDialog(window.name);
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
			var msg = assetsReconstructionCheck.valid();
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
			$(assetsReconstructionCheck._datagridId).jqGrid('endEditCell');
		 	var dataSubVo = $(assetsReconstructionCheck._datagridId).jqGrid('getRowData');	
			var dataSub = JSON.stringify(dataSubVo);
	        //验证附件密级
		   	var files = $('#attachment').uploaderExt('getUploadFiles');
		   	for(var i = 0; i < files.length; i++){
		   		var name = files[i].name;
		   		var secretLevel = files[i].secretLevel;
		   		//这里验证密级
		   	}
	       	//限制保存按钮多次点击
   			$('#dynAssetsReconst_saveForm').addClass('disabled').unbind("click"); 
		    parent.dynAssetsReconst.save($('#form'),window.name,dataSub);
		}
	
		$(document).ready(function () {
		    var pid = "${dynAssetsReconstDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/device/dynassetsreconst/dynAssetsReconstController/operation/sub/";
			assetsReconstructionCheck = new AssetsReconstructionCheck('assetsReconstructionCheck', surl,
					"formSub",
					assetsReconstructionCheckGridColModel,
					'searchDialogSub', pid,searchSubNames, 'assetsReconstructionCheck_keyWord',isReload);
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
			
			parent.dynAssetsReconst.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${dynAssetsReconstDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
			});
			//保存按钮绑定事件
			$('#dynAssetsReconst_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#dynAssetsReconst_closeForm').bind('click', function(){
				closeForm();
			});
			//添加按钮绑定事件
			$('#assetsReconstructionCheck_insert').bind('click', function() {
				assetsReconstructionCheck.insert();
			});
			//删除按钮绑定事件
			$('#assetsReconstructionCheck_del').bind('click', function() {
				assetsReconstructionCheck.del();
			});
			
																											$('#authorAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'author',textFiled:'authorAlias'});
					    this.blur();
					    nullInput(e);
					}); 
				
																																																	$('#deptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'dept',textFiled:'deptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																																																																					
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>