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
<!-- ControllerPath = "assets/device/assetsreconstructionproc/assetsReconstructionProcController/toAssetsReconstructionProcManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsReconstructionProc_button_add" permissionDes="添加">
  	<a id="assetsReconstructionProc_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsReconstructionProc_button_edit" permissionDes="编辑">
	<a id="assetsReconstructionProc_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑" style="display:none;"><i class="fa fa-file-text-o"></i> 编辑</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsReconstructionProc_button_delete" permissionDes="删除">
	<a id="assetsReconstructionProc_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除" style="display:none;"><i class="fa fa-trash-o"></i> 删除</a>
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
     		<input type="text" name="assetsReconstructionProc_keyWord" id="assetsReconstructionProc_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="assetsReconstructionProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="assetsReconstructionProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="assetsReconstructionProcjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		   <input type="hidden" id="bpmState" name="bpmState" value="all">
    	   <table class="form_commonTable">
			    <tr>
																						  						   						   						   							 							 						   																							  						   						   						   							 								<th width="10%">改造申请单号:</th>
										    								 <td width="15%">
	    								 <input title="改造申请单号" class="form-control input-sm" type="text" name="reconstructionId" id="reconstructionId" />
	    								 </td>
																								 						   																																		  						   						   						   							 								<th width="10%">申请人部门:</th>
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
																								 						   																																																																														  						   						   						   							 								<th width="10%">责任部门:</th>
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
																								 						   																							  						   						   						   							 								<th width="10%">设备名称:</th>
										    								 <td width="15%">
	    								 <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">密级:</th>
																		 <td width="15%">
                                     <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级" isNull="true" lookupCode="SECRET_LEVEL" />
                                     </td>
                                     																	</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">统一编号:</th>
										    								 <td width="15%">
	    								 <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">设备型号:</th>
										    								 <td width="15%">
	    								 <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">设备规格:</th>
										    								 <td width="15%">
	    								 <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec" />
	    								 </td>
																								 						   																							  						   						   						   							 								<th width="10%">生产厂家:</th>
										    								 <td width="15%">
	    								 <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId" />
	    								 </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 									<th width="10%">立卡时间(从):</th>
    								   <td width="15%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="likaDateBegin" id="likaDateBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
										    									<th width="10%">立卡时间(至):</th>
    									<td width="15%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="likaDateEnd" id="likaDateEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   																							  						   						   						   							 								<th width="10%">设备原值:</th>
																			<td width="15%">
																				     												<div class="input-group input-group-sm spinner" data-trigger="spinner">
												  <input  class="form-control"  type="text" name="originalValue" id="originalValue"  data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
												  <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
												</div>	
																					  										</td>
																								 						   																							  						   						   						   							 								<th width="10%">现有结构性能指标:</th>
															                     <td width="15%">
						                     <textarea class="form-control input-sm" rows="3" title="现有结构性能指标" name="existingPerformance" id="existingPerformance" ></textarea>
						                    </td>
																										</tr>
									<tr>
															 						   																							  						   						   						   							 								<th width="10%">改造理由:</th>
															                     <td width="15%">
						                     <textarea class="form-control input-sm" rows="3" title="改造理由" name="reformingReason" id="reformingReason" ></textarea>
						                    </td>
																								 						   																							  						   						   						   							 								<th width="10%">改造后结构性能指标:</th>
															                     <td width="15%">
						                     <textarea class="form-control input-sm" rows="3" title="改造后结构性能指标" name="afterPerformance" id="afterPerformance" ></textarea>
						                    </td>
																								 						   																							  						   						   						   							 								<th width="10%">改造途径:</th>
															                     <td width="15%">
						                     <textarea class="form-control input-sm" rows="3" title="改造途径" name="transformWay" id="transformWay" ></textarea>
						                    </td>
																								 						   																							  						   						   						   							 								<th width="10%">经费预算:</th>
										    								 <td width="15%">
	    								 <input title="经费预算" class="form-control input-sm" type="text" name="budget" id="budget" />
	    								 </td>
																										</tr>
									<tr>
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
<script src="avicit/assets/device/assetsreconstructionproc/js/AssetsReconstructionProc.js" type="text/javascript"></script>
<script type="text/javascript">
var assetsReconstructionProc;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="assetsReconstructionProc.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="assetsReconstructionProc.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//刷新本页面
window.bpm_operator_refresh = function(){
	assetsReconstructionProc.reLoad();
};
$(document).ready(function () {
	var dataGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																		  																	,{ label: '改造申请单号', name: 'reconstructionId', width: 150,formatter:formatValue}
																															  																		,{ label: '申请人部门', name: 'createdByDeptAlias', width: 150}
																													  																		,{ label: '单据状态', name: 'formState', width: 150}
																																												  																		,{ label: '责任部门', name: 'ownerDeptAlias', width: 150}
																													  																		,{ label: '责任人', name: 'ownerIdAlias', width: 150}
																													  																		,{ label: '责任人联系方式', name: 'ownerTel', width: 150}
																													  																		,{ label: '设备名称', name: 'deviceName', width: 150}
																													  																		,{ label: '密级', name: 'secretLevel', width: 150}
																													  																		,{ label: '统一编号', name: 'unifiedId', width: 150}
																													  																		,{ label: '设备型号', name: 'deviceModel', width: 150}
																													  																		,{ label: '设备规格', name: 'deviceSpec', width: 150}
																													  																		,{ label: '生产厂家', name: 'manufacturerId', width: 150}
																													  																		,{ label: '立卡时间', name: 'likaDate', width: 150,formatter:format}
																													  																		,{ label: '设备原值', name: 'originalValue', width: 150}
																													  																		,{ label: '现有结构性能指标', name: 'existingPerformance', width: 150}
																													  																		,{ label: '改造理由', name: 'reformingReason', width: 150}
																													  																		,{ label: '改造后结构性能指标', name: 'afterPerformance', width: 150}
																													  																		,{ label: '改造途径', name: 'transformWay', width: 150}
																													  																		,{ label: '经费预算', name: 'budget', width: 150}
																																																																																							<sec:accesscontrollist hasPermission="3" domainObject="assetsReconstructionProc_table_activityalias" permissionDes="流程当前步骤">
				        ,{ label: '流程当前步骤', name: 'activityalias_', width: 150 }
				        </sec:accesscontrollist>
				        <sec:accesscontrollist hasPermission="3" domainObject="assetsReconstructionProc_table_businessstate" permissionDes="流程状态">
				        ,{ label: '流程状态', name: 'businessstate_', width: 150 }
				        </sec:accesscontrollist>
	];
	var searchNames = new Array();
	var searchTips = new Array();
						  		  							  		         searchNames.push("reconstructionId");
    searchTips.push("改造申请单号");
		 	 		  										  		  							  		         searchNames.push("formState");
    searchTips.push("单据状态");
		 	 		  																						  		  							  		  							  		     		  							  		     		  							  		  							  		     		  							  		     		  							  		     		  							  		     		  							  							  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  																																																																var searchC = searchTips.length==2?'或' + searchTips[1] : "";
	$('#assetsReconstructionProc_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	assetsReconstructionProc = new AssetsReconstructionProc('assetsReconstructionProcjqGrid','${url}','searchDialog','form','assetsReconstructionProc_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#assetsReconstructionProc_insert').bind('click', function(){
		assetsReconstructionProc.insert();
	});
	//编辑按钮绑定事件
	$('#assetsReconstructionProc_modify').bind('click', function(){
		assetsReconstructionProc.modify();
	});
	//删除按钮绑定事件
	$('#assetsReconstructionProc_del').bind('click', function(){  
		assetsReconstructionProc.del();
	});
	//查询按钮绑定事件
	$('#assetsReconstructionProc_searchPart').bind('click', function(){
		assetsReconstructionProc.searchByKeyWord();
	});
	//打开高级查询框
	$('#assetsReconstructionProc_searchAll').bind('click', function(){
		assetsReconstructionProc.openSearchForm(this,800,400);
	});
	//根据流程状态加载数据
	$('#workFlowSelect').bind('change',function(){
		assetsReconstructionProc.initWorkFlow($(this).val());
	});
																																																	$('#createdByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'createdByDept',textFiled:'createdByDeptAlias'});
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
																																																																																																																																																																																																																																																																																																																																																	
});

</script>
</html>