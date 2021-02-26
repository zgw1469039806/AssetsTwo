<%@ page contentType="text/html; charset=GBK"%>
<!-- CAS安全认证网关登录页面 -->
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="avicit.platform6.commons.utils.DESUtils"%>
<%@ page import="org.springframework.util.ObjectUtils"%>
<%
	String loginAction = null;
	String path = request.getContextPath();
	String username = ObjectUtils.getDisplayString(request.getSession().getAttribute("LOGIN"));
// 	java.security.Principal principal = request.getUserPrincipal();
// 	if (principal != null) {
// 		username = principal.getName();
// 	}
	username = DESUtils.encrypt(username);
	
	String sURI = ObjectUtils.getDisplayString(request.getParameter("sourceURI"));
	String sourceQueryString = ObjectUtils.getDisplayString(request.getParameter("sourceQueryString"));
%>
<script type="text/javascript">
function submitForm() {
	document.getElementById("casLogin").submit();
}
</script>
<body onload="submitForm()">
	<form id="casLogin" action="<%=path%>/caslogin" method="post" style="display: none">
		<input  id="username_" name="username_" type="hidden" value="<%=username%>"></input>
		<input  id="sourceURI" name="sourceURI" type="hidden" value="<%=sURI%>"></input>
		<input  id="sourceQueryString" name="sourceQueryString" type="hidden" value="<%=sourceQueryString%>"></input>
	</form>
</body>
