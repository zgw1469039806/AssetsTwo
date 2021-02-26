<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>


<!DOCTYPE html>
<html>

<head>
<title>ApiService</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link rel="stylesheet" href="avicit/platform6/apicenter/apimanage/css/codemirror.css" type="text/css" />


<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" /></jsp:include>

<style>

.CodeMirror{
  height:100%;
}

#show_code_exmple{
   padding-top:10px;
}

</style>
</head>

<body>
	
	<div id="show_code_exmple">
	
	<textarea id="java-code">${apiInfoManageDTO.apiSampleCode}</textarea>
	
	</div>
	
	
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" /></jsp:include>
	<script src="avicit/platform6/apicenter/apimanage/js/codemirror.js" type="text/javascript"></script>
	<script src="avicit/platform6/apicenter/apimanage/js/clike.js" type="text/javascript"></script>
	<script>
	var javaEditor = CodeMirror.fromTextArea(document.getElementById("java-code"), {
        lineNumbers: true,
        matchBrackets: true,
        mode: "text/x-java",
        readOnly: true
      });
	$("#show_code_exmple").height($(window).height() - 10);
	</script>

</body>
</html>