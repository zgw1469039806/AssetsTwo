<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
  String agent=request.getHeader("User-Agent").toLowerCase();

  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>页面不存在</title>
<link rel="stylesheet" href="login/style/css/style.css" />
<style type="text/css">
</style>
<script type="text/javascript"
	src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.min.js"></script>
<script>
$(window).resize(function() {
      init();
		});
 	$(function(){
 		init();
 	});
</script>
</head>
<body>
<script type="text/javascript">
   function returnLogin(){
	top.location.href = '<%=ViewUtil.getRequestPath(request)%>';
		}
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
	 				 $('body').css('background',"#ffffff");
	 				if(flag==true){
	 				add_cssForIE8 ()
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
	<div class="error_box" id="content">
		<div class="bg">
			<img src="login/style/image/404_bg_new.png" />
			<div class="icon ">
				<span>404</span>
			</div>
		</div>
		<h4 class="error_tit">抱歉！您访问的页面不存在</h4>
		<a style="cursor: pointer" onclick="returnLogin();return false;"
			class="back_home">返回首页</a>
	</div>
</body>
</html>
