<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>图形预览</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <script type="text/javascript" src="static/h5/echarts/dist/echarts.min.js"></script>
   <script type="text/javascript" src="static/h5/echarts/dist/echarts-gl.min.js"></script>
   <script type="text/javascript" src="static/h5/echarts/dist/ecStat.min.js"></script>
   <script type="text/javascript" src="static/h5/echarts/dist/dataTool.min.js"></script>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div id="container" style="height: 400px;"></div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>

<script type="text/javascript">

    var dom = document.getElementById("container");
    var myChart = echarts.init(dom);
    var app = {};
    var option =  ${option};

    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }

    $(window).resize(function() {
        for(var i = 0; i < charts.length; i++) {
            charts[i].resize();
        }
    });

    $(function(){
        $($("#container > div")[0]).css("width","100%");//设置图表所在div中的div宽度
        $($("#container > canvas")[0]).css("width", "100%");//设置图表的div宽度
        myChart.resize();

    });

</script>
</body>
</html>
