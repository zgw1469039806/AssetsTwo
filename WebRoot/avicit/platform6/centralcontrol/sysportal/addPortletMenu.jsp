<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
    <jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
    <script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
    <script src="avicit/platform6/centralcontrol/sysmenu/js/SysMenu.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,title:'系统菜单'" style="width:250px;padding:0px;">
		<div id="toolbar" class="datagrid-toolbar">
		 	<table width="100%">
		 		<tr>
		 			<td width="100%"><input  type="text"  name="searchWord" id="searchWord"></input></td>
		 		</tr>
		 	</table>
		 </div>
		<ul id="menu">正在加载数据...</ul>
	</div>
	<div data-options="region:'center',split:true,title:'自定义菜单'" style="padding: 0px;height:0; overflow:hidden;">
		<div id="toolbarImportResult" class='datagrid-toolbar'>
			<table>
				<tr>
					<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="before();" href="javascript:void(0);">向前添加</a></td>
					<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="after();" href="javascript:void(0);">向后添加</a></td>
					<td><a class="easyui-linkbutton" iconCls="icon-add-other" plain="true" onclick="child();" href="javascript:void(0);">添加子菜单</a></td>
					<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="del();" href="javascript:void(0);">删除</a></td>
				</tr>
			</table>
		</div>
		<ul id="sdmenu"></ul>
	</div>
<script type="text/javascript">
var sysMenu,sdMenu,configId='${id}';
$(function(){
	 sysMenu = new SysMenu('menu','${url}','searchWord','form');
	 sysMenu.loadByAppId(parent._appid);
	 sdMenu=$("#sdmenu").tree({
		 url:"platform/cc/sysportal/getPortletMenu/2/"+configId,
		 method:'GET'
		});
});
var before =function(){
	var node = $('#menu').tree('getSelected'),roots,newNode,_snode;
	if(node._parentId ==="-1"){
		alert('不允许添加根节点');
		return false;
	}
	roots =sdMenu.tree("getRoots");
	newNode ={};
	if(roots.length==0){//添加跟节点
		newNode.menuId=node.id;
		newNode.text =node.text;
		newNode.parentId="-1";
		newNode.beforeId="first";
		newNode.afterId="last";
		
		$.ajax({
			 url:"platform/cc/sysportal/savePortletMenu/"+configId,
			 data : {before:'first',now:JSON.stringify(newNode),after:'last'},//{datas :JSON.stringify(obj),appId:_appid,type:t},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if(r.flag==='success'){
					 newNode.id=r.id
					 _snode=sdMenu.tree('append',{data:[newNode]}).tree('find', newNode.id);
					 sdMenu.tree('select', _snode.target);
				 }else{
					 $.messager.show({
						 title : '提示',
						 msg : r.e
					});
				 }
			 }
		 });
	}else{//向前添加
		var _ssnode= sdMenu.tree('getSelected');
		var preNode;
		var first='first';
		if(!_ssnode){
			alert('请选择一个菜单！');
			return false;
		}
		if(_ssnode.beforeId){
			preNode=sdMenu.tree('find', _ssnode.beforeId);
			if(preNode){
				first=preNode.id;
			}
		}
		newNode.menuId=node.id;
		newNode.text =node.text;
		newNode.parentId=_ssnode.parentId;
		
		newNode.beforeId=_ssnode.beforeId;
		newNode.afterId=_ssnode.id;
		
		$.ajax({
			 url:"platform/cc/sysportal/savePortletMenu/"+configId,
			 data : {before:first,now:JSON.stringify(newNode),after:_ssnode.id},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if(r.flag==='success'){
					 newNode.id=r.id
					 sdMenu.tree('insert', {
							before: _ssnode.target,
							data: [newNode]
						}).tree('update', {
							target: _ssnode.target,
							beforeId: newNode.id
						});
						if(preNode){
							sdMenu.tree('update', {
								target: preNode.target,
								afterId: newNode.id
							});
						}
				 }else{
					 $.messager.show({
						 title : '提示',
						 msg : r.e
					});
				 }
			 }
		 });
	}
}
var after =function(){
	var node = $('#menu').tree('getSelected'),roots,_node,_snode;
	if(node._parentId ==="-1"){
		alert('不允许添加根节点');
		return false;
	}
	roots =sdMenu.tree("getRoots");
	_node ={};
	if(roots.length==0){//添加跟节点
		_node.menuId=node.id;
		_node.text =node.text;
		_node.parentId="-1";
		_node.beforeId='first';
		_node.afterId='last';
		
		$.ajax({
			 url:"platform/cc/sysportal/savePortletMenu/"+configId,
			 data : {before:'first',now:JSON.stringify(_node),after:'last'},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if(r.flag==='success'){
					 _node.id=r.id
					 _snode=sdMenu.tree('append',{data:[_node]}).tree('find', _node.id);
					sdMenu.tree('select', _snode.target);
				 }else{
					 $.messager.show({
						 title : '提示',
						 msg : r.e
					});
				 }
			 }
		 });
	}else{//向后添加
		var _ssnode= sdMenu.tree('getSelected');
		var aftNode;
		var after='last';
		if(!_ssnode){
			alert('请选择一个菜单！');
			return false;
		}
		if(_ssnode.afterId){
			aftNode=sdMenu.tree('find', _ssnode.afterId);
			if(aftNode){
				after=aftNode.id;
			}
		}
		_node.menuId=node.id;
		_node.text =node.text;
		_node.parentId=_ssnode.parentId;
		
		_node.beforeId=_ssnode.id;
		_node.afterId=_ssnode.afterId;
		
		$.ajax({
			 url:"platform/cc/sysportal/savePortletMenu/"+configId,
			 data : {before:_ssnode.id,now:JSON.stringify(_node),after:after},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if(r.flag==='success'){
					 _node.id=r.id
					 sdMenu.tree('insert', {
							after: _ssnode.target,
							data: [_node]
						}).tree('update', {
							target: _ssnode.target,
							afterId: _node.id
						});
						if(aftNode){
							sdMenu.tree('update', {
								target: aftNode.target,
								beforeId: _node.id
							});
						}
				 }else{
					 $.messager.show({
						 title : '提示',
						 msg : r.e
					});
				 }
			 }
		 });
	}
}
var child=function(){
	var node = $('#menu').tree('getSelected'),roots,_node,_snode;
	if(node._parentId ==="-1"){
		alert('不允许添加根节点');
		return false;
	}
	roots =sdMenu.tree("getRoots");
	_node ={};
	if(roots.length==0){//添加跟节点
		_node.menuId=node.id;
		_node.text =node.text;
		_node.parentId="-1";
		_node.beforeId='first';
		_node.afterId='last';
		
		$.ajax({
			 url:"platform/cc/sysportal/savePortletMenu/"+configId,
			 data : {before:'first',now:JSON.stringify(_node),after:'last'},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if(r.flag==='success'){
					 _node.id=r.id
					 _snode=sdMenu.tree('append',{data:[_node]}).tree('find', _node.id);
					sdMenu.tree('select', _snode.target);
				 }else{
					 $.messager.show({
						 title : '提示',
						 msg : r.e
					});
				 }
			 }
		 });
	}else{//添加子节点
		var _ssnode= sdMenu.tree('getSelected');
		if(!_ssnode){
			alert('请选择一个菜单！');
			return false;
		}
		_node.menuId=node.id;
		_node.text =node.text;
		_node.parentId=_ssnode.id;
		if(_ssnode.children&&_ssnode.children.length>0){//有子节点
			var preNode=_ssnode.children[_ssnode.children.length-1];
			_node.beforeId=preNode.id;
			_node.afterId='last';
			
			$.ajax({
				 url:"platform/cc/sysportal/savePortletMenu/"+configId,
				 data : {before:preNode.id,now:JSON.stringify(_node),after:'last'},
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if(r.flag==='success'){
						 _node.id=r.id
						 sdMenu.tree('append', {
								parent: _ssnode.target,
								data: [_node]
							}).tree('update', {
								target: sdMenu.tree('find', preNode.id).target,
								afterId: _node.id
							});	
					 }else{
						 $.messager.show({
							 title : '提示',
							 msg : r.e
						});
					 }
				 }
			 });
		}else{//没子节点
			_node.beforeId='first';
			_node.afterId='last';
			
			$.ajax({
				 url:"platform/cc/sysportal/savePortletMenu/"+configId,
				 data : {before:'first',now:JSON.stringify(_node),after:'last'},//{datas :JSON.stringify(obj),appId:_appid,type:t},
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if(r.flag==='success'){
						 _node.id=r.id
						 sdMenu.tree('append', {
							parent: _ssnode.target,
							data: [_node]
						 });	
					 }else{
						 $.messager.show({
							 title : '提示',
							 msg : r.e
						});
					 }
				 }
			 });
		}
	}
}
var del =function(){
	var _ssnode= sdMenu.tree('getSelected');
	if(!_ssnode){
		alert("请选择要删除的菜单！");
		return false;
	}
	$.messager.confirm('请确认','您确定要删除当前菜单及其子菜单？',function(b){
		 if(b){
			 $.ajax({
				 url:"platform/cc/sysportal/deletePortletMenu/"+_ssnode.id,
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if(r.flag==='success'){
						 if(_ssnode.beforeId ==="first"&&_ssnode.afterId==="last"){
						 }else if(_ssnode.beforeId ==="first"){
							 sdMenu.tree('update', {
									target: sdMenu.tree('find', _ssnode.afterId).target,
									beforeId: 'first'
								});	
						 }else if(_ssnode.afterId==="last"){
							 sdMenu.tree('update', {
								 	target: sdMenu.tree('find', _ssnode.beforeId).target,
								 	afterId: 'last'
								});	
						 }else{
							 sdMenu.tree('update', {
								 	target: sdMenu.tree('find', _ssnode.beforeId).target,
								 	afterId: _ssnode.afterId
								}).tree('update', {
									target: sdMenu.tree('find', _ssnode.afterId).target,
									beforeId: _ssnode.beforeId
								});	
						 }
						 sdMenu.tree('remove',_ssnode.target);
						 var node =sdMenu.tree('find',_ssnode.parentId);
						 if(node){
							sdMenu.tree('select', node.target);
						 }
					 }else{
						 $.messager.show({
							 title : '提示',
							 msg : r.e
						});
					 }
				 }
			 }); 
		 }
	});
	return true;
	/* var _ssnode= sdMenu.tree('getSelected');
	sdMenu.tree('remove',_ssnode.target);
	var node =sdMenu.tree('find',_ssnode.parentId);
	 if(node){
		 sdMenu.tree('select', node.target);
	 } */
}
</script>	
</body>            
</html>