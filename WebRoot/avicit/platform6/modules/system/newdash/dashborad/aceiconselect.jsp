<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

<script src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.min.js" type="text/javascript"></script>
<!-- bootstrap & fontawesome -->
<link rel="stylesheet"
	href="static/css/platform/aceadmin/css/bootstrap.css" />
<link rel="stylesheet"
	href="static/css/platform/aceadmin/css/font-awesome.css" />

<!-- page specific plugin styles -->

<!-- text fonts -->
<link rel="stylesheet"
	href="static/css/platform/aceadmin/css/ace-fonts.css" />

<!-- ace styles -->
<link rel="stylesheet"
	href="static/css/platform/aceadmin/css/ace.css"
	class="ace-main-stylesheet" id="main-ace-style" />

</head>

<style>
.fa-hover li:hover {
	display: block;
	background: #008080;
	padding: 5px;
	color: #ffffff;
	font-size: 1.1em;
}
</style>
<body>
	<div class="row">
		<!-- <div class="col-xs-12">
			<h3 class="header smaller lighter blue">
				Font Awesome图标 <small> <a
					href="http://fontawesome.io/icons/" target="_blank"> (查看全部图标 <i
						class="ace-icon fa fa-external-link"></i>)
				</a>
				</small>
			</h3>
		</div> -->
		<div class="col-xs-6 col-sm-3">
			<ul class="list-unstyled fa-hover">
				<li><i class="ace-icon fa fa-adjust"></i> fa-adjust</li>

				<li><i class="ace-icon fa fa-asterisk"></i> fa-asterisk</li>

				<li><i class="ace-icon fa fa-ban"></i> fa-ban</li>

				<li><i class="ace-icon fa fa-bar-chart-o"></i> fa-bar-chart-o</li>

				<li><i class="ace-icon fa fa-barcode"></i> fa-barcode</li>

				<li><i class="ace-icon fa fa-flask"></i> fa-flask</li>

				<li><i class="ace-icon fa fa-beer"></i> fa-beer</li>

				<li><i class="ace-icon fa fa-bell-o"></i> fa-bell-o</li>

				<li><i class="ace-icon fa fa-bell"></i> fa-bell</li>

				<li><i class="ace-icon fa fa-bolt"></i> fa-bolt</li>

				<li><i class="ace-icon fa fa-book"></i> fa-book</li>

				<li><i class="ace-icon fa fa-bookmark"></i> fa-bookmark</li>

				<li><i class="ace-icon fa fa-bookmark-o"></i> fa-bookmark-o</li>

				<li><i class="ace-icon fa fa-briefcase"></i> fa-briefcase</li>

				<li><i class="ace-icon fa fa-bullhorn"></i> fa-bullhorn</li>

				<li><i class="ace-icon fa fa-calendar"></i> fa-calendar</li>

				<li><i class="ace-icon fa fa-camera"></i> fa-camera</li>

				<li><i class="ace-icon fa fa-camera-retro"></i> fa-camera-retro
				</li>

				<li><i class="ace-icon fa fa-certificate"></i> fa-certificate</li>
			</ul>
		</div>

		<div class="col-xs-6 col-sm-3">
			<ul class="list-unstyled fa-hover">
				<li><i class="ace-icon fa fa-check-square-o"></i>
					fa-check-square-o</li>

				<li><i class="ace-icon fa fa-square-o"></i> fa-square-o</li>

				<li><i class="ace-icon fa fa-circle"></i> fa-circle</li>

				<li><i class="ace-icon fa fa-circle-o"></i> fa-circle-o</li>

				<li><i class="ace-icon fa fa-cloud"></i> fa-cloud</li>

				<li><i class="ace-icon fa fa-cloud-download"></i>
					fa-cloud-download</li>

				<li><i class="ace-icon fa fa-cloud-upload"></i> fa-cloud-upload
				</li>

				<li><i class="ace-icon fa fa-coffee"></i> fa-coffee</li>

				<li><i class="ace-icon fa fa-cog"></i> fa-cog</li>

				<li><i class="ace-icon fa fa-cogs"></i> fa-cogs</li>

				<li><i class="ace-icon fa fa-comment"></i> fa-comment</li>

				<li><i class="ace-icon fa fa-comment-o"></i> fa-comment-o</li>

				<li><i class="ace-icon fa fa-comments"></i> fa-comments</li>

				<li><i class="ace-icon fa fa-comments-o"></i> fa-comments-o</li>

				<li><i class="ace-icon fa fa-credit-card"></i> fa-credit-card</li>

				<li><i class="ace-icon fa fa-tachometer"></i> fa-tachometer</li>

				<li><i class="ace-icon fa fa-desktop"></i> fa-desktop</li>

				<li><i class="ace-icon fa fa-arrow-circle-o-down"></i>
					fa-arrow-circle-o-down</li>

				<li><i class="ace-icon fa fa-download"></i> fa-download</li>
			</ul>
		</div>

		<div class="col-xs-6 col-sm-3">
			<ul class="list-unstyled fa-hover">
				<li><i class="ace-icon fa fa-pencil-square-o"></i>
					fa-pencil-square-o</li>

				<li><i class="ace-icon fa fa-envelope"></i> fa-envelope</li>

				<li><i class="ace-icon fa fa-envelope-o"></i> fa-envelope-o</li>

				<li><i class="ace-icon fa fa-exchange"></i> fa-exchange</li>

				<li><i class="ace-icon fa fa-exclamation-circle"></i>
					fa-exclamation-circle</li>

				<li><i class="ace-icon fa fa-external-link"></i>
					fa-external-link</li>

				<li><i class="ace-icon fa fa-eye-slash"></i> fa-eye-slash</li>

				<li><i class="ace-icon fa fa-eye"></i> fa-eye</li>

				<li><i class="ace-icon fa fa-video-camera"></i> fa-video-camera
				</li>

				<li><i class="ace-icon fa fa-fighter-jet"></i> fa-fighter-jet</li>

				<li><i class="ace-icon fa fa-film"></i> fa-film</li>

				<li><i class="ace-icon fa fa-filter"></i> fa-filter</li>

				<li><i class="ace-icon fa fa-fire"></i> fa-fire</li>

				<li><i class="ace-icon fa fa-flag"></i> fa-flag</li>

				<li><i class="ace-icon fa fa-folder"></i> fa-folder</li>

				<li><i class="ace-icon fa fa-folder-open"></i> fa-folder-open</li>

				<li><i class="ace-icon fa fa-folder-o"></i> fa-folder-o</li>

				<li><i class="ace-icon fa fa-folder-open-o"></i>
					fa-folder-open-o</li>

				<li><i class="ace-icon fa fa-cutlery"></i> fa-cutlery</li>
			</ul>
		</div>


		<div class="col-xs-6 col-sm-3">
			<ul class="list-unstyled fa-hover">
				<li><i class="ace-icon fa fa-gift"></i> fa-gift</li>

				<li><i class="ace-icon fa fa-glass"></i> fa-glass</li>

				<li><i class="ace-icon fa fa-globe"></i> fa-globe</li>

				<li><i class="ace-icon fa fa-users"></i> fa-users</li>

				<li><i class="ace-icon fa fa-hdd-o"></i> fa-hdd-o</li>

				<li><i class="ace-icon fa fa-headphones"></i> fa-headphones</li>

				<li><i class="ace-icon fa fa-heart"></i> fa-heart</li>

				<li><i class="ace-icon fa fa-heart-o"></i> fa-heart-o</li>

				<li><i class="ace-icon fa fa-home"></i> fa-home</li>

				<li><i class="ace-icon fa fa-inbox"></i> fa-inbox</li>

				<li><i class="ace-icon fa fa-info-circle"></i> fa-info-circle</li>

				<li><i class="ace-icon fa fa-key"></i> fa-key</li>

				<li><i class="ace-icon fa fa-leaf"></i> fa-leaf</li>

				<li><i class="ace-icon fa fa-laptop"></i> fa-laptop</li>

				<li><i class="ace-icon fa fa-gavel"></i> fa-gavel</li>

				<li><i class="ace-icon fa fa-lemon-o"></i> fa-lemon-o</li>

				<li><i class="ace-icon fa fa-lightbulb-o"></i> fa-lightbulb-o</li>

				<li><i class="ace-icon fa fa-lock"></i> fa-lock</li>

				<li><i class="ace-icon fa fa-unlock"></i> fa-unlock</li>
			</ul>
		</div>
	</div>
</body>
<script type="text/javascript">
jQuery(function($) {
	$("li").on("click",function(){
		var iconClass = $(this).find("i").attr("class");
		parent.setIconClass(iconClass.replace("ace-icon","menu-icon"));
		parent.closeDlg("icondlg");
	});
});
</script>
</html>
