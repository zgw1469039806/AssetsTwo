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
<!-- ControllerPath = "train/form/sysmigratetask/sysMigrateTaskController/toSysMigrateTaskManage" -->
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
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMigrateTask_button_add" permissionDes="数据源配置">
				<a id="setDataSource" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="数据源配置"><i class="iconfont icon-setting"></i> 数据源配置</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMigrateTask_button_edit" permissionDes="模块配置">
				<a id="setModel" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="模块配置"><i class="iconfont icon-setting"></i> 模块配置</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysMigrateTask_button_delete" permissionDes="任务配置">
				<a id="setTask" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="任务配置"><i class="iconfont icon-setting"></i> 任务配置</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="keyWord" id="keyWord" style="width: 240px;"class="form-control input-sm" placeholder="请输入查询条件">
				<label id="sysMigrateTask_searchPart" class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="sysMigrateTaskjqGrid"></table>
	<div id="jqGridPager"></div>
</body>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<style type="text/css">
	.toolbar-left a i{
		font-size:14px;
	}
</style>
<script src="avicit/platform6/migrate/migratetask/js/SysMigrateTask.js" type="text/javascript"></script>
<script type="text/javascript">
	var sysMigrateTask;

	$(document).ready(
			function() {
				var searchNames = new Array();
				var searchTips = new Array();
				searchNames.push("name");
				searchTips.push("名称");
				$('#keyWord').attr('placeholder','请输入' + searchTips[0]);
				
				sysMigrateTask = new SysMigrateTask('sysMigrateTaskjqGrid', 'keyWord',searchNames);

                //数据源配置按钮绑定事件
                $('#setDataSource').on('click', function() {
                    sysMigrateTask.setDataSource();
                });
				//模块配置按钮绑定事件
				$('#setModel').on('click', function() {
					sysMigrateTask.setModel();
				});
				//任务配置按钮绑定事件
				$('#setTask').on('click', function() {
                    sysMigrateTask.setTask();
				});
				//查询按钮绑定事件
				$('#sysMigrateTask_searchPart').bind('click', function() {
					sysMigrateTask.searchByKeyWord();
				});

			});
</script>
</html>