<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>提示</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="">
<meta http-equiv="description" content="">
<style type="text/css">
body {
	color: #666;
	text-align: center;
	font-family: Helvetica, 'microsoft yahei', Arial, sans-serif;
	margin: 0;
	width: 800px;
	margin: auto;
	font-size: 14px;
}

h1 {
	font-size: 56px;
	line-height: 100px;
	font-weight: normal;
	color: #456;
}

h2 {
	font-size: 24px;
	color: #666;
	line-height: 1.5em;
}

h3 {
	color: #456;
	font-size: 20px;
	font-weight: normal;
	line-height: 28px;
}

hr {
	margin: 18px 0;
	border: 0;
	border-top: 1px solid #EEE;
	border-bottom: 1px solid white;
}

a {
	color: #17bc9b;
	text-decoration: none;
}
</style>

</head>

<body style="background:#EEEEEE">
	<h1>No Support!</h1>
	<h3>流程设计器不支持IE8以下版本浏览器。</h3>
	<hr />
	<p style="font-size:16px;">
		为了获得更好的使用体验，我们强烈建议您升级到最新版本的IE浏览器，或者使用较新版本的 <span style="font-weight:bold;">Google Chrome</span>、 <span style="font-weight:bold;">Firefox</span>、 <span style="font-weight:bold;">Safari</span> 等。
	</p>
</body>
</html>
