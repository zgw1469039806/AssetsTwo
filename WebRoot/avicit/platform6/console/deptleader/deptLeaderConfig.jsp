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
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_deptLeader_button_add"
				permissionDes="添加">
				<a id="deptLeader_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_deptLeader_button_save"
				permissionDes="保存">
				<a id="deptLeader_save" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="保存"><i class="fa fa-save"></i> 保存</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_deptLeader_button_del"
				permissionDes="删除">
				<a id="deptLeader_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			 <div class="input-group form-tool-search">
				<input type="text" name="search_keyWord"
					id="search_keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入员工姓名或部门名称"> <label
					id="search_icon"
					class="icon icon-search form-tool-searchicon"></label>
			</div> 
		</div>
	</div>
	<table id="deptLeaderList"></table>
	<div id="jqGridPager"></div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/console/deptleader/js/deptLeader.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var isAdmin ="<%=isAdmin%>";
	var viewScopeType = '';
	if (isAdmin == "true") {
		viewScopeType = '';
	} else {
		viewScopeType = 'currentOrg';
	}

	//后台获取的通用代码数据
	var deptLeader;
	$(document).ready(
					function() {
						var dataGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 120,
							hidden : true
						}, {
							label : 'userid',
							name : 'userId',
							width : 120,
							hidden : true
						},{
							label : '员工姓名',
							name : 'userName',
							width : 30,
							sortable:false,
							editable : true,
							edittype : 'custom',
							editoptions : {
								custom_element : userElem,
								custom_value : userValue,
								forId : 'userId',
								viewScope:viewScopeType
							}
						}, {
							label : 'deptId',
							name : 'deptId',
							width : 120,
							hidden : true
						},{
							label : '所管部门',
							name : 'deptName',
							width : 50,
                            sortable:false,
							editable : true,
							edittype : 'custom',
							editoptions : {
								custom_element : deptElem,
								custom_value : deptValue,
								forId : 'deptId',
								viewScope:viewScopeType
							}
						}];
						var searchMainNames = [];
						searchMainNames.push("userName");
						
						deptLeader = new DeptLeader('deptLeaderList', '${url}','search_keyWord',dataGridColModel,searchMainNames);
						//添加按钮绑定事件
						$('#deptLeader_insert').bind('click', function() {
							deptLeader.insert();
						});
						//删除按钮绑定事件
						$('#deptLeader_del').bind('click', function() {
							deptLeader.del();
						});
						//保存按钮绑定事件
						$('#deptLeader_save').bind('click', function() {
							deptLeader.save();
						});
						//查询按钮绑定事件
						$('#search_icon').bind('click',
								function() {
									deptLeader.searchByKeyWord();
								});
						 
						 //回车键查询
						$('#search_keyWord').on('keydown', function(e) {
							if (e.keyCode == 13) {
								deptLeader.searchByKeyWord();
							}
						}) ; 
					});
</script>
</html>