<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>展示详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
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
<script src="avicit/platform6/mda_easyui/mdasearchconfig/js/MdaSearchconfig.js" type="text/javascript"></script>
<script type="text/javascript">


</script>


</html>