<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的工作</title>
<%
	String userId = SessionHelper.getLoginSysUserId(request);
	String tab = request.getParameter("tab");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
%>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
<script src="static/js/platform/component/common/browserSupportedTest.js"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<div class="easyui-tabs" fit="true" id="processWork">
			<div title="未办工作" style="padding:3px;">
				<div class="easyui-layout" fit="true">
					<div data-options="region:'north',split:false,border:false"
						style="height:70px">
						<fieldset>
							<legend>查询条件</legend>
							<table class="tableForm" id="Todo_searchForm">
								<tr>
									<td>流程名称</td>
									<td style="width:170px"><input id="Todo_processDefName" name="Todo_processDefName" class="easyui-validatebox" style="width: 150px;" /></td>
									<td>标题</td>
									<td style="width:170px"><input id="Todo_taskTitle" name="Todo_taskTitle" class="easyui-validatebox" style="width: 150px;" /></td>
									<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="loadTodoFun();" href="javascript:void(0);">查询</a><a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="clearTodoFun();" href="javascript:void(0);">清空</a></td>
								</tr>
							</table>
						</fieldset>
					</div>
					<div data-options="region:'center',split:false,border:false">
						<table id="Todo_data" class="easyui-datagrid"
							data-options="fit: true,
										url:'platform/bpm/clientbpmdisplayaction/gettodo.json',
										queryParams:{userId : '<%=userId%>', taskFinished : '0'},
										border: false,
										rownumbers: true,
										animate: true,
										fitColumns: true,
										autoRowHeight: false,
										idField :'dbid',
										singleSelect: true,
										pagination:true,
										pageSize:dataOptions.pageSize,
										pageList:dataOptions.pageList,
										striped:true">
							<thead>
								<tr>
									<th data-options="field:'dbid', hidden:true">id</th>
									<th data-options="field:'processDefName',align:'left'" width="50">流程名称</th>
									<th data-options="field:'taskTitle',align:'left',formatter:formatTaskTitle" width="50">标题</th>
									<th data-options="field:'priority',align:'center',formatter:formatPriority" width="20">优先级</th>
									<th data-options="field:'taskSendUser',align:'center'" width="20">发送人</th>
									<th data-options="field:'taskSendDept',align:'center'" width="30">发送部门</th>
									<th data-options="field:'cTime',align:'center'" width="50">发送时间</th>
									<th data-options="field:'op',align:'center',formatter:formatOpTodo" width="20">流程跟踪</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<div title="已办工作" style="padding:3px;">
				<div class="easyui-layout" fit="true">
					<div data-options="region:'north',split:false,border:false"
						style="height:70px">
						<fieldset>
							<legend>查询条件</legend>
							<table class="tableForm" id="FinishedTodo_searchForm">
								<tr>
									<td>流程名称</td>
									<td style="width:170px"><input id="FinishedTodo_processDefName" name="FinishedTodo_processDefName" class="easyui-validatebox" style="width: 150px;" /></td>
									<td>标题</td>
									<td style="width:170px"><input id="FinishedTodo_taskTitle" name="FinishedTodo_taskTitle" class="easyui-validatebox" style="width: 150px;" /></td>
									<td>完成日期(起)</td>
									<td style="width:170px"><input name="FinishedTodo_endDateBegin" id="FinishedTodo_endDateBegin" class="easyui-datebox" editable="false" style="width: 150px;" /></td>
									<td>完成日期(止)</td>
									<td style="width:170px"><input name="FinishedTodo_endDateEnd" id="FinishedTodo_endDateEnd" class="easyui-datebox" editable="false" style="width: 150px;" /></td>
									<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="loadFinishedTodoFun();" href="javascript:void(0);">查询</a><a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="clearFinishedTodoFun();" href="javascript:void(0);">清空</a>
									</td>
								</tr>
							</table>
						</fieldset>
					</div>
					<div data-options="region:'center',split:false,border:false">
						<table id="FinishedTodo_data" class="easyui-datagrid"
							data-options="fit: true,
										url:'platform/bpm/clientbpmdisplayaction/getfinishtodo.json',
										queryParams:{userId : '<%=userId%>', taskFinished : '1'},
										border: false,
										rownumbers: true,
										animate: true,
										fitColumns: true,
										autoRowHeight: false,
										idField :'dbid',
										singleSelect: true,
										pagination:true,
										pageSize:dataOptions.pageSize,
										pageList:dataOptions.pageList,
										striped:true">
							<thead>
								<tr>
									<th data-options="field:'dbid', hidden:true">id</th>
									<th data-options="field:'processDefName',align:'left'" width="50">流程名称</th>
									<th data-options="field:'taskTitle',align:'left',formatter:formatTaskTitle" width="50">标题</th>
									<th data-options="field:'priority',align:'center',formatter:formatPriority" width="20">优先级</th>
									<th data-options="field:'taskSendUser',align:'center'" width="20">发送人</th>
									<th data-options="field:'taskSendDept',align:'center'" width="30">发送部门</th>
									<th data-options="field:'cTime',align:'center'" width="50">发送时间</th>
									<th data-options="field:'op',align:'center',formatter:formatOpFinish" width="20">流程跟踪</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			var baseurl = '<%=ViewUtil.getRequestPath(request) %>';
			function formatTaskTitle(value, rec){
				var processInstance = "'"+rec.processInstance+"'";
				var executionId = "'"+rec.executionId+"'";
				var dbid = "'"+rec.dbid+"'";
				var businessId = "'"+rec.businessId+"'";
				var url = "'"+rec.formResourceName+"'";
				var title = "'"+rec.taskTitle+"'";
				return '<a href="javascript:window.executeTask('+processInstance+','+executionId+','+dbid+','+businessId+','+url+','+title+')">'+value+'</a>';
			}
			function formatPriority(value,rec){
				if(value == "2"){
					return '<img align="center" src="static/images/platform/bpm/client/images/highest.gif"/>';
				}else if(value == "1"){
					return '<img align="center" src="static/images/platform/bpm/client/images/high.gif"/>';
				}else{
					return '<img align="center" src="static/images/platform/bpm/client/images/normal.gif"/>';
				}
			}
			function formatOpTodo(value,rec){
				if(rec.taskType == '1'){
					return "&nbsp;<img src='static/images/platform/bpm/client/images/signTask.gif' style='cursor:pointer' title='把待办任务标记完成' onclick='javascript:window.finishTask(\""+rec.dbid+"\",\""+rec.processInstance+"\")' />&nbsp;&nbsp;&nbsp;&nbsp;<img src='static/images/platform/bpm/client/images/trackTask.gif' style='cursor:pointer' title='流程跟踪' onclick='javascript:window.trackBpm(\""+rec.processInstance+"\")'/>";	
				}else{
					return "&nbsp;<img src='static/images/platform/bpm/client/images/trackTask.gif' style='cursor:pointer' title='流程跟踪' onclick='javascript:window.trackBpm(\""+rec.processInstance+"\")'/>";	
				}
			}
			function formatOpFinish(value,rec){
				return "&nbsp;<img src='static/images/platform/bpm/client/images/trackTask.gif' style='cursor:pointer' title='流程跟踪' onclick='javascript:window.trackBpm(\""+rec.processInstance+"\")'/>";
			}
			function loadFinishedTodoFun(){
				var queryParams = {
					userId : "<%=userId%>",
					taskFinished : "1",
					processDefName : $("#FinishedTodo_processDefName").val(),
					taskTitle : $("#FinishedTodo_taskTitle").val(),
					endDateBegin : $("#FinishedTodo_endDateBegin").datetimebox("getValue"),
					endDateEnd : $("#FinishedTodo_endDateEnd").datetimebox("getValue")
				};
				$("#FinishedTodo_data").datagrid("uncheckAll").datagrid("unselectAll").datagrid("clearSelections");
				$("#FinishedTodo_data").datagrid("load", queryParams);
			}
			function loadTodoFun(){
				var queryParams = {
					userId : "<%=userId%>",
					taskFinished : "0",
					processDefName : $("#Todo_processDefName").val(),
					taskTitle : $("#Todo_taskTitle").val()
				};
				$("#Todo_data").datagrid("uncheckAll").datagrid("unselectAll").datagrid("clearSelections");
				$("#Todo_data").datagrid("load", queryParams);
			}
			function clearFinishedTodoFun() {
				$("#FinishedTodo_searchForm input").val("");
				$("#FinishedTodo_searchForm select").val("");
			}
			function clearTodoFun() {
				$("#Todo_searchForm input").val("");
				$("#Todo_searchForm select").val("");
			}
			$(function() {
				var tab = "<%=tab%>";
				if (tab != "" && tab != "null") {
					if (tab == "Finish") {
						$("#FinishedTodo_endDateBegin").datebox("setValue","<%=startDate%>"); 
						$("#FinishedTodo_endDateEnd").datebox("setValue","<%=endDate%>"); 
						$("#processWork").tabs("select" , 1);
						setTimeout(loadFinishedTodoFun(),500);
					}
				}
			});
			
			function executeTask(entryId, executionId, taskId, formId, url, title) {
				if (url == null || url == '') {
					return;
				}
				$.ajax({
					type : "POST",
					data : {
						processInstanceId : entryId
					},
					url : "platform/bpm/clientbpmdisplayaction/isUserSecretLevel",
					dataType : "json",
					success : function(r) {
						var b = r.result;
						if (b) {
							var proxyPage = "N"; //是否做页面代理
							if (url != null && url.indexOf("proxyPage=Y") != -1) {//是否做页面代理
								proxyPage = "Y";
							}
							if (proxyPage != "Y") { //不明确指定用代理页面的，则通通跳转到自己页面
								if (url.indexOf("?") > 0) {
									url += "&entryId=" + entryId;
								} else {
									url += "?entryId=" + entryId;
								}
								url += "&id=" + formId;
								url += "&executionId=" + executionId;
								url += "&taskId=" + taskId;
								try {
									if (typeof (eval(top.addTab)) == "function") {
										top.addTab(title, encodeURI(url), "static/images/platform/index/images/icons.gif", "taskTodo", " -0px -120px");
									} else {
										window.open(baseurl + url);
									}
								} catch (e) {
								}
								return;
							}
							//以下都是采用代理页面的avicit/platform6/bpmclient/bpm/ProcessApprove.jsp
							var redirectPath = "";
							redirectPath += "?id=" + formId;
							redirectPath += "&entryId=" + entryId;
							redirectPath += "&executionId=" + executionId;
							redirectPath += "&taskId=" + taskId;
							if (url.indexOf("?") > 0) {
								url += "&entryId=" + entryId;
								url += "&id=" + formId;
								url += "&executionId=" + executionId;
								url += "&taskId=" + taskId;
							} else {
								url += "?entryId=" + entryId;
								url += "&id=" + formId;
								url += "&executionId=" + executionId;
								url += "&taskId=" + taskId;
							}
							redirectPath += "&url=" + encodeURIComponent(url);
							try {
								if (typeof (eval(top.addTab)) == "function") {
									redirectPath = "avicit/platform6/bpmclient/bpm/ProcessApprove.jsp" + redirectPath;
									top.addTab(title, redirectPath, "static/images/platform/index/images/icons.gif", "taskTodo", " -0px -120px");
								} else {
									redirectPath = "ProcessApprove.jsp" + redirectPath;
									window.open(redirectPath);
								}
							} catch (e) {
							}
							return;
						} else {
							$.messager.alert('提示', '人员密级不符合要求，无法打开！');
						}
					}
				});
			}
			function finishTask(id, processInstanceId) {
				if (confirm("是否标识完成?")) {
					ajaxRequest("POST", "dbid=" + id + "&entryId=" + processInstanceId, "platform/bpm/clientbpmdisplayaction/finishtodo", "json", "backFinished");
				}
			}
			function backFinished(obj) {
				if (obj != null && obj.mes == true) {
					loadTodoFun();
				}
			}
			function trackBpm(processInstanceId) {
				var url = getPath2() + "/avicit/platform6/bpmclient/bpm/ProcessTrack.jsp";
				if (!myBrowserSupported.isBrowserSupported()) {
					url = getPath2() + "/avicit/platform6/bpmclient/bpm/ProcessTrack_bak.jsp";
				}
				url += "?processInstanceId=" + processInstanceId;
				window.open(encodeURI(url), "流程图", "scrollbars=no,status=yes,resizable=no,top=0,left=0,width=700,height=400");
			}
			
			/**
			 * 刷新当前页
			 */
			function bpm_operator_refresh() {
				loadTodoFun();
				loadFinishedTodoFun();
			}
		</script>
	<body>
</html>
