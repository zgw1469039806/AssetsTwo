<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.core.spring.SpringFactory"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>三员角色管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
</head>

<body class="easyui-layout" fit="true">
		<div data-options="region:'north',split:true,title:''" style="height:300px; padding:0px;overflow:hidden;">
			<table id="dgRole"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					idField :'id',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					striped:true
					">
				<thead>
					<tr>
						<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
						<th data-options="field:'roleName', halign:'center',align:'center'" width="220">角色名称</th>
						<th data-options="field:'roleCode', halign:'center',align:'center'" width="220">角色编码</th>
						<th data-options="field:'usageModifier',halign:'center',align:'center',formatter:formatScope" width="220">应用范围</th>
						<th data-options="field:'roleDesc',halign:'center',align:'center'"  width="220">描述</th>
						<th data-options="field:'orderBy',halign:'center',align:'center'"  width="220">排序编号</th>
						<th data-options="field:'validFlag',halign:'center',align:'center',formatter: formatStatus" width="220">状态</th>
					</tr>
				</thead>
			</table>		
		</div>	
		<div data-options="region:'center',split:true,title:'',fit:'true'" style="padding:0px;height:0; overflow:hidden;">	
		
			<div id="toolbarUser" class="datagrid-toolbar">
					<a id="btAddUser"  class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sanRoleUser.showAddUser();" href="javascript:void(0);">添加用户</a>
					<a id="btDeleteUser" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="sanRoleUser.deleteUser();" href="javascript:void(0);">删除用户</a>
			</div>
			<table id="dgUser"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					toolbar:'#toolbarUser',
					idField :'id',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					pagination:true,
					pageSize:dataOptions.pageSize,
					pageList:dataOptions.pageList,
					striped:true
					">
				<thead>
					<tr>
						<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
						<th data-options="field:'no',required:true,halign:'center',align:'center'" width="220">用户编号</th>
						<th data-options="field:'name',required:true,halign:'center',align:'center'"  width="220">用户名</th>
						<th data-options="field:'loginName',halign:'center',align:'center'"  width="220">登录名</th>
						<th data-options="field:'deptCode',halign:'center',align:'center'"  width="220">部门编号</th>
						<th data-options="field:'deptName',halign:'center',align:'center'"  width="220">所属部门</th>
						<th data-options="field:'status',halign:'center',align:'center',formatter: formatUser"  width="220">状态</th>
						<th data-options="field:'remark',halign:'center',align:'center'"  width="220">描述</th>
						
					</tr>
				</thead>
			</table>	
		</div>
		<div id="searchUserDialog" data-options="iconCls:'icon-search',resizable:false,modal:false,buttons:'#searchBtns'" style="width: 450px;height:150px;display: none;">
		<form id="searchUserForm">
    		<table style="padding-top: 10px;">
    			<tr style="height:5px;">
	    			</tr>
	    			<tr>
	    				<td>用户名:</td><td><input type='text'  class="easyui-validatebox" name="filter-LIKE-NAME" id="filter-LIKE-name"/></td>
	    				<td>登录名:</td><td><input type='text'  class="easyui-validatebox" name="filter-LIKE-LOGIN_NAME" id="filter-LIKE-loginName"/></td>
	    			</tr>
	    			<tr style="height:5px;">
	    			</tr>
	    			<tr>
	    				<td>状态:</td>
	    				<td><pt6:syslookup name="filter-EQ-STATUS" id="filter-EQ-STATUS" isNull="true" lookupCode="PLATFORM_VALID_FLAG" dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel,width:170"></pt6:syslookup></td>
	    			</tr>
    		</table>
    	</form>
    	<div id="searchBtns">
    		<a class="easyui-linkbutton" plain="false" onclick="sanRoleUser.searchData();" href="javascript:void(0);">查询</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="sanRoleUser.clearData();" href="javascript:void(0);">清空</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="sanRoleUser.hideSearchForm();" href="javascript:void(0);">返回</a>
    	</div>
  </div>
<script src="avicit/platform6/modules/system/sysrole/js/SanRole.js" type="text/javascript"></script>
<script type="text/javascript">
var sanRole,sanRoleUser;
$(function(){
	sanRole= new SanRole('dgRole','${url}');
	sanRole.setOnLoadSuccess(function(){
		sanRoleUser = new SanRoleUser('dgUser','${url}','searchUserDialog','searchUserForm'); 
	});
	sanRole.setOnSelectRow(function(rowIndex, rowData,id){
		sanRoleUser.loadById(id);  
	});
	sanRole.init();
});
function formatScope(value){
	return sanRole.formatScope(value);
};
function formatStatus(value,row,index){
	if(row.roleCode ==='platform_manager'){
		return '<a style="cursor:pointer;" onclick="sanRole.stop();return false;">禁用</a>';
	}
	return sanRole.formatValid(value);
};
function formatUser(value){
	if(value=="1"){
		return '正常';
	}
	return '无效';
}
</script>
</body>

</html>