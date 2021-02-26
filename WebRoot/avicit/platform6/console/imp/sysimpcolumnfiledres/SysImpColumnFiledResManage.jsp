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
<!-- ControllerPath = "platform6/msystem/imp/sysimpcolumnfiledres/sysImpColumnFiledResController/toSysImpColumnFiledResManage" -->
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
				domainObject="formdialog_sysImpColumnFiledRes_button_add"
				permissionDes="添加">
				<a id="sysImpColumnFiledRes_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysImpColumnFiledRes_button_edit"
				permissionDes="编辑">
				<a id="sysImpColumnFiledRes_modify" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysImpColumnFiledRes_button_delete"
				permissionDes="删除">
				<a id="sysImpColumnFiledRes_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="sysImpColumnFiledRes_keyWord"
					id="sysImpColumnFiledRes_keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="sysImpColumnFiledRes_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="sysImpColumnFiledRes_searchAll" href="javascript:void(0)"
					class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span
					class="caret"></span></a>
			</div>
		</div>
	</div>
	<table id="sysImpColumnFiledResjqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">sheetId:</th>
				<td width="39%"><input title="sheetId"
					class="form-control input-sm" type="text" name="sheetid"
					id="sheetid" /></td>
				<th width="10%">列标题:</th>
				<td width="39%"><input title="列标题"
					class="form-control input-sm" type="text" name="columnTitle"
					id="columnTitle" /></td>
			</tr>
			<tr>
				<th width="10%">列序号:</th>
				<td width="39%"><input title="列序号"
					class="form-control input-sm" type="text" name="columnIndex"
					id="columnIndex" /></td>
				<th width="10%">字段属性:</th>
				<td width="39%"><input title="字段属性"
					class="form-control input-sm" type="text" name="field" id="field" />
				</td>
			</tr>
			<tr>
				<th width="10%">字段名称:</th>
				<td width="39%"><input title="字段名称"
					class="form-control input-sm" type="text" name="fieldDesc"
					id="fieldDesc" /></td>
				<th width="10%">是否必填:</th>
				<td width="39%"><input title="是否必填"
					class="form-control input-sm" type="text" name="required"
					id="required" /></td>
			</tr>
			<tr>
				<th width="10%">备注:</th>
				<td width="39%"><input title="备注" class="form-control input-sm"
					type="text" name="remark" id="remark" /></td>
				<th width="10%">格式校验 1：数值 2：日期 3:邮箱 4：手机 5：ip地址:</th>
				<td width="39%"><input title="格式校验 1：数值 2：日期 3:邮箱 4：手机 5：ip地址"
					class="form-control input-sm" type="text" name="checkType"
					id="checkType" /></td>
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
	src="avicit/platform6/modules/system/imp/sysimpcolumnfiledres/js/SysImpColumnFiledRes.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var sysImpColumnFiledRes;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="sysImpColumnFiledRes.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysImpColumnFiledRes.detail(\''
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
							label : 'sheetId',
							name : 'sheetid',
							width : 150,
							formatter : formatValue
						}, {
							label : '列标题',
							name : 'columnTitle',
							width : 150
						}, {
							label : '列序号',
							name : 'columnIndex',
							width : 150
						}, {
							label : '字段属性',
							name : 'field',
							width : 150
						}, {
							label : '字段名称',
							name : 'fieldDesc',
							width : 150
						}, {
							label : '是否必填',
							name : 'required',
							width : 150
						}, {
							label : '备注',
							name : 'remark',
							width : 150
						}, {
							label : '格式校验 1：数值 2：日期 3:邮箱 4：手机 5：ip地址',
							name : 'checkType',
							width : 150
						} ];
						var searchNames = new Array();
						var searchTips = new Array();
						searchNames.push("sheetid");
						searchTips.push("sheetId");
						searchNames.push("columnTitle");
						searchTips.push("列标题");
						var searchC = searchTips.length == 2 ? '或'
								+ searchTips[1] : "";
						$('#sysImpColumnFiledRes_keyWord').attr('placeholder',
								'请输入' + searchTips[0] + searchC);
						sysImpColumnFiledRes = new SysImpColumnFiledRes(
								'sysImpColumnFiledResjqGrid', '${url}',
								'searchDialog', 'form',
								'sysImpColumnFiledRes_keyWord', searchNames,
								dataGridColModel);
						//添加按钮绑定事件
						$('#sysImpColumnFiledRes_insert').bind('click',
								function() {
									sysImpColumnFiledRes.insert();
								});
						//编辑按钮绑定事件
						$('#sysImpColumnFiledRes_modify').bind('click',
								function() {
									sysImpColumnFiledRes.modify();
								});
						//删除按钮绑定事件
						$('#sysImpColumnFiledRes_del').bind('click',
								function() {
									sysImpColumnFiledRes.del();
								});
						//查询按钮绑定事件
						$('#sysImpColumnFiledRes_searchPart').bind('click',
								function() {
									sysImpColumnFiledRes.searchByKeyWord();
								});
						//打开高级查询框
						$('#sysImpColumnFiledRes_searchAll').bind('click',
								function() {
									sysImpColumnFiledRes.openSearchForm(this);
								});

					});
</script>
</html>