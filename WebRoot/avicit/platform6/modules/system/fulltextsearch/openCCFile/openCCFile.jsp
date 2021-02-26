<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree";
%>

<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>选择已经创建的表</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <%--<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>--%>
</head>

<body>
<div class="easyui-layout" fit=true>
    <div class="row" style="margin: 3px;">
        <%-- 树搜索 ------- 后续完善--%>

        <!-- 数据模型分类树 -->
        <ul id="dbTableTypeTreeUL" class="ztree" style="height: 90%; overflow-y: scroll;">
        </ul>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script type="text/javascript">
    var eformTypeTree;

    var setting = {
        async: {
            enable: true,
            url: "platform/connectcenter/connectCenterController/getOutConnectTree",//异步请求树子节点url
            autoParam: ["id"]//父节点id
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdkey: "pId"
            }
        },
        view: {
            fontCss: setFontCssBySearch
        },
        callback: {
            //节点点击事件
            onClick: function (event, treeId, treeNode) {
                if(treeNode.isDatabase == "true") { 
                    parent.$("#${param.formId}").val(treeNode.id);
                    parent.$("#${param.formName}").val(treeNode.name);
                    parent.layer.close(parent.openCCFile.selectDialog);
                }
            }
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: "platform/connectcenter/connectCenterController/getOutConnectTree",
        data: "id=-1",
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var zNodes = backData;
            eformTypeTree = $.fn.zTree.init($("#dbTableTypeTreeUL"), setting, zNodes);
        }
    });
    //绑定搜索事件
    $("#searchTreeInput").on('keyup',function(e){
        if(e.keyCode == 13){
            searchDbTableTree($("#searchTreeInput").val());
        }
    });
    $("#searchTreeBtn").click(function () {
        searchDbTableTree($("#searchTreeInput").val());
    });

    //搜索分类树
    function searchDbTableTree(searchParm) {
        $.ajax({
            url: "platform/db/dbTableManageController/getCreatedDbTableBySearch",
            data: "searchParm=" + searchParm,
            type: "post",
            dataType: "json",
            success: function (backData) {
                $("#searchStatus").val("1");

                var zNodes = backData;
                eformTypeTree = $.fn.zTree.init($("#dbTableTypeTreeUL"), setting, zNodes);
            }
        });
    }

    function setFontCssBySearch(treeId, treeNode) {
        if ($("#searchStatus").val() == "1" && treeNode.type == "form") {
            return {color:"red"};
        }
    }
</script>
</body>
</html>