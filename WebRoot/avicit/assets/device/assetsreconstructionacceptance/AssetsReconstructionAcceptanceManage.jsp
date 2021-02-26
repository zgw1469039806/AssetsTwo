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
<!-- ControllerPath = "assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/toAssetsUstdtempAcceptanceManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_assetsUstdtempAcceptance_button_add"
				permissionDes="添加">
				<a id="assetsUstdtempAcceptance_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_assetsUstdtempAcceptance_button_edit"
				permissionDes="编辑">
				<a id="assetsUstdtempAcceptance_modify" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="编辑" style="display: none;"><i class="fa fa-file-text-o"></i>
					编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_assetsUstdtempAcceptance_button_delete"
				permissionDes="删除">
				<a id="assetsUstdtempAcceptance_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除" style="display: none;"><i class="fa fa-trash-o"></i>
					删除</a>
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
			<div class="input-group form-tool-search">
				<input type="text" name="assetsUstdtempAcceptance_keyWord"
					id="assetsUstdtempAcceptance_keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="assetsUstdtempAcceptance_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="assetsUstdtempAcceptance_searchAll" href="javascript:void(0)"
					class="btn btn-defaul btn-sm" role="button">高级查询 <span
					class="caret"></span></a>
			</div>
		</div>
	</div>
	<table id="assetsUstdtempAcceptancejqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<input type="hidden" id="bpmState" name="bpmState" value="all">
		<table class="form_commonTable">
			<tr>
				<th width="10%">验收单号:</th>
				<td width="39%"><input title="验收单号"
					class="form-control input-sm" type="text" name="acceptanceId"
					id="acceptanceId" /></td>
				<th width="10%">申请人部门:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="createdByDept" name="createdByDept">
						<input class="form-control" placeholder="请选择部门" type="text"
							id="createdByDeptAlias" name="createdByDeptAlias"> <span
							class="input-group-addon"> <i
							class="glyphicon glyphicon-equalizer"></i>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">单据状态:</th>
				<td width="39%"><input title="单据状态"
					class="form-control input-sm" type="text" name="formState"
					id="formState" /></td>
				<th width="10%">合同编号:</th>
				<td width="39%"><input title="合同编号"
					class="form-control input-sm" type="text" name="contractNum"
					id="contractNum" /></td>
			</tr>
			<tr>
				<th width="10%">设备名称:</th>
				<td width="39%"><input title="设备名称"
					class="form-control input-sm" type="text" name="deviceName"
					id="deviceName" /></td>
				<th width="10%">统一编号:</th>
				<td width="39%"><input title="统一编号"
					class="form-control input-sm" type="text" name="unifiedId"
					id="unifiedId" /></td>
			</tr>
			<tr>
				<th width="10%">密级:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="secretLevel" id="secretLevel" title="密级" isNull="true"
						lookupCode="SECRET_LEVEL" /></td>
				<th width="10%">生产厂家:</th>
				<td width="39%"><input title="生产厂家"
					class="form-control input-sm" type="text" name="manufacturerId"
					id="manufacturerId" /></td>
			</tr>
			<tr>
				<th width="10%">申购单号:</th>
				<td width="39%"><input title="申购单号"
					class="form-control input-sm" type="text" name="stdId" id="stdId" />
				</td>
				<th width="10%">责任部门:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="chargeDept" name="chargeDept"> <input
							class="form-control" placeholder="请选择部门" type="text"
							id="chargeDeptAlias" name="chargeDeptAlias"> <span
							class="input-group-addon"> <i
							class="glyphicon glyphicon-equalizer"></i>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">责任人:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="chargePerson" name="chargePerson">
						<input class="form-control" placeholder="请选择用户" type="text"
							id="chargePersonAlias" name="chargePersonAlias"> <span
							class="input-group-addon"> <i
							class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
				<th width="10%">责任人联系方式:</th>
				<td width="39%"><input title="责任人联系方式"
					class="form-control input-sm" type="text" name="chargePersonTel"
					id="chargePersonTel" /></td>
			</tr>
			<tr>
				<th width="10%">单价(元):</th>
				<td width="39%">
					<div class="input-group input-group-sm spinner"
						data-trigger="spinner">
						<input class="form-control" type="text" name="unitPrice"
							id="unitPrice" data-min="-<%=Math.pow(10, 12) - Math.pow(10, -3)%>"
							data-max="<%=Math.pow(10, 12) - Math.pow(10, -3)%>" data-step="1"
							data-precision="3"> <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i
								class="glyphicon glyphicon-triangle-top"></i></a> <a
							href="javascript:;" class="spin-down" data-spin="down"><i
								class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th width="10%">设备类别:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="deviceCategory" id="deviceCategory" title="设备类别"
						isNull="true" lookupCode="DEVICE_CATEGORY" /></td>
			</tr>
			<tr>
				<th width="10%">是否定检:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="isRegularCheck" id="isRegularCheck" title="是否定检"
						isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" /></td>
				<th width="10%">是否点检:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="isSpotCheck" id="isSpotCheck" title="是否点检" isNull="true"
						lookupCode="PLATFORM_YES_NO_FLAG" /></td>
			</tr>
			<tr>
				<th width="10%">是否精度检查:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="isAccuracyCheck" id="isAccuracyCheck" title="是否精度检查"
						isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" /></td>
				<th width="10%">是否保养:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="isMaintain" id="isMaintain" title="是否保养" isNull="true"
						lookupCode="PLATFORM_YES_NO_FLAG" /></td>
			</tr>
			<tr>
				<th width="10%">是否计量:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="isMetering" id="isMetering" title="是否计量" isNull="true"
						lookupCode="PLATFORM_YES_NO_FLAG" /></td>
				<th width="10%">是否需要安装:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="isNeedInstall" id="isNeedInstall" title="是否需要安装"
						isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" /></td>
			</tr>
			<tr>
				<th width="10%">是否现场计量:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="isSceneMetering" id="isSceneMetering" title="是否现场计量"
						isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" /></td>
				<th width="10%">计量标识:</th>
				<td width="39%"><input title="计量标识"
					class="form-control input-sm" type="text" name="meteringId"
					id="meteringId" /></td>
			</tr>
			<tr>
				<th width="10%">计量人员:</th>
				<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="meterman" name="meterman"> <input
							class="form-control" placeholder="请选择用户" type="text"
							id="metermanAlias" name="metermanAlias"> <span
							class="input-group-addon"> <i
							class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
				<th width="10%">计量时间(从):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="meteringDateBegin" id="meteringDateBegin" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">计量时间(至):</th>
				<td width="39%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="meteringDateEnd" id="meteringDateEnd" /> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">计量周期:</th>
				<td width="39%">
					<div class="input-group input-group-sm spinner"
						data-trigger="spinner">
						<input class="form-control" type="text" name="meteringCycle"
							id="meteringCycle"
							data-min="-<%=Math.pow(10, 12) - Math.pow(10, -0)%>"
							data-max="<%=Math.pow(10, 12) - Math.pow(10, -0)%>" data-step="1"
							data-precision="0"> <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i
								class="glyphicon glyphicon-triangle-top"></i></a> <a
							href="javascript:;" class="spin-down" data-spin="down"><i
								class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">安装地点:</th>
				<td width="39%"><input title="安装地点"
					class="form-control input-sm" type="text" name="position"
					id="position" /></td>
				<th width="10%">是否涉及安全生产:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="isSafetyProduction" id="isSafetyProduction" title="是否涉及安全生产"
						isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" /></td>
			</tr>
			<tr>
				<th width="10%">经费来源:</th>
				<td width="39%"><input title="经费来源"
					class="form-control input-sm" type="text" name="financialResources"
					id="financialResources" /></td>
				<th width="10%">所属项目:</th>
				<td width="39%"><input title="所属项目"
					class="form-control input-sm" type="text" name="belongProject"
					id="belongProject" /></td>
			</tr>
			<tr>
				<th width="10%">项目序号:</th>
				<td width="39%"><input title="项目序号"
					class="form-control input-sm" type="text" name="projectNo"
					id="projectNo" /></td>
				<th width="10%">批复名称:</th>
				<td width="39%"><input title="批复名称"
					class="form-control input-sm" type="text" name="replyName"
					id="replyName" /></td>
			</tr>
			<tr>
				<th width="10%">立项单号:</th>
				<td width="39%"><input title="立项单号"
					class="form-control input-sm" type="text" name="approvalFormNumber"
					id="approvalFormNumber" /></td>
				<th width="10%">ABC分类:</th>
				<td width="39%"><input title="ABC分类"
					class="form-control input-sm" type="text" name="abcCategory"
					id="abcCategory" /></td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script
	src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<!-- 业务的js -->
<script
	src="avicit/assets/device/assetsreconstructionacceptance/js/AssetsReconstructionAcceptance.js"
	type="text/javascript"></script>
<script type="text/javascript">
var assetsUstdtempAcceptance;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="assetsUstdtempAcceptance.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="assetsUstdtempAcceptance.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//刷新本页面
window.bpm_operator_refresh = function(){
	assetsUstdtempAcceptance.reLoad();
};
$(document).ready(function () {
	var dataGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																		  																	,{ label: '验收单号', name: 'acceptanceId', width: 150,formatter:formatValue}
																															  																		,{ label: '申请人部门', name: 'createdByDeptAlias', width: 150}
																													  																		,{ label: '单据状态', name: 'formState', width: 150}
																																  																		,{ label: '合同编号', name: 'contractNum', width: 150}
																																									  																		,{ label: '设备名称', name: 'deviceName', width: 150}
																													  																		,{ label: '统一编号', name: 'unifiedId', width: 150}
																													  																		,{ label: '密级', name: 'secretLevel', width: 150}
																													  																		,{ label: '生产厂家', name: 'manufacturerId', width: 150}
																													  																		,{ label: '申购单号', name: 'stdId', width: 150}
																													  																		,{ label: '责任部门', name: 'chargeDeptAlias', width: 150}
																													  																		,{ label: '责任人', name: 'chargePersonAlias', width: 150}
																													  																		,{ label: '责任人联系方式', name: 'chargePersonTel', width: 150}
																													  																		,{ label: '单价(元)', name: 'unitPrice', width: 150}
																													  																		,{ label: '设备类别', name: 'deviceCategory', width: 150}
																													  																		,{ label: '是否定检', name: 'isRegularCheck', width: 150}
																													  																		,{ label: '是否点检', name: 'isSpotCheck', width: 150}
																													  																		,{ label: '是否精度检查', name: 'isAccuracyCheck', width: 150}
																													  																		,{ label: '是否保养', name: 'isMaintain', width: 150}
																													  																		,{ label: '是否计量', name: 'isMetering', width: 150}
																													  																		,{ label: '是否需要安装', name: 'isNeedInstall', width: 150}
																													  																		,{ label: '是否现场计量', name: 'isSceneMetering', width: 150}
																													  																		,{ label: '计量标识', name: 'meteringId', width: 150}
																													  																		,{ label: '计量人员', name: 'metermanAlias', width: 150}
																													  																		,{ label: '计量时间', name: 'meteringDate', width: 150,formatter:format}
																													  																		,{ label: '计量周期', name: 'meteringCycle', width: 150}
																													  																		,{ label: '安装地点', name: 'position', width: 150}
																													  																		,{ label: '是否涉及安全生产', name: 'isSafetyProduction', width: 150}
																													  																		,{ label: '经费来源', name: 'financialResources', width: 150}
																													  																		,{ label: '所属项目', name: 'belongProject', width: 150}
																													  																		,{ label: '项目序号', name: 'projectNo', width: 150}
																													  																		,{ label: '批复名称', name: 'replyName', width: 150}
																													  																		,{ label: '立项单号', name: 'approvalFormNumber', width: 150}
																																																																																									  																		,{ label: 'ABC分类', name: 'abcCategory', width: 150}
																											<sec:accesscontrollist hasPermission="3" domainObject="assetsUstdtempAcceptance_table_activityalias" permissionDes="流程当前步骤">
				        ,{ label: '流程当前步骤', name: 'activityalias_', width: 150 }
				        </sec:accesscontrollist>
				        <sec:accesscontrollist hasPermission="3" domainObject="assetsUstdtempAcceptance_table_businessstate" permissionDes="流程状态">
				        ,{ label: '流程状态', name: 'businessstate_', width: 150 }
				        </sec:accesscontrollist>
	];
	var searchNames = new Array();
	var searchTips = new Array();
						  		  							  		         searchNames.push("acceptanceId");
    searchTips.push("验收单号");
		 	 		  										  		  							  		         searchNames.push("formState");
    searchTips.push("单据状态");
		 	 		  										  		     		  																			  		     		  							  		     		  							  		  							  		     		  							  		     		  							  		  							  		  							  		     		  							  							  		  							  		  							  		  							  		  							  		  							  		  							  		  							  		  							  		     		  							  		  							  							  							  		     		  							  		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  																																																																			  		     		  				var searchC = searchTips.length==2?'或' + searchTips[1] : "";
	$('#assetsUstdtempAcceptance_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	assetsUstdtempAcceptance = new AssetsUstdtempAcceptance('assetsUstdtempAcceptancejqGrid','${url}','searchDialog','form','assetsUstdtempAcceptance_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#assetsUstdtempAcceptance_insert').bind('click', function(){
		assetsUstdtempAcceptance.insert();
	});
	//编辑按钮绑定事件
	$('#assetsUstdtempAcceptance_modify').bind('click', function(){
		assetsUstdtempAcceptance.modify();
	});
	//删除按钮绑定事件
	$('#assetsUstdtempAcceptance_del').bind('click', function(){  
		assetsUstdtempAcceptance.del();
	});
	//查询按钮绑定事件
	$('#assetsUstdtempAcceptance_searchPart').bind('click', function(){
		assetsUstdtempAcceptance.searchByKeyWord();
	});
	//打开高级查询框
	$('#assetsUstdtempAcceptance_searchAll').bind('click', function(){
		assetsUstdtempAcceptance.openSearchForm(this,800,400);
	});
	//根据流程状态加载数据
	$('#workFlowSelect').bind('change',function(){
		assetsUstdtempAcceptance.initWorkFlow($(this).val());
	});
																																																	$('#createdByDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'createdByDept',textFiled:'createdByDeptAlias'});
						this.blur();
						nullInput(e);
					});
																																																																																																																																																																												$('#chargeDeptAlias').on('focus',function(e){
						new H5CommonSelect({type:'deptSelect', idFiled:'chargeDept',textFiled:'chargeDeptAlias'});
						this.blur();
						nullInput(e);
					});
																								$('#chargePersonAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'chargePerson',textFiled:'chargePersonAlias'});
						this.blur();
						nullInput(e);
					}); 
																																																																																																																																																																																																																																									$('#metermanAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'meterman',textFiled:'metermanAlias'});
						this.blur();
						nullInput(e);
					}); 
																																																																																																																																																																																																																																																																					
});

</script>
</html>