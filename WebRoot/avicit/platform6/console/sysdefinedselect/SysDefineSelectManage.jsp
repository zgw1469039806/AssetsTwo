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
<!-- ControllerPath = "createdefineselect/sysdefineselect/sysDefineSelectController/toSysDefineSelectManage" -->
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
				domainObject="formdialog_sysDefineSelect_button_add"
				permissionDes="添加">
				<a id="sysDefineSelect_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
					title="添加"><i class="icon icon-add"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysDefineSelect_button_edit"
				permissionDes="编辑">
				<a id="sysDefineSelect_modify" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="编辑"><i class="icon icon-edit"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysDefineSelect_button_delete"
				permissionDes="删除">
				<a id="sysDefineSelect_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="icon icon-delete"></i> 删除</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysDefineSelect_button_test"
				permissionDes="测试">
				<a id="sysDefineSelect_test" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="测试"><i class="icon icon-monishiyong"></i> 模拟使用</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="sysDefineSelect_keyWord"
					id="sysDefineSelect_keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="sysDefineSelect_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="sysDefineSelect_searchAll" href="javascript:void(0)"
					class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span
					class="caret"></span></a>
			</div>
		</div>
	</div>
	<table id="sysDefineSelectjqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">编码:</th>
				<td width="39%"><input title="编码" class="form-control input-sm"
					type="text" name="code_" id="code_" /></td>
			  <th width="12%">是否系统标识:</th>
				<td width="37%"><pt6:h5select css_class="form-control input-sm"
						name="sign_" id="sign_" title="是否系统标识" isNull="true"
						lookupCode="PLATFORM_SYS_SIGN" /></td>
			</tr>
			<!-- <tr>
				<th width="10%">sql语句:</th>
				<td width="39%"><textarea class="form-control input-sm"
						rows="3" title="sql语句" name="sql_" id="sql_"></textarea></td>
				<th width="10%">是否系统标识:</th>
				
			</tr> -->
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
	src="avicit/platform6/console/sysdefinedselect/js/SysDefineSelect.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var sysDefineSelect;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="sysDefineSelect.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function unformatValue(cellvalue, options, cell) {
		return cellvalue;
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysDefineSelect.detail(\''
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
							label : '编码',
							name : 'code_',
							width : 150,
							formatter : formatValue,
							unformat : unformatValue
						}, {
							label : '是否系统标识',
							name : 'sign_',
							align:"center",
							width : 150
						},{
							label : 'sql语句',
							name : 'sql_',
							width : 150
						}, {
							label : '描述',
							name : 'des_',
							width : 150
						}];
						var searchNames = new Array();
						var searchTips = new Array();
						searchNames.push("code_");
						searchTips.push("编码");
						searchNames.push("des_");
						searchTips.push("描述");
						var searchC = searchTips.length == 2 ? '或'
								+ searchTips[1] : "";
						$('#sysDefineSelect_keyWord').attr('placeholder',
								'请输入' + searchTips[0] + searchC);
						sysDefineSelect = new SysDefineSelect(
								'sysDefineSelectjqGrid', '${url}',
								'searchDialog', 'form',
								'sysDefineSelect_keyWord', searchNames,
								dataGridColModel);
						//添加按钮绑定事件
						$('#sysDefineSelect_insert').bind('click', function() {
							sysDefineSelect.insert();
						});
						//编辑按钮绑定事件
						$('#sysDefineSelect_modify').bind('click', function() {
							sysDefineSelect.modify();
						});
						//删除按钮绑定事件
						$('#sysDefineSelect_del').bind('click', function() {
							sysDefineSelect.del();
						});
						//测试按钮绑定事件
						$('#sysDefineSelect_test').bind('click', function() {
							sysDefineSelect.test();
						});
						//查询按钮绑定事件
						$('#sysDefineSelect_searchPart').bind('click',
								function() {
									sysDefineSelect.searchByKeyWord();
								});
						//打开高级查询框
						$('#sysDefineSelect_searchAll').bind('click',
								function() {
									sysDefineSelect.openSearchForm(this);
								});

					});
</script>
</html>