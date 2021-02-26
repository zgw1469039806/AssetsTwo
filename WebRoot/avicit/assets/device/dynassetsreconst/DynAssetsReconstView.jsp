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
										      <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" readonly="readonly" name="authorAlias" value="<c:out  value='${dynAssetsReconstDTO.authorAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																								   													 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="releasedate">上报日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="releasedate" id="releasedate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${dynAssetsReconstDTO.releasedate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="deptAlias">上报单位:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="dept" name="dept" value="<c:out  value='${dynAssetsReconstDTO.dept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" readonly="readonly" name="deptAlias" value="<c:out  value='${dynAssetsReconstDTO.deptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																								   													 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="tel">电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="tel"  id="tel" readonly="readonly" value="<c:out  value='${dynAssetsReconstDTO.tel}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="collectYear">年度:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="collectYear"  id="collectYear" readonly="readonly" value="<c:out  value='${dynAssetsReconstDTO.collectYear}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="collectSelect">关联征集单:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="collectSelect"  id="collectSelect" readonly="readonly" value="<c:out  value='${dynAssetsReconstDTO.collectSelect}'/>"/>
																	   </td>
																								   													 												 												 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
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
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="avicit/assets/device/dynassetsreconst/js/AssetsReconstructionCheck.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     				     			     								     			     			     			     			     			     			     			     			     			     			     			     			     			     			     			     																							     			 var deviceCategoryData = ${deviceCategoryData};
             			     	var assetsReconstructionCheck;
	var assetsReconstructionCheckGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   																		,{ label: '<span style="color:red;">*</span>改造申请单号', name: 'reconstructionId', width: 150,editable:false}
																		  		   			 			 											   				   													,{ label: '申请人部门', name: 'createdByDeptAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'createdByDept'}}
                            ,{ label: '申请人部门id', name: 'createdByDept', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '单据状态', name: 'formState', width: 150,editable:false}
																		  		   			 			 			 			 			 			 											   				   													,{ label: '责任部门', name: 'ownerDeptAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'ownerDept'}}
                            ,{ label: '责任部门id', name: 'ownerDept', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '责任人', name: 'ownerIdAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'ownerId'}}
                            ,{ label: '责任人id', name: 'ownerId', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '责任人联系方式', name: 'ownerTel', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '密级', name: 'secretLevel', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '统一编号', name: 'unifiedId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备型号', name: 'deviceModel', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备规格', name: 'deviceSpec', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '生产厂家', name: 'manufacturerId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '立卡时间', name: 'likaDate', width: 150,editable:false, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 											   				   										     								   	                        ,{ label: '设备原值', name: 'originalValue', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   													,{ label: '现有结构性能指标', name: 'existingPerformance', width: 150,editable:false}
																		  		   			 											   				   			               	                        ,{ label: '改造理由', name: 'reformingReason', width: 150,editable : false,   edittype:"textarea", editoptions : {rows:'1', maxlength : "1024"}}
																		  		   			 											   				   													,{ label: '改造后结构性能指标', name: 'afterPerformance', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '改造途径', name: 'transformWay', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '经费预算', name: 'budget', width: 150,editable:false}
																		  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 											   				   										     								   	                        ,{ label: '净值', name: 'netValue', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   			           							,{ label: '设备类别id', name: 'deviceCategory', width: 75, hidden:true}
   	                        ,{ label: '设备类别', name: 'deviceCategoryName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'deviceCategory', value: deviceCategoryData}}
									        							  		   			 											   				   													,{ label: '申请人', name: 'createdByPerson', width: 150,editable:false}
																		  		   			 	];
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
			});
			
			parent.dynAssetsReconst.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${dynAssetsReconstDTO.id}',
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