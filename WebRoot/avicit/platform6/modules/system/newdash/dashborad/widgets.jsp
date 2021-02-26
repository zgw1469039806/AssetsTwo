<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<%
		Object admin =session.getAttribute(AfterLoginSessionProcess.SESSION_IS_ADMIN);	
	%>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title></title>

		<meta name="description" content="top menu &amp; navigation" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/bootstrap.min.css" />
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/font-awesome.min.css" />

		<!-- page specific plugin styles -->

		<!-- text fonts -->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/ace-fonts.min.css" />
		
		<!-- gritter-->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/jquery.gritter.min.css" />

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
	.rowactive{
		border: 5px solid red;
	}
	
	.portal-tool a{
		margin:2px;
	}
	</style>
	<script type="text/javascript">
		var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
	</script>
<body class="skin-1" style="position:absolute;height:100%;width:100%;">
	<div class="page-content" style="position:absolute;height:100%;width:100%;">
		<div id="ace-settings-container" class="ace-settings-container">
			<div id="ace-settings-btn"
				class="ace-settings-btn btn btn-app btn-xs btn-warning">
				<i class="ace-icon fa fa-cog bigger-150"></i>
			</div>
		<div id="ace-settings-box" class="ace-settings-box clearfix">
				<div class="pull-left width-50">
					<!-- <div class="ace-settings-item">
						<input type="checkbox" id="eidt_portal" class="ace" /> <label
							for="eidt_portal" class="lbl"> 编辑首页布局</label>
					</div> -->
					<div class="ace-settings-item">
						<button  id="add_portal" class="ace"  href="avicit/platform6/modules/system/newdash/dashborad/addwidgetsbox.jsp"
							data-target="#addBox" data-toggle="modal" onclick="addPortal();"></button> <label
							for="add_portal" class="lbl"> 添加小页</label>
					</div>
					<div class="ace-settings-item">
						<button  id="edit_portal" class="ace"  href="avicit/platform6/modules/system/newdash/dashborad/modifywidgetLayout.jsp"
							data-target="#editBox" data-toggle="modal" onclick="editPortal();"></button> <label
							for="edit_portal" class="lbl"> 配置布局</label>
					</div>
					<div class="ace-settings-item">
						<button  id="save_portal" class="ace" onclick="savePortlet();" href="javascript:void(0);"></button> <label
							for="save_portal" class="lbl"> 保存配置</label>
					</div>
				</div>
				<!-- /.pull-left -->

				<div class="pull-left width-50"></div>
				<!-- /.pull-left -->
			</div>
			
			<!-- /.ace-settings-box -->
		</div>
		<div class="col-xs-12" id="portal_area">

			<!-- <div class="tools">
																<a href="#">
																	<i class="ace-icon fa fa-link"></i>
																</a>

																<a href="#">
																	<i class="ace-icon fa fa-paperclip"></i>
																</a>

																<a href="#">
																	<i class="ace-icon fa fa-pencil"></i>
																</a>

																<a href="#">
																	<i class="ace-icon fa fa-times red"></i>
																</a>
															</div> 
								<div class="row portal_group" id="group_1">
									<div id="row_sss" class="col-xs-12 col-sm-6 widget-container-col">
									</div>

									<div id="row_sss2" class="col-xs-12 col-sm-6 widget-container-col">
									</div>
								</div>

								<div class="space-24"></div>
								
								<div class="row portal_group" id="group_2">
									<div id="row_sss2" class="col-xs-12 col-sm-6 widget-container-col">
									</div>

									<div id="row_sss22" class="col-xs-12 col-sm-6 widget-container-col">
									</div>
								</div>

								<div class="space-24"></div>-->


		</div>
		<input type="hidden" name="layout" id="layout">
	</div>
	<!--[if !IE]> -->
	<script type="text/javascript">
		window.jQuery
				|| document
						.write("<script src='static/js/platform/aceadmin/jquery.min.js'>"
								+ "<"+"/script>");
	</script>

	<script
		src="static/js/platform/aceadmin/bootstrap.min.js"></script>

	<!-- page specific plugin scripts -->
	<script
		src="static/js/platform/aceadmin/jquery-ui.custom.min.js"></script>

	<!-- ace scripts -->
	<script
		src="static/js/platform/aceadmin/ace/elements.scroller.js"></script>
	<script
		src="static/js/platform/aceadmin/ace.min.js"></script>
	<script
		src="static/js/platform/aceadmin/ace/ace.widget-box.js"></script>
	<script
		src="static/js/platform/aceadmin/jquery.gritter.min.js"></script>
	<script
		src="static/js/platform/aceadmin/ace/ace.settings.js"></script>
	<script
		src="static/js/platform/aceadmin/ace/ace.settings-rtl.js"></script>
	<script
		src="static/js/platform/aceadmin/ace/ace.settings-skin.js"></script>
	<script
		src="static/js/platform/aceadmin/ace/ace.widget-on-reload.js"></script>
	<script
		src="static/js/platform/aceadmin/portlet.js"></script>
	<script
		src="static/js/platform/aceadmin/mydialog.js"></script>
	<!-- inline scripts related to this page -->

	<script type="text/javascript">
		jQuery(function($) {
			loadPortlet("portal_area");
			activeModifyPortal("eidt_portal", "portal_area");
			/* $("#add_portal").modalDialog();
			$("#add_portal").beforeShowEvent(function(e){
				initAddHtml("portal_area",e);
			});
			
			$("#edit_portal").modalDialog();
			$("#edit_portal").beforeShowEvent(function(e){
				initConfigHtml(e);
			}); */
		});
		

		function addPortal(){
			$("#add_portal").modalDialog();
			$("#add_portal").beforeShowEvent(function(e){
				initAddHtml("portal_area",e,"<%=admin%>");
			});
		}
		function editPortal(){
			$("#edit_portal").modalDialog();
			$("#edit_portal").beforeShowEvent(function(e){
				initConfigHtml(e);
			});
		}
	</script>

</body>
</html>
