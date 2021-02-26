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
<!-- ControllerPath = "train/demo/mdasearchconfig/mdaSearchconfigController/toMdaSearchconfigManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js"
	type="text/javascript"></script>
<!-- 自定义列属性-->
<script
	src="static/js/platform/component/common/userDefinedColumnTools.js"
	type="text/javascript"></script>
<script
	src="avicit/platform6/mda_easyui/mdasearchconfig/js/MdaSearchconfig.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var mdaSearchconfig;
	$(function() {
		mdaSearchconfig = new MdaSearchconfig('dgMdaSearchconfig', 'platform/mdaSearchconfigEasyUIController/operation/',
				'searchDialog', 'mdaSearchconfig');
	});
	function formatDate(value, row, index) {
		return mdaSearchconfig.format(value);
	}
	function formatDateTime(value, row, index) {
		return mdaSearchconfig.formatDateTime(value);
	}
	function formatDateForHref(value, row, index) {
		var thisDate = mdaSearchconfig.format(value);
		return '<a href="javascript:void(0);" onclick="mdaSearchconfig.detail(\''
				+ row.id + '\');">' + thisDate + '</a>';
	}
	function formatTimeForHref() {
		var thisTime = mdaSearchconfig.formatDateTime(value);
		return '<a href="javascript:void(0);" onclick="mdaSearchconfig.detail(\''
				+ row.id + '\');">' + thisTime + '</a>';
	}
	function formatHref(value, row, inde) {
		return '<a href="javascript:void(0);" onclick="mdaSearchconfig.detail(\''
				+ row.id + '\');">' + value + '</a>';
	}

	function formatstatus(value) {
		return Platform6.fn.lookup.formatLookupType(value,
				mdaSearchconfig.status);
	}

	document.ready = function() {
		document.body.style.visibility = 'visible';
	}
</script>
</head>
<body class="easyui-layout" fit="true" style="visibility: hidden;">
	<div data-options="region:'center'"
		style="background: #ffffff; height: 0px; padding: 0px; overflow: hidden;">
		<div id="toolbarMdaSearchconfig" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaSearchconfig_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="mdaSearchconfig.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaSearchconfig_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="mdaSearchconfig.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaSearchconfig_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="mdaSearchconfig.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_mdaSearchconfig_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="mdaSearchconfig.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgMdaSearchconfig"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarMdaSearchconfig',
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
						width="220">ID</th>
					<th data-options="field:'name', halign:'center'" width="220">配置名称</th>
					<th data-options="field:'numbers', halign:'center'" width="220">过滤级别</th>
					<th data-options="field:'filtercontent', halign:'center'"
						width="220">过滤内容</th>
					<th
						data-options="field:'createtime', halign:'center',formatter:formatDate"
						width="220">创建时间</th>

					<th
						data-options="field:'status', halign:'center',formatter:formatstatus"
						width="220">状态</th>

				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="width: 904px; height: 340px; display: none;">
		<form id="mdaSearchconfig">
			<table class="form_commonTable">
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">配置名称:</th>
					<td width="39%"><input class="easyui-validatebox"
						style="width: 99%;" type="text" name="name" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">过滤级别:</th>
					<td width="39%"><input class="easyui-validatebox"
						style="width: 99%;" type="text" name="numbers" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">创建时间(从):</th>
					<td width="39%"><input name="createtimeBegin"
						id="createtimeBegin" class="easyui-datebox" editable="false" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">创建时间(至):</th>
					<td width="39%"><input name="createtimeEnd" id="createtimeEnd"
						class="easyui-datebox" editable="false" /></td>
				</tr>
				<tr>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">过滤内容:</th>
					<td width="39%"><input class="easyui-validatebox"
						style="width: 99%;" type="text" name="filtercontent" /></td>
					<th width="10%"
						style="word-break: break-all; word-warp: break-word;">STATUS:</th>
					<td width="39%"><pt6:syslookup name="status" id="status"
							title="STATUS" isNull="true" lookupCode="MDA_STATUS"
							dataOptions="width:151,editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">
						</pt6:syslookup></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar foot-formopera"
			style="padding-bottom: 6px;">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn"
						iconCls="" plain="false" onclick="mdaSearchconfig.searchData();"
						href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="mdaSearchconfig.clearData();"
						href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
						iconCls="" plain="false"
						onclick="mdaSearchconfig.hideSearchForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>