<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="avicit.platform6.core.spring.SpringFactory"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<html>
<head>
<%
	long timestamp = System.currentTimeMillis();
	String language =SessionHelper.getCurrentUserLanguageCode(request);
	String appId = SessionHelper.getApplicationId();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>群组添加用户</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<script type="text/javascript">


var path="<%=ViewUtil.getRequestPath(request)%>";
var comboData={};


$(document).ready(function(){ 
	initComboData();
	
	$('#searchUser').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			loadInfo();
		}
	});
		
		$('#dgUser').datagrid('doCellTip',   
		{   
			onlyShowInterrupt:true,   
			position:'bottom',
			tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
		}); 
		

});

/**
 * 
**/
function initComboData(){
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/PLATFORM_VALID_FLAG',
		type :'get',
		async:false,
		dataType :'json',
		success : function(r){
			if(r){
				comboData =r;
			}
		}
	});
}

function loadInfo(){	
	$("#dgUser").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	$("#dgUser").datagrid('load',{ param : JSON.stringify(serializeObject($("#searchUserForm")))});
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

function clearUser(){
	$("#searchUserForm").find('input').val('');
	$("#dgUser").datagrid('reload',{});
};

function searchUser()
{
	loadInfo();
}

function formatModifier(value){
	if (value == "1"){
		return "私有使用";
	}else{
		return "公共使用";
	}
}



</script>
</head>

<body class="easyui-layout" fit="true">
		
	<div data-options="region:'north',split:false,title:''" style="height: 60px; padding:0px;">	
	
			<div style="TEXT-ALIGN: center; ">
				<form id="searchUserForm">
		    		<table style=" MARGIN-RIGHT: auto; MARGIN-LEFT: auto;">
		    			<tr>
		    				
		    				<td>系统代码类型:</td><td><input type='text' name="filter-LIKE-LOOKUP_TYPE" id="filter_LIKE_loginName" style="width:100px"/></td>
		    				<td>系统代码类型名称:</td><td><input type='text' name="filter-LIKE-LOOKUP_TYPE_NAME" id="filter_LIKE_name" style="width:100px"/></td>
		    				<td>有效标识:</td><td><input id="filter-EQ-VALID_FLAG" class="easyui-combobox" name="filter-EQ-VALID_FLAG" style="width:100px" 
	    						 data-options="panelHeight:'auto', editable:false,valueField:'lookupCode',textField:'lookupName', data: [{lookupCode:'1', lookupName: '有效'},{lookupCode:'0', lookupName: '无效'}]" /> </td>
		
		    			</tr>
		    			<tr>
			    			<td style="TEXT-ALIGN: center; " colspan="6">
							    <div style="TEXT-ALIGN: center; ">
							    
							    	<div  id="searchBtns" style=" MARGIN-RIGHT: auto; MARGIN-LEFT: auto;">
							    		<a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchUser();" href="javascript:void(0);">查询</a>
							    		<a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="clearUser();" href="javascript:void(0);">清空</a>
							    		
							    	</div>
			    				</div>
		    				</td>
		    			</tr>
		    			
		    		</table>
		    	</form>
		    </div>	
		    
	</div>
	
	<div data-options="region:'center',split:false,title:''" style="height:0; overflow:hidden; font-size:0;">				
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
				
				striped:true,
				url: 'platform/eform/tabledefine/<%=timestamp%>/<%=appId%>/<%=language%>/allSysLookupType.json'	
				">
			<thead>
				<tr> 
		        	<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
		        	<th data-options="field:'sid', halign:'center',hidden:true" width="220">sid</th>
		        	
		        	<th data-options="field:'lookupType',align:'center'" editor="{type:'text'}" width="220">系统代码类型</th>
		        	<th data-options="field:'lookupTypeName',align:'center'" editor="{type:'text'}" width="320">系统代码类型名称</th>
		        	<th data-options="field:'usageModifier',align:'center',align:'center',formatter:formatModifier"  width="120">使用级别</th>
					<th data-options="field:'validFlag',align:'center',formatter:formatcombobox" 
						editor="{type:'combobox',options:{panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName',onHidePanel:function(){sysLookup.endEditing();}}}" width="220">有效标识</th>
					<th data-options="field:'description',align:'center'" editor="{type:'text'}" width="220">描述</th>
		        </tr>
			</thead>
		</table>	
	</div>
		
		
	

</body>
</html>