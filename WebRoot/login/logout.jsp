<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<title>注销页面</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
</head>
<body topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
<script>
	var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
	window.location = baseUrl+'platform/user/logout';
</script>
</body>
</html>

