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
<!-- ControllerPath = "assets/furniture/assetsfurnitureacceptance/assetsFurnitureAcceptanceController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_assetsFurAcceptanceRel{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsFurnitureAcceptanceDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsFurnitureAcceptanceDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																																																																	 <table class="form_commonTable">
				<tr>
																																											 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="acceptanceNo">验收单号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="acceptanceNo"  id="acceptanceNo" readonly="readonly" value="<c:out  value='${assetsFurnitureAcceptanceDTO.acceptanceNo}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="furNo">申购单号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="furNo"  id="furNo" readonly="readonly" value="<c:out  value='${assetsFurnitureAcceptanceDTO.furNo}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="buyerAlias">采购员:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="buyer" name="buyer" value="<c:out  value='${assetsFurnitureAcceptanceDTO.buyer}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="buyerAlias" name="buyerAlias" readonly="readonly" value="<c:out  value='${assetsFurnitureAcceptanceDTO.buyerAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByPersionAlias">申请人:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="createdByPersion" name="createdByPersion" value="<c:out  value='${assetsFurnitureAcceptanceDTO.createdByPersion}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersionAlias" name="createdByPersionAlias" readonly="readonly" value="<c:out  value='${assetsFurnitureAcceptanceDTO.createdByPersionAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByDeptAlias">申请人部门:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept" value="<c:out  value='${assetsFurnitureAcceptanceDTO.createdByDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" readonly="readonly" value="<c:out  value='${assetsFurnitureAcceptanceDTO.createdByDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																																								   													 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="applyReason">申购原因:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="applyReason"  id="applyReason" readonly="readonly" value="<c:out  value='${assetsFurnitureAcceptanceDTO.applyReason}'/>"/>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="contractNum">合同号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="contractNum"  id="contractNum" readonly="readonly" value="<c:out  value='${assetsFurnitureAcceptanceDTO.contractNum}'/>"/>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="arrivalDate">预计到货时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="arrivalDate" id="arrivalDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsFurnitureAcceptanceDTO.arrivalDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="actuallyDate">实际到货时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="actuallyDate" id="actuallyDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsFurnitureAcceptanceDTO.actuallyDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formPrice">单据总金额:</label></th>
								    									<td width="39%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="formPrice" id="formPrice" readonly="readonly" value="<c:out  value='${assetsFurnitureAcceptanceDTO.formPrice}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
											  <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
											</div>
																			 																	   </td>
																			</tr>
										<tr>
																																								   													 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 												 						</tr>
						<tr>
							<th width="99%" colspan="<%=2 * 2 %>">
								<table id="assetsFurAcceptanceRel"></table>
							</th>
						</tr>
						<tr>
						    <th><label for="attachment">附件</label></th>
							<td colspan="<%=2 * 2 - 1%>">
								<div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
							</td>
						</tr>
					</table>
			</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/furniture/assetsfurnitureacceptance/js/AssetsFurAcceptanceRel.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     									     			 var furnitureCategoryData = ${furnitureCategoryData};
             			     			     			     			     			     			     			     			     																					var assetsFurAcceptanceRel;
	var assetsFurAcceptanceRelGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 								 			 			 			 			 			 			 											   				   													,{ label: '家具名称', name: 'furnitureName', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '家具分类id', name: 'furnitureCategory', width: 75, hidden:true}
   	                        ,{ label: '家具分类', name: 'furnitureCategoryName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'furnitureCategory', value: furnitureCategoryData}}
									        							  		   			 											   				   													,{ label: '生产厂家', name: 'manufacturerId', width: 150,editable:false}
																		  		   			 											   				   										     								   	                        ,{ label: '质保期(单位：天)', name: 'guaranteePeriod', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-0)%>,max:<%=Math.pow(10,12)-Math.pow(10,-0)%>,step:1,precision:0}}
																		  												  		   			 											   				   													,{ label: '质保截止日期', name: 'guaranteeDate', width: 150,editable:false, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 											   				   													,{ label: '规格', name: 'furnitureSpec', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '安装地点ID', name: 'positionId', width: 150,editable:false}
																		  		   			 											   				   										     								   	                        ,{ label: '验收数量', name: 'checkNum', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-0)%>,max:<%=Math.pow(10,12)-Math.pow(10,-0)%>,step:1,precision:0}}
																		  												  		   			 											   				   										     								   	                        ,{ label: '采购单价', name: 'unitPrice', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   										     								   	                        ,{ label: '采购总价', name: 'totalPrice', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 	];
				$(document).ready(function () {
		    var pid = "${assetsFurnitureAcceptanceDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/furniture/assetsfurnitureacceptance/assetsFurnitureAcceptanceController/operation/sub/";
			assetsFurAcceptanceRel = new AssetsFurAcceptanceRel('assetsFurAcceptanceRel', surl,
					"formSub",
					assetsFurAcceptanceRelGridColModel,
					'searchDialogSub', pid,searchSubNames, 'assetsFurAcceptanceRel_keyWord',isReload);
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.assetsFurnitureAcceptance.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsFurnitureAcceptanceDTO.id}',
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