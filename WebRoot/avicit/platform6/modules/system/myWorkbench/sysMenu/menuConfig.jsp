<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=ViewUtil.getRequestPath(request)%>">
	
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<meta charset="utf-8" />
		<title></title>

		<meta name="description" content="overview &amp; stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />

		<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/bootstrap.min.css" />
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/font-awesome.min.css" />

		<!-- page specific plugin styles -->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/jquery-ui.min.css" />
		<%--以下不需要 
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/chosen.min.css" />
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/bootstrap-timepicker.min.css" />
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/daterangepicker.min.css" />
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/bootstrap-datetimepicker.min.css" />
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/colorpicker.min.css" />
		--%>

		<!-- text fonts -->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/ace-fonts.min.css" />

		<!-- ace styles -->
		<link rel="stylesheet" href="static/css/platform/aceadmin/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />
		<!--[if lte IE 9]>
			<link rel="stylesheet" href="static/css/platform/aceadmin/css/ace-part2.min.css" class="ace-main-stylesheet" />
		<![endif]-->
		<!--[if lte IE 9]>
		  <link rel="stylesheet" href="static/css/platform/aceadmin/css/ace-ie.min.css" />
		<![endif]-->

		<!-- ace settings handler -->
		<script src="static/js/platform/aceadmin/ace-extra.min.js"></script>
		<!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
		<!--[if lte IE 8]>
		<script src="static/js/platform/aceadmin/html5shiv.min.js"></script>
		<script src="static/js/platform/aceadmin/respond.min.js"></script>
		<![endif]-->

		<!-- 自定义 -->
		<link rel="stylesheet" href="static/css/platform/public/common.css" />	
	</head>

	<body class="no-skin">
		<div class="main-container ace-save-state" id="main-container">
			<!-- /section:basics/sidebar -->
			<div class="main-content">
				<div class="main-content-inner">
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12">
							<!-- PAGE CONTENT BEGINS -->
								<!-- 主体内容模块：直接填充页面 -->
								<div id="mainContent">
								</div>
								
								<!-- 主体内容模块：通过bootstrap modal填充页面【对应不同尺寸】 -->
								<div id="mainModal">
									<div id="mainModal-default" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
											</div>
										</div>
									</div>
									<div id="mainModal-10pct" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document" style="width: 10%;">
											<div class="modal-content">
											</div>
										</div>
									</div>
									<div id="mainModal-20pct" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document" style="width: 20%;">
											<div class="modal-content">
											</div>
										</div>
									</div>
									<div id="mainModal-30pct" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document" style="width: 30%;">
											<div class="modal-content">
											</div>
										</div>
									</div>
									<div id="mainModal-40pct" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document" style="width: 40%;">
											<div class="modal-content">
											</div>
										</div>
									</div>
									<div id="mainModal-50pct" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document" style="width: 50%;">
											<div class="modal-content">
											</div>
										</div>
									</div>
									<div id="mainModal-60pct" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document" style="width: 60%;">
											<div class="modal-content">
											</div>
										</div>
									</div>
									<div id="mainModal-70pct" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document" style="width: 70%;">
											<div class="modal-content">
											</div>
										</div>
									</div>
									<div id="mainModal-80pct" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document" style="width: 80%;">
											<div class="modal-content">
											</div>
										</div>
									</div>
									<div id="mainModal-90pct" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document" style="width: 90%;">
											<div class="modal-content">
											</div>
										</div>
									</div>
									<div id="mainModal-100pct" class="modal fade" role="dialog" aria-hidden="true">
										<div class="modal-dialog" role="document" style="width: 100%;">
											<div class="modal-content">
											</div>
										</div>
									</div>
								</div>
							<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
					</div><!-- /.page-content -->
				</div>
			</div><!-- /.main-content -->
		</div><!-- /.main-container -->

		<!-- basic scripts -->
		<!--[if !IE]> -->
			<script src="static/js/platform/aceadmin/jquery.min.js"></script>
		<!-- <![endif]-->
		<!--[if IE]>
			<script src="static/js/platform/aceadmin/jquery1x.min.js"></script>
		<![endif]-->
		<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='static/js/platform/aceadmin/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
		<script src="static/js/platform/aceadmin/jquery-ui.min.js"></script>
		<script src="static/js/platform/aceadmin/jquery.ui.touch-punch.min.js"></script>
		<script src="static/js/platform/aceadmin/bootstrap.min.js"></script>
		<script src="static/js/platform/aceadmin/bootbox.min.js"></script>
		<%-- 以下js本页面不需要
		<script src="static/js/platform/aceadmin/dataTables/jquery.dataTables.min.js"></script>
		<script src="static/js/platform/aceadmin/dataTables/jquery.dataTables.bootstrap.min.js"></script>
		<script src="static/js/platform/aceadmin/dataTables/extensions/Buttons/js/dataTables.buttons.min.js"></script>
		<script src="static/js/platform/aceadmin/dataTables/extensions/Buttons/js/buttons.flash.min.js"></script>
		<script src="static/js/platform/aceadmin/dataTables/extensions/Buttons/js/buttons.html5.js"></script><!-- 修改英文为汉语，不调用min版本 -->
		<script src="static/js/platform/aceadmin/dataTables/extensions/Buttons/js/buttons.print.min.js"></script>
		<script src="static/js/platform/aceadmin/dataTables/extensions/Buttons/js/buttons.colVis.min.js"></script>
		<script src="static/js/platform/aceadmin/dataTables/extensions/Select/js/dataTables.select.min.js"></script>
		<!-- jquery dataTables信息汉化 -->
		<script src="static/js/platform/public/jqDataTables_messages_cn.js"></script>
		--%>
		<script src="static/js/platform/aceadmin/jquery.validate.min.js"></script>
		<!-- jquery validate提示信息汉化 -->
		<script src="static/js/platform/public/jqValidate_messages_cn.js"></script>
		<!-- Ajax操作封装&前台操作 -->
		<script src="static/js/platform/public/jsAction.js"></script>

		<!-- ace scripts -->
		<script src="static/js/platform/aceadmin/ace/elements.treeview.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.js"></script>
		<!--  以下为源码所写，根据需求往上加
		<script src="static/js/platform/aceadmin/ace/elements.scroller.js"></script>
		<script src="static/js/platform/aceadmin/ace/elements.colorpicker.js"></script>
		<script src="static/js/platform/aceadmin/ace/elements.fileinput.js"></script>
		<script src="static/js/platform/aceadmin/ace/elements.typeahead.js"></script>
		<script src="static/js/platform/aceadmin/ace/elements.wysiwyg.js"></script>
		<script src="static/js/platform/aceadmin/ace/elements.spinner.js"></script>
		<script src="static/js/platform/aceadmin/ace/elements.treeview.js"></script>
		<script src="static/js/platform/aceadmin/ace/elements.wizard.js"></script>
		<script src="static/js/platform/aceadmin/ace/elements.aside.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.ajax-content.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.touch-drag.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.sidebar.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.sidebar-scroll-1.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.submenu-hover.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.widget-box.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.settings.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.settings-rtl.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.settings-skin.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.widget-on-reload.js"></script>
		<script src="static/js/platform/aceadmin/ace/ace.searchbox-autocomplete.js"></script>
		-->
		
		<!-- tab -->
		<!--  
		<script src="static/js/platform/aceadmin/menubar.js"></script>
		-->
		<!-- 
		<script src="static/js/platform/index/js/platform.dashboard.index.all.js"></script>
		-->
		
		<script type="text/javascript">
			//加载页面
			ajaxOpenPage("MODAL", "mainModal-50pct", "avicit/platform6/modules/system/myWorkbench/sysMenu/menuTree.jsp", "");
		</script>
	</body>
</html>