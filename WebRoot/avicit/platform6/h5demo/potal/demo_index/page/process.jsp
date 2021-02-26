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
		.process_inner{
			height: ;
		}
		.process_box li{
			float: left;
			width: 50%;
		}
		.process_inner{
			height: 96px;
			border: 1px solid #F0F2F4;
			margin:7px;
			border-radius:4px ;
			position: relative;
			padding-left: 50px;
			background: url(avicit/platform6/h5demo/potal/demo_index/image/process_bg.png) no-repeat right;
			cursor: po
		}
		.process_inner .icon{
			font-size:24px;
			position: absolute;
			left: 10px;
			top: 18px;
		}
		.process_txt{
			padding: 10px 0;
		}
		.process_txt p{
			margin:0;
			font-size: 14px;
			color: #3d4d65;
			line-height: 32px;
		}
		.process_txt span{
			display: block;
			font-size: 14px;
			color: #ADB9CA;
			line-height: 20px;
			padding-right: 10px;
		}
	</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
		
		<div class="process content_box">
			<!-- <div class="title_switch box_title ">
				<ul class="clearfix">
					<li class="act">
						<p>常用流程</p>
						<div class="title_switch_on"></div>
						<i class="item_number">(5)</i>
					</li>
				</ul>
					<div class="operation float-r">
					<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
					<a class="more-a" href="javascript:void(0);" data-src="platform/eform/bpmsCRUDClient/toViewJsp/SendFileView" data-title="文件"><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
				</div>
			</div> -->
			<div class="content_inner process_box" style="height: 340px;">
				<ul class="clearfix">
					<li>
						<div class="process_inner">
							<div class="icon iconfont icon-chucha"  style="color: #34B3F8;"></div>
							<div class="process_txt">
								<p>差旅费报销V1</p>
								<span>(固定流程)</span>
							</div>
						</div>
					</li>
					<li>
						<div class="process_inner">
							<div class="icon iconfont icon-shengchengcaijichengguo"  style="color: #48CFAE;"></div>
							<div class="process_txt">
								<p>项目立项</p>
								<span>(预先技术研究、共用基础表)</span>
							</div>
						</div>
					</li>
					<li>
						<div class="process_inner">
							<div class="icon iconfont icon-custom-official-b"  style="color: #FF6666;"></div>
							<div class="process_txt">
								<p>合同管理</p>
								<span>(预先技术研究、共用基础表)</span>
							</div>
						</div>
					</li>
					<li>
						<div class="process_inner">
							<div class="icon iconfont icon-shujuku"  style="color: #FFCC00;"></div>
							<div class="process_txt">
								<p>差旅费报销V1</p>
								<span>(固定流程)</span>
							</div>
						</div>
					</li>
					<li>
						<div class="process_inner">
							<div class="icon iconfont icon-group" style="color: #FFCC00;"></div>
							<div class="process_txt">
								<p>会议室申请</p>
								<span>(预先技术研究、共用基础表)</span>
							</div>
						</div>
					</li>
					<li>
						<div class="process_inner">
							<div class="icon iconfont icon-tags-fill" style="color: #34B3F8;"></div>
							<div class="process_txt">
								<p>合同管理</p>
								<span>(预先技术研究、共用基础表)</span>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		
	</body>

</html>

