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
<!-- ControllerPath = "platfrom6/tablecol/resteasyorg/resteasyOrgController/toResteasyOrgManage" -->
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
				domainObject="formdialog_resteasyOrg_button_add" permissionDes="添加">
				<a id="resteasyOrg_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
					title="添加"><i class="icon icon-add"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_resteasyOrg_button_del" permissionDes="删除">
				<a id="resteasyOrg_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="icon icon-delete"></i> 删除</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_resteasyOrg_button_save" permissionDes="保存">
				<a id="resteasyOrg_save" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="保存"><i class="icon icon-save"></i> 保存</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="resteasyOrg_keyWord"
					id="resteasyOrg_keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="resteasyOrg_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
		</div>
	</div>
	<table id="resteasyOrgjqGrid"></table>
	<div id="jqGridPager"></div>
</body>

<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/console/newRestmanage/js/ResteasyOrg.js"
	type="text/javascript"></script>
<script type="text/javascript">
	//后台获取的通用代码数据
	var resteasyOrg;
	$(document).ready(
			function() {
				var dataGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '单位名称',
					name : 'orgName',
					width : 150,
					editable : true,
					align : "center",
					cellattr: addCellAttr
				} ];
				var searchNames = new Array();
				var searchTips = new Array();
				searchNames.push("orgName");
				searchTips.push("单位名称");
				$('#resteasyOrg_keyWord').attr('placeholder',
						'请输入' + searchTips[0] );
				resteasyOrg = new ResteasyOrg('resteasyOrgjqGrid', '${url}',
						'searchDialog', 'form', 'resteasyOrg_keyWord',
						searchNames, dataGridColModel);
				//添加按钮绑定事件
				$('#resteasyOrg_insert').bind('click', function() {
					resteasyOrg.insert();
				});
				//删除按钮绑定事件
				$('#resteasyOrg_del').bind('click', function() {
					resteasyOrg.del();
				});
				//保存按钮绑定事件
				$('#resteasyOrg_save').bind('click', function() {
					resteasyOrg.save();
				});
				//查询按钮绑定事件
				$('#resteasyOrg_searchPart').bind('click', function() {
					resteasyOrg.searchByKeyWord();
				});
				//打开高级查询框
				$('#resteasyOrg_searchAll').bind('click', function() {
					resteasyOrg.openSearchForm(this);
				});
				//回车键查询
				$('#resteasyOrg_keyWord').on('keydown', function(e) {
					if (e.keyCode == 13) {
						resteasyOrg.searchByKeyWord();
					}
				});

			});
	function addCellAttr(rowId, val, rawObject, cm, rdata) {
		     return "style='text-align:center'";
	}
</script>
</html>