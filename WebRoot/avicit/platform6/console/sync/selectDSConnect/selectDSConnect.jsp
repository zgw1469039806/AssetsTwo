<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree";
%>

<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>选择数据源</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <%--<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>--%>
</head>

<body>
<div class="easyui-layout" fit=true>
    <div data-options="region:'center',split:true,border:false">
        <ul id="datasourceTreeUL" class="ztree">
        </ul>
    </div>

    <div data-options="region:'south',border:false" style="height: 40px;">
        <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableForm" style="border:0;cellspacing:1;width:100%">
                <tr>
                    <td width="80%" style="padding-right:4%;float:right;display:block;" align="right">
                        <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                           title="保存" id="table_saveForm">保存</a>
                        <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button"
                           title="返回" id="table_closeForm">返回</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script type="text/javascript">
    var selectedNode = null;
    var setting = {
        async: {
            enable: true,
            url: "platform/syncController/getDSConnectTree",//异步请求树子节点url
            autoParam: ["id"]//父节点id
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdkey: "pId"
            }
        },
        callback: {
            //节点点击事件
            onClick: function (event, treeId, treeNode) {
                if (treeNode.type == "node") {
                    selectedNode = treeNode;
                }
            }
        }
    };
    var datasourceTree = $.fn.zTree.init($("#datasourceTreeUL"), setting);

    $('#table_saveForm').bind('click', function () {
        if (selectedNode == null) {
            layer.alert('请选择数据源！', {icon: 7});
            return;
        }

        parent.$("#${param.fieldId}").val(selectedNode.id);
        parent.$("#${param.fieldName}").val(selectedNode.name);

        var dataObject = parent.$("#${param.fieldId}").data("data-object");
        if (dataObject != undefined && dataObject != null) {
            var data = {
                id: selectedNode.id,
                name: selectedNode.name
            };
            dataObject.postFunction(data);
        }

        var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
        parent.layer.close(index);
    });
    $('#table_closeForm').bind('click', function () {
        var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
        parent.layer.close(index);
    });
</script>
</body>
</html>