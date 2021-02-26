<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common";
	String nodeId = "\'"+request.getParameter("nodeId")+"\'";
	String nodeType = "\'"+request.getParameter("nodeType")+"\'";
	String pdId = "\'"+request.getParameter("pdId")+"\'";
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
	<li class="active"><a rel="iframe1" href="#myDraft" data-toggle="tab" id="tab1" >我的草稿</a></li>
	<li><a rel="iframe2" href="#myStarted" data-toggle="tab" id="tab2" >我的申请</a></li>
	<li><a rel="iframe3" href="#myDone" data-toggle="tab" id="tab3" >我的经办</a></li>	
</ul>
<div id="myTabContent" class="tab-content" style="width:100%;height:100%; border: 0;">
	<div class="tab-pane fade in active" id=myDraft style="width:100%;height:100%; border: 0;">
	</div>
	<div class="tab-pane fade" id="myStarted" style="width:100%;height:100%; border: 0;">
		<iframe id="iframe2" name="iframe2" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
	</div>
	<div class="tab-pane fade" id="myDone" style="width:100%;height:100%; border: 0;">
		<iframe id="iframe3" name="iframe3" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
	</div>
</div>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript">
var nodeId = <%=nodeId%>;
var nodeType = <%=nodeType%>;
var pdId = <%=pdId%>;
var subtractHeight= 35;
$(function(){
	$("#myTabContent").css('height',$(document).innerHeight() -subtractHeight);
	//$("#myTabContent").css('height',document.documentElement.clientHeight -41);
	
	
	setTimeout(function(){
		var url = "avicit/platform6/bpmreform/bpmprocess/myDraft.jsp?nodeId="+nodeId+"&nodeType="+nodeType+"&pdId="+pdId;
		$('<iframe id="iframe1" name="iframe1" src="'+url+'"  scrolling="no" frameborder="0" style="width: 100%;height: 100%; border: 0;"></iframe>').appendTo($('#myDraft'));
	},10);
	var url1 = 'avicit/platform6/bpmreform/bpmprocess/myDraft.jsp?nodeId='+nodeId+'&nodeType='+nodeType+'&pdId='+pdId;
	var url2 = 'avicit/platform6/bpmreform/bpmprocess/myStartedProcess.jsp?nodeId='+nodeId+'&nodeType='+nodeType+'&pdId='+pdId;
	var url3 = 'avicit/platform6/bpmreform/bpmprocess/myDoneProcess.jsp?nodeId='+nodeId+'&nodeType='+nodeType+'&pdId='+pdId;
	var ifrm={'iframe1':url1,
			  'iframe2':url2,
			  'iframe3':url3
			  };

	  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	  	if(!$('#'+e.target.rel).attr('src')){
	  		$('#'+e.target.rel).attr('src',ifrm[e.target.rel]);
	  	}else{
		  	if(window.frames[e.target.rel].bpm_operator_refresh){
		  		window.frames[e.target.rel].bpm_operator_refresh();
			 }
		}
	  });
	  $.ajax({
			url : 'platform/bpm/process/initHistProcessByPage?nodeId='+nodeId+'&nodeType='+nodeType+'&pdId='+pdId,
			data : {
			},
			type : "POST",
			dataType : "JSON",
			success : function(result) {
				if(result.startCount!=undefined && result.startCount!=null){
					var tabName = '我的申请'+'(<span style="color:red">'+result.startCount+'</span>)';
					$('#tab2').html(tabName);
				}
				if(result.doneCount!=undefined && result.doneCount!=null){
					var tabName = '我的经办'+'(<span style="color:red">'+result.doneCount+'</span>)';
					$('#tab3').html(tabName);
				}
			}
		});
})



$(window).resize(function(){
	$("#myTabContent").css('height',$(document).innerHeight() -subtractHeight);
});

</script>
</html>