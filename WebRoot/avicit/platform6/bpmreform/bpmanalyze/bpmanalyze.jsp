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
    <title>流程分析</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>
</head>
<body>
<ul id="myTab" class="nav nav-tabs" style="width: 100%;height:100%;">
    <li class="active"><a rel='portal_ifrm' href="#portal" data-toggle="tab">统计排名</a></li>
    <li><a rel='console_ifrm' href="#console" data-toggle="tab">效率看板</a></li>
</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="portal">
    </div>
    <div class="tab-pane fade" id="console">
        <iframe id="console_ifrm" src="" scrolling="no" frameborder="0" src="" style="width:100%;height:100%;"></iframe>
    </div>

</div>
</body>
<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<script type="text/javascript">

    $('#console').css("height",document.documentElement.clientHeight-50);
    $('#portal').css("height",document.documentElement.clientHeight-50);


    setTimeout(function(){
        $('<iframe id="portal_ifrm" src="avicit/platform6/bpmreform/bpmanalyze/bpmRankingStatistics.jsp" scrolling="no" frameborder="0" style="width:100%;height:100%;"></iframe>').appendTo($('#portal'));
    },10);

    var ifrm={'console_ifrm':'avicit/platform6/bpmreform/bpmanalyze/bpmEffectiveboard.jsp'};

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        if(!$('#'+e.target.rel).attr('src')){
            $('#'+e.target.rel).attr('src',ifrm[e.target.rel]);
        }
    });

    $(window).resize(function(){
        $('#console').css("height",document.documentElement.clientHeight-50);
        $('#portal').css("height",document.documentElement.clientHeight-50);
    });
</script>
</html>