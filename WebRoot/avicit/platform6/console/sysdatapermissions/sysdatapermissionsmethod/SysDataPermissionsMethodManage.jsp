<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.api.sysprofile.SysProfileAPI"%>
<%@page import="avicit.platform6.core.spring.SpringFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,tree,table,form";
	SysProfileAPI sysProfileAPI = SpringFactory.getBean(SysProfileAPI.class);
	String isOpenLog = sysProfileAPI.getProfileValueByCodeByAppId("PLATFORM_V6_DATA_PERMISSION_LOG", SessionHelper.getApplicationId());
	pageContext.setAttribute("isOpenLog", isOpenLog);
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css" />
<link rel="stylesheet" type="text/css" href="static/h5/switch/css/bootstrap-switch.css" />
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
		<div id='mdiv'>
			<ul id="consoleMenu" class="ztree"></ul>
		</div>
	</div>

	<div data-options="region:'center'">
		<div class="easyui-layout" data-options="fit:true">
			
			<div id="north1" data-options="region:'north',split:true,width:fixwidth(.5),onResize:function(a){$('#sysDataPermissionsRule').setGridWidth(a);$(window).trigger('resize');}" style="height:300px;overflow-x:hidden;">
				<div id="toolbar_sysDataPermissionsMethod" class="toolbar">
					<div class="toolbar-left">
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsMethod_button_add" permissionDes="主表添加">
							<a id="sysDataPermissionsMethod_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsMethod_button_edit" permissionDes="主表编辑">
							<a id="sysDataPermissionsMethod_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsMethod_button_delete" permissionDes="主表删除">
							<a id="sysDataPermissionsMethod_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsMethod_button_default_rule" permissionDes="默认规则维护">
							<a id="sysDataPermissionsMethod_default_rule" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="默认规则维护"><i class="fa fa-cog"></i> 默认规则维护</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsMethod_button_copyMethod" permissionDes="复制方法">
							<a id="sysDataPermissionsMethod_copy_method" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="复制方法"><i class="fa fa-copy"></i> 复制方法</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsMethod_button_log" permissionDes="数据权限日志">
							是否开启数据权限日志：<input type="checkbox" id="startLog" <c:if test="${isOpenLog eq true }">checked="checked"</c:if>/>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsMethod_button_log_select" permissionDes="数据权限日志查询">
							<a id="sysDataPermissionsMethod_log_select" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="数据权限日志查询"><i class="fa fa-search"></i> 数据权限日志查询</a>
						</sec:accesscontrollist>
					</div>
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
			
			<div id= "north2" data-options="region:'center',split:true,onResize:function(a,b){resizeSouth(a,b);}" style="padding:0px;overflow-x:hidden;">
				<div id="toolbar_sysDataPermissionsRule" class="toolbar">
					<div class="toolbar-left">
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsRule_button_add" permissionDes="子表添加">
					  		<a id="sysDataPermissionsRule_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsRule_button_edit" permissionDes="子表编辑">
							<a id="sysDataPermissionsRule_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsRule_button_delete" permissionDes="子表删除">
							<a id="sysDataPermissionsRule_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_sysDataPermissionsRule_button_copy_rule" permissionDes="复制规则">
							<a id="sysDataPermissionsRule_copy_rule" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="复制规则"><i class="fa fa-copy"></i> 复制规则</a>
						</sec:accesscontrollist>
					</div>
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
				<td width="39%">
					<select id="type" name="type" class="form-control input-sm" title="类型">
						<option value="" selected="selected"></option>
						<option value="0">普通模块</option>
						<option value="1">电子表单</option>
						<option value="2">选择页</option>
					</select>
				</td>
				<th width="10%">表名称:</th>
				<td width="39%"><input title="表名称" class="form-control input-sm" type="text" name="tableName" id="tableName" /></td>
			</tr>
			<tr>
				<th width="10%">mapper名称:</th>
				<td width="39%"><input title="mapper名称" class="form-control input-sm" type="text" name="mapperName" id="mapperName" /></td>
				<th width="10%">执行方法:</th>
				<td width="39%"><input title="执行方法" class="form-control input-sm" type="text" name="method" id="method" /></td>
			</tr>
			<tr>
				<th width="10%">选择页标识:</th>
				<td width="39%"><input title="选择页标识" class="form-control input-sm" type="text" name="selectId" id="selectId" /></td>
			</tr>
		</table>
	</form>
</div>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto; display: none">
	<form id="formSub">
		<table class="form_commonTable">
			<tr>
				<th width="10%">规则名称:</th>
				<td width="39%"><input title="规则名称"
					class="form-control input-sm" type="text" name="ruleName"
					id="ruleName" /></td>
				<th width="10%">状态:</th>
				<td width="39%">
					<select id="state" name="state" class="form-control input-sm" title="状态">
						<option value="" selected="selected"></option>
						<option value="0">有效</option>
						<option value="1">无效</option>
					</select>
				</td>
			</tr>
		</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/MenuTree.js?v=<%=System.currentTimeMillis() %>" type="text/javascript"></script>
<script src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/SysDataPermissionsMethod.js?v=<%=System.currentTimeMillis() %>" type="text/javascript"></script>
<script src="avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/js/SysDataPermissionsRule.js?v=<%=System.currentTimeMillis() %>" type="text/javascript"></script>
<script src="static/h5/switch/js/bootstrap-switch.js" charset="utf-8"></script>

<script type="text/javascript">
	var sysDataPermissionsMethod;
	var sysDataPermissionsRule;
	var menuTree;
	var menuId = "";
	var copyPageIndex;
	var isInitGrid = false;

	function formatValue(cellvalue, options, rowObject) {
		if(null != cellvalue && "" != cellvalue){
			return '<a href="javascript:void(0);" onclick="sysDataPermissionsMethod.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
		} else {
			return "";
		}
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysDataPermissionsMethod.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
	}
	function formatSubValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="subDetail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function stateFormatter(cellvalue, options, rowObject){
		if("0" == cellvalue){
			return '<input type="checkbox" name="my-checkbox" data-rowid="'+rowObject.id+'" checked />';
		} else {
			return '<input type="checkbox" name="my-checkbox" data-rowid="'+rowObject.id+'"/>';
		}
	}
	function formatTools(cellvalue, options, rowObject){
		return '<a href="javascript:void(0);" onclick="showAuthDetail(\'' + rowObject.id + '\');">权限明细</a>'
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
	
	function showAuthDetail(methodId){
		editIndex = layer.open({
		    type: 2,
		    area: ['90%', '90%'],
		    title: '查看权限明细',
		    skin: 'bs-modal',
	        maxmin: false,
		    content: "platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toShowAuthDetailPage?methodId="+methodId
		});
	}

	$(document).ready(function() {
		$('#startLog').bootstrapSwitch({
    		size:'small',
    		onText:'开启',
    		offText:'关闭',
    		onColor : "success",
    		offColor : "danger"
    	});
    	$('#startLog').on('switchChange.bootstrapSwitch', function(event, state) {
    		avicAjax.ajax({
    			url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/updatelogState",
    			data : {state:state.value},
    			type : 'get',
    			dataType : 'json',
    			async : false,
    			success : function(r){
    				if (r.flag == "success"){
    					layer.msg('设置成功！');
    				}
    			}
    		});
    	});

		var searchMainNames = new Array();
		var searchMainTips = new Array();
		searchMainNames.push("tableName");
		searchMainTips.push("表名、标识符");
		searchMainNames.push("mapperName");
		searchMainTips.push("mapper名称");
		searchMainNames.push("selectId");
		searchMainTips.push("");
		var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
		$('#sysDataPermissionsMethod_keyWord').attr('placeholder', '请输入表名、标识符或mapper');
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
		},{
			label : '类型',
			name : 'type',
			width : 50,
			sortable : false,
			formatter : formatTypeValue
		},{
			label : '表名/选择页唯一标识',
			name : 'tableName',
			width : 100,
			formatter : formatValue,
			sortable : false
		},{
			label : '表说明/选择页唯一标识说明',
			name : 'tableRemarks',
			width : 100,
			sortable : false
		},{
			label : 'mapper名称',
			name : 'mapperName',
			width : 100,
			sortable : false
		}, {
			label : '执行方法',
			name : 'method',
			width : 200,
			sortable : false
		}, {
			label : '操作',
			name : 'tools',
			width : 50,
			sortable : false,
			align:'center',
			formatter : formatTools
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
			formatter : formatSubValue,
			sortable : false
		},{
			label : '状态',
			name : 'state',
			width : 30,
			align:'center',
			formatter : stateFormatter,
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
			hidden : true
		}, {
			label : '过滤sql/自定义方法',
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
		//添加按钮绑定事件
		$('#sysDataPermissionsMethod_insert').bind('click', function() {
			// 只能在末级节点添加方法
			var treeChildren = menuTree.tree.getSelectedNodes()[0].childCount;
			if(undefined != treeChildren && treeChildren > 0){
				layer.alert("只能在末级节点添加方法！",{icon:2});
				return false;
			}
			sysDataPermissionsMethod.insert(menuId);
		});
		//编辑按钮绑定事件
		$('#sysDataPermissionsMethod_modify').bind('click', function() {
			sysDataPermissionsMethod.modify(menuId);
		});
		//删除按钮绑定事件
		$('#sysDataPermissionsMethod_del').bind('click', function() {
			sysDataPermissionsMethod.del();
		});
		//打开高级查询框
		$('#sysDataPermissionsMethod_searchAll').bind('click', function() {
			sysDataPermissionsMethod.openSearchForm(this, $('#sysDataPermissionsMethod'));
		});
		//关键字段查询按钮绑定事件
		$('#sysDataPermissionsMethod_searchPart').bind('click',function() {
			sysDataPermissionsMethod.searchByKeyWord();
		});
		//默认规则维护
		$('#sysDataPermissionsMethod_default_rule').bind('click',function() {
			editIndex = layer.open({
			    type: 2,
			    area: ['90%', '90%'],
			    title: '默认规则维护',
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		        maxmin: false, //开启最大化最小化按钮
			    content: "platform6/msystem/sysdatapermissions/sysdatapermissionsdefrule/sysDataPermissionsDefRuleController/toSysDataPermissionsDefRuleManage"
			});
		});
		//复制方法
		$('#sysDataPermissionsMethod_copy_method').bind('click',function() {
			copyPageIndex = layer.open({
			    type: 2,
			    area: ['100%', '100%'],
			    title: '复制方法（该模块主要用于复制方法对应的规则）',
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		        maxmin: false, //开启最大化最小化按钮
			    content: "platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toCopyMethodPage"
			});
		});
		//数据权限日志查询
		$('#sysDataPermissionsMethod_log_select').bind('click',function() {
			copyPageIndex = layer.open({
			    type: 2,
			    area: ['90%', '90%'],
			    title: '数据权限日志查询',
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		        maxmin: false, //开启最大化最小化按钮
			    content: "platform6/msystem/sysdatapermissions/sysdatapermissionslog/toSysDataPermissionsLogManage"
			});
		});
		//子表操作
		//添加按钮绑定事件
		$('#sysDataPermissionsRule_insert').bind('click',function() {
			var selectRow = $("#sysDataPermissionsMethod").jqGrid('getGridParam','selarrrow');
			if(selectRow.length != 1){
				layer.msg("请选择一条主表记录");
				return false;
			}
			avicAjax.ajax({
				url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/getRuleMaxNo",
				data : {methodId : selectRow[0]},
				type : 'get',
				dataType : 'json',
				async : false,
				success : function(r){
					if (r.flag == "success"){
						sysDataPermissionsRule.insert($("#sysDataPermissionsMethod").jqGrid('getRowData', selectRow[0]));
					} else {
						layer.msg("最多可维护9个规则！");
					}
				}
			});
		});
		//编辑按钮绑定事件
		$('#sysDataPermissionsRule_modify').bind('click', function() {
			var selectRow = $("#sysDataPermissionsMethod").jqGrid('getGridParam','selarrrow');
			if(selectRow.length != 1){
				layer.msg("请选择一条主表记录");
				return false;
			}
			sysDataPermissionsRule.modify($("#sysDataPermissionsMethod").jqGrid('getRowData', selectRow[0]));
		});
		//删除按钮绑定事件
		$('#sysDataPermissionsRule_del').bind('click', function() {
			sysDataPermissionsRule.del();
		});
		//打开高级查询
		$('#sysDataPermissionsRule_searchAll').bind('click', function() {
			sysDataPermissionsRule.openSearchForm(this, $('#sysDataPermissionsRule'));
		});
		//关键字段查询按钮绑定事件
		$('#sysDataPermissionsRule_searchPart').bind('click', function() {
			sysDataPermissionsRule.searchByKeyWord();
		});
		//复制规则
		$('#sysDataPermissionsRule_copy_rule').bind('click', function() {
			var selectRow = $("#sysDataPermissionsMethod").jqGrid('getGridParam','selarrrow');
			if(selectRow.length != 1){
				layer.msg("请选择一条主表记录");
				return false;
			}
			copyPageIndex = layer.open({
			    type: 2,
			    area: ['90%', '90%'],
			    title: '复制规则',
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		        maxmin: false, //开启最大化最小化按钮
			    content: "platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toCopyRulePage?methodId="+selectRow[0]
			});
		});
	});

	var subDetailIndex;
	function subDetail(subPid){
		var selectRow = $("#sysDataPermissionsMethod").jqGrid('getGridParam','selarrrow');
		if(selectRow.length != 1){
			layer.msg("请选择一条主表记录");
			return false;
		}
		subDetailIndex = layer.open({
		    type: 2,
		    area: ['90%', '90%'],
		    title: '详细页',
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
	        maxmin: false, //开启最大化最小化按钮
		    content: 'platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/subDetail/'+subPid+"?pid="+$("#sysDataPermissionsMethod").jqGrid('getRowData', selectRow[0]).id
		});
	}
	function closeSubDetailDialog(){
		layer.close(subDetailIndex);
	}
	//南侧拖拽修改改变时修改表格自适应
	function resizeSouth(width,height){
		var windowHeight = $(window).height();
		var topTableHeight = windowHeight - height
		$("#north1").height(topTableHeight);
		$('#sysDataPermissionsRule').setGridHeight(height-120);
		$('#sysDataPermissionsMethod').setGridHeight(topTableHeight-120);
	}
</script>
</html>