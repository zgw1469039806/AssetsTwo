<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 格尔安全认证网关登录页面 -->
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<%@page import="org.apache.log4j.Logger"%>
<%@ page import="avicit.platform6.commons.utils.DESUtils"%>
<%@ page import="org.springframework.util.ObjectUtils"%>
<%
	Logger logger = Logger.getLogger(this.getClass());
	// FXIME 以后能把登录和注销相关代码进行一下重构，现在有点乱
	// 登录页

	String path = request.getContextPath();
	String loginJsp ="/login/console/login.jsp";
	String username = "";
	String sURI = "";
	// 集成认证成功后跳转登录action
    Cookie[] cookies = request.getCookies();
	if (cookies == null) {
		cookies = new Cookie[0];
	} 
	String loginAction = null;
	for (Cookie ck : cookies) {
		logger.info(ck.getName() + " = " + ck.getValue());
		if ("KOAL_CERT_CN".equals(ck.getName())) {
			username = new String(URLDecoder.decode(ck.getValue(), "ISO-8859-1").getBytes("ISO-8859-1"), "GBK");
			username = DESUtils.encrypt(username);
			sURI = request.getParameter("sourceURI");
			/**
			*  此处不再对用户名进行md5加密 马义 2010年10月21日
			loginAction =path+ "/platform/user/caslogin?username_=" +username;
			*/
			//username = MD5Utils.getMD5DigestHex(URLEncoder.encode(username, "UTF-8")).toLowerCase();
			// 因为这里的用户名已经MD5过，所以可以直接在url中进行传递
			//loginAction =path+ "/platform/user/caslogin?username_=" + URLEncoder.encode(username, "UTF-8");
			loginAction =path+ "/caslogin?username_=" + URLEncoder.encode(username, "UTF-8");
			if(sURI != null && !"".equals(sURI)){
				if(!sURI.startsWith("/")){
					sURI = "/" + sURI;
				}
				if(!sURI.startsWith(path)){
					sURI = path + sURI;
				}
				loginAction += "&sourceURI=" + URLEncoder.encode(sURI,"UTF-8");
			}
			break;
		}
	}
	if (loginAction != null) {
		//response.sendRedirect(response.encodeRedirectURL(loginAction));
	} else {
		request.getRequestDispatcher(loginJsp).forward(request, response);
	}
%>
<script type="text/javascript">
function submitForm() {
	document.getElementById("casLogin").submit();
}
</script>
<body onload="submitForm()">
	<form id="casLogin" action="<%=path%>/platform/user/caslogin" method="post" style="display: none">
		<input  id="username_" name="username_" type="hidden" value="<%=username%>"></input>
		<input  id="sourceURI" name="sourceURI" type="hidden" value="<%=sURI%>"></input>
		<input  id="sourceQueryString" name="sourceQueryString" type="hidden" value="<%=sourceQueryString%>"></input>
	</form>
</body>
