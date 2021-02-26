<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<%
String skinsValue =  (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN_TYPE);
if(StringUtils.isEmpty(skinsValue)){
	 skinsValue = "blue";
}
%>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>demo1</title>
<link rel="stylesheet" type="text/css" href="static/h5/skin/iconfont/iconfont.css"/>
<link id = "portlet-skin" rel="stylesheet" href="avicit/platform6/portal/portlet/skin/<%=skinsValue %>-portlet.css">
<style type="text/css">
.content-empty:after,
.content-empty:before{
  content:"" !important;
}
</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
	<div class="content-body">
		<ul class="news-list">
			<li class="list-li news-hot1"><em class="list-number">1</em> <a
				class="list-link" href="javascript:void(0);">系统上线参数配置及优化</a></li>
			<li class="list-li news-hot2"><em class="list-number">2</em> <a
				class="list-link" href="javascript:void(0);">Jdk和Tomcat版本查看（32位、64位）及官...</a></li>
			<li class="list-li news-hot3"><em class="list-number">3</em> <a
				class="list-link" href="javascript:void(0);">V5平台保密整改补丁及说明文档</a></li>
			<li class="list-li"><em class="list-number">4</em> <a
				class="list-link" href="javascript:void(0);">平台V6R3.2.3保密整改方案</a></li>
			<li class="list-li"><em class="list-number">5</em> <a
				class="list-link" href="javascript:void(0);">流程-sql节点开发文档</a></li>
			<li class="list-li"><em class="list-number">6</em> <a
				class="list-link" href="javascript:void(0);">润乾报表最新License </a></li>
			<li class="list-li"><em class="list-number">7</em> <a
				class="list-link" href="javascript:void(0);">平台V6R3.2.3保密整改方案</a></li>
			<li class="list-li"><em class="list-number">8</em> <a
				class="list-link" href="javascript:void(0);">流程-sql节点开发文档</a></li>
		</ul>
	</div>
	<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
	<!-- 解决IE图标重绘问题公共js -->
    <script src="avicit/platform6/portal/js/redrawpseudoel.js"></script>
	<script type="text/javascript">
   $(function() {
	   redrawPseudoEl();
       var _baseUrl = '<%=ViewUtil.getRequestPath(request)%>';
       $('.icon-ziyuan').on('click',function(){
    	   if(top && top.addTab){
				top.addTab("通知公告", "avicit/platform6/h5demo/potal/demo_index3/page/notice.jsp");
			}
       });
       $('.icon-shuaxin').on('click',function(){
    	   window.location.reload()
       });
	});
</script>
</body>
</html>
