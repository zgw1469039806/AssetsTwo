<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>子流程模板</title>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<!-- 公用 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/common.css">
<!-- 当前页 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/newWorkflow.css">
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
	<div class="main">
		<div class="newWorkflow">
			<div class="nw-cont">
				<div class="nw-body">
					<c:forEach items="${result}" var="catalog">
						<div class="nw-list">
							<div class="nw-l-title">
								<span>${catalog.catalogName }</span>
							</div>
							<ul>
								<c:forEach items="${catalog.children}" var="processInfo">
									<li>
										<div class="nw-l-cont">
											<i class="icon icon-point"></i> <a href="javascript:void(0);" onclick="clickFlowModel('${processInfo.deploymentId }')">${processInfo.pdName } <c:if test="${showVersion == null || showVersion == undefined || showVersion == '1'}">V${processInfo.pdVersion }<span class="sub">(<c:choose><c:when test="${processInfo.isUflow != null && processInfo.isUflow == '2' }">自由流程</c:when><c:otherwise>固定流程</c:otherwise></c:choose>)</span></c:if></a>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script>
		//ie9以上美化滚动条
		function perfectScroll(dom) {
			dom.perfectScrollbar();
		}
		//美化滚动条
		$(function() {
			perfectScroll($('body'));
		});
		function clickFlowModel(deploymentId){
			parent._bpm_BpmStartsubflow.executeUserInfo(deploymentId);
		}
	</script>
</body>
</html>
