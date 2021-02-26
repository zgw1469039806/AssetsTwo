<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "SysDatatablesController/SysDatatablesInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/sfn/SelfDefiningQuery.js" type="text/javascript"></script>

<!-- 自定义列属性-->
<script src="static/js/platform/component/common/userDefinedColumnTools.js?a=444112" type="text/javascript"></script>

<script type="text/javascript">
	var path="<%=ViewUtil.getRequestPath(request)%>";

	var sysDatatables;
	var sysDatatableColumns;

	$(function() {
		sysDatatables = new SysDatatables('dgSysDatatables', '${url}',
				'searchDialog', 'sysDatatables');

		sysDatatables.setOnLoadSuccess(function() {
			sysDatatableColumns = new SysDatatableColumns(
					'dgsysDatatableColumns', '${surl}');
		});
		sysDatatables.setOnSelectRow(function(rowIndex, rowData, id) {
			sysDatatableColumns.loadByPid(id);
		});

		sysDatatables.init();

		var array = [];

		var searchObject = {
			name : '用户ID',
			field : 'USER_ID',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);

		var searchObject = {
			name : '模块名',
			field : 'TABLE_NAME',
			type : 1,
			dataType : 'string'
		};
		array.push(searchObject);
		///

		selfDefQury.init(array);
		selfDefQury.setQuery(function(param) {
			sysDatatables.searchDataBySfn(param);
		});

		document.body.style.visibility = 'visible';
	});
	function formateDate(value, row, index) {
		return sysDatatables.formate(value);
	}
	function formateDateTime(value, row, index) {
		return sysDatatables.formateDateTime(value);
	}
	//sysDatatables.detail(\''+row.id+'\')
	function formateHref(value, row, inde) {
		return '<a href="javascript:void(0);" onclick="sysDatatables.detail(\''
				+ row.id + '\');">' + value + '</a>';
	}

	function formatDisplay(value, row, index) {
		return value == "true" ? "是" : "否";
	}

	// 删除
	function deleteDtoToRedis() {
		var rows = $("#dgSysDatatables").datagrid('getChecked');
		var l = rows.length;
		var ids = [];
		if (l > 0) {
			$.messager.confirm('请确认','您确定要删除当前所选的数据？',function(b) {
				if (b) {
					for (; l--;) {
						ids.push(rows[l].id);
					}
					$.ajax({
								url : "platform/SysDatatablesController/deleteDtoToRedisById",
								data : JSON.stringify(ids),
								contentType : 'application/json',
								type : 'post',
								dataType : 'json',
								success : function(callBack) {
									if ("success" == callBack.flag) {
										$.messager.show({
											title : '提示',
											msg : '删除成功！'
										});
										$("#dgSysDatatables").datagrid('load',{});
										$("#dgSysDatatables").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
									} else if (callBack.flag == "failure") {
										$.messager.show({ title : '提示', msg : callBack.error });
									}
								}
						});
				}
			});
		} else {
			$.messager.alert('提示', '请选择要删除的记录！', 'warning');
		}
	}

	// 刷新缓存
	function refresh() {
		$.ajax({
			url : "platform/SysDatatablesController/refresh",
			type : 'post',
			contentType : 'application/json',
			dataType : 'json',
			async : false,
			success : function(callBack) {
				if ("success" == callBack.flag) {
					$.messager.show({
						title : '提示',
						msg : '刷新成功！'
					});
					$("#dgSysDatatables").datagrid('load', {});
				} else if (callBack.flag == "failure") {
					$.messager.show({
						title : '提示',
						msg : callBack.error
					});
				}
			}
		});
	}
</script>

</head>

<body class="easyui-layout" fit="true" style="visibility: hidden;">

	<div data-options="region:'north',split:true"
		style="height: 260px; padding: 0px;">
		<div id="toolbarSysDatatables" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysDatatables_button_query"
						permissionDes="主表查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="sysDatatables.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>

					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysDatatables_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="deleteDtoToRedis();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>

					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysDatatables_button_refresh"
						permissionDes="刷新缓存">
						<td><a class="easyui-linkbutton" iconCls="icon-reload"
							plain="true" onclick="refresh();" href="javascript:void(0);">刷新缓存</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgSysDatatables"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarSysDatatables',
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">主键</th>
					<th data-options="field:'userName', align:'center'" width="220">用户</th>
					<th data-options="field:'tableName', align:'center'" width="220">模块名</th>
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'center',split:true" style="padding: 0px;">

		<div id="toolbarsysDatatableColumns" class="datagrid-toolbar">
			<table>
				<tr></tr>
			</table>
		</div>
		<table id='dgsysDatatableColumns' class="easyui-datagrid"
			data-options="
    		fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField :'id',
			toolbar:'#toolbarsysDatatableColumns',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			method:'get',
			pagination:true,
            pageSize:dataOptions.pageSize,
            pageList:dataOptions.pageList,
			striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">主键</th>

					<th data-options="field:'columnLabel', align:'center'" width="220">标题</th>

					<th data-options="field:'columnField', align:'center'" width="220">列字段</th>

					<th data-options="field:'columnWidth', align:'center'" width="220">列宽</th>

					<th
						data-options="field:'columnShow', align:'center' ,formatter:formatDisplay"
						width="220">是否显示</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="width: 550px; height: 160px; display: none;">
		<form id="sysDatatables">
			<table class="form_commonTable">
				<tr>
					<th width="10%">用户:</th>
					<td width="40%"><input class="easyui-validatebox"
						readonly="readonly" style="width: 151px;" type="text"
						name="userName" id="userName" /> <input type="hidden" id="userId"
						name="userId">
						</div></td>
					<th width="10%">模块名:</th>
					<td width="40%"><input class="easyui-validatebox"
						style="width: 151px;" type="text" name="tableName" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns" class="datagrid-toolbar foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td align="right"><a class="easyui-linkbutton primary-btn"
						iconCls="" plain="false" onclick="sysDatatables.searchData();"
						href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="sysDatatables.clearData();"
						href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
						iconCls="" plain="false" onclick="sysDatatables.hideSearchForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>


	<script
		src=" avicit/platform6/modules/system/sysdatatables/js/SysDatatables.js"
		type="text/javascript"></script>
	<script
		src=" avicit/platform6/modules/system/sysdatatables/js/SysDatatableColumns.js"
		type="text/javascript"></script>

	<script type="text/javascript">
		$(function() {
			// 选人
			var deptCommonSelector = new CommonSelector("user", "userSelectCommonDialog", "userId", "userName", null, null, null, true, null, null, "600", "250");
			deptCommonSelector.init();
		});
	</script>
</body>
</html>