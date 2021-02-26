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
<!-- ControllerPath = "platform6/bootstrapmsecure/mobileapp/NewmobileAppController/toMobileAppManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div
		data-options="region:'center',onResize:function(a){$('#mobileApp').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_mobileApp" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileApp_button_add" permissionDes="主表添加">
					<a id="mobileApp_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileApp_button_edit"
					permissionDes="主表编辑">
					<a id="mobileApp_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileApp_button_delete"
					permissionDes="主表删除">
					<a id="mobileApp_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="mobileApp_keyWord" id="mobileApp_keyWord"
						style="width: 125px;" class="form-control input-sm"
						placeholder="请输入查询条件"> <label id="mobileApp_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="mobileApp_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="mobileApp"></table>
		<div id="mobileAppPager"></div>
	</div>
	<div
		data-options="region:'east',split:true,width:fixwidth(.5),onResize:function(a){$('#mobileAppVersion').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_mobileAppVersion" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileAppVersion_button_add"
					permissionDes="子表添加">
					<a id="mobileAppVersion_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileAppVersion_button_edit"
					permissionDes="子表编辑">
					<a id="mobileAppVersion_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_mobileAppVersion_button_delete"
					permissionDes="子表删除">
					<a id="mobileAppVersion_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
				<td><small style="color:red; padding:5px;">提示：ios和android都只能有且只能有一个最新版</small></td>
				<div class="toolbar-right"  style="height:4px;"></div>
			</div>
<!-- 			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 125px">
					<input type="text" name="mobileAppVersion_keyWord"
						id="mobileAppVersion_keyWord" style="width: 125px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="mobileAppVersion_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="mobileAppVersion_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div> -->
		</div>
		<table id="mobileAppVersion"></table>
		<div id="mobileAppVersionPager"></div>
	</div>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form">
		<table class="form_commonTable">
			<tr>
				<th width="10%">应用名称：</th>
				<td width="39%"><input title="应用名称"
					class="form-control input-sm" type="text" name="appName"
					id="appName" /></td>
				<th width="10%">应用状态：</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="appStatus" id="appStatus" title="应用状态：true正常，false禁用"
						isNull="true" lookupCode="PLATFORM_APP_STATUS" /></td>
			</tr>
			<tr>
				<th width="10%">应用描述：</th>
				<td width="39%"><input title="应用描述"
					class="form-control input-sm" type="text" name="descript"
					id="descript" /></td>
				<th width="10%">应用是否需要绑定：</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="appBindChose" id="appBindChose"
						title="应用是否需要绑定：true需要，false不需要" isNull="true"
						lookupCode="PLATFORM_APP_BIND_CHOSE" /></td>
			</tr>
			<tr>
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
				<th width="10%">APP版本类型</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="platformType" id="platformType" title="APP版本类型：ios或者android"
						isNull="true" lookupCode="PLATFORM_PLATFORM_APP_TYPE" /></td>
				<th width="10%">应用版本号</th>
				<td width="39%"><input title="应用版本"
					class="form-control input-sm" type="text" name="appVersion"
					id="appVersion" /></td>
			</tr>
			<tr>
				<th width="10%">版本状态</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="appStatus" id="appStatus" title="版本状态：true正常，false禁用"
						isNull="true" lookupCode="PLATFORM_APP_VERSION_STATUS" /></td>
				<th width="10%">应用下载地址</th>
				<td width="39%"><input title="应用下载地址"
					class="form-control input-sm" type="text" name="downloadUrl"
					id="downloadUrl" /></td>
			</tr>
			<tr>
				<th width="10%">应用描述:</th>
				<td width="39%"><input title="应用描述"
					class="form-control input-sm" type="text" name="descript"
					id="descript" /></td>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script
	src="avicit/platform6/mobile/bootstrapmsecure/mobileapp/js/NewMobileApp.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/mobile/bootstrapmsecure/mobileapp/js/NewMobileAppVersion.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var mobileApp;
	var mobileAppVersion;
/* 	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mobileApp.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	} */
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="mobileApp.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}

	$(document).ready(
			function() {
				var searchMainNames = new Array();
				var searchMainTips = new Array();
				searchMainNames.push("appName");
				searchMainTips.push("应用名称");
				searchMainNames.push("descript");
				searchMainTips.push("应用描述");
				var searchMainC = searchMainTips.length == 2 ? '或'
						+ searchMainTips[1] : "";
				$('#mobileApp_keyWord').attr('placeholder',
						'请输入' + searchMainTips[0] + searchMainC);
				var searchSubNames = new Array();
				var searchSubTips = new Array();
				searchSubNames.push("appId");
				searchSubTips.push("应用ID，MOBILE_APP外键");
				searchSubNames.push("appVersion");
				searchSubTips.push("应用版本");
				var searchSubC = searchSubTips.length == 2 ? '或'
						+ searchSubTips[1] : "";
				$('#mobileAppVersion_keyWord').attr('placeholder',
						'请输入' + searchSubTips[0] + searchSubC);
				var mobileAppGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '应用名称',
					name : 'appName',
					width : 150
				}, {
					label : '应用状态',
					name : 'appStatus',
					width : 150
				}, {
					label : '应用是否需要绑定',
					name : 'appBindChose',
					width : 150
				}, {
					label : '应用描述',
					name : 'descript',
					width : 150
				} ];
				var mobileAppVersionGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, /* {
					label : '应用ID，MOBILE_APP外键',
					name : 'appId',
					width : 150,
					hidden : true
				}, */ {
					label : 'APP版本类型',
					name : 'platformType',
					width : 150
				}, {
					label : '应用版本号',
					name : 'appVersion',
					width : 150
				}, {
					label : '版本状态',
					name : 'appStatus',
					width : 150
				}/* , {
					label : '应用下载地址',
					name : 'downloadUrl',
					width : 150,
					hidden : true
				}, {
					label : '应用描述',
					name : 'descript',
					width : 150,
					hidden : true
				}  */];

				mobileApp = new MobileApp('mobileApp', '${url}', 'form',
						mobileAppGridColModel, 'searchDialog', function(pid) {
							mobileAppVersion = new MobileAppVersion(
									'mobileAppVersion', '${surl}', "formSub",
									mobileAppVersionGridColModel,
									'searchDialogSub', pid, searchSubNames,
									"mobileAppVersion_keyWord");
						}, function(pid) {
							mobileAppVersion.reLoad(pid);
						}, searchMainNames, "mobileApp_keyWord");
				//主表操作
				//添加按钮绑定事件
				$('#mobileApp_insert').bind('click', function() {
					mobileApp.insert();
				});
				//编辑按钮绑定事件
				$('#mobileApp_modify').bind('click', function() {
					mobileApp.modify();
				});
				//删除按钮绑定事件
				$('#mobileApp_del').bind('click', function() {
					mobileApp.del();
				});
				//打开高级查询框
				$('#mobileApp_searchAll').bind('click', function() {
					mobileApp.openSearchForm(this, $('#mobileApp'));
				});
				//关键字段查询按钮绑定事件
				$('#mobileApp_searchPart').bind('click', function() {
					mobileApp.searchByKeyWord();
				});
				//子表操作
				//添加按钮绑定事件
				$('#mobileAppVersion_insert').bind('click', function() {
					mobileAppVersion.insert();
				});
				//编辑按钮绑定事件
				$('#mobileAppVersion_modify').bind('click', function() {
					mobileAppVersion.modify();
				});
				//删除按钮绑定事件
				$('#mobileAppVersion_del').bind('click', function() {
					mobileAppVersion.del();
				});
				//打开高级查询
				$('#mobileAppVersion_searchAll').bind(
						'click',
						function() {
							mobileAppVersion.openSearchForm(this,
									$('#mobileAppVersion'));
						});
				//关键字段查询按钮绑定事件
				$('#mobileAppVersion_searchPart').bind('click', function() {
					mobileAppVersion.searchByKeyWord();
				});

			});
</script>
</html>