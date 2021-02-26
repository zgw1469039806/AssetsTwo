<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/toAssetsStdtempAcceptanceManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div id="panelnorth" data-options="region:'north',height:fixheight(.5),onResize:function(a){$('#assetsStdtempAcceptance').setGridWidth(a);$('#assetsStdtempAcceptance').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
		<div id="toolbar_assetsStdtempAcceptance" class="toolbar">
			<div class="toolbar-left">
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsStdtempAcceptance_button_add" permissionDes="添加">
		  	<a id="assetsStdtempAcceptance_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsStdtempAcceptance_button_edit" permissionDes="编辑">
			<a id="assetsStdtempAcceptance_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsStdtempAcceptance_button_delete" permissionDes="删除">
			<a id="assetsStdtempAcceptance_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
						</div>
		    <div class="toolbar-right">
		        <select id="workFlowSelect"
					class="form-control input-sm workflow-select">
					<option value="all" selected="selected">全部</option>
					<option value="start">拟稿中</option>
					<option value="active">流转中</option>
					<option value="ended">已完成</option>
				</select>
			    <div class="input-group form-tool-search" style="width:125px">
		     		<input type="text" name="assetsStdtempAcceptance_keyWord" id="assetsStdtempAcceptance_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
		     		<label id="assetsStdtempAcceptance_searchPart" class="icon icon-search form-tool-searchicon"></label>
		   		</div>
		   		<div class="input-group-btn form-tool-searchbtn">
		   			<a id="assetsStdtempAcceptance_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
		   		</div>
		    </div>
		</div>	
		<table id="assetsStdtempAcceptance"></table>
		<div id="assetsStdtempAcceptancePager"></div>
    </div>
    <div id="centerpanel" data-options="region:'center',split:true,onResize:function(a){$('#attInventory').setGridWidth(a); $('#attInventory').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
	    <div id="toolbar_attInventory" class="toolbar">
		    <div class="toolbar-right">
			    <div class="input-group form-tool-search" style="width:125px">
		     		<input type="text" name="attInventory_keyWord" id="attInventory_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
		     		<label id="attInventory_searchPart" class="icon icon-search form-tool-searchicon"></label>
		   		</div>
		   		<div class="input-group-btn form-tool-searchbtn">
		   			<a id="attInventory_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
		   		</div>
		    </div>
		</div>	
		<table id="attInventory"></table>
		<div id="attInventoryPager"></div>
    </div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form">
	       <input type="hidden" id="bpmState" name="bpmState" value="all">
    	   <table class="form_commonTable">
			    <tr>
																						  						   						   						   							 							 						   																																																																																																																																																																																																																																																																																																																					  						   						   						   							 								<th width="10%">验收单号 :</th>
										    								 <td width="15%">
	    								 <input title="验收单号 " class="form-control input-sm" type="text" name="acceptanceId" id="acceptanceId" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">申请人:</th>
										    								 <td width="15%">
	    								 <input title="申请人" class="form-control input-sm" type="text" name="createdByPersion" id="createdByPersion" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">申请人部门:</th>
										    								 <td width="15%">
	    								 <input title="申请人部门" class="form-control input-sm" type="text" name="createdByDept" id="createdByDept" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">单据状态 :</th>
										    								 <td width="15%">
	    								 <input title="单据状态 " class="form-control input-sm" type="text" name="formState" id="formState" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">合同号:</th>
										    								 <td width="15%">
	    								 <input title="合同号" class="form-control input-sm" type="text" name="contractNum" id="contractNum" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">采购部门:</th>
										    								 <td width="15%">
	    								 <input title="采购部门" class="form-control input-sm" type="text" name="buyerDept" id="buyerDept" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">采购员:</th>
										    								 <td width="15%">
	    								 <input title="采购员" class="form-control input-sm" type="text" name="buyer" id="buyer" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">申购单号:</th>
										    								 <td width="15%">
	    								 <input title="申购单号" class="form-control input-sm" type="text" name="stdId" id="stdId" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">责任人 :</th>
										    								 <td width="15%">
	    								 <input title="责任人 " class="form-control input-sm" type="text" name="chargePerson" id="chargePerson" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">责任部门 :</th>
										    								 <td width="15%">
	    								 <input title="责任部门 " class="form-control input-sm" type="text" name="chargeDept" id="chargeDept" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">责任人联系方式 :</th>
										    								 <td width="15%">
	    								 <input title="责任人联系方式 " class="form-control input-sm" type="text" name="chargePersonTel" id="chargePersonTel" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">设备名称:</th>
										    								 <td width="15%">
	    								 <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">统一编号:</th>
										    								 <td width="15%">
	    								 <input title="统一编号" class="form-control input-sm" type="text" name="unifyId" id="unifyId" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">设备类型 :</th>
										    								 <td width="15%">
	    								 <input title="设备类型 " class="form-control input-sm" type="text" name="deviceType" id="deviceType" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">设备类别:</th>
										    								 <td width="15%">
	    								 <input title="设备类别" class="form-control input-sm" type="text" name="deviceCategory" id="deviceCategory" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">设备型号:</th>
										    								 <td width="15%">
	    								 <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">设备规格:</th>
										    								 <td width="15%">
	    								 <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">出厂编号:</th>
										    								 <td width="15%">
	    								 <input title="出厂编号" class="form-control input-sm" type="text" name="manufacturingNumber" id="manufacturingNumber" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">生产国家和地区:</th>
										    								 <td width="15%">
	    								 <input title="生产国家和地区" class="form-control input-sm" type="text" name="producingCountries" id="producingCountries" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">生产厂家:</th>
										    								 <td width="15%">
	    								 <input title="生产厂家" class="form-control input-sm" type="text" name="productionManufacturer" id="productionManufacturer" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 									<th width="10%">出厂时间(从):</th>
    								   <td width="15%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="deliveryTimeBegin" id="deliveryTimeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
										    									<th width="10%">出厂时间(至):</th>
    									<td width="15%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="deliveryTimeEnd" id="deliveryTimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   																							  						   						   						   							 								<th width="10%">供应商:</th>
										    								 <td width="15%">
	    								 <input title="供应商" class="form-control input-sm" type="text" name="contractSupplier" id="contractSupplier" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">采购单价 :</th>
																			<td width="15%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="unitPrice" id="unitPrice"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">采购金额:</th>
																			<td width="15%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="totalPrice" id="totalPrice"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																								 						   																							  						   						   						   							 								<th width="10%">是否精度检查:</th>
										    								 <td width="15%">
	    								 <input title="是否精度检查" class="form-control input-sm" type="text" name="isAccuracyCheck" id="isAccuracyCheck" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">是否定检:</th>
										    								 <td width="15%">
	    								 <input title="是否定检" class="form-control input-sm" type="text" name="isRegularCheck" id="isRegularCheck" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">是否安装:</th>
										    								 <td width="15%">
	    								 <input title="是否安装" class="form-control input-sm" type="text" name="isInstall" id="isInstall" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">使用人 :</th>
										    								 <td width="15%">
	    								 <input title="使用人 " class="form-control input-sm" type="text" name="employUser" id="employUser" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">使用人部门 :</th>
										    								 <td width="15%">
	    								 <input title="使用人部门 " class="form-control input-sm" type="text" name="employDept" id="employDept" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">计量标识:</th>
										    								 <td width="15%">
	    								 <input title="计量标识" class="form-control input-sm" type="text" name="measuringTag" id="measuringTag" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">计量人员:</th>
										    								 <td width="15%">
	    								 <input title="计量人员" class="form-control input-sm" type="text" name="measuringUser" id="measuringUser" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">计量计划员:</th>
										    								 <td width="15%">
	    								 <input title="计量计划员" class="form-control input-sm" type="text" name="planMeasuring" id="planMeasuring" />
	    								 </td>
																								 						   																							  						   						   						   							 									<th width="10%">计量时间(从):</th>
    								   <td width="15%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="measuringTimeBegin" id="measuringTimeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
										    									<th width="10%">计量时间(至):</th>
    									<td width="15%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="measuringTimeEnd" id="measuringTimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   																							  						   						   						   							 								<th width="10%">计量周期:</th>
																			<td width="15%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="measuringPeriod" id="measuringPeriod"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">是否计量:</th>
										    								 <td width="15%">
	    								 <input title="是否计量" class="form-control input-sm" type="text" name="isMeasuring" id="isMeasuring" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">是否现场计量:</th>
										    								 <td width="15%">
	    								 <input title="是否现场计量" class="form-control input-sm" type="text" name="isSceneMeasuring" id="isSceneMeasuring" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">是否点检:</th>
										    								 <td width="15%">
	    								 <input title="是否点检" class="form-control input-sm" type="text" name="isSpotCheck" id="isSpotCheck" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">是否是计算机:</th>
										    								 <td width="15%">
	    								 <input title="是否是计算机" class="form-control input-sm" type="text" name="isPc" id="isPc" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">密级 :</th>
										    								 <td width="15%">
	    								 <input title="密级 " class="form-control input-sm" type="text" name="secretLevel" id="secretLevel" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">是否涉及安全生产:</th>
										    								 <td width="15%">
	    								 <input title="是否涉及安全生产" class="form-control input-sm" type="text" name="isSafetyProduction" id="isSafetyProduction" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">是否保养:</th>
										    								 <td width="15%">
	    								 <input title="是否保养" class="form-control input-sm" type="text" name="isMaintain" id="isMaintain" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">精度检查结果 :</th>
										    								 <td width="15%">
	    								 <input title="精度检查结果 " class="form-control input-sm" type="text" name="accuracyCheckResult" id="accuracyCheckResult" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">保养结果 :</th>
										    								 <td width="15%">
	    								 <input title="保养结果 " class="form-control input-sm" type="text" name="maintainResult" id="maintainResult" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">安装结果 :</th>
										    								 <td width="15%">
	    								 <input title="安装结果 " class="form-control input-sm" type="text" name="installResult" id="installResult" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">质量审查结果 :</th>
										    								 <td width="15%">
	    								 <input title="质量审查结果 " class="form-control input-sm" type="text" name="qualityResult" id="qualityResult" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">整改结果 :</th>
										    								 <td width="15%">
	    								 <input title="整改结果 " class="form-control input-sm" type="text" name="abarbeitungResult" id="abarbeitungResult" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">联系电话:</th>
										    								 <td width="15%">
	    								 <input title="联系电话" class="form-control input-sm" type="text" name="createdByTel" id="createdByTel" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">申购父ID:</th>
										    								 <td width="15%">
	    								 <input title="申购父ID" class="form-control input-sm" type="text" name="fid" id="fid" />
	    								 </td>
																								 						   														 </tr>
    	</table>
    </form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
    	   <table class="form_commonTable">
			    <tr>
																						  						  						   						   						   							 							 						   						 					   					 												  						  						   						   						   							 								<th width="10%">DEVICE_MODEL:</th>
										    								 <td width="15%">
	    								 <input title="DEVICE_MODEL" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel" />
	    								 </td>
																								 						   						 					   					 												  						  						   						   						   							 								<th width="10%">DEVICE_NAME:</th>
										    								 <td width="15%">
	    								 <input title="DEVICE_NAME" class="form-control input-sm" type="text" name="deviceName" id="deviceName" />
	    								 </td>
																								 						   						 					   					 											 											 												  						  						   						   						   							 								<th width="10%">DEVICE_CATEGORY:</th>
										    								 <td width="15%">
	    								 <input title="DEVICE_CATEGORY" class="form-control input-sm" type="text" name="deviceCategory" id="deviceCategory" />
	    								 </td>
																								 						   						 					   					 											 											 											 											 												  						  						   						   						   							 								<th width="10%">DEVICE_SPEC:</th>
										    								 <td width="15%">
	    								 <input title="DEVICE_SPEC" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec" />
	    								 </td>
																										</tr>
									<tr>
															 						   						 					   					 												  						  						   						   						   							 								<th width="10%">DEVICE_NUM:</th>
										    								 <td width="15%">
	    								 <input title="DEVICE_NUM" class="form-control input-sm" type="text" name="deviceNum" id="deviceNum" />
	    								 </td>
																								 						   						 					   					 												  					   					 											 			 </tr>
    	</table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script src="avicit/assets/device/assetsstdtempacceptance/js/AssetsStdtempAcceptance.js" type="text/javascript"></script>
<script src="avicit/assets/device/assetsstdtempacceptance/js/AttInventory.js" type="text/javascript"></script>
<script type="text/javascript">
var assetsStdtempAcceptance;
var attInventory;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="assetsStdtempAcceptance.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="assetsStdtempAcceptance.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//刷新本页面
window.bpm_operator_refresh = function(){
	assetsStdtempAcceptance.reLoad();
};
		
$(document).ready(function () {
	var searchMainNames = new Array();
	var searchMainTips = new Array();
						  		  																																																																																					  		      	 searchMainNames.push("acceptanceId");
 	 searchMainTips.push("验收单号 ");
		 	 		  							  		      	 searchMainNames.push("createdByPersion");
 	 searchMainTips.push("申请人");
		 	 		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  							  		     		  							  							  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  							  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  				var searchMainC = searchMainTips.length==2?'或' + searchMainTips[1] : "";
	$('#assetsStdtempAcceptance_keyWord').attr('placeholder','请输入' + searchMainTips[0] + searchMainC);
	$('#assetsStdtempAcceptance_keyWord').attr('title','请输入' + searchMainTips[0] + searchMainC);
	var searchSubNames = new Array();
	var searchSubTips = new Array();
						  		  							  		         searchSubNames.push("deviceModel");
    searchSubTips.push("DEVICE_MODEL");
		 	 		  							  		         searchSubNames.push("deviceName");
    searchSubTips.push("DEVICE_NAME");
		 	 		  													  		     		  																			  		     		  							  		     		  							  		  							var searchSubC = searchSubTips.length==2?'或' + searchSubTips[1] : "";
	$('#attInventory_keyWord').attr('placeholder','请输入' + searchSubTips[0] + searchSubC);
	$('#attInventory_keyWord').attr('title','请输入' + searchSubTips[0] + searchSubC);
	var assetsStdtempAcceptanceGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																																																																																																  																		,{ label: '验收单号 ', name: 'acceptanceId', width: 150}
																													  																		,{ label: '申请人', name: 'createdByPersion', width: 150}
																													  																		,{ label: '申请人部门', name: 'createdByDept', width: 150}
																													  																		,{ label: '单据状态 ', name: 'formState', width: 150}
																													  																		,{ label: '合同号', name: 'contractNum', width: 150}
																													  																		,{ label: '采购部门', name: 'buyerDept', width: 150}
																													  																		,{ label: '采购员', name: 'buyer', width: 150}
																													  																		,{ label: '申购单号', name: 'stdId', width: 150}
																													  																		,{ label: '责任人 ', name: 'chargePerson', width: 150}
																													  																		,{ label: '责任部门 ', name: 'chargeDept', width: 150}
																													  																		,{ label: '责任人联系方式 ', name: 'chargePersonTel', width: 150}
																													  																		,{ label: '设备名称', name: 'deviceName', width: 150}
																													  																		,{ label: '统一编号', name: 'unifyId', width: 150}
																													  																		,{ label: '设备类型 ', name: 'deviceType', width: 150}
																													  																		,{ label: '设备类别', name: 'deviceCategory', width: 150}
																													  																		,{ label: '设备型号', name: 'deviceModel', width: 150}
																													  																		,{ label: '设备规格', name: 'deviceSpec', width: 150}
																													  																		,{ label: '出厂编号', name: 'manufacturingNumber', width: 150}
																													  																		,{ label: '生产国家和地区', name: 'producingCountries', width: 150}
																													  																		,{ label: '生产厂家', name: 'productionManufacturer', width: 150}
																													  																		,{ label: '出厂时间', name: 'deliveryTime', width: 150,formatter:format}
																													  																		,{ label: '供应商', name: 'contractSupplier', width: 150}
																													  																		,{ label: '采购单价 ', name: 'unitPrice', width: 150}
																													  																		,{ label: '采购金额', name: 'totalPrice', width: 150}
																													  																		,{ label: '是否精度检查', name: 'isAccuracyCheck', width: 150}
																													  																		,{ label: '是否定检', name: 'isRegularCheck', width: 150}
																													  																		,{ label: '是否安装', name: 'isInstall', width: 150}
																													  																		,{ label: '使用人 ', name: 'employUser', width: 150}
																													  																		,{ label: '使用人部门 ', name: 'employDept', width: 150}
																													  																		,{ label: '计量标识', name: 'measuringTag', width: 150}
																													  																		,{ label: '计量人员', name: 'measuringUser', width: 150}
																													  																		,{ label: '计量计划员', name: 'planMeasuring', width: 150}
																													  																		,{ label: '计量时间', name: 'measuringTime', width: 150,formatter:format}
																													  																		,{ label: '计量周期', name: 'measuringPeriod', width: 150}
																													  																		,{ label: '是否计量', name: 'isMeasuring', width: 150}
																													  																		,{ label: '是否现场计量', name: 'isSceneMeasuring', width: 150}
																													  																		,{ label: '是否点检', name: 'isSpotCheck', width: 150}
																													  																		,{ label: '是否是计算机', name: 'isPc', width: 150}
																													  																		,{ label: '密级 ', name: 'secretLevel', width: 150}
																													  																		,{ label: '是否涉及安全生产', name: 'isSafetyProduction', width: 150}
																													  																		,{ label: '是否保养', name: 'isMaintain', width: 150}
																													  																		,{ label: '精度检查结果 ', name: 'accuracyCheckResult', width: 150}
																													  																		,{ label: '保养结果 ', name: 'maintainResult', width: 150}
																													  																		,{ label: '安装结果 ', name: 'installResult', width: 150}
																													  																		,{ label: '质量审查结果 ', name: 'qualityResult', width: 150}
																													  																		,{ label: '整改结果 ', name: 'abarbeitungResult', width: 150}
																													  																		,{ label: '联系电话', name: 'createdByTel', width: 150}
																													  																		,{ label: '申购父ID', name: 'fid', width: 150}
																						                ,{ label: '流程当前步骤', name: 'activityalias_',width: 150 } 
	                ,{ label: '流程状态',name: 'businessstate_', width: 150}
	];
	var attInventoryGridColModel =  [
																			{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																																							,{ label: 'DEVICE_MODEL', name: 'deviceModel', width: 150}
																																															,{ label: 'DEVICE_NAME', name: 'deviceName', width: 150}
																																																					,{ label: 'DEVICE_CATEGORY', name: 'deviceCategory', width: 150}
																																																											,{ label: 'DEVICE_SPEC', name: 'deviceSpec', width: 150}
																																															,{ label: 'DEVICE_NUM', name: 'deviceNum', width: 150}
																																	];
	
	assetsStdtempAcceptance= new AssetsStdtempAcceptance('assetsStdtempAcceptance','${url}','form',assetsStdtempAcceptanceGridColModel,'searchDialog',
	 function(pid){
			attInventory = new AttInventory('attInventory','${surl}', "formSub", attInventoryGridColModel, 'searchDialogSub', pid, searchSubNames, "attInventory_keyWord");
		},
	 function(pid){
			attInventory.reLoad(pid);
		},
		searchMainNames,
		"assetsStdtempAcceptance_keyWord");
	//主表操作
	//添加按钮绑定事件
	$('#assetsStdtempAcceptance_insert').bind('click', function(){
		assetsStdtempAcceptance.insert();
	});
	//编辑按钮绑定事件
	$('#assetsStdtempAcceptance_modify').bind('click', function(){
		assetsStdtempAcceptance.modify();
	});
	//删除按钮绑定事件
	$('#assetsStdtempAcceptance_del').bind('click', function(){  
		assetsStdtempAcceptance.del();
	});
	//打开高级查询框
	$('#assetsStdtempAcceptance_searchAll').bind('click', function(){
		assetsStdtempAcceptance.openSearchForm(this,$('#assetsStdtempAcceptance'));
	});
	//关键字段查询按钮绑定事件
	$('#assetsStdtempAcceptance_searchPart').bind('click', function(){
		assetsStdtempAcceptance.searchByKeyWord();
	});
	
	//根据流程状态加载数据
	$('#workFlowSelect').bind('change',function(){
		assetsStdtempAcceptance.initWorkFlow($(this).val());
	});
	//子表操作
	//打开高级查询
	$('#attInventory_searchAll').bind('click', function(){
		attInventory.openSearchForm(this,$('#attInventory'));
	});
	//关键字段查询按钮绑定事件
	$('#attInventory_searchPart').bind('click', function(){
		attInventory.searchByKeyWord();
	});
    
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																												
																																																																																																																																																					
});

</script>
</html>