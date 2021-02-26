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
		.dasboard_chart{
			display: inline-block;
			vertical-align: middle;
			width: 140px;
    		text-align: center;
		}
		.dasboard_text{
			display: inline-block;
			vertical-align: middle;
			margin-left: 10px;
		}
		.dasboard_inner{
			border-right:1px dashed #E8E8E8 ;
		}
		.dasboard_box td{
			vertical-align: middle;
			text-align: center;
		}
		.dasboard_box .dasboard_text p{
			font-size: 28px;
			color: #7D899D;
			line-height: 34px;
			margin: 0;
			display: inline-block;
			vertical-align: middle;
		}
		.dasboard_box .dasboard_tit{
			font-size: 13px;
			color: #ADB9CA;
			text-align: center;
			margin-top: 10px;
		}
	</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
		<div class="dasboard content_box" style="left: 7px;top:5px">
			<!-- <div class="title_switch box_title ">
				<ul class="clearfix">
					<li class="act">
						<p>仪表盘</p>
						<div class="title_switch_on"></div>
						<i class="item_number">(5)</i>
					</li>
				</ul>
				<div class="operation float-r">
					<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
					<a class="more-a" href="javascript:void(0);" data-src="platform/eform/bpmsCRUDClient/toViewJsp/SendFileView" data-title="文件"><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
				</div>
			</div> -->
			<div class="content_inner dasboard_box" style="height: 120px;">
				<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td>
							<div class="dasboard_inner ">
								<div class="dasboard_chart">
									<img src="avicit/platform6/h5demo/potal/demo_index/image/dasboard.png" />
								</div>
								<div class="dasboard_text">
									<p>60%</p>
									<div class="dasboard_tit">压力仪表盘</div>
								</div>
								
							</div>
						</td>
						<td>
							<div class="dasboard_inner " style="border: 0;">
								<div class="dasboard_chart">
									<img src="avicit/platform6/h5demo/potal/demo_index/image/huanxingtu.png" />
								</div>
								<div class="dasboard_text">
									<p>60%</p>
									<div class="dasboard_tit">完成率</div>
								</div>
								
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>

</html>




