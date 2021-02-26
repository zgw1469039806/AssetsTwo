<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String tab = request.getParameter("tab");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程实例信息</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/browserSupportedTest.js"></script>
</head>

<script type="text/javascript">
	var baseurl = '<%=ViewUtil.getRequestPath(request)%>';
	var tabSelectedIndex = "0"; //那个标签被选中

	/**
	 * 初始化页面参数
	 */
	function init() {
		var tab = '<%=tab%>';
		if (tab != "undefind" && tab != "" && tab != "null") {
			if (tab != "Todo") {
				$("#instance"+tab+"_startDateBegin").datebox("setValue", '<%=startDate%>'); 
				$("#instance"+tab+"_startDateEnd").datebox("setValue", '<%=endDate%>');
			}
			if (tab == "Start") {
				$('#myProcessTab').tabs("select", 0);
			}
			if (tab == "Todo") {
				$('#myProcessTab').tabs("select", 1);
			}
			if (tab == "Finish") {
				$('#myProcessTab').tabs("select", 2);
			}
		}
	}

	/**
	 * 点击树节点操作
	 */
	function clickTree(node) {
		expand();
		var nodeType = node.attributes.nodeType;
		if (nodeType != null && nodeType == "catalog") {
			$('#instanceStart_catalogId').val(node.id);
			$('#instanceStart_pdId').val("");
			$('#instanceTodo_catalogId').val(node.id);
			$('#instanceTodo_pdId').val("");
			$('#instanceFinish_catalogId').val(node.id);
			$('#instanceFinish_pdId').val("");
		} else if (nodeType != null && nodeType == "process") {
			$('#instanceStart_catalogId').val("");
			$('#instanceStart_pdId').val(node.id);
			$('#instanceTodo_catalogId').val("");
			$('#instanceTodo_pdId').val(node.id);
			$('#instanceFinish_catalogId').val("");
			$('#instanceFinish_pdId').val(node.id);
		}

		if (tabSelectedIndex == "0") {
			searchInstanceStart();
		} else if (tabSelectedIndex == "1") {
			searchInstanceTodo();
		} else if (tabSelectedIndex == "2") {
			searchInstanceFinish();
		}
	}
	/**
	 * 展开树节点操作
	 */
	function expand() {
		var node = $('#mytree').tree('getSelected');
		if (node) {
			$('#mytree').tree('expand', node.target);
		} else {
			$('#mytree').tree('expandAll');
		}
	}
	/////////////////////////////////////////////////////////////////////////////////
	/**
	 * 我启动的流程实例查询
	 */
	function searchInstanceStart() {
		var startDateBegin = $('#instanceStart_startDateBegin').datetimebox('getValue');
		var startDateEnd = $('#instanceStart_startDateEnd').datetimebox('getValue');
		
		var definename = $('#instanceStart_definename').val();
		var entryName = $('#instanceStart_entryName').val();
		var state = $('#instanceStart_state').combobox('getValue');
		
		var catalogId = $('#instanceStart_catalogId').val();
		var pdId = $('#instanceStart_pdId').val();
		
		var queryParams = {
			catalogId : catalogId,
			startDateBegin : startDateBegin,
			startDateEnd : startDateEnd,
			pdId : pdId,
			definename : definename,
			entryName : entryName,
			state : state
		};
		$("#instanceStartDiv").datagrid("uncheckAll").datagrid("unselectAll").datagrid("clearSelections");
		$("#instanceStartDiv").datagrid("load", queryParams);
	}
	/**
	 * 清空我启动的流程实例查询条件
	 */
	function clearInstanceStart() {
		//$('#instanceStart_catalogId').val('');
		
		$('#instanceStart_definename').val('');
		$('#instanceStart_entryName').val('');
		$('#instanceStart_state').combobox("setValue", "");
		
		$('#instanceStart_startDateBegin').datebox("setValue", "");
		$('#instanceStart_startDateEnd').datebox("setValue", "");
		//$('#instanceStart_pdId').val('');
	}
	/**
	 * 流程跟踪
	 */
	function trackBpm(processInstanceId) {
		$.ajax({
			type : "POST",
			data : {processInstanceId: processInstanceId},
			url : "platform/bpm/clientbpmdisplayaction/isUserSecretLevel", 
			dataType : "json",
			success : function(r) {
				var b = r.result;
				if(b){
					var url = getPath2() + "/avicit/platform6/bpmclient/bpm/ProcessTrack.jsp";
					if(!myBrowserSupported.isBrowserSupported()){
						url = getPath2()+"/avicit/platform6/bpmclient/bpm/ProcessTrack_bak.jsp";
					}
					url += "?processInstanceId=" + processInstanceId;
					window.open(encodeURI(url), "流程图", "scrollbars=no,status=yes,resizable=no,top=0,left=0,width=700,height=400");
				}else{
					$.messager.alert('提示','人员密级不符合要求，无法打开！');
				}
			}
		});
	}
	//////////////////////////////////////////////////////////////////////////////
	/**
	 * 我处理中的流程实例查询
	 */
	function searchInstanceTodo() {
		var startDateBegin = $('#instanceTodo_startDateBegin').datetimebox('getValue');
		var startDateEnd = $('#instanceTodo_startDateEnd').datetimebox('getValue');
		var catalogId = $('#instanceTodo_catalogId').val();
		
		var definename = $('#instanceTodo_definename').val();
		var entryName = $('#instanceTodo_entryName').val();
		var createUserId = $('#instanceTodo_createUserId').val();
		var createDeptId = $('#instanceTodo_createDeptId').val();
		
		var pdId = $('#instanceTodo_pdId').val();
		
		var queryParams = {
			catalogId : catalogId,
			startDateBegin : startDateBegin,
			startDateEnd : startDateEnd,
			pdId : pdId,
			definename : definename,
			entryName : entryName,
			createUserId : createUserId,
			createDeptId : createDeptId
		};
		$("#instanceTodoDiv").datagrid("uncheckAll").datagrid("unselectAll").datagrid("clearSelections");
		$("#instanceTodoDiv").datagrid("load", queryParams);
	}
	/**
	 * 清空我处理中的流程实例查询条件
	 */
	function clearInstanceTodo() {
		//$('#instanceTodo_catalogId').val('');
		$('#instanceTodo_startDateBegin').datebox("setValue", "");
		$('#instanceTodo_startDateEnd').datebox("setValue", "");
		
		$('#instanceTodo_definename').val("");
		$('#instanceTodo_entryName').val("");
		$('#instanceTodo_createUserId').val("");
		$('#instanceTodo_createUserName').val("");
		$('#instanceTodo_createDeptId').val("");
		$('#instanceTodo_createDeptName').val("");
		
		//$('#instanceTodo_pdId').val('');
	}
	//////////////////////////////////////////////////////////////////////////////
	/**
	 * 我经办过流程实例查询
	 */
	function searchInstanceFinish() {
		var startDateBegin = $('#instanceFinish_startDateBegin').datetimebox('getValue');
		var startDateEnd = $('#instanceFinish_startDateEnd').datetimebox('getValue');
		var catalogId = $('#instanceFinish_catalogId').val();
		var pdId = $('#instanceFinish_pdId').val();
		
		var definename = $('#instanceFinish_definename').val();
		var entryName = $('#instanceFinish_entryName').val();
		var state = $('#instanceFinish_state').combobox("getValue");
		var createUserId = $('#instanceFinish_createUserId').val();
		var createDeptId = $('#instanceFinish_createDeptId').val();
		
		var queryParams = {
			catalogId : catalogId,
			startDateBegin : startDateBegin,
			startDateEnd : startDateEnd,
			pdId : pdId,
			definename : definename,
			entryName : entryName,
			state : state,
			createUserId : createUserId,
			createDeptId : createDeptId
		};
		$("#instanceFinishDiv").datagrid("uncheckAll").datagrid("unselectAll").datagrid("clearSelections");
		$("#instanceFinishDiv").datagrid("load", queryParams);
			
	}
	/**
	 * 清空我经办过流程实例条件
	 */
	function clearInstanceFinish() {
		//$('#instanceFinish_catalogId').val('');
		$('#instanceFinish_startDateBegin').datebox("setValue", "");
		$('#instanceFinish_startDateEnd').datebox("setValue", "");
		
		$('#instanceFinish_definename').val("");
		$('#instanceFinish_entryName').val("");
		$('#instanceFinish_state').combobox("setValue", "");
		$('#instanceFinish_createUserId').val("");
		$('#instanceFinish_createUserName').val("");
		$('#instanceFinish_createDeptId').val("");
		$('#instanceFinish_createDeptName').val("");
		
		//$('#instanceFinish_pdId').val('');
	}
	
	
	$(function(){
		$('#mytree').tree({
			checkbox : false,
			lines : true,
			method : 'post',
			animate : true,
			url : 'platform/bpm/clientbpmdisplayaction/getProcessStartTree.json?id=root',
			onBeforeExpand : function(node, param) {
				$('#mytree').tree('options').url = "platform/bpm/clientbpmdisplayaction/getProcessStartTree.json?id=" + node.id;
			},
			onClick : function(node) {
				clickTree(node);
			},
			onLoadSuccess : function(node, data){
				if(node == null){
					expand();
				}
			}
		});
		var comSelector1 = new CommonSelector("user","userSelectCommonDialog","instanceTodo_createUserId","instanceTodo_createUserName",null,null,null,null,null,null,600,400);
		comSelector1.init(null, null, 'n'); //选择人员  回填部门 */
		
		var comSelector2 = new CommonSelector("user","userSelectCommonDialog","instanceFinish_createUserId","instanceFinish_createUserName",null,null,null,null,null,null,600,400);
		comSelector2.init(null, null, 'n'); //选择人员  回填部门 */

		var comSelector3 = new CommonSelector("dept","deptSelectCommonDialog","instanceTodo_createDeptId","instanceTodo_createDeptName",null,null,null,null,null,null,600,400);
		comSelector3.init(null, null, 'n'); //选择人员  回填部门 */

		var comSelector4 = new CommonSelector("dept","deptSelectCommonDialog","instanceFinish_createDeptId","instanceFinish_createDeptName",null,null,null,null,null,null,600,400);
		comSelector4.init(null, null, 'n'); //选择人员  回填部门 */
	});
</script>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',title:'流程业务目录',split:false" style="width:200px;">
		<ul id="mytree" style="width:100%;height:100%"></ul>
	</div>
	<div data-options="region:'center',split:true,border:false">
		<div class="easyui-tabs" fit="true" id="myProcessTab" data-options="onSelect:selectMyTab">
			<div title="我发起的流程" style="padding:3px;">
				<div class="easyui-layout" fit="true">
					<div id="d1" data-options="region:'north',split:false,border:false" style="height:90px">
						<fieldset>
							<legend>查询条件</legend>
							<input type="hidden" name="catalogId" id="instanceStart_catalogId" /> <input type="hidden" name="pdId" id="instanceStart_pdId" />
							<table class="tableForm">
								<tr>
									<td style="width:70px">定义名称：</td>
									<td style="width:160px"><input id="instanceStart_definename" class="easyui-validatebox" style="width:150px;" /></td>
									<td style="width:70px">实例名称：</td>
									<td style="width:160px"><input id="instanceStart_entryName" class="easyui-validatebox" style="width:150px;" /></td>
									<td style="width:70px">流转状态：</td>
									<td style="width:160px"><select id="instanceStart_state" class="easyui-combobox" style="width:150px;" data-options="editable:false">
											<option value="">全部</option>
											<option value="active">流转中</option>
											<option value="ended">结束</option>
											<option value="suspended">挂起</option>
									</select></td>
								</tr>
								<tr>
									<td style="width:70px">开始时间：</td>
									<td style="width:160px"><input id="instanceStart_startDateBegin" class="easyui-datebox" editable="false" style="width:150px;" /></td>
									<td style="width:70px">结束时间：</td>
									<td style="width:160px"><input id="instanceStart_startDateEnd" class="easyui-datebox" editable="false" style="width: 150px;" /></td>
									<td colspan=2 align="center"><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchInstanceStart();" href="javascript:void(0);">查询</a> <a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="clearInstanceStart();" href="javascript:void(0);">清空</a></td>
								</tr>
							</table>
						</fieldset>
					</div>
					<div data-options="region:'center',split:false,border:false">
						<table id="instanceStartDiv" class="easyui-datagrid"
							data-options="fit: true,
										url:'platform/bpm/clientbpmdisplayaction/getProcessInstanceListByPage.json',
										queryParams:{},
										sortName : 'startdate',
										sortOrder : 'desc',
										border: false,
										rownumbers: true,
										animate: true,
										fitColumns: true,
										autoRowHeight: false,
										idField :'id',
										singleSelect: true,
										pagination:true,
										pageSize:dataOptions.pageSize,
										pageList:dataOptions.pageList,
										striped:true">
							<thead>
								<tr>
									<th data-options="field:'id', hidden:true">id</th>
									<th data-options="field:'definename',align:'left',sortable:true" width="60">流程定义名称</th>
									<th data-options="field:'entryname',align:'left',sortable:true,formatter:formatEntryName" width="50">流程实例名称</th>
									<th data-options="field:'state',align:'left',sortable:true,formatter:formatState" width="40">状态</th>
									<th data-options="field:'userid',align:'left',sortable:true" width="25">创建者</th>
									<th data-options="field:'deptid',align:'left',sortable:true" width="50">创建部门</th>
									<th data-options="field:'startdate',align:'left',sortable:true,formatter:formatMyDate" width="50">启动时间</th>
									<th data-options="field:'enddate',align:'left',sortable:true,formatter:formatMyDate" width="50">结束时间</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<div title="我处理中的流程" style="padding:3px;">
				<div class="easyui-layout" fit="true">
					<div id="d2" data-options="region:'north',split:false,border:false" style="height:120px">
						<fieldset>
							<legend>查询条件</legend>
							<input type="hidden" name="catalogId" id="instanceTodo_catalogId" /> <input type="hidden" name="pdId" id="instanceTodo_pdId" />
							<table class="tableForm">
								<tr>
									<td style="width:70px">定义名称：</td>
									<td style="width:160px"><input id="instanceTodo_definename" class="easyui-validatebox" style="width:150px;" /></td>
									<td style="width:70px">实例名称：</td>
									<td style="width:160px"><input id="instanceTodo_entryName" class="easyui-validatebox" style="width:150px;" /></td>
									<td style="width:70px">创建者：</td>
									<td style="width:160px"><input type="hidden" id="instanceTodo_createUserId"/><input id="instanceTodo_createUserName" class="easyui-validatebox" readonly style="width:150px;" /></td>
								</tr>
								<tr>
									<td style="width:70px">开始时间：</td>
									<td style="width:160px"><input id="instanceTodo_startDateBegin" class="easyui-datebox" editable="false" style="width:150px;" /></td>
									<td style="width:70px">结束时间：</td>
									<td style="width:160px"><input id="instanceTodo_startDateEnd" class="easyui-datebox" editable="false" style="width: 150px;" /></td>
									<td style="width:70px">创建部门：</td>
									<td style="width:160px"><input type="hidden" id="instanceTodo_createDeptId"/><input id="instanceTodo_createDeptName" class="easyui-validatebox" readonly style="width:150px;" /></td>
								</tr>
								<tr>
									<td colspan=6 align="center"><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchInstanceTodo();" href="javascript:void(0);">查询</a><a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="clearInstanceTodo();" href="javascript:void(0);">清空</a></td>
								</tr>
							</table>
						</fieldset>
					</div>
					<div data-options="region:'center',split:false,border:false">
						<table id="instanceTodoDiv" class="easyui-datagrid"
							data-options="fit: true,
										url:'platform/bpm/clientbpmdisplayaction/getProcessInstanceTodoListByPage.json?isFinished=0',
										queryParams:{},
										sortName : 'startdate',
										sortOrder : 'desc',
										border: false,
										rownumbers: true,
										animate: true,
										fitColumns: true,
										autoRowHeight: false,
										idField :'id',
										singleSelect: true,
										pagination:true,
										pageSize:dataOptions.pageSize,
										pageList:dataOptions.pageList,
										striped:true">
							<thead>
								<tr>
									<th data-options="field:'id', hidden:true">id</th>
									<th data-options="field:'definename',align:'left',sortable:true" width="60">流程定义名称</th>
									<th data-options="field:'entryname',align:'left',sortable:true,formatter:formatEntryName" width="50">流程实例名称</th>
									<th data-options="field:'state',align:'left',sortable:true,formatter:formatState" width="40">状态</th>
									<th data-options="field:'userid',align:'left',sortable:true" width="25">创建者</th>
									<th data-options="field:'deptid',align:'left',sortable:true" width="50">创建部门</th>
									<th data-options="field:'startdate',align:'left',sortable:true,formatter:formatMyDate" width="50">启动时间</th>
									<th data-options="field:'enddate',align:'left',sortable:true,formatter:formatMyDate" width="50">结束时间</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<div title="我经办过的流程" style="padding:3px;">
				<div class="easyui-layout" fit="true">
					<div id="d3" data-options="region:'north',split:false,border:false" style="height:120px">
						<fieldset>
							<legend>查询条件</legend>
							<input type="hidden" name="catalogId" id="instanceFinish_catalogId" /> <input type="hidden" name="pdId" id="instanceFinish_pdId" />
							<table class="tableForm">
								<tr>
									<td style="width:70px">定义名称：</td>
									<td style="width:160px"><input id="instanceFinish_definename" class="easyui-validatebox" style="width:150px;" /></td>
									<td style="width:70px">实例名称：</td>
									<td style="width:160px"><input id="instanceFinish_entryName" class="easyui-validatebox" style="width:150px;" /></td>
									<td style="width:70px">创建者：</td>
									<td style="width:160px"><input type="hidden" id="instanceFinish_createUserId"/><input id="instanceFinish_createUserName" class="easyui-validatebox" readonly style="width:150px;" /></td>
								</tr>
								<tr>
									<td style="width:70px">开始时间：</td>
									<td style="width:160px"><input id="instanceFinish_startDateBegin" class="easyui-datebox" editable="false" style="width:150px;" /></td>
									<td style="width:70px">结束时间：</td>
									<td style="width:160px"><input id="instanceFinish_startDateEnd" class="easyui-datebox" editable="false" style="width: 150px;" /></td>
									<td style="width:70px">创建部门：</td>
									<td style="width:160px"><input type="hidden" id="instanceFinish_createDeptId"/><input id="instanceFinish_createDeptName" class="easyui-validatebox" readonly style="width:150px;" /></td>
								</tr>
								<tr>
									<td style="width:70px">流转状态：</td>
									<td style="width:160px"><select id="instanceFinish_state" class="easyui-combobox" style="width:150px;" data-options="editable:false">
											<option value="">全部</option>
											<option value="active">流转中</option>
											<option value="ended">结束</option>
											<option value="suspended">挂起</option>
									</select></td>
									<td colspan=4 align="center"><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchInstanceFinish();" href="javascript:void(0);">查询</a><a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="clearInstanceFinish();" href="javascript:void(0);">清空</a></td>
								</tr>
							</table>
						</fieldset>
					</div>
					<div data-options="region:'center',split:false,border:false">
						<table id="instanceFinishDiv" class="easyui-datagrid"
							data-options="fit: true,
										url:'platform/bpm/clientbpmdisplayaction/getProcessInstanceTodoListByPage.json?isFinished=1',
										queryParams:{},
										sortName : 'startdate',
										sortOrder : 'desc',
										border: false,
										rownumbers: true,
										animate: true,
										fitColumns: true,
										autoRowHeight: false,
										idField :'id',
										singleSelect: true,
										pagination:true,
										pageSize:dataOptions.pageSize,
										pageList:dataOptions.pageList,
										striped:true">
							<thead>
								<tr>
									<th data-options="field:'id', hidden:true">id</th>
									<th data-options="field:'definename',align:'left',sortable:true" width="60">流程定义名称</th>
									<th data-options="field:'entryname',align:'left',sortable:true,formatter:formatEntryName" width="50">流程实例名称</th>
									<th data-options="field:'state',align:'left',sortable:true,formatter:formatState" width="40">状态</th>
									<th data-options="field:'userid',align:'left',sortable:true" width="25">创建者</th>
									<th data-options="field:'deptid',align:'left',sortable:true" width="50">创建部门</th>
									<th data-options="field:'startdate',align:'left',sortable:true,formatter:formatMyDate" width="50">启动时间</th>
									<th data-options="field:'enddate',align:'left',sortable:true,formatter:formatMyDate" width="50">结束时间</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function formatEntryName(value, rec){
			if(value == null || value == ""){
				value = "未命名";
			}
			var processInstance = "'" + rec.entryid + "'";
			var state = "'" + rec.state + "'";
			var id = "'" + rec.id + "'";
			return '<a href="javascript:window.trackBpm(' + processInstance + ')">' + value + '</a>';
		}
		function formatState(value, rec){
			if (value == 'active') {
				return '流转中';
			} else if (value == 'ended') {
				return '结束';
			} else if (value == 'suspended') {
				return '挂起';
			}
		}
		function formatMyDate(value, rec){
			if (value == undefined) {
				return;
			}
			var newDate = new Date(value);
			return newDate.Format("yyyy-MM-dd hh:mm:ss");
		}
		
		function selectMyTab(title, index){
			if (index == 0) {
				tabSelectedIndex = "0";
			}
			if (index == 1) {
				tabSelectedIndex = "1";
			}
			if (index == 2) {
				tabSelectedIndex = "2";
			}
		}
	</script>
</body>
</html>