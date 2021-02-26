<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<% 
String importlibs = "common,tree,table,form";	
String _treeNodeId = "\'"+request.getParameter("_treeNodeId")+"\'";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>岗位待办积压最多排名</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/flowMonitoring/bpaDataAnalyze/css/analyze.css">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>
<style type="text/css">
div#customText {
    font-size:  14px;
    padding-left: 14px;
    padding-top: 6px;
}
</style>
</head>
<body>
	<div>
        <img style="height: 287px;width:  900px;" src="avicit/platform6/flowMonitoring/bpaDataAnalyze/photo/positionBacklog.jpg"  alt="岗位待办积压最多排名" />
    </div>
	<div id="customText" class="text" style="visibility: visible;">
	 	<p>
			<span>维度X：岗位</span>
		</p>
		<p>
			<span>维度Y：待办任务的数量</span>
		</p>
	   	<p>
			<span>描   述  ：正在办理的任务   </span><br>
	    </p>
	</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">

</script>
</html>