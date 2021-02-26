<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "assets/device/assetsreconacceptance/assetsReconAcceptanceController/toAssetsReconAcceptanceManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsReconAcceptance_button_add" permissionDes="添加">
  	<a id="assetsReconAcceptance_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsReconAcceptance_button_edit" permissionDes="编辑">
	<a id="assetsReconAcceptance_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑" style="display:none;"><i class="fa fa-file-text-o"></i> 编辑</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsReconAcceptance_button_delete" permissionDes="删除">
	<a id="assetsReconAcceptance_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除" style="display:none;"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist>
		</div>
    <div class="toolbar-right">
    	<select id="workFlowSelect" class="form-control input-sm workflow-select">
    		<option value="all" selected="selected">全部</option>
    		<option value="start">拟稿中</option>
    		<option value="active">流转中</option>
    		<option value="ended">已完成</option>
    	</select>
	    <div class="input-group form-tool-search">
     		<input type="text" name="assetsReconAcceptance_keyWord" id="assetsReconAcceptance_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="assetsReconAcceptance_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="assetsReconAcceptance_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="assetsReconAcceptancejqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		   <input type="hidden" id="bpmState" name="bpmState" value="all">
    	   <table class="form_commonTable">
			    <tr>
																						  						   						   						   							 							 						   																							  						   						   						   							 								<th width="10%">验收单号:</th>
										    								 <td width="15%">
	    								 <input title="验收单号" class="form-control input-sm" type="text" name="acceptanceNo" id="acceptanceNo" />
	    								 </td>
																								 						   																																		  						   						   						   							 								<th width="10%">创建人部门:</th>
																			<td width="15%">
										<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="createdByDept" name="createdByDept">
									      <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" >
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
										</td>
																								 						   																																																																														  						   						   						   							 								<th width="10%">单据状态:</th>
										    								 <td width="15%">
	    								 <input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">申请人:</th>
																			<td width="15%">
										<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="applyBy" name="applyBy">
										      <input class="form-control" placeholder="请选择用户" type="text" id="applyByAlias" name="applyByAlias" >
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
								    	</div>
										</td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">申请人部门:</th>
																			<td width="15%">
										<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="applyByDept" name="applyByDept">
									      <input class="form-control" placeholder="请选择部门" type="text" id="applyByDeptAlias" name="applyByDeptAlias" >
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
										</td>
																								 						   																							  						   						   						   							 								<th width="10%">申购单号:</th>
										    								 <td width="15%">
	    								 <input title="申购单号" class="form-control input-sm" type="text" name="reconstructionNo" id="reconstructionNo" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">设备名称:</th>
										    								 <td width="15%">
	    								 <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">统一编号:</th>
										    								 <td width="15%">
	    								 <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">密级:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级" isNull="true" lookupCode="SECRET_LEVEL" />
                                     </td>
                                     															 						   																							  						   						   						   							 								<th width="10%">生产厂家:</th>
										    								 <td width="15%">
	    								 <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">主管总师:</th>
																			<td width="15%">
										<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="competentChiefEngineer" name="competentChiefEngineer">
										      <input class="form-control" placeholder="请选择用户" type="text" id="competentChiefEngineerAlias" name="competentChiefEngineerAlias" >
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
								    	</div>
										</td>
																								 						   																							  						   						   						   							 								<th width="10%">责任人部门:</th>
																			<td width="15%">
										<div class="input-group  input-group-sm">
									   	  <input type="hidden"  id="ownerDept" name="ownerDept">
									      <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" >
									      <span class="input-group-addon" >
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
								        </div>
										</td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">责任人:</th>
																			<td width="15%">
										<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="ownerId" name="ownerId">
										      <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias" >
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
								    	</div>
										</td>
																								 						   																							  						   						   						   							 								<th width="10%">责任人联系方式:</th>
										    								 <td width="15%">
	    								 <input title="责任人联系方式" class="form-control input-sm" type="text" name="ownerTel" id="ownerTel" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">台(套)数:</th>
																			<td width="15%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="setsCount" id="setsCount"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																								 						   																							  						   						   						   							 								<th width="10%">单价(元):</th>
																			<td width="15%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="unitPrice" id="unitPrice"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">项目主管:</th>
																			<td width="15%">
										<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="projectDirector" name="projectDirector">
										      <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias" >
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
								    	</div>
										</td>
																								 						   																							  						   						   						   							 								<th width="10%">设备类别:</th>
										    								 <td width="15%">
	    								 <input title="设备类别" class="form-control input-sm" type="text" name="deviceCategory" id="deviceCategory" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">是否定检:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="ifRegularCheck" id="ifRegularCheck" title="是否定检" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
                                     </td>
                                     															 						   																							  						   						   						   							 								<th width="10%">是否点检:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="ifSpotCheck" id="ifSpotCheck" title="是否点检" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
                                     </td>
                                     																	</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">是否精度检查:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="ifPrecisionInspection" id="ifPrecisionInspection" title="是否精度检查" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
                                     </td>
                                     															 						   																							  						   						   						   							 								<th width="10%">是否保养:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="ifUpkeep" id="ifUpkeep" title="是否保养" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
                                     </td>
                                     															 						   																							  						   						   						   							 								<th width="10%">保养周期(天):</th>
																			<td width="15%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="upkeepCycle" id="upkeepCycle"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																								 						   																							  						   						   						   							 								<th width="10%">保养要求:</th>
															                     <td width="15%">
						                     <textarea class="form-control input-sm" rows="3" title="保养要求" name="upkeepRequirements" id="upkeepRequirements" ></textarea>
						                    </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 									<th width="10%">下次保养时间(从):</th>
    								   <td width="15%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="nextUpkeepDateBegin" id="nextUpkeepDateBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
										    									<th width="10%">下次保养时间(至):</th>
    									<td width="15%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="nextUpkeepDateEnd" id="nextUpkeepDateEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   																							  						   						   						   							 								<th width="10%">是否计量:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="ifMeasure" id="ifMeasure" title="是否计量" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
                                     </td>
                                     															 						   																							  						   						   						   							 								<th width="10%">是否需要安装:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="ifInstall" id="ifInstall" title="是否需要安装" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
                                     </td>
                                     																	</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">是否现场计量:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="ifMeasureOnsite" id="ifMeasureOnsite" title="是否现场计量" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
                                     </td>
                                     															 						   																							  						   						   						   							 								<th width="10%">计量标识:</th>
										    								 <td width="15%">
	    								 <input title="计量标识" class="form-control input-sm" type="text" name="measureIdentify" id="measureIdentify" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">计量人员:</th>
																			<td width="15%">
										<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="measureBy" name="measureBy">
										      <input class="form-control" placeholder="请选择用户" type="text" id="measureByAlias" name="measureByAlias" >
										      <span class="input-group-addon" >
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
								    	</div>
										</td>
																								 						   																							  						   						   						   							 									<th width="10%">计量时间(从):</th>
    								   <td width="15%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="meteringDateBegin" id="meteringDateBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
																			     </tr>
									     <tr>
								            									<th width="10%">计量时间(至):</th>
    									<td width="15%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="meteringDateEnd" id="meteringDateEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   																							  						   						   						   							 								<th width="10%">计量周期(天):</th>
																			<td width="15%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="meteringCycle" id="meteringCycle"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																								 						   																							  						   						   						   							 								<th width="10%">安装地点:</th>
										    								 <td width="15%">
	    								 <input title="安装地点" class="form-control input-sm" type="text" name="positionId" id="positionId" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">是否含计算机/无线模板:</th>
										    								 <td width="15%">
	    								 <input title="是否含计算机/无线模板" class="form-control input-sm" type="text" name="ifHasComputer" id="ifHasComputer" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">是否涉及安全生产:</th>
										    								 <td width="15%">
	    								 <input title="是否涉及安全生产" class="form-control input-sm" type="text" name="isSafetyProduction" id="isSafetyProduction" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">经费来源:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources" title="经费来源" isNull="true" lookupCode="FINANCIAL_RESOURCES" />
                                     </td>
                                     															 						   																							  						   						   						   							 								<th width="10%">所属项目:</th>
										    								 <td width="15%">
	    								 <input title="所属项目" class="form-control input-sm" type="text" name="belongProject" id="belongProject" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">项目序号:</th>
										    								 <td width="15%">
	    								 <input title="项目序号" class="form-control input-sm" type="text" name="projectNo" id="projectNo" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">批复名称:</th>
										    								 <td width="15%">
	    								 <input title="批复名称" class="form-control input-sm" type="text" name="replyName" id="replyName" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">立项单号:</th>
										    								 <td width="15%">
	    								 <input title="立项单号" class="form-control input-sm" type="text" name="projectApprovalNo" id="projectApprovalNo" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">ABC分类:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="abcCategory" id="abcCategory" title="ABC分类" isNull="true" lookupCode="ABC_CATEGORY" />
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
<!-- 业务的js -->
<script src="avicit/assets/device/assetsreconacceptance/js/AssetsReconAcceptance.js" type="text/javascript"></script>
<script type="text/javascript">
var assetsReconAcceptance;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="assetsReconAcceptance.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="assetsReconAcceptance.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//刷新本页面
window.bpm_operator_refresh = function(){
	assetsReconAcceptance.reLoad();
};
$(document).ready(function () {
	var dataGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																		  																	,{ label: '验收单号', name: 'acceptanceNo', width: 150,formatter:formatValue}
																															  																		,{ label: '创建人部门', name: 'createdByDeptAlias', width: 150}
																																												  																		,{ label: '单据状态', name: 'formState', width: 150}
																													  																		,{ label: '申请人', name: 'applyByAlias', width: 150}
																													  																		,{ label: '申请人部门', name: 'applyByDeptAlias', width: 150}
																													  																		,{ label: '申购单号', name: 'reconstructionNo', width: 150}
																													  																		,{ label: '设备名称', name: 'deviceName', width: 150}
																													  																		,{ label: '统一编号', name: 'unifiedId', width: 150}
																													  																		,{ label: '密级', name: 'secretLevel', width: 150}
																													  																		,{ label: '生产厂家', name: 'manufacturerId', width: 150}
																													  																		,{ label: '主管总师', name: 'competentChiefEngineerAlias', width: 150}
																													  																		,{ label: '责任人部门', name: 'ownerDeptAlias', width: 150}
																													  																		,{ label: '责任人', name: 'ownerIdAlias', width: 150}
																													  																		,{ label: '责任人联系方式', name: 'ownerTel', width: 150}
																													  																		,{ label: '台(套)数', name: 'setsCount', width: 150}
																													  																		,{ label: '单价(元)', name: 'unitPrice', width: 150}
																													  																		,{ label: '项目主管', name: 'projectDirectorAlias', width: 150}
																													  																		,{ label: '设备类别', name: 'deviceCategory', width: 150}
																													  																		,{ label: '是否定检', name: 'ifRegularCheck', width: 150}
																													  																		,{ label: '是否点检', name: 'ifSpotCheck', width: 150}
																													  																		,{ label: '是否精度检查', name: 'ifPrecisionInspection', width: 150}
																													  																		,{ label: '是否保养', name: 'ifUpkeep', width: 150}
																													  																		,{ label: '保养周期(天)', name: 'upkeepCycle', width: 150}
																													  																		,{ label: '保养要求', name: 'upkeepRequirements', width: 150}
																													  																		,{ label: '下次保养时间', name: 'nextUpkeepDate', width: 150,formatter:format}
																													  																		,{ label: '是否计量', name: 'ifMeasure', width: 150}
																													  																		,{ label: '是否需要安装', name: 'ifInstall', width: 150}
																													  																		,{ label: '是否现场计量', name: 'ifMeasureOnsite', width: 150}
																													  																		,{ label: '计量标识', name: 'measureIdentify', width: 150}
																													  																		,{ label: '计量人员', name: 'measureByAlias', width: 150}
																													  																		,{ label: '计量时间', name: 'meteringDate', width: 150,formatter:format}
																													  																		,{ label: '计量周期(天)', name: 'meteringCycle', width: 150}
																													  																		,{ label: '安装地点', name: 'positionId', width: 150}
																													  																		,{ label: '是否含计算机/无线模板', name: 'ifHasComputer', width: 150}
																													  																		,{ label: '是否涉及安全生产', name: 'isSafetyProduction', width: 150}
																													  																		,{ label: '经费来源', name: 'financialResources', width: 150}
																													  																		,{ label: '所属项目', name: 'belongProject', width: 150}
																													  																		,{ label: '项目序号', name: 'projectNo', width: 150}
																													  																		,{ label: '批复名称', name: 'replyName', width: 150}
																													  																		,{ label: '立项单号', name: 'projectApprovalNo', width: 150}
																													  																		,{ label: 'ABC分类', name: 'abcCategory', width: 150}
																																																																																																																					<sec:accesscontrollist hasPermission="3" domainObject="assetsReconAcceptance_table_activityalias" permissionDes="流程当前步骤">
				        ,{ label: '流程当前步骤', name: 'activityalias_', width: 150 }
				        </sec:accesscontrollist>
				        <sec:accesscontrollist hasPermission="3" domainObject="assetsReconAcceptance_table_businessstate" permissionDes="流程状态">
				        ,{ label: '流程状态', name: 'businessstate_', width: 150 }
				        </sec:accesscontrollist>
	];
	var searchNames = new Array();
	var searchTips = new Array();
						  		  							  		         searchNames.push("acceptanceNo");
    searchTips.push("验收单号");
		 	 		  										  		  																						  		         searchNames.push("formState");
    searchTips.push("单据状态");
		 	 		  							  		  							  		  							  		     		  							  		     		  							  		     		  							  		  							  		     		  							  		  							  		  							  		  							  		     		  							  							  							  		  							  		     		  							  		  							  		  							  		  							  		  							  							  		     		  							  							  		  							  		  							  		  							  		     		  							  		  							  							  							  		     		  							  		     		  							  		     		  							  		  							  		     		  							  		     		  							  		     		  							  		     		  							  		  																																																																																														var searchC = searchTips.length==2?'或' + searchTips[1] : "";
	$('#assetsReconAcceptance_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	assetsReconAcceptance = new AssetsReconAcceptance('assetsReconAcceptancejqGrid','${url}','searchDialog','form','assetsReconAcceptance_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#assetsReconAcceptance_insert').bind('click', function(){
		assetsReconAcceptance.insert();
	});
	//编辑按钮绑定事件
	$('#assetsReconAcceptance_modify').bind('click', function(){
		assetsReconAcceptance.modify();
	});
	//删除按钮绑定事件
	$('#assetsReconAcceptance_del').bind('click', function(){  
		assetsReconAcceptance.del();
	});
	//查询按钮绑定事件
	$('#assetsReconAcceptance_searchPart').bind('click', function(){
		assetsReconAcceptance.searchByKeyWord();
	});
	//打开高级查询框
	$('#assetsReconAcceptance_searchAll').bind('click', function(){
		assetsReconAcceptance.openSearchForm(this,800,400);
	});
	//根据流程状态加载数据
	$('#workFlowSelect').bind('change',function(){
		assetsReconAcceptance.initWorkFlow($(this).val());
	});
																																																	$('#createdByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'createdByDept',textFiled:'createdByDeptAlias'});
						this.blur();
						nullInput(e);
					});
																																																										$('#applyByAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'applyBy',textFiled:'applyByAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#applyByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'applyByDept',textFiled:'applyByDeptAlias'});
						this.blur();
						nullInput(e);
					});
																																																																																																																							$('#competentChiefEngineerAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'competentChiefEngineer',textFiled:'competentChiefEngineerAlias'});
						this.blur();
						nullInput(e);
					}); 
																								$('#ownerDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'ownerDept',textFiled:'ownerDeptAlias'});
						this.blur();
						nullInput(e);
					});
																								$('#ownerIdAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'ownerId',textFiled:'ownerIdAlias'});
						this.blur();
						nullInput(e);
					}); 
																																																																																	$('#projectDirectorAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'projectDirector',textFiled:'projectDirectorAlias'});
						this.blur();
						nullInput(e);
					}); 
																																																																																																																																																																																																																																																												$('#measureByAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'measureBy',textFiled:'measureByAlias'});
						this.blur();
						nullInput(e);
					}); 
																																																																																																																																																																																																																																																																																																																						
});

</script>
</html>