<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,tree,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "ttt/bpmcatalog/bpmCatalogController/toBpmCatalogManage" -->
<title>结束流程实例</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmmonitor/css/style.css"/>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
}

.ztree-submenu {
	border: 1px solid #959595;
	position: fixed !important;
	background: #FFF !important;
	z-index: 1;
}

.ztree-submenu:before {
	position: absolute;
	width: 36px;
	height: 100%;
	left: 0;
	top: 0;
	background-color: #e7e8e8;
	z-index: 1;
	display: block;
	content: ' ';
}

.ztree-submenu a {
	color: #454545;
	font-size: 14px;
	border: 0;
	background: none;
	line-height: 14px;
	padding: 8px 15px 8px 45px;
	z-index: 2;
}

.ztree-submenu a:hover {
	background-color: #cbeef5;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div style="border-top-style: hidden;"
		data-options="region:'west',split:true,width:fixwidth(.3),onResize:function(a){$('#demoSubUser').setGridWidth(a);$(window).trigger('resize');}">
		<div class="row" style="margin: 5px;">

			<div>
				<ul id="treeDemo" class="ztree"></ul>
			</div>
		</div>
	</div>
	<div
		data-options="region:'center',onResize:function(a){$('#demoMainDept').setGridWidth(a);$(window).trigger('resize');}">
		<div id="toolbar_bpmProcinst" class="toolbar">
			<div class="toolbar-left">

				<sec:accesscontrollist hasPermission="3"
					domainObject="bpmProcinst_button_del" permissionDes="删除">
					<a id="bpmProcinst_button_del" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
						title="删除"><i class="icon icon-delete"></i> 删除</a>
				</sec:accesscontrollist>

			</div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search">
					<input type="text" name="bpmProcinst_keyWord"
						id="bpmProcinst_keyWord" style="width:240px;"
						class="form-control input-sm" placeholder="请输入查询条件"> <label
						id="bpmProcinst_searchPart"
						class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="bpmProcinst_searchAll" href="javascript:void(0)"
						class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询
						<span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="bpmProcinst"></table>
		<div id="bpmProcinstPager"></div>
	</div>
</body>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
		<input type="hidden" name="deptid" id="deptid" />
		<table class="form_commonTable">
			<tr>
				<th width="18%">流程实例ID：</th>
				<td width="30%"><input title="流程实例ID"
					class="form-control input-sm" type="text" name="entryid"
					id="entryid" /></td>
				<th width="18%">流程实例名称：</th>
				<td width="30%"><input title="流程实例名称"
					class="form-control input-sm" type="text" name="entryname"
					id="entryname" /></td>
			</tr>
			<tr>
				<th width="15%">流程定义名称：</th>
				<td width="30%"><input title="流程定义名称"
					class="form-control input-sm" type="text" name="definename"
					id="definename" /></td>
				<th width="15%">创建者：</th>
				<td width="30%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="userid" name="userid">
						<input class="form-control" placeholder="请选择用户" type="text"
							id="receptUserName" name="receptUserName"> <span
							class="input-group-addon" id="userbtn"> <i
							class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="15%">开始时间：</th>
				<td width="30%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="startDateBegin" id="startDateBegin" /><span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="15%">结束时间：</th>
				<td width="30%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text"
							name="startDateEnd" id="startDateEnd" /><span
							class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>

			</tr>

		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmmonitor/js/BpmCatalogTree.js"
	type="text/javascript"></script>
<script src="avicit/platform6/bpmreform/bpmmonitor/js/BpmProcinst.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
	var bpmCatalog;
	var bpmProcinst;
	function getOptButtons(cellvalue, options, rowObject) {
		return '<a id="bpmProcinst_Variable" href="javascript:void(0)" class="glyphicon glyphicon-th"'
		+'  title="流程变量" onClick="processVariable(\''+rowObject.entryid+'\')"> </a>';
	}

	function getTraceButtons(cellvalue, options, rowObject){
		//return '<a id="bpmProcinst_trace" href="javascript:void(0)" class="glyphicon glyphicon-search flow-icon-big"'
		//+'  title="流程跟踪" onClick="processTrace(\''+rowObject.entryid+'\')"> </a>';
		return '<a href="javascript:window.processTrace(\''+rowObject.entryid+'\')">'+rowObject.entryid+'</a>';
	}

	function processTrace(entryid){
		bpmProcinst.processTrace(entryid);
	}

	function getWorkitemButton(cellvalue, options, rowObject){
		//return '<a href="javascript:window.viewWorkitem(\''+rowObject.entryid+'\',\''+rowObject.executionid+'\',\''+rowObject.state+'\')">'+cellvalue+'</a>';
		return '<a href="javascript:void(0)" title="工作项管理" class="icon iconfont icon-gongzuoxiang" onClick="viewWorkitem(\''+rowObject.entryid+'\',\''+rowObject.executionid+'\',\''+rowObject.state+'\')"></a>';
	}

	function viewWorkitem(entryId,executionid,state){
		var url = "avicit/platform6/bpmreform/bpmmonitor/workitem.jsp";
		url += "?processInstanceId="+entryId+"&executionid="+executionid+"&state="+state+"&isHistory=1";
		workitemDialog = layer.open({
	        type: 2,
	        title: '工作项信息',
	        skin: 'bs-modal',
	        area: ['100%', '100%'],
	        maxmin: false,
	        content:url
	       });
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="bpmProcinst.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
	}

	function processVariable(processInstanceId){
		bpmProcinst.processVariable(processInstanceId);
	}


	function bpm_operator_refresh(){
		bpmCatalog.clickNode();
	}

	$(document).ready(function() {
		var searchSubNames = new Array();
		var searchSubTips = new Array();
		searchSubNames.push("entryid");
		searchSubTips.push("流程实例ID");
		$('#bpmProcinst_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
		var bpmProcinstGridColModel = [
			{
				label : 'executionid',
				name : 'executionid',
				key : true,
				hidden : true
			}
			, {
				label : '流程实例ID',
				width : 100,
				sortable : false,
				formatter : getTraceButtons
			},
			{
				label:'entryid',
				name : 'entryid',
				hidden : true
			}
			, {
				label : '流程实例名称',
				name : 'entryname',
				width : 40,
				align : 'left',
				sortable : false
			}
			, {
				label : '流程定义名称',
				name : 'definename',
				width : 60,
				align : 'left',
				sortable : false
			}
			,{
				label : '状态',
				name : 'state',
				hidden : true
			}
			, {
				label : '创建者',
				name : 'userid',
				width : 40,
				align : 'left',
				sortable : false
			}
			, {
				label : '启动时间',
				name : 'startdate',
				width : 50,
				align : 'left',
				sortable : false,
				formatter : function(value, rec) {
					var startdateMi = value;
					if (startdateMi == undefined) {
						return '';
					}
					var newDate = new Date(startdateMi);
					return newDate.format("yyyy-MM-dd hh:mm:ss");
				}
			}
			, {
				label : '结束时间',
				name : 'enddate',
				width : 50,
				align : 'left',
				editor : 'text',
				sortable : false,
				formatter : function(value, rec) {
					var endateMi = value;
					if (endateMi == undefined) {
						return '';
					}
					var newDate = new Date(endateMi);
					return newDate.format("yyyy-MM-dd hh:mm:ss");
				}
			}
			, {
				label : '工作项管理',
				name : 'trace',
				width : 30,
				align : 'center',
				sortable : false,
				formatter : getWorkitemButton
			}
		];

		bpmCatalog = new BpmCatalogTree('treeDemo', 'bpm/monitor/getFlowModelTree?console=true', '', '', '',
			function(pid, nodeType,pdId) {
				bpmProcinst = new BpmProcinst('bpmProcinst', 'bpm/monitor/getPrcessInstListByPage?isRunning=0', "formSub", bpmProcinstGridColModel, 'searchDialogSub', pid, nodeType, searchSubNames, "bpmProcinst_keyWord",pdId);
			},
			function(pid, nodeType,pdId) {
				bpmProcinst.reLoad(pid, nodeType,pdId);
			}
		);



		//删除按钮绑定事件
		$('#bpmProcinst_button_del').bind('click', function() {
			bpmProcinst.del();
		});


		//打开高级查询
		$('#bpmProcinst_searchAll').bind('click', function() {
			bpmProcinst.openSearchForm(this, $('#bpmProcinst'));
		});
		//关键字段查询按钮绑定事件
		$('#bpmProcinst_searchPart').bind('click', function() {
			bpmProcinst.searchByKeyWord();
		});

		$('#receptUserName').on('focus', function(e) {
			new H5CommonSelect({
				type : 'userSelect',
				idFiled : 'userid',
				textFiled : 'receptUserName',
				viewScope : 'currentOrg'
			});
		});


	});
</script>
</html>
