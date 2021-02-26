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
		.dynamic_box{
			overflow: auto;
		}
		.dynamic_inner{
			position: relative;
			padding-left: 40px;
			min-height: 60px;
			}
		.dynamic_left{
			position: absolute;
			left: 0;
			top: 0;
		}
		.dynamic_left .icon_box{
			width: 28px;
			height: 28px;
			border-radius:16px ;
			border: 1px solid #e8e8e8;
			background: #FFFFFF;
			z-index: 1;
			text-align: center;
			line-height: 28px;
		}
		.dynamic_text h4{
			font-size: 14px;
			line-height:28px;
			color: #54657E;
			font-weight:600;
			display: inline-block;
			vertical-align: middle;
		}
		.dynamic_text span{
			font-size: 14px;
			line-height: 28px;
			color: #3d4d65;	
			display: inline-block;
			vertical-align: middle;
		}
		.dynamic_inner .time{
			font-size: 12px;
			line-height: 24px;
			color: #ADB9CA;
			margin-top: -4px;
    		display: block;
		}
		.icon_box .icon{
			display: inline-block;
			font-size:18px ;
			color: #48CFAE;
			
			border-radius:12px ;
		}
		.line{
			position: absolute;
			left: 14px;
			top: 16px;
			bottom: 0;
			width: 1px;
			background: #e8e8e8;
		}
		.last_list .line{
			display: none;
		}
	</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
		
		<div class="dynamic content_box">
			<!-- <div class="title_switch box_title ">
				<ul class="clearfix">
					<li class="act">
						<p>最新动态</p>
						<div class="title_switch_on"></div>
						<i class="item_number">(5)</i>
					</li>
				</ul>
				<div class="operation float-r">
					<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
					<a class="more-a" href="javascript:void(0);" data-src="platform/eform/bpmsCRUDClient/toViewJsp/SendFileView" data-title="文件"><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
				</div>
			</div> -->
			<div class="content_inner dynamic_box" style="height: 300px;">
				<div class="">
					<ul>
						<li>
							<div class="dynamic_inner">
								<div class="line"></div>
								<div class="dynamic_left">
									<div class="icon_box">
										<i class="icon iconfont icon-time-circle-fill"></i>
									</div>
								</div>
								<div class="dynamic_text">
									<h4>张三</h4>
									<span>登录系统，进行修改密码操作</span>
								</div>
								<span class="time">4小时之前</span>
							</div>
						</li>
						<li>
							<div class="dynamic_inner">
								<div class="line"></div>
								<div class="dynamic_left">
									<div class="icon_box">
										<i class="icon iconfont icon-time-circle-fill"></i>
									</div>
								</div>
								<div class="dynamic_text">
									<h4>张三</h4>
									<span>登录系统，进行修改密码操作</span>
								</div>
								<span class="time">4小时之前</span>
							</div>
						</li>
						<li>
							<div class="dynamic_inner">
								<div class="line"></div>
								<div class="dynamic_left">
									<div class="icon_box">
										<i class="icon iconfont icon-time-circle-fill"></i>
									</div>
								</div>
								<div class="dynamic_text">
									<h4>张三</h4>
									<span>登录系统，进行修改密码操作</span>
								</div>
								<span class="time">4小时之前</span>
							</div>
						</li>
						<li>
							<div class="dynamic_inner">
								<div class="line"></div>
								<div class="dynamic_left">
									<div class="icon_box">
										<i class="icon iconfont icon-time-circle-fill"></i>
									</div>
								</div>
								<div class="dynamic_text">
									<h4>张三</h4>
									<span>登录系统，进行修改密码操作</span>
								</div>
								<span class="time">4小时之前</span>
							</div>
						</li>
						<li>
							<div class="dynamic_inner">
								<div class="line"></div>
								<div class="dynamic_left">
									<div class="icon_box">
										<i class="icon iconfont icon-time-circle-fill"></i>
									</div>
								</div>
								<div class="dynamic_text">
									<h4>张三</h4>
									<span>登录系统，进行修改密码操作</span>
								</div>
								<span class="time">4小时之前</span>
							</div>
						</li>
						<li>
							<div class="dynamic_inner">
								<div class="line"></div>
								<div class="dynamic_left">
									<div class="icon_box">
										<i class="icon iconfont icon-time-circle-fill"></i>
									</div>
								</div>
								<div class="dynamic_text">
									<h4>张三</h4>
									<span>登录系统，进行修改密码操作</span>
								</div>
								<span class="time">4小时之前</span>
							</div>
						</li>
						<li class="last_list">
							<div class="dynamic_inner">
								<div class="line"></div>
								<div class="dynamic_left">
									<div class="icon_box">
										<i class="icon iconfont icon-time-circle-fill"></i>
									</div>
								</div>
								<div class="dynamic_text">
									<h4>张三</h4>
									<span>登录系统，进行修改密码操作</span>
								</div>
								<span class="time">4小时之前</span>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
		
	</body>

</html>







