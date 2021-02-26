<%@page import="avicit.platform6.api.sysmenu.dto.SysBootstrapMenuItem"%>
<%@page import="avicit.platform6.api.sysmenu.impl.SysMenuBootstrapAPImpl"%>
<%@page import="avicit.platform6.core.spring.SpringFactory"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.api.session.dto.SecurityMenu"%>
<%@page import="avicit.platform6.api.session.dto.SecurityUser"%>
<%@page import="avicit.platform6.api.sysmenu.impl.SysMenuAPImpl"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	SysMenuBootstrapAPImpl sysMenuAPI = SpringFactory.getBean(SysMenuBootstrapAPImpl.class);
	SecurityUser user = SessionHelper.getSecurityUser(request);
	String appId =SessionHelper.getApplicationId();
	SecurityMenu menu = new SecurityMenu();
	menu.reflashMenu(appId);
	String loginname =user.getUser().getName();
	String indexElement = sysMenuAPI.getBootStrapMenu(SessionHelper.getCurrentUserLanguageCode(request), user, menu,appId,SysBootstrapMenuItem.class);
%>
<!DOCTYPE html>
<html>
	<head>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title>系统首页</title>

		<meta name="description" content="top menu &amp; navigation" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/bootstrap.min.css" />
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/font-awesome.min.css" />

		<!-- page specific plugin styles -->

		<!-- text fonts -->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/ace-fonts.min.css" />
		
		<!-- ace skin -->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/ace-skins.min.css" />

		<!-- ace styles -->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />

		<!--[if lte IE 9]>
			<link rel="stylesheet" href="static/css/platform/aceadmin/css/ace-part2.min.css" class="ace-main-stylesheet" />
		<![endif]-->

		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="static/css/platform/aceadmin/css/ace-ie.min.css" />
		<![endif]-->

		<!-- inline styles related to this page -->

		<!-- ace settings handler -->
		<script src="static/js/platform/aceadmin/ace-extra.min.js"></script>

		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->

		<!--[if lte IE 8]>
		<script src="static/js/platform/aceadmin/html5shiv.min.js"></script>
		<script src="static/js/platform/aceadmin/respond.min.js"></script>
		<![endif]-->
	</head>
	<style>
	.logo {
	margin-top: 1px;
	width: 100%;
	background: url(static/css/platform/aceadmin/css/img/LOGO.png) no-repeat;
	float: left;
}
.tab-content {
	
    padding-top: 10px;
    padding-left: 2px;
    padding-right: 2px;
    padding-bottom: 10px;
	
}

	</style>
	<script type="text/javascript">
	var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
	</script>

	<body class="no-skin">
		<!-- #section:basics/navbar.layout -->
		<div id="navbar" class="navbar navbar-default navbar-fixed-top">
			<script type="text/javascript">
				try{ace.settings.check('navbar' , 'fixed')}catch(e){}
			</script>

			<div class="navbar-container" id="navbar-container">
				<!-- #section:basics/sidebar.mobile.toggle -->
				<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
					<span class="sr-only">Toggle sidebar</span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>

					<span class="icon-bar"></span>
				</button>
				
				<!-- /section:basics/sidebar.mobile.toggle -->
				<div class="navbar-header pull-left">
					<!-- #section:basics/navbar.layout.brand -->
					<a href="#" class="navbar-brand">
						<small>
							<img src="static/css/platform/aceadmin/css/img/LOGO.png" style="padding-bottom:3px;"/>
							业务基础平台V6
						</small>
					</a>
				</div>

				<!-- #section:basics/navbar.dropdown -->
				<div class="navbar-buttons navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav" id="buttonsUl">
					</ul>
				</div>
			</div><!-- /.navbar-container -->
		</div>

		<!-- /section:basics/navbar.layout -->
		<div class="main-container" id="main-container">
			<script type="text/javascript">
				try{ace.settings.check('main-container' , 'fixed')}catch(e){}
			</script>

			<!-- #section:basics/sidebar.horizontal -->
			<div id="sidebar" class="sidebar responsive sidebar-fixed">
				<script type="text/javascript">
					try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
				</script>

			
				<div class="sidebar-shortcuts" id="sidebar-shortcuts">
					<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
						<button class="btn btn-success">
							<i class="ace-icon fa fa-signal"></i>
						</button>

						<button class="btn btn-info">
							<i class="ace-icon fa fa-pencil"></i>
						</button>

						<!-- #section:basics/sidebar.layout.shortcuts -->
						<button class="btn btn-warning">
							<i class="ace-icon fa fa-users"></i>
						</button>

						<button class="btn btn-danger">
							<i class="ace-icon fa fa-cogs"></i>
						</button>

					</div>

					<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
						<span class="btn btn-success"></span>

						<span class="btn btn-info"></span>

						<span class="btn btn-warning"></span>

						<span class="btn btn-danger"></span>
					</div>
				</div>
				<div id="menuBar">
					<ul class="nav nav-list">
						<%=indexElement%>
					</ul>
				</div>
				<div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
					<i class="ace-icon fa fa-angle-double-left" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
				</div>
				<script type="text/javascript">
					try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
				</script>
				
			</div>

			<div class="main-content">
				<div class="main-content-inner">
				<div class="tabbable">
				
							<ul id="myTab" class="nav nav-tabs">
							</ul>
							<div id="myTabContent" class="tab-content">
							</div>
							</div>
				</div>
			</div>

			<!-- <div class="footer">
				<div class="footer-inner">
					
				</div>
			</div> -->

			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>
		</div><!-- /.main-container -->

		<!-- basic scripts -->

		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='static/js/platform/aceadmin/jquery.min.js'>"+"<"+"/script>");
		</script>

		<!-- <![endif]-->

		<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='static/js/platform/aceadmin/jquery1x.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='static/js/platform/aceadmin/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="static/js/platform/aceadmin/bootstrap.min.js"></script>

		<!-- page specific plugin scripts -->

		<!-- ace scripts -->
		<script src="static/js/platform/aceadmin/menubar.min.js"></script>
		<script src="static/js/platform/aceadmin/navbar.js"></script>
		<script src="static/js/platform/aceadmin/ace/elements.scroller.js"></script>
		<script src="static/js/platform/aceadmin/ace.min.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.sidebar.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.sidebar-scroll-1.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.submenu-hover.js"></script>
		<script src="static/js/platform/aceadmin/bootbox.min.js"></script>
		

		<!-- inline scripts related to this page -->
		<script type="text/javascript">
			jQuery(function($) {
				$("#buttonsUl").initMyNavBar();
				loadMessageInterval();
				menuClick($("#homePage"),{id: "homePage",close:false, title: $("#homePage").html(), url:"avicit/platform6/modules/system/newdash/dashborad/widgets.jsp"});
			});
		</script>
	</body>
</html>
