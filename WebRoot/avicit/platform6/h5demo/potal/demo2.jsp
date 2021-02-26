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
			<i class="icon iconfont icon-wendang"></i>项目经费执行情况
		</div>
		<div class="operation float-r">
			<a class="refresh-a" href="javascript:void(0);" data-src="40283f81729d2e2c01729d31946a01dd"><i title="刷新" class="icon iconfont icon-shuaxin"></i></a>
			<a class="more-a" href="javascript:void(0);" data-src="platform/eform/bpmsCRUDClient/toViewJsp/SendFileView" data-title="文件"><i title="更多" class="icon iconfont icon-ziyuan"></i></a>
		</div>
	</div>
	<div class="content-body">
		<div class="funds_box">
			<table width="100%" cellspacing="0" border="0">
				<tbody>
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
				</tbody>
			</table>
		</div>
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
				top.addTab("列表portal", "avicit/platform6/h5demo/potal/demo2.jsp");
			}
       });
       $('.refresh-a').on('click',function(){
    	   window.location.reload()
       });
	});
</script>
</body>
</html>
