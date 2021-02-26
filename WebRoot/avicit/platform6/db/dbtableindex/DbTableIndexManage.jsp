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
<!-- ControllerPath = "platform6/db/dbtableindex/dbTableIndexController/toDbTableIndexManage" -->
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
				domainObject="formdialog_dbTableIndex_button_add" permissionDes="添加">
				<a id="dbTableIndex_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_dbTableIndex_button_del" permissionDes="删除">
				<a id="dbTableIndex_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_dbTableIndex_button_save"
				permissionDes="保存">
				<a id="dbTableIndex_save" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="保存"><i class="fa fa-save"></i> 保存</a>
			</sec:accesscontrollist>
		</div>
		
	</div>
	<table id="dbTableIndexjqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">表外键ID:</th>
				<td width="39%"><input title="表外键ID"
					class="form-control input-sm" type="text" name="tableId"
					id="tableId" /></td>
				<th width="10%">索引英文名称:</th>
				<td width="39%"><input title="索引英文名称"
					class="form-control input-sm" type="text" name="indexName"
					id="indexName" /></td>
			</tr>
			<tr>
				<th width="10%">索引类型，默认为normal:</th>
				<td width="39%"><input title="索引类型，默认为normal"
					class="form-control input-sm" type="text" name="indexType"
					id="indexType" /></td>
				<th width="10%">索引列:</th>
				<td width="39%"><input title="索引列"
					class="form-control input-sm" type="text" name="indexCol"
					id="indexCol" /></td>
			</tr>
			<tr>
				<th width="10%">应用ID:</th>
				<td width="39%"><input title="应用ID"
					class="form-control input-sm" type="text" name="sysApplicationId"
					id="sysApplicationId" /></td>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/db/dbtableindex/js/DbTableIndex.js"
	type="text/javascript"></script>
<script type="text/javascript">
	//后台获取的通用代码数据
	var dbTableIndex;
	$(document).ready(
			function() {
				var dataGridColModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '表外键ID',
					name : 'tableId',
					width : 150,
					editable : true
				}, {
					label : '索引英文名称',
					name : 'indexName',
					width : 150,
					editable : true
				}, {
					label : '索引类型id',
					name : 'indexType',
					width : 75,
					hidden : true
				},{
					label : '索引类型',
					name : 'indexTypeName',
					width : 150,
					editable : true,
					edittype : "custom",
					editoptions : {
						custom_element : selectElem,
						custom_value : selectValue,
						forId : 'indexType',
						value : {"Normal":"Normal","Unique":"Unique","Bitmap":"Bitmap"}
					}
				}, {
					label : '索引列',
					name : 'indexCol',
					width : 150,
					editable : true
				}, {
					label : '应用ID',
					name : 'sysApplicationId',
					width : 150,
					editable : true,
					hidden:true
				} ];
				var searchNames = new Array();
				var searchTips = new Array();
				searchNames.push("tableId");
				searchTips.push("表外键ID");
				searchNames.push("indexName");
				searchTips.push("索引英文名称");
				$('#dbTableIndex_keyWord').attr('placeholder',
						'请输入' + searchTips[0] + '或' + searchTips[1]);
				dbTableIndex = new DbTableIndex('dbTableIndexjqGrid', '${url}',
						'searchDialog', 'form', 'dbTableIndex_keyWord',
						searchNames, dataGridColModel);
				//添加按钮绑定事件
				$('#dbTableIndex_insert').bind('click', function() {
					dbTableIndex.insert();
				});
				//删除按钮绑定事件
				$('#dbTableIndex_del').bind('click', function() {
					dbTableIndex.del();
				});
				//保存按钮绑定事件
				$('#dbTableIndex_save').bind('click', function() {
					dbTableIndex.save();
				});
				//查询按钮绑定事件
				$('#dbTableIndex_searchPart').bind('click', function() {
					dbTableIndex.searchByKeyWord();
				});
				//打开高级查询框
				$('#dbTableIndex_searchAll').bind('click', function() {
					dbTableIndex.openSearchForm(this);
				});
				//回车键查询
				$('#dbTableIndex_keyWord').on('keydown', function(e) {
					if (e.keyCode == 13) {
						dbTableIndex.searchByKeyWord();
					}
				});

			});
</script>
</html>