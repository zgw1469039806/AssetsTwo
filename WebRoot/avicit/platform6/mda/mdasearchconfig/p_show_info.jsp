<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>展示详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
  <table border="1" align="left">
	<tr>
	<c:forEach  var="head" items="${tableHeader}">
		<th>
			${head}
		</th>
	</c:forEach>
	</tr>
	<tr>
		<c:forEach  var="body" items="${tableBody}">
		<td>
			${body}
		</td>
	</c:forEach>
	</tr>
	</tbody>
</table>



</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdasearchconfig/js/MdaSearchconfig.js" type="text/javascript"></script>
<script type="text/javascript">


</script>


</html>