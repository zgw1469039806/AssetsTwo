<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String menuId = request.getParameter("menuId");
%>

<script>
	function chooseIcon(iconName){
		//关闭图标选择modal
		$("#mainModal-60pct").modal('hide');
		
		$("#icon-<%=menuId%>").removeClass();//移除所有class
		$("#icon-<%=menuId%>").addClass("ace-icon");
		$("#icon-<%=menuId%>").addClass("fa");
		$("#icon-<%=menuId%>").addClass(iconName);
		$("#icon-<%=menuId%>").addClass("bigger-300");
		
		//修改entranceEdit.jsp页面表单值，用于传参
		$("#iconClass-<%=menuId%>").attr("value", "ace-icon fa bigger-300 " + iconName);
	}
</script>

<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	<h4 class="modal-title">选择图标</h4>
</div>

<div class="modal-body">
	<!-- BEGIN ICON -->
	<div class="row">
		<div class="col-xs-6 col-sm-3">
			<ul class="list-unstyled">
				<li>
					<i class="ace-icon fa fa-adjust"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-adjust')">fa-adjust</a>
				</li>

				<li>
					<i class="ace-icon fa fa-asterisk"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-asterisk')">fa-asterisk</a>
				</li>

				<li>
					<i class="ace-icon fa fa-ban"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-ban')">fa-ban</a>
				</li>

				<li>
					<i class="ace-icon fa fa-bar-chart-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-bar-chart-o')">fa-bar-chart-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-barcode"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-barcode')">fa-barcode</a>
				</li>

				<li>
					<i class="ace-icon fa fa-flask"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-flask')">fa-flask</a>
				</li>

				<li>
					<i class="ace-icon fa fa-beer"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-beer')">fa-beer</a>
				</li>

				<li>
					<i class="ace-icon fa fa-bell-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-bell-o')">fa-bell-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-bell"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-bell')">fa-bell</a>
				</li>

				<li>
					<i class="ace-icon fa fa-bolt"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-bolt')">fa-bolt</a>
				</li>

				<li>
					<i class="ace-icon fa fa-book"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-book')">fa-book</a>
				</li>

				<li>
					<i class="ace-icon fa fa-bookmark"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-bookmark')">fa-bookmark</a>
				</li>

				<li>
					<i class="ace-icon fa fa-bookmark-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-bookmark-o')">fa-bookmark-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-briefcase"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-briefcase')">fa-briefcase</a>
				</li>

				<li>
					<i class="ace-icon fa fa-bullhorn"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-bullhorn')">fa-bullhorn</a>
				</li>

				<li>
					<i class="ace-icon fa fa-calendar"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-calendar')">fa-calendar</a>
				</li>

				<li>
					<i class="ace-icon fa fa-camera"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-camera')">fa-camera</a>
				</li>

				<li>
					<i class="ace-icon fa fa-camera-retro"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-camera-retro')">fa-camera-retro</a>
				</li>

				<li>
					<i class="ace-icon fa fa-certificate"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-certificate')">fa-certificate</a>
				</li>
			</ul>
		</div>

		<div class="col-xs-6 col-sm-3">
			<ul class="list-unstyled">
				<li>
					<i class="ace-icon fa fa-check-square-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-check-square-o')">fa-check-square-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-square-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-square-o')">fa-square-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-circle"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-circle')">fa-circle</a>
				</li>

				<li>
					<i class="ace-icon fa fa-circle-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-circle-o')">fa-circle-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-cloud"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-cloud')">fa-cloud</a>
				</li>

				<li>
					<i class="ace-icon fa fa-cloud-download"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-cloud-download')">fa-cloud-download</a>
				</li>

				<li>
					<i class="ace-icon fa fa-cloud-upload"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-cloud-upload')">fa-cloud-upload</a>
				</li>

				<li>
					<i class="ace-icon fa fa-coffee"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-coffee')">fa-coffee</a>
				</li>

				<li>
					<i class="ace-icon fa fa-cog"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-cog')">fa-cog</a>
				</li>

				<li>
					<i class="ace-icon fa fa-cogs"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-cogs')">fa-cogs</a>
				</li>

				<li>
					<i class="ace-icon fa fa-comment"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-comment')">fa-comment</a>
				</li>

				<li>
					<i class="ace-icon fa fa-comment-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-comment-o')">fa-comment-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-comments"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-comments')">fa-comments</a>
				</li>

				<li>
					<i class="ace-icon fa fa-comments-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-comments-o')">fa-comments-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-credit-card"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-credit-card')">fa-credit-card</a>
				</li>

				<li>
					<i class="ace-icon fa fa-tachometer"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-tachometer')">fa-tachometer</a>
				</li>

				<li>
					<i class="ace-icon fa fa-desktop"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-desktop')">fa-desktop</a>
				</li>

				<li>
					<i class="ace-icon fa fa-arrow-circle-o-down"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-arrow-circle-o-down')">fa-arrow-circle-o-down</a>
				</li>

				<li>
					<i class="ace-icon fa fa-download"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-download')">fa-download</a>
				</li>
			</ul>
		</div>

		<div class="col-xs-6 col-sm-3">
			<ul class="list-unstyled">
				<li>
					<i class="ace-icon fa fa-pencil-square-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-pencil-square-o')">fa-pencil-square-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-envelope"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-envelope')">fa-envelope</a>
				</li>

				<li>
					<i class="ace-icon fa fa-envelope-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-envelope-o')">fa-envelope-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-exchange"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-exchange')">fa-exchange</a>
				</li>

				<li>
					<i class="ace-icon fa fa-exclamation-circle"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-exclamation-circle')">fa-exclamation-circle</a>
				</li>

				<li>
					<i class="ace-icon fa fa-external-link"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-external-link')">fa-external-link</a>
				</li>

				<li>
					<i class="ace-icon fa fa-eye-slash"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-eye-slash')">fa-eye-slash</a>
				</li>

				<li>
					<i class="ace-icon fa fa-eye"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-eye')">fa-eye</a>
				</li>

				<li>
					<i class="ace-icon fa fa-video-camera"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-video-camera')">fa-video-camera</a>
				</li>

				<li>
					<i class="ace-icon fa fa-fighter-jet"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-fighter-jet')">fa-fighter-jet</a>
				</li>

				<li>
					<i class="ace-icon fa fa-film"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-film')">fa-film</a>
				</li>

				<li>
					<i class="ace-icon fa fa-filter"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-filter')">fa-filter</a>
				</li>

				<li>
					<i class="ace-icon fa fa-fire"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-fire')">fa-fire</a>
				</li>

				<li>
					<i class="ace-icon fa fa-flag"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-flag')">fa-flag</a>
				</li>

				<li>
					<i class="ace-icon fa fa-folder"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-folder')">fa-folder</a>
				</li>

				<li>
					<i class="ace-icon fa fa-folder-open"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-folder-open')">fa-folder-open</a>
				</li>

				<li>
					<i class="ace-icon fa fa-folder-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-folder-o')">fa-folder-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-folder-open-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-folder-open-o')">fa-folder-open-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-cutlery"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-cutlery')">fa-cutlery</a>
				</li>
			</ul>
		</div>

		<div class="col-xs-6 col-sm-3">
			<ul class="list-unstyled">
				<li>
					<i class="ace-icon fa fa-gift"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-gift')">fa-gift</a>
				</li>

				<li>
					<i class="ace-icon fa fa-glass"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-glass')">fa-glass</a>
				</li>

				<li>
					<i class="ace-icon fa fa-globe"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-globe')">fa-globe</a>
				</li>

				<li>
					<i class="ace-icon fa fa-users"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-users')">fa-users</a>
				</li>

				<li>
					<i class="ace-icon fa fa-hdd-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-hdd-o')">fa-hdd-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-headphones"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-headphones')">fa-headphones</a>
				</li>

				<li>
					<i class="ace-icon fa fa-heart"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-heart')">fa-heart</a>
				</li>

				<li>
					<i class="ace-icon fa fa-heart-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-heart-o')">fa-heart-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-home"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-home')">fa-home</a>
				</li>

				<li>
					<i class="ace-icon fa fa-inbox"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-inbox')">fa-inbox</a>
				</li>

				<li>
					<i class="ace-icon fa fa-info-circle"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-info-circle')">fa-info-circle</a>
				</li>

				<li>
					<i class="ace-icon fa fa-key"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-key')">fa-key</a>
				</li>

				<li>
					<i class="ace-icon fa fa-leaf"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-leaf')">fa-leaf</a>
				</li>

				<li>
					<i class="ace-icon fa fa-laptop"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-laptop')">fa-laptop</a>
				</li>

				<li>
					<i class="ace-icon fa fa-gavel"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-gavel')">fa-gavel</a>
				</li>

				<li>
					<i class="ace-icon fa fa-lemon-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-lemon-o')">fa-lemon-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-lightbulb-o"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-lightbulb-o')">fa-lightbulb-o</a>
				</li>

				<li>
					<i class="ace-icon fa fa-lock"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-lock')">fa-lock</a>
				</li>

				<li>
					<i class="ace-icon fa fa-unlock"></i>
					<a href="javascript:;" onclick="chooseIcon('fa-unlock')">fa-unlock</a>
				</li>
			</ul>
		</div>
	</div>
	<!-- END ICON -->
</div>