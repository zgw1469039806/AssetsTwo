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
<!-- ControllerPath = "platfrom6/tablecol/searchconnection/searchConnectionController/toSearchConnectionManage" -->
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
				domainObject="formdialog_searchConnection_button_add"
				permissionDes="添加">
				<a id="searchConnection_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_searchConnection_button_edit"
				permissionDes="编辑">
				<a id="searchConnection_modify" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_searchConnection_button_delete"
				permissionDes="删除">
				<a id="searchConnection_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-left">
			<div class="input-group form-tool-search">
				<input type="text" name="keyWord" id="keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入数据库名称"> <label
					id="searchConnection_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="searchConnectionjqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">CONNECTION_NAME:</th>
				<td width="88%"><input title="CONNECTION_NAME"
					class="form-control input-sm" type="text" name="connectionName"
					id="connectionName" /></td>
			</tr>
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
	src="avicit/platform6/modules/system/newsearch/js/SearchConnection.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var searchConnection;
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="searchConnection.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}

	$(document).ready(
			function() {
				var dataGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '数据库名称',
					name : 'connectionName',
					width : 150,
					sortable:false
				},
				{
					label : '数据库地址',
					name : 'connectionUrl',
					width : 150,
					sortable:false
				}, {
					label : '数据库用户',
					name : 'connectionUsername',
					width : 150,
					sortable:false
				}, {
					label : '数据库密码',
					name : 'connectionPassword',
					width : 150,
					hidden : true,
					sortable:false
				}, {
					label : '数据库驱动',
					name : 'connectionDriver',
					width : 150,
					sortable:false
				}  ];
				var searchNames = new Array();
				var searchTips = new Array();
				searchNames.push("connectionName");
				searchTips.push("CONNECTION_NAME");
				searchConnection = new SearchConnection(
						'searchConnectionjqGrid', '${url}', 'searchDialog',
						'form', 'keyWord', searchNames, dataGridColModel);
				//添加按钮绑定事件
				$('#searchConnection_insert').bind('click', function() {
					searchConnection.insert();
				});
				//编辑按钮绑定事件
				$('#searchConnection_modify').bind('click', function() {
					searchConnection.modify();
				});
				//删除按钮绑定事件
				$('#searchConnection_del').bind('click', function() {
					searchConnection.del();
				});
				//查询按钮绑定事件
				$('#searchConnection_searchPart').bind('click', function() {
					searchConnection.searchByKeyWord();
				});
				//打开高级查询框
				$('#searchConnection_searchAll').bind('click', function() {
					searchConnection.openSearchForm(this);
				});

			});
</script>
</html>