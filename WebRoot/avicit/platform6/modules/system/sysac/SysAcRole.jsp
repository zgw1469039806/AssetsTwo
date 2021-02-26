<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "test/demo/sysac/sysAcRoleController/toSysAcManage" -->
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
				domainObject="formdialog_sysAcRole_button_add" permissionDes="添加">
				<a id="sysAcRole_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysAcRole_button_allow" permissionDes="授权">
				<a id="sysAcRole_allow" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="授权"><i class="glyphicon glyphicon-ok"></i> 授权</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysAcRole_button_deny" permissionDes="禁止">
				<a id="sysAcRole_deny" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="禁止"><i class="glyphicon glyphicon-ban-circle"></i> 禁止</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysAcRole_button_delete" permissionDes="删除">
				<a id="sysAcRole_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
	</div>
	<table id="sysAcRolejqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/modules/system/sysac/js/SysAcRole.js" type="text/javascript"></script>
<script type="text/javascript">
	var sysAcRole;
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

	$(document).ready(function() {
						var dataGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : '授权对象类型(user,role,dept,org) ',
							name : 'acOrgType',
							width : 150,
							hidden : true
						}, {
							label : '角色名称',
							name : 'acOrgId',
							width : 150,
							align:'center',
						},{ 
							label: '状态', 
							name: 'status', 
							width: 150,
							align:'center',
							formatter:formatStatus
						}  ];
						var searchNames = new Array();
						var searchTips = new Array();
						var searchC = searchTips.length == 2 ? '或'
								+ searchTips[1] : "";
						sysAcRole = new SysAcRole('sysAcRolejqGrid', 'sysac/sysAcController/operation/',
								'searchDialog', 'form', 'sysAcRole_keyWord',
								searchNames, dataGridColModel,'${param.parentId}','acRole');
						//添加按钮绑定事件
						$('#sysAcRole_insert').bind('click', function() {
							sysAcRole.insert("${param.parentId}");
						});
						//授权按钮绑定事件
						$('#sysAcRole_allow').bind('click', function() {
							sysAcRole.allow();
						});
						//禁止按钮绑定事件
						$('#sysAcRole_deny').bind('click', function() {
							sysAcRole.deny();
						});
						//删除按钮绑定事件
						$('#sysAcRole_del').bind('click', function() {
							sysAcRole.del();
						});
					});
</script>
</html>