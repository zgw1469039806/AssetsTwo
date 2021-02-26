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
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMigrateDb_button_add" permissionDes="添加">
				<a id="sysMigrateDb_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMigrateDb_button_edit" permissionDes="编辑">
				<a id="sysMigrateDb_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMigrateDb_button_delete" permissionDes="删除">
				<a id="sysMigrateDb_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="keyWord" id="keyWord" style="width: 240px;" class="form-control input-sm" placeholder="请输入查询条件">
				<label id="sysMigrateDb_searchPart" class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="sysMigrateDbjqGrid"></table>
	<div id="jqGridPager"></div>
</body>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/migrate/migratedb/js/SysMigrateDb.js" type="text/javascript"></script>
<script type="text/javascript">
	var sysMigrateDb;
	$(document).ready(
			function() {

                var searchNames = new Array();
				var searchTips = new Array();
				searchNames.push("dbName");
				searchTips.push("数据库名称");
				searchNames.push("dbType");
				searchTips.push("数据库类型");
				$('#keyWord').attr('placeholder','请输入' + searchTips[0] + '或' + searchTips[1]);
				
				sysMigrateDb = new SysMigrateDb('sysMigrateDbjqGrid', 'keyWord', searchNames);
				//添加按钮绑定事件
				$('#sysMigrateDb_insert').on('click', function() {
					sysMigrateDb.insert();
				});
				//编辑按钮绑定事件
				$('#sysMigrateDb_modify').on('click', function() {
					sysMigrateDb.modify();
				});
				//删除按钮绑定事件
				$('#sysMigrateDb_del').on('click', function() {
					sysMigrateDb.del();
				});
				//查询按钮绑定事件
				$('#sysMigrateDb_searchPart').on('click', function() {
					sysMigrateDb.searchByKeyWord();
				});

			});
</script>
</html>