<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<!DOCTYPE html>
<%
    String importlibs = "common,tree";
%>

<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>选择已发布流程电子表单</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <%--<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>--%>
</head>

<body>
<div class="easyui-layout" fit=true>
    <div class="row" style="margin: 3px;">
        <%-- 树搜索 --%>
        <input type="hidden" id="searchStatus" value="0"><%-- 搜索状态：0未搜索、1已搜索 --%>
        <div class="input-group  input-group-sm">
            <input class="form-control" placeholder="回车查询" type="text" id="searchTreeInput">
            <span class="input-group-btn">
                <button id="searchTreeBtn" class="btn btn-default" type="button">
                    <span class="glyphicon glyphicon-search"></span>
                </button>
		    </span>
        </div>

        <!-- 电子表单分类树 -->
        <ul id="eformTypeTreeUL" class="ztree" style="height: 275px; overflow-y: auto;">
        </ul>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script type="text/javascript">
    var eformTypeTree;
    var formtype = "${param.formsType}";
    var url;
    if (formtype === "view"){
        url = "platform/eform/bpmsManageController/getPublishViewByEformType";
    }else{
        url = "platform/eform/bpmsManageController/getPublishEformByEformType";
    }
    var setting = {
        async: {
            enable: true,
            url: url+"?isBpm=${param.isBpm}&formsType=${param.formsType}",//异步请求树子节点url
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
                if (treeNode.type == "form") {
                    var dataObject;

                    if ("${param.parentAreaId}" == "null" || "${param.parentAreaId}" == "") {
                        parent.$("#${param.fieldId}").val(treeNode.id);
                        parent.$("#${param.fieldName}").val(treeNode.name);

                        dataObject = parent.$("#${param.fieldId}").data("data-object");
                    }
                    else {
                        parent.$("#${param.parentAreaId}").find("#${param.fieldId}").val(treeNode.id);
                        parent.$("#${param.parentAreaId}").find("#${param.fieldName}").val(treeNode.name);

                        dataObject =  parent.$("#${param.parentAreaId}").find("#${param.fieldId}").data("data-object");
                    }

                    if (dataObject != undefined && dataObject != null) {
                        var data = {
                            id: treeNode.id,
                            name : treeNode.name,
                            treeNode : treeNode
                        }
                        dataObject.postFunction(data);
                    }

                    var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
                    parent.layer.close(index);
                }
            }
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: url,
        data: "id=-1&isBpm=${param.isBpm}&formsType=${param.formsType}",
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var zNodes = backData;
            eformTypeTree = $.fn.zTree.init($("#eformTypeTreeUL"), setting, zNodes);
        }
    });

    //绑定搜索事件
    $("#searchTreeInput").on('keyup',function(e){
        if(e.keyCode == 13){
            searchEformTypeTree($("#searchTreeInput").val());
        }
    });
    $("#searchTreeBtn").click(function () {
        searchEformTypeTree($("#searchTreeInput").val());
    });

    //搜索分类树
    function searchEformTypeTree(searchParm) {

        if (searchParm != null && searchParm != undefined && searchParm!=""){

            var searchurl = "platform/eform/bpmsManageController/getPublishEformTreeBySearch";
            if (formtype === "view"){
                searchurl = "platform/eform/bpmsManageController/getPublishViewTreeBySearch";
            }
            $.ajax({
                url: searchurl,
                data: "isBpm=${param.isBpm}&formsType=${param.formsType}&searchParm=" + searchParm,
                type: "post",
                dataType: "json",
                success: function (backData) {
                    $("#searchStatus").val("1");

                    var zNodes = backData;
                    eformTypeTree = $.fn.zTree.init($("#eformTypeTreeUL"), setting, zNodes);
                }
            });
        }else{
            $.ajax({
                url: url,
                data: "id=-1&isBpm=${param.isBpm}&formsType=${param.formsType}",
                type: "post",
                async: false,
                dataType: "json",
                success: function (backData) {
                    var zNodes = backData;
                    eformTypeTree = $.fn.zTree.init($("#eformTypeTreeUL"), setting, zNodes);
                }
            });
        }
    }

    function setFontCssBySearch(treeId, treeNode) {
        if ($("#searchStatus").val() == "1" && treeNode.type == "form") {
            return {color:"red"};
        }
    }
</script>
</body>
</html>