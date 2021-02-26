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
										      <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" readonly="readonly" name="authorAlias" value="<c:out  value='${dynUsdassetsNtcDTO.authorAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="applyYear">年度:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="applyYear"  id="applyYear" readonly="readonly" value="<c:out  value='${dynUsdassetsNtcDTO.applyYear}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deptDeadline">部门上报截至日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="deptDeadline" id="deptDeadline" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${dynUsdassetsNtcDTO.deptDeadline}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="releasedate">发布日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="releasedate" id="releasedate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${dynUsdassetsNtcDTO.releasedate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="telephone">电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="telephone"  id="telephone" readonly="readonly" value="<c:out  value='${dynUsdassetsNtcDTO.telephone}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="deptAlias">发布人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="dept" name="dept" value="<c:out  value='${dynUsdassetsNtcDTO.dept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" readonly="readonly" name="deptAlias" value="<c:out  value='${dynUsdassetsNtcDTO.deptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formRemarks">备注:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formRemarks"  id="formRemarks" readonly="readonly" value="<c:out  value='${dynUsdassetsNtcDTO.formRemarks}'/>"/>
																	   </td>
																								   													 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formTitle">标题:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formTitle"  id="formTitle" readonly="readonly" value="<c:out  value='${dynUsdassetsNtcDTO.formTitle}'/>"/>
																	   </td>
																			</tr>
										<tr>
																								   													 												 												 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
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
             			     			     	var assetsUstdtempapplyCollect;
	var assetsUstdtempapplyCollectGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   				   													,{ label: '申购单号', name: 'stdId', width: 150,editable:false}
																		  		   			 			 											   				   													,{ label: '申请人部门', name: 'createdByDept', width: 150,editable:false}
																		  		   			 			 			 			 			 			 			 			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '设备类别id', name: 'deviceCategory', width: 75, hidden:true}
   	                        ,{ label: '设备类别', name: 'deviceCategoryName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'deviceCategory', value: deviceCategoryData}}
									        							  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 											   				   													,{ label: '主管设备所领导', name: 'competentDeviceLeaderAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'competentDeviceLeader'}}
                            ,{ label: '主管设备所领导id', name: 'competentDeviceLeader', width: 75, hidden:true , editable:false}
																		  		   			 								 	];
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
			});
			
			parent.dynUsdassetsNtc.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${dynUsdassetsNtcDTO.id}',
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