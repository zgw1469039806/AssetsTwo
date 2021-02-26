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
																		    <input class="form-control input-sm" type="text" name="allotNo"  id="allotNo" readonly="readonly" value="<c:out  value='${assetsAllotProcDTO.allotNo}'/>"/>
																	   </td>
																								   													 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByDeptAlias">申请人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept" value="<c:out  value='${assetsAllotProcDTO.createdByDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" readonly="readonly" name="createdByDeptAlias" value="<c:out  value='${assetsAllotProcDTO.createdByDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByTel">申请人电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" readonly="readonly" value="<c:out  value='${assetsAllotProcDTO.createdByTel}'/>"/>
																	   </td>
																								   													 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formState">单据状态:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out  value='${assetsAllotProcDTO.formState}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="callinDeptAlias">调入部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="callinDept" name="callinDept" value="<c:out  value='${assetsAllotProcDTO.callinDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="callinDeptAlias" readonly="readonly" name="callinDeptAlias" value="<c:out  value='${assetsAllotProcDTO.callinDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="assetsCompose">设备组成:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3" readonly="readonly"  name="assetsCompose" id="assetsCompose"><c:out  value='${assetsAllotProcDTO.assetsCompose}'/></textarea> 
																	   </td>
																								   													 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
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
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/device/assetsallotproc/js/AllotAssets.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     			     			     			     			     			 var secretLevelData = ${secretLevelData};
             			 var isSafetyProductionData = ${isSafetyProductionData};
             			     	var allotAssets;
	var allotAssetsGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   				   													,{ label: '统一编号', name: 'unifiedId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备型号', name: 'deviceModel', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备规格', name: 'deviceSpec', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '生产厂家', name: 'manufacturerId', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '密级id', name: 'secretLevel', width: 75, hidden:true}
   	                        ,{ label: '密级', name: 'secretLevelName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'secretLevel', value: secretLevelData}}
									        							  		   			 											   				   			           							,{ label: '是否涉及安全生产id', name: 'isSafetyProduction', width: 75, hidden:true}
   	                        ,{ label: '是否涉及安全生产', name: 'isSafetyProductionName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isSafetyProduction', value: isSafetyProductionData}}
									        							  		   			 								 	];
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
			});
			
			parent.assetsAllotProc.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsAllotProcDTO.id}',
				allowAdd: false,
				allowDelete: false
			});
		});
		//form控件禁用
		setFormDisabled();
		$(document).keydown(function(event){  
			event.returnValue = false;
			return false;
		});  
	</script>
</body>
</html>