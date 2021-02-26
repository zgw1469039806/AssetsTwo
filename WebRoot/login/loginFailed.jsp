<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
<% 
 String host = ViewUtil.getRequestPath(request);
 Object oUrl =request.getSession().getAttribute(AfterLoginSessionProcess.LOGIN_SUCCESS_NEXT_URL);
 String sUrl="/login/toplogin.jsp";
 if(oUrl!=null){
	 sUrl=oUrl.toString();
 }
 String href =host+oUrl;
%>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<link rel="stylesheet" href="style/css/style.css" />
<script type="text/javascript"
	src="<%=host %>/static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.min.js">
</script>
<script type="text/javascript">
    function returnLogin(){
	top.location.href='<%=href%>';
   }
    $(window).resize(function() {
    init();
		});
	$(function(){
		init();
	});
	//判断是否是IE8浏览器
	function isIE8() {
		if (navigator.userAgent.indexOf("MSIE 8.0") > -1
				|| navigator.userAgent.indexOf("MSIE 9.0") > -1) {
			return true;
		} else {
			return false;
		}
	}
	function init(){
		var flag=isIE8();
 			var width=$(document).width()
 			if(width<1000){
 				$('body').css('background'," #ffffff");
 				if(flag==true){
 				add_cssForIE8()
 				}else{
 	 				$('#content').removeClass("ie8");
 	 			}
 			}else{
 				$('body').css('background'," #f3f4f9");
 			}
 		   
	}
	function add_cssForIE8() {
		$('#content').addClass("ie8");
	} 
</script>
</head>
<body>
	<div class="error_box" id="content">
			<div class="bg">
				<img src="style/image/404_bg_new.png" />
				<div class="icon ">
					<img src="style/image/lock.png" />
				</div>
			</div>
			<h4 class="error_tit">非常抱歉！您无权访问该页面</h4>
			<a style="cursor: pointer" onclick="returnLogin();" class="back_home">返回首页</a>
		</div>
</body>
</html>
