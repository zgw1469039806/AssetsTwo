<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobileapp/MobileAppController/MobileAppInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
<!-- <div data-options="region:'north',split:true,title:''" style="height:300px; padding:0px;overflow:hidden;"> -->
<div class="easyui-layout" data-options="fit:true"> 
	<div data-options="region:'center'" style="background:#ffffff;height:0;">
		<div id="toolbarMobileApp" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileApp_button_add" permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="mobileApp.insert();" href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileApp_button_edit" permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="mobileApp.modify();" href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileApp_button_delete" permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="mobileApp.del();" href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileApp_button_query" permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="mobileApp.openSearchForm();" href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgMobileApp" data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMobileApp',
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true" width="220">Id</th>
					<th data-options="field:'appName', halign:'center'" width="220">应用名称</th>
					<th data-options="field:'appStatus', halign:'center',formatter:statuschange" width="220">应用状态</th>
					<th data-options="field:'appBindChose', halign:'center',formatter:chosechange" width="220">是否需要绑定</th>
					<th data-options="field:'descript', halign:'center'" width="220">应用描述</th>
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'east'" style="width:650px;background:#f5fafe;">
		<div id="toolbarmobileAppVersion" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileAppVersion_button_add" permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="mobileAppVersion.insert(mobileApp.getSelectID());" href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileAppVersion_button_edit" permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="mobileAppVersion.modify();" href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mobileAppVersion_button_delete" permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="mobileAppVersion.del();" href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<td><small style="color:red; padding:5px;">提示：ios和android都只能有且只能有一个最新版</small></td>
				</tr>
			</table>
		</div>
		<table id='dgmobileAppVersion' class="easyui-datagrid" data-options="
    		fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField :'id',
			toolbar:'#toolbarmobileAppVersion',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			method:'get',
			striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true" width="220">Id</th>
					<th data-options="field:'platformType', halign:'center'" width="220">APP版本类型</th>
					<th data-options="field:'appVersion', halign:'center'" width="220">应用版本号</th>
					<th data-options="field:'appStatus', halign:'center',formatter:versionstatuschange" width="220">版本状态</th>
					<!-- <th data-options="field:'appId', halign:'center'" width="220">应用ID，MOBILE_APP外键</th> -->
					<!-- <th data-options="field:'downloadUrl', halign:'center'" width="220">应用下载地址</th> -->
					<!-- <th data-options="field:'descript', halign:'center'" width="220">应用描述</th> -->
				</tr>
			</thead>
		</table>
	</div>
	</div>
<!-- 	</div> -->
	<%-- <div data-options="region:'center',split:true,title:''" style="padding:0px;height:0; overflow:hidden;">	
		<div id="toolbarMobileUpdateSmart" class="datagrid-toolbar">
	<table>
		<tr>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_mobileUpdateSmart_button_add"
				permissionDes="添加">
				<td><a class="easyui-linkbutton" iconCls="icon-add"
					plain="true" onclick="mobileUpdateSmart.insert();"
					href="javascript:void(0);">添加</a></td>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_mobileUpdateSmart_button_edit"
				permissionDes="编辑">
				<td><a class="easyui-linkbutton" iconCls="icon-edit"
					plain="true" onclick="mobileUpdateSmart.modify();"
					href="javascript:void(0);">编辑</a></td>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_mobileUpdateSmart_button_delete"
				permissionDes="删除">
				<td><a class="easyui-linkbutton" iconCls="icon-remove"
					plain="true" onclick="mobileUpdateSmart.del();"
					href="javascript:void(0);">删除</a></td>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_mobileUpdateSmart_button_query"
				permissionDes="查询">
				<td><a class="easyui-linkbutton" iconCls="icon-search"
					plain="true" onclick="mobileUpdateSmart.openSearchForm();"
					href="javascript:void(0);">查询</a></td>
			</sec:accesscontrollist>
		</tr>
	</table>
</div>
<table id="dgMobileUpdateSmart"
	data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMobileUpdateSmart',
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				striped:true">
	<thead>
		<tr>
			<th data-options="field:'id', halign:'center',checkbox:true"
				width="220">ID</th>
			<th data-options="field:'smartVersion', halign:'center'" width="220">更新版本</th>
			<th data-options="field:'publicStatus', halign:'center',formatter:setPublic" width="220">发布状态</th>
			<th data-options="field:'descript', halign:'center'" width="220">备注</th>
		</tr>
	</thead>
</table>
	</div> --%>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" style="width: 904px;height:340px;display:none;">
		<form id="mobileApp">
			<table class="form_commonTable">
				<tr>
					<th width="10%">应用名称:</th>
					<td width="40%"><input class="easyui-validatebox" style="width: 151px;" type="text" name="appName" /></td>
					<th width="10%">应用状态:</th>
					<td width="40%"><select class="easyui-combobox" name="appStatus" id="appStatus" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="1">正常</option>
							<option value="0">禁用</option>
					</select>
				</tr>
				<tr>
					<th width="10%">应用描述:</th>
					<td width="40%"><input class="easyui-validatebox" style="width: 151px;" type="text" name="descript" /></td>
					<th width="10%">应用是否需要绑定：</th>
					<td width="40%"><select class="easyui-combobox" name="appBindChose" id="appBindChose" data-options="panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
							<option value="1">需要</option>
							<option value="0">不需要</option>
					</select>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn" iconCls="" plain="false" onclick="mobileApp.searchData();" href="javascript:void(0);">查询</a> <a class="easyui-linkbutton" iconCls="" plain="false" onclick="mobileApp.clearData();" href="javascript:void(0);">清空</a> <a class="easyui-linkbutton" iconCls="" plain="false" onclick="mobileApp.hideSearchForm();" href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script src=" avicit/platform6/mobile/msecure/mobileapp/js/MobileApp.js" type="text/javascript"></script>
	<script src=" avicit/platform6/mobile/msecure/mobileapp/js/MobileAppVersion.js" type="text/javascript"></script>
	<script src=" avicit/platform6/mobile/msecure/mobileapp/js/MobileUpdateSmart.js" type="text/javascript"></script>
	<script type="text/javascript">
		var mobileApp;
		var mobileAppVersion;
		$(function() {
			mobileApp = new MobileApp('dgMobileApp', '${url}', 'searchDialog', 'mobileApp');

			mobileApp.setOnLoadSuccess(function() {
				mobileAppVersion = new MobileAppVersion('dgmobileAppVersion', '${surl}');
				mobileAppVersion.setOnLoadSuccess(function(){
					mobileUpdateSmart = new MobileUpdateSmart('dgMobileUpdateSmart',
							'${updateurl}', 'searchDialog', 'mobileUpdateSmart');
				});
				mobileAppVersion.setOnSelectRow(function(rowIndex, rowData, id){
					$("#dgMobileUpdateSmart").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
					mobileUpdateSmart.loadByPid(id);
				})
			});
			mobileApp.setOnSelectRow(function(rowIndex, rowData, id) {
				$("#dgmobileAppVersion").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
				mobileAppVersion.loadByPid(id);
			});

			mobileApp.init();

			var array = [];

			var searchObject = {
				name : '应用名称',
				field : 'APP_NAME',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '应用状态：',
				field : 'APP_STATUS',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '应用描述',
				field : 'DESCRIPT',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '应用是否需要绑定：',
				field : 'APP_BIND_CHOSE',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);
			///

			selfDefQury.init(array);
			selfDefQury.setQuery(function(param) {
				mobileApp.searchDataBySfn(param);
			});

		});
		function formateDate(value, row, index) {
			return mobileApp.formate(value);
		}
		function formateDateTime(value, row, index) {
			return mobileApp.formateTime(value);
		}
		//mobileApp.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="mobileApp.detail(\'' + row.id + '\');">' + value + '</a>';
		}

		function statuschange(value, row, index) {
			if (value == '1') {
				return '正常';
			} else {
				return '禁用';
			}
		}

		function chosechange(value, row, index) {
			if (value == '1') {
				return '需要';
			} else {
				return '不需要';
			}
		}
		
		function setPublic(value, row, index) {
			if (value == '1') {
				return '已发布';
			} else {
				return '未发布';
			}
		}
		
		function versionstatuschange(value, row, index) {
			if (value == '1') {
				return '旧版';
			} else if (value == '2') {
				return '最新版';
			} else{
				return '禁用';
			}
		}
		
		var mobileUpdateSmart;
		$(function() {
			mobileUpdateSmart = new MobileUpdateSmart('dgMobileUpdateSmart',
					'${updateurl}', 'searchDialog', 'mobileUpdateSmart');
		});
		function formateDate(value, row, index) {
			return mobileUpdateSmart.formate(value);
		}
		function formateDateTime(value, row, index) {
			return mobileUpdateSmart.formateTime(value);
		}
		//mobileUpdateSmart.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="mobileUpdateSmart.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
	</script>
</body>
</html>