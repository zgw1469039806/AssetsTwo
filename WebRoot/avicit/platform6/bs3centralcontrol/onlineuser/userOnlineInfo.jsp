<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html lang="en"
	class="app js no-touch no-android chrome no-firefox no-iemobile no-ie no-ie10 no-ie11 no-ios no-ios7 ipad">
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta name="decorator" content="default"/>

<link rel="stylesheet" href="avicit/platform6/console/monitor/css/font-awesome.min.css"/>
<link rel="stylesheet" href="avicit/platform6/console/monitor/css/bootstrap.min.css"/>
<link rel="stylesheet" href="avicit/platform6/console/monitor/css/style.css"/>

<!--[if lt IE 9]>
<script type="text/javascript"  src="static/h5/bootstrap/html5shiv.js"></script>
<![endif]-->
<!--[if lt IE 9]>
<script type="text/javascript"  src="static/h5/bootstrap/respond.min.js"></script>
<![endif]-->

<script src="static/h5/echarts/dist/echarts-all.js" type="text/javascript"></script>
<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
<%
	String appid = request.getParameter("appid");
%>
<script type="text/javascript">
var appid = '<%=appid%>';
</script>

<script type="text/javascript" src="avicit/platform6/bs3centralcontrol/onlineuser/js/userOnlineInfo.js"></script>
<style type="text/css">
html,body{width:100%}
.wrapper-content {
    padding: 15px;
    width:100%;
   
}

.panel-danger {
    width: 100%;
    margin:0 auto;
}
</style>
</head>
<body class="" style="">
	<div class="wrapper wrapper-content" style="padding-left:32px;">
		<div class="row animated fadeInRight" style="width:100%;">
			<div class="col-sm-12">
			  <div class="panel panel-danger">
				<div class="panel-heading">
					<i class="fa fa-fire"></i> 在线用户实时监控
				</div>
				<div class="panel-body">
					<div id="main" style="height: 150px;width:100%;"></div>
				</div>
			 </div>
			</div>
		</div>
	</div>
</body>
</html>
