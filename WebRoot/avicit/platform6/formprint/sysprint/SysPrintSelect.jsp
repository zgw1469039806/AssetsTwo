<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "sysprint/sysPrintController/toSysPrintManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>

<table id="sysPrintjqGrid"></table>
<%--<div id="jqGridPager"></div>--%>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">


    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '模板编号', name: 'printTempCode', width: 150}
            , {label: '模板名称', name: 'printTempName', width: 150}
        ];

        $("#sysPrintjqGrid").jqGrid({
            url: '${url}'+'getSysPrints.json',
            postData:{resourceId: '${resourceId}'},
            mtype: 'POST',
            datatype: "json",
            toolbar: [true,'top'],
            colModel: dataGridColModel,
            height:$(window).height()-120,
            scrollOffset: 20, //设置垂直滚动条宽度
            loadonce:true,
            altRows:true,
            pagerpos:'left',
            styleUI : 'Bootstrap',
            viewrecords: true,
            multiselect: false,
            autowidth: true,
            shrinkToFit: true,
            responsive:true,//开启自适应

        });

    });

</script>
</html>