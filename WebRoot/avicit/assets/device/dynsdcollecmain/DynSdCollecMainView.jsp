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
<!-- ControllerPath = "assets/device/dynsdcollecmain/dynSdCollecMainController/operation/Edit/id" -->
<title>编辑</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<style type="text/css">
#t_assetsSdequipCollect{
   display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
						<input type="hidden" name="version" value="<c:out  value='${dynSdCollecMainDTO.version}'/>"/>
															<input type="hidden" name="id" value="<c:out  value='${dynSdCollecMainDTO.id}'/>"/>
																																																																																																																																																													 <table class="form_commonTable">
				<tr>
																																											 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="authorAlias">字段_1:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="author" name="author" value="<c:out  value='${dynSdCollecMainDTO.author}'/>">
										      <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" readonly="readonly" name="authorAlias" value="<c:out  value='${dynSdCollecMainDTO.authorAlias}'/>">
										      <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
								    	</div>
																	   </td>
																								   													 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="releasedate">发布日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="releasedate" id="releasedate" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${dynSdCollecMainDTO.releasedate}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="telephone">电话:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="telephone"  id="telephone" readonly="readonly" value="<c:out  value='${dynSdCollecMainDTO.telephone}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								    <label for="deptAlias">发布人部门:</label></th>
								    									<td width="15%">
																			<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="dept" name="dept" value="<c:out  value='${dynSdCollecMainDTO.dept}'/>">
									      <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" readonly="readonly" name="deptAlias" value="<c:out  value='${dynSdCollecMainDTO.deptAlias}'/>">
									      <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
								        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formRemarks">备注:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formRemarks"  id="formRemarks" readonly="readonly" value="<c:out  value='${dynSdCollecMainDTO.formRemarks}'/>"/>
																	   </td>
																								   													 												 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="formTitle">标题:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="formTitle"  id="formTitle" readonly="readonly" value="<c:out  value='${dynSdCollecMainDTO.formTitle}'/>"/>
																	   </td>
																								   													 												 												 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="applyYear">年度:</label></th>
								    									<td width="15%">
																		    <input class="form-control input-sm" type="text" name="applyYear"  id="applyYear" readonly="readonly" value="<c:out  value='${dynSdCollecMainDTO.applyYear}'/>"/>
																	   </td>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="deptDeadline">部门上报截至日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="deptDeadline" id="deptDeadline" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${dynSdCollecMainDTO.deptDeadline}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																			</tr>
										<tr>
																								   													 																			    																																	<th width="10%" style="word-break:break-all;word-warp:break-word;">
								    								  	<label for="personDeadline">个人上报截至日期:</label></th>
								    									<td width="15%">
																		    <div class="input-group input-group-sm">
				                	      <input class="form-control date-picker" type="text" name="personDeadline" id="personDeadline" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value='${dynSdCollecMainDTO.personDeadline}'/>"/><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				              	        </div>
																	   </td>
																								   													 						</tr>
						<tr>
							<th width="99%" colspan="<%=4 * 2 %>">
								<table id="assetsSdequipCollect"></table>
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
	<script type="text/javascript" src="avicit/assets/device/dynsdcollecmain/js/AssetsSdequipCollect.js"></script>
	<script type="text/javascript">
	//后台获取的通用代码数据
			 		     			     			     			     			     				     			     			     			     			 var secretLevelData = ${secretLevelData};
             			     			     			     			     			 var deviceTypeData = ${deviceTypeData};
             			 var deviceCategoryData = ${deviceCategoryData};
             			 var isMeteringData = ${isMeteringData};
             			 var isSceneMeteringData = ${isSceneMeteringData};
             			 var isMaintainData = ${isMaintainData};
             			 var isAccuracyCheckData = ${isAccuracyCheckData};
             			 var isRegularCheckData = ${isRegularCheckData};
             			 var isSpotCheckData = ${isSpotCheckData};
             			 var isSpecialDeviceData = ${isSpecialDeviceData};
             			 var isPrecisionIndexData = ${isPrecisionIndexData};
             			 var isNeedInstallData = ${isNeedInstallData};
             			     			 var isFoundationData = ${isFoundationData};
             			 var isSafetyProductionData = ${isSafetyProductionData};
             			 var financialResourcesData = ${financialResourcesData};
             			     			     			     			     			     			 var demandUrgencyDegreeData = ${demandUrgencyDegreeData};
             			 var isTrainData = ${isTrainData};
             			 var isPcData = ${isPcData};
             			     			     			     			 var isWirelessData = ${isWirelessData};
             			     			     			     			     			     			     			     			     			     			     			     			     			     			     								 var isBearingMeetData = ${isBearingMeetData};
             			 var isOutdoorUnitData = ${isOutdoorUnitData};
             			 var isAllowOutdoorUnitData = ${isAllowOutdoorUnitData};
             			 var isNeedFoundationData = ${isNeedFoundationData};
             			 var isFoundationConditionData = ${isFoundationConditionData};
             			     			 var isVoltageConditionData = ${isVoltageConditionData};
             			 var isHumidityNeedData = ${isHumidityNeedData};
             			     			 var isCleanlinessNeedData = ${isCleanlinessNeedData};
             			     			 var isWaterNeedData = ${isWaterNeedData};
             			     			 var isGasNeedData = ${isGasNeedData};
             			     			 var isLetData = ${isLetData};
             			     			 var isOtherNeedData = ${isOtherNeedData};
             			     			 var isNoiseData = ${isNoiseData};
             			 var isNoiseInfluenceData = ${isNoiseInfluenceData};
             			     			     			     			     			     			     			     			     			     			     			     																							 var largeDeviceTypeData = ${largeDeviceTypeData};
             			 var instituteOrCompanyData = ${instituteOrCompanyData};
             			     			     	var assetsSdequipCollect;
	var assetsSdequipCollectGridColModel=[
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
									   			 											   				   													,{ label: '申购单号', name: 'stdId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '申请人', name: 'createdByPersionAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'createdByPersion'}}
                            ,{ label: '申请人id', name: 'createdByPersion', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '申请人部门', name: 'createdByDeptAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'createdByDept'}}
                            ,{ label: '申请人部门id', name: 'createdByDept', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '申请人电话', name: 'createdByTel', width: 150,editable:false}
																		  		   			 			 											   				   													,{ label: '单据状态', name: 'formState', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备名称', name: 'deviceName', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备规格', name: 'deviceSpec', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备型号', name: 'deviceModel', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '密级id', name: 'secretLevel', width: 75, hidden:true}
   	                        ,{ label: '密级', name: 'secretLevelName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'secretLevel', value: secretLevelData}}
									        							  		   			 											   				   													,{ label: '参考厂家', name: 'referencePlant', width: 150,editable:false}
																		  		   			 											   				   										     								   	                        ,{ label: '台（套）数', name: 'deviceNum', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-0)%>,max:<%=Math.pow(10,12)-Math.pow(10,-0)%>,step:1,precision:0}}
																		  												  		   			 											   				   										     								   	                        ,{ label: '单价(元)', name: 'unitPrice', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   										     								   	                        ,{ label: '总金额（元）', name: 'totalPrice', width: 150, editable:false, edittype:'custom', editoptions:{custom_element:spinnerElem,custom_value:spinnerValue,min:-<%=Math.pow(10,12)-Math.pow(10,-3)%>,max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,step:1,precision:3}}
																		  												  		   			 											   				   			           							,{ label: '设备类型id', name: 'deviceType', width: 75, hidden:true}
   	                        ,{ label: '设备类型', name: 'deviceTypeName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'deviceType', value: deviceTypeData}}
									        							  		   			 											   				   			           							,{ label: '设备类别id', name: 'deviceCategory', width: 75, hidden:true}
   	                        ,{ label: '设备类别', name: 'deviceCategoryName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'deviceCategory', value: deviceCategoryData}}
									        							  		   			 											   				   			           							,{ label: '是否计量id', name: 'isMetering', width: 75, hidden:true}
   	                        ,{ label: '是否计量', name: 'isMeteringName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isMetering', value: isMeteringData}}
									        							  		   			 											   				   			           							,{ label: '是否现场计量id', name: 'isSceneMetering', width: 75, hidden:true}
   	                        ,{ label: '是否现场计量', name: 'isSceneMeteringName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isSceneMetering', value: isSceneMeteringData}}
									        							  		   			 											   				   			           							,{ label: '是否保养id', name: 'isMaintain', width: 75, hidden:true}
   	                        ,{ label: '是否保养', name: 'isMaintainName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isMaintain', value: isMaintainData}}
									        							  		   			 											   				   			           							,{ label: '是否精度检查id', name: 'isAccuracyCheck', width: 75, hidden:true}
   	                        ,{ label: '是否精度检查', name: 'isAccuracyCheckName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isAccuracyCheck', value: isAccuracyCheckData}}
									        							  		   			 											   				   			           							,{ label: '是否定检id', name: 'isRegularCheck', width: 75, hidden:true}
   	                        ,{ label: '是否定检', name: 'isRegularCheckName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isRegularCheck', value: isRegularCheckData}}
									        							  		   			 											   				   			           							,{ label: '是否点检id', name: 'isSpotCheck', width: 75, hidden:true}
   	                        ,{ label: '是否点检', name: 'isSpotCheckName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isSpotCheck', value: isSpotCheckData}}
									        							  		   			 											   				   			           							,{ label: '是否特种设备id', name: 'isSpecialDevice', width: 75, hidden:true}
   	                        ,{ label: '是否特种设备', name: 'isSpecialDeviceName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isSpecialDevice', value: isSpecialDeviceData}}
									        							  		   			 											   				   			           							,{ label: '是否精度指标id', name: 'isPrecisionIndex', width: 75, hidden:true}
   	                        ,{ label: '是否精度指标', name: 'isPrecisionIndexName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isPrecisionIndex', value: isPrecisionIndexData}}
									        							  		   			 											   				   			           							,{ label: '是否需要安装id', name: 'isNeedInstall', width: 75, hidden:true}
   	                        ,{ label: '是否需要安装', name: 'isNeedInstallName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isNeedInstall', value: isNeedInstallData}}
									        							  		   			 											   				   													,{ label: '安装地点', name: 'installPosition', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '是否需要地基基础id', name: 'isFoundation', width: 75, hidden:true}
   	                        ,{ label: '是否需要地基基础', name: 'isFoundationName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isFoundation', value: isFoundationData}}
									        							  		   			 											   				   			           							,{ label: '是否涉及安全生产id', name: 'isSafetyProduction', width: 75, hidden:true}
   	                        ,{ label: '是否涉及安全生产', name: 'isSafetyProductionName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isSafetyProduction', value: isSafetyProductionData}}
									        							  		   			 											   				   			           							,{ label: '经费来源id', name: 'financialResources', width: 75, hidden:true}
   	                        ,{ label: '经费来源', name: 'financialResourcesName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'financialResources', value: financialResourcesData}}
									        							  		   			 											   				   													,{ label: '所属项目', name: 'toProject', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '批复名称', name: 'approvalName', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '主管总师', name: 'chiefEngineerAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'chiefEngineer'}}
                            ,{ label: '主管总师id', name: 'chiefEngineer', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '项目序号', name: 'projectNum', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '项目主管', name: 'projectDirectorAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'projectDirector'}}
                            ,{ label: '项目主管id', name: 'projectDirector', width: 75, hidden:true , editable:false}
																		  		   			 											   				   			           							,{ label: '需求紧急程度id', name: 'demandUrgencyDegree', width: 75, hidden:true}
   	                        ,{ label: '需求紧急程度', name: 'demandUrgencyDegreeName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'demandUrgencyDegree', value: demandUrgencyDegreeData}}
									        							  		   			 											   				   			           							,{ label: '是否需要设备培训id', name: 'isTrain', width: 75, hidden:true}
   	                        ,{ label: '是否需要设备培训', name: 'isTrainName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isTrain', value: isTrainData}}
									        							  		   			 											   				   			           							,{ label: '是否是计算机id', name: 'isPc', width: 75, hidden:true}
   	                        ,{ label: '是否是计算机', name: 'isPcName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isPc', value: isPcData}}
									        							  		   			 											   				   													,{ label: '计划到货时间', name: 'planDeliveryTime', width: 150,editable:false, edittype:'custom',formatter:format,editoptions:{custom_element:dateElem,custom_value:dateValue}}
																		  		   			 											   				   													,{ label: '采购员', name: 'buyerAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'buyer'}}
                            ,{ label: '采购员id', name: 'buyer', width: 75, hidden:true , editable:false}
																		  		   			 											   				   													,{ label: '采购计划员', name: 'planBuyerAlias', width: 150, editable:false,edittype:'custom',editoptions:{custom_element:userElem,custom_value:userValue, forId:'planBuyer'}}
                            ,{ label: '采购计划员id', name: 'planBuyer', width: 75, hidden:true , editable:false}
																		  		   			 											   				   			           							,{ label: '是否具有无线功能id', name: 'isWireless', width: 75, hidden:true}
   	                        ,{ label: '是否具有无线功能', name: 'isWirelessName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isWireless', value: isWirelessData}}
									        							  		   			 											   				   													,{ label: '设备购置类型', name: 'devicePurchaseType', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备购置原因', name: 'devicePurchaseCause', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '技术指标', name: 'technicalIndex', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '技术指标', name: 'technicalIndex02', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '指标先进性', name: 'advancement', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备可靠性', name: 'deviceReliability', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '是否属于即将产能淘汰设备', name: 'isWeedOut', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '已有设备为什么不能满足要求', name: 'notMeetDemand', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备利用率情况', name: 'useRatio', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备能耗情况 ', name: 'energyConsumption', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备耗材经济性', name: 'consumableEconomics', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备通用性', name: 'universality', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '设备维保费用情况', name: 'maintainCost', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '安全性', name: 'security', width: 150,editable:false}
																		  		   			 			 			 			 			 			 											   				   			           							,{ label: '安装设备楼层承重是否满足id', name: 'isBearingMeet', width: 75, hidden:true}
   	                        ,{ label: '安装设备楼层承重是否满足', name: 'isBearingMeetName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isBearingMeet', value: isBearingMeetData}}
									        							  		   			 											   				   			           							,{ label: '设备是否有室外机id', name: 'isOutdoorUnit', width: 75, hidden:true}
   	                        ,{ label: '设备是否有室外机', name: 'isOutdoorUnitName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isOutdoorUnit', value: isOutdoorUnitData}}
									        							  		   			 											   				   			           							,{ label: '所安装位置是否允许安装室外机id', name: 'isAllowOutdoorUnit', width: 75, hidden:true}
   	                        ,{ label: '所安装位置是否允许安装室外机', name: 'isAllowOutdoorUnitName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isAllowOutdoorUnit', value: isAllowOutdoorUnitData}}
									        							  		   			 											   				   			           							,{ label: '设备是否需要地基基础id', name: 'isNeedFoundation', width: 75, hidden:true}
   	                        ,{ label: '设备是否需要地基基础', name: 'isNeedFoundationName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isNeedFoundation', value: isNeedFoundationData}}
									        							  		   			 											   				   			           							,{ label: '所安装位置是否具备设置地基条件id', name: 'isFoundationCondition', width: 75, hidden:true}
   	                        ,{ label: '所安装位置是否具备设置地基条件', name: 'isFoundationConditionName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isFoundationCondition', value: isFoundationConditionData}}
									        							  		   			 											   				   													,{ label: '使用电压', name: 'serviceVoltage', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '安装位置是否具备电压条件id', name: 'isVoltageCondition', width: 75, hidden:true}
   	                        ,{ label: '安装位置是否具备电压条件', name: 'isVoltageConditionName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isVoltageCondition', value: isVoltageConditionData}}
									        							  		   			 											   				   			           							,{ label: '是否对温湿度有要求id', name: 'isHumidityNeed', width: 75, hidden:true}
   	                        ,{ label: '是否对温湿度有要求', name: 'isHumidityNeedName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isHumidityNeed', value: isHumidityNeedData}}
									        							  		   			 											   				   													,{ label: '温湿度要求', name: 'humidityNeed', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '是否对洁净度有要求id', name: 'isCleanlinessNeed', width: 75, hidden:true}
   	                        ,{ label: '是否对洁净度有要求', name: 'isCleanlinessNeedName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isCleanlinessNeed', value: isCleanlinessNeedData}}
									        							  		   			 											   				   													,{ label: '洁净度要求', name: 'cleanlinessNeed', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '是否有用水要求id', name: 'isWaterNeed', width: 75, hidden:true}
   	                        ,{ label: '是否有用水要求', name: 'isWaterNeedName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isWaterNeed', value: isWaterNeedData}}
									        							  		   			 											   				   													,{ label: '用水要求', name: 'waterNeed', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '是否有用气要求id', name: 'isGasNeed', width: 75, hidden:true}
   	                        ,{ label: '是否有用气要求', name: 'isGasNeedName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isGasNeed', value: isGasNeedData}}
									        							  		   			 											   				   													,{ label: '用气要求', name: 'gasNeed', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '是否是否有气体、污水排放id', name: 'isLet', width: 75, hidden:true}
   	                        ,{ label: '是否是否有气体、污水排放', name: 'isLetName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isLet', value: isLetData}}
									        							  		   			 											   				   													,{ label: '气体、污水排放要求', name: 'letNeed', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '是否有其他特殊要求id', name: 'isOtherNeed', width: 75, hidden:true}
   	                        ,{ label: '是否有其他特殊要求', name: 'isOtherNeedName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isOtherNeed', value: isOtherNeedData}}
									        							  		   			 											   				   													,{ label: '其他特殊要求', name: 'otherNeed', width: 150,editable:false}
																		  		   			 											   				   			           							,{ label: '是否有噪音id', name: 'isNoise', width: 75, hidden:true}
   	                        ,{ label: '是否有噪音', name: 'isNoiseName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isNoise', value: isNoiseData}}
									        							  		   			 											   				   			           							,{ label: '噪音是否影响安装地工作办公id', name: 'isNoiseInfluence', width: 75, hidden:true}
   	                        ,{ label: '噪音是否影响安装地工作办公', name: 'isNoiseInfluenceName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'isNoiseInfluence', value: isNoiseInfluenceData}}
									        							  		   			 											   				   													,{ label: '以上需求条件在拟安装地点是否都已具备', name: 'aboveNeedHave', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '审批总师', name: 'examineApproveEngineer', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '专业审核员', name: 'professionalAuditor', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '主管所领导', name: 'competentLeader', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '部门领导结论', name: 'deptHeadConclusion', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '部门领导意见', name: 'deptHeadOpinion', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '专业审核员意见', name: 'professionalAuditorOpinion', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '总师结论', name: 'chiefEngineerConclusion', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '总师意见', name: 'chiefEngineerOpinion', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '主管所领导结论', name: 'competentLeaderConclusion', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '主管所领导意见', name: 'competentLeaderOpinion', width: 150,editable:false}
																		  		   			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 			 											   				   			           							,{ label: '简易/大型设备id', name: 'largeDeviceType', width: 75, hidden:true}
   	                        ,{ label: '简易/大型设备', name: 'largeDeviceTypeName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'largeDeviceType', value: largeDeviceTypeData}}
									        							  		   			 											   				   			           							,{ label: '研究所/公司id', name: 'instituteOrCompany', width: 75, hidden:true}
   	                        ,{ label: '研究所/公司', name: 'instituteOrCompanyName', width: 150, editable:false, edittype:"custom", editoptions: {custom_element:selectElem,custom_value:selectValue, forId:'instituteOrCompany', value: instituteOrCompanyData}}
									        							  		   			 											   				   													,{ label: '安装地点（未使用）', name: 'positionId', width: 150,editable:false}
																		  		   			 											   				   													,{ label: '标准设备年度申购征集通知单id', name: 'parentId', width: 150,editable:false}
																		  		   			 	];
				$(document).ready(function () {
		    var pid = "${dynSdCollecMainDTO.id}";
			var isReload = "edit";
			var searchSubNames = "";
			var surl = "platform/assets/device/dynsdcollecmain/dynSdCollecMainController/operation/sub/";
			assetsSdequipCollect = new AssetsSdequipCollect('assetsSdequipCollect', surl,
					"formSub",
					assetsSdequipCollectGridColModel,
					'searchDialogSub', pid,searchSubNames, 'assetsSdequipCollect_keyWord',isReload);
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine:true,//单行显示时分秒
				closeText:'确定',//关闭按钮文案
				showButtonPanel:true,//是否展示功能按钮面板
				showSecond:false,//是否可以选择秒，默认否
			});
			
			parent.dynSdCollecMain.formValidate($('#form'));
			//初始化附件上传组件
			$('#attachment').uploaderExt({
			    formId: '${dynSdCollecMainDTO.id}',
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