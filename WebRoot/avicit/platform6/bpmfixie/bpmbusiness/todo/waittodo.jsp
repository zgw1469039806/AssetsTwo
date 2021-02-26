<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>门户待办小页</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<!-- 公用 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmfixie/bpmcommon/css/normalize.css">
<!-- 当前页 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmfixie/bpmcommon/css/guider.css">
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmfixie/bpmcommon/css/page1.css">
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
	<div class="guider">
		<div class="g-title">
			<div class="l"><i class="icon">&#xe677;</i><a href="javascript:void(0);"_target="todo" <c:if test="${tabType == 'todo' }">class="on"</c:if>>我的待办</a><span class="subtitle"></span><a href="javascript:void(0);"_target="read" <c:if test="${tabType == 'read' }">class="on"</c:if>>我的待阅</a></div>
			<div class="r"><i class="icon refresh">&#xe672;</i><a href="javascript:void(0);" id="more">更多 >></a></div>
		</div>
		<div class="g-body" <c:if test="${tabType == 'read' }">style="display:none"</c:if> id="todo">
			<c:if test="${todoTotal == 0 }">
				<table cellpadding="0" cellspacing="10" border="0" width="100%" class="newsTable">
					<tbody>
						<tr>
							<td class="title" align="left">暂无待办任务</td>
						</tr>
					</tbody>
				</table>
			</c:if>
			<c:if test="${todoTotal > 0 }">
				<table cellpadding="0" cellspacing="10" border="0" width="100%" class="newsTable">
					<tbody>
						<c:forEach items="${todoRows}" var="todo" varStatus="vs">
							<tr>
								<td width="30%" class="title" align="left">【${todo.processDefName }】</td>
								<td width="30%" align="left"><a href="javascript:void(0);" <c:if test="${todo.priority==2 || todo.priority==1}">class="redFlag"</c:if> onclick="flowUtils.executeTask('${todo.processInstance }','${todo.executionId }','${todo.dbid }','${todo.businessId }','${todo.formResourceName }','${todo.taskTitle }','${todo.taskType}')">${todo.taskTitle }</a></td>
								<td width="20%">${todo.taskSendUser }</td>
								<td width="15%">${fn:substring(todo.cTime, 0, 10)}</td>
								<%-- <td width="8%" align="right"><a href="javascript:void(0);" class="btn" onclick="flowUtils.quickDoTask('${todo.processInstance }','${todo.executionId }','${todo.dbid }','${todo.businessId }','${todo.formResourceName }','${todo.taskTitle }','${todo.taskType}')">办理</a></td> --%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
		<div class="g-body" <c:if test="${tabType == 'todo' }">style="display:none"</c:if> id="read">
			<c:if test="${readTotal == 0 }">
				<table cellpadding="0" cellspacing="10" border="0" width="100%" class="newsTable">
					<tbody>
						<tr>
							<td class="title" align="left">暂无待阅任务</td>
						</tr>
					</tbody>
				</table>
			</c:if>
			<c:if test="${readTotal > 0 }">
				<table cellpadding="0" cellspacing="10" border="0" width="100%" class="newsTable">
					<tbody>
						<c:forEach items="${readRows}" var="todo" varStatus="vs">
							<tr>
								<td width="30%" class="title" align="left">【${todo.processDefName }】</td>
								<td width="30%" align="left"><a href="javascript:void(0);" <c:if test="${todo.priority==2 || todo.priority==1}">class="redFlag"</c:if> onclick="flowUtils.executeTask('${todo.processInstance }','${todo.executionId }','${todo.dbid }','${todo.businessId }','${todo.formResourceName }','${todo.taskTitle }','${todo.taskType}')">${todo.taskTitle }</a></td>
								<td width="20%">${todo.taskSendUser }</td>
								<td width="15%">${fn:substring(todo.cTime, 0, 10)}</td>
								<td width="8%" align="right"><a href="javascript:void(0);" class="btn" onclick="flowUtils.quickDoTask('${todo.processInstance }','${todo.executionId }','${todo.dbid }','${todo.businessId }','${todo.formResourceName }','${todo.taskTitle }','${todo.taskType}')">已阅</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
	<script src="static/js/platform/component/common/json2.js" type="text/javascript"></script>
	<script type="text/javascript" src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.js" ></script>
	<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
	<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowButtons.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmcommon/js/guider.js"></script>
	<script type="text/javascript">
		//刷新本页面
		window.bpm_operator_refresh = function() {
			var tabType = $(".l>.on").attr("_target");
			var url = window.location.href;
			if(url.indexOf("tabType") != -1){
				url = url.replace(/tabType=(.)*/g, "tabType=" + tabType);
			}else{
				url = url + "&tabType=" + tabType;
			}
			window.location.replace(url);
		};
		$(function(){
			$(".refresh").on("click", function(){
				bpm_operator_refresh();
			});
			$(".l>a").on("click", function(){
				var target = $(this).attr("_target");
				var targetDom = $("#" + target);
				$(this).addClass('on').siblings("a").removeClass("on");
				targetDom.show();
				targetDom.siblings('.g-body').hide();
			});
			$("#more").on("click", function(){
				if(top && top.addTab){
					top.addTab("我的任务", "avicit/platform6/bpmfixie/bpmtask/bpmTaskManage.jsp");
				}
			});
		});
	</script>
</body>
</html>
