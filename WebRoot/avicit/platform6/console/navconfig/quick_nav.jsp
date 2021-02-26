<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.core.properties.PlatformConstant"%>
<%@ page import="avicit.platform6.core.properties.PlatformProperties"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" href="avicit/platform6/console/navconfig/css/style.css" />
<!-- <link rel="stylesheet" href="css/font-awesome-4.7.0/css/font-awesome.css" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script> -->
</head>
<body >
	<div class="warpper">
		<div class="content_box">
			<div class=" box_title ">
				<h2 class="title">快速配置向导</h2>
			</div>
			<ul class="clearfix guide_box">
			<c:if test="${fn:contains(url, 'platform/eform/bpmsManageController/toEformManager')}" >
				<li>
					<div class="guide_inner" rel="platform/eform/bpmsManageController/toEformManager" title="表单模型"  onclick="showMenu(this);">
						<div class="guide_img_box">
							<img src="avicit/platform6/console/navconfig/img/bdjm.png" />
						</div>
						<h4>表单建模</h4>
						<p>提供30+种控件</p>
						<p>可视化配置（表单，视图）</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'platform/bpm/deploy/bpmModelManage')}" >
				<li>
					<div class="guide_inner" rel="platform/bpm/deploy/bpmModelManage" title="流程建模" onclick="showMenu(this);">
						<div class="guide_img_box">
							<img src="avicit/platform6/console/navconfig/img/lcjm.png" />
						</div>
						<h4>流程模型</h4>
						<p>可视化配置</p>
						<p>实现流程图的绘制和属性配置</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'platform/console/menu/list')}" >
				<li>
					<div class="guide_inner" rel="platform/console/menu/list" title="菜单管理" onclick="showMenu(this);">
						<div class="guide_img_box">
							<img src="avicit/platform6/console/navconfig/img/cdgl.png" />
						</div>
						<h4>菜单管理</h4>
						<p>维护基础菜单、门户小页</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'platform/console/auth/unified')}" >
				<li>
					<div class="guide_inner" rel="platform/console/auth/unified" title="集中授权管理" onclick="showMenu(this);">
						<div class="guide_img_box">
							<img src="avicit/platform6/console/navconfig/img/jzsq.png" />
						</div>
						<h4>集中授权</h4>
						<p>对系统的菜单及</p>
						<p>组件进行权限设置</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toSysDataPermissionsMethodManage')}" >
				<li>
					<div class="guide_inner" rel="platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toSysDataPermissionsMethodManage" title="数据授权" onclick="showMenu(this);">
						<div class="guide_img_box">
							<img src="avicit/platform6/console/navconfig/img/sjqx.png" />
						</div>
						<h4>数据授权</h4>
						<p>支持多维度的数据授权</p>
						<p>满足业务中行数据权限控制</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'platform/db/dbTableManageController/toDbManager')}" >
				<li>
					<div class="guide_inner" rel="platform/db/dbTableManageController/toDbManager" title="存储模型"  onclick="showMenu(this);">
						<div class="guide_img_box">
							<img src="avicit/platform6/console/navconfig/img/ccmx.png" />
						</div>
						<h4>存储模型</h4>
						<p>适配Oracle、MySql、SQLServer</p>
						<p>等数据库</p>
					</div>
				</li>
				</c:if>
			</ul>
		</div>
		<div class="content_box" style="margin-top: 20px;">
			<div class=" box_title ">
				<h2 class="title">常用功能</h2>
			</div>
			<ul class="clearfix app_ul">
			<c:if test="${fn:contains(url, 'avicit/platform6/modules/system/sysdashboard/reLoadCache_new.jsp')}" >
				<li>
					<div class="app" rel="avicit/platform6/modules/system/sysdashboard/reLoadCache_new.jsp" title="刷新缓存" onclick="showMenu(this);">
						<i class="fa fa-refresh"></i>
						<p>刷新缓存</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'platform/console/portal/toPortalAndPortletConfig')}" >
				<li>
					<div class="app" rel="platform/console/portal/toPortalAndPortletConfig" title="门户配置" onclick="showMenu(this);">
						<i class="fa fa-envira"></i>
						<p>门户配置</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'console/lookup/toSysLookupTypeManage')}" >
				<li>
					<div class="app" rel="console/lookup/toSysLookupTypeManage" title="通用代码管理" onclick="showMenu(this);">
						<i class="fa fa-th"></i>
						<p>通用代码</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'console/profile/toProfileManage')}" >
				<li>
					<div class="app" rel="console/profile/toProfileManage" title="系统参数配置" onclick="showMenu(this);">
						<i class="fa fa-microchip"></i>
						<p>系统参数</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'platform/console/role/toSysRoleManage')}" >
				<li>
					<div class="app" rel="platform/console/role/toSysRoleManage" title="角色模型" onclick="showMenu(this);">
						<i class="fa fa-users"></i>
						<p>角色模型</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'platform/console/authmenu/unified')}" >
				<li>
					<div class="app" rel="platform/console/authmenu/unified" title="前台菜单授权" onclick="showMenu(this);">
						<i class="fa fa-lock"></i>
						<p>菜单授权</p>
					</div>
				</li>
				</c:if>
				<c:if test="${fn:contains(url, 'avicit/platform6/autocode/SysAutoCodeManage.jsp')}" >
				<li>
					<div class="app" rel="avicit/platform6/autocode/SysAutoCodeManage.jsp" title="编码管理" onclick="showMenu(this);">
						<i class="fa fa-sliders "></i>
						<p>编码管理</p>
					</div>
				</li>
				</c:if>
			</ul>
		</div>
	</div>
</body>
<script type="text/javascript">
		function showMenu(obj){
			var url = $(obj).attr("rel");
			var title = $(obj).attr("title");
				top.addTab(title, url,true);
		}
	</script>

</html>