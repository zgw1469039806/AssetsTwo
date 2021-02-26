<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%response.setStatus(HttpServletResponse.SC_OK);%>
<%
	String errorTitle = "";
	String errorDetail = "";
	if (exception != null){
		errorTitle = exception.getMessage();
		StringWriter sw = new StringWriter();
		exception.printStackTrace(new PrintWriter(sw));
		errorDetail = sw.toString();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=ViewUtil.getRequestPath(request) %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>软件错误</title>
<link rel="stylesheet" href="login/style/css/style.css" />

<script type="text/javascript" src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="static/js/platform/portal/jquery-ui-1.10.4.custom.min.js"></script>
<script type="text/javascript">
function showHideDetail(){
	$("#error").toggle();
}
</script>
</head>
<body>
<div class="error_box function_error"  id="content">
			<div class="bg">
				<img src="login/style/image/404_bg_new.png" />
				<div class="icon ">
					<span>500</span>
				</div>
			</div>
			<h4 class="error_tit">对不起，软件运行发生了错误</h4>
			<p class="error_p">
				错误内容：<span><%=errorTitle %></span>
			</p>
			<div class="function_error_btn"><a href="javascript:showHideDetail();" class="function_error_a " >查看详细错误信息</a></div>
			<div  id="error" class="error_text error_text_open"><%=errorDetail %></div>
		</div>
</body>
</html>
