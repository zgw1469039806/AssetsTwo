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

<!-- ControllerPath = "ttt/bpmcatalog/bpmCatalogController/toBpmCatalogManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

</head>
<body>
<ul id="myTab" class="nav nav-tabs" style="width:100%;height:100%;">
	<li class="active"><a rel="iframe1" href="#overview" data-toggle="tab" id="tab1" >
		概览</a></li>
	<li><a rel="iframe2" href="#runningProcess" data-toggle="tab" id="tab2" >运行实例</a></li>
	<li><a rel="iframe3" href="#finishedProcess" data-toggle="tab" id="tab3" >结束实例</a></li>
	<li><a rel="iframe4" href="#exceptionProcess" data-toggle="tab" id="tab4" >异常信息</a></li>
	
</ul>
<div id="myTabContent" class="tab-content" style="width:100%;height:100%; border: 0;">
	<div class="tab-pane fade in active" id="overview" style="width:100%;height:100%; border: 0;overflow:hidden;">
		
	</div>
	<div class="tab-pane fade" id="runningProcess" style="width:100%;height:100%; border: 0;overflow:hidden;">
		<iframe id="iframe2" name="iframe2" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
	</div>
	<div class="tab-pane fade" id="finishedProcess" style="width:100%;height:100%; border: 0;overflow:hidden;">
		<iframe id="iframe3" name="iframe3" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
	</div>
	<div class="tab-pane fade" id="exceptionProcess" style="width:100%;height:100%; border: 0;overflow:hidden;">
		<iframe id="iframe4" name="iframe4" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
	</div>
</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
$(function(){
	$("#myTabContent").css('height',$(document).innerHeight() -41);
	//$("#myTabContent").css('height',document.documentElement.clientHeight -41);
	
	
	setTimeout(function(){
		$('<iframe id="iframe1" name="iframe1" src="avicit/platform6/bpmreform/bpmmonitor/overview.jsp"  frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>').appendTo($('#overview'));
	},10);
	
	var ifrm={'iframe1':'avicit/platform6/bpmreform/bpmmonitor/overview.jsp',
			  'iframe2':'avicit/platform6/bpmreform/bpmmonitor/runningProcess.jsp',
			  'iframe3':'avicit/platform6/bpmreform/bpmmonitor/finishedProcess.jsp',
			  'iframe4':'avicit/platform6/bpmreform/bpmmonitor/exceptionProcess.jsp'};

	  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	  	if(!$('#'+e.target.rel).attr('src')){
	  		$('#'+e.target.rel).attr('src',ifrm[e.target.rel]);
	  	}else{
		  	if(window.frames[e.target.rel].bpm_operator_refresh){
		  		window.frames[e.target.rel].bpm_operator_refresh();
			 }
		  	}
	  });
})
function changeTab(num){
 if(num=='1'){
	 
 }else if(num=='2'){
	 $("#iframe"+num).attr("src","avicit/platform6/bpmreform/bpmmonitor/runningProcess.jsp");
 }else if(num=='3'){
	 $("#iframe"+num).attr("src","avicit/platform6/bpmreform/bpmmonitor/finishedProcess.jsp");
 }else if(num=='4'){
	 $("#iframe"+num).attr("src","avicit/platform6/bpmreform/bpmmonitor/exceptionProcess.jsp");
 }
}


$(window).resize(function(){
	$("#myTabContent").css('height',$(document).innerHeight() -41);
});

</script>
</html>