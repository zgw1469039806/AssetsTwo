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
		.monitor_inner{
			border-right:1px dashed #E8E8E8 ;
			text-align: center;
			padding: 10px 0;
		}
		.monitor_inner_top i{
			display: inline-block;
			color: #7AACEE;
			font-size: 32px;
			vertical-align: middle;
		}
		.monitor_inner_top p{
			font-size: 28px;
			color: #7D899D;
			line-height: 34px;
			margin: 0;
			display: inline-block;
			vertical-align: middle;
		}
		.monitor_title{
			font-size: 13px;
			color: #ADB9CA;
			text-align: center;
			margin-top: 10px;
		}
		.monitor_box td{
			vertical-align: middle;
		}
	</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
		<div class="monitor content_box"  style="left: 7px;bottom: 5px;">
			<!-- <div class="title_switch box_title ">
				<ul class="clearfix">
					<li class="act">
						<p>监控</p>
						<div class="title_switch_on"></div>
						<i class="item_number">(5)</i>
					</li>
				</ul>
				<div class="operation float-r">
					<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
					<a class="more-a" href="javascript:void(0);" data-src="platform/eform/bpmsCRUDClient/toViewJsp/SendFileView" data-title="文件"><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
				</div>
			</div> -->
			<div class="content_inner monitor_box" style="height: 120px;">
				<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td>
							<div class="monitor_inner">
								<div class="monitor_inner_top clearfix">
									<i class="icon iconfont icon-piechart"></i>
									<p>60%</p>
								</div>
								<div class="monitor_title">CPU占有率</div>
							</div>
						</td>
						<td>
							<div class="monitor_inner">
								<div class="monitor_inner_top clearfix">
									<i class="icon iconfont icon-team"></i>
									<p>150,00</p>
								</div>
								<div class="monitor_title">当前用户数</div>
							</div>
						</td>
						<td>
							<div class="monitor_inner"style="border: 0;">
								<div class="monitor_inner_top clearfix">
									<i class="icon iconfont icon-share"></i>
									<p>0.00</p>
								</div>
								<div class="monitor_title">网络流入速率</div>
							</div>
							
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>

</html>
