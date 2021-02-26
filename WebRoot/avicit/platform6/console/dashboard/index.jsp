
<%@page language="java"  pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@page import="avicit.platform6.api.sysuser.dto.SysUser"%>
<%@page import="avicit.platform6.api.sysuser.SysOrgAPI"%>
<%@page import="avicit.platform6.core.spring.CacheSpringFactory"%>
<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="avicit.platform6.api.sysprofile.SysProfileAPI"%>
<%

String deptName = SessionHelper.getCurrentDeptName(request);


SysUser user = (SysUser)SessionHelper.getLoginSysUser(request);

String loginName = user.getName();

String userId = user.getId();

String orgName =CacheSpringFactory.getInstance().getBean(SysOrgAPI.class).getSysOrgNameBySysOrgId(session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_ORG).toString(), SessionHelper.getSystemDefaultLanguageCode());
SysProfileAPI sysProfileAPI = CacheSpringFactory.getInstance().getBean(SysProfileAPI.class);
%>
<!DOCTYPE html>
<html >
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" > 
	<meta name="renderer" content="webkit|ie-stand">
	<title>欢迎使用-业务基础平台-控制台</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<style type="text/css">
	  * {
	    font-family:"Microsoft YaHei";
	  }
	</style>
	<link rel="shortcut icon" href="favicon.ico" mce_href="favicon.ico" type="image/x-icon">
	<!-- 样式标准化 boostrap.css -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/console/dashboard/compent/bootstrap/3.3.4/css_default/bootstrap.css">

	<!-- jquery-tabs样式依赖 -->
	<!--平台公共图标库文件  -->
    <link rel="stylesheet" type="text/css" href="static/h5/skin/iconfont/iconfont.css"/>
 	<link rel="stylesheet" type="text/css" href="avicit/platform6/console/dashboard/css/index.min.css">
 	<link rel="stylesheet" type="text/css" href="avicit/platform6/console/dashboard/css/index.css">
 	<link rel="stylesheet" type="text/css" href="static/h5/skin/topFixed.css">
    <script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="static/h5/bootstrap/3.3.4/js/bootstrap.js"></script>
    
    <link rel="stylesheet" type="text/css" href="avicit/platform6/portal/css/loadding.css">
	<!-- 更换皮肤用占位link标签 -->
	<link id="theme" rel="stylesheet" href="">


	<!-- ie8下boostrap样式修复 -->
	<!--[if lt IE 9]>
	<script type="text/javascript" src="static/h5/boostrap/html5shiv.js"></script>
	<script type="text/javascript" src="static/h5/boostrap/respond.min.js"></script>
	<![endif]-->
</head>
<body>
	<div class="mainBody">
		<!-- 头部工具栏Start -->
		<div class="header">
			<a  class="logo" href="#"><div>业务基础平台控制台</div></a>
			<div class="navbar" id='navbar'>
				
			</div>

			<div class="toolbar">
				<div class="iconbtn">
					<ul>
					    <a href="javascript:void(0);">
						   <li class="icon icon-bell-fill" title="通知"><span id="unreadMessage" style="display: none"></span>
							<ul class="subMenu info auto" id="personMessage">
								<ul class="avic-smenu xl" id="personalMessageUl" style="overflow-y:auto;height:200px;"></ul>
								<div class="btns">
                                    <div class="a-btn" id="addMessageDialog"><i class="icon icon-add"></i>添加</div>
                                    <div class="a-btn" onClick="moreMessage();"><i class="icon icon-more"></i>更多</div>
                                </div>
							</ul>
						 </li>
						</a>
						<a href="javascript:void(0);">
							<li id="portal" class="icon icon-shouye" title="门户首页">
								<!-- <ul class="subMenu">
									<li ><span id="portal">门户首页</span></li>
									<li><span  id="update_password">密码修改</span></li>
								</ul> -->
							</li>
						</a>
						<a href="javascript:void(0);">
						   <li class="userNameLi" title="<%=loginName%>">
						   	  <div class="userNameBox">
								<span class="username"><c:out  value='<%=loginName%>'/></span>
								<i class="icon iconfont icon-xiangxiajiantou-mianxing"></i>
							  </div>
							  <ul class="subMenuPerson subMenu info ">
							  	<div class="MenuPerson">
									 <div class="head"><img  id="sysUserHeadPhotoImg" src="">
										<!-- <i class="switch" onclick='openChangeMoreOrgDailog();return false;'></i> -->
									 </div>
	                                 <div class="user">
	                                    <p class="namePerson" title="c"><c:out  value='<%=loginName%>'/></p>
	                                    <p class="name" title="<%=orgName%>">组织 : <%=orgName%></p>
	                                    <p class="name" title="<%=deptName%>">部门 : <%=deptName%></p>
	                                 </div>
                                 </div>
                                 <div class="personButton">
									 <div class="userinfoDiv">
										<p onclick='openChangeMoreOrgDailog();return false;'><i class="icon iconfont icon-qiehuanzhanghaohei"></i>切换组织</p>
									 </div>
									 <div class="userinfoDiv">
										<p id="update_password"><i class="icon iconfont icon-key"></i>修改密码</p>
									 </div>
								 </div>
								 <div class="personButton">
									 <div class="userinfoDiv">
										<p onclick="logout('<%=ViewUtil.getRequestPath(request)%>')"><i class="icon iconfont icon-tuichu"></i>退出登录</p>
									 </div>
								 </div>
							  </ul>
						   </li>
						</a>
					</ul>
				</div>
			</div>
		</div>
		<!-- 头部工具栏end -->

		<div class="bodyCont">
			<!-- 内容区Start -->
			<!-- <div class="iframeCont">
				<iframe id="contFrame" src="avicit/platform6/console/dashboard/index_portal.jsp"></iframe>
			</div> -->
			<div id="tabs-panel" class="iframeCont easyui-tabs" data-options="fit:true,border:false,tabHeight:30">
				<!-- <div title="首页" data-options="fit:true,border:false">
					 <iframe src="avicit/platform6/console/monitor/info.jsp"></iframe> 
					 <iframe src="avicit/platform6/console/navconfig/quick_nav.html"></iframe> 
				</div> -->
			</div>
			<!-- 内容区End -->
		</div>
	</div>


	<!-- 加载层 -->
	<div class="square">
		<div class="box">
			<div class="square-gradient">
				<i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i> <i class="gradient"></i>
				<i class="gradient"></i>
			</div> 
			<p>系统正在加载，请稍等...</p>
		</div>
	</div>

	<!-- 换肤按钮Start -->

	<script type="text/javascript" src="avicit/platform6/console/dashboard/js/index2.js"></script>

	<script type="text/javascript" src="avicit/platform6/console/dashboard/js/jquery.changeui.js"></script>
	<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>

	<script type="text/javascript" src="avicit/platform6/console/dashboard/js/easyloader.js"></script>
	<script type="text/javascript" src="avicit/platform6/console/dashboard/js/plugins/jquery.parser.js"></script>
	<script type="text/javascript" src="avicit/platform6/console/dashboard/js/plugins/jquery.menu.js"></script>
	<script type="text/javascript" src="avicit/platform6/console/dashboard/js/plugins/jquery.tabs.js"></script>
	<script type="text/javascript" src="avicit/platform6/console/dashboard/js/plugins/jquery.panel.js"></script>
	<script type="text/javascript" src="avicit/platform6/portal/message/js/SysMsgPub.js"></script>
	
	<script type="text/javascript" >
	     var consoleFlag = "_console";//定义全局变量用于区分前后台
		 var baseUrl = '<%=ViewUtil.getRequestPath(request)%>';
		 var userId = '<%=userId%>';
         var REFRESHINTERVAL ="<%=sysProfileAPI.getProfileValueByCode("PLATFORM_V6_MESSAGE_REQUEST_INTERVAL")%>";//消息刷新间隔
         if(REFRESHINTERVAL==null||REFRESHINTERVAL==''){
             REFRESHINTERVAL = "30000";//默认30秒
         }
         setInterval(queryUnReadMessageAmount,parseInt(REFRESHINTERVAL));
         setInterval(loadPersonalMessage,parseInt(REFRESHINTERVAL));
		 $(document).ready(function () {
			 //修改初始化内容滚动条问题
			 $('#tabs-panel').tabs('add', {
                 title: '配置向导',
                 content: '<iframe scrolling="auto" frameborder="0"  src="console/toQuickNav" style="width:100%;height:100%;"></iframe>',
                 closable: false
             });

			 
		 	$('#portal').on('click',function(){
		 		window.open(baseUrl+'portal','_portal');
			});
			
			$("#sysUserHeadPhotoImg").attr("src",baseUrl+"platform/console/userupload/headerphoto?sysUserId=<%=userId%>");
			
			
			$('#update_password').on('click',function(){
		 		
		 		modifyIndex = layer.open({
	    			type: 2,
	   				area: ['70%', '50%'],
	    			title: '修改密码',
	    			skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        			maxmin: false, //开启最大化最小化按钮
	    			content: '<%=ViewUtil.getRequestPath(request)%>'+'avicit/platform6/console/user/modifyUserPassword.jsp?userId=<%=userId%>' 
				});  
			});
		 });
		 
		 function closeModiyPassworDilog(){
			layer.close(modifyIndex);
		}
	</script>
<!--[if lte IE 8]>
<link rel="stylesheet" type="text/css" href="static/h5/common-ext/checkbrower/checkbrowser.css">
<script type="text/javascript" src="static/h5/common-ext/checkbrower/checkbrowser.js"></script>
<![endif]-->
</body>
</html>