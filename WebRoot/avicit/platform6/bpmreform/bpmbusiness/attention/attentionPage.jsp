<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>我的关注小页</title>
<!-- 公用 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/normalize.css">
<!-- 当前页 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/guider.css">
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/page1.css">
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
	<div class="guider">
		<div class="g-title">
			<div class="l"><i class="icon icon-wodedaiban"></i><a href="javascript:void(0);" _target="attention">我的关注</a></div>
			<div class="r"><i class="icon icon-shuaxin refresh"></i> <a href="javascript:void(0);" id="more">更多 >></a></div>
		</div>
		<div class="g-body" <c:if test="${tabType == 'att' }">style="display:none"</c:if> id="todo">
			<c:if test="${todoTotal == 0 }">
				<table cellpadding="0" cellspacing="10" border="0" width="100%" class="newsTable">
					<tbody>
						<tr>
							<td class="title" align="left">暂无关注任务</td>
						</tr>
					</tbody>
				</table>
			</c:if>
			<c:if test="${todoTotal > 0 }">
				<table cellpadding="0" cellspacing="10" border="0" width="100%" class="newsTable">
					<tbody>
						<c:forEach items="${todoRows}" var="att" varStatus="vs">
							<tr>
								<td width="30%" class="title" align="left">【${att.processDefName }】</td>
								<td width="30%" align="left"><a href="javascript:void(0);" <c:if test="${att.priority==2 || att.priority==1}">class="redFlag"</c:if> onclick="flowUtils.executeTask('${att.processInstance }','${att.executionId }','${att.dbid }','${att.businessId }','${att.formResourceName }','${att.taskTitle }','${att.taskType}')">${att.taskTitle }</a></td>
								<td width="30%" class="priority" align="left"><c:if test="${att.priority==0}">一般</c:if><c:if test="${att.priority==1}">急</c:if><c:if test="${att.priority==2}">特急</c:if></td>
								<td width="20%">${att.taskSendUser }</td>
								<td width="15%">${fn:substring(att.cTime, 0, 10)}</td>
								<td width="8%" align="right"><a href="javascript:void(0);" class="btn" onclick="flowUtils.attTask('${att.dbid }')">取消关注</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
	
	<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
	<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowButtons.js"></script>
	<script type="text/javascript">
		//刷新本页面
		window.bpm_operator_refresh = function() {
			var tabType = $(".l>.on").attr("_target");
			var url = window.location.href;
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
					top.addTab("我的关注", "bpm/taskPage//bpmTaskPage");
				}
			});
		});
	</script>
</body>
</html>
