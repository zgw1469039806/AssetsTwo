<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.core.properties.PlatformConstant"%>
<%@ page import="avicit.platform6.core.properties.PlatformProperties"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>欢迎使用-业务基础平台</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit|ie-stand">

<!-- Bootstrap css file v2.2.1 -->
<link rel="stylesheet" type="text/css"
	href="static/fixie/bsie/bootstrap/css/bootstrap.css">
<!--[if lte IE 6]>
    <!-- bsie css 补丁文件 -->
<link rel="stylesheet" type="text/css"
	href="static/fixie/bsie/bootstrap/css/bootstrap-ie6.css">
<!-- bsie 额外的 css 补丁文件 -->
<link rel="stylesheet" type="text/css"
	href="static/fixie/bsie/bootstrap/css/ie.css">
<![endif]-->

<!-- jquery-tabs样式依赖 -->
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/portal/themes/fixie/css/linkbutton.css">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/portal/themes/fixie/css/menu.css">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/portal/themes/fixie/css/panel.css ">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/portal/themes/fixie/css/tabs.css">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/portal/themes/fixie/css/layer.css">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/portal/themes/fixie/css/menubutton.css">
<!-- 页面样式 index.css -->
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/portal/themes/fixie/css/index-ie6.css">
</head>
<body>
	<div class="mainBody">
		<!-- 左侧菜单menu Start -->
		<div class="leftAside">
			<div class="logoDom">
				<div class="logo">
					<img src="avicit/platform6/portal/logo.png">
				</div>
				<div class="title">业务基础平台</div>
			</div>
			<ul id="navList" class="navList">
				<ul class="turn-dom">${menus}
				</ul>
			</ul>
		</div>
		<!-- 左侧菜单menu End -->

		<!-- 主页面 Start-->
		<div class="bodyCont">
			<!-- 主页面头部工具条 Start -->
			<div class="header">
				<div class="toolbar">
					<div class="leftTool">
						<div class="hideLeftMenu">
							<i class="icon icon-menu"></i>
						</div>
					</div>
					<div class="rightTool">
						<div class="search">
								<input id="keywords" type="text" class="searchinput"
									name="keywords" placeholder="请输入搜索内容..." value=""> 
									<input type="hidden" name="somehiddenvalue" value="test">
									  <input id="headSubmit" type="submit">
									<label for="headSubmit" class="icon icon-search head-search"></label>
						</div>
						<div class="iconbtn">
							<ul>
								<li class="dropdown" id="personalMenu"><i title="常用"
									class="icon grey20 icon-changyong" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="true"></i>
									<div class="dropdown-menu dropdown-menu-right avic-dropmenu">
										<ul class="avic-smenu xl" id="personalMenuUl">
										</ul>
										<div class="btns">
											<div class="a-btn addFrequently" id="personalMenuAdd"
												onclick="loadMenuNotAdded();">
												<i class="icon icon-add"></i>添加
											</div>
											<div class="a-btn last-child" id="personalMenuTrunk"
												onclick="trunkPersonalMenu();">
												<i class="icon icon-close"></i>清空
											</div>
										</div>
									</div></li>
								<%--<li class="dropdown" id="personalCollect"><i title="收藏"
									class="icon grey20 icon-shoucang" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="true"></i>
									<div class="dropdown-menu dropdown-menu-right avic-dropmenu">
										<ul class="avic-smenu xl">

										</ul>
										<div class="btns">
											<div class="a-btn noborder">
												<i class="icon icon-icon"></i>更多
											</div>
										</div>
									</div></li>--%>
								<!--                                 <span id="oacollection"></span> -->
								<li class="dropdown" id="personalMessage"><i title="通知"
									class="icon grey20 icon-tongzhi" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="true" id="unreadMessage"></i>
									<div
										class="dropdown-menu dropdown-menu-right avic-dropmenu pull-right">
										<ul class="avic-smenu xl" id="personalMessageUl"
											style="overflow-y: auto; height: 200px;">
										</ul>
										<div class="btns">
										<!-- onclick="addMessageDialog();" -->
											<div class="a-btn" id="addMessageDialog">
												<i class="icon icon-add"></i>添加
											</div>
											<div class="a-btn" onclick="moreMessage();">
												<i class="icon icon-icon"></i>更多
											</div>
										</div>
									</div></li>
									<li>
                                    <i title="皮肤" class="icon grey20 icon-pifu changui" onclick="changeThemesSkinsEvent();return false;"></i>
                                    </li>
								<li class="dropdown"><i title="更多"
									class="icon grey20 icon-gengduo" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"></i>
									<div class="dropdown-menu dropdown-menu-right pull-right">
										<ul class="	avic-dropmenu avic-smenu auto">
											<li onclick="showLicenseInfo();return false;"><i
												class="icon icon-shouquan"></i>授权信息</li>
											<li onclick="showVersionInfo();return false;"><i
												class="icon icon-banben"></i>版本信息</li>
										</ul>
									</div></li>
							</ul>
						</div>
						<div class="userinfo dropdown">
							<p class="dropdown-toggle" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="true">
								您好,<span class="username">[<c:out value="${userName}" />]</span>
							</p>
							<ul
								class="dropdown-menu dropdown-menu-right avic-dropmenu pull-right">
								<li class="user-card">
									<div class="usercont">
										<div class="userhead"
											style="background-image:url('${userHeadURI}');filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='${userHeadURI}',sizingMethod='scale');
                                        ">
											<!--     <i class="switch" onclick="userSwich();"></i>
 -->
										</div>
										<div class="userbase">
											<p title="<c:out value="${userName}" />">
												姓名：<span><c:out value="${userName}" /></span>
											</p>
											<p title="${currentDeptName}">
												部门：<span class="department">${currentDeptName}</span>
											</p>
											<p title="${currentPositionName}">
												岗位：<span class="job">${currentPositionName}</span>
											</p>
										</div>
									</div>
									<div class="btns">
										<div class="a-btn" onclick="settings();">设置</div>
										<div class="a-btn" onclick="logout();">退出</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 主页面头部工具条 End -->

			<!-- 页面内容区 Start -->
			<div class="main">
				<div id="tabs-panel" class="mainbody easyui-tabs"
					data-options="tools:'#tab-tools',fit:true,border:false,tabHeight:34">
					<div title="首页" data-options="fit:true,border:false">
						<iframe src="" id="mainFrame" name="mainFrame"
							frameborder="0"></iframe>
					</div>

				</div>
			</div>
			<!-- 页面内容区 End -->
		</div>
		<!-- 主页面 End -->
	</div>


	<div class="hiddenMenu">
        <div id="indexMenu" class="tabsSubMenu" data-for="首页" style="width:400px;">
            <ul class="indexMenuContent">
                <li class="changeUrl checked" rel="guider.html">
                    <div><i></i><span class="cn">我的工作</span><span class="setting"></span></div>
                </li>
            </ul>
            <div class="btns" onclick="userDefinedPortlet_add();return false;">
            	<ul>
            		<li><em class="icon icon-add"></em>添加首页</li>
            	</ul>
            </div>
        </div>
    </div>
	<!-- 添加常用的模态框 Start -->
	<div id=addFrequently class="model-s"></div>
	<!-- 添加常用的模态框 End -->
	<!-- 模态框 End -->

	<!-- 框架依赖 jquery-1.9.1.js -->
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/jquery-1.9.1.js"></script>
	<!-- 基础框架依赖 bootstrap.js -->
	<script type="text/javascript"
		src="static/fixie/bsie/bootstrap/js/bootstrap.js"></script>
	<!--[if lte IE 6]>
        <script type="text/javascript" src="js/ie6/bsie/js/bootstrap-ie.js"></script>
    <![endif]-->
	<!-- 弹层组件 layer.js -->
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/layer.js"></script>
	<!-- jquery-tabs 脚本依赖 -->
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/effectIe.js"></script>
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/easyloader.js"></script>
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/plugins/jquery.parser.js"></script>
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/plugins/jquery.linkbutton.js"></script>
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/plugins/jquery.menu.js"></script>
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/plugins/jquery.menubutton.js"></script>
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/plugins/jquery.tabs.js"></script>
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/plugins/jquery.panel.js"></script>
	<script type="text/javascript" src="static/h5/common-ext/avic.ajax.js"></script>
	 <script type="text/javascript" src="avicit/platform6/portal/themes/fixie/js/SysMsgPubIe.js"></script>
<!-- 	<script type="text/javascript"
		src="avicit\platform6\portal\themes\oa\js\oa.js"></script> -->
	<!-- 页面脚本 index.js-->
	<script type="text/javascript"
		src="avicit/platform6/portal/themes/fixie/js/index-ie6.js"></script>
		
		
		<script  type="text/javascript">
// 	    $('#oacollection').oaCollectionPortal();//个人收藏初始化
        var REFRESHINTERVAL = '${refreshInterval}';//消息刷新间隔
        if(REFRESHINTERVAL==null||REFRESHINTERVAL==''){
            REFRESHINTERVAL = "30000";//默认30秒
        }
        setInterval(queryUnReadMessageAmount,parseInt(REFRESHINTERVAL));
		$(function(){
			$('#console').css("height",document.documentElement.clientHeight-50);
			$('#portal').css("height",document.documentElement.clientHeight-50);
			$('#portlet').css("height",document.documentElement.clientHeight-50);
			
			$('#keywords').bind('keypress',function(event){ 
		         if(event.keyCode == 13){  
		        	 execSearch();  
		         }  
		     });
			$("#headSubmit").click(function(){
				execSearch();
			});
			$("#addMessageDialog").on("click", function() {	
				    var addIndex = layer.open({
			        type: 2,
			        area: ['70%', '70%'],
			        title: '添加',
			        maxmin: false, //开启最大化最小化按钮
			        content: 'avicit/platform6/portal/themes/fixie/jsp/SysMsgPubAddIe6.jsp?type=addMessageDialog'
			    });
		   });
			 $("#unreadMessage").on("click", function() {	
			    	loadPersonalMessage();
			    });
		});
		$(window).resize(function(){
			$('#console').css("height",document.documentElement.clientHeight-50);
			$('#portal').css("height",document.documentElement.clientHeight-50);
			$('#portlet').css("height",document.documentElement.clientHeight-50);
		});
		$('.userinfo').on('mouseleave',function(e){
			if(!$(e.target).is('.userinfo')){
			$(this).trigger('click');
			}
		});
		function execSearch(){
			var id = "#tabs-panel";
			var curTabTitle = "搜索";//对应标签的title 这里需要你手动获取别参考代码
			var nowurl = $(id).tabs("getTab", curTabTitle);
			if(null!=nowurl&&nowurl!=""){
				var keywords = document.getElementById("keywords").value;
				$(id).tabs("getTab", curTabTitle).find('iframe').attr('src', 'platform/search/search.html?keywords='+encodeURI(encodeURI(keywords))+'&histKey=1');
			}else{
				var keywords = document.getElementById("keywords").value;
				addTab('搜索','platform/search/search.html?keywords='+encodeURI(encodeURI(keywords))+'&histKey=1');
			}
		 }
		
		/**IM**/
		<%if("true".equals(PlatformProperties.getProperty(PlatformConstant.IM_START))){ %>
		$(function(){
			try{
				Chat.connect("<%=SessionHelper.getLoginSysUser(request).getLoginName()%>", "<%=SessionHelper.getLoginSysUser(request).getLoginPassword()%>");
			}catch(e){
			}
		});
		<%} %>
</script>
</body>
</html>