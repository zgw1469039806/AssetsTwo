<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree,table";
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
<style>
	#t_nodeDetail{
		display:none;
	}
</style>
<body>
<div class="easyui-layout" fit=true>
    <div class="row" data-options="region:'west',split:true" style="width:240px;">
        <%-- 树搜索 ------- 后续完善--%>

        <!-- 数据模型分类树 -->
        <ul id="dbTableTypeTreeUL" class="ztree" >
        </ul>
    </div>
    <div data-options="region:'center'" style="width:81%">
    	<table id="nodeDetail"></table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/modules/system/fulltextsearch/js/NodeDetail.js" type="text/javascript"></script>
<script type="text/javascript">
    var eformTypeTree;
    var nodeDetail;
    var isRead;

    var setting = {
        async: {
            enable: true,
            url: "FulltextSearchInfoController/operation/openRemoteFile",//异步请求树子节点url
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
            	if(treeNode.canRead==true){
            		isRead = "可读";
            	}else{
            		isRead = "不可读";
            	}
            	if(nodeDetail==null || nodeDetail==undefined){
                	var searchNames = new Array();
                	nodeDetail = new NodeDetail('nodeDetail', "platform/FulltextSearchInfoController/operation/", "", "", "", searchNames,treeNode.length,treeNode.canRead);
                	nodeDetail.insert(treeNode.length+"KB",isRead);
            	}else{
            		nodeDetail.insert(treeNode.length+"KB",isRead);
                }
            },
	        //节点双击事件
	        onDblClick: function (event, treeId, treeNode) {
	            if(treeNode.isDirectory == "true") { 
	                parent.$("#${param.formId}").val(treeNode.id);
	                parent.layer.close(parent.openRemoteFile.selectDialog);
	            }
	        }
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: "FulltextSearchInfoController/operation/openRemoteFile",
        data: "id=root",
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