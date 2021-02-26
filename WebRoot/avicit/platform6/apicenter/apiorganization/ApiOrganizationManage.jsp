<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,tree,form";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "monitor/monitororganization/monitorOrganizationController/toMonitorOrganizationManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" id="bsztree" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro.css" />
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeviewmin-fixie8.css" />
<style>
.busDomainIcon_ico_docu {
	margin-right: 2px;
	background: url(./avicit/platform6/apicenter/apimanage/images/yewuyu.png) no-repeat scroll 0px 2px transparent !important;
	vertical-align: top;
	*vertical-align: middle
}
.busDomainIcon_ico_open{
	margin-right: 2px;
	background: url(./avicit/platform6/apicenter/apimanage/images/yewuyu.png) no-repeat scroll 0px 2px transparent !important;
	vertical-align: top;
	*vertical-align: middle
}
.busDomainIcon_ico_close{
	margin-right: 2px;
	background: url(./avicit/platform6/apicenter/apimanage/images/yewuyu.png) no-repeat scroll 0px 2px transparent !important;
	vertical-align: top;
	*vertical-align: middle
}
</style>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div class="easyui-layout" style="height: 100%; width: 100%">
			<div id="_tree-center" data-options="region:'center',width:'100%'" style="padding-right: 10px">
				<ul id="_ztree" class="ztree" style="width: 100%; height: 100%"></ul>
			</div>
		</div>

	</div>
	<input id="id" type="hidden" value="${id}">
	<input id="name" type="hidden" value="${name}">
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<!-- 模块js -->
	<script src="avicit/platform6/apicenter/apiorganization/js/ApiOrganization.js" type="text/javascript"></script>

	<script type="text/javascript">
		var monitorOrganization;
		$(document).ready(
				function() {
					monitorOrganization = new MonitorOrganization('_ztree',
							'${url}', 'form', 'txt', 'searchbtn');
					monitorOrganization.init();
					
				});
	</script>
</body>
</html>