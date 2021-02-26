<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,tree,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单授权</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<link rel="stylesheet" type="text/css" href="avicit/platform6/console/authorization/css/auth.css"/>
</head>
<body class="easyui-layout" fit="true" style="overflow: hidden;">
	<div data-options="region:'west',split:false,border:true,collapsible:false" id="west" style="width: 350px;">
			<div id="tableToolbarM" class="toolbar">
				<div class="toolbar-left">
						<div class="input-group  input-group-sm">
							<input  class="form-control" placeholder="输入名称查询" type="text" id="txt" name="txt">
							<span class="input-group-btn">
								<button id="searchbtn" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
							</span>
						</div>
				</div>
				<div class="toolbar-right">
					<a id="authRefresh" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="刷新缓存"><i class="glyphicon glyphicon-refresh"></i>刷新缓存</a>
				</div>
			</div>
			<div  id='mdiv' style="overflow:auto;">
				<ul id="consoleMenu" class="ztree"></ul>
			</div>
	</div>
	<div data-options="region:'center'">
		<ul id="myTab" class="nav nav-tabs">
			<!--<li class="active"><a rel='R' href="#role" data-toggle="tab">角色</a></li>
			 <li><a rel='U' href="#user" data-toggle="tab">用户</a></li>
			<li><a rel='D' href="#dept" data-toggle="tab">部门</a></li>
			<li><a rel='P' href="#post" data-toggle="tab">岗位</a></li>
			<li><a rel='G' href="#group" data-toggle="tab">群组</a></li> -->
		</ul>
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="role">
				<div id="tableToolbarR" class="toolbar">
					<div class="toolbar-left">
						<a id="addR" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
						title="添加角色"><i class="icon icon-add"></i>添加</a>


						<a id="allowR" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="授权角色"><i class="glyphicon glyphicon-ok"></i>授权</a>
						<a id="denyR" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="禁止角色"><i class="glyphicon glyphicon-ban-circle"></i>禁止</a>


						<a id="delR" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="删除角色授权"><i class="icon icon-delete"></i>删除</a>
					</div>
					<div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordR" style="width:240px;" class="form-control input-sm" placeholder="输入名称查询">
							<label id="keyWordLableR" class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div>
				</div>
				<table id="jqGridR"></table>
			</div>

<%--
			<div class="tab-pane fade" id="user">
				<div id="tableToolbarU" class="toolbar">
					<div class="toolbar-left">
						<a id="addU" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="添加用户"><i class="icon icon-add"></i>添加</a>


						<a id="allowU" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="授权用户"><i class="icon icon-delete"></i>授权</a>
						<a id="denyU" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="禁止用户"><i class="icon icon-add"></i>禁止</a>


						<a id="delU" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="删除用户授权"><i class="icon icon-delete"></i>删除</a>
					</div>
					<div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordU" style="width:240px;" class="form-control input-sm" placeholder="名称">
							<label id="keyWordLableU" class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div>
				</div>
				<table id="jqGridU"></table>
			</div>

			<div class="tab-pane fade" id="dept">
				<div id="tableToolbarD" class="toolbar">
					<div class="toolbar-left">
						<a id="addD" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="添加部门"><i class="icon icon-add"></i>添加</a>


						<a id="allowD" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="授权部门"><i class="icon icon-delete"></i>授权</a>
						<a id="denyD" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="禁止部门"><i class="icon icon-add"></i>禁止</a>


						<a id="delD" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="删除部门授权"><i class="icon icon-delete"></i>删除</a>
					</div>
					<div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordD" style="width:240px;" class="form-control input-sm" placeholder="名称">
							<label id="keyWordLableD" class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div>
				</div>
				<table id="jqGridD"></table>
			</div>
			<div class="tab-pane fade" id="post">
				<div id="tableToolbarP" class="toolbar">
				<div class="toolbar-left">
					<a id="addP" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加岗位"><i class="icon icon-add"></i>添加</a>


					<a id="allowP" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="授权岗位"><i class="icon icon-delete"></i>授权</a>
					<a id="denyP" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="禁止岗位"><i class="icon icon-add"></i>禁止</a>


					<a id="delP" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除岗位授权"><i class="icon icon-delete"></i>删除</a>
				</div>
				<div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordP" style="width:240px;" class="form-control input-sm" placeholder="名称">
							<label id="keyWordLableP" class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div>
				</div>
				<table id="jqGridP"></table>
			</div>
			<div class="tab-pane fade" id="group">
				<div id="tableToolbarG" class="toolbar">
					<div class="toolbar-left">
						<a id="addG" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="添加群组"><i class="icon icon-add"></i>添加</a>


						<a id="allowG" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="授权群组"><i class="icon icon-delete"></i>授权</a>
						<a id="denyG" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="禁止群组"><i class="icon icon-add"></i>禁止</a>


						<a id="delG" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="删除群组授权"><i class="icon icon-delete"></i>删除</a>
					</div>
					<div class="toolbar-right">
						<div class="input-group form-tool-search">
							<input type="text" name="keyWord" id="keyWordG" style="width:240px;" class="form-control input-sm" placeholder="名称">
							<label id="keyWordLableG" class="icon icon-search form-tool-searchicon"></label>
						</div>
					</div>
				</div>
				<table id="jqGridG"></table>
			</div>
		--%>

        </div>
	</div> 
</body>
<div id="selectR" style="overflow: auto;display: none">
	<div id="searchBarR" class="toolbar">
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
<div id="selectU" style="overflow: auto;display: none">
	<div id="searchBarU" class="toolbar">
		<div class="toolbar-right" style="margin-right: 10px;">
			<div class="input-group form-tool-search">
				<input type="text" name="keyWord" id="keyWordUser" style="width:240px;" class="form-control input-sm" placeholder="名称">
				<label id="keyWordUserL" class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="jqGridUser"></table>
	<div id="jqGridPagerU"></div>
</div>
<div id="selectG" style="overflow: auto;display: none">
	<div id="searchBarG" class="toolbar">
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="keyWord" id="keyWordGroup" style="width:240px;" class="form-control input-sm" placeholder="名称">
				<label id="keyWordGroupL" class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="jqGridGroup"></table>
	<div id="jqGridPagerG"></div>
</div>
<div id="selectP" style="overflow: auto;display: none">
	<div id="searchBarP" class="toolbar">
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="keyWord" id="keyWordPost" style="width:240px;" class="form-control input-sm" placeholder="名称">
				<label id="keyWordPostL" class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="jqGridPost"></table>
	<div id="jqGridPagerP"></div>
</div>
<div id="selectD" style="overflow: auto;display: none">
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
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/console/menu/js/MenuTree.js" ></script>
<script type="text/javascript" src="avicit/platform6/console/authmenu/js/RudgpObj.js" ></script>
<script type="text/javascript" src="avicit/platform6/console/authmenu/js/listObj.js"></script>
<script type="text/javascript" src="avicit/platform6/console/authmenu/js/treeObj.js"></script>

<script  type="text/javascript">
var menuTree,pId,targetType='R',applicationId='${appId}',orgId='${orgId}',utype='${utype}',
	userList,
	roleList,
	groupList,
	deptList,
	postionList;
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
var clickMenu=function(){
	switch(targetType){
		case 'R':{
			if(!roleList){
				var dataGridColModelR =  [
				{ label: 'id', name: 'id', key: true, hidden:true },
				{ label: '角色名称', name: 'name', width: 100,sortable:false,align:'center'},
				{ label: '角色描述', name: 'desc', width: 80,sortable:false,align:'center' },
				{ label: '状态', name: 'auth', width: 20,sortable:false,align:'center',formatter:formatStatus}
				];
				roleList = new RudgpObj('jqGrid','${url}','R',dataGridColModelR,pId,applicationId,orgId);
				break;
			}
			roleList.loadByAppId(pId);
			
			break;	
		}
		
		case 'U':{
			if(!userList){
				var dataGridColModelU =  [
				{ label: 'id', name: 'id', key: true, hidden:true },
				{ label: '用户姓名', name: 'name', width: 100,sortable:false,align:'center'},
				{ label: '登录名', name: 'loginName', width: 80,sortable:false,align:'center' },
				{ label: '状态', name: 'auth', width: 20,sortable:false,align:'center',formatter:formatStatus}
				];
				userList = new RudgpObj('jqGrid','${url}','U',dataGridColModelU,pId,applicationId,orgId,utype);
				break;
			}
			userList.loadByAppId(pId);
			
			break;	
		}
		case 'D':{
			if(!deptList){
				var dataGridColModelD =  [
				{ label: 'id', name: 'id', key: true, hidden:true },
				{ label: '部门名称', name: 'name', width: 100,sortable:false,align:'center'},
				{ label: '部门编号', name: 'code', width: 80,sortable:false,align:'center' },
				{ label: '状态', name: 'auth', width: 20,sortable:false,align:'center',formatter:formatStatus}
				];
				deptList = new RudgpObj('jqGrid','${url}','D',dataGridColModelD,pId,applicationId,orgId);
				break;
			}
			deptList.loadByAppId(pId);
			break;
		}
		case 'P':{
			if(!postionList){
				var dataGridColModelP =  [
				{ label: 'id', name: 'id', key: true, hidden:true },
				{ label: '岗位名称', name: 'name', width: 100,sortable:false,align:'center'},
				{ label: '岗位描述', name: 'desc', width: 80,sortable:false,align:'center' },
				{ label: '状态', name: 'auth', width: 20,sortable:false,align:'center',formatter:formatStatus}
				];
				postionList = new RudgpObj('jqGrid','${url}','P',dataGridColModelP,pId,applicationId,orgId);
				break;
			}
			postionList.loadByAppId(pId);
			break;
		}
		case 'G':{
			if(!groupList){
				var dataGridColModelG =  [
				{ label: 'id', name: 'id', key: true, hidden:true },
				{ label: '群组名称', name: 'name', width: 100,sortable:false,align:'center'},
				{ label: '群组描述', name: 'desc', width: 80,sortable:false,align:'center' },
				{ label: '状态', name: 'auth', width: 20,sortable:false,align:'center',formatter:formatStatus}
				];
				groupList = new RudgpObj('jqGrid','${url}','G',dataGridColModelG,pId,applicationId,orgId);
				break;
			}
			groupList.loadByAppId(pId);
			break;
		}
		default :{}

	}

};
$(function(){
   	$('#mdiv').height(document.documentElement.clientHeight-50);
	//菜单树初始化
	menuTree = new MenuTree('consoleMenu','${url}','','txt','searchbtn');

	menuTree.setOnSelect(function(treeNode) {
			pId=treeNode.id;
			clickMenu();
		}).init();

	});


	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		targetType=e.target.rel;
		clickMenu();
	});


	$('#authRefresh').bind('click',function(){
		$.ajax({
			url:'console/auth/ORG_ROOT/authRefresh',
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
</script>
</html>