<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
    String importlibs = "common";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<ul id="myTab" class="nav nav-tabs" style="width:100%;">
	<li class="active"><a rel="iframe1" href="#baseinfo" data-toggle="tab" id="tab1" >
		基本信息</a></li>
	<li><a rel="iframe2" href="#index" data-toggle="tab" id="tab2" >索引</a></li>
	<li><a rel="iframe3" href="#event" data-toggle="tab" id="tab3" >事件</a></li>
</ul>
<div id="myTabContent" class="tab-content" style="width:100%;height:100%; border: 0;">
	<div class="tab-pane fade in active" id="baseinfo" style="width:100%;height:100%; border: 0;overflow:hidden;">

	</div>
	<div class="tab-pane fade" id="index" style="width:100%;height:100%; border: 0;overflow:hidden;">
		<iframe id="iframe2" name="iframe2" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
	</div>
	<div class="tab-pane fade" id="event" style="width:100%;height:100%; border: 0;overflow:hidden;">
		<iframe id="iframe3" name="iframe3" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
	</div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>

<script type="text/javascript">
    document.ready = function () {
    	$("#myTabContent").css('height',$(document).innerHeight() -41);
    	var url = "platform/FulltextSearchInfoController/operation/edit/"+"${param.rowId}";
    	setTimeout(function(){
    		$('<iframe id="iframe1" name="iframe1" src='+url+' frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>').appendTo($('#baseinfo'));
    	},10);
    	
    	 var ifrm={'iframe1':url,
    			  'iframe2':'avicit/platform6/modules/system/fulltextsearch/searchConfig/indexConfig.jsp?infoId='+"${param.rowId}",
    			  'iframe3':'avicit/platform6/modules/system/fulltextsearch/searchConfig/searchEvent.jsp?infoId='+"${param.rowId}"};

    	  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    	  		$('#'+e.target.rel).attr('src',ifrm[e.target.rel]);
    	  }); 
    };
    
    $(window).resize(function(){
    	$("#myTabContent").css('height',$(document).innerHeight() -41);
    });
    
</script>
</body>
</html>
