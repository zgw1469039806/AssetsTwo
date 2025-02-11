<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>批量换岗</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<script type="text/javascript">


var path="<%=ViewUtil.getRequestPath(request)%>";
var comboData={};
var userTypeComboData={};


$(document).ready(function(){ 
	initComboData();
	
	$('#searchUser').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchUser();
		}
	});
	loadUserInfo(null, null, null, "1");
});

/**
 * 
**/
function initComboData(){
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/PLATFORM_USER_STATUS',
		type :'get',
		dataType :'json',
		success : function(r){
			if(r){
				comboData =	r;
				$('#filter_EQ_status').combobox('loadData', [{lookupCode:'', lookupName: '所有'}].concat(comboData));
			}
		}
	});
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/PLATFORM_USER_TYPE',
		type :'get',
		dataType :'json',
		success : function(r){
			if(r){
				userTypeComboData =r;
			}
		}
	});
}

function loadUserInfo(name, loginName, no, validFlag)
{
	$("#dgUser").datagrid("options").url ="platform/sysposition/sysPositionController/getUserListByPage/${positionId}";
	$('#dgUser').datagrid("reload", {"filter-LIKE-NAME": name, "filter-LIKE-LOGIN_NAME":loginName, "filter-LIKE-NO":no, "filter-LIKE-STATUS": validFlag} );
	$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');	
}

function formatcombobox(value){
	if(value ==null ||value == ''){
		return '';
	}
	for(var i =0 ,length = comboData.length; i<length;i++){
		if(comboData[i].lookupCode == value){
			return comboData[i].lookupName;
		}
	}
}

function formatUserTypeCombobox(value){
	if(value ==null ||value == ''){
		return '';
	}
	for(var i =0 ,length = userTypeComboData.length; i<length;i++){
		if(userTypeComboData[i].lookupCode == value){
			return userTypeComboData[i].lookupName;
		}
	}
}

function clearUser()
{
	$('#filter_LIKE_name').val('');
	$('#filter_LIKE_loginName').val('');
	$('#filter_LIKE_no').val('');
	$('#filter_EQ_status').combobox('select', '1');
}

function searchUser()
{
	var name=$('#filter_LIKE_name').val();
	var loginName=$('#filter_LIKE_loginName').val();
	var no=$('#filter_LIKE_no').val();	
	var validFlag= $('#filter_EQ_status').combobox('getValue');
	loadUserInfo(name, loginName, no, validFlag);
}



</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'north',split:false,collapsible:false,title:'查询'" style="height: 100px; padding:0px;overflow: hidden;">	
				<form id="searchUserForm">
		    		<table style=" MARGIN-RIGHT: auto; MARGIN-LEFT: auto;">
		    			<tr>
		    				<td>用户名:</td><td><input type='text' name="filter_LIKE_name" id="filter_LIKE_name" style="width:100px"/></td>
		    				<td>登录名:</td><td><input type='text' name="filter_LIKE_loginName" id="filter_LIKE_loginName" style="width:100px"/></td>
		    				<td>用户编号:</td><td><input type='text' name="filter_LIKE_no" id="filter_LIKE_no" style="width:100px"/></td>
		    				<td>是否有效:</td><td><input id="filter_EQ_status" class="easyui-combobox" name="filter_EQ_status" style="width:100px" value="1"
	    						 data-options="panelHeight:'auto', editable:false,valueField:'lookupCode',textField:'lookupName', data: [{lookupCode:'1', lookupName: 'aaa'}]" /> </td>
		    			</tr>
		    		</table>
		    		 <div style="TEXT-ALIGN: center;">
				    	<div  id="searchBtns" style=" margin-right: auto; margin-left: auto;margin-bottom: 5px;">
				    		<a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchUser();" href="javascript:void(0);">查询</a>
				    		<a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="clearUser();" href="javascript:void(0);">清空</a>
				    		
				    	</div>
			    	</div>
		    	</form>
	</div>
	
	<div data-options="region:'center',split:false,title:''" style="padding:0px;">				
		<table id="dgUser" class="easyui-datagrid"
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
				singleSelect: false,
				checkOnSelect: false,
				selectOnCheck: true,
				
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true	
				">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
					
					<th data-options="field:'name',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">用户名</th>
					<th data-options="field:'nameEn',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">英文名</th>
					<th data-options="field:'deptName',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">所属部门</th>
					<th data-options="field:'no',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">用户编号</th>
					<th data-options="field:'loginName',halign:'center',align:'left'" editor="{type:'text'}"  width="220">登录名</th>
					<th data-options="field:'type',halign:'center',align:'left', formatter:formatUserTypeCombobox" editor="{type:'combobox', options:{required:true,panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName'}}"  width="220">类型</th>
					<th data-options="field:'status',halign:'center',align:'left', formatter:formatcombobox" editor="{type:'combobox', options:{required:true,panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName'}}"  width="220">状态</th>
					<th data-options="field:'remark',halign:'center',align:'left'" editor="{type:'text'}"  width="220">描述</th>
					
				</tr>
			</thead>
		</table>	
	</div>
		
		
	

</body>
</html>