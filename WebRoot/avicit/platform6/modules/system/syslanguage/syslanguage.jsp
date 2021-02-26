<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>多语言管理</title>
	<base href="<%=ViewUtil.getRequestPath(request) %>">
	<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
	<script src="avicit/platform6/modules/system/syslanguage/js/syslanguage.js" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8">
		$(function() {
			sysLanguage.inite('languageDataGrid','');
		});
	</script>
</head>
<body class="easyui-layout" fit="true">
  <div data-options="region:'center',split:true,border:false">
	<div id="toolbar" >
		<table class="toolbarTable">
			<tr>
				<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sysLanguage.addRow();" href="javascript:void(0);">添加</a></td>
				<td><a class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="sysLanguage.save();" href="javascript:void(0);">保存</a></td>
				<td><a class="easyui-linkbutton" iconCls="icon-no" plain="true" onclick="sysLanguage.del();" href="javascript:void(0);">删除</a></td>
			</tr>
		</table>
	</div> 
	
	<table id="languageDataGrid" class="easyui-datagrid"
		data-options=" 
			fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			toolbar:'#toolbar',
			idField :'id',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			striped:true
			">
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>				
				<th data-options="field:'languageName',halign:'center',align:'left'" editor="{type:'combobox',options:{required:true,editable:false,valueField:'v',textField:'v'}}" width="220">语言名称</th>
				<th data-options="field:'languageCode', halign:'center',align:'left'" editor="{type:'validatebox',options:{required:true}}" width="220">语言代码</th>
				<th data-options="field:'isSystemDefault',halign:'center',align:'center',formatter: sysLanguage.format" width="220">系统默认语言</th>
			</tr>
		</thead>
	</table>
 </div>
</body>
</html>