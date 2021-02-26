<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>

<html>
<head>
<% 
 String host = ViewUtil.getRequestPath(request);
 Object oUrl =request.getSession().getAttribute(AfterLoginSessionProcess.LOGIN_SUCCESS_NEXT_URL);
 String sUrl="/login/console/toplogin.jsp";
 if(oUrl!=null){
	 sUrl=oUrl.toString();
 }
 String href =host+oUrl;
%>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<link href="../login/style/cmstop-error.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
function returnLogin(){
	top.location.href='<%=href%>';
}

</script>
</head>
<body>
	<div class="main">
    <p class="title">非常抱歉，您无权访问该界面</p>
    <a href="#" class="btn" onclick="returnLogin();">返回网站首页</a>
	</div>
</body>
</html>
