<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
<title>流程发起</title>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<!-- 公用 样式 -->
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/bpmreform/bpmcommon/css/common.css">
<!-- 当前页 样式 -->
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/bpmreform/bpmbusiness/startflowlist/portal/newWorkflow.css">
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
	<div class="main">
		<div class="newWorkflow">
			<div class="nw-cont">				
				<div class="nw-body"></div>
			</div>
			<div class="nw-cont">								
					<c:forEach items="${result}" var="catalog">
								 <c:forEach items="${catalog.children}" var="processInfo"> 
												<a href="#" name="bpmDoFav"
													clsss="dropdown-toggle" data-toggle="dropdown"
													role="button" aria-haspopup="true" aria-expanded="false"><input
														type="hidden" value="${processInfo.pdId }"></a>
								</c:forEach>
					</c:forEach>
		</div>
	</div> 
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript"
		src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript"
		src="avicit/platform6/bpmreform/bpmbusiness/startflowlist/portal/viewPage.js"></script>
</body>
</html>
