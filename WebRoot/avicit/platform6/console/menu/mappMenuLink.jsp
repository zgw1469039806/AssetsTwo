<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%
    String importlibs = "common";
%>
<html>
<head>
    <title>多应用菜单引用</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='saveForm' style="height: 90%;">
        <table class="form_commonTable">
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label>多应用：</label>
                </th>
                <td width="85%">
                    <select id="applicationList">
                        <c:forEach items="${applicationList}" var="app">
                            <option value="${app.id}">${app.applicationName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label>前台菜单：</label>
                </th>
                <td width="85%">
                    <div id="portalMenu">
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>

<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
                    <a href="javascript:void(0)" style="margin-right:10px;"
                       class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="doMenuLink">保存</a>
                    <a href="javascript:void(0)" style="margin-right:10px;"
                        class="btn btn-grey form-tool-btn typeb btn-sm" role="button" title="返回" id="cancel">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<%-- ztree --%>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeviewmin.css"/>
<script type="text/javascript" src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
    $("#portalMenu").css("height", $(window).height() - 120);
    $("#portalMenu").css("overflow", "auto");
    $("#portalMenu").css("border", "1px solid #d3d3d3");
        
    var portalMenu = null;
    var selectNode = null;

    function drawPortalMenuArea(appId) {
        $("#portalMenu").empty();
        portalMenu = null;
        selectNode = null;

        $("#portalMenu").append("<ul id='portalMenuTree' class='ztree'></ul>");

        var settingPortalMenu = {
            async: {
                enable: true,
                url: "platform/console/menu/appPortalMenuTree?appId=" + appId
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdkey: "pId"
                }
            },
            callback: {
                onClick: function (event, treeId, treeNode){
                    selectNode = treeNode;
                }
            }
        };
        portalMenu = $.fn.zTree.init($("#portalMenu").find("ul.ztree"), settingPortalMenu);
    }

    $("#applicationList").change(function () {
        drawPortalMenuArea(this.value);
    });
    drawPortalMenuArea($("#applicationList").val());

    $("#doMenuLink").click(function () {
        if(selectNode == null) {
            layer.msg('请选择需要引用的菜单！', {icon: 7});
        }
        else if(selectNode.pId == null) {
            layer.msg('不能选择根菜单！', {icon: 7});
        }
        else {
            layer.confirm('确认要引用该菜单及其子菜单吗？', {icon: 3, title: '提示'}, function (index) {
                $.ajax({
                    url: 'platform/console/menu/doMenuLink',
                    data: {
                        toMenuId: '${toMenuId}',
                        linkMenuId: selectNode.id
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (result) {
                        if (result.success == true) {
                            parent.layer.msg('操作成功！', {icon: 1});

                            //刷新后台缓存
                            parent.$.ajax({
                                url: 'platform/cache/RefreshCacheController/refresh?type=menu',
                                type: 'post',
                                dataType: 'json',
                                success: function (back) {
                                    if (back.success == "true") {
                                    }
                                }
                            });

                            //刷新树节点
                            var pNode = parent.menuTree.tree.getNodeByParam('id', '${toMenuId}', null);
                            if (!pNode.isParent)
                                pNode.isParent = 'true';
                            parent.menuTree.tree.reAsyncChildNodes(pNode, 'refresh');

                            //刷新表格
                            //parent.menuList._$grid.trigger('reloadGrid');
                            parent.$("#"+pNode.tId+"_a").click();

                            var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
                            parent.layer.close(index);
                        } else {
                            parent.layer.msg('操作失败！', {icon: 2});
                        }
                    }
                });

                layer.close(index);
            });
        }
    });

    $("#cancel").click(function () {
        var index = parent.layer.getFrameIndex(window.name); //得到当前iframe层的索引
        parent.layer.close(index);
    });
</script>
</body>
</html>
