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
<!-- ControllerPath = "assets/furniture/assetsfurniturerepairproc/assetsFurnitureRepairProcController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_assetsFurnitureRepairSub{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsFurnitureRepairProcDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsFurnitureRepairProcDTO.id}'/>"/>
																																																																																																																																																													 <table class="form_commonTable">
				<tr>
																																											 												 												 												 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="procName">流程名称:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="procName"  id="procName" readonly="readonly" value="<c:out  value='${assetsFurnitureRepairProcDTO.procName}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="procId">流程ID:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="procId"  id="procId" readonly="readonly" value="<c:out  value='${assetsFurnitureRepairProcDTO.procId}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formState">单据状态:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out  value='${assetsFurnitureRepairProcDTO.formState}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByPersonAlias">申请人:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="createdByPerson" name="createdByPerson" value="<c:out  value='${assetsFurnitureRepairProcDTO.createdByPerson}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias" readonly="readonly" name="createdByPersonAlias" value="<c:out  value='${assetsFurnitureRepairProcDTO.createdByPersonAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByDeptAlias">申请人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept" value="<c:out  value='${assetsFurnitureRepairProcDTO.createdByDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" readonly="readonly" name="createdByDeptAlias" value="<c:out  value='${assetsFurnitureRepairProcDTO.createdByDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByTel">申请人电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" readonly="readonly" value="<c:out  value='${assetsFurnitureRepairProcDTO.createdByTel}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="repairReason">家具损坏原因及损坏情况:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3" readonly="readonly"  name="repairReason" id="repairReason"><c:out  value='${assetsFurnitureRepairProcDTO.repairReason}'/></textarea> 
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="repairCondition">修理情况:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3" readonly="readonly"  name="repairCondition" id="repairCondition"><c:out  value='${assetsFurnitureRepairProcDTO.repairCondition}'/></textarea> 
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="remarks">备注:</label></th>
								    									<td width="15%">
																		    <textarea class="form-control input-sm" rows="3" readonly="readonly"  name="remarks" id="remarks"><c:out  value='${assetsFurnitureRepairProcDTO.remarks}'/></textarea> 
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="repairExpenses">维修费用:</label></th>
								    									<td width="15%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="repairExpenses" id="repairExpenses" readonly="readonly" value="<c:out  value='${assetsFurnitureRepairProcDTO.repairExpenses}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-step="1" data-precision="2">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																								   													 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
								<table id="assetsFurnitureRepairSub"></table>
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
	<script type="text/javascript" src="avicit/assets/furniture/assetsfurniturerepairproc/js/AssetsFurnitureRepairSub.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     									     			     			     			 var furnitureCategoryData = ${furnitureCategoryData};
             			     			     			     			     			     			     			     			     			     			 var furnitureStateData = ${furnitureStateData};
             			     			     			     	var assetsFurnitureRepairSub;
	var assetsFurnitureRepairSubGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 								 			 			 			 			 			 			 											   																		,{ label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '资产编号', name: 'assetId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '家具名称', name: 'furnitureName', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '家具分类id', name: 'furnitureCategory', width: 75, hidden:true}
   	                        ,{ label: '家具分类', name: 'furnitureCategoryName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'furnitureCategory', value: furnitureCategoryData}}
									        							  		   			 											   				   													,{ label: '家具规格', name: 'furnitureSpec', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '责任人', name: 'ownerIdAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'ownerId'}}
                            ,{ label: '责任人id', name: 'ownerId', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '责任人部门', name: 'ownerDeptAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'ownerDept'}}
                            ,{ label: '责任人部门id', name: 'ownerDept', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '使用人', name: 'userIdAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'userId'}}
                            ,{ label: '使用人id', name: 'userId', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '使用人部门', name: 'userDeptAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'userDept'}}
                            ,{ label: '使用人部门id', name: 'userDept', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '生产厂家', name: 'manufacturerId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '立卡日期', name: 'createdDate', width: 150,editable:false, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 											   				   													,{ label: '安装地点ID', name: 'positionId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '家具照片', name: 'furniturePhoto', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '家具状态id', name: 'furnitureState', width: 75, hidden:true}
   	                        ,{ label: '家具状态', name: 'furnitureStateName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'furnitureState', value: furnitureStateData}}
									        							  		   			 											   				   										     								   	                        ,{ label: '原值', name: 'originalValue', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   										     								   	                        ,{ label: '净值', name: 'netValue', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   													,{ label: '质保截止日期', name: 'guaranteeDate', width: 150,editable:false, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 	];
				$(document).ready(function () {
		    var pid = "${assetsFurnitureRepairProcDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/furniture/assetsfurniturerepairproc/assetsFurnitureRepairProcController/operation/sub/";
			assetsFurnitureRepairSub = new AssetsFurnitureRepairSub('assetsFurnitureRepairSub', surl,
					"formSub",
					assetsFurnitureRepairSubGridColModel,
					'searchDialogSub', pid,searchSubNames, 'assetsFurnitureRepairSub_keyWord',isReload);
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.assetsFurnitureRepairProc.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsFurnitureRepairProcDTO.id}',
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