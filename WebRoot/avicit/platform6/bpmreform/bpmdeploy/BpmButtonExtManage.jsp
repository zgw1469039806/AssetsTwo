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
<!-- ControllerPath = "platform6/bpmreform/bpmdesigner/bpmbuttonext/bpmButtonExtController/toBpmButtonExtManage" -->
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
				domainObject="formdialog_bpmButtonExt_button_add" permissionDes="添加">
				<a id="bpmButtonExt_insert" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
					title="添加"><i class="fa fa-plus"></i> 添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_bpmButtonExt_button_edit"
				permissionDes="编辑">
				<a id="bpmButtonExt_modify" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_bpmButtonExt_button_delete"
				permissionDes="删除">
				<a id="bpmButtonExt_del" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="删除"><i class="fa fa-trash-o"></i> 删除</a>
			</sec:accesscontrollist>
		</div>
		<div class="toolbar-right">
			<div class="input-group form-tool-search">
				<input type="text" name="bpmButtonExt_keyWord"
					id="bpmButtonExt_keyWord" style="width:240px;"
					class="form-control input-sm" placeholder="请输入查询条件"> <label
					id="bpmButtonExt_searchPart"
					class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="bpmButtonExt_searchAll" href="javascript:void(0)"
					class="btn btn-defaul btn-sm" role="button">高级查询 <span
					class="caret"></span></a>
			</div>
		</div>
	</div>
	<table id="bpmButtonExtjqGrid"></table>
	<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">编码:</th>
				<td width="39%"><input title="编码"
					class="form-control input-sm" type="text" name="code"
					id="code" /></td>
				<th width="10%">默认名称:</th>
				<td width="39%"><input title="默认名称"
					class="form-control input-sm" type="text"
					name="dName" id="dName" /></td>
			</tr>
			<tr>
				<th width="10%">自定义名称:</th>
				<td width="39%"><input title="按钮名称，即自定义名称，优先使用"
					class="form-control input-sm" type="text" name="name"
					id="name" /></td>
				<th width="10%">是否全局按钮:</th>
				<td width="39%"><select id="isGlobal" name="isGlobal" class="form-control input-sm" title=""
							data-options="" style="">
						  <option value="">请选择</option>
						  <option value="1">是</option>
						  <option value="0">否</option>
						</select>
				</td>
			</tr>
			<tr>
				<th width="10%">是否平台按钮:</th>
				<td colspan="3">
					<select id="isPlatform" name="isPlatform" class="form-control input-sm" title=""
							data-options="" style="" >
						  <option value="">请选择</option>
						  <option value="0">否</option>
						  <option value="1">是</option>
					</select>
			    </td>
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
	src="avicit/platform6/bpmreform/bpmdeploy/js/BpmButtonExt.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var bpmButtonExt;
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="bpmButtonExt.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="bpmButtonExt.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}

	function formatYesNo(cellvalue, options, rowObject){
		var html = "";
		if('1'==cellvalue){
			html = '是';
		}else{
			html = '否';
		}
		return html;

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
							name : 'code',
							width : 150,
							formatter : formatValue
						}, {
							label : '默认名称',
							name : 'dName',
							width : 150
						}, {
							label : '自定义名称',
							name : 'name',
							width : 150
						}, {
							label : '排序',
							name : 'order',
							width : 150
						}, {
							label : 'js方法名称',
							name : 'jsfunction',
							width : 150
						}, {
							label : '是否全局按钮',
							name : 'isGlobal',
							width : 150,
							formatter : formatYesNo
						}, {
							label : '是否平台按钮',
							name : 'isPlatform',
							width : 150,
							formatter : formatYesNo
						}, {
							label : '是否在设计器配置',
							name : 'isDesign',
							width : 150,
							formatter : formatYesNo
						}
						/*,{
							label : '是否常用按钮',
							name : 'isCommonly',
							width : 150,
							formatter : formatYesNo
						}*/
						];
						var searchNames = new Array();
						var searchTips = new Array();
						searchNames.push("code");
						searchTips.push("编码");
						searchNames.push("dName");
						searchTips.push("默认名称");
						var searchC = searchTips.length == 2 ? '或'
								+ searchTips[1] : "";
						$('#bpmButtonExt_keyWord').attr('placeholder',
								'请输入' + searchTips[0] + searchC);
						bpmButtonExt = new BpmButtonExt('bpmButtonExtjqGrid',
								'${url}', 'searchDialog', 'form',
								'bpmButtonExt_keyWord', searchNames,
								dataGridColModel);
						//添加按钮绑定事件
						$('#bpmButtonExt_insert').bind('click', function() {
							bpmButtonExt.insert();
						});
						//编辑按钮绑定事件
						$('#bpmButtonExt_modify').bind('click', function() {
							bpmButtonExt.modify();
						});
						//删除按钮绑定事件
						$('#bpmButtonExt_del').bind('click', function() {
							bpmButtonExt.del();
						});
						//查询按钮绑定事件
						$('#bpmButtonExt_searchPart').bind('click', function() {
							bpmButtonExt.searchByKeyWord();
						});
						//打开高级查询框
						$('#bpmButtonExt_searchAll').bind('click', function() {
							bpmButtonExt.openSearchForm(this);
						});

					});
</script>
</html>
