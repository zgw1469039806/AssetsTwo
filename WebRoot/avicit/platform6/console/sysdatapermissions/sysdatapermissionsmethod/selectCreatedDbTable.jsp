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
</head>

<body>
<div class="easyui-layout" fit=true >
    <div class="row" style="margin: 3px;height:300px;">
        <%-- 树搜索 --%>
        <input type="hidden" id="searchStatus" value="0"><%-- 搜索状态：0未搜索、1已搜索 --%>
        <div class="input-group  input-group-sm">
            <input class="form-control" placeholder="请输入表模型名称" type="text" id="searchTreeInput">
            <span class="input-group-btn">
                <button id="searchTreeBtn" class="btn btn-default" type="button">
                    <span class="glyphicon glyphicon-search"></span>
                </button>
		    </span>
        </div>
        <!-- 数据模型分类树 -->
        <ul id="dbTableTypeTreeUL" class="ztree" style="height: 90%; overflow-y: scroll;">
        </ul>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script type="text/javascript">
   	var rootId = "-1";
    var eformTypeTree;
    var setting = {
        async: {
            enable: true,
            url: "platform/db/dbTableManageController/getCreatedDbTableByDbTableType",//异步请求树子节点url
            autoParam: ["id"],//父节点id
            otherParam: {
                "rootId": rootId
            }
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
                if(treeNode.type == "form") {
                    parent.$("#tableName").val(treeNode.tablename);
                    parent.$("#tableRemarks").val(treeNode.name);

					var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
                    parent.layer.close(index);
                }
            }
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: "platform/db/dbTableManageController/getCreatedDbTableByDbTableType",
        data: {
            id: rootId,
            rootId: rootId
        },
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
    	var placeholder = $("#searchTreeInput").attr("placeholder");
    	var keyWord = "";
    	if (placeholder != $("#searchTreeInput").val()){
    		keyWord = $("#searchTreeInput").val();
    	}
        searchDbTableTree(keyWord);
    });

    //搜索分类树
    function searchDbTableTree(searchParm) {
        $.ajax({
            url: "platform/db/dbTableManageController/getCreatedDbTableBySearch",
            data: {
                searchParm: searchParm,
                rootId: rootId
            },
            type: "post",
            dataType: "json",
            success: function (backData) {
                $("#searchStatus").val("1");

                var zNodes = backData;
                if(zNodes.length != 0) {
                    eformTypeTree = $.fn.zTree.init($("#dbTableTypeTreeUL"), setting, zNodes);
                }
                else {
                    eformTypeTree.destroy();
                }
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