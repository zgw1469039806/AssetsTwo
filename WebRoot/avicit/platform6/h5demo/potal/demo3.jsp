<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
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
	<div class="title-box clearfix">
		<div class="title-text float-l">
			<i class="icon iconfont icon-gongju-fill"></i>常用工具
		</div>
		<div class="operation float-r">
			<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
			<a class="more-a" href="javascript:void(0);" data-src="platform/eform/bpmsCRUDClient/toViewJsp/SendFileView" data-title="文件"><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
		</div>
	</div>
	<div class="content-body">
		<ul class="quicklinksUl quicklinks-list clearfix">
			<li class="quicklinks-li">
				<a class="quicklinks-link" href="javascript:void(0);">
					<p class="quicklinksP clearfix">
						<i class="icon iconfont icon-jingfeibaozhang commonOne"></i>
						<span class="quicklinks-text">我的经费</span>
					</p>
				</a>
			</li>
			<li class="quicklinks-li">
				<a class="quicklinks-link" href="javascript:void(0);">
					<p class="quicklinksP clearfix">
						<i class="icon iconfont icon-medal-fill commonTwo"></i>
						<span class="quicklinks-text">我的奖惩</span>
					</p>
				</a>
			</li>
			<li class="quicklinks-li">
				<a class="quicklinks-link" href="javascript:void(0);">
					<p class="quicklinksP clearfix">
						<i class="icon iconfont icon-shengchengcaijichengguo commonThree"></i>
						<span class="quicklinks-text">我的成果</span>
					</p>
				</a>
			</li>
			<li class="quicklinks-li">
				<a class="quicklinks-link" href="javascript:void(0);">
					<p class="quicklinksP clearfix">
						<i class="icon iconfont icon-qingjiashenqing commonFour"></i>
						<span class="quicklinks-text">我的请假</span>
					</p>
				</a>
			</li>
			<li class="quicklinks-li">
				<a class="quicklinks-link" href="javascript:void(0);">
					<p class="quicklinksP clearfix">
						<i class="icon iconfont icon-putongbaoxiao commonFive"></i>
						<span class="quicklinks-text">我的报销</span>
					</p>
				</a>
			</li>
			<li class="quicklinks-li">
				<a class="quicklinks-link" href="javascript:void(0);">
					<p class="quicklinksP clearfix">
						<i class="icon iconfont icon-chucha commonSix"></i>
						<span class="quicklinks-text">我的出差</span>
					</p>
				</a>
			</li>
			<li class="quicklinks-li">
				<a class="quicklinks-link" href="javascript:void(0);">
					<p class="quicklinksP clearfix">
						<i class="icon iconfont icon-huiyishi commonSeven"></i>
						<span class="quicklinks-text">会议申请</span>
					</p>
				</a>
			</li>
			<li class="quicklinks-li">
				<a class="quicklinks-link" href="javascript:void(0);">
					<p class="quicklinksP clearfix">
						<i class="icon iconfont icon-iconbangong commonEight"></i>
						<span class="quicklinks-text">办公用品</span>
					</p>
				</a>
			</li>
		</ul>
	</div>
	<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
	<!-- 解决IE图标重绘问题公共js -->
   <script src="avicit/platform6/portal/js/redrawpseudoel.js"></script>
		<script type="text/javascript">
   $(function() {
	   redrawPseudoEl();
       var _baseUrl = '<%=ViewUtil.getRequestPath(request)%>';
       $('.more-a').on('click',function(){
    	   if(top && top.addTab){
				top.addTab("常用工具", "avicit/platform6/h5demo/potal/demo3.jsp");
			}
       });
       $('.refresh-a').on('click',function(){
    	   window.location.reload();
       });
	});
</script>
</body>
</html>
