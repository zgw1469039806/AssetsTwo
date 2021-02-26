<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
	<head>
		<!-- ControllerPath = "assets/device/assetsallotproc/assetsAllotProcController/toAssetsAllotProcManage" -->
		<title>管理</title>
		<base href="<%=ViewUtil.getRequestPath(request)%>">
		<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
			<jsp:param value="<%=importlibs%>" name="importlibs"/>
		</jsp:include>
	</head>

	<body class="easyui-layout" fit="true">
		<div id="panelnorth"
			 data-options="region:'north',height:fixheight(.5),onResize:function(a){$('#assetsAllotProc').setGridWidth(a);$('#assetsAllotProc').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
			<div id="toolbar_assetsAllotProc" class="toolbar">
				<div class="toolbar-left">
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsAllotProc_button_add"
										   permissionDes="添加">
						<a id="assetsAllotProc_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
						   role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsAllotProc_button_edit"
										   permissionDes="编辑">
						<a id="assetsAllotProc_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
						   style="display:none;" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsAllotProc_button_delete"
										   permissionDes="删除">
						<a id="assetsAllotProc_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm"
						   style="display:none;" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
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
						<input type="text" name="assetsAllotProc_keyWord" id="assetsAllotProc_keyWord" style="width:125px;"
							   class="form-control input-sm" placeholder="请输入查询条件">
						<label id="assetsAllotProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="assetsAllotProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
							<span class="caret"></span></a>
					</div>
				</div>
			</div>
			<table id="assetsAllotProc"></table>
			<div id="assetsAllotProcPager"></div>
		</div>
		<div id="centerpanel"
			 data-options="region:'center',split:true,onResize:function(a){$('#allotAssets').setGridWidth(a); $('#allotAssets').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
			<div id="toolbar_allotAssets" class="toolbar">
				<div class="toolbar-right">
					<div class="input-group form-tool-search" style="width:125px">
						<input type="text" name="allotAssets_keyWord" id="allotAssets_keyWord" style="width:125px;"
							   class="form-control input-sm" placeholder="请输入查询条件">
						<label id="allotAssets_searchPart" class="icon icon-search form-tool-searchicon"></label>
					</div>
					<div class="input-group-btn form-tool-searchbtn">
						<a id="allotAssets_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
							<span class="caret"></span></a>
					</div>
				</div>
			</div>
			<table id="allotAssets"></table>
			<div id="allotAssetsPager"></div>
		</div>
	</body>

	<!-- 主表高级查询 -->
	<div id="searchDialog" style="overflow: auto;display: none">
		<form id="form">
			<input type="hidden" id="bpmState" name="bpmState" value="all">
			<table class="form_commonTable">
				<tr>
					<th width="10%">调拨单号:</th>
					<td width="15%">
						<input title="调拨单号" class="form-control input-sm" type="text" name="allotNo" id="allotNo"/>
					</td>
					<th width="10%">申请人部门:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="createdByDept" name="createdByDept">
							<input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-equalizer"></i>
						  	</span>
						</div>
					</td>
					<th width="10%">申请人电话:</th>
					<td width="15%">
						<input title="申请人电话" class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"/>
					</td>
					<th width="10%">单据状态:</th>
					<td width="15%">
						<input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
					</td>
				</tr>
				<tr>
					<th width="10%">调入部门:</th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="callinDept" name="callinDept">
							<input class="form-control" placeholder="请选择部门" type="text" id="callinDeptAlias" name="callinDeptAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-equalizer"></i>
							</span>
						</div>
					</td>
					<th width="10%">设备组成:</th>
					<td width="15%">
						<textarea class="form-control input-sm" rows="3" title="设备组成" name="assetsCompose" id="assetsCompose"></textarea>
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
					<th width="10%">统一编号:</th>
					<td width="15%">
						<input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
					</td>
					<th width="10%">设备名称:</th>
					<td width="15%">
						<input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
					</td>
					<th width="10%">设备型号:</th>
					<td width="15%">
						<input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
					</td>
					<th width="10%">设备规格:</th>
					<td width="15%">
						<input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
					</td>
				</tr>
				<tr>
					<th width="10%">生产厂家:</th>
					<td width="15%">
						<input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId"/>
					</td>
					<th width="10%">密级:</th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级" isNull="true" lookupCode="SECRET_LEVEL"/>
					</td>
					<th width="10%">是否涉及安全生产:</th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction" title="是否涉及安全生产" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
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
	<script src="avicit/assets/device/assetsallotproc/js/AssetsAllotProc.js" type="text/javascript"></script>
	<script src="avicit/assets/device/assetsallotproc/js/AllotAssets.js" type="text/javascript"></script>

	<script type="text/javascript">
		var assetsAllotProc;
		var allotAssets;

		function formatValue(cellvalue, options, rowObject) {
			return '<a href="javascript:void(0);" onclick="assetsAllotProc.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
		}

		function formatDateForHref(cellvalue, options, rowObject) {
			var thisDate = format(cellvalue);
			return '<a href="javascript:void(0);" onclick="assetsAllotProc.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
		}

		//刷新本页面
		window.bpm_operator_refresh = function () {
			assetsAllotProc.reLoad();
		};

		$(document).ready(function () {
			var searchMainNames = new Array();
			var searchMainTips = new Array();
			searchMainNames.push("allotNo");
			searchMainTips.push("调拨单号");
			searchMainNames.push("createdByTel");
			searchMainTips.push("申请人电话");
			var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
			$('#assetsAllotProc_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
			$('#assetsAllotProc_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
			var searchSubNames = new Array();
			var searchSubTips = new Array();
			searchSubNames.push("unifiedId");
			searchSubTips.push("统一编号");
			searchSubNames.push("deviceName");
			searchSubTips.push("设备名称");
			var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
			$('#allotAssets_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
			$('#allotAssets_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
			var assetsAllotProcGridColModel = [
				{label: 'id', name: 'id', key: true, width: 75, hidden: true}
				, {label: '调拨单号', name: 'allotNo', width: 150, formatter: formatValue}
				, {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
				, {label: '申请人电话', name: 'createdByTel', width: 150}
				, {label: '单据状态', name: 'formState', width: 150}
				, {label: '调入部门', name: 'callinDeptAlias', width: 150}
				, {label: '设备组成', name: 'assetsCompose', width: 150}
				, {label: '流程当前步骤', name: 'activityalias_', width: 150}
				, {label: '流程状态', name: 'businessstate_', width: 150}
			];

			var allotAssetsGridColModel = [
				{label: 'id', name: 'id', key: true, width: 75, hidden: true}
				, {label: '统一编号', name: 'unifiedId', width: 150}
				, {label: '设备名称', name: 'deviceName', width: 150}
				, {label: '设备型号', name: 'deviceModel', width: 150}
				, {label: '设备规格', name: 'deviceSpec', width: 150}
				, {label: '生产厂家', name: 'manufacturerId', width: 150}
				, {label: '密级', name: 'secretLevelName', width: 150}
				, {label: '是否涉及安全生产', name: 'isSafetyProductionName', width: 150}
			];

			assetsAllotProc = new AssetsAllotProc('assetsAllotProc', '${url}', 'form', assetsAllotProcGridColModel, 'searchDialog',
				function (pid) {
					allotAssets = new AllotAssets('allotAssets', '${surl}', "formSub", allotAssetsGridColModel, 'searchDialogSub', pid, searchSubNames, "allotAssets_keyWord");
				},
				function (pid) {
					allotAssets.reLoad(pid);
				},
				searchMainNames,
				"assetsAllotProc_keyWord");

			//主表操作
			$('#assetsAllotProc_insert').bind('click', function () {	//添加按钮绑定事件
				assetsAllotProc.insert();
			});

			$('#assetsAllotProc_modify').bind('click', function () {	//编辑按钮绑定事件
				assetsAllotProc.modify();
			});

			$('#assetsAllotProc_del').bind('click', function () {	//删除按钮绑定事件
				assetsAllotProc.del();
			});

			$('#assetsAllotProc_searchAll').bind('click', function () {	//打开高级查询框
				assetsAllotProc.openSearchForm(this, $('#assetsAllotProc'));
			});

			$('#assetsAllotProc_searchPart').bind('click', function () {	//关键字段查询按钮绑定事件
				assetsAllotProc.searchByKeyWord();
			});

			$('#workFlowSelect').bind('change', function () {	//根据流程状态加载数据
				assetsAllotProc.initWorkFlow($(this).val());
			});

			//子表操作
			$('#allotAssets_searchAll').bind('click', function () {	//打开高级查询
				allotAssets.openSearchForm(this, $('#allotAssets'));
			});

			$('#allotAssets_searchPart').bind('click', function () {	//关键字段查询按钮绑定事件
				allotAssets.searchByKeyWord();
			});

			$('#createdByDeptAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
				this.blur();
				nullInput(e);
			});
			$('#callinDeptAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'deptSelect', idFiled: 'callinDept', textFiled: 'callinDeptAlias'});
				this.blur();
				nullInput(e);
			});
		});
	</script>
</html>