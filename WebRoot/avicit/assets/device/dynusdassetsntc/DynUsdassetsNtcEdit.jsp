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
<!-- ControllerPath = "assets/device/dynusdassetsntc/dynUsdassetsNtcController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_assetsUstdtempapplyCollect{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${dynUsdassetsNtcDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${dynUsdassetsNtcDTO.id}'/>"/>
																																																																																																																																																				 <table class="form_commonTable">
				<tr>
																																											 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="authorAlias">申请人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="author" name="author" value="<c:out  value='${dynUsdassetsNtcDTO.author}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias" value="<c:out  value='${dynUsdassetsNtcDTO.authorAlias}'/>">
										       <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="applyYear">年度:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="applyYear"  id="applyYear" value="<c:out  value='${dynUsdassetsNtcDTO.applyYear}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deptDeadline">部门上报截至日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="deptDeadline" id="deptDeadline" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${dynUsdassetsNtcDTO.deptDeadline}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="releasedate">发布日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="releasedate" id="releasedate" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${dynUsdassetsNtcDTO.releasedate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="telephone">电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="telephone"  id="telephone" value="<c:out  value='${dynUsdassetsNtcDTO.telephone}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="deptAlias">发布人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="dept" name="dept" value="<c:out  value='${dynUsdassetsNtcDTO.dept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias" value="<c:out  value='${dynUsdassetsNtcDTO.deptAlias}'/>">
									      <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formRemarks">备注:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formRemarks"  id="formRemarks" value="<c:out  value='${dynUsdassetsNtcDTO.formRemarks}'/>"/>
																	   </td>
																								   													 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formTitle">标题:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formTitle"  id="formTitle" value="<c:out  value='${dynUsdassetsNtcDTO.formTitle}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 												 												 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
								<div id="toolbar_assetsUstdtempapplyCollect" class="toolbar">
									<div class="toolbar-left">
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_assetsUstdtempapplyCollect_button_add"
											permissionDes="添加">
											<a id="assetsUstdtempapplyCollect_insert" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="添加"><i class="fa fa-plus"></i> 添加</a>
										</sec:accesscontrollist>
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_assetsUstdtempapplyCollect_button_delete"
											permissionDes="删除">
											<a id="assetsUstdtempapplyCollect_del" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="删除"><i class="fa fa-trash-o"></i> 删除</a>
										</sec:accesscontrollist>
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
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="dynUsdassetsNtc_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="dynUsdassetsNtc_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/device/dynusdassetsntc/js/AssetsUstdtempapplyCollect.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     				     			     								     			     			 var deviceCategoryData = ${deviceCategoryData};
             			     			     			     			     			     			     			     			     			     			     			     			 var isNeedInstallData = ${isNeedInstallData};
             			     			     			 var isHumidityNeedData = ${isHumidityNeedData};
             			     			 var isWaterNeedData = ${isWaterNeedData};
             			     			 var isGasNeedData = ${isGasNeedData};
             			     			 var isLetData = ${isLetData};
             			     			 var isOtherNeedData = ${isOtherNeedData};
             			     			 var isAboveConditionsData = ${isAboveConditionsData};
             			 var isMeteringData = ${isMeteringData};
             			     			     			 var financialResourcesData = ${financialResourcesData};
             			     			     			     			     																							 var isTestDeviceData = ${isTestDeviceData};
             			     			     	var afterUploadEvent = null;
	var assetsUstdtempapplyCollect;
	var assetsUstdtempapplyCollectGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   				   													,{ label: '申购单号', name: 'stdId', width: 150,editable:true}
																		  		   			 			 											   				   													,{ label: '申请人部门', name: 'createdByDept', width: 150,editable:true}
																		  		   			 			 			 			 			 			 			 			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150,editable:true}
																		  		   			 											   				   			           							,{ label: '设备类别id', name: 'deviceCategory', width: 75, hidden:true}
   	                        ,{ label: '设备类别', name: 'deviceCategoryName', width: 150, editable:true, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'deviceCategory', value: deviceCategoryData}}
									        							  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 											   				   													,{ label: '主管设备所领导', name: 'competentDeviceLeaderAlias', width: 150, editable:true,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'competentDeviceLeader'}}
                            ,{ label: '主管设备所领导id', name: 'competentDeviceLeader', width: 75, hidden:true , editable:true}
																		  		   			 								 	];
			function closeForm(){
			parent.dynUsdassetsNtc.closeDialog(window.name);
		}
		function saveForm(){
			var isValidate = $("#form").validate();
	        if (!isValidate.checkForm()) {
	            isValidate.showErrors();
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
   			$('#dynUsdassetsNtc_saveForm').addClass('disabled').unbind("click"); 
		    parent.dynUsdassetsNtc.save($('#form'),window.name);
		}
	
		$(document).ready(function () {
		    var pid = "${dynUsdassetsNtcDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/device/dynusdassetsntc/dynUsdassetsNtcController/operation/sub/";
			assetsUstdtempapplyCollect = new AssetsUstdtempapplyCollect('assetsUstdtempapplyCollect', surl,
					"formSub",
					assetsUstdtempapplyCollectGridColModel,
					'searchDialogSub', pid,searchSubNames, 'assetsUstdtempapplyCollect_keyWord',isReload);
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
			
			parent.dynUsdassetsNtc.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${dynUsdassetsNtcDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
			});
			//保存按钮绑定事件
			$('#dynUsdassetsNtc_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#dynUsdassetsNtc_closeForm').bind('click', function(){
				closeForm();
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