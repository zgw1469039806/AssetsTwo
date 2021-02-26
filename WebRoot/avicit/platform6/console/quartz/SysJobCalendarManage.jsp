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
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div id="centerpanel" data-options="region:'center',split:true,height:fixheight(.5),onResize:function(a){$('#sysJobCalendar').setGridWidth(a);$('#sysJobCalendar').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}"  >
		<div id="toolbar_sysJobCalendar" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysJobCalendar_button_add"
					permissionDes="主表添加">
					<a id="sysJobCalendar_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysJobCalendar_button_edit"
					permissionDes="主表编辑">
					<a id="sysJobCalendar_modify" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
<%-- 				<sec:accesscontrollist hasPermission="3" --%>
<%-- 					domainObject="formdialog_sysJobCalendar_button_return" permissionDes="返回"> --%>
<!-- 					<a id="sysJobCalendar_return" href="javascript:void(0)" -->
<!-- 						class="btn btn-default form-tool-btn btn-sm" role="button" -->
<!-- 						title="返回"> 返回</a> -->
<%-- 				</sec:accesscontrollist> --%>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysJobCalendar_button_delete"
					permissionDes="主表删除">
					<a id="sysJobCalendar_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
		</div>
		<table id="sysJobCalendar"></table>
		<div id="sysJobCalendarJqGridPager"></div>
	</div>
	<div id="panelnorth" data-options="region:'south',split:true,split:true,height:fixheight(.5),onResize:function(a){$('#sysJobCalendarDate').setGridWidth(a);$('#sysJobCalendarDate').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
		<div id="toolbar_sysJobCalendarDate" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysJobCalendarDate_button_add"
					permissionDes="子表添加">
					<a id="sysJobCalendarDate_insert" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysJobCalendarDate_button_delete"
					permissionDes="子表删除">
					<a id="sysJobCalendarDate_del" href="javascript:void(0)"
						class="btn btn-default form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
		</div>
		<table id="sysJobCalendarDate"></table>
		<div id="sysJobCalendarDateJqGridPager"></div>
	</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/quartz/SysJobCalendar.js" type="text/javascript"></script>
<script src="avicit/platform6/console/quartz/SysJobCalendarDate.js" type="text/javascript"></script>
<script type="text/javascript">
var sysJobCalendar;
var sysJobCalendarDate;
$(document).ready(function() {
			var sysJobCalendarGridColModel = [ {
				label : 'id',
				name : 'id',
				key : true,
				width : 75,
				hidden : true
			}, {
				label : '名称',
				name : 'name',
				width : 150
			}, {
				label : '描述',
				name : 'description',
				width : 150
			}, {
				label : '创建日期',
				name : 'createDate',
				width : 150,
				formatter : format
			}, {
				label : '创建人',
				name : 'createUser',
				width : 150
			}, {
				label : '更新日期',
				name : 'updateDate',
				width : 150,
				formatter : format
			}, {
				label : '更新人',
				name : 'updateUser',
				width : 150
			} ];
			var sysJobCalendarDateGridColModel = [ {
				label : 'id',
				name : 'id',
				key : true,
				width : 75,
				hidden : true
			}, {
				label : '任务日历主键',
				name : 'jobCalendarId',
				width : 150,
				hidden : true
			}, {
				label : '排除的日期',
				name : 'excludedDate',
				width : 150,
				formatter : format
			}, {
				label : '描述',
				name : 'description',
				width : 150
			} ];

			sysJobCalendar = new SysJobCalendar(
					'sysJobCalendar',
					'${url}',
					'form',
					sysJobCalendarGridColModel,
					'searchDialog',
					function(pid) {
						sysJobCalendarDate = new SysJobCalendarDate(
								'sysJobCalendarDate', '${surl}',
								"formSub",
								sysJobCalendarDateGridColModel,
								'searchDialogSub', pid);
					}, function(pid) {
						sysJobCalendarDate.reLoad(pid);
					});
			//主表操作
			//添加按钮绑定事件
			$('#sysJobCalendar_insert').bind('click', function() {
				sysJobCalendar.insert();
			});
			//编辑按钮绑定事件
			$('#sysJobCalendar_modify').bind('click', function() {
				sysJobCalendar.modify();
			});
			//删除按钮绑定事件
			$('#sysJobCalendar_del').bind('click', function() {
				sysJobCalendar.del();
			});
			//打开高级查询框
			$('#sysJobCalendar_searchAll').bind(
					'click',
					function() {
						sysJobCalendar.openSearchForm(this,
								$('#sysJobCalendar'));
					});
			//关键字段查询按钮绑定事件
			$('#sysJobCalendar_searchPart').bind('click',
					function() {
						sysJobCalendar.searchByKeyWord();
					});
			//子表操作
			//添加按钮绑定事件
			$('#sysJobCalendarDate_insert').bind('click',
					function() {
						sysJobCalendarDate.insert();
					});
			//编辑按钮绑定事件
			$('#sysJobCalendarDate_modify').bind('click',
					function() {
						sysJobCalendarDate.modify();
					});
			//删除按钮绑定事件
			$('#sysJobCalendarDate_del').bind('click', function() {
				sysJobCalendarDate.del();
			});
			$('#sysJobCalendar_return').bind('click',function() {
				parent.closeCalendarDialog();
			});
});
</script>
</html>