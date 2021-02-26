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
<!-- ControllerPath = "assets/device/dynusdassetsntc/dynUsdassetsNtcController/operation/toDetailJsp" -->
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
#t_assetsUstdtempapplyCollect{
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
						<input type="hidden" name="id" />
						<input type="hidden" name="version"/>
						<table class="form_commonTable">
							<tr>
																																																							 																										 																																					<th width="10%">
									    									    <label for="authorAlias">申请人:</label></th>
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
									    									  	<label for="applyYear">年度:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="applyYear"  id="applyYear" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="deptDeadline">部门上报截至日期:</label></th>
									    										<td width="15%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="deptDeadline" id="deptDeadline" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																											   															 															 															 																										 																																					<th width="10%">
									    									  	<label for="releasedate">发布日期:</label></th>
									    										<td width="15%">
																				    <div class="input-group input-group-sm">
					                	      <input class="form-control date-picker" type="text" name="releasedate" id="releasedate" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					              	        </div>
																			   </td>
																					</tr>
											<tr>
																											   															 																										 																																					<th width="10%">
									    									  	<label for="telephone">电话:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="telephone"  id="telephone" />
																			   </td>
																											   															 																										 																																					<th width="10%">
									    									    <label for="deptAlias">发布人部门:</label></th>
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
									    									  	<label for="formRemarks">备注:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="formRemarks"  id="formRemarks" />
																			   </td>
																											   															 															 															 															 																										 																																					<th width="10%">
									    									  	<label for="formTitle">标题:</label></th>
									    										<td width="15%">
																				    <input class="form-control input-sm" type="text" name="formTitle"  id="formTitle" />
																			   </td>
																					</tr>
											<tr>
																											   															 															 															 									</tr>
									<tr>
										<th width="99%" colspan="<%=4 * 2 %>">
											<div id="toolbar_AssetsUstdtempapplyCollect" class="toolbar">
												<div class="toolbar-left">
													<sec:accesscontrollist hasPermission="3"
														domainObject="formdialog_AssetsUstdtempapplyCollect_button_add"
														permissionDes="添加">
														<a id="assetsUstdtempapplyCollect_insert" href="javascript:void(0)"
															class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button"
															title="添加"><i class="fa fa-plus"></i> 添加</a>
													</sec:accesscontrollist>
													<sec:accesscontrollist hasPermission="3"
														domainObject="formdialog_AssetsUstdtempapplyCollect_button_delete"
														permissionDes="删除">
														<a id="assetsUstdtempapplyCollect_del" href="javascript:void(0)"
															class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button"
															title="删除"><i class="fa fa-trash-o"></i> 删除</a>
													</sec:accesscontrollist>
														<a class="btn btn-default form-tool-btn btn-sm bpm_self_class" style="display:none" title="子表数据是否可编辑" name="assetsUstdtempapplyCollect_editable" id="assetsUstdtempapplyCollect_editable" >是否可编辑</a>
												</div>
											</div>
											<table id="assetsUstdtempapplyCollect"></table>
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
	<script type="text/javascript" src="avicit/assets/device/dynusdassetsntc/js/DynUsdassetsNtcDetail.js"></script>
	<script type="text/javascript" src="avicit/assets/device/dynusdassetsntc/js/AssetsUstdtempapplyCollect.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     				     			     								     			     			 var deviceCategoryData = null;
             			     			     			     			     			     			     			     			     			     			     			     			 var isNeedInstallData = null;
             			     			     			 var isHumidityNeedData = null;
             			     			 var isWaterNeedData = null;
             			     			 var isGasNeedData = null;
             			     			 var isLetData = null;
             			     			 var isOtherNeedData = null;
             			     			 var isAboveConditionsData = null;
             			 var isMeteringData = null;
             			     			     			 var financialResourcesData = null;
             			     			     			     			     																							 var isTestDeviceData = null;
             			     			       //初始化通用代码值
  function initOnceInAdd(){
		avicAjax.ajax({
			 url:"platform/assets/device/dynusdassetsntc/dynUsdassetsNtcController/getLookUpCode",
			 type : 'post',
			 dataType : 'json',
			 async:false,
			 success : function(r){
				 if (r.flag == "success"){
				     																		 							 					    																		 					    																													 					    																		 					    																																																																									 					    																		 					    																		 					deviceCategoryData = JSON.parse(r.deviceCategoryData);
					         					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					    																		 					isNeedInstallData = JSON.parse(r.isNeedInstallData);
					         					    																		 					    																		 					    																		 					isHumidityNeedData = JSON.parse(r.isHumidityNeedData);
					         					    																		 					    																		 					isWaterNeedData = JSON.parse(r.isWaterNeedData);
					         					    																		 					    																		 					isGasNeedData = JSON.parse(r.isGasNeedData);
					         					    																		 					    																		 					isLetData = JSON.parse(r.isLetData);
					         					    																		 					    																		 					isOtherNeedData = JSON.parse(r.isOtherNeedData);
					         					    																		 					    																		 					isAboveConditionsData = JSON.parse(r.isAboveConditionsData);
					         					    																		 					isMeteringData = JSON.parse(r.isMeteringData);
					         					    																		 					    																		 					    																		 					financialResourcesData = JSON.parse(r.financialResourcesData);
					         					    																		 					    																		 					    																		 					    																		 					    																																																																																																																																																																																																																																														 					isTestDeviceData = JSON.parse(r.isTestDeviceData);
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
	var assetsUstdtempapplyCollectGridColModel = null;
			$(document).ready(function () {
		    var pid = "<%=pid%>";
			var isReload = "true";
			var searchSubNames = "";
			initOnceInAdd(); //初始化通用代码值
			assetsUstdtempapplyCollectGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   				   													,{ label: '申购单号', name: 'stdId', width: 150}
																		  		   			 			 											   				   													,{ label: '申请人部门', name: 'createdByDept', width: 150}
																		  		   			 			 			 			 			 			 			 			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150}
																		  		   			 											   				   			           							,{ label: '设备类别id', name: 'deviceCategory', width: 75, hidden:true}
   	                        ,{ label: '设备类别', name: 'deviceCategoryName', width: 150,  edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'deviceCategory', value: deviceCategoryData}}
									        							  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 											   				   													,{ label: '主管设备所领导', name: 'competentDeviceLeaderAlias', width: 150, edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'competentDeviceLeader'}}
                            ,{ label: '主管设备所领导id', name: 'competentDeviceLeader', width: 75, hidden:true }
																		  		   			 								 	];
			var surl = "platform/assets/device/dynusdassetsntc/dynUsdassetsNtcController/operation/sub/";
			var assetsUstdtempapplyCollect = new AssetsUstdtempapplyCollect('assetsUstdtempapplyCollect', surl,
					"formSub",
					assetsUstdtempapplyCollectGridColModel,
					'searchDialogSub', pid,searchSubNames, 'assetsUstdtempapplyCollect_keyWord',isReload);
			//创建业务操作JS
			var dynUsdassetsNtcDetail = new DynUsdassetsNtcDetail('form',assetsUstdtempapplyCollect);
			//创建流程操作JS
			new FlowEditor(dynUsdassetsNtcDetail);
			
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
			dynUsdassetsNtcDetail.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
				formId: '<%=pid%>',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
			});
			//添加按钮绑定事件
			$('#assetsUstdtempapplyCollect_insert').bind('click', function() {
				assetsUstdtempapplyCollect.insert();
			});
			//删除按钮绑定事件
			$('#assetsUstdtempapplyCollect_del').bind('click', function() {
				assetsUstdtempapplyCollect.del();
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