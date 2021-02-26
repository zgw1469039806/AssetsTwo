<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page import="avicit.platform6.api.sysshirolog.utils.SecurityUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";
String appId = SessionHelper.getApplicationId();

    String username = SessionHelper.getLoginName(request);
    Boolean isAdmin = SecurityUtil.isAdministrator(username);
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

</head>
<body class="easyui-layout" fit="true">
<div id="panelcenter" data-options="region:'center',onResize:function(a){$('#jqGridrole').setGridWidth(a);$('#jqGridrole').setGridHeight(getJgridTableHeight($('#panelcenter')));$(window).trigger('resize');}">

<div id="tableToolbarrole" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleRole_button_add" permissionDes="添加角色">
	  	<a id="consolerole_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加角色"><i class="icon icon-add"></i> 添加角色</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleRole_button_edit" permissionDes="保存">
		<a id="consolerole_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"><i class="icon icon-save"></i> 保存</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleRole_button_del" permissionDes="删除">
		<a id="consolerole_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleRole_button_importrole" permissionDes="角色导入">
		<a id="exportrole" href="javascript:void(0)"class="btn btn-primary form-tool-btn btn-sm" role="button" title="角色导入"><i class="icon icon-daoru"></i> 导入</a>
		</sec:accesscontrollist>

		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleRole_button_exportrole" permissionDes="导出角色">
		<div class="dropdown">
				<a class="btn btn-primary form-tool-btn btn-sm" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu"><i class="icon icon-daochu"></i> 导出<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					<!-- role = "presentation"表示陈述 -->
					<li role="presentation"><a href="javascript:void(0);" onclick="exportClientData();">导出-当前页</a></li>
					<li role="separator" class="divider"></li>
					<li role="presentation"><a href="javascript:void(0);" onclick="exportServerData();">导出-所有页</a></li>
				</ul>
		</div>
		</sec:accesscontrollist>
	</div>
	<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 160px">
					<input type="text" name="sysRole_keyWord"
						id="sysRole_keyWord"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="sysRole_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
	</div>
</div>
<table id="jqGridrole"></table>
<div id="jqGridPager1"></div>
</div>
<div id="paneleast" data-options="region:'east',split:true,width:fixwidth(.4),onResize:function(a){$('#jqGrid').setGridWidth(a);$('#jqGrid').setGridHeight(getJgridTableHeight($('#paneleast')));$(window).trigger('resize');}">
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleRoleUser_button_add" permissionDes="添加用户">
		<a id="consoleuser_add" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加用户"><i class="icon icon-add"></i> 添加用户</a>
		</sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleRoleUser_button_save" permissionDes="保存">
        <a id="consoleuser_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"><i class="icon icon-save"></i> 保存</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_consoleRoleUser_button_del" permissionDes="删除用户">
		<a id="consoleuser_delete" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>
		</sec:accesscontrollist>
	</div>
	<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width: 160px">
					<input type="text" name="sysUser_keyWord"
						id="sysUser_keyWord"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="sysUser_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
	</div>
</div>

<table id="jqGrid"></table>

<div id="jqGridPager"></div>
</div>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id='form' style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th>用户姓名:</th>
				<td><input title="用户姓名" class="form-control input-sm" type="text" name="name" id="name" /></td>
				
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="loginName">登录名:</label></th>
				<td width="39%"><input title="登录名" class="form-control input-sm" type="text" name="loginName" id="loginName" /></td>
			</tr>
		</table>
	</form>
</div>


<!-- 高级查询 -->
<div id="searcRolehDialog" style="overflow: auto;display: none">
	<form id='formrole' style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th>角色名称:</th>
				<td><input title="角色名称" class="form-control input-sm" type="text" name="roleName" id="roleName" /></td>
				
				<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="roleCode">角色编码:</label></th>
				<td width="39%"><input title="角色编码" class="form-control input-sm" type="text" name="roleCode" id="roleCode" /></td>
			</tr>
		</table>
	</form>
</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/role/js/consoleRole.js" type="text/javascript"></script> 
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript">
    var isAdmin = "<%=isAdmin%>";
    var viewScopeType = '';
    if (isAdmin == "true") {
        viewScopeType = '';
    } else {
        viewScopeType = 'currentOrg';
    }

var appid="<%=appId%>"; 	
var consolerole;
function formatStatus(cellvalue, options, rowObject) {

	if(rowObject.userLocked!="0"){
		return "<img src='avicit/platform6/console/role/images/lock.png' title='锁定'>";
	}
	if(cellvalue=="1"){
		return "<img src='avicit/platform6/console/role/images/state.png' title='有效用户'>";
	}else{
		return "<img src='avicit/platform6/console/role/images/unstate.png' title='无效用户'>";
	}
	
}
function formatConsole(cellvalue, options, rowObject) {
	
	if(cellvalue=="1"){
		return '';
	}else{
		return "<img src='avicit/platform6/console/user/images/status.png' title='是'>";
	}
}

function formatLevel(cellvalue, options, rowObject) {
	if(cellvalue=="1"){
		return '非涉密人员';
	}else if(cellvalue=="2"){
		return '一般涉密人员';
	}else if(cellvalue=="3"){
		return '重点涉密人员';
	}else{
	return '核心涉密人员';
	
	}
	
}

function formatRoleMoif(cellvalue, options, rowObject) {
	if(cellvalue=="0"){
		return '公共使用';
	}else{
		return '私有使用';
	}
	
}

function formatvalidFlag(cellvalue, options, rowObject) {
	if(cellvalue=="1"){
		return '有效';
	}else{
		return '无效';
	}
	
}
$(document).ready(function () {
	var searchMainNames = [];
	var searchMainTips = [];
	searchMainNames.push("roleName");
 	searchMainTips.push("名称");
 	searchMainNames.push("roleCode");
 	searchMainTips.push("编码");
	$('#sysRole_keyWord').attr('placeholder','请输入'+searchMainTips[0]+'或'+searchMainTips[1]);
	
	var searchUserMainNames = [];
	var searchUserMainTips = [];
	searchUserMainNames.push("name");
 	searchUserMainTips.push("用户名");
 	searchUserMainNames.push("loginName");
 	searchUserMainTips.push("登录名");
	$('#sysUser_keyWord').attr('placeholder','输入'+searchUserMainTips[0]+'或'+searchUserMainTips[1]);
	
	var dataGridUserColModel =  [
       { label: 'id', name: 'id', key: true, width: 75, hidden:true }
 	  ,{ label: '状态', name: 'status', sortable : false,width: 100,align:'center',formatter:formatStatus}

      ,{ label: '用户姓名', name: 'name', sortable : false,width: 200 ,align:'center'}
      ,{ label: '用户id', name: 'userId', width: 75, hidden:true , editable:true}

      ,{ label: '登录名', name: 'loginName',sortable : false, width: 200,align:'center'}
      ,{ label: '密级', name: 'secretLevel', sortable : false,width: 150,align:'center',formatter:formatLevel}
      ,{ label: '后台用户', name: 'consoleType', sortable : false,width: 150 ,align:'center',formatter:formatConsole}

      ,{ label: '关联部门', name: 'deptName', sortable : false,width: 150 ,align:'center', editable:true,edittype:'custom',editoptions:{custom_element:deptElem,custom_value:deptValue, forId:'deptId',viewScope:viewScopeType}}
      ,{ label: '关联部门id', name: 'deptId', width: 75, hidden:true , editable:true}
	];
	
	
	var dataGridroleColModel = [ 
						{
							label : 'id',
							name : 'id',
							width : 75,
							sortable : false,
							hidden : true
						}, {
							label : '<span class="remind">*</span>'+'角色名称',
							name : 'roleName',
							width : 150,
							sortable : false,
							editable : true
							
						
						}, {
							label : '<span class="remind">*</span>'+'角色编码',
							name : 'roleCode',
							width : 150,
							sortable : false,
							editable : true
							
						},  {
							label : '应用范围',
							name : 'usageModifier',
							width : 150,
							editable : true,
							formatter:formatRoleMoif,
							sortable : false,
							edittype : 'select',
							editoptions:{
							
							value:{0:'公共使用',1:'私有使用'},
							
							defaultValue:'1'
							
							}
							
						},{
							label : '角色描述',
							name : 'desc',
							width : 150,
							sortable : false,
							editable : true
							
						},{
							label : '状态',
							name : 'validFlag',
							width : 150,
							editable : true,
							sortable : false,
							formatter:formatvalidFlag,
							edittype : 'select',
							editoptions:{
							
							value:{1:'有效',0:'无效'},
							
							defaultValue:'1'
							
							}
						},{
							label : '<span class="remind">*</span>'+'排序',
							name : 'orderBy',
							width : 150,
							sortable : false,
							editable : true
						}
						];
						 
	consolerole = new ConsoleRole('jqGrid','jqGridrole','${url}','searchDialog','form','sysRole_keyWord','sysUser_keyWord',searchMainNames,searchUserMainNames,dataGridUserColModel,dataGridroleColModel);
	
	consolerole.setOnSelect(function(roleId){
	
			consolerole.loaduserByid(roleId);
			
		}).init();
	//添加按钮绑定事件
		$('#consolerole_insert').bind('click', function() {
			
			consolerole.insert();
		});
		//删除按钮绑定事件
		$('#consolerole_del').bind('click', function() {
			consolerole.del();
		});
		//保存按钮绑定事件
		$('#consolerole_save').bind('click', function() {
			consolerole.save();
		});
	
		//打开高级查询框
		$('#consolerole_searchAll').bind('click',function(){
			consolerole.openSearchForm(this);
		});
		//打开高级查询框
		$('#consolerole_search').bind('click',function(){
			consolerole.openSearchRoleForm(this);
		});
		
		

		$('#exportrole').bind('click', function() {
			consolerole.importrole();
		});
		
		
		$('#consoleuser_add').bind('click', function() {
			consolerole.insertUser();
		});


		$('#consoleuser_save').bind('click', function() {
			consolerole.saveUser();
		});
		
		
		$('#consoleuser_delete').bind('click', function() {
			consolerole.deleteUser();
		});
	
		//关键字段查询按钮绑定事件
		$('#sysRole_searchPart').bind('click', function(){
			consolerole.searchByKeyWord();
		});
			//关键字段查询按钮绑定事件
		$('#sysUser_searchPart').bind('click', function(){
			consolerole.searchUserByKeyWord();
		});

	
	
   

});



</script>
</html>