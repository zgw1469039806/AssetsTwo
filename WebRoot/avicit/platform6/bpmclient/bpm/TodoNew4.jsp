<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>待办信息</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
<script src="static/js/platform/bpm/client/js/ToolBar.js" type="text/javascript"></script>
<link type="text/css" rel="stylesheet" href="static/css/platform/todo/todo.css">
</head>
<script type="text/javascript">
	function executeTask(entryId, executionId, taskId, formId, url, title, taskType) {
		if (url == null || url == '') {
			return;
		}
		if (taskType == '1') {
			finishTaskNew(taskId, entryId);
		}
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
					window.open(url);
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
	}
	function finishTask(id, entryId) {
		if (confirm("是否标识完成?")) {
			ajaxRequest("POST", "dbid=" + id + "&entryId=" + entryId, "platform/bpm/clientbpmdisplayaction/finishtodo", "json", "backFinished");
		}
	}
	function backFinished(obj) {
		if (obj != null && obj.mes == true) {
			refreshPage(currWaitReadPage, "1", "waitread", "待阅", 1, false, function(){});
		}
	}
	function finishTaskNew(id, entryId) {
		if (id != null) {
			ajaxRequest("POST", "dbid=" + id + "&entryId=" + entryId, "platform/bpm/clientbpmdisplayaction/finishtodo", "json", "backFinished");
		}
	}
	var currWaitdoPage;//待办当前页
	var currWaitReadPage;//待阅当前页
	var pageSize = 9;//每页显示条数
	$(function() {
		//待办上一页
		$("#waitdo .fjpages").on("click", function() {
			if (currWaitdoPage == 1) {
				$.messager.alert("操作提示", "当前已经是第一页！", "info");
				return;
			}
			refreshPage(currWaitdoPage - 1, "0", "waitdo", "待办", 0, false, function(){currWaitdoPage = currWaitdoPage - 1});
		});
		//待办下一页
		$("#waitdo .fjpagex").on("click", function() {
			refreshPage(currWaitdoPage + 1, "0", "waitdo", "待办", 0, true, function(){currWaitdoPage = currWaitdoPage + 1});
		});
		//待阅上一页
		$("#waitread .fjpages").on("click", function() {
			if (currWaitReadPage == 1) {
				$.messager.alert("操作提示", "当前已经是第一页！", "info");
				return;
			}
			refreshPage(currWaitReadPage - 1, "1", "waitread", "待阅", 1, false, function(){currWaitReadPage = currWaitReadPage - 1});
		});
		//待阅下一页
		$("#waitread .fjpagex").on("click", function() {
			refreshPage(currWaitReadPage + 1, "1", "waitread", "待阅", 1, true, function(){currWaitReadPage = currWaitReadPage + 1});
		});
		bpm_operator_refresh();
	});
	/**
	 * 创建行
	 */
	function createTr(data) {
		var tr = $('<tr></tr>');
		var td1 = $('<td class="w15"><img src="static/css/platform/todo/images/todo_arrow.gif"/></td>');
		var td2;
		if (data.processDefName == null || data.processDefName == "") {
			td2 = $('<td _id="rmie6" class="alignl w15" nowrap="nowrap" title="通知">通知</td>');
		} else {
			td2 = $('<td _id="rmie6" class="alignl w15" nowrap="nowrap" title="'+data.processDefName+'">' + data.processDefName + '</td>');
		}
		var td3 = $('<td class="alignl" title="'+data.taskTitle+'"><a href="javascript:void(0);">' + data.taskTitle + '</a></td>');
		if (data.priority == null || data.priority == "" || data.priority == 0) {

		} else if (data.priority == 1) {
			td3.append($('<img src="static/css/platform/todo/images/j.gif"/>'));
		} else if (data.priority == 2) {
			td3.append($('<img src="static/css/platform/todo/images/jj.gif"/>'));
		}
		td3.find("a").on("click", function() {
			executeTask(data.processInstance, data.executionId, data.dbid, data.businessId, data.formResourceName, data.taskTitle, data.taskType)
		});
		var td4 = $('<td class="w80 gray" title="'+data.taskSendUser+'">' + data.taskSendUser + '</td>');
		var td5 = $('<td class="w60 gray">' + data.cTime.substring(0, 10) + '</td>');
		var td6 = $('<td class="w60"></td>');
		if (data.taskType != null && data.taskType == "1") {
			td6.append($('<a href="javascript:void(0);" title="把待阅任务标记完成">标记完成</a>'));
			td6.find("a").on("click", function() {
				finishTask(data.dbid, data.processInstance);
			});
		}
		tr.append(td1);
		tr.append(td2);
		tr.append(td3);
		tr.append(td4);
		tr.append(td5);
		tr.append(td6);
		return tr;
	}
	/**
	 * 刷新当前页
	 */
	function bpm_operator_refresh() {
		currWaitdoPage = 1;//待办当前页
		currWaitReadPage = 1;//待阅当前页
		refreshPage(currWaitdoPage, "0", "waitdo", "待办", 0, false, function(){});
		refreshPage(currWaitReadPage, "1", "waitread", "待阅", 1, false, function(){});
	}
	
	function refreshPage(pageNo, taskType, id, title, index, isNext, func){
		$.ajax({
			type : "POST",
			data : {
				pageNo : pageNo,
				pageSize : pageSize,
				taskType : taskType
			},
			url : "platform/bpm/clientbpmtodoaction/gettodonew4",
			dataType : "json",
			success : function(r) {
				var flg = true;
				if (pageNo == 1 && r.rows.length == 0) {
					$("#" + id).find(".spanMain").show();
					$("#" + id).find(".lmain").hide();
					$("#" + id).find(".rmain").hide();
				} else if (pageNo == 1 && r.rows.length > 0) {
					$("#" + id).find(".spanMain").hide();
					$("#" + id).find(".lmain").show();
					$("#" + id).find(".rmain").show();
				}else if (pageNo > 1 && r.rows.length == 0) {
					if(isNext){
						$.messager.alert("操作提示", "下一页没有数据了！", "info");
						flg = false;
					}
				}
				if(flg){
					$("#" + id).find(".lmain").find("tbody").empty();
					for (var i = 0; i < r.rows.length; i++) {
						$("#" + id).find(".lmain").find("tbody").append(createTr(r.rows[i]));
					}
					if (r.total != null && r.total > 0) {
						title = title + "（" + r.total + "）";
					}
					if (myUtils.IS_IE6) {
						$("td[_id='rmie6']").removeClass("w15");
					}
					var tab = $("#tt").tabs("getTab", index);
					$("#tt").tabs("update", {
						tab : tab,
						options : {
							title : title
						}
					});
					func();
				}
			}
		});
	}
	
	var myUtils = {
		IS_IE6 : navigator.userAgent.indexOf('MSIE 6') >= 0
	};
</script>
<body class="easyui-layout" fit="true">
	<div id="tt" class="easyui-tabs" fit="true">
		<div id="waitdo" title="待办" style="padding:2px;width:auto">
			<div class="spanMain" style="display:none;">暂无待办任务</div>
			<div class="lmain">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tbody>
					</tbody>
				</table>
			</div>
			<div class="rmain">
				<a href="javascript:void(0);" class="fjpages"></a> <a href="javascript:void(0);" class="fjpagex"></a>
			</div>
		</div>
		<div id="waitread" title="待阅" style="padding:2px;width:auto">
			<div class="spanMain" style="display:none;">暂无待阅任务</div>
			<div class="lmain">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tbody>
					</tbody>
				</table>
			</div>
			<div class="rmain">
				<a href="javascript:void(0);" class="fjpages"></a> <a href="javascript:void(0);" class="fjpagex"></a>
			</div>
		</div>
	</div>
</body>
</html>
