<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的任务</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
<style type="text/css">
.myHidden{
	display:none;
}
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,width:300">
		<ul id="tree"></ul>
	</div>
	<div data-options="region:'center'">
		<div id="tabs" fit="true" style="width:100%;height:100%;">
			<div title="我的待办">
				<div id="todoToolbar" class="datagrid-toolbar myHidden">
					<table style="width:100%">
						<tr>
							<td>
								<div class="ext-toolbar-left">
									<a class="easyui-linkbutton" iconCls="icon-add" plain="true" href="javascript:void(0);" id="batchExecuteTask">批量提交</a>
								</div>
								<div class="ext-toolbar-right">
									<div class="ext-selector-div">
										<input class="easyui-validatebox ext-selector-input keySearchClass" title="请输入标题" id="todoKeyInput"> <span class="ext-input-right-icon icon-search"></span>
									</div>
									<a class="easyui-linkbutton" plain="true" href="javascript:void(0);" id="todoSearchId">高级查询 <span class="caret"></span></a> <span class="ext-icon changyong"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<table class="myHidden" id="todoGrid" data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#todoToolbar',
				idField :'dbid',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
					<thead>
						<tr>
							<th data-options="field:'dbid', halign:'center', checkbox:true"></th>
							<th data-options="field:'executionId', hidden:true"></th>
							<th data-options="field:'processInstance', hidden:true"></th>
							<th data-options="field:'taskTitle', halign:'center', formatter:getTraceButtons" width="200">标题</th>
							<th data-options="field:'priority', align:'center', formatter:formatPriority" width="80">紧急程度</th>
							<th data-options="field:'processStartTime', align:'center', formatter:formatTime" width="140">申请日期</th>
							<th data-options="field:'curActName', halign:'center'" width="140">当前节点</th>
							<th data-options="field:'businessState', align:'center', formatter:formatState" width="80">状态</th>
							<th data-options="field:'taskSendUser', align:'center'" width="80">发送人</th>
							<!-- <th data-options="field:'opt', align:'center', formatter:formatTaskOptTodo" width="80">操作</th> -->
						</tr>
					</thead>
				</table>
			</div>
			
			<div title="我的待阅">
				<div id="toreadToolbar" class="datagrid-toolbar myHidden">
					<table style="width:100%">
						<tr>
							<td>
								<div class="ext-toolbar-left">
									<a class="easyui-linkbutton" iconCls="icon-add" plain="true" href="javascript:void(0);" id="batchReadTask">批量阅文</a>
								</div>
								<div class="ext-toolbar-right">
									<div class="ext-selector-div">
										<input class="easyui-validatebox ext-selector-input keySearchClass" title="请输入标题" id="toreadKeyInput"> <span class="ext-input-right-icon icon-search"></span>
									</div>
									<a class="easyui-linkbutton" plain="true" href="javascript:void(0);" id="toreadSearchId">高级查询 <span class="caret"></span></a> <span class="ext-icon changyong"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<table id="toreadGrid" class="myHidden" data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toreadToolbar',
				idField :'dbid',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
					<thead>
						<tr>
							<th data-options="field:'dbid', halign:'center', checkbox:true"></th>
							<th data-options="field:'executionId', hidden:true"></th>
							<th data-options="field:'processInstance', hidden:true"></th>
							<th data-options="field:'taskTitle', halign:'center', formatter:getTraceButtons" width="200">标题</th>
							<th data-options="field:'priority', align:'center', formatter:formatPriority" width="80">紧急程度</th>
							<th data-options="field:'processStartTime', align:'center', formatter:formatTime" width="140">申请日期</th>
							<th data-options="field:'curActName', halign:'center'" width="140">当前节点</th>
							<th data-options="field:'businessState', align:'center', formatter:formatState" width="80">状态</th>
							<th data-options="field:'taskSendUser', align:'center'" width="80">发送人</th>
							<th data-options="field:'opt', align:'center', formatter:formatTaskOptToread" width="80">操作</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="我的已办">
				<div id="finisheddoToolbar" class="datagrid-toolbar myHidden">
					<table style="width:100%">
						<tr>
							<td>
								<div class="ext-toolbar-right">
									<div class="ext-selector-div">
										<input class="easyui-validatebox ext-selector-input keySearchClass" title="请输入标题" id="finisheddoKeyInput"> <span class="ext-input-right-icon icon-search"></span>
									</div>
									<a class="easyui-linkbutton" plain="true" href="javascript:void(0);" id="finisheddoSearchId">高级查询 <span class="caret"></span></a> <span class="ext-icon changyong"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<table id="finisheddoGrid" class="myHidden" data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#finisheddoToolbar',
				idField :'dbid',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
					<thead>
						<tr>
							<th data-options="field:'dbid', hidden:true"></th>
							<th data-options="field:'taskTitle', halign:'center', formatter:getTraceButtons" width="220">标题</th>
							<th data-options="field:'priority', align:'center', formatter:formatPriority" width="80">紧急程度</th>
							<th data-options="field:'processStartTime', align:'center', formatter:formatTime" width="140">申请日期</th>
							<th data-options="field:'curActName', halign:'center'" width="140">当前节点</th>
							<th data-options="field:'businessState', align:'center', formatter:formatState" width="80">状态</th>
							<th data-options="field:'assigneeName', align:'center'" width="80">处理人</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="我的已阅">
				<div id="finishedreadToolbar" class="datagrid-toolbar myHidden">
					<table style="width:100%">
						<tr>
							<td>
								<div class="ext-toolbar-right">
									<div class="ext-selector-div">
										<input class="easyui-validatebox ext-selector-input keySearchClass" title="请输入标题" id="finishedreadKeyInput"> <span class="ext-input-right-icon icon-search"></span>
									</div>
									<a class="easyui-linkbutton" plain="true" href="javascript:void(0);" id="finishedreadSearchId">高级查询 <span class="caret"></span></a> <span class="ext-icon changyong"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<table id="finishedreadGrid" class="myHidden" data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#finishedreadToolbar',
				idField :'dbid',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
					<thead>
						<tr>
							<th data-options="field:'dbid', hidden:true"></th>
							<th data-options="field:'taskTitle', halign:'center', formatter:getTraceButtons" width="220">标题</th>
							<th data-options="field:'priority', align:'center', formatter:formatPriority" width="80">紧急程度</th>
							<th data-options="field:'processStartTime', align:'center', formatter:formatTime" width="140">申请日期</th>
							<th data-options="field:'curActName', halign:'center'" width="140">当前节点</th>
							<th data-options="field:'businessState', align:'center', formatter:formatState" width="80">状态</th>
							<th data-options="field:'assigneeName', align:'center'" width="80">处理人</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="我的关注">
				<div id="focusedToolbar" class="datagrid-toolbar myHidden">
					<table style="width:100%">
						<tr>
							<td>
								<div class="ext-toolbar-right">
									<div class="ext-selector-div">
										<input class="easyui-validatebox ext-selector-input keySearchClass" title="请输入标题" id="focusedKeyInput"> <span class="ext-input-right-icon icon-search"></span>
									</div>
									<a class="easyui-linkbutton" plain="true" href="javascript:void(0);" id="focusedSearchId">高级查询 <span class="caret"></span></a> <span class="ext-icon changyong"></span>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<table id="focusedGrid" class="myHidden" data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#focusedToolbar',
				idField :'dbid',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
					<thead>
						<tr>
							<th data-options="field:'dbid', hidden:true"></th>
							<th data-options="field:'taskTitle', halign:'center', formatter:getTraceButtons" width="220">标题</th>
							<th data-options="field:'priority', align:'center', formatter:formatPriority" width="80">紧急程度</th>
							<th data-options="field:'processStartTime', align:'center', formatter:formatTime" width="140">申请日期</th>
							<th data-options="field:'curActName', halign:'center'" width="140">当前节点</th>
							<th data-options="field:'businessState', align:'center', formatter:formatState" width="80">状态</th>
							<th data-options="field:'assigneeName', align:'center'" width="80">处理人</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<div id="todoDialog" style="overflow: auto;display: none">
		<form id="todoSearchForm" style="padding: 10px;">
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">标题:</th>
					<td width="39%"><input class="easyui-validatebox" style="width: 99%;" type="text" name="taskTitle" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">紧急程度:</th>
					<td width="39%"><select class="easyui-combobox" style="width: 99%;" name="priority" data-options="editable:false">
							<option value="">请选择</option>
							<option value="0">一般</option>
							<option value="1">紧急</option>
							<option value="2">特急</option>
					</select></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请人:</th>
					<td width="39%"><input class="inputbox" type="hidden" name="processStarter" id="todoprocessStarter" />
						<div class="">
							<input class="easyui-validatebox" type="text" name="processStarterAlias" id="todoprocessStarterAlias" readOnly="readOnly"></input>
						</div></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请部门:</th>
					<td width="39%"><input class="inputbox" type="hidden" name="processStartDept" id="todoprocessStartDept" />
						<div class="">
							<input class="easyui-validatebox" type="text" name="processStartDeptAlias" id="todoprocessStartDeptAlias" readOnly="readOnly"></input>
						</div></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请日期:</th>
					<td width="39%"><input name="processStartTimeBegin" class="easyui-datebox" editable="false" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">至:</th>
					<td width="39%"><input name="processStartTimeEnd" class="easyui-datebox" editable="false" /></td>
				</tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;">流程状态:</th>
				<td width="39%"><select class="easyui-combobox" style="width: 99%;" name="businessState" data-options="editable:false">
						<option value="">请选择</option>
						<option value="start">拟稿中</option>
						<option value="active">流转中</option>
						<option value="ended">已完成</option>
				</select></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="toreadDialog" style="overflow: auto;display: none">
		<form id="toreadSearchForm" style="padding: 10px;">
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">标题:</th>
					<td width="39%"><input class="easyui-validatebox" style="width: 99%;" type="text" name="taskTitle" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">紧急程度:</th>
					<td width="39%"><select class="easyui-combobox" style="width: 99%;" name="priority" data-options="editable:false">
							<option value="">请选择</option>
							<option value="0">一般</option>
							<option value="1">紧急</option>
							<option value="2">特急</option>
					</select></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请人:</th>
					<td width="39%"><input class="inputbox" type="hidden" name="processStarter" id="toreadprocessStarter" />
						<div class="">
							<input class="easyui-validatebox" type="text" name="processStarterAlias" id="toreadprocessStarterAlias" readOnly="readOnly"></input>
						</div></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请部门:</th>
					<td width="39%"><input class="inputbox" type="hidden" name="processStartDept" id="toreadprocessStartDept" />
						<div class="">
							<input class="easyui-validatebox" type="text" name="processStartDeptAlias" id="toreadprocessStartDeptAlias" readOnly="readOnly"></input>
						</div></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请日期:</th>
					<td width="39%"><input name="processStartTimeBegin" class="easyui-datebox" editable="false" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">至:</th>
					<td width="39%"><input name="processStartTimeEnd" class="easyui-datebox" editable="false" /></td>
				</tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;">流程状态:</th>
				<td width="39%"><select class="easyui-combobox" style="width: 99%;" name="businessState" data-options="editable:false">
						<option value="">请选择</option>
						<option value="start">拟稿中</option>
						<option value="active">流转中</option>
						<option value="ended">已完成</option>
				</select></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="finisheddoDialog" style="overflow: auto;display: none">
		<form id="finisheddoSearchForm" style="padding: 10px;">
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">标题:</th>
					<td width="39%"><input class="easyui-validatebox" style="width: 99%;" type="text" name="taskTitle" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">紧急程度:</th>
					<td width="39%"><select class="easyui-combobox" style="width: 99%;" name="priority" data-options="editable:false">
							<option value="">请选择</option>
							<option value="0">一般</option>
							<option value="1">紧急</option>
							<option value="2">特急</option>
					</select></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请人:</th>
					<td width="39%"><input class="inputbox" type="hidden" name="processStarter" id="finisheddoprocessStarter" />
						<div class="">
							<input class="easyui-validatebox" type="text" name="processStarterAlias" id="finisheddoprocessStarterAlias" readOnly="readOnly"></input>
						</div></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请部门:</th>
					<td width="39%"><input class="inputbox" type="hidden" name="processStartDept" id="finisheddoprocessStartDept" />
						<div class="">
							<input class="easyui-validatebox" type="text" name="processStartDeptAlias" id="finisheddoprocessStartDeptAlias" readOnly="readOnly"></input>
						</div></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请日期:</th>
					<td width="39%"><input name="processStartTimeBegin" class="easyui-datebox" editable="false" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">至:</th>
					<td width="39%"><input name="processStartTimeEnd" class="easyui-datebox" editable="false" /></td>
				</tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;">流程状态:</th>
				<td width="39%"><select class="easyui-combobox" style="width: 99%;" name="businessState" data-options="editable:false">
						<option value="">请选择</option>
						<option value="start">拟稿中</option>
						<option value="active">流转中</option>
						<option value="ended">已完成</option>
				</select></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="finishedreadDialog" style="overflow: auto;display: none">
		<form id="finishedreadSearchForm" style="padding: 10px;">
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">标题:</th>
					<td width="39%"><input class="easyui-validatebox" style="width: 99%;" type="text" name="taskTitle" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">紧急程度:</th>
					<td width="39%"><select class="easyui-combobox" style="width: 99%;" name="priority" data-options="editable:false">
							<option value="">请选择</option>
							<option value="0">一般</option>
							<option value="1">紧急</option>
							<option value="2">特急</option>
					</select></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请人:</th>
					<td width="39%"><input class="inputbox" type="hidden" name="processStarter" id="finishedreadprocessStarter" />
						<div class="">
							<input class="easyui-validatebox" type="text" name="processStarterAlias" id="finishedreadprocessStarterAlias" readOnly="readOnly"></input>
						</div></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请部门:</th>
					<td width="39%"><input class="inputbox" type="hidden" name="processStartDept" id="finishedreadprocessStartDept" />
						<div class="">
							<input class="easyui-validatebox" type="text" name="processStartDeptAlias" id="finishedreadprocessStartDeptAlias" readOnly="readOnly"></input>
						</div></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请日期:</th>
					<td width="39%"><input name="processStartTimeBegin" class="easyui-datebox" editable="false" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">至:</th>
					<td width="39%"><input name="processStartTimeEnd" class="easyui-datebox" editable="false" /></td>
				</tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;">流程状态:</th>
				<td width="39%"><select class="easyui-combobox" style="width: 99%;" name="businessState" data-options="editable:false">
						<option value="">请选择</option>
						<option value="start">拟稿中</option>
						<option value="active">流转中</option>
						<option value="ended">已完成</option>
				</select></td>
				</tr>
			</table>
		</form>
	</div>

	<div id="focusedDialog" style="overflow: auto;display: none">
		<form id="focusedSearchForm" style="padding: 10px;">
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">标题:</th>
					<td width="39%"><input class="easyui-validatebox" style="width: 99%;" type="text" name="taskTitle" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">紧急程度:</th>
					<td width="39%"><select class="easyui-combobox" style="width: 99%;" name="priority" data-options="editable:false">
							<option value="">请选择</option>
							<option value="0">一般</option>
							<option value="1">紧急</option>
							<option value="2">特急</option>
					</select></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请人:</th>
					<td width="39%"><input class="inputbox" type="hidden" name="processStarter" id="focusedprocessStarter" />
						<div class="">
							<input class="easyui-validatebox" type="text" name="processStarterAlias" id="focusedprocessStarterAlias" readOnly="readOnly"></input>
						</div></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请部门:</th>
					<td width="39%"><input class="inputbox" type="hidden" name="processStartDept" id="focusedprocessStartDept" />
						<div class="">
							<input class="easyui-validatebox" type="text" name="processStartDeptAlias" id="focusedprocessStartDeptAlias" readOnly="readOnly"></input>
						</div></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">申请日期:</th>
					<td width="39%"><input name="processStartTimeBegin" class="easyui-datebox" editable="false" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;">至:</th>
					<td width="39%"><input name="processStartTimeEnd" class="easyui-datebox" editable="false" /></td>
				</tr>
				<th width="10%" style="word-break: break-all; word-warp: break-word;">流程状态:</th>
				<td width="39%"><select class="easyui-combobox" style="width: 99%;" name="businessState" data-options="editable:false">
						<option value="">请选择</option>
						<option value="start">拟稿中</option>
						<option value="active">流转中</option>
						<option value="ended">已完成</option>
				</select></td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowButtons.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmtask/js/BpmTaskGrid.js"></script>
<script type="text/javascript">
	$(function() {
		var todoGrid = new BpmTaskGrid("todo", "platform/bpm/task/searchHistTaskByPage?taskType=0&taskFinished=0", "我的待办", 0, true);
		var toreadGrid = new BpmTaskGrid("toread", "platform/bpm/task/searchHistTaskByPage?taskType=1&taskFinished=0", "我的待阅", 1, true);
		var finisheddoGrid = new BpmTaskGrid("finisheddo", "platform/bpm/task/searchHistTaskByPage?taskType=0&taskFinished=1", "我的已办", 2, false);
		var finishedreadGrid = new BpmTaskGrid("finishedread", "platform/bpm/task/searchHistTaskByPage?taskType=1&taskFinished=1", "我的已阅", 3, false);
		var focusedGrid = new BpmTaskGrid("focused", "platform/bpm/task/searchFocusedTaskByPage", "我的关注", 4, false);
		var flg = new Array();
		$('#tabs').tabs({
			onSelect : function(title, index) {
				if(!flg[index]){
					if(index == 2){
						finisheddoGrid.realod();
					}else if(index == 3){
						finishedreadGrid.realod();
					}else if(index == 4){
						focusedGrid.realod();
					}
					flg[index] = true;
				}
			}
		});
		$('#tree').tree({
			url : 'platform/bpm/monitor/getFlowModelTree',
			onSelect : function(node) {
				var queryParams = {
					nodeId : node.id,
					nodeType : node.attributes.nodeType,
					pdId : node.attributes.pdId || ''
				};
				todoGrid.setQueryParams(queryParams);
				toreadGrid.setQueryParams(queryParams);
				finisheddoGrid.setQueryParams(queryParams);
				finishedreadGrid.setQueryParams(queryParams);
				focusedGrid.setQueryParams(queryParams);
				flg[0] = true;
				flg[1] = true;
				flg[2] = false;
				flg[3] = false
				flg[4] = false
				todoGrid.realod();
				toreadGrid.realod();
				var tab = $('#tabs').tabs('getSelected');
				var index = $('#tabs').tabs('getTabIndex',tab);
				flg[index] =  true;
				if(index == 2){
					finisheddoGrid.realod();
				}else if(index == 3){
					finishedreadGrid.realod();
				}else if(index == 4){
					focusedGrid.realod();
				}
			},
			onLoadSuccess : function(node) {
				var select = $('#tree').tree("getSelected");
				if (select == null) {
					var root = $('#tree').tree("getRoot");
					$('#tree').tree('select', root.target);
				}
			}
		});

		$("#batchExecuteTask").on("click", function() {
			var rows = $("#todoGrid").datagrid('getChecked');
			if (rows == null || rows == '' || rows.length < 1) {
				flowUtils.warning("请选择要批量办理的记录！");
				return;
			}
			var ids = '';
			var entryIds = '';
			var executionIds = '';
			for (var i = 0; i < rows.length; i++) {
				var rowData = rows[i];
				if (ids == '') {
					ids = rowData.dbid;
					entryIds = rowData.processInstance;
					executionIds = rowData.executionId;
				} else {
					ids = ids + ',' + rowData.dbid;
					entryIds = entryIds + ',' + rowData.processInstance;
					executionIds = executionIds + ',' + rowData.executionId;
				}
			}
			flowUtils.doBatchHandle(entryIds, executionIds, ids);
		});

		$("#batchReadTask").on("click", function() {
			var rows = $("#toreadGrid").datagrid('getChecked');
			if (rows == null || rows == '' || rows.length < 1) {
				flowUtils.warning("请选择要批量阅文的记录！");
				return;
			}
			var ids = '';
			var entryIds = '';
			var executionIds = '';
			for (var i = 0; i < rows.length; i++) {
				var rowData = rows[i];
				if (ids == '') {
					ids = rowData.dbid;
					entryIds = rowData.processInstance;
					executionIds = rowData.executionId;
				} else {
					ids = ids + ',' + rowData.dbid;
					entryIds = entryIds + ',' + rowData.processInstance;
					executionIds = executionIds + ',' + rowData.executionId;
				}
			}
			flowUtils.doBatchRead(entryIds, executionIds, ids);
		});

		$('.keySearchClass').attr('placeholder', '请输入标题');
		$('.combo').bind('click', function() {//解决高级查询控件层级问题
			$('.panel.combo-p').css('z-index', 999999999)
		});
		inputPlaceHolder();

		flowUtils.getBatchHandleInfo();
	});

	function getTraceButtons(value, row, index) {
		if (value != null && value != '') {
			value = value.trim();
		}
		var taskTitle = row.taskTitle;
		if (taskTitle != null) {
			taskTitle = escapeHtml(taskTitle);
		}
		var processInstance = "'" + row.processInstance + "'";
		var executionId = "'" + row.executionId + "'";
		var dbid = "'" + row.dbid + "'";
		var businessId = "'" + row.businessId + "'";
		var url = "'" + row.formResourceName + "'";
		var title = "'" + taskTitle + "'";
		var taskType = "'" + row.taskType + "'";
		return '<a href="javascript:flowUtils.executeTask(' + processInstance + ',' + executionId + ',' + dbid + ',' + businessId + ',' + url + ',' + title + ',' + taskType + ')">' + value + '</a>';
	}

	function formatPriority(value, row, index) {
		var html = "";
		if ('1' == value) {
			html = '<span style="color:red;font-size:13px;">急</span>';
		} else if ('2' == value) {
			html = '<span style="color:red;font-size:13px;">紧急</span>';
		} else {
			html = '<span style="color:red;font-size:13px;">一般</span>';
		}
		return html;
	}

	function formatTime(value, row, index) {
		var startdateMi = value;
		if (startdateMi == undefined) {
			return '';
		}
		var newDate = new Date(startdateMi);
		return newDate.format("yyyy-MM-dd hh:mm:ss");
	}

	function formatState(value, row, index) {
		if (value == 'start') {
			return '拟稿中';
		} else if (value == 'active') {
			return '流转中';
		} else if (value == 'ended') {
			return '已完成';
		} else {
			return value;
		}
	}

	function formatTaskOptTodo(value, row, index) {
		var processInstance = "'" + row.processInstance + "'";
		var executionId = "'" + row.executionId + "'";
		var dbid = "'" + row.dbid + "'";
		var businessId = "'" + row.businessId + "'";
		var url = "'" + row.formResourceName + "'";
		var taskTitle = "'" + row.taskTitle + "'";
		if (taskTitle != null) {
			taskTitle = escapeHtml(taskTitle);
		}
		var taskType = "'" + row.taskType + "'";
		return '<a href="javascript:flowUtils.quickDoTask(' + processInstance + ',' + executionId + ',' + dbid + ',' + businessId + ',' + url + ',' + taskTitle + ',' + taskType + ')">' + '办理' + '</a>';
	}

	function formatTaskOptToread(value, row, index) {
		var processInstance = "'" + row.processInstance + "'";
		var executionId = "'" + row.executionId + "'";
		var dbid = "'" + row.dbid + "'";
		var businessId = "'" + row.businessId + "'";
		var url = "'" + row.formResourceName + "'";
		var taskTitle = "'" + row.taskTitle + "'";
		if (taskTitle != null) {
			taskTitle = escapeHtml(taskTitle);
		}
		var taskType = "'" + row.taskType + "'";
		return '<a href="javascript:flowUtils.quickDoTask(' + processInstance + ',' + executionId + ',' + dbid + ',' + businessId + ',' + url + ',' + taskTitle + ',' + taskType + ')">' + '已阅' + '</a>';
	}

	//js中的字符串正常显示在HTML页面中 
	function escapeHtml(string) {
		var entityMap = {
			"&" : "&amp;",
			"<": "&lt;",
	        ">" : "&gt;",
			'"' : '&quot;',
			"'" : '&#39;',
			"/" : '&#x2F;'
		};
		return String(string).replace(/[&<>"'\/]/g, function(s) {
			return entityMap[s];
		});
	}

	function bpm_operator_refresh() {
		var select = $('#tree').tree("getSelected");
		$('#tree').tree('select', select.target);
	}
</script>
</html>