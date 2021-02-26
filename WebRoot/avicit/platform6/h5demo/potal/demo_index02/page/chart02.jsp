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
<link rel="stylesheet" href="avicit/platform6/h5demo/potal/demo_index02/css/index.css" />
<link id = "portlet-skin" rel="stylesheet" href="avicit/platform6/portal/portlet/skin/<%=skinsValue %>-portlet.css">
<style type="text/css">
.content-empty:after,
.content-empty:before{
  content:"" !important;
}
</style>
<style>
	.statistics_box {
	    text-align: center;
	    height: 260px;
	}
</style>
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
</head>
	<body>
		<div class="bulletin content_box">
			<div class="content_inner" style="height: 250px;">
				<div class="statistics_box">
					<img src="avicit/platform6/h5demo/potal/demo_index02/image/chart02.png">
				</div>
			</div>
		</div>
	</body>

</html>