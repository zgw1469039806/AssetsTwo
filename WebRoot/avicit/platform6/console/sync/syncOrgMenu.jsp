<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%
    String importlibs = "common,form,table";
%>
<html>
<head>
    <title>多组织菜单同步</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='addForm' style="height: 90%;">
        <table class="form_commonTable" >
            <tr>
                <th width="100px" style="word-break: break-all; word-warp: break-word;">
                    <label>源组织：</label>
                </th>
                <td  width="100px">
                    <select class="form-control input-sm" id="orgIdFrom">
                        ${orgListFrom}
                    </select>
                </td>

                <th width="100px" style="word-break: break-all; word-warp: break-word;">
                    <label>目标组织：</label>
                </th>
                <td  width="100px">
                    <select class="form-control input-sm" id="orgIdTo">
                        ${orgListTo}
                    </select>
                </td>

                <th width="100px" rowspan="3" style="word-break: break-all; word-warp: break-word;padding-top: 10px;" valign="top">
                    <label>操作日志：</label>
                </th>
                <td rowspan="3"  valign="top">
                    <div id="syncLog">
                    </div>
                </td>
            </tr>

            <tr>
                <th style="word-break: break-all; word-warp: break-word;">
                    <label>菜单类型：</label>
                </th>
                <td colspan="3">
                    <select class="form-control input-sm" id="menuType">
                        <option value="menu">前台菜单</option>
                        <option value="menuPortlet">门户小页</option>
                        <option value="sysThemesSkinsPortlet">门户首页配置</option>
                    </select>
                </td>
            </tr>

            <tr>
                <th  style="word-break: break-all; word-warp: break-word;">
                    <label>源组织菜单：</label>
                </th>
                <td >
                    <div id="orgFromMenu">
                    </div>
                </td>

                <th  style="word-break: break-all; word-warp: break-word;">
                    <label>目标组织菜单：</label>
                </th>
                <td >
                    <div id="orgToMenu">
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
                       class="btn btn-primary form-tool-btn  btn-sm btn-point" role="button" title="保存" id="doSyncOrgMenu">开始同步</a>
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
   var treeWidth = ($(".form_commonTable").width() -350)/3;
    $("#orgFromMenu").css("height", $(window).height() - 160);
    $("#orgFromMenu").css("width", treeWidth);
    $("#orgFromMenu").css("overflow", "auto");
    $("#orgFromMenu").css("border", "1px solid #d3d3d3");

    $("#orgToMenu").css("height", $(window).height() - 175);
    $("#orgToMenu").css("width", treeWidth);
    $("#orgToMenu").css("overflow", "auto");
    $("#orgToMenu").css("border", "1px solid #d3d3d3");

    $("#syncLog").css("height", $(window).height() - 85);
    $("#syncLog").css("width", treeWidth);
    $("#syncLog").css("overflow", "auto");
    $("#syncLog").css("border", "1px solid #d3d3d3");

    function fmtStatus(cellvalue) {
        if (cellvalue == 0) {
            return '禁用';
        }
        else if (cellvalue == 1) {
            return '启用';
        } else {
            return "";
        }
    }
    function isDefaultFormatter(cellvalue) {
        if (cellvalue == "1") {
            return "是";
        } else {
            return "否";
        }
    }

    function typeFormatter(cellvalue) {
        if (cellvalue == "0") {
            return "系统默认";
        } else if (cellvalue == "1") {
            return "角色定义";
        } else if (cellvalue == "2") {
            return "用户自定义";
        } else {
            return "";
        }
    }

    var orgFromMenu;
    var orgToMenu;

    function drawMenuArea(fromOrTo) {
        var orgIdFrom = $("#orgIdFrom").val();
        var orgIdTo = $("#orgIdTo").val();
        var menuType = $("#menuType").val();

        //源菜单
        if (fromOrTo == 'from') {
            $("#orgFromMenu").empty();
            orgFromMenu = null;

            //前台菜单
            if (menuType == 'menu') {
                $("#orgFromMenu").append("<ul id='orgFromTree' class='ztree'></ul>");

                var settingorgFromMenu = {
                    async: {
                        enable: true,
                        url: "platform/syncController/orgMenuTree?menuType=" + menuType + "&orgId=" + orgIdFrom
                    },
                    data: {
                        simpleData: {
                            enable: true,
                            idKey: "id",
                            pIdkey: "pId"
                        }
                    },
                    check: {
                        enable: true,
                        chkStyle: "checkbox",
                        chkboxType: {"Y": "ps", "N": "s"}//勾选操作，影响父级、子级节点；取消勾选操作，只影响子级节点
                    }
                };
                orgFromMenu = $.fn.zTree.init($("#orgFromMenu").find("ul.ztree"), settingorgFromMenu);
            }
            //门户小页、门户首页配置
            else {
                $("#orgFromMenu").append("<table id='orgFromTable'></table>");

                var colModel;
                if (menuType == 'menuPortlet') {
                    colModel = [{
                        key: true,
                        label: 'id',
                        name: 'id',
                        width: 75,
                        hidden: true
                    }, {
                        label: '小页名称',
                        name: 'menuName',
                        width: 80
                    }, {
                        label: '小页状态',
                        name: 'menuStatus',
                        width: 50,
                        formatter: fmtStatus
                    }];
                }
                if (menuType == 'sysThemesSkinsPortlet') {
                    colModel = [{
                        key: true,
                        label: 'id',
                        name: 'id',
                        width: 75,
                        hidden: true
                    }, {
                        label: '布局名称',
                        name: 'portletName',
                        width: 80
                    }, {
                        label: '是否默认',
                        name: 'isDefault',
                        width: 50,
                        formatter: isDefaultFormatter
                    }, {
                        label: '类型',
                        name: 'resourceType',
                        width: 60,
                        formatter: typeFormatter
                    }];
                }

                orgFromMenu = $("#orgFromMenu").find("table").jqGrid({
                    url: 'platform/syncController/orgMenuList',
                    mtype: 'POST',
                    datatype: "json",
                    postData: {
                        menuType: menuType,
                        orgId: orgIdFrom
                    },
                    colModel: colModel,
                    height: $(window).height() - 201,
                    scrollOffset: 20,
                    rowNum : 10000,
                    altRows: true,
                    styleUI: 'Bootstrap',
                    viewrecords: true,
                    multiselect: true,
                    autowidth: true,
                    hasColSet: false,
                    hasTabExport: false,
                    responsive: true
                });
            }
        }
        //目标菜单
        else {
            $("#orgToMenu").empty();
            orgToMenu = null;

            //前台菜单
            if (menuType == 'menu') {
                $("#orgToMenu").append("<ul id='orgToTree' class='ztree'></ul>");

                var settingorgToMenu = {
                    async: {
                        enable: true,
                        url: "platform/syncController/orgMenuTree?menuType=" + menuType + "&orgId=" + orgIdTo
                    },
                    data: {
                        simpleData: {
                            enable: true,
                            idKey: "id",
                            pIdkey: "pId"
                        }
                    }
                };
                orgToMenu = $.fn.zTree.init($("#orgToMenu").find("ul.ztree"), settingorgToMenu);
            }
            //门户小页、门户首页配置
            else {
                $("#orgToMenu").append("<table id='orgToTable'></table>");

                var colModel;
                if (menuType == 'menuPortlet') {
                    colModel = [{
                        key: true,
                        label: 'id',
                        name: 'id',
                        width: 75,
                        hidden: true
                    }, {
                        label: '小页名称',
                        name: 'menuName',
                        width: 80
                    }, {
                        label: '小页状态',
                        name: 'menuStatus',
                        width: 50,
                        formatter: fmtStatus
                    }];
                }
                if (menuType == 'sysThemesSkinsPortlet') {
                    colModel = [{
                        key: true,
                        label: 'id',
                        name: 'id',
                        width: 75,
                        hidden: true
                    }, {
                        label: '布局名称',
                        name: 'portletName',
                        width: 80
                    }, {
                        label: '是否默认',
                        name: 'isDefault',
                        width: 50,
                        formatter: isDefaultFormatter
                    }, {
                        label: '类型',
                        name: 'resourceType',
                        width: 60,
                        formatter: typeFormatter
                    }];
                }

                orgToMenu = $("#orgToMenu").find("table").jqGrid({
                    url: 'platform/syncController/orgMenuList',
                    mtype: 'POST',
                    datatype: "json",
                    postData: {
                        menuType: menuType,
                        orgId: orgIdTo
                    },
                    colModel: colModel,
                    height: $(window).height() - 210,
                    scrollOffset: 20,
                    rowNum : 10000,
                    altRows: true,
                    styleUI: 'Bootstrap',
                    viewrecords: true,
                    multiselect: false,
                    autowidth: true,
                    hasColSet: false,
                    hasTabExport: false,
                    responsive: true
                });
            }
        }
    }

    $("#orgIdFrom").change(function () {
        drawMenuArea('from');
    });
    $("#orgIdTo").change(function () {
        drawMenuArea('to');
    });
    $("#menuType").change(function () {
        drawMenuArea('from');
        drawMenuArea('to');
    });
    drawMenuArea('from');
    drawMenuArea('to');

    function getSyncData() {
        var orgIdFrom = $("#orgIdFrom").val();
        var orgIdTo = $("#orgIdTo").val();
        var menuType = $("#menuType").val();

        var menuIdArray = [];
        //前台菜单
        if (menuType == 'menu') {
            var checkedNodes = orgFromMenu.getCheckedNodes(true);
            for (var i = 0; i < checkedNodes.length; i++) {
                menuIdArray.push(checkedNodes[i].id);
            }
        }
        //门户小页、门户首页配置
        else {
            var rows = orgFromMenu.jqGrid('getGridParam', 'selarrrow');
            var i = rows.length;
            for (; i--;) {
                menuIdArray.push(rows[i]);
            }
        }

        var data = {
            orgIdFrom: orgIdFrom,
            orgIdTo: orgIdTo,
            menuType: menuType,
            menuIds: menuIdArray.join(",")
        };

        return data;
    }

    $("#doSyncOrgMenu").click(function () {
        var syncData = getSyncData();
        var orgIdFrom = syncData.orgIdFrom;
        var orgIdTo = syncData.orgIdTo;
        var menuType = syncData.menuType;
        var menuIds = syncData.menuIds;

        if (orgIdFrom == orgIdTo) {
            layer.msg('同步组织不能相同！', {icon: 7});
        }
        else if (menuIds == '' || menuIds == null) {
            layer.msg('请选择需要同步的菜单！', {icon: 7});
        } else {
            $.ajax({
                url: 'platform/syncController/doSyncOrgMenu',
                data: {
                    orgIdFrom: orgIdFrom,
                    orgIdTo: orgIdTo,
                    menuType: menuType,
                    menuIds: menuIds
                },
                type: 'post',
                dataType: 'json',
                success: function (result) {
                    if (result.success == true) {
                        $("#syncLog").empty();

                        var msg = result.msg;
                        msg = msg.replaceAll('\n', '<br>');
                        $("#syncLog").html(msg);

                        drawMenuArea('to');
                        layer.msg('操作成功！', {icon: 1});
                    } else {
                        layer.msg('操作失败！', {icon: 2});
                    }
                }
            });
        }
    });
</script>
</body>
</html>
