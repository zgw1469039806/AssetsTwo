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
		.todo {
			background: #FFFFFF;
		}
		.project_icon {
			display: inline-block;
			width: 48px;
			height: 48px;
			border-radius: 24px;
			text-align: center;
			line-height: 48px;
			font-size: 20px;
			vertical-align: top;
			position: absolute;
			left: 0;
			top: 0;
		}
		.project_tit {
			display: inline-block;
			margin-left: 4px;
			cursor: pointer;
		}
		.project_tit p {
			margin: 0;
			line-height: 24px;
			color: #3d4d65;
			font-size: 14px;
			overflow:hidden;
			text-overflow:ellipsis; 
			white-space:nowrap;
			max-width: 70%;
		}
		.project_tit:hover p {
			color: #297CE6;
		}
		.project_tit span {
			font-size: 12px;
			color: #ADB9CA;
			margin-right: 8px;
			line-height: 18px;
		}
		.project_chart {
			height: 8px;
			background: #F3F4F9;
			border-radius: 4px;
			margin-top: 4px;
		}
		.project_chart_inner {
			height: 8px;
			border-radius: 4px;
		}
		.time {
			font-size: 12px;
			color: #92A0B2;
			float: left;
			line-height: 24px;
			margin-left: 4px;
		}
		.chart_number {
			font-size: 18px;
			color: #297CE6;
			float: right;
			line-height: 24px;
			margin-right: 4px;
		}
		.project_inner {
			padding: 10px;
			border-bottom: 1px dashed #e8e8e8;
		}
		.project_top {
			margin-bottom: 4px;
			position: relative;
			padding-left: 52px;
		}
		/*进行中状态*/
		
		.project_blue .project_icon {
			background: #EAF2FD;
			color: #297CE6;
		}
		.project_blue .project_chart_inner {
			background: #7AACEE;
		}
		.project_blue .chart_number {
			color: #297CE6;
		}
		/*进行中状态*/
		/*遇到问题状态*/
		
		.project_org .project_icon {
			background: #FFF5E6;
			color: #FF9900;
		}
		.project_org .project_chart_inner {
			background: #FABE64;
		}
		.project_org .chart_number {
			color: #FF9900;
		}
		/*遇到问题状态*/
		/*已完成状态*/
		
		.project_green .project_icon {
			background: #EDFAF7;
			color: #48CFAE;
		}
		.project_green .project_chart_inner {
			background: #8CDECC;
		}
		.project_green .chart_number {
			color: #48CFAE;
		}
		/*已完成状态*/
	</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
		<div class="project content_box" style="right: 7px;">
			<!-- <div class="title_switch box_title ">
				<div class="title-text float-l">
					<i class="icon iconfont icon-message"></i>关注项目
				</div>
				</ul>
					<div class="operation float-r">
			<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
			<a class="more-a" href="javascript:void(0);" data-src="platform/eform/bpmsCRUDClient/toViewJsp/SendFileView" data-title="文件"><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
		</div>
			</div> -->
			<div class="content_inner project_box" style="height: 320px;">
				<ul>
					<li>
						<div class="project_inner project_green">
							<div class="project_top">
								<div class="project_icon ">M</div>
								<div class="project_tit">
									<p>M999型号研制项目</p>
									<div><span>责任人：张朝阳</span><span>责任部门：研发中心</span>
									</div>
								</div>
							</div>
							<div class="project_chart_box">
								<div class="clearfix">
									<span class="time">2019-10-04</span>
									<span class="chart_number">90%</span>
								</div>
								<div class="project_chart">
									<div class="project_chart_inner" style="width: 90%;"></div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="project_inner project_blue">
							<div class="project_top">
								<div class="project_icon ">J</div>
								<div class="project_tit">
									<p>J2019年科研专项J2019年科研专项J2019年科研专项</p>
									<div><span>责任人：张朝阳</span><span>责任部门：研发中心</span>
									</div>
								</div>
							</div>
							<div class="project_chart_box">
								<div class="clearfix">
									<span class="time">2019-10-04</span>
									<span class="chart_number">60%</span>
								</div>
								<div class="project_chart">
									<div class="project_chart_inner" style="width: 60%;"></div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<div class="project_inner project_org" style="border: 0;">
							<div class="project_top">
								<div class="project_icon ">M</div>
								<div class="project_tit">
									<p>M999型号研制项目</p>
									<div><span>责任人：张朝阳</span><span>责任部门：研发中心</span>
									</div>
								</div>
							</div>
							<div class="project_chart_box">
								<div class="clearfix">
									<span class="time">2019-10-04</span>
									<span class="chart_number">30%</span>
								</div>
								<div class="project_chart">
									<div class="project_chart_inner" style="width: 30%;"></div>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</body>
</html>

