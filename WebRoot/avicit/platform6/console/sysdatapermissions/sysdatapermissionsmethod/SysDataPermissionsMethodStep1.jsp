<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,tree,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>步骤</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css" />
</head>
<body class="easyui-layout">

	<div data-options="region:'west',split:true" style="width: 250px; border-top-style: hidden;">
		<div id="tableToolbarM" class="toolbar">
			<div class="toolbar-left">
				<div class="input-group  input-group-sm">
					<input class="form-control" placeholder="输入菜单名称查询" type="text" id="txt" name="txt"> <span class="input-group-btn">
						<button id="searchbtn" class="btn btn-default" type="button">
							<span class="glyphicon glyphicon-search"></span>
						</button>
					</span>
				</div>
			</div>
		</div>
		<div id='mdiv' style="overflow: auto;">
			<ul id="consoleMenu" class="ztree"></ul>
		</div>
	</div>

	<div data-options="region:'center'">
		<div class="easyui-layout" data-options="fit:true">
			
			<div id="north1" data-options="region:'north',split:true,width:fixwidth(.5),onResize:function(a){$('#sysDataPermissionsRule').setGridWidth(a);$(window).trigger('resize');}" style="height:230px;overflow-x:hidden;">
				<div id="toolbar_sysDataPermissionsMethod" class="toolbar">
					<div class="toolbar-right">
						<div class="input-group form-tool-search" style="width: 200px">
							<input type="text" name="sysDataPermissionsMethod_keyWord"
								id="sysDataPermissionsMethod_keyWord" style="width: 200px;"
								class="form-control input-sm" placeholder="请输入查询条件"> <label
								id="sysDataPermissionsMethod_searchPart"
								class="icon icon-search form-tool-searchicon"></label>
						</div>
						<div class="input-group-btn form-tool-searchbtn">
							<a id="sysDataPermissionsMethod_searchAll"
								href="javascript:void(0)" class="btn btn-defaul btn-sm"
								role="button">高级查询 <span class="caret"></span></a>
						</div>
					</div>
				</div>
				<table id="sysDataPermissionsMethod"></table>
				<div id="sysDataPermissionsMethodPager"></div>
			</div>
			
			<div id= "north2" data-options="region:'center',split:true" style="padding:0px;overflow-x:hidden;">
				<div id="toolbar_sysDataPermissionsRule" class="toolbar">
					<div class="toolbar-right">
						<div class="input-group form-tool-search" style="width: 200px">
							<input type="text" name="sysDataPermissionsRule_keyWord"
								id="sysDataPermissionsRule_keyWord" style="width: 200px;"
								class="form-control input-sm" placeholder="请输入查询条件"> <label
								id="sysDataPermissionsRule_searchPart"
								class="icon icon-search form-tool-searchicon"></label>
						</div>
						<div class="input-group-btn form-tool-searchbtn">
							<a id="sysDataPermissionsRule_searchAll" href="javascript:void(0)"
								class="btn btn-defaul btn-sm" role="button">高级查询 <span
								class="caret"></span></a>
						</div>
					</div>
				</div>
				<table id="sysDataPermissionsRule"></table>
				<div id="sysDataPermissionsRulePager"></div>
			</div>
			
		</div>
	</div>

</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form">
		<table class="form_commonTable">
			<tr>
				<th width="10%">类型:</th>
				<td width="39%"><input title="类型"
					class="form-control input-sm" type="text" name="type" id="type" />
				</td>
				<th width="10%">表名称:</th>
				<td width="39%"><input title="表名称"
					class="form-control input-sm" type="text" name="tableName"
					id="tableName" /></td>
			</tr>
			<tr>
				<th width="10%">mapper名称:</th>
				<td width="39%"><input title="mapper名称"
					class="form-control input-sm" type="text" name="mapperName"
					id="mapperName" /></td>
				<th width="10%">执行方法:</th>
				<td width="39%"><input title="执行方法"
					class="form-control input-sm" type="text" name="method" id="method" />
				</td>
			</tr>
		</table>
	</form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto; display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid" />
		<table class="form_commonTable">
			<tr>
				<th width="10%">规则名称:</th>
				<td width="39%"><input title="规则名称"
					class="form-control input-sm" type="text" name="ruleName"
					id="ruleName" /></td>
				<th width="10%">状态:</th>
				<td width="39%"><input title="状态"
					class="form-control input-sm" type="text" name="status" id="status" />
				</td>
			</tr>
		</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/MenuTree.js?v=<%=System.currentTimeMillis() %>" type="text/javascript"></script>
<script src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/SysDataPermissionsMethodCopy.js?v=<%=System.currentTimeMillis() %>" type="text/javascript"></script>
<script src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/SysDataPermissionsRuleCopy.js?v=<%=System.currentTimeMillis() %>" type="text/javascript"></script>

<script type="text/javascript">
	function getFormData(){
		var selectRow = $("#sysDataPermissionsMethod").jqGrid('getGridParam','selarrrow');
		if(selectRow.length != 1){
			layer.msg("请选择一条记录");
			return false;
		}
		return $("#sysDataPermissionsMethod").jqGrid('getRowData', selectRow[0]);
	}

	var sysDataPermissionsMethod;
	var sysDataPermissionsRule;
	var menuTree;
	var menuId = "";
	var copyPageIndex;
	var isInitGrid = false;

	function stateFormatter(cellvalue, options, rowObject){
		if("0" == cellvalue){
			return '有效';
		} else {
			return '无效';
		}
	}
	function formatTypeValue(cellvalue, options, rowObject){
		if("0" == cellvalue){
			return '普通模块';
		} else if("1" == cellvalue){
			return '电子表单';
		} else {
			return '选择页';
		}
	}
	
	$(document).ready(function() {
		var searchMainNames = new Array();
		var searchMainTips = new Array();
		searchMainNames.push("tableName");
		searchMainTips.push("表名/标识符");
		searchMainNames.push("mapperName");
		searchMainTips.push("mapper名称");
		searchMainNames.push("selectId");
		searchMainTips.push("");
		var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
		$('#sysDataPermissionsMethod_keyWord').attr('placeholder', '请输入表名/标识符或mapper');
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		searchSubNames.push("ruleName");
		searchSubTips.push("规则名称");
		var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
		$('#sysDataPermissionsRule_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
		var sysDataPermissionsMethodGridColModel = [{
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		}, {
			label : '表名/选择页唯一标识',
			name : 'tableName',
			width : 100,
            sortable : false
		}, {
			label : '表说明/选择页唯一标识说明',
			name : 'tableRemarks',
			width : 100,
            sortable : false
		}, {
			label : '类型',
			name : 'type',
			width : 50,
			formatter : formatTypeValue,
            sortable : false
		}, {
			label : 'mapper名称',
			name : 'mapperName',
			width : 100,
            sortable : false
		}, {
			label : '执行方法',
			name : 'method',
			width : 250,
            sortable : false
		}];
		var sysDataPermissionsRuleGridColModel = [{
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		}, {
			label : '标识符',
			name : 'identifier',
			width : 20,
			align:'center',
            sortable : false
		},{
			label : '规则名称',
			name : 'ruleName',
			width : 60,
            sortable : false
		},{
			label : '状态',
			name : 'state',
			width : 30,
			formatter:stateFormatter,
			align:'center',
            sortable : false
		},{
			label : '相邻匹配符',
			name : 'matchSymbol',
			align:'center',
			width : 35,
            sortable : false
		}, {
			label : '过滤条件',
			name : 'filterCondition',
			width : 100,
            sortable : false
		}, {
			label : '过滤sql',
			name : 'filterConditionSql',
			width : 150,
            sortable : false
		}];
		
		//菜单树初始化
		menuTree = new MenuTree('consoleMenu',' ${urlMenu}/console/${params}','','txt','searchbtn');
		menuTree.setOnSelect(function(treeNode) {
			menuId=treeNode.id;
			if(isInitGrid==true){
				sysDataPermissionsMethod.reloadDataByMenuId(menuId);
			} else {
				isInitGrid = true;
				sysDataPermissionsMethod = new SysDataPermissionsMethod('sysDataPermissionsMethod','${url}','form', sysDataPermissionsMethodGridColModel,'searchDialog',function(pid) {
					sysDataPermissionsRule = new SysDataPermissionsRule('sysDataPermissionsRule','${surl}', "formSub",sysDataPermissionsRuleGridColModel,'searchDialogSub', pid,searchSubNames,"sysDataPermissionsRule_keyWord");
				}, function(pid) {
					sysDataPermissionsRule.reLoad(pid);
				}, searchMainNames, "sysDataPermissionsMethod_keyWord",menuId);
			}
		}).init();

		//主表操作
		//打开高级查询框
		$('#sysDataPermissionsMethod_searchAll').bind('click', function() {
			sysDataPermissionsMethod.openSearchForm(this, $('#sysDataPermissionsMethod'));
		});
		//关键字段查询按钮绑定事件
		$('#sysDataPermissionsMethod_searchPart').bind('click',function() {
			sysDataPermissionsMethod.searchByKeyWord();
		});
		//打开高级查询
		$('#sysDataPermissionsRule_searchAll').bind('click', function() {
			sysDataPermissionsRule.openSearchForm(this, $('#sysDataPermissionsRule'));
		});
		//关键字段查询按钮绑定事件
		$('#sysDataPermissionsRule_searchPart').bind('click', function() {
			sysDataPermissionsRule.searchByKeyWord();
		});
	});
</script>
</html>