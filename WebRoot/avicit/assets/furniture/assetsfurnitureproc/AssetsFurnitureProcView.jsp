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
<!-- ControllerPath = "assets/furniture/assetsfurnitureproc/assetsFurnitureProcController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_assetsFurnitureProcRel{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${assetsFurnitureProcDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${assetsFurnitureProcDTO.id}'/>"/>
																																																																																																																																																																																																																																																																																																													 <table class="form_commonTable">
				<tr>
																																											 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="furNo">申购单号:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="furNo"  id="furNo" readonly="readonly" value="<c:out  value='${assetsFurnitureProcDTO.furNo}'/>"/>
																	   </td>
																																								   													 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="createdByDeptAlias">申请人部门:</label></th>
								    									<td width="39%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept" value="<c:out  value='${assetsFurnitureProcDTO.createdByDept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" readonly="readonly" value="<c:out  value='${assetsFurnitureProcDTO.createdByDeptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="createdByTel">申请人电话:</label></th>
								    									<td width="39%">
																		    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" readonly="readonly" value="<c:out  value='${assetsFurnitureProcDTO.createdByTel}'/>"/>
																	   </td>
																																								   													 												 												 												 												 												 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="applyReason">申购原因:</label></th>
								    									<td width="39%">
																		    <textarea class="form-control input-sm" rows="3" readonly="readonly"  name="applyReason" id="applyReason"><c:out  value='${assetsFurnitureProcDTO.applyReason}'/></textarea> 
																	   </td>
																			</tr>
										<tr>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="arrivalDate">预计到货时间:</label></th>
								    									<td width="39%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="arrivalDate" id="arrivalDate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsFurnitureProcDTO.arrivalDate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																																								   													 																			    																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formPrice">单据总金额:</label></th>
								    									<td width="39%">
																		  										 										 		<div class="input-group input-group-sm spinner" data-trigger="spinner">
											  <input  class="form-control"  type="text" name="formPrice" id="formPrice" readonly="readonly" value="<c:out  value='${assetsFurnitureProcDTO.formPrice}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
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
								<table id="assetsFurnitureProcRel"></table>
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
	<script type="text/javascript" src="avicit/assets/furniture/assetsfurnitureproc/js/AssetsFurnitureProcRel.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     				     			     								     			     			     			     			     																					var assetsFurnitureProcRel;
	var assetsFurnitureProcRelGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 								 			 											   				   													,{ label: '申请人部门', name: 'createdByDept', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '申请人电话', name: 'createdByTel', width: 150,editable:false}
																		  		   			 			 			 			 			 			 											   				   													,{ label: '家具名称', name: 'furnitureName', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '规格', name: 'furnitureSpec', width: 150,editable:false}
																		  		   			 											   				   										     								   	                        ,{ label: '申购数量', name: 'applyNum', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-0)%>,max:<%=Math.pow(10,12)-Math.pow(10,-0)%>,step:1,precision:0}}
																		  												  		   			 											   				   										     								   	                        ,{ label: '预算单价', name: 'unitPrice', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   										     								   	                        ,{ label: '预算总价', name: 'totalPrice', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 	];
				$(document).ready(function () {
		    var pid = "${assetsFurnitureProcDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/furniture/assetsfurnitureproc/assetsFurnitureProcController/operation/sub/";
			assetsFurnitureProcRel = new AssetsFurnitureProcRel('assetsFurnitureProcRel', surl,
					"formSub",
					assetsFurnitureProcRelGridColModel,
					'searchDialogSub', pid,searchSubNames, 'assetsFurnitureProcRel_keyWord',isReload);
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.assetsFurnitureProc.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${assetsFurnitureProcDTO.id}',
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