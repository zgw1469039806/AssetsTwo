<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
	String importlibs = "common,form,table,fileupload,tree";
	String pid = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "assets/device/dynassetsreconst/dynAssetsReconstController/operation/toDetailJsp" -->
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
<style type="text/css">
#t_assetsReconstructionCheck{
   display:none;
}
</style>
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
									    									    <label for="authorAlias">上报人:</label></th>
									    										<td width="15%">
																					 <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="author" name="author">
										      <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias">
										      <span class="input-group-addon" >
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
										    </div>
																			   </td>
																											   															 															 															 																										 																																					<th width="10%">
									    									  	<label for="releasedate">上报日期:</label></th>
									    										<td width="15%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="releasedate" id="releasedate" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									    <label for="deptAlias">上报单位:</label></th>
									    										<td width="15%">
																				    <div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="dept" name="dept">
										      <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias" >
										       <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
									        </div>
									    									   </td>
																											   															 															 															 															 																										 																																					<th width="10%">
									    									  	<label for="tel">电话:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="tel"  id="tel" />
																			   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="collectYear">年度:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="collectYear"  id="collectYear" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="collectSelect">关联征集单:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="collectSelect"  id="collectSelect" />
																			   </td>
																											   															 															 															 									</tr>
									<tr>
										<th width="99%" colspan="<%=4 * 2 %>">
											<div id="toolbar_AssetsReconstructionCheck" class="toolbar">
												<div class="toolbar-left">
													<sec:accesscontrollist hasPermission="3"
														domainObject="formdialog_AssetsReconstructionCheck_button_add"
														permissionDes="添加">
														<a id="assetsReconstructionCheck_insert" href="javascript:void(0)"
															class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button"
															title="添加"><i class="fa fa-plus"></i> 添加</a>
													</sec:accesscontrollist>
													<sec:accesscontrollist hasPermission="3"
														domainObject="formdialog_AssetsReconstructionCheck_button_delete"
														permissionDes="删除">
														<a id="assetsReconstructionCheck_del" href="javascript:void(0)"
															class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button"
															title="删除"><i class="fa fa-trash-o"></i> 删除</a>
													</sec:accesscontrollist>
														<a class="btn btn-default form-tool-btn btn-sm bpm_self_class" style="display:none" title="子表数据是否可编辑" name="assetsReconstructionCheck_editable" id="assetsReconstructionCheck_editable" >是否可编辑</a>
												</div>
											</div>
											<table id="assetsReconstructionCheck" name="ASSETS_RECONSTRUCTION_CHECK" class="customform_subtable_bpm_auth"></table>
																																															 													 											    																																				 											         	<pt6:h5resource label="改造申请单号" name="reconstructionId" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																																											 														<pt6:h5resource label="申请人部门" name="createdByDeptAlias" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource> 
											         											    																																				 											         	<pt6:h5resource label="单据状态" name="formState" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																																																																																																																																							 														<pt6:h5resource label="责任部门" name="ownerDeptAlias" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource> 
											         											    																																				 														<pt6:h5resource label="责任人" name="ownerIdAlias" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource> 
											         											    																																				 											         	<pt6:h5resource label="责任人联系方式" name="ownerTel" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="设备名称" name="deviceName" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="密级" name="secretLevel" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="统一编号" name="unifiedId" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="设备型号" name="deviceModel" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="设备规格" name="deviceSpec" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="生产厂家" name="manufacturerId" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="立卡时间" name="likaDate" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="设备原值" name="originalValue" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="现有结构性能指标" name="existingPerformance" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="改造理由" name="reformingReason" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="改造后结构性能指标" name="afterPerformance" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="改造途径" name="transformWay" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="经费预算" name="budget" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																 											         	<pt6:h5resource label="净值" name="netValue" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
											         											    																																				 											         	<pt6:h5resource label="设备类别" name="deviceCategoryName" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource> 
											         											    																																				 											         	<pt6:h5resource label="申请人" name="createdByPerson" ref_table="ASSETS_RECONSTRUCTION_CHECK"></pt6:h5resource>
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
	<script type="text/javascript" src="avicit/assets/device/dynassetsreconst/js/DynAssetsReconstDetail.js"></script>
	<script type="text/javascript" src="avicit/assets/device/dynassetsreconst/js/AssetsReconstructionCheck.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     				     			     								     			     			     			     			     			     			     			     			     			     			     			     			     			     			     			     																							     			 var deviceCategoryData = null;
             			       //初始化通用代码值
  function initOnceInAdd(){
		avicAjax.ajax({
			 url:"platform/assets/device/dynassetsreconst/dynAssetsReconstController/getLookUpCode",
			 type : 'post',
			 dataType : 'json',
			 async:false,
			 success : function(r){
				 if (r.flag == "success"){
				     																		 							 					    																		 					    																													 					    																		 					    																																																																									 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																																																																																																																																																																																																																																														 					    																		 					deviceCategoryData = JSON.parse(r.deviceCategoryData);
					         					    																		 					    									 }else{
					 layer.alert('获取失败！' + r.error,{
						  icon: 7,
						  area: ['400px', ''], //宽高
						  closeBtn: 0,
						  btn: ['关闭'],
				          title:"提示"
					    }
			         );
				 } 
			 }
		 });
    };
    
	var afterUploadEvent = null;
	var assetsReconstructionCheckGridColModel = null;
			$(document).ready(function () {
		    var pid = "<%=pid%>";
			var isReload = "true";
			var searchSubNames = "";
			initOnceInAdd(); //初始化通用代码值
			assetsReconstructionCheckGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   																		,{ label: '改造申请单号', name: 'reconstructionId', width: 150}
																		  		   			 			 											   				   													,{ label: '申请人部门', name: 'createdByDeptAlias', width: 150, edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'createdByDept'}}
                            ,{ label: '申请人部门id', name: 'createdByDept', width: 75, hidden:true }
																		  		   			 											   				   													,{ label: '单据状态', name: 'formState', width: 150}
																		  		   			 			 			 			 			 			 											   				   													,{ label: '责任部门', name: 'ownerDeptAlias', width: 150, edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'ownerDept'}}
                            ,{ label: '责任部门id', name: 'ownerDept', width: 75, hidden:true }
																		  		   			 											   				   													,{ label: '责任人', name: 'ownerIdAlias', width: 150, edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'ownerId'}}
                            ,{ label: '责任人id', name: 'ownerId', width: 75, hidden:true }
																		  		   			 											   				   													,{ label: '责任人联系方式', name: 'ownerTel', width: 150}
																		  		   			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150}
																		  		   			 											   				   													,{ label: '密级', name: 'secretLevel', width: 150}
																		  		   			 											   				   													,{ label: '统一编号', name: 'unifiedId', width: 150}
																		  		   			 											   				   													,{ label: '设备型号', name: 'deviceModel', width: 150}
																		  		   			 											   				   													,{ label: '设备规格', name: 'deviceSpec', width: 150}
																		  		   			 											   				   													,{ label: '生产厂家', name: 'manufacturerId', width: 150}
																		  		   			 											   				   													,{ label: '立卡时间', name: 'likaDate', width: 150, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 											   				   										     								   	                        ,{ label: '设备原值', name: 'originalValue', width: 150,  edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   													,{ label: '现有结构性能指标', name: 'existingPerformance', width: 150}
																		  		   			 											   				   			               	                        ,{ label: '改造理由', name: 'reformingReason', width: 150, edittype:"textarea", editoptions : {rows:'1', maxlength : "1024"}}
																		  		   			 											   				   													,{ label: '改造后结构性能指标', name: 'afterPerformance', width: 150}
																		  		   			 											   				   													,{ label: '改造途径', name: 'transformWay', width: 150}
																		  		   			 											   				   													,{ label: '经费预算', name: 'budget', width: 150}
																		  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 											   				   										     								   	                        ,{ label: '净值', name: 'netValue', width: 150,  edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   			           							,{ label: '设备类别id', name: 'deviceCategory', width: 75, hidden:true}
   	                        ,{ label: '设备类别', name: 'deviceCategoryName', width: 150,  edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'deviceCategory', value: deviceCategoryData}}
									        							  		   			 											   				   													,{ label: '申请人', name: 'createdByPerson', width: 150}
																		  		   			 	];
			var surl = "platform/assets/device/dynassetsreconst/dynAssetsReconstController/operation/sub/";
			var assetsReconstructionCheck = new AssetsReconstructionCheck('assetsReconstructionCheck', surl,
					"formSub",
					assetsReconstructionCheckGridColModel,
					'searchDialogSub', pid,searchSubNames, 'assetsReconstructionCheck_keyWord',isReload);
			//创建业务操作JS
			var dynAssetsReconstDetail = new DynAssetsReconstDetail('form',assetsReconstructionCheck);
			//创建流程操作JS
			new FlowEditor(dynAssetsReconstDetail);
			
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
			$('.date-picker').datepicker({yearRange:"c-100:c+10"}); //时间控件增加年度选择
			
			//绑定表单验证规则
			dynAssetsReconstDetail.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
				formId: '<%=pid%>',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
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