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
		.task_box th {
			background: #edf0f5;
			line-height: 32px;
			font-size: 14px;
			font-weight: 400;
			color: #484848;
			padding: 0 10px;
			border-right: 1px solid #FFFFFF;
		}
		.task_box td {
			padding: 0 10px;
			text-align: center;
			line-height: 34px;
			border-bottom: 1px solid #edf0f5;
			border-top: 1px solid #FFFFFF;
			font-size: 12px;
			color: #666666;
		}
		.task_box td.text_right {
			text-align: right;
		}
		.task_box tr {
			cursor: pointer;
		}
		.task_box tr:hover td {
			background: #dfebfb;
			border-color: #94bdf2;
		}
		.task_chart {
			text-align: center;
			margin-bottom: 20px;
			height: 240px;
		}
		.task_table_box{
			padding: 0 10px;
		}
	</style>
<script type="text/javascript">
var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
<body>
		<div class="task content_box">
			<!-- <div class="title_switch box_title ">
				<ul class="clearfix">
					<li class="act">
						<p>关注任务</p>
						<div class="title_switch_on"></div>
						<i class="item_number">(5)</i>
					</li>
				</ul>
				<div class="operation float-r">
					<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
					<a class="more-a" href="javascript:void(0);" data-src="platform/eform/bpmsCRUDClient/toViewJsp/SendFileView" data-title="文件"><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
				</div>
			</div> -->
			<div class="content_inner task_box" style="height: 480px;">
				<div class="task_chart">
					<img src="avicit/platform6/h5demo/potal/demo_index/image/task_chart.png" />
				</div>
				<div>
					<table width="100%" cellspacing="0" border="0">
						<tr>
							<th style="width: 12px;"></th>
							<th>费用类型</th>
							<th class=" text_right">总经费(万元)</th>
							<th class=" text_right">总预算(万元)</th>
							<th class=" text_right">实际花费(万元)</th>
							<th class=" text_right">节超支情况(万元)</th>
						</tr>
						<tr>
							<td>1</td>
							<td>外协费</td>
							<td class="text_right">1,100,000</td>
							<td class="text_right">2,000,000</td>
							<td class="text_right">1,000,000</td>
							<td class="text_org text_right">-20,000</td>
						</tr>
						<tr>
							<td>2</td>
							<td>设备费</td>
							<td class="text_right">1,100,000</td>
							<td class="text_right">2,000,000</td>
							<td class="text_right">1,000,000</td>
							<td class=" text_right">20,000</td>
						</tr>
						<tr>
							<td>3</td>
							<td>管理费</td>
							<td class="text_right">1,100,000</td>
							<td class="text_right">2,000,000</td>
							<td class="text_right">1,000,000</td>
							<td class="text_right ">20,000</td>
						</tr>
						<tr>
							<td>4</td>
							<td>材料费</td>
							<td class="text_right">1,100,000</td>
							<td class="text_right">2,000,000</td>
							<td class="text_right">1,000,000</td>
							<td class="text_org text_right">-20,000</td>
						</tr>
						<tr>
							<td>5</td>
							<td>差旅费</td>
							<td class="text_right">1,100,000</td>
							<td class="text_right">2,000,000</td>
							<td class="text_right">1,000,000</td>
							<td class="text_org text_right">-20,000</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</body>

</html>










