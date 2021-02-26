<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "platform6/msecure/mobiledevice/MobileDeviceController/MobileDeviceInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js"
	type="text/javascript"></script>
	<script src=" avicit/platform6/mobile/msecure/mobiledevice/js/MobileDevice.js"
		type="text/javascript"></script>
	<script
		src=" avicit/platform6/mobile/msecure/mobiledevice/js/MobileUseDeviceBind.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var mobileDevice;
		var mobileUseDeviceBind;
		$(function() {
			mobileDevice = new MobileDevice('dgMobileDevice', '${url}',
					'searchDialog', 'mobileDevice');

			mobileDevice.setOnLoadSuccess(function() {
				mobileUseDeviceBind = new MobileUseDeviceBind(
						'dgmobileUseDeviceBind', '${surl}');
			});
			mobileDevice.setOnSelectRow(function(rowIndex, rowData, id) {
				mobileUseDeviceBind.loadByPid(id);
			});

			mobileDevice.init();

			var array = [];

			var searchObject = {
				name : '设备IMEI',
				field : 'IMEI',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '设备IMSI',
				field : 'IMSI',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '屏幕分辨率',
				field : 'SCREEN',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '设备名称',
				field : 'DEVICE_NAME',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '设备平台：ios或者android',
				field : 'PLATFORM',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '平台版本',
				field : 'PLATFORM_VERSION',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '设备状态：',
				field : 'DEVICE_STATUS',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);
			///

			selfDefQury.init(array);
			selfDefQury.setQuery(function(param) {
				mobileDevice.searchDataBySfn(param);
			});

		});
		function formateDate(value, row, index) {
			return mobileDevice.formate(value);
		}
		function formateDateTime(value, row, index) {
			return mobileDevice.formateTime(value);
		}
		//mobileDevice.detail(\''+row.id+'\')
		function formateHref(value, row, index) {
			return '<a href="javascript:void(0);" onclick="mobileDevice.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
		function statusAlias(value, row, index)
		{
			if(value=="1"){
				return "正常";
			}
			else return "禁止";
		}
		
		function bindStatusAlias(value, row, index)
		{
			if(value=="1"){
				return "正常";
			}
			else return "禁止";
		}
	</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'"
		style="background:#ffffff;height:0px;padding:0px;overflow:hidden;">
		<div id="toolbarMobileDevice" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileDevice_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="mobileDevice.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileDevice_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mobileDevice.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileDevice_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mobileDevice.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileDevice_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="mobileDevice.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				<!-- 	<td><a class="easyui-linkbutton" iconCls="icon-search"
						plain="true" onclick="selfDefQury.show();"
						href="javascript:void(0);">高级查询</a></td> -->
				</tr>
			</table>
		</div>
		<table id="dgMobileDevice"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMobileDevice',
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
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">Id</th>
					<th data-options="field:'imei', halign:'center'" width="220">设备IMEI</th>
					<th data-options="field:'imsi', halign:'center'" width="220">设备IMSI</th>
					<th data-options="field:'screen', halign:'center'" width="220">屏幕分辨率</th>
					<th data-options="field:'deviceName', halign:'center'" width="220">设备名称</th>
					<th data-options="field:'platform', halign:'center'" width="220" >设备平台</th>
					<th data-options="field:'platformVersion', halign:'center'"
						width="220">平台版本</th>
					<th data-options="field:'deviceStatus', halign:'center',formatter:statusAlias"
						width="220">设备状态</th>
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'east'"
		style="width:380px;background:#f5fafe;height:0px; overflow:hidden; font-size:0;">
		<div id="toolbarmobileUseDeviceBind" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileUseDeviceBind_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true"
							onclick="mobileUseDeviceBind.insert(mobileDevice.getSelectID());"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileUseDeviceBind_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mobileUseDeviceBind.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileUseDeviceBind_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mobileUseDeviceBind.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id='dgmobileUseDeviceBind' class="easyui-datagrid"
			data-options="
    		fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField :'id',
			toolbar:'#toolbarmobileUseDeviceBind',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			method:'get',
			striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">Id</th>
					<th data-options="field:'userId',align:'center'" width="220">登陆名</th>
					<th data-options="field:'appName',align:'center'" width="220">应用名称</th>
					<th data-options="field:'bindStatus',align:'center',formatter:bindStatusAlias" width="220">状态</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="width: 904px; height: 340px; display: none;">
		<form id="mobileDevice">
			<table class="form_commonTable">
				<tr>
					<th width="10%">设备IMEI:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="imei" /></td>
					<th width="10%">设备IMSI:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="imsi" /></td>
				</tr>
				<tr>
					<th width="10%">屏幕分辨率:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="screen" /></td>
					<th width="10%">设备名称:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="deviceName" /></td>
				</tr>
				<tr>
					<th width="10%">设备平台:</th>
					<td width="40%">
					<select name="platform" id="platform"
						class="easyui-combobox"
						data-options="width:151,editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						<option>ios</option>
						<option>android</option>
						</select>
				</td>
					<th width="10%">平台版本:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="platformVersion" /></td>
				</tr>
				<tr>
					<th width="10%">设备状态:</th>
					<td width="40%">
					<select name="deviceStatus" id="deviceStatus"
						class="easyui-combobox"
						data-options="width:151,editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						<option value="0">禁止</option>
						<option value="1">正常</option>
						</select>
				</tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn"
						iconCls="" plain="false" onclick="mobileDevice.searchData();"
						href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mobileDevice.clearData();"
						href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mobileDevice.hideSearchForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>