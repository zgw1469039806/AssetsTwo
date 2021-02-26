<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<%
String skinsValue =  (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN_TYPE);
if(StringUtils.isEmpty(skinsValue)){
	skinsValue = "blue";
}
%>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>门户待办小页</title>
<link rel="stylesheet" type="text/css" href="static/h5/skin/iconfont/iconfont.css" />
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmbusiness/todo/todo.css" />
<link id="portlet-skin" rel="stylesheet" href="avicit/platform6/portal/portlet/skin/<%=skinsValue %>-portlet.css">
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
var todototal=${todoTotal};
var readtotal=${readTotal};
var pageSize=${pageSize};
</script>
</head>
<body style="background: #fff;overflow: hidden;">
	<div class="title-box clearfix">
		<div class="title-text float-l">
			<!-- <i class="icon iconfont icon-daiban"></i>  -->
			<a href="javascript:void(0);" _target="todo" <c:if test="${tabType == 'todo' }">class="active"</c:if>>我的待办 <c:if test="${todoTotal>0}">
				<em class="figure">(${todoTotal})</em>
				</c:if></a>
			<a href="javascript:void(0);" _target="read" <c:if test="${tabType == 'read' }">class="active"</c:if>>我的待阅 <c:if test="${readTotal>0}">
				<em class="figure">(${readTotal })</em>
			</c:if></a>
		</div>
		<div class="operation float-r">
			<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd" id="refresh"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
			<a class="more-a" href="javascript:void(0);" id="more" ><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
		</div>
	</div>
	<div class="content-body" <c:if test="${tabType == 'read' }">style="display:none"</c:if> id="todo">
		<c:if test="${todoTotal == 0 }">
			<table class="db-table" border="0" cellpadding="0" cellspacing="0">
				<td class="title" align="center">
					<div class="no_data">
						<img style="width: 100px; margin-top: 50px;" src="avicit/platform6/console/dashboard/images/no-data.png">
						<p>暂无待办任务</p>
					</div>
				</td>
			</table>
		</c:if>
		<c:if test="${todoTotal > 0 }">
			<table class="db-table" border="0" cellpadding="0" cellspacing="0">
				<c:forEach items="${todoRows}" var="todo" varStatus="vs">
					<tr>
						<td class="title">
						<a href="javascript:void(0);" class="link-title <c:if test="${todo.priority==2 || todo.priority==1}"> red-text</c:if>"
							onclick="flowUtils.executeTask('${todo.processInstance }','${todo.executionId }','${todo.dbid }','${todo.businessId }','${todo.formResourceName }','<c:out value="${todo.taskTitle }" escapeXml="true"/>','${todo.taskType}')">

								${fn:startsWith(todo.sendType,"doretreatto") ? "<span class='retreat'>退回：</span>" : ""}

							<span>${todo.processDefName }</span>----

							<span>${todo.taskTitle}</span>

						</a>
						</td>
						<!-- <td>
						</td> -->
						<td width="100px">${todo.taskSendUser }</td>
						<td width="80px" nowrap="nowrap">${fn:substring(todo.cTime, 0, 10)}</td>
						<c:if test="${hideQuickDo != 'true'}">
							<td width="60px;"  nowrap="nowrap"><a class="link-text" href="javascript:void(0);"
								onclick="flowUtils.quickDoTask('${todo.processInstance }','${todo.executionId }','${todo.dbid }','${todo.businessId }','${todo.formResourceName }','<c:out value="${todo.taskTitle }" escapeXml="true"/>','${todo.taskType}','${todo.taskName}')">办理</a>
							</td>
						</c:if>

					</tr>
				</c:forEach>
			</table>
			<div class="rmain">
				<a href="javascript:void(0);" onclick="window.todoGo('${todoPageNo-1}')"><i class="icon iconfont icon-xiangshangjiantou-mianxing"></i></a> <a href="javascript:void(0);"
					onclick="window.todoGo('${todoPageNo+1}')"><i class="icon iconfont icon-xiangxiajiantou-mianxing"></i></a>
			</div>
		</c:if>
	</div>
	<div class="content-body" <c:if test="${tabType == 'todo' }">style="display:none"</c:if> id="read">
		<c:if test="${readTotal == 0 }">
			<table class="db-table" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="title" align="center">
						<div class="no_data">
							<img style="width: 100px; margin-top: 50px;" src="avicit/platform6/console/dashboard/images/no-data.png">
							<p>暂无待阅任务</p>
						</div>
					</td>
				</tr>
			</table>
		</c:if>
		<c:if test="${readTotal > 0 }">
			<table class="db-table" border="0" cellpadding="0" cellspacing="0">
				<c:forEach items="${readRows}" var="todo" varStatus="vs">
					<tr>
						<td class="title">

							<a href="javascript:void(0);" class="link-title <c:if test="${todo.priority==2 || todo.priority==1}"> red-text</c:if>"
							onclick="flowUtils.executeTask('${todo.processInstance }','${todo.executionId }','${todo.dbid }','${todo.businessId }','${todo.formResourceName }','<c:out value="${todo.taskTitle }" escapeXml="true"/>','${todo.taskType}')">

							<span>${todo.processDefName }</span>----

							<span>${todo.taskTitle }</span>
							</a>

						</td>
						<!-- <td>

						</td> -->
						<td  width="100px">${todo.taskSendUser }</td>
						<td  width="80px">${fn:substring(todo.cTime, 0, 10)}</td>
						<td  width="60px;" nowrap="nowrap"><a class="link-text" href="javascript:void(0);"
							onclick="flowUtils.quickDoTask('${todo.processInstance }','${todo.executionId }','${todo.dbid }','${todo.businessId }','${todo.formResourceName }','<c:out value="${todo.taskTitle }" escapeXml="true"/>','${todo.taskType}')">已阅</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div class="rmain">
				<%-- 				<a href="javascript:void(0);" onclick="window.readGo('${readPageNo-1}')" class="fjpages"></a> --%>
				<%-- 				<a href="javascript:void(0);" onclick="window.readGo('${readPageNo+1}')" class="fjpagex"></a> --%>
				<a href="javascript:void(0);" onclick="window.readGo('${readPageNo-1}')"><i class="icon iconfont icon-xiangshangjiantou-mianxing"></i></a> <a href="javascript:void(0);"
					onclick="window.readGo('${readPageNo+1}')"><i class="icon iconfont icon-xiangxiajiantou-mianxing"></i></a>
			</div>
		</c:if>
	</div>
	<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
	<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowButtons.js"></script>
	<!-- 解决IE图标重绘问题公共js -->
	<script src="avicit/platform6/portal/js/redrawpseudoel.js"></script>
	<script type="text/javascript">
		//刷新本页面
		window.bpm_operator_refresh = function() {
			var tabType = $(".float-l>.active").attr("_target");
			var url = window.location.href;
			if(url.indexOf("tabType") != -1){
				url = url.replace(/tabType=(.)*/g, "tabType=" + tabType);
			}else{
			    if(url.indexOf("?") != -1){
                    url = url + "&tabType=" + tabType;
				}else{
                    url = url + "?tabType=" + tabType;
				}
			}
			window.location.replace(url);
		};
		$(function(){
			redrawPseudoEl();
			if(todototal<pageSize){
				$(".rmain").hide();
			}else{
				$(".rmain").show();
			}

			$("#refresh").on("click", function(){
				bpm_operator_refresh();
			});
			$(".float-l>a").on("click", function(){
				var target = $(this).attr("_target");
				if(target=="read"){
					if(readtotal<pageSize){
						$(".rmain").hide();
					}else{
						$(".rmain").show();
					 }
					}else{
						if(todototal<pageSize){
							$(".rmain").hide();
						}else{
							$(".rmain").show();
						}
					}
				var targetDom = $("#" + target);
				$(this).addClass('active').siblings("a").removeClass("active");
				targetDom.show();
				targetDom.siblings('.content-body').hide();
			});
			$("#more").on("click", function(){
				if(top && top.addTab){
					top.addTab("我的任务", "avicit/platform6/bpmreform/bpmbusiness/todo/taskTab.jsp");
				}
			});
		});

		function todoGo(num) {
			if (num <= 0) {
				layer.msg('当前已是第一页');
				return;
			}
			var maxPage = '${todoMaxPage}';
	 		if (num > maxPage) {
	 			layer.msg('当前已是最后一页');
				return;
			}
	 		var tabType = $(".float-l>.active").attr("_target");
			var url = window.location.href;
			if(url.indexOf("tabType") != -1){
				url = url.replace(/tabType=(.)*/g, "tabType=" + tabType);
			}else{
			    if(url.indexOf("?") != -1){
                    url = url + "&tabType=" + tabType;
				}else{
                    url = url + "?tabType=" + tabType;
				}
			}
			var pos = url.indexOf("todoPageNo"); //查看是否存在pageNum页数参数
			if (pos == "-1") {
				window.location.replace(url + '&todoPageNo=' + num); //不存在则添加,值为所点击的页数
			} else {
				var ui = String(url).substring(0, pos);
				window.location.replace(ui + 'todoPageNo=' + num); //存在,则刷新pageNum参数值
			}
		}
		function readGo(num) {
			if (num <= 0) {
				layer.msg('当前已是第一页');
				return;
			}
			var maxPage = '${readMaxPage}';
	 		if (num > maxPage) {
	 			layer.msg('当前已是最后一页');
				return;
			}
	 		var tabType = $(".float-l>.active").attr("_target");
			var url = window.location.href;
			if(url.indexOf("tabType") != -1){
				url = url.replace(/tabType=(.)*/g, "tabType=" + tabType);
			}else{
			    if(url.indexOf("?") != -1){
                    url = url + "&tabType=" + tabType;
				}else{
                    url = url + "?tabType=" + tabType;
				}
			}
			var pos = url.indexOf("readPageNo"); //查看是否存在pageNum页数参数
			if (pos == "-1") {
				window.location.replace(url + '&readPageNo=' + num); //不存在则添加,值为所点击的页数
			} else {
				var ui = String(url).substring(0, pos);
				window.location.replace(ui + 'readPageNo=' + num); //存在,则刷新pageNum参数值
			}
		}
	</script>
</body>
</html>
