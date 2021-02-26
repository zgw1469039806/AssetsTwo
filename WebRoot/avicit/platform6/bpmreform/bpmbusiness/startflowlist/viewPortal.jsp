<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%--集中管控-流程发起--%>
    <title>流程发起</title>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'west',split:true,title:'应用列表',collapsible:false"
     style="height:0; overflow:hidden; font-size:0;width:170px;">
    <div id="tableToolbarM" class="toolbar">
        <div class="toolbar-left">
            <div class="input-group  input-group-sm">
                <input class="form-control" placeholder="输入名称查询" type="text" id="appSearchInput" name="txt">
                <span class="input-group-btn">
                    <button id="appSearch" class="btn btn-default" type="button">
                        <span class="glyphicon glyphicon-search"></span>
                    </button>
                </span>
            </div>
        </div>
    </div>
    <div id='mdiv' style="overflow:hidden;">
        <table id="jqGridApp"></table>
    </div>
</div>
<div id="center" data-options="region:'center',split:true">
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bs3centralcontrol/appliaction/js/AppList.js"></script>
<script type="text/javascript">
    $('#mdiv').height(document.documentElement.clientHeight - 38);
    var _map = {};
    $(function () {
        sysAppTree = new AppList('jqGridApp', '1', 'searchDialog', 'form', 'keyWord');
        sysAppTree.setOnSelect(function (appId) {
            $('.frame').css('display', 'none');
            if (!$('#' + appId + 'Frm').length) {
                var rowData = $('#jqGridApp').jqGrid('getRowData', appId);
                var url = rowData["attributes.url"];
                var src = url + "/bpm/business/processStartView?isSubApp=1";
                _map[appId] = src;
                var frame = $("<iframe id='" + appId + "Frm' class='frame' src=" + src + " scrolling='no' frameborder='0' style='width:100%;height:100%;'></iframe>");
                frame.appendTo($('#center'));
                return false;
            }
            $('#' + appId + 'Frm').css('display', 'block');

        });
    });
</script>
</body>
</html>
