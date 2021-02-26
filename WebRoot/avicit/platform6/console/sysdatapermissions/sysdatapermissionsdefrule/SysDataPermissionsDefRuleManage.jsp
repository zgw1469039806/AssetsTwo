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
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysDataPermissionsDefRule_button_add"
				permissionDes="添加">
				<a id="sysDataPermissionsDefRule_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysDataPermissionsDefRule_button_edit"
				permissionDes="编辑">
				<a id="sysDataPermissionsDefRule_modify" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_sysDataPermissionsDefRule_button_delete"
				permissionDes="删除">
				<a id="sysDataPermissionsDefRule_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="sysDataPermissionsDefRule_keyWord"
					id="sysDataPermissionsDefRule_keyWord" style="width: 240px;"
					class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="sysDataPermissionsDefRule_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="sysDataPermissionsDefRule_searchAll"
					href="javascript:void(0)" class="btn btn-defaul btn-sm"
					role="button">高级查询 <span class="caret"></span></a>
			</div>
		</div>
	</div>
	<table id="sysDataPermissionsDefRulejqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">规则名称:</th>
				<td width="39%"><input title="规则名称"
					class="form-control input-sm" type="text" name="ruleName"
					id="ruleName" /></td>
				<th width="10%">规则描述:</th>
				<td width="39%"><input title="规则描述"
					class="form-control input-sm" type="text" name="ruleRemarks"
					id="ruleRemarks" /></td>
			</tr>
		</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsdefrule/js/SysDataPermissionsDefRule.js?v=<%=System.currentTimeMillis() %>" type="text/javascript"></script>
<script type="text/javascript">
	var sysDataPermissionsDefRule;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="sysDataPermissionsDefRule.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysDataPermissionsDefRule.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}

	$(document).ready(function() {
						var dataGridColModel = [ {
							label : 'id',
							name : 'id',
							key : true,
							width : 75,
							hidden : true
						}, {
							label : '规则名称',
							name : 'ruleName',
							width : 100,
							formatter : formatValue,
                            sortable : false
						},  {
							label : '规则描述',
							name : 'ruleRemarks',
							width : 150,
                            sortable : false
						}, {
							label : '相邻匹配符',
							name : 'matchSymbol',
							width : 40,
                            sortable : false
						}, {
							label : '过滤条件',
							name : 'filterCondition',
							width : 150,
                            sortable : false
						}, {
							label : '过滤条件SQL',
							name : 'filterConditionSql',
							width : 150,
                            sortable : false
						},{
							label : '状态',
							name : 'state',
							width : 50,
                            sortable : false
						}];
						var searchNames = new Array();
						var searchTips = new Array();
						searchNames.push("ruleName");
						searchTips.push("规则名称");
						var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
						$('#sysDataPermissionsDefRule_keyWord').attr(
								'placeholder', '请输入' + searchTips[0] + searchC);
						sysDataPermissionsDefRule = new SysDataPermissionsDefRule(
								'sysDataPermissionsDefRulejqGrid', '${url}',
								'searchDialog', 'form',
								'sysDataPermissionsDefRule_keyWord',
								searchNames, dataGridColModel);
						//添加按钮绑定事件
						$('#sysDataPermissionsDefRule_insert').bind('click',
								function() {
									sysDataPermissionsDefRule.insert();
								});
						//编辑按钮绑定事件
						$('#sysDataPermissionsDefRule_modify').bind('click',
								function() {
									sysDataPermissionsDefRule.modify();
								});
						//删除按钮绑定事件
						$('#sysDataPermissionsDefRule_del').bind('click',
								function() {
									sysDataPermissionsDefRule.del();
								});
						//查询按钮绑定事件
						$('#sysDataPermissionsDefRule_searchPart')
								.bind(
										'click',
										function() {
											sysDataPermissionsDefRule
													.searchByKeyWord();
										});
						//打开高级查询框
						$('#sysDataPermissionsDefRule_searchAll').bind(
								'click',
								function() {
									sysDataPermissionsDefRule
											.openSearchForm(this);
								});

					});
</script>

<script type="text/javascript">
	function isIE() {
	 	if (!!window.ActiveXObject || "ActiveXObject" in window){
			return true;
	 	} else {
			return false;
	 	}
	}
	if(isIE()){
		$("body").width("99%");
	}
</script>

</html>