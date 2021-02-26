<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.core.spring.SpringFactory"%>
<%@page import="avicit.platform6.api.syslookup.SysLookupAPI"%>
<%@page import="avicit.platform6.api.syslookup.dto.SysLookupSimpleVo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>刷新缓存</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<style type="text/css">
iframe{
	width : 100%;
	height : 100%;
	border:0px;
}
</style>
<%
	SysLookupAPI sysLookupAPI = SpringFactory.getBean(SysLookupAPI.class);
	Collection<SysLookupSimpleVo> vos = sysLookupAPI.getLookUpListByType("PLATFORM_CACHEMANAGER");
	if (vos == null) {
		vos = new ArrayList<SysLookupSimpleVo>();
	}
%>
</head>

<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<div class="easyui-tabs" data-options="fit:true,plain:true,tabPosition:'top',toolPosition:'right'">
			<div title="本地缓存" data-options="iconCls:'icon-refresh'" style="padding:10px">
				<iframe src="avicit/platform6/modules/system/sysdashboard/reLoadCache_single.jsp" frameborder="no"></iframe>
			</div>
			<%
				for (SysLookupSimpleVo vo : vos) {
			%>
			<div title="<%=vo.getLookupName()%>" data-options="iconCls:'icon-refresh'" style="padding:10px">
				<iframe src="<%=vo.getLookupCode()%>avicit/platform6/modules/system/sysdashboard/reLoadCache_single.jsp" frameborder="no"></iframe>
			</div>
			<%
				}
			%>
		</div>
	</div>
</body>
</html>
