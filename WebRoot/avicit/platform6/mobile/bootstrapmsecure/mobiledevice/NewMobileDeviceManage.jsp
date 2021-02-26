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
<!-- ControllerPath = "platform6/bootstrapmsecure/mobiledevice/NewmobileDeviceController/toMobileDeviceManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div
		data-options="region:'center',onResize:function(a){$('#mobileDevice').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_mobileDevice" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileDevice_button_add"
					permissionDes="主表添加">
					<a id="mobileDevice_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileDevice_button_edit"
					permissionDes="主表编辑">
					<a id="mobileDevice_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileDevice_button_delete"
					permissionDes="主表删除">
					<a id="mobileDevice_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="mobileDevice_keyWord"
						id="mobileDevice_keyWord" style="width: 125px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="mobileDevice_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="mobileDevice_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="mobileDevice"></table>
		<div id="mobileDevicePager"></div>
	</div>
	<div
		data-options="region:'east',split:true,width:fixwidth(.3),onResize:function(a){$('#mobileUseDeviceBind').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_mobileUseDeviceBind" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileUseDeviceBind_button_add"
					permissionDes="子表添加">
					<a id="mobileUseDeviceBind_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileUseDeviceBind_button_edit"
					permissionDes="子表编辑">
					<a id="mobileUseDeviceBind_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileUseDeviceBind_button_delete"
					permissionDes="子表删除">
					<a id="mobileUseDeviceBind_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right"  style="height:34px;"></div>
			<!-- <div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="mobileUseDeviceBind_keyWord"
						id="mobileUseDeviceBind_keyWord" style="width: 125px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="mobileUseDeviceBind_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="mobileUseDeviceBind_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div> -->
		</div>
		<table id="mobileUseDeviceBind"></table>
		<div id="mobileUseDeviceBindPager"></div>
	</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form">
		<table class="form_commonTable">
			<tr>
				<th width="10%">设备IMEI:</th>
				<td width="39%"><input title="设备IMEI"
					class="form-control input-sm" type="text" name="imei" id="imei" />
				</td>
				<th width="10%">设备IMSI:</th>
				<td width="39%"><input title="设备IMSI"
					class="form-control input-sm" type="text" name="imsi" id="imsi" />
				</td>
			</tr>
			<tr>
				<th width="10%">屏幕分辨率:</th>
				<td width="39%"><input title="屏幕分辨率"
					class="form-control input-sm" type="text" name="screen" id="screen" />
				</td>
				<th width="10%">设备名称:</th>
				<td width="39%"><input title="设备名称"
					class="form-control input-sm" type="text" name="deviceName"
					id="deviceName" /></td>
			</tr>
			<tr>
				<th width="10%">设备平台:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="platform" id="platform" title="设备平台：ios或者android"
						isNull="true" lookupCode="PLATFORM_PLATFORM_APP_TYPE" /></td>
				<th width="10%">平台版本:</th>
				<td width="39%"><input title="平台版本"
					class="form-control input-sm" type="text" name="platformVersion"
					id="platformVersion" /></td>
			</tr>
			<tr>
				<th width="10%">设备状态:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="deviceStatus" id="deviceStatus" title="设备状态：true正常，false禁止"
						isNull="true" lookupCode="PLATFORM_APP_DEVICE_STATUS" /></td>
			</tr>
		</table>
	</form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto; display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid" />
		<table class="form_commonTable">
			<tr>
				<th width="10%">用户ID:</th>
				<td width="39%"><input title="用户ID"
					class="form-control input-sm" type="text" name="userId" id="userId" />
				</td>
				<th width="10%">APPID:</th>
				<td width="39%"><input title="APPID"
					class="form-control input-sm" type="text" name="appId" id="appId" />
				</td>
			</tr>
			<tr>
				<th width="10%">状态:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="bindStatus" id="bindStatus" title="状态" isNull="true"
						lookupCode="PLATFORM_APP_DEVICE_STATUS" /></td>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script
	src="avicit/platform6/mobile/bootstrapmsecure/mobiledevice/js/NewMobileDevice.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/mobile/bootstrapmsecure/mobiledevice/js/NewMobileUseDeviceBind.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var mobileDevice;
	var mobileUseDeviceBind;
	/* function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mobileDevice.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	} */
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="mobileDevice.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}

	$(document).ready(
			function() {
				var searchMainNames = new Array();
				var searchMainTips = new Array();
				searchMainNames.push("imei");
				searchMainTips.push("设备IMEI");
				searchMainNames.push("imsi");
				searchMainTips.push("设备IMSI");
				var searchMainC = searchMainTips.length == 2 ? '或'
						+ searchMainTips[1] : "";
				$('#mobileDevice_keyWord').attr('placeholder',
						'请输入' + searchMainTips[0] + searchMainC);
				var searchSubNames = new Array();
				var searchSubTips = new Array();
				searchSubNames.push("userId");
				searchSubTips.push("用户ID");
				searchSubNames.push("deviceId");
				searchSubTips.push("设备ID");
				var searchSubC = searchSubTips.length == 2 ? '或'
						+ searchSubTips[1] : "";
				$('#mobileUseDeviceBind_keyWord').attr('placeholder',
						'请输入' + searchSubTips[0] + searchSubC);
				var mobileDeviceGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '设备IMEI',
					name : 'imei',
					width : 150
				}, {
					label : '设备IMSI',
					name : 'imsi',
					width : 150
				}, {
					label : '屏幕分辨率',
					name : 'screen',
					width : 150
				}, {
					label : '设备名称',
					name : 'deviceName',
					width : 150
				}, {
					label : '设备平台',
					name : 'platform',
					width : 150
				}, {
					label : '平台版本',
					name : 'platformVersion',
					width : 150
				}, {
					label : '设备状态',
					name : 'deviceStatus',
					width : 150
				} ];
				var mobileUseDeviceBindGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '用户ID',
					name : 'userId',
					width : 150
				}, {
					label : '设备ID',
					name : 'deviceId',
					width : 150,
					hidden : true
				}, {
					label : '应用名称',
					name : 'appName',
					width : 150/* ,
					formatter: formatIdToName */
				}, {
					label : '状态',
					name : 'bindStatus',
					width : 150
				} ];
				mobileDevice = new MobileDevice('mobileDevice', '${url}',
						'form', mobileDeviceGridColModel, 'searchDialog',
						function(pid) {
							mobileUseDeviceBind = new MobileUseDeviceBind(
									'mobileUseDeviceBind', '${surl}',
									"formSub", mobileUseDeviceBindGridColModel,
									'searchDialogSub', pid, searchSubNames,
									"mobileUseDeviceBind_keyWord");
						}, function(pid) {
							mobileUseDeviceBind.reLoad(pid);
						}, searchMainNames, "mobileDevice_keyWord");
				//主表操作
				//添加按钮绑定事件
				$('#mobileDevice_insert').bind('click', function() {
					mobileDevice.insert();
				});
				//编辑按钮绑定事件
				$('#mobileDevice_modify').bind('click', function() {
					mobileDevice.modify();
				});
				//删除按钮绑定事件
				$('#mobileDevice_del').bind('click', function() {
					mobileDevice.del();
				});
				//打开高级查询框
				$('#mobileDevice_searchAll').bind('click', function() {
					mobileDevice.openSearchForm(this, $('#mobileDevice'));
				});
				//关键字段查询按钮绑定事件
				$('#mobileDevice_searchPart').bind('click', function() {
					mobileDevice.searchByKeyWord();
				});
				//子表操作
				//添加按钮绑定事件
				$('#mobileUseDeviceBind_insert').bind('click', function() {
					mobileUseDeviceBind.insert();
				});
				//编辑按钮绑定事件
				$('#mobileUseDeviceBind_modify').bind('click', function() {
					mobileUseDeviceBind.modify();
				});
				//删除按钮绑定事件
				$('#mobileUseDeviceBind_del').bind('click', function() {
					mobileUseDeviceBind.del();
				});
				//打开高级查询
				$('#mobileUseDeviceBind_searchAll').bind(
						'click',
						function() {
							mobileUseDeviceBind.openSearchForm(this,
									$('#mobileUseDeviceBind'));
						});
				//关键字段查询按钮绑定事件
				$('#mobileUseDeviceBind_searchPart').bind('click', function() {
					mobileUseDeviceBind.searchByKeyWord();
				});

			});
</script>
</html>