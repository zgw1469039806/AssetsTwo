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
		body{
			background: #eceff4;
		}
	    .top_card{
	    	margin: 0 -7px;
	    }
		.top_card_list{
			float: left;
			width: 25%;
		}
		.top_card_box{
			margin: 0 7px;
			height: 92px;
			background: #FFFFFF;
			border-radius:4px ;
			padding: 14px 20px;
			position: relative;
			box-sizing:content-box;
		}
		.card_title{
			font-size: 16px;
			color: #98A5BB;
			font-weight: 600;
			margin-bottom: 20px;
		}
		.card_inner{
			padding: 6px 0;
		}
		.card_number{
			display: inline-block;
			font-size: 32px;
			color: #7D899D;
			line-height: 32px;
			vertical-align: middle;
		}
			.card_number{
				font-size: 20px;
			}
			.chart_sm_box{
				margin-top: 10px;
			}
		.card_tag {
			width: 74px;
			height: 32px;
			color: #FFFFFF;
			line-height: 32px;
			text-align: center;
			border-radius:16px ;
			display: inline-block;
			vertical-align: middle;
			margin-left: 14px;
		}
		.tag_blue{background: #85c1fb;}
		.tag_green{background: #55d1b4;}
		.progress_box{
			display: inline-block;
			height: 12px;
			background: #f3f4f9;
			width: 64%;
			border-radius:6px ;
			float: right;
			margin-top: 10px;
		}
		.progress{
			height: 12px;
			border-radius:6px ;
			background: #297CE6;
		}
		.chart_sm_box{
			display: inline-block;
			width: 64%;
			border-radius:6px ;
			float: right;
		}
		.top_card_box .icon{
			position: absolute;
			right: 20px;
			top: 10px;
			color: #f3f4f9;
			font-size: 46px;
		}
		.chart_sm_box img{
			width: 100%;
		}
		@media only screen and (min-width: 1024px) and (max-width:1366px) {
		}
	</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body style="overflow: hidden;">
		<div class="top_card">
			<ul class="clearfix">
				<li class="top_card_list">
					<div class="top_card_box">
						<i class="icon iconfont icon-transaction"></i>
						<h4 class="card_title">项目金额总览</h4>
						<div class="card_inner">
							<span class="card_number">¥15,000.032</span><span class="card_tag tag_blue">+15%</span>
						</div>
					</div>
				</li>
				<li class="top_card_list">
					<div class="top_card_box">
						<i class="icon iconfont icon-reloadtime"></i>
						<h4 class="card_title">当月任务总数统计</h4>
						<div class="card_inner">
							<span class="card_number">150</span><span class="card_tag tag_green ">+15%</span>
						</div>
					</div>
				</li>
				<li class="top_card_list">
					<div class="top_card_box">
						<i class="icon iconfont icon-piechart"></i>
						<h4 class="card_title">当月任务完成情况总览</h4>
						<div class="card_inner">
							<span class="card_number">72%</span>
							<div class="progress_box">
								<div class="progress" style="width: 72%;"></div>
							</div>
						</div>
					</div>
				</li>
					<li class="top_card_list">
					<div class="top_card_box">
						<i class="icon iconfont icon-dashboard"></i>
						<h4 class="card_title">访问量</h4>
						<div class="card_inner">
							<span class="card_number">8,846</span>
							<div class="chart_sm_box">
								<div class="chart_sm" >
									<img src="avicit/platform6/h5demo/potal/demo_index/image/chart_sm.png" />
								</div>
							</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</body>

</html>

