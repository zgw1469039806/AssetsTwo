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

<script src="static/h5/echarts/dist/echarts-all.js"
	type="text/javascript"></script>
<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="avicit/platform6/console/monitor/js/systemInfo.js"></script>
</head>
<body class="" style="">
	<div class="wrapper wrapper-content">
			<div class="row animated fadeInRight">
				<div class="col-sm-12">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<i class="fa fa-rss-square"></i> 实时监控
						</div>
	
						<div class="panel-body">
							<table style="width: 100%;">
								<tr>
									<td width="33.3%"><div id="main_three" style="height: 240px;"></div></td>
									
									<td width="33.3%"><div id="main_two" style="height: 240px;"></div></td>
									<td width="33.3%"><div id="main_one" style="height: 240px;"></div></td>
									
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="row animated fadeInRight">
				<div class="col-xs-6">
					<div class="panel panel-info">
						<div class="panel-heading">
							<i class="fa fa-th-list"></i> 服务器信息
						</div>
						<div class="panel-body" style="padding: 0px">
							<div style="height: 400px;" class="embed-responsive">
							  <iframe class="embed-responsive-item" src="platform/modules/system/monitor/systemInfo"></iframe>
							</div>
						</div>
					</div>
				</div>
				<div class="col-xs-6">
				  <div class="panel panel-danger">
					<div class="panel-heading">
						<i class="fa fa-fire"></i> 实时监控
					</div>

					<div class="panel-body">
						<div id="main" style="height: 370px;width:100%;"></div>
					</div>
				 </div>
				</div>
			</div>
			
			<div class="row animated fadeInRight">
				<div class="col-xs-6">
				  <div class="panel panel-danger">
					<div class="panel-heading">
						<i class="fa fa-fire"></i> 流量监控
					</div>
						
					<div class="panel-body">
						<div id="netMonitor" style="height: 370px;width:100%;"></div>
					</div>
				 </div>
				</div>
			</div>
	</div>
</body>
</html>
