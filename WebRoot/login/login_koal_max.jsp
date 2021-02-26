<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="org.apache.log4j.Logger"%>
<%
	String path = request.getContextPath();

    Logger logger = Logger.getLogger(this.getClass());
    
    String username = request.getHeader("iv-user");
	String sURI=request.getParameter("sourceURI");
	String loginJsp ="/login/login.jsp";
	String loginAction = "";
	if (username != null) {
		loginAction = "/platform/user/caslogin?username_="+username;
		if(sURI!=null&&!"".equals(sURI)){
			if(!sURI.startsWith("/")){
				sURI ="/" + sURI;
			}
			if(!sURI.startsWith(path)){
				sURI = path + sURI;
			}
			loginAction+="&sourceURI="+java.net.URLEncoder.encode(sURI,"UTF-8");
		}
	} else {
		loginAction = loginJsp;
	}
%>
<script type="text/javascript">
	var _href = window.location.href;
	if(_href.indexOf('/login/login_koal_max.jsp') > 0){
		_href = _href.substring(0,_href.indexOf('/login/login_koal_max.jsp'));
	}else{
		_href = '<%=path %>';
	}
	var url = _href + '<%=loginAction%>';
	if(window.screen){
		var w = screen.availWidth;
		var h = screen.availHeight;
		
		var myWindow = window.open(url,'','location=no');
		myWindow.moveTo(0, 0);
		myWindow.resizeTo(w, h);
		
		window.open('about:blank','_self');
		window.opener = null;
		window.close();
	}else{
		window.location.href = url;
	}
</script>