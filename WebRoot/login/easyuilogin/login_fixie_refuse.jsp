<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.verifycode.VerifyCodeUtil"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="avicit.platform6.core.locale.PlatformLocalesJSTL"%>
<%@page import="java.util.Locale"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String host = request.getContextPath();
	
	//首次登录的问题
	Object _m=session.getAttribute("_&_");
	session.removeAttribute("_&_");
	String _title= (String) session.getAttribute("exception_msg_");
	String userId = (String)session.getAttribute("_&_U");
	/* 判断是否存在登录失败的情况 */
	String exception_msg_ = _title;
	//移除登录信息
	session.removeAttribute("exception_msg_");
	
%>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit|ie-stand">
    <link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico" type="image/x-icon">
    <meta charset="utf-8" />
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
    <meta name="description" content="">

    <title>业务基础平台-控制台</title>
</head>

<body style="background-color: darkgrey;">


	<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
    <!--[if IE 6]>
		<script src="avicit/platform6/login/js/jquery.pngFix.pack.js"></script>
	<![endif]-->

	<script>
		$(function(){
            layer.open({
                type: 1,
                title: false,
                area: ['630px', '360px'],
                shade: 0.3,
                closeBtn: 0,
                shadeClose: true,
                content:  $('#tips')

            });
		});

	</script>
</body>
<div id="tips">
	<div style="height: 30px;width:100%;border-bottom:2px solid yellow;">
		<h4 style="margin-bottom: 2px;margin-left: 2px;">提示</h4>
	</div>
	<div style="height: 40px;width:100%;border-top:2px solid yellow;">
		&nbsp;&nbsp;您当前浏览器版过低，无法使用【业务基础平台-管理控制端】，建议使用<img border="0" src="login/easyuilogin/img/browsers-bg.png" style="width: 66px;height: 30px;" >等高版本浏览器。
		<br/>
		可以继续使用<a href="portal">【业务基础平台-Portal端】</a>
	</div>
</div>

</html>