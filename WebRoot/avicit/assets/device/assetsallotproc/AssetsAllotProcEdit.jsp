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
<!-- ControllerPath = "assets/device/assetsallotproc/assetsAllotProcController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_allotAssets{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsAllotProcDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsAllotProcDTO.id}'/>"/>
																																																																																																																									 <table class="form_commonTable">
				<tr>
																																											 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="allotNo">调拨单号:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="allotNo"  id="allotNo" value="<c:out  value='${assetsAllotProcDTO.allotNo}'/>"/>
																	   </td>
																								   													 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByDeptAlias">申请人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept" value="<c:out  value='${assetsAllotProcDTO.createdByDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" value="<c:out  value='${assetsAllotProcDTO.createdByDeptAlias}'/>">
									      <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByTel">申请人电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" value="<c:out  value='${assetsAllotProcDTO.createdByTel}'/>"/>
																	   </td>
																								   													 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formState">单据状态:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formState"  id="formState" value="<c:out  value='${assetsAllotProcDTO.formState}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="callinDeptAlias">调入部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="callinDept" name="callinDept" value="<c:out  value='${assetsAllotProcDTO.callinDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="callinDeptAlias" name="callinDeptAlias" value="<c:out  value='${assetsAllotProcDTO.callinDeptAlias}'/>">
									      <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="assetsCompose">设备组成:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3"   name="assetsCompose" id="assetsCompose"><c:out  value='${assetsAllotProcDTO.assetsCompose}'/></textarea> 
																	   </td>
																								   													 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
								<div id="toolbar_allotAssets" class="toolbar">
									<div class="toolbar-left">
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_allotAssets_button_add"
											permissionDes="添加">
											<a id="allotAssets_insert" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="添加"><i class="fa fa-plus"></i> 添加</a>
										</sec:accesscontrollist>
										<sec:accesscontrollist hasPermission="3"
											domainObject="formdialog_allotAssets_button_delete"
											permissionDes="删除">
											<a id="allotAssets_del" href="javascript:void(0)"
												class="btn btn-default form-tool-btn btn-sm" role="button"
												title="删除"><i class="fa fa-trash-o"></i> 删除</a>
										</sec:accesscontrollist>
									</div>
								</div>
								<table id="allotAssets"></table>
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
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="assetsAllotProc_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsAllotProc_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/device/assetsallotproc/js/AllotAssets.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     			     			     			     			     			 var secretLevelData = ${secretLevelData};
             			 var isSafetyProductionData = ${isSafetyProductionData};
             			     	var afterUploadEvent = null;
	var allotAssets;
	var allotAssetsGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   				   													,{ label: '统一编号', name: 'unifiedId', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '设备型号', name: 'deviceModel', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '设备规格', name: 'deviceSpec', width: 150,editable:true}
																		  		   			 											   				   													,{ label: '生产厂家', name: 'manufacturerId', width: 150,editable:true}
																		  		   			 											   				   			           							,{ label: '密级id', name: 'secretLevel', width: 75, hidden:true}
   	                        ,{ label: '密级', name: 'secretLevelName', width: 150, editable:true, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'secretLevel', value: secretLevelData}}
									        							  		   			 											   				   			           							,{ label: '是否涉及安全生产id', name: 'isSafetyProduction', width: 75, hidden:true}
   	                        ,{ label: '是否涉及安全生产', name: 'isSafetyProductionName', width: 150, editable:true, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isSafetyProduction', value: isSafetyProductionData}}
									        							  		   			 								 	];
			function closeForm(){
			parent.assetsAllotProc.closeDialog(window.name);
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
			var msg = allotAssets.valid();
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
			$(allotAssets._datagridId).jqGrid('endEditCell');
		 	var dataSubVo = $(allotAssets._datagridId).jqGrid('getRowData');	
			var dataSub = JSON.stringify(dataSubVo);
	        //验证附件密级
		   	var files = $('#attachment').uploaderExt('getUploadFiles');
		   	for(var i = 0; i < files.length; i++){
		   		var name = files[i].name;
		   		var secretLevel = files[i].secretLevel;
		   		//这里验证密级
		   	}
	       	//限制保存按钮多次点击
   			$('#assetsAllotProc_saveForm').addClass('disabled').unbind("click"); 
		    parent.assetsAllotProc.save($('#form'),window.name,dataSub);
		}
	
		$(document).ready(function () {
		    var pid = "${assetsAllotProcDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/device/assetsallotproc/assetsAllotProcController/operation/sub/";
			allotAssets = new AllotAssets('allotAssets', surl,
					"formSub",
					allotAssetsGridColModel,
					'searchDialogSub', pid,searchSubNames, 'allotAssets_keyWord',isReload);
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
			
			parent.assetsAllotProc.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsAllotProcDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function(){return afterUploadEvent();}
			});
			//保存按钮绑定事件
			$('#assetsAllotProc_saveForm').bind('click', function(){
				saveForm();
			}); 
			//返回按钮绑定事件
			$('#assetsAllotProc_closeForm').bind('click', function(){
				closeForm();
			});
			//添加按钮绑定事件
			$('#allotAssets_insert').bind('click', function() {
				allotAssets.insert();
			});
			//删除按钮绑定事件
			$('#allotAssets_del').bind('click', function() {
				allotAssets.del();
			});
			
																																																	$('#createdByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'createdByDept',textFiled:'createdByDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																																																													$('#callinDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'callinDept',textFiled:'callinDeptAlias'});
					    this.blur();
					    nullInput(e);
					});
																																
			$('.date-picker').on('keydown',nullInput);
			$('.time-picker').on('keydown',nullInput);
		});
	</script>
</body>
</html>