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
	String appId = SessionHelper.getApplicationId();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>模板选择</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
</head>

<body class="easyui-layout" fit="true">
<input id="tableId"  value="${tableId}"   type="hidden" >
<div data-options="region:'center',split:false,title:''" style="height:0; overflow:hidden; font-size:0;">
<div id="toolbarTree" class="datagrid-toolbar">
	 	<table width="100%">
	 		<tr>
	 			
	 			<td><input type="text"  name="searchTempletTree" id="searchTempletTree" ></input></td>
	 		</tr>
	 	</table>
 </div>
<table id="tt" class="easyui-treegrid" style="height:0"   
        data-options="
        	url:'platform/cbbTemplet/<%=appId%>/ROOT/-1/${tableId}/getTempletTreegrid.json',
        	idField:'id',
        	treeField:'text',
        	singleSelect: true,
        	checkOnSelect: true,
			selectOnCheck: false,
			fit: true,
			panel:true,
			border: false,
			rownumbers: true,
			toolbar:'#toolbarTree',
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
        	loadFilter: function(data){
		         if (data.treeGridNodeList){	
		              return data.treeGridNodeList;
		          } else {
		              return data;
		          }
  			},
  			onBeforeExpand:function(node,param){
				 if(node){
					 $('#tt').treegrid('options').url = 'platform/cbbTemplet/<%=appId%>/'+node.id+'/1/getTempletTree.json'
				 }
		 	}
       		">   
    	<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true"		width="220">id</th>
				<th data-options="field:'text',required:true,halign:'center',align:'left'"	editor="{type:'text'}" width="220">模板名称</th>
				<th	data-options="field:'code',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">模板编号</th>
				<th data-options="field:'type',halign:'center',align:'left',formatter:formatcombobox" width="220">模板类型</th>
			</tr>
		</thead>   
</table>
</div>
<div data-options="region:'south',split:false,title:''" style="height:35px; padding:0px;">
<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend"> 
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td width="50%" align="right">
						<a id='saveButton' href="javascript:void(0)" class="easyui-linkbutton primary-btn"  onclick="saveUser()" >保存</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="parent.dlg_close_only('newtemplet')" >返回</a>
					</td>
				</tr>
			</table>
</div>
</div>


<script type="text/javascript">

$(document).ready(function(){ 
	if('${isCreated}' == 'Y'){
		$("#saveButton").hide();
	}
	$("#searchTempletTree").searchbox({
	 	width: 150,
        searcher: function (value) {
        	if(value==null||value==""){
        		$("#tt").treegrid({
        			url:"platform/cbbTemplet/<%=appId%>/ROOT/-1/${tableId}/getTempletTreegrid.json"
        		});
        		$("#tt").treegrid('reload');

        	}else{
	        	$.ajax({
	                cache:false,
	                type: "post",
	                url:"platform/cbbTemplet/<%=appId%>/${tableId}/searchTreeGrid.json",
	                dataType:"json",
	                data:{search_text:value},
	                async: false,
	                error: function(request) {
	                	throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
	                },
	                success: function(data) {
						if(data){
							$("#tt").treegrid('loadData',data);
						}else{
							$("#tt").treegrid('loadData',{});
						}
	                }
	            });
        	}
        },
        prompt: "请输入模板名称！"
    });
});



function formatcombobox(value){
	if(value ==null ||value == ''){
		return '';
	}
	if(value == 'R'){
		return '根节点';
	}else if(value == 'F'){
		return '模板夹';
	}else if(value == 'C'){
		return '模板';
	}else if(value == 'S'){
		return '系统标识';
	}
}
function saveUser(){
	var url='platform/eform/tabledefine/savetemplet';
	var treeids='';
	var tableId=$('#tableId').val();
	try {
	var rows = $("input[name='id']");
	$("input[name='id']").each(function(){
	    if ($(this).attr("checked")){
	    	var node = $('#tt').treegrid('find', $(this).val());
	    	if (node.type != 'C'){
	    		throw "请选择模板类型节点，否则不能与表关联";
	    	}
	    	treeids=treeids+$(this).val()+',';
	    }
	  });
	/**
	var row = $('#tt').datagrid('getChecked');
	for(var i=0;i<row.length;i++){
		if (row[i].type != 'C'){
			$.messager.alert('提示','请选择模板类型节点，否则不能与表关联','warning');
			return false;
		}
		treeids=treeids+row[i].id+',';
	}
	**/
	$.post(url, {
		tableId:tableId,
		treeids:treeids
	}, function(result) {
			if (treeids == ''){
				parent.alertSuccess('提示','模板关联取消成功！');
			}else{
				parent.alertSuccess('提示','模板关联成功！');
			}
			parent.dlg_close('newtemplet');
		
	}, 'json');
	}catch(e){
		$.messager.alert('提示',e,'warning');
		return false;
	}
	
}


</script> 
</body> 