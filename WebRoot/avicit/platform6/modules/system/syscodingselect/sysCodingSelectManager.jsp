<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自编代码规则管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
/**
 * 初始化数据
 */
$(function(){
	/*初始化查询框*/
	var searchForm = $('#formSearch').form();
	searchForm.find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchCoding();
		}
	});
});

/**
 * 查询数据
 */
function searchCoding(){
	var r = $('#formSearch').form('validate');
	if(!r){
		return false;
	}
	var param = {
		searchCodingName : $('#searchCodingName').val(),
		searchCodingValue : $('#searchCodingValue').val(),
		searchModuleName: $('#searchModuleName').val()
	}; 
	$('#datagrid1').datagrid('reload', param);
}

/**
 * 清空查询的数据
 */
function clearSearch(){
	$('#formSearch').find('input').val('');
}

/**
 * 导出查询的数据
 */
 function ExporterExcel() { 
	document.getElementById("formSearch").submit();
 }
</script>
</head>
<body class="easyui-layout">
<iframe name="loadFileIframe" style="display: none"></iframe>
<div region="center" border="false">
	<table id="datagrid1" class="easyui-datagrid" 
			data-options="
				fit: true,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbar',
				method: 'post',
				url:'platform/sysCodingSelectController/getUsedCodingData.json',
				singleSelect: false,
				checkOnSelect: true,
				selectOnCheck: true,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList
			">
		<thead>
			<tr>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_gridform_codingName">
					<th data-options="field:'codingName', halign:'center'" width="120">规则名称</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_gridform_segmentNumber">
					<th data-options="field:'codingValue', halign:'center', align:'left'" width="100">编码值</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_gridform_criterionCode">
					<th data-options="field:'moduleName', halign:'center', align:'left'" width="100">使用对象</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_gridform_creationDate">
					<th data-options="field:'creationDate', halign:'center', align:'center', formatter: formatColumnTime" width="100">创建时间</th>
				</sec:accesscontrollist>
			</tr>
		</thead>
	</table>
	<div id="toolbar" class="datagrid-toolbar" style="height:auto;">
		<form id="formSearch" method="post" style="margin: 0" target="loadFileIframe" action="<%=request.getContextPath() %>/sysCodingSelectController/exportExcel4CodingSelectData.do">
			<span style="word-wrap: break-word;margin-left: 15px;">
				<span>规则名称</span>
				<input class="easyui-validatebox" id="searchCodingName" name="searchCodingName" data-options="validType:'length[0,100]'" value=""/>
			</span>
			<span style="word-wrap: break-word;margin-left: 15px;">
				<span>编码值</span>
				<input class="easyui-validatebox" id="searchCodingValue" name="searchCodingValue" data-options="validType:'length[0,100]'" value=""/>
			</span>
			<span style="word-wrap: break-word;margin-left: 15px;">
				<span>使用对象</span>
				<input class="easyui-validatebox" id="searchModuleName" name="searchModuleName" data-options="validType:'length[0,100]'" value=""/>
			</span>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_button_searchRule" >
				<a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchCoding();" href="javascript:void(0);">查询</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_button_clear" >
				<a class="easyui-linkbutton" iconCls="icon-trash" plain="true" onclick="clearSearch();" href="javascript:void(0);">清空</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_button_exportExcel" >
				<a class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="ExporterExcel();" href="javascript:void(0);">导出</a> 
			</sec:accesscontrollist>
		</form>
	</div>
</div>
</body>
</html>
