<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
	String userId = SessionHelper.getLoginSysUserId(request);
%>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
<script src="static/js/platform/component/common/browserSupportedTest.js"></script>
</head>

<script type="text/javascript">
	var baseurl = '<%=ViewUtil.getRequestPath(request)%>';

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
					if (url.indexOf("?") == -1) {
						url += "?id=" + formId;
					} else {
						url += "&id=" + formId;
					}
					try {
						if (typeof (top.addTab) == "function") {
							top.addTab(title, encodeURI(url), "static/images/platform/index/images/icons.gif", "taskTodo", " -0px -120px");
						} else {
							window.open(getPath2() + "/" + url);
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

	function cancelFocusedTask(id) {
		if (confirm("是否取消关注?")) {
			ajaxRequest("POST", "dbid=" + id, "platform/bpm/clientbpmoperateaction/cancelFocusedTask", "json", "backFinished");
		}
	}
	function backFinished(obj) {
		if (obj != null && obj.mes == true) {
			$("#focused_data").datagrid("uncheckAll").datagrid("unselectAll").datagrid("clearSelections");
			$("#focused_data").datagrid("reload");
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
</script>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<table id="focused_data" class="easyui-datagrid"
			data-options="fit: true,
						url: 'platform/bpm/clientbpmdisplayaction/getFocusedTask.json?userId=<%=userId%>',
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
					<th data-options="field:'op',align:'center',formatter:formatOp" width="20">流程跟踪</th>
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
		function formatTaskTitle(value, rec) {
			var processInstance = "'" + rec.processInstance + "'";
			var executionId = "'" + rec.executionId + "'";
			var dbid = "'" + rec.dbid + "'";
			var businessId = "'" + rec.businessId + "'";
			var url = "'" + rec.formResourceName + "'";
			var title = "'" + rec.taskTitle + "'";
			return '<a href="javascript:window.executeTask(' + processInstance + ',' + executionId + ',' + dbid + ',' + businessId + ',' + url + ',' + title + ')">' + value + '</a>';
		}
		function formatPriority(value, rec) {
			if (value == "2") {
				return '<img align="center" src="static/images/platform/bpm/client/images/highest.gif"/>';
			} else if (value == "1") {
				return '<img align="center" src="static/images/platform/bpm/client/images/high.gif"/>';
			} else {
				return '<img align="center" src="static/images/platform/bpm/client/images/normal.gif"/>';
			}
		}
		function formatOp(value, rec) {
			return '&nbsp;<img src="static/images/platform/bpm/client/images/signTask.gif" style="cursor:pointer" title="取消关注" onclick="javascript:window.cancelFocusedTask(\'' + rec.dbid + '\')" />&nbsp;&nbsp;&nbsp;&nbsp;<img src="static/images/platform/bpm/client/images/trackTask.gif" style="cursor:pointer" title="流程跟踪" onclick="javascript:window.trackBpm(\'' + rec.processInstance + '\')"/>';
		}
	</script>
<body>
</html>
