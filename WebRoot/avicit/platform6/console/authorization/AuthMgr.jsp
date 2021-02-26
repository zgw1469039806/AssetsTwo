<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,tree,table";	
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>集中授权</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<link rel="stylesheet" type="text/css" href="avicit/platform6/console/authorization/css/auth.css"/>
<style>
.ui-jqgrid .ui-paging-pager td {
    padding: 0 2px;
}
</style>
</head>
<body class="easyui-layout" fit="true" style="overflow:hidden;">

	<div data-options="region:'west',title:'授权选择',split:false,border:true,collapsible:false" style="width:460px;overflow-x: hidden;">
		<ul id="myTab" class="nav nav-tabs">
			<!-- <li class="active"><a rel='R' href="#role" data-toggle="tab">角色</a></li>
			<li><a rel='U' href="#user" data-toggle="tab">用户</a></li>
			<li><a rel='D' href="#dept" data-toggle="tab">部门</a></li>
			<li><a rel='P' href="#post" data-toggle="tab">岗位</a></li>
			<li><a rel='G' href="#group" data-toggle="tab">群组</a></li> -->
		</ul>
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="role">
				<div id="tableToolbarR" class="toolbar">
				<div class="toolbar-right" style="margin-right: 10px;">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordRole" style="width:240px;" class="form-control input-sm" placeholder="角色名称">
							<label id="keyWordRoleL" class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div>
				</div>
				<table id="jqGridRole"></table>
				<div id="jqGridPagerR"></div>
			</div>


			<div class="tab-pane fade" id="user">
				<div id="tableToolbarU" class="toolbar">
					<div class="input-group  input-group-sm">
						<input  class="form-control" placeholder="回车查询" type="text" id="keyWordUser" name="txt">
						<span class="input-group-btn">
							<button id="searchUser" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
						</span>
					</div>
				</div>
				<table id="jqGridUser"></table>
				<div id="jqGridPagerU"></div>
			</div>

			<div class="tab-pane fade" id="dept">
				<div class="input-group  input-group-sm">
					<input  class="form-control" placeholder="回车查询" type="text" id="searchDeptVal" name="txt">
					<span class="input-group-btn">
						<button id="searchDept" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
					</span>
				</div>
				<div>
					<ul id="deptTree" class="ztree"></ul>
				</div>
			</div>
			<div class="tab-pane fade" id="post">
				<div id="tableToolbarP" class="toolbar">
				<div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordPost" style="width:240px;" class="form-control input-sm" placeholder="名称或者编码">
							<label id="keyWordPostL" class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div>
				</div>
				<table id="jqGridPost"></table>
				<div id="jqGridPagerP"></div>
			</div>
			<div class="tab-pane fade" id="group">
				<div id="tableToolbarG" class="toolbar">
					<div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordGroup" style="width:240px;" class="form-control input-sm" placeholder="名称或者编码">
							<label id="keyWordGroupL" class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div>
				</div>
				<table id="jqGridGroup"></table>
				<div id="jqGridPagerG"></div>
			</div>
		</div>


	</div>   
    <div id='center' data-options="region:'center',title:'菜单权限',split:false,border:true" style="overflow: hidden;">
	<div id="tableToolbarGroup" class="toolbar">
		<div class="toolbar-left">
			<a id="authAllow" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="授权"><i class="glyphicon glyphicon-ok"></i>授权</a>
			<a id="authDeny" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="禁止"><i class="glyphicon glyphicon-ban-circle"></i>禁止</a>
			<a id="authRmv" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="移除"><i class="glyphicon glyphicon-remove"></i>移除</a>
			<a id="authAllowCur" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="递归授权"><i class="glyphicon glyphicon-ok"></i>递归授权</a>
			<a id="authRefresh" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="刷新缓存"><i class="glyphicon glyphicon-refresh"></i>刷新授权缓存</a>
		</div>
	</div>
    <div style="margin-left: 10px;font-size: 16px;"><span style="color: blue;font-weight: bold;">蓝色</span>:允许授权,<span style="color: red;font-weight: bold;">红色</span>:禁止权限,<span style="font-weight: bold;">黑色</span>:默认权限 </div>
	<div id='mdiv' style="overflow:auto;">
		<ul id="menuTree" class="ztree"></ul>
	</div>
</div>  
    <div data-options="region:'east',title:'组件权限',split:false,border:true,collapsible:false" style="width:450px;">
	<div id="tableToolbarCom" class="toolbar">
		<div class="toolbar-left">
			<div class="dropdown">
				<a class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu">批量操作<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					<li role="presentation"><a href="javascript:void(0);" id="compAllow">批量允许</a></li>
					<li role="presentation"><a href="javascript:void(0);" id="compDeny">批量禁止</a></li>
					<li role="presentation"><a href="javascript:void(0);" id="compRmv">批量移除</a></li>

				</ul>
			</div>
			<a id="reloadComs" href="javascript:void(0)"
			class="btn btn-primary form-tool-btn btn-sm" role="button"
			title="重载页面组件"><i class="icon icon-add"></i>重载页面组件</a>
			

			<a id="comDel" href="javascript:void(0)"
			class="btn btn-primary form-tool-btn btn-sm" role="button"
			title="删除"><i class="icon icon-delete"></i>删除</a>

            
		</div>
	</div>
	<table id="comJqGrid"></table>

</div>    
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/console/authorization/js/listObj.js"></script>
<script type="text/javascript" src="avicit/platform6/console/authorization/js/treeObj.js"></script>
<script type="text/javascript" src="avicit/platform6/console/authorization/js/authMenu.js"></script>
<script type="text/javascript" src="avicit/platform6/console/authorization/js/comObj.js"></script>
<script type="text/javascript">
var listRole,listUser,listPost,treeDept,listGroup,menuTree,appId='${appId}';
var idTypeMap={},comObj;
var formatStatus=function(cellvalue, options, rowObject){
	
	if(cellvalue=='1'){
		return "<img src='avicit/platform6/console/authorization/images/ok.png' title='允许访问'>";
	}
	if(cellvalue=='0'){
		return "<img src='avicit/platform6/console/authorization/images/no.gif' title='禁止访问'>";
	}
	if(!cellvalue){
		return "<img src='avicit/platform6/console/authorization/images/untitled.png' title='未设置权限'>";
	}
};
var clickRow=function(rid,type){
	$('#mdiv').height($('#center').height()-85);
	idTypeMap[type]=rid;
	if(!rid){
		if(menuTree){
			menuTree.tree.removeNode(menuTree.tree.getNodeByParam("_parentId","-1",null));
			if(comObj){
				comObj.clear();
			}
			return false;
		}
		return false;
	}
	menuTree = new MenuTree('menuTree','${urlMenu}'+'/M/'+rid+'-'+type,type).init();
	
	menuTree.setOnSelect(function(node){
		var dataGridComModel =  [
		{ label: 'id', name: 'id', key: true, hidden:true },
		{ label: '组件名称', name: 'name', width: 50,sortable:false,align:'center'},
		{ label: '组件标识', name: 'desc', width: 100,sortable:false,align:'left' },
		{ label: '状态', name: 'status', width: 20,sortable:false,align:'center',formatter:formatStatus }];
		comObj =new ComObj('comJqGrid','${urlMenu}'+'/C/'+rid+'-'+type,dataGridComModel,node.id,type).loadByMenuId(node.id);
	});
	if(comObj){
		comObj.clear();
	}

};

$(function(){
	var dataGridColModel =  [
	{ label: 'id', name: 'id', key: true, hidden:true },
	{ label: '角色名称', name: 'roleName', width: 100,sortable:false,align:'center'},
	{ label: '角色描述', name: 'roleDesc', width: 80,sortable:false,align:'center' }
	];
	listRole = new ListObj('jqGridRole','${urlRole}'+'/R','searchDialog','R','keyWordRole',["roleName"],dataGridColModel,appId);
	listRole.setOnClick(clickRow);

	/*菜单事件绑定 */
	$('#authAllow').bind('click',function(){
		if(!menuTree||listRole.getNull()){
			layer.alert('请选择一个角色！', {
				icon: 7,
				area: ['400px', ''],
				closeBtn: 0
			});
			return false;
		}
		menuTree.allow();
	});
	$('#authDeny').bind('click',function(){
		if(!menuTree||listRole.getNull()){
			layer.alert('请选择一个角色！', {
				icon: 7,
				area: ['400px', ''],
				closeBtn: 0
			});
			return false;
		}
		menuTree.deny();
	});
	$('#authRmv').bind('click',function(){
		if(!menuTree||listRole.getNull()){
			layer.alert('请选择一个角色！', {
				icon: 7,
				area: ['400px', ''],
				closeBtn: 0
			});
			return false;
		}
		menuTree.remove();
	});

	$('#authAllowCur').bind('click',function(){
		if(!menuTree||listRole.getNull()){
			layer.alert('请选择一个角色！', {
				icon: 7,
				area: ['400px', ''],
				closeBtn: 0
			});
			return false;
		}
		menuTree.allowCur();
	});

	$('#authRefresh').bind('click',function(){
		$.ajax({
			url:'${urlGroup}'+'/authRefresh',
			type : 'post',
			dataType : 'json',
			success : function(r){
				if (r.flag == "success") {
					layer.msg('刷新成功！',{
						icon: 1,
						area: ['200px', ''],
						closeBtn: 0
					});
				}else{
					layer.alert('刷新失败！' + r.e, {
						icon: 2,
						area: ['400px', ''],
						closeBtn: 0
					});
				}
			}
		});
	});
	/*  组件事件绑定  */
	$('#reloadComs').bind('click',function(){
		if(!comObj){
			layer.msg('请选择菜单！',{
				icon: 7,
				area: ['200px', ''],
				closeBtn: 0
			});
			return false;
		}
		comObj.reLoadCom();
	});

	$('#comDel').bind('click',function(){
		if(!comObj){
			layer.msg('请选择组件！',{
				icon: 7,
				area: ['200px', ''],
				closeBtn: 0
			});
			return false;
		}
		comObj.del();
	});


	$('#compAllow').bind('click',function(){
		if(!comObj){
			layer.msg('请选择组件！',{
				icon: 7,
				area: ['200px', ''],
				closeBtn: 0
			});
			return false;
		}
		comObj.allow();
	});


	$('#compDeny').bind('click',function(){
		if(!comObj){
			layer.msg('请选择组件！',{
				icon: 7,
				area: ['200px', ''],
				closeBtn: 0
			});
			return false;
		}
		comObj.deny();
	});


	$('#compRmv').bind('click',function(){
		if(!comObj){
			layer.msg('请选择组件！',{
				icon: 7,
				area: ['200px', ''],
				closeBtn: 0
			});
			return false;
		}
		comObj.remove();
	});


	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {

		clickRow(idTypeMap[e.target.rel],e.target.rel);
		if(e.target.rel==='U'&&!listUser){

			var dataGridColModel1 =  [
			{ label: 'id', name: 'id', key: true, hidden:true },
			{ label: '用户登录名', name: 'loginName', width: 100,sortable:false,align:'center'},
			{ label: '用户名称', name: 'name', width: 80,sortable:false,align:'center' }
			];
			listUser = new ListObj('jqGridUser','${urlUser}'+'/U','searchDialog','U','keyWordUser',['loginName','name'],dataGridColModel1,appId);
			listUser.setOnClick(clickRow);
		}else if(e.target.rel==='G' &&!listGroup){

			var dataGridColModel2 =  [
			{ label: 'id', name: 'id', key: true, hidden:true },
			{ label: '群组名称', name: 'name', width: 100,sortable:false,align:'center'},
			{ label: '群组描述', name: 'desc', width: 80,sortable:false,align:'center' }
			];
			listGroup = new ListObj('jqGridGroup','${urlGroup}'+'/G','searchDialog','G','keyWordGroup',['name'],dataGridColModel2,appId);
			listGroup.setOnClick(clickRow);
		}else if(e.target.rel==='P' &&!listPost){

			var dataGridColModel3 =  [
			{ label: 'id', name: 'id', key: true, hidden:true },
			{ label: '岗位名称', name: 'name', width: 100,sortable:false,align:'center'},
			{ label: '岗位描述', name: 'desc', width: 80,sortable:false,align:'center' }
			];
			listPost = new ListObj('jqGridPost','${urlPost}'+'/P','searchDialog','P','keyWordPost', ['name','code'],dataGridColModel3,appId);
			listPost.setOnClick(clickRow);
		}else if(e.target.rel==='D' &&!treeDept){
			treeDept =TreeObj.init('${urlDept}'+'/D','searchDept');	
			treeDept.setClick(clickRow);
		}
	});
});
</script>
</html>