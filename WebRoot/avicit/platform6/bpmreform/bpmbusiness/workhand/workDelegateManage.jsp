<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common";
%>
<!DOCTYPE html>
<html>
<head>

<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

</head>
<body>
<ul id="myTab" class="nav nav-tabs" style="width:100%;height:100%;">
	<li class="active"><a rel="iframe1" href="#workDelegate" data-toggle="tab" id="tab1" >我的委托</a></li>
	<li><a rel="iframe2" href="#myWorkDelegate" data-toggle="tab" id="tab2" >我的受托</a></li>
</ul>
<div id="myTabContent" class="tab-content" style="width:100%;height:100%; border: 0;">
	<div class="tab-pane fade in active" id="workDelegate" style="width:100%;height:100%; border: 0;">
	</div>
	<div class="tab-pane fade" id="myWorkDelegate" style="width:100%;height:100%; border: 0;">
		<iframe id="iframe2" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
	</div>
</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
var subtractHeight= 39;
$(function(){
	$("#myTabContent").css('height',$(document).innerHeight() -subtractHeight);
	//$("#myTabContent").css('height',document.documentElement.clientHeight -41);
	
	
	setTimeout(function(){
		var url = "avicit/platform6/bpmreform/bpmbusiness/workhand/workDelegate.jsp";
		$('<iframe id="iframe1" src="'+url+'"  scrolling="no" frameborder="0" style="width: 100%;height: 100%; border: 0;"></iframe>').appendTo($('#workDelegate'));
	},10);
	
	var url2 = "avicit/platform6/bpmreform/bpmbusiness/workhand/myWorkDelegate.jsp";
	var ifrm={'iframe2':url2
			  };

	  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	  	if(!$('#'+e.target.rel).attr('src')){
	  		$('#'+e.target.rel).attr('src',ifrm[e.target.rel]);
	  	}
	  });
})



$(window).resize(function(){
	$("#myTabContent").css('height',$(document).innerHeight() -subtractHeight);
});

</script>
</html>