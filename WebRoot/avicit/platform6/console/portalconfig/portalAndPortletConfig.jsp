<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div class="easyui-layout" fit="true" >
	<ul id="myTab" class="nav nav-tabs">
		<li class="active"><a rel='portal_ifrm' href="#portal" data-toggle="tab">主题皮肤</a></li>
		<li><a rel='portlet_ifrm' href="#portlet" data-toggle="tab">多栏目门户</a></li>
		<li><a rel='logo_ifrm' href="#logo" data-toggle="tab">logo配置</a></li>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="portal">
			<iframe id='themeSkinsFrame' name='themeSkinsFrame' src='' frameborder='0'  width="100%" height="500"></iframe>
		</div>
		
		<div class="tab-pane fade" id="portlet">
				<iframe id="portletFrame" name="portletFrame" src="" scrolling="auto" frameborder="0" src="" style="width:100%;height:500;"></iframe>
		</div>
		
		<div class="tab-pane fade" id="logo">
				<iframe id="logoFrame" name="logoFrame" src="" scrolling="auto" frameborder="0" src="" style="width:100%;height:500;"></iframe>
		</div>
	</div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 模块js -->
<!-- <script type="text/javascript" src="avicit/platform6/console/user/js/OrgTree.js" ></script> -->
<script type="text/javascript">
	$(document).ready(function(){
		$('#themeSkinsFrame').css("height",document.documentElement.clientHeight - 20);
		$('#portletFrame').css("height",document.documentElement.clientHeight - 20);
		$('#logoFrame').css("height",document.documentElement.clientHeight - 20);
	});
	$(window).resize(function(){
		$('#themeSkinsFrame').css("height",document.documentElement.clientHeight - 20);
		$('#portletFrame').css("height",document.documentElement.clientHeight - 20);
		$('#logoFrame').css("height",document.documentElement.clientHeight - 20);
	});
	$(document).ready(function(){
		document.getElementById('themeSkinsFrame').src = 'platform/console/portal/toPortalConfig?appId=${appId}';
// 		document.getElementById('portletFrame').src = 'platform/portal/portlet/toPortletConfig?resourceType=default';
		
		$('#myTab a').click(function (e) {
			 e.preventDefault();
			$(this).tab('show');
			if($(this).attr('rel') == 'portlet_ifrm'){
				if($('#portletFrame').attr('src') == ''){
					$('#portletFrame').attr('src','platform/portal/portlet/toPortletConfig?resourceType=default&appId=${appId}&orgIdentity=${orgIdentity}');
				}
			}else if($(this).attr('rel') == 'logo_ifrm'){
				if($('#logoFrame').attr('src') == ''){
					$('#logoFrame').attr('src','platform/console/logo/toLogoConfig?appId=${appId}');
				}
			}
		});
	});
</script>
<input type='hidden' id='appId' name='appId' value='${appId}'/>
<input type='hidden' id='orgIdentity' name='orgIdentity' value='${orgIdentity}'/>
</body>
</html>