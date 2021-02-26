<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
String importlibs = "common";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<ul id="myTab" class="nav nav-tabs">
	<li class="active"><a rel='portal_ifrm' href="#portal" data-toggle="tab">前台菜单</a></li>
    <c:if test="${show}">
        <li><a rel='console_ifrm' href="#console" data-toggle="tab">后台菜单</a></li>
    </c:if>
	<li><a rel='portlet_ifrm' href="#portlet" data-toggle="tab">门户小页</a></li>
</ul>
<div id="myTabContent" class="tab-content">
	<div class="tab-pane fade in active" id="portal">
	</div>
	<div class="tab-pane fade" id="console">
			<iframe id="console_ifrm" src="" scrolling="no" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
	</div>
	
	<div class="tab-pane fade" id="portlet">
			<iframe id="portlet_ifrm" src="" scrolling="no" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
	</div>
</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script  type="text/javascript">

$(function(){
    var appid='<c:out value="${sappId}"/>'||'<c:out value="${param.appid}"/>';

    appid=appid||1;

    $('#console').css("height",document.documentElement.clientHeight-50);
	$('#portal').css("height",document.documentElement.clientHeight-50);
	$('#portlet').css("height",document.documentElement.clientHeight-50);

	setTimeout(function(){
			var $frame=$('<iframe id="portal_ifrm" scrolling="no" frameborder="0" style="width:100%;height:100%;"></iframe>');
			$frame.attr("src","console/menu/portal/"+appid);
			$frame.appendTo($('#portal'));
		},10);

	var ifrm={'console_ifrm':'console/menu/console/'+appid,
			  'portlet_ifrm':'console/menu/portlet/'+appid};

	  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	  	if(!$('#'+e.target.rel).attr('src')){
	  		$('#'+e.target.rel).attr('src',ifrm[e.target.rel]);
	  	}
	  });
	
})
$(window).resize(function(){
	$('#console').css("height",document.documentElement.clientHeight-50);
	$('#portal').css("height",document.documentElement.clientHeight-50);
	$('#portlet').css("height",document.documentElement.clientHeight-50);
});

	//alert($(window).height());
</script>
</html>