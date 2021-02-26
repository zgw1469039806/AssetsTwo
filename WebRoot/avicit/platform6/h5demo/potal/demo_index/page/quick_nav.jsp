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

<link rel="stylesheet" href="avicit/platform6/h5demo/potal/demo_index/css/index.css" />
<link id = "portlet-skin" rel="stylesheet" href="avicit/platform6/portal/portlet/skin/<%=skinsValue %>-portlet.css">




<style type="text/css">
.content-empty:after,
.content-empty:before{
  content:"" !important;
}
</style>
<style>
		.quick_nav_box li{
			float: left;
			width: 33.33%;
		}
		.quick_nav_link{
			display: block;
			height: 32px;
			background: #f3f4f9;
			margin: 7px;
			padding: 0 7px;
		}
		.quick_nav_link .icon{
			display: inline-block;
			width: 18px;
			height: 18px;
			margin:0 7px;
			color: #ADB9CA;
			vertical-align: middle;
		}
		.quick_nav_link{
			outline: none;
			text-decoration:none ;
			color: #3d4d65;
			font-size: 14px;
			border-radius:4px ;
		}
		.quick_nav_link span {
			display: inline-block;
			line-height: 32px;
			vertical-align: middle;
		}
		.quick_nav_link:hover {
			background: #297CE6;
			color: #FFFFFF;
		}
		.quick_nav_link:hover .icon {
			color: #FFFFFF;
		}
	</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
		
		<div class="quick_nav content_box">
			<!-- <div class="title_switch box_title ">
				<ul class="clearfix">
					<li class="act">
						<p>快捷入口</p>
						<div class="title_switch_on"></div>
						<i class="item_number">(5)</i>
					</li>
				</ul>
				<div class="operation float-r">
					<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
					<a class="more-a" href="javascript:void(0);" data-src="platform/eform/bpmsCRUDClient/toViewJsp/SendFileView" data-title="文件"><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
				</div>
			</div> -->
			<div class="content_inner quick_nav_box" style="height:110px;">
				<ul>
					<li>
						<a href="####" class="quick_nav_link">
							<i class="icon iconfont icon-jingfeibaozhang"></i><span>我的经费</span>
						</a>
					</li>
					<li>
						<a href="####" class="quick_nav_link">
							<i class="icon iconfont icon-chucha"></i><span>我的出差</span>
						</a>
					</li>
					<li>
						<a href="####" class="quick_nav_link">
							<i class="icon iconfont icon-huiyishi"></i><span>会议申请</span>
						</a>
					</li>
					<li>
						<a href="####" class="quick_nav_link">
							<i class="icon iconfont icon-qingjiashenqing"></i><span>我的请假</span>
						</a>
					</li>
					<li>
						<a href="####" class="quick_nav_link">
							<i class="icon iconfont icon-custom-office"></i><span>办公用品</span>
						</a>
					</li>
					<li>
						<a href="####" class="quick_nav_link">
							<i class="icon iconfont icon-add"></i><span>添加更多</span>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</body>

</html>








