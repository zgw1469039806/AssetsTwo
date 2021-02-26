<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统首页管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false" style="padding:0px;overflow:hidden;height:0; overflow:hidden;">
		<div id="toolbar" class="datagrid-toolbar" style="display: block;">
				<table>  
					<tr>
						<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="insert();" href="javascript:void(0);">添加</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit();" href="javascript:void(0);">编辑</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="del();" href="javascript:void(0);">删除</a></td>
					</tr>
				</table>
	     </div>
		<table id="portalconfig" class="easyui-datagrid" 
			data-options=" 
				fit: true,
				border: false,
				rownumbers: true,
				idField :'id',
				animate: true,
				collapsible: false,
				toolbar:'#toolbar',
				fitColumns: true,
				autoRowHeight: false,
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				striped:true,
				url:'platform/portlet/portletconfig/getData.json',
				onClickCell:clickCell
				">
			<thead>
				<th data-options="field:'id',halign:'center',checkbox:true">id</th>
				<th data-options="field:'name',halign:'center'" width="220">名称</th>
				<th data-options="field:'userid',halign:'center',hidden:true" width="220"></th>
				<th data-options="field:'userName',align:'center',halign:'center'" width="100">创建者</th>
				<th data-options="field:'roleId',halign:'center',hidden:true"></th>
				<th data-options="field:'layoutExtends',halign:'center'" width="220">应用角色</th>
				<th data-options="field:'layout',halign:'center'" width="120">布局</th>
				<th data-options="field:'indexType',align:'center',halign:'center',formatter:formatIndex" width="120">首页类型</th>
				<th data-options="field:'orderBy',halign:'center'" width="50">优先级</th>
				<th data-options="field:'content',align:'center',halign:'center',formatter:formatContent,styler:styler" width="100">portlet</th>
				<th data-options="field:'c',align:'center',halign:'center',formatter:formatContent,styler:styler" width="100">菜单</th>
			</thead>
		</table>
	</div>
<script type="text/javascript">
var datagrid;
var indexType=[];
$(function(){
	Platform6.fn.lookup.getLookupType('PLATFORM_INDEX_TYPE',function(r){r&&(indexType=r);});
});
function styler(){
	return 'cursor:pointer;';
};
function formatIndex(value,row,index){
	return Platform6.fn.lookup.formatLookupType(value, indexType);
};
function formatContent(value,row,index){
	return "<span style='color:green;cursor:pointer;'>配置</span>";
};
//添加页面
var insert=function(){
	this.nData = new CommonDialog("insert","730","400","platform/portlet/operation/"+'add/null',"添加",false,true,false);
	this.nData.show();
};
var edit =function(){
	var rows = $('#portalconfig').datagrid('getChecked');
	if(rows.length !== 1){
		$.messager.alert('提示','请选择一条数据编辑！','warning');
		return false;
	}
	this.nData = new CommonDialog("edit","730","400","platform/portlet/operation/modify/"+rows[0].id,"编辑",false,true,false);
	this.nData.show();
}
//保存
var save=function(obj,id,t){
	$.ajax({
		 url:'platform/portlet/portletconfig/save.json',
		 data : {datas :JSON.stringify(obj),type:t},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 $("#portalconfig").datagrid('load',{});
				 $("#portalconfig").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
				 $(id).dialog('close');
				$.messager.show({
					 title : '提示',
					 msg : '保存成功！'
				 });
			 }else{
				 $.messager.show({
					 title : '提示',
					 msg : r.error
				});
			 } 
		 }
	 });
};
var closeDialog=function(id){
	 $(id).dialog('close');
};
//删除
var del=function(){
	var rows = $("#portalconfig").datagrid('getChecked');
	var ids = [];
	var l =rows.length;
  	if(l > 0){
	  $.messager.confirm('请确认','您确定要删除当前所选的数据？',function(b){
		 if(b){
			 for(;l--;){
				 ids.push(rows[l].id);
			 }
			 $.ajax({
				 url:'platform/portlet/portletconfig/delte.json',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 $("#portalconfig").datagrid('load',{});
						 $("#portalconfig").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({
							 title : '提示',
							 msg : '删除成功！'
						});
					}else{
						$.messager.show({
							 title : '提示',
							 msg : r.error
						});
					}
				 }
			 });
		 } 
	  });
  	}else{
	  $.messager.alert('提示','请选择要删除的记录！','warning');
  	}
};
var clickCell = function(index, field,value){
	var nowRow=$('#portalconfig').datagrid('getRows')[index];
	if(field ==='content'&&nowRow.indexType==='0'){
		window.open('<%=ViewUtil.getRequestPath(request)%>avicit/platform6/modules/system/sysdashboard/indexAdmin.jsp?sysPortletConfigId='+nowRow.id+'&j='+ Math.random());
	}else if(field ==='c'&&nowRow.indexType==='0'){
		this.nData = new CommonDialog("addmenu","700","450","platform/portlet/portletMenu/"+nowRow.id,"【"+nowRow.name+"】首页菜单",false,true,false);
		this.nData.show();
	}else if(field ==='content' ||field ==='c'){
		$.messager.show({
			 title : '提示',
			 msg : '自定义首页不需要配置'
		});
	}
};
</script>
</body>
</html>