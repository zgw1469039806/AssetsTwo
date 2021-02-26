<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "avicit/platform6/bootstrapmsecure/mobileuserlog/controller/NewMobileUserLogController/toMobileUserLogManage" -->
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
<%-- 
		<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_mobileUserLog_button_add"
				permissionDes="添加">
				<a id="mobileUserLog_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_mobileUserLog_button_edit"
				permissionDes="编辑">
				<a id="mobileUserLog_modify" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_mobileUserLog_button_delete"
				permissionDes="删除">
				<a id="mobileUserLog_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist> --%>
		</div>
		<div class="toolbar-right">
			<!-- <div class="input-group form-tool-search">
				<input type="text" name="mobileUserLog_keyWord"
					id="mobileUserLog_keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="mobileUserLog_searchPart"
					class="icon icon-search form-tool77799-searchicon"></label>
			</div> -->
			<div class="input-group-btn form-tool-searchbtn">
				<a id="mobileUserLog_searchAll" href="javascript:void(0)"
					class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span
					class="caret"></span></a>
			</div>
		</div>
	</div>
	<table id="mobileUserLogjqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">用户ID:</th>
				<td width="39%"><input title="用户ID"
					class="form-control input-sm" type="text" name="userId" id="userId" />
				</td>
				<th width="10%">设备ID:</th>
				<td width="39%"><input title="设备ID"
					class="form-control input-sm" type="text" name="deviceId"
					id="deviceId" /></td>
			</tr>
			<tr>
				<th width="10%">版本ID:</th>
				<td width="39%"><input title="版本ID"
					class="form-control input-sm" type="text" name="appVersionId"
					id="appVersionId" /></td>
				<th width="10%">日志类型:</th>
				<td width="39%"><input title="日志类型"
					class="form-control input-sm" type="text" name="type" id="type" />
				</td>
			</tr>
			<tr>
				<th width="3%"><label>从日期:</label></th>
				<td width="20%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="startTime" id="startTime1" /><span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="3%"><label>到日期:</label></th>
				<td width="20%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="startTime" id="endTime1" /><span class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
			</tr>
	<%-- 		<tr>
				<th width="10%">OP_CONTENT:</th>
				<td width="39%"><input title="OP_CONTENT"
					class="form-control input-sm" type="text" name="opContent"
					id="opContent" /></td>
				<th width="10%">是否归档：归档，未归档:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="isArchive" id="isArchive" title="是否归档：归档，未归档" isNull="true"
						lookupCode="IS_ARCHIVE" /></td>
			</tr> --%>
			<tr>
			</tr>
		</table>
	</form>
</div>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script
	src="avicit/platform6/mobile/bootstrapmsecure/mobileuserlog/js/MobileUserLog.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var mobileUserLog;
	function formateDateTime(value, row, index) {
		return mobileUserLog.formateDateTime(value);
	}
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mobileUserLog.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="mobileUserLog.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}

	$(document)
			.ready(
					function() {
						var dataGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : '用户ID',
							name : 'userId',
							width : 150
						}, {
							label : '设备ID',
							name : 'deviceId',
							width : 150
						}, {
							label : '版本ID',
							name : 'appVersionId',
							width : 150
						}, {
							label : '日志类型',
							name : 'type',
							width : 150
						}, {
							label : 'OP_CONTENT',
							name : 'opContent',
							width : 150,
							hidden : true
						}, {
							label : '是否归档：归档，未归档',
							name : 'isArchive',
							width : 150,
							hidden : true
						} ,{
							label : '时间',
							width : 150,
							formatter :formateDateTime
						}];
						var searchNames = new Array();
						var searchTips = new Array();
						searchNames.push("userId");
						searchTips.push("用户ID");
						searchNames.push("deviceId");
						searchTips.push("设备ID");
						var searchC = searchTips.length == 2 ? '或'
								+ searchTips[1] : "";
						$('#mobileUserLog_keyWord').attr('placeholder',
								'请输入' + searchTips[0] + searchC);
						mobileUserLog = new MobileUserLog(
								'mobileUserLogjqGrid', '${url}',
								'searchDialog', 'form',
								'mobileUserLog_keyWord', searchNames,
								dataGridColModel);
						$('.date-picker').datepicker();
						$('.time-picker').datetimepicker({
							closeText : '确定',//关闭按钮文案
							oneLine : true,//单行显示时分秒
							showButtonPanel : true,//是否展示功能按钮面板
							showSecond : false,//是否可以选择秒，默认否
							beforeShow : function(selectedDate) {
								if ($('#' + selectedDate.id).val() == "") {
									$(this).datetimepicker("setDate", new Date());
									$('#' + selectedDate.id).val('');
								}
							}
						});
						//禁止手动输入时间
						$('.date-picker').on('keydown', nullInput);
						$('.time-picker').on('keydown', nullInput);
						//添加按钮绑定事件
						$('#mobileUserLog_insert').bind('click', function() {
							mobileUserLog.insert();
						});
						//编辑按钮绑定事件
						$('#mobileUserLog_modify').bind('click', function() {
							mobileUserLog.modify();
						});
						//删除按钮绑定事件
						$('#mobileUserLog_del').bind('click', function() {
							mobileUserLog.del();
						});
						//查询按钮绑定事件
						$('#mobileUserLog_searchPart').bind('click',
								function() {
									mobileUserLog.searchByKeyWord();
								});
						//打开高级查询框
						$('#mobileUserLog_searchAll').bind('click', function() {
							mobileUserLog.openSearchForm(this);
						});
						

					});
</script>
</html>