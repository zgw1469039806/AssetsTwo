<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<title>注销页面</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<script type="text/javascript" src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.min.js"></script>
</head>
<body topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
<!--单点需要配置单点退出地址  http://cas.avicit.com/cas3/logout-->
<iframe style="height: 0px;" src = "http://localhost/cas/logout"></iframe>
	<%
		/*执行注销的过程*/
		//String loginurl = "login.jsp";
		//String loginurl = "http://222.avicit.org:8080/cas3/logout?service=http://222.avicit.org:8080/cas3/login";
		session.invalidate();
	%>
	
</body>
<script type="text/javascript">
$(function(){
	var path = "<%=ViewUtil.getRequestPath(request)%>";
	window.location = path+'index.jsp';
});

</script>
</html>

