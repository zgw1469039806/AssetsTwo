<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="X-UA-Compatible" content="IE=8">
<title>流程发起</title>
<!-- Bootstrap css file v2.2.1 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmfixie/bpmcommon/css/bootstrap.css">
<!-- 当前页 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmfixie/bpmcommon/css/newWorkflow-ie.css">
<!-- 换肤预留 -->
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
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
	<script type="text/javascript" src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.js" ></script>
	<script type="text/javascript" src="static/fixie/bsie/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmcommon/js/newWorkflow.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmbusiness/startflowlist/portal/viewPage.js"></script>
</body>
</html>
