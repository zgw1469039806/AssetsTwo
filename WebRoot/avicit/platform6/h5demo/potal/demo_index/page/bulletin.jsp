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
	.bulletin_text,.bulletin_tit{
		display: inline-block;
		vertical-align: middle;
		line-height: 40px;
		margin: 0;
	}
	.bulletin_list{
		padding: 0 10px;
		border-radius:4px ;
		cursor: pointer;
	}
	.bulletin_list:hover{
		background: #f3f4f9;
	}
	.bulletin_list:hover .bulletin_tit{
		color: #297CE6;
	}
	.bulletin_tit{
		font-size: 14px;
		color: #3d4d65;
		max-width: 240px;
		overflow: hidden;
   		text-overflow: ellipsis;
    	white-space: nowrap;
    	float: left;
		}
		.news{
			float: left;
			/* background: #FF6666; */
			color: #FF6666;
			text-align: center;
			display: inline-block;
			width: 42px;
			height: 18px;
			line-height: 18px;
			border-radius:4px;
			font-size: 12px;
			font-style: italic;
			margin:  11px 3px;
		}
		.bulletin_text{
			float: right;
		}
		.bulletin_text span{
			display: inline-block;
			font-size: 12px;
			color: #98A5BA;
			margin-left: 10px;
		}
	</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
		<div class="bulletin content_box">
			<div class="title_switch box_title ">
				<ul class="clearfix">
					<li class="act">
						<p>通知公告</p>
						<div class="title_switch_on"></div>
						<i class="item_number">(5)</i>
					</li>
				</ul>
			<div class="operation float-r">
				<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
				<a class="more-a" href="javascript:void(0);" data-src="platform/eform/bpmsCRUDClient/toViewJsp/SendFileView" data-title="文件"><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
			</div>
			</div>
			<div class="content_inner bulletin_box" style="height: 240px;">
				<ul>
					<li class="bulletin_list clearfix">
						<p class="bulletin_tit">Jdk和Tomcat版本查看（32位、64位）及官</p>
						<i class="news">NEWS</i>
						<div class="bulletin_text">
							<span>05-17</span><span>陈某某</span>
						</div>
					</li>
					<li class="bulletin_list clearfix">
						<p class="bulletin_tit">Jdk和Tomcat版本查看</p>
						<i class="news">NEWS</i>
						<div class="bulletin_text">
							<span>05-17</span><span>陈某某</span>
						</div>
					</li>
					<li class="bulletin_list clearfix">
						<p class="bulletin_tit">Jdk</p>
						<i class="news">NEWS</i>
						<div class="bulletin_text">
							<span>05-17</span><span>陈某某</span>
						</div>
					</li>
					<li class="bulletin_list clearfix">
						<p class="bulletin_tit">Jdk和Tomcat版本查看（32位、64位）及官...</p>
						<div class="bulletin_text">
							<span>05-17</span><span>陈某某</span>
						</div>
					</li>
					<li class="bulletin_list clearfix">
						<p class="bulletin_tit">Jdk和Tomcat版本查看（32位、64位）及官...</p>
						<div class="bulletin_text">
							<span>05-17</span><span>陈某某</span>
						</div>
					</li>
					<li class="bulletin_list clearfix">
						<p class="bulletin_tit">Jdk和Tomcat版本查看（32位、64位）及官...</p>
						<div class="bulletin_text">
							<span>05-17</span><span>陈某某</span>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</body>

</html>

