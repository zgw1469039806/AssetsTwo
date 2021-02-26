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
<!-- ControllerPath = "platform6/msecure/mobileserviceinfo/MobileServiceInfoController/MobileServiceInfoInfo" -->
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
</head>
<body class="easyui-layout" fit="true" style="visibility:hidden;">
	<div data-options="region:'west'" style="background: #ffffff; width:490px">
	<div data-options="region:'center'" style="background: #ffffff; height:270px">
		<div id="toolbarMobileServiceInfo" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceInfo_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="mobileServiceInfo.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceInfo_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mobileServiceInfo.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceInfo_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mobileServiceInfo.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceInfo_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="mobileServiceInfo.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
					<!-- <td><a class="easyui-linkbutton" iconCls="icon-search"
						plain="true" onclick="selfDefQury.show();"
						href="javascript:void(0);">高级查询</a></td> -->
				</tr>
			</table>
		</div>
		<table id="dgMobileServiceInfo"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMobileServiceInfo',
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
						width="220">主键</th>
					<th data-options="field:'serviceName', halign:'center'" width="120">服务名称</th>
					<th data-options="field:'serviceBaseurl', halign:'center'"
						width="320">服务基本地址</th>
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'south'" style="background: #f5fafe;height:265px;">
		<div id="toolbarmobileServiceHeaders" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceHeaders_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true"
							onclick="mobileServiceHeaders.insert(mobileServiceInfo.getSelectID());"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceHeaders_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mobileServiceHeaders.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileServiceHeaders_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mobileServiceHeaders.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id='dgmobileServiceHeaders' class="easyui-datagrid"
			data-options="
    		fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField :'id',
			toolbar:'#toolbarmobileServiceHeaders',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			method:'get',
			pagination:false,
            pageSize:dataOptions.pageSize,
            pageList:dataOptions.pageList,
			striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">主键</th>
					<th data-options="field:'serviceId', halign:'center', hidden:true" width="220">服务id外键</th>
					<th data-options="field:'headerName', halign:'center'" width="220">header键</th>
					<th data-options="field:'headerValue', halign:'center'" width="220">header值</th>
				</tr>
			</thead>
		</table>
	</div>
	</div>
	<!-- /////// -->
	 <div data-options="region:'center'"		style="background: #f5fafe;">
		<div class="easyui-layout" data-options="fit:true"> 
		<div data-options="region:'north'"		style="height:270px; background: #f5fafe;">
		<div id="toolbarmobileCommandInfo" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileCommandInfo_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true"
							onclick="mobileCommandInfo.insert(mobileServiceInfo.getSelectID());"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileCommandInfo_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mobileCommandInfo.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileCommandInfo_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mobileCommandInfo.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id='dgmobileCommandInfo' class="easyui-datagrid"
			data-options="
    		fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField :'id',
			toolbar:'#toolbarmobileCommandInfo',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			method:'get',
			pagination:false,
            pageSize:dataOptions.pageSize,
            pageList:dataOptions.pageList,
			striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', align:'center',checkbox:true" width="220">主键</th>
					<th data-options="field:'serviceId', hidden:true" width="220">服务id外键</th>
					<th data-options="field:'methodName', align:'left'" width="120">方法名称</th>
					<th data-options="field:'methodShowName', align:'left'" width="120">备注</th>
					<th data-options="field:'methodType', align:'center'" width="80">方法类型</th>
					<th data-options="field:'methodUrl', align:'left'" width="220">方法URL地址</th>
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'center'"style="width:200px;height:200px;background: #f5fafe;">
		<div id="toolbarmobileCommandHeaders" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileCommandHeaders_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true"
							onclick="mobileCommandHeaders.insert(mobileCommandInfo.getSelectID());"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileCommandHeaders_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mobileCommandHeaders.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileCommandHeaders_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mobileCommandHeaders.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id='dgmobileCommandHeaders' class="easyui-datagrid"
			data-options="
    		fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField :'id',
			toolbar:'#toolbarmobileCommandHeaders',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			method:'get',
			pagination:false,
            pageSize:dataOptions.pageSize,
            pageList:dataOptions.pageList,
			striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">主键</th>
					<th data-options="field:'commandId', halign:'center', hidden:true" width="220">方法id外键</th>
					<th data-options="field:'headerName', halign:'center'" width="220">header键</th>
					<th data-options="field:'headerValue', halign:'center'" width="220">header值</th>
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'east'" style="width:450px;background: #f5fafe;">
		<div id="toolbarmobileCommandExtend" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileCommandExtend_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true"
							onclick="mobileCommandExtend.insert(mobileCommandInfo.getSelectID());"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileCommandExtend_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mobileCommandExtend.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mobileCommandExtend_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mobileCommandExtend.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id='dgmobileCommandExtend' class="easyui-datagrid"
			data-options="
    		fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField :'id',
			toolbar:'#toolbarmobileCommandExtend',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			method:'get',
			pagination:false,
            pageSize:dataOptions.pageSize,
            pageList:dataOptions.pageList,
			striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">主键</th>
					<th data-options="field:'commandId', halign:'center', hidden:true" width="220">方法id外键</th>
					<th data-options="field:'className', halign:'center'" width="220">类名</th>
				</tr>
			</thead>
		</table>
	</div> 
	</div> 
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="width: 904px; height: 340px; display: none;">
		<form id="mobileServiceInfo">
			<table class="form_commonTable">
				<tr>
					<th width="10%">服务名称:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="serviceName" /></td>
					<th width="10%">服务基本地址:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="serviceBaseurl" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn"
						iconCls="" plain="false" onclick="mobileServiceInfo.searchData();"
						href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mobileServiceInfo.clearData();"
						href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
						iconCls="" plain="false"
						onclick="mobileServiceInfo.hideSearchForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script
		src=" avicit/platform6/mobile/msecure/mobileserviceinfo/js/MobileServiceInfo.js"
		type="text/javascript"></script>
	<script
		src=" avicit/platform6/mobile/msecure/mobileserviceinfo/js/MobileServiceHeaders.js"
		type="text/javascript"></script>
	<script
		src=" avicit/platform6/mobile/msecure/mobileserviceinfo/js/MobileCommandInfo.js"
		type="text/javascript"></script>
	<script
		src=" avicit/platform6/mobile/msecure/mobileserviceinfo/js/MobileCommandHeaders.js"
		type="text/javascript"></script>
	 <script
		src=" avicit/platform6/mobile/msecure/mobileserviceinfo/js/MobileCommandExtend.js"
		type="text/javascript"></script> 
	<script type="text/javascript">
		var mobileServiceInfo;
		var mobileServiceHeaders;
		var mobileCommandInfo;
		var mobileCommandHeaders;
		var mobileCommandExtend;
		document.ready = function () {
			document.body.style.visibility = 'visible';
				}
		
		$(function() {
			mobileServiceInfo = new MobileServiceInfo('dgMobileServiceInfo',
					'${url}', 'searchDialog', 'mobileServiceInfo');
			mobileCommandInfo = new MobileCommandInfo(
					'dgmobileCommandInfo', '${s2url}');
			mobileServiceInfo.setOnLoadSuccess(function() {
				mobileServiceHeaders = new MobileServiceHeaders(
						'dgmobileServiceHeaders', '${surl}');
			//	mobileCommandInfo = new MobileCommandInfo(
			//			'dgmobileCommandInfo', '${s2url}');
			});
			mobileCommandInfo.setOnLoadSuccess(function(){
			mobileCommandHeaders = new MobileCommandHeaders(
					'dgmobileCommandHeaders', '${ssurl}'); 
			mobileCommandExtend = new MobileCommandExtend(
			'dgmobileCommandExtend', '${ss2url}');  
			});
			mobileServiceInfo.setOnSelectRow(function(rowIndex, rowData, id) {
				mobileServiceHeaders.loadByPid(id);
				mobileCommandInfo.loadByPid(id);
			});
		 	mobileCommandInfo.setOnSelectRow(function(rowIndex, rowData, id) {
				mobileCommandHeaders.loadByPid(id);
				mobileCommandExtend.loadByPid(id);
			});  
			mobileServiceInfo.init();
			mobileCommandInfo.init();

			var array = [];

			var searchObject = {
				name : '服务名称',
				field : 'SERVICE_NAME',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);

			var searchObject = {
				name : '服务基本地址',
				field : 'SERVICE_BASEURL',
				type : 1,
				dataType : 'VARCHAR'
			};
			array.push(searchObject);
			///

			selfDefQury.init(array);
			selfDefQury.setQuery(function(param) {
				mobileServiceInfo.searchDataBySfn(param);
				mobileCommandInfo.searchDataBySfn(param);
			});

		});
		function formateDate(value, row, index) {
			return mobileServiceInfo.formate(value);
		}
		function formateDateTime(value, row, index) {
			return mobileServiceInfo.formateTime(value);
		}
		//mobileServiceInfo.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="mobileServiceInfo.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
	</script>
</body>
</html>