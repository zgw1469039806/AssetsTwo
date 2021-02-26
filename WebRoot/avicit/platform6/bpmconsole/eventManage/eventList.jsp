<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>事件注册管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',title:'事件注册'" style="background:#ffffff;overflow:hidden;height:0;font-size:0;">
		<div id="event_toolbar" class="datagrid-toolbar">
			<table>
				<tr>
					<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="myEventList.insertEvent();" href="javascript:void(0);">添加</a></td>
					<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="myEventList.modifyEvent();" href="javascript:void(0);">编辑</a></td>
					<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="myEventList.delEvent();" href="javascript:void(0);">删除</a></td>
				</tr>
			</table>
		</div>
		<table id="event_table" class="easyui-datagrid" data-options="
				fit: true,
				url:'bpm/bpmconsole/eventManageAction/getEventListByPage.json',
				onSelect:selectEventList,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#event_toolbar',
				idField :'dbid',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
			<thead>
				<tr>
					<th data-options="field:'dbid', halign:'center',checkbox:true" width="50"></th>
					<th data-options="field:'name', halign:'center'" width="100">事件名称</th>
					<th data-options="field:'path', halign:'center'" width="200">事件类路径</th>
					<th data-options="field:'type', align:'center'" width="60">类型</th>
					<th data-options="field:'remark',halign:'center'" width="100">描述</th>
					<th data-options="field:'orderBy',align:'center'" width="50">排序</th>
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'south',title:'参数注册'" style="background:#ffffff;overflow:hidden;width:0;height:250px;font-size:0;">
		<div id="properties_toolbar" class="datagrid-toolbar">
			<table>
				<tr>
					<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="myEventList.insertProperties();" href="javascript:void(0);">添加</a></td>
					<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="myEventList.modifyProperties();" href="javascript:void(0);">编辑</a></td>
					<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="myEventList.delProperties();" href="javascript:void(0);">删除</a></td>
				</tr>
			</table>
		</div>
		<table id="properties_table" class="easyui-datagrid" data-options="
				fit: true,
				url:'bpm/bpmconsole/eventManageAction/getPropertiesListByPage.json',
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#properties_toolbar',
				idField :'dbid',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				striped:true">
			<thead>
				<tr>
					<th data-options="field:'dbid', halign:'center',checkbox:true" width="50"></th>
					<th data-options="field:'name', halign:'center'" width="100">常量名</th>
					<th data-options="field:'initExpr', halign:'center'" width="50">常量值</th>
					<th data-options="field:'remark',halign:'center'" width="100">描述</th>
					<th data-options="field:'orderBy',align:'center'" width="50">排序</th>
				</tr>
			</thead>
		</table>
	</div>
	<script src="avicit/platform6/bpmconsole/eventManage/eventList.js" type="text/javascript"></script>
	<script type="text/javascript">
		function selectEventList(rowIndex, rowData) {
			myEventList.selectEventList(rowIndex, rowData);
		}
	</script>
</body>
</html>