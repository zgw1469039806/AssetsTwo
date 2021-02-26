<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table";
    String userId = request.getParameter("userId");
%>
<!DOCTYPE html>
<html>

<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>移交待办</title>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style>
        body {
            padding: 24px;
        }

        #task {
            display: none;
        }

        #processDef {
            display: none;
        }
    </style>
</head>

<body class="container-fluid">
<div class="row">
    <div class="col-xs-12">
        <label class="radio-inline">
            <input type="radio" name="workHandType" value="all" checked> 全部移交
        </label>
        <label class="radio-inline">
            <input type="radio" name="workHandType" value="task"> 按待办移交
        </label>
        <%--<label class="radio-inline">
            <input type="radio" name="workHandType" value="processDef"> 按流程移交
        </label>--%>
    </div>
</div>
<div class="row" id="task">
    <div class="col-xs-12">
        <div class="toolbar form-inline">
            <div class="toolbar-left form-group">
                <label for="flowName">流程模板：</label>
                <div class="input-group">
                    <input type="text" id="flowName" class="form-control" placeholder="请选择流程模板" style="width: 200px;"/>
                    <input type="hidden" id="flowId">
                    <span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
                </div>
            </div>
        </div>
        <table id="workHandTaskList"></table>
        <div id="workHandTaskPager"></div>
    </div>
</div>
<div class="row" id="processDef">
    <div class="col-xs-12">
        按流程移交
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js" type="text/javascript"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/workhand/js/BpmModuleSelect.js" type="text/javascript"></script>
<script src="avicit/platform6/console/user/js/WorkHandTaskList.js" type="text/javascript"></script>
<script type="text/javascript">
    var workHandTaskList;
    $(function () {
        $("input[name='workHandType']").on("click", function () {
            var workHandType = $("input[name='workHandType']:checked").val();
            if (workHandType == "task") {
                $("#processDef").hide();
                $("#task").show();
                $(window).resize();
            } else if (workHandType == "processDef") {
                $("#task").hide();
                $("#processDef").show();
                $(window).resize();
            } else {
                $("#task").hide();
                $("#processDef").hide();
            }
        });

        workHandTaskList = new WorkHandTaskList('#workHandTaskList', '#workHandTaskPager', '<%=userId%>');

        new BpmModuleSelect("flowId", "flowName", function (data) {
            if (data.ids && data.ids.indexOf(",") != -1) {
                layer.msg("只允许选择一条流程模板");
                return;
            }
            $("#flowId").val(data.ids);
            $("#flowName").val(data.texts);
            workHandTaskList.reLoad();
        }, undefined, $("#flowId"), $("#flowName"));
    });

    function getWorkHandData() {
        var workHandType = $("input[name='workHandType']:checked").val();
        var workHandData = [];
        if (workHandType == "task") {
            workHandData = workHandTaskList.getSelected();
            if (workHandData.length == 0) {
                layer.msg("请先选择数据");
                return false;
            }
        } else if (workHandType == "processDef") {
            if (workHandData.length == 0) {
                layer.msg("请先选择数据");
                return false;
            }
        }
        return {
            workHandType: workHandType,
            workHandData: workHandData.join(",")
        };
    }
</script>
</body>

</html>
