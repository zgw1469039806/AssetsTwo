<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,tree,form";
%>
<!DOCTYPE html>
<html>
<head>
    <title>用户选择</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css"
          href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeviewmin-fixie8.css"/>
    <link rel="stylesheet" type="text/css" href="avicit/platform6/h5component/common/commonselect.css"/>
    <style type="text/css">
        .checkbox-title-multi {
            padding-left: 4px;
            vertical-align: middle;
        }
    </style>
</HEAD>
<BODY class=" easyui-layout" fit="true">
<div data-options="region:'north'" style="height:40px;margin-right: 5px;overflow-y: hidden;">
    <div class="row" style="margin-right: 5px;">
        <div class="col-xs-6">
            <ul class="nav nav-pills" role="tablist">
                <li id="dept" role="presentation" class="active"><a href="javascript:void(0)"
                                                                    onclick="TabActiveClick('dept');">部门</a></li>
                <li id="group" role="presentation"><a href="javascript:void(0)"
                                                      onclick="TabActiveClick('group');">群组</a></li>
                <li id="role" role="presentation"><a href="javascript:void(0)" onclick="TabActiveClick('role');">角色</a>
                </li>
                <li id="position" role="presentation"><a href="javascript:void(0)"
                                                         onclick="TabActiveClick('position');">岗位</a></li>
            </ul>
        </div>
        <div class="col-xs-6">
            <table style="width:160px;margin-top:10px;float:right;">
                <tr>
                    <td class="isShowVoid" style="text-align:right;">
                        <input id="viewSystemUser" class="toolbox" type="checkbox"/>
                    </td>
                    <td class="isShowVoid" style="width: 90px;">
                        &nbsp;显示无效用户
                    </td>
                    <td style="text-align:right;">
                        <input id="viewType" class="toolbox" type="checkbox" checked="checked"/>
                    </td>
                    <td style="">
                        &nbsp;列表
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<div data-options="region:'west',split:false,collapsible:false" style="width:359px;overflow: hidden;">
    <div style="padding: 5px 0 0 5px; height: 100%; width: 100%;">
        <table>
            <tr width="100%">
                <td>
                    <div class="input-group  input-group-sm"
                         style="width: 346px;padding-left: 10px;padding-right: 8px;">
                        <input class="form-control" placeholder="请输入用户信息" type="text" id="search_text"
                               name="search_text" onkeyup="onSeach(event.keyCode, this.value)"/>
                        <span class="input-group-btn">
				        		<button class="btn btn-default ztree-search" type="button"
                                        onclick="onSeach(13, $('#search_text').val())"><span
                                        class="glyphicon glyphicon-search"></span></button>
				      		</span>
                    </div>
                </td>
            </tr>
        </table>
        <div style="height: 296px; width: 100%;">
            <ul id="selectUserTree" class="ztree" style='overflow: auto;height: 100%; width: 100%;'></ul>
        </div>
    </div>
</div>
<div id="_platform-userselect-userview" data-options="region:'center',split:false"
     style="overflow: hidden;padding:0 14px;">
    <div id="tableToolbarCenter" class="toolbar">
        <div class="toolbar-left selected-check-all">
            <input type="checkbox" id="selectedCheckAll" title="全选"/>
            <span id="selectedCheckboxTitle" class="role-checkbox-title">已选用户</span>
            <span id="selectedPanelTitle" class="selected-panel-title"></span>
        </div>
        <div class="toolbar-right role-delete-all">
            <label id="selectedDeleteAll" class="glyphicon glyphicon-trash" title="删除选中"></label>
        </div>
    </div>
    <div id="platform-userselect-userview" class="row" style="width:99%;display: none;overflow-y: auto;height: 280px;">
    </div>
    <table id="jqGridSelected"></table>
</div>
</BODY>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="static/js/platform/eform/widget.js"></script>
<script src="static/js/platform/eform/mouse.js"></script>
<script src="static/js/platform/eform/sortable.js"></script>
<script src="static/js/platform/eform/jquery-ui.min.js"></script>
<script type="text/javascript">
    var h5KadsView = null;
    var currentTab = "dept";
    var setting = null;
    var firstAsyncSuccessFlag2 = 0;
    var isShowChebox = false;
    var defaultLoadDeptId = "";
    var defaultLoadGroupId = "";
    var defaultLoadRoleId = "";
    var defaultLoadPositionId = "";
    var viewScope = "";
    var defaultOrgId = "";
    var defaultDept = "";
    var secretLevel = "";
    var isShowVoid = false;
    var leyerindex;
    var useridArrays = [];
    var userDeptidsArrays = [];
    var numLimit = 200;
    var callBack = null;
    var setPropertys = null;
    // var viewType = "H5KadsView";
    var viewType = "H5ListView";

    function init(o) {
        if (o.hidTab) {
            for (var i = 0; i < o.hidTab.length; i++) {
                $("#" + o.hidTab[i]).hide();
            }
            var findClickTab = true;
            var viewTab = "dept";

            for (var i = 0; i < o.hidTab.length; i++) {
                if ("dept" == o.hidTab[i]) {
                    findClickTab = false;
                    viewTab = "group";
                    break;
                }
            }
            if (!findClickTab) {
                for (var i = 0; i < o.hidTab.length; i++) {
                    if ("group" == o.hidTab[i]) {
                        findClickTab = false;
                        viewTab = "role";
                        break;
                    } else {
                        findClickTab = true;
                    }
                }
            }
            if (!findClickTab) {
                for (var i = 0; i < o.hidTab.length; i++) {
                    if ("role" == o.hidTab[i]) {
                        findClickTab = false;
                        viewTab = "position";
                        break;
                    } else {
                        findClickTab = true;
                    }
                }
            }
            TabActiveClick(viewTab);
        }
        isShowVoid = o.isShowVoid;
        callBack = o.callBack;
        setPropertys = o.setPropertys;

        if (isShowVoid) {
            $(".isShowVoid").hide();
        }
        var selectModel = o.selectModel;
        if (o.userids && o.userids.indexOf(",") > -1) {
            useridArrays = ((o.userids == null || o.userids == '') ? [] : o.userids.split(","));
        } else {
            useridArrays = ((o.userids == null || o.userids == '') ? [] : o.userids.split(";"));
        }
        if (o.userdeptids && o.userdeptids.indexOf(",") > -1) {
            userDeptidsArrays = ((o.userdeptids == null || o.userdeptids == '') ? [] : o.userdeptids.split(","));
        } else {
            userDeptidsArrays = ((o.userdeptids == null || o.userdeptids == '') ? [] : o.userdeptids.split(";"));
        }
        defaultLoadDeptId = o.defaultLoadDeptId;
        defaultLoadGroupId = o.defaultLoadGroupId;
        defaultLoadRoleId = o.defaultLoadRoleId;
        defaultLoadPositionId = o.defaultLoadPositionId;

        viewScope = o.viewScope;
        defaultOrgId = o.defaultOrgId;
        defaultDept = o.defaultDept;
        secretLevel = o.secretLevel;
        numLimit = o.numLimit || 200;

        var viewSystemUser = false;
        var isload = 0;

        if (selectModel == 'multi') {
            isShowChebox = true;
            $("#selectedCheckboxTitle").addClass("checkbox-title-multi");
        } else {
            isShowChebox = false;
            $("#selectedCheckboxTitle").addClass("checkbox-title-single");
            $("#selectedCheckAll").hide();
            $("#selectedPanelTitle").hide();
        }

        setting = {
            view: {
                fontCss: getTreeNodeFont,
                selectedMulti: false
            },
            check: {
                autoCheckTrigger: false,
                chkboxType: {"Y": "ps", "N": "ps"},
                enable: isShowChebox
            },
            data: {
                key: {
                    id: "id",
                    name: "text",
                    children: "children"
                },
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdKey: "parentId",
                    rootPId: -1
                }
            },
            async: {
                enable: true,
                url: "h5/view/common/select/SelectController/getUserSelectList",
                autoParam: ["id", "nodeType", "orgId"],
                otherParam: {
                    "currentTab": function () {
                        return currentTab;
                    },
                    "viewSystemUser": function () {
                        return viewSystemUser;
                    },
                    "defaultLoadDeptId": defaultLoadDeptId,
                    "defaultLoadGroupId": defaultLoadGroupId,
                    "defaultLoadRoleId": defaultLoadRoleId,
                    "defaultLoadPositionId": defaultLoadPositionId,
                    "selectedUsers": function () {
                        return getSelectedUserIds();
                    },
                    "viewScope": viewScope,
                    "defaultOrgId": defaultOrgId,
                    "defaultDept": defaultDept,
                    "secretLevel": secretLevel
                },
                dataFilter: function (treeId, parentNode, childNodes) {
                    if (!childNodes) {
                        return null;
                    } else {
                        return childNodes;
                    }
                }
            },
            callback: {
                onAsyncError: function (event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
                    layer.alert(XMLHttpRequest);
                },
                beforeAsync: function () {
                    if (isload == 0) {
                        leyerindex = layer.load(1, {
                            shade: [0.3, '#000'] //0.1透明度的白色背景
                        });
                    }
                    isload++;
                    return true;
                },
                onAsyncSuccess: function (event, treeId, treeNode, msg) {
                    var tree = $.fn.zTree.getZTreeObj(treeId);
                    var nodes = tree.getNodes();
                    if (firstAsyncSuccessFlag2 == 0 && currentTab != 'group' && currentTab != 'role' && currentTab != 'position') {
                        tree.expandNode(nodes[0], true);
                        firstAsyncSuccessFlag2 = 1;
                    }
                    if (typeof (treeNode) != "undefined" && typeof (treeNode.checked) != "undefined" && treeNode.checked == true) {
                        tree.checkNode(treeNode, true, true, true);
                    }
                    isload--;
                    if (isload == 0) {
                        layer.close(leyerindex);
                    }
                },
                onClick: function (event, treeId, treeNode) {
                    if (isShowChebox) {
                        // 多选时触发节点的onCheck事件
                        if (treeNode.nodeType === "user") {
                            $.fn.zTree.getZTreeObj(treeId).checkNode(treeNode, !treeNode.checked, true, true);
                        }
                    } else {
                        if (treeNode.nodeType === "user") {
                            addToSelectedUser(treeNode.id, treeNodeToRowData(treeNode));
                        }
                    }
                },
                onCheck: function (event, treeId, _treeNode) {
                    if (_treeNode.checked) {
                        var tree = $.fn.zTree.getZTreeObj(treeId);
                        if (_treeNode.isParent == true && _treeNode.children.length == 0) {
                            if (!_treeNode.open) {
                                tree.expandNode(_treeNode, true);
                                return false;
                            }
                        }
                        handleCheckedCascade(treeId, _treeNode);
                    } else {
                        handleUncheckedCascade(treeId, _treeNode);
                    }
                },
                onDblClick: function (event, treeId, _treeNode) {
                    if (!isShowChebox && _treeNode.nodeType === 'user') {
                        dbClick(_treeNode);
                    }
                }
            }
        };

        firstAsyncSuccessFlag2 = 0;
        $.fn.zTree.init($("#selectUserTree"), setting, []);
        h5KadsView = new H5KadsView({
            id: '#platform-userselect-userview',
            selectModel: selectModel,
            beferRemove: function (id) {
                try {
                    useridArrays = [];
                    userDeptidsArrays = [];
                    var tree = $.fn.zTree.getZTreeObj("selectUserTree");
                    if (id != "all") {
                        var node = tree.getNodesByParam("id", id, null);
                        node[0].checked = false;
                        tree.updateNode(node[0]);
                        resetSelectNum();
                    }
                } catch (e) {
                }
            },
            afertRemove: function () {
                var tree = $.fn.zTree.getZTreeObj("selectUserTree");
                if (h5KadsView.getDataList().length == 0) {
                    var nodes = tree.getCheckedNodes(true);
                    for (var i = 0, l = nodes.length; i < l; i++) {
                        tree.checkNode(nodes[i], false, false);
                    }
                }

                resetSelectNum();
            },
            template: function () {
                if (viewType == "H5KadsView") {
                    return '<div class="col-xs-4 userviewkads"  data=\'{\"id\":\"#0#\", \"name\": \"#1#\",\"deptid\":\"#2#\",\"deptname\":\"#3#\",\"orgIdentity\":\"#4#\",\"loginName\":\"#5#\"}\'  id=\"kads_#0#\">  <div class="thumbnail" style="font-size:12px">	' +
                        ' <span class="glyphicon glyphicon-remove" aria-hidden="true"  style="cursor:pointer;z-index:100" onclick="h5KadsView.remove(\'#0#\');"></span>' +
                        '  <div class="img" style="position:relative"><img class="lazy userPhoto" data-original="<%=ViewUtil.getRequestPath(request)%>/h5/view/common/select/SelectController/getUserPhoto?userid=#0#"></div> <center class="userinfo">#3#</center><center  class="userinfo">#1#</center></div>' +
                        ' </div>';
                } else {
                    return '<div class="col-xs-12 alert-info userviewkads" data=\'{\"id\":\"#0#\", \"name\": \"#1#\", \"deptid\":\"#2#\",\"deptname\":\"#3#\",\"orgIdentity\":\"#4#\",\"loginName\":\"#5#\"}\'  id=\"kads_#0#\">' +
                        '<div class="col-xs-5">#1#</div><div class="col-xs-5">#3#</div><div class="col-xs-1"><span class="icon icon-drag" aria-hidden="true" title="移动" style="cursor:pointer; display: inline-block;"><span class="icon icon-close" aria-hidden="true" title="移除"  style="cursor:pointer" onclick="h5KadsView.remove(\'#0#\');"></span><div>' +
                        '</div>';
                }
            }
        });
        avicAjax.ajax({
            url: "h5/view/common/select/SelectController/getInitUserInfo",
            data: {"userids": JSON.stringify(useridArrays), "deptids": JSON.stringify(userDeptidsArrays)},
            type: 'post',
            dataType: 'json',
            success: function (r) {
                initSelectedUserInfo(r);
            }
        });


        $('.toolbox').on('change', function () {
            if ($(this).is(':checked')) {
                $(this).attr("checked", true);
            } else {
                $(this).attr("checked", false);
            }

            if ($(this).attr('id') == "viewType") {
                if ($("#viewType").attr("checked") == "checked") {
                    viewType = "H5ListView";
                    $('#platform-userselect-userview').hide();
                    $('#jqGridSelected').show();
                    $("#selectedCheckAll").show();
                    $('#jqGridSelected').jqGrid("clearGridData");
                    var retArray = h5KadsView.getDataList();
                    $.each(retArray, function (index, elem) {
                        var rowData = {
                            id: elem.id,
                            name: elem.name,
                            deptid: elem.deptid,
                            deptname: elem.deptname,
                            orgIdentity: elem.orgIdentity,
                            loginName: elem.loginName
                        };
                        addToSelectedUser(rowData.id, rowData);
                    });
                } else {
                    viewType = "H5KadsView";
                    $('#platform-userselect-userview').show();
                    $('#jqGridSelected').hide();
                    $("#selectedCheckAll").hide();
                    h5KadsView.removeAllNOEvent();
                    var useridlist = $("#jqGridSelected").getDataIDs();
                    for (var i = 0; i < useridlist.length; i++) {
                        var rowData = $("#jqGridSelected").jqGrid('getRowData', useridlist[i]);
                        h5KadsView.add(rowData.id, [rowData.id, rowData.name, rowData.deptid, rowData.deptname, rowData.orgIdentity]);
                    }
                    var timeout = setTimeout(function () {
                        $("img.lazy").lazyload({
                            placeholder: "static/h5/common-ext/userDefault.png",
                            effect: "fadeIn",
                            container: "#_platform-userselect-userview"
                        });
                    }, 500);
                }

                resetSelectNum();
            } else if ($(this).attr('id') == "viewSystemUser") {
                if ($("#viewSystemUser").attr("checked") == "checked") {
                    viewSystemUser = true;
                } else {
                    viewSystemUser = false;
                }
                firstAsyncSuccessFlag2 = 0;
                $.fn.zTree.init($("#selectUserTree"), setting, []);
            } else {
                if ($("#isCheck").attr("checked") == "checked") {
                    $.fn.zTree.getZTreeObj("selectUserTree").setting.check.chkboxType = {"Y": "ps", "N": "ps"};
                } else {
                    $.fn.zTree.getZTreeObj("selectUserTree").setting.check.chkboxType = {"Y": "", "N": ""};
                }
            }
        });
    }

    function getUserList() {
        var userids = "";
        var usernames = "";
        var userdeptids = "";
        var userdeptnames = "";
        var orgIdentitys = "";
        var loginNames = "";
        var userlist = [];

        if (viewType == "H5KadsView") {
            userlist = h5KadsView.getDataList();
        } else {
            var useridlist = $("#jqGridSelected").getDataIDs();
            for (var i = 0; i < useridlist.length; i++) {
                var id = useridlist[i];
                var rowData = $("#jqGridSelected").jqGrid('getRowData', id);
                userlist.push(rowData);
            }
        }

        for (var i = 0; i < userlist.length; i++) {
            userids = userids + userlist[i].id + ";";
            usernames = usernames + userlist[i].name + ";";
            userdeptids = userdeptids + userlist[i].deptid + ";";
            userdeptnames = userdeptnames + userlist[i].deptname + ";";
            orgIdentitys = orgIdentitys + userlist[i].orgIdentity + ";";
            loginNames = loginNames + userlist[i].loginName + ";";
        }

        userids = userids.substring(0, userids.length - 1);
        usernames = usernames.substring(0, usernames.length - 1);
        userdeptids = userdeptids.substring(0, userdeptids.length - 1);
        userdeptnames = userdeptnames.substring(0, userdeptnames.length - 1);
        loginNames = loginNames.substring(0, loginNames.length - 1);
        return {
            userids: userids,
            usernames: usernames,
            userdeptids: userdeptids,
            userdeptnames: userdeptnames,
            orgIdentitys: orgIdentitys,
            loginNames: loginNames
        };
    }

    function dbClick(node) {
        var ret = {};
        ret.userids = node.id;
        ret.usernames = node.text;
        ret.userdeptids = node.attributes.deptid;
        ret.userdeptnames = node.attributes.deptname;
        ret.orgIdentitys = node.orgIdentity;
        ret.loginNames = node.loginName;
        setPropertys(ret);
        if (callBack != null && callBack != 'undefined') {
            if (typeof (callBack) === 'function') {
                callBack(ret);
            }
        }
        var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
        parent.layer.close(index);
    }

    function onSeach(ecode, value) {
        if (ecode == 13) {
            var isload = 0;
            var viewSystemUser = false;
            if ($("#viewSystemUser").attr("checked") == "checked") {
                viewSystemUser = true;
            } else {
                viewSystemUser = false;
            }
            if (value == null || value == "" || value == "请输入用户信息") {
                firstAsyncSuccessFlag2 = 0;
                $.fn.zTree.init($("#selectUserTree"), setting, []);
                return;
            }
            $.ajax({
                cache: true,
                type: "post",
                url: "h5/view/common/select/SelectController/newSearchUser",
                dataType: "json",
                data: {
                    "currentTab": function () {
                        return currentTab;
                    },
                    "search_text": value,
                    "selectedUsers": function () {
                        return getSelectedUserIds();
                    },
                    "viewSystemUser": function () {
                        return viewSystemUser;
                    },
                    "defaultLoadDeptId": defaultLoadDeptId,
                    "defaultLoadGroupId": defaultLoadGroupId,
                    "defaultLoadRoleId": defaultLoadRoleId,
                    "defaultLoadPositionId": defaultLoadPositionId,
                    "viewScope": viewScope,
                    "defaultOrgId": defaultOrgId,
                    "defaultDept": defaultDept,
                    "secretLevel": secretLevel,
                    "numLimit": numLimit
                },
                async: false,
                error: function (request) {
                    throw new Error('操作失败，服务请求状态：' + request.status + ' ' + request.statusText + ' 请检查服务是否可用！');
                },
                success: function (r) {
                    if (r.flag != 'success') {
                        layer.msg(r.error);
                    } else {
                        var data = r.data;
                        if (!data || data.length == 0) {
                            layer.msg('没有查询到匹配的数据！');
                            return;
                        }
                        $.fn.zTree.init($("#selectUserTree"), {
                            view: {
                                fontCss: getTreeNodeFont,
                                selectedMulti: false
                            },
                            check: {
                                autoCheckTrigger: false,
                                chkboxType: {"Y": "ps", "N": "ps"},
                                enable: isShowChebox
                            },
                            data: {
                                key: {
                                    id: "id",
                                    name: "text",
                                    children: "children"
                                },
                                simpleData: {
                                    enable: false,
                                    idKey: "id",
                                    pIdKey: "parentId",
                                    rootPId: -1
                                }
                            }, callback: {
                                onClick: function (event, treeId, treeNode) {
                                    if (isShowChebox) {
                                        // 多选时触发节点的onCheck事件
                                        if (treeNode.nodeType === "user") {
                                            $.fn.zTree.getZTreeObj(treeId).checkNode(treeNode, !treeNode.checked, true, true);
                                        }
                                    } else {
                                        if (treeNode.nodeType === "user") {
                                            addToSelectedUser(treeNode.id, treeNodeToRowData(treeNode));
                                        }
                                    }
                                },
                                onCheck: function (event, treeId, _treeNode) {
                                    if (_treeNode.checked) {
                                        handleCheckedCascade(treeId, _treeNode);
                                    } else {
                                        handleUncheckedCascade(treeId, _treeNode);
                                    }
                                },
                                onDblClick: function (event, treeId, _treeNode) {
                                    if (!isShowChebox && _treeNode.nodeType === 'user') {
                                        dbClick(_treeNode);
                                    }
                                }
                            }

                        }, data);
                    }
                }
            });
        }
    }

    function removeAllSelect() {
        if (viewType == "H5KadsView") {
            useridArrays = [];
            userDeptidsArrays = [];
            h5KadsView.removeAll();
            var treeObj = $.fn.zTree.getZTreeObj("selectUserTree");
            treeObj.checkAllNodes(false);
            resetSelectNum();
        } else {
            if (isShowChebox) {
                // 多选时删除选中
                var delIds = $("#jqGridSelected").jqGrid('getGridParam', 'selarrrow');
                removeFromSelectedUserBatch(delIds);
                var treeObj = $.fn.zTree.getZTreeObj("selectUserTree");
                var nodes = treeObj.getCheckedNodes(true);
                $.each(nodes, function (index, node) {
                    if (node.nodeType === "user" && $.inArray(node.id, delIds) > -1) {
                        treeObj.checkNode(node, false, true);
                    }
                });
            } else {
                // 单选时删除所有
                $.each($("#jqGridSelected").getDataIDs(), function (index, elem) {
                    deleteSelectedCascade(elem);
                });
            }
            resetSelectNum();
        }
    }

    function TabActiveClick(Tabid) {
        $("#" + currentTab).removeClass("active");
        $("#" + Tabid).addClass("active");
        currentTab = Tabid;
        firstAsyncSuccessFlag2 = 0;
        $.fn.zTree.init($("#selectUserTree"), setting, []);
        $("#search_text").val("");
        $("#search_text").focus().blur();
        return false;
    }

    var dataGridColModelSelected = [{
        label: 'id',
        name: 'id',
        key: true,
        width: 75,
        hidden: true
    }, {
        label: '全选',
        name: 'title',
        width: 260,
        formatter: formatTitleSelected,
        classes: 'selected-title-col'
    }, {
        label: '部门ID',
        name: 'deptid',
        width: 75,
        hidden: true
    }, {
        label: '部门名',
        name: 'deptname',
        width: 150,
        hidden: true
    }, {
        label: '用户登录名',
        name: 'loginName',
        hidden: true,
        width: 150
    }, {
        label: '用户名',
        name: 'name',
        width: 150,
        hidden: true
    }, {
        label: '组织应用ID',
        name: 'orgIdentity',
        width: 150,
        hidden: true
    }, {
        label: '操作',
        name: 'op',
        width: 60,
        //hidden: true,
        formatter: formatOp,
        classes: 'selected-op-col'
    }];

    function initSelectedUserInfo(userArray) {
        $('#jqGridSelected').jqGrid({
            colModel: dataGridColModelSelected,
            height: $(window).height() - 93,
            datatype: "local",
            rowNum: -1,
            hasColSet: false,
            hasTabExport: false,
            altRows: true,
            userDataOnFooter: true,
            loadonce: false,
            viewrecords: true,
            styleUI: 'Bootstrap',
            multiboxonly: false,
            multiselect: true,
            autowidth: !isShowChebox,
            //rownumbers: true,
            responsive: !isShowChebox,//开启自适应
            //onSelectRow: onSelectRow,//js方法
            //ondblClickRow: ondblClickRow,
            gridComplete: function () {
                //单选隐藏checkbox
                if (!isShowChebox) {
                    $('#selectedCheckAll').hide();
                    $("#jqGridSelected").jqGrid('hideCol', 'cb');
                    $("#jqGridSelected").jqGrid('hideCol', 'op');
                    $("#selectedCheckboxTitle").addClass("checkbox-title-single");
                } else {
                    //$("#jqGridSelected").jqGrid('showCol', 'op');
                    $("#selectedCheckboxTitle").addClass("checkbox-title-multi");
                    $(".ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td").css("padding-left", "0");
                }
                $("#jqGridSelected_title").hide();
                $("#jqGridSelected_op").hide();
                $("#jqGridSelected_cb").hide();
                $("#jqGridSelected td[role=\"gridcell\"]").attr("title", "");
            }
        });

        if (viewType == "H5KadsView") {
            var temp = h5KadsView.template();
            for (var i = 0; i < r.length; i++) {
                h5KadsView.fastAdd(r[i].id, [r[i].id, r[i].name, r[i].deptid, r[i].deptname, r[i].orgIdentity, r[i].loginName], temp.concat());
            }
            var timeout = setTimeout(function () {
                $("img.lazy").lazyload({
                    placeholder: "static/h5/common-ext/userDefault.png",
                    effect: "fadeIn",
                    container: "#_platform-userselect-userview"
                });
            }, 500);
            resetSelectNum();
        } else {
            addToSelectedUserBatch(userArray);
            //实现行拖拽
            $('#jqGridSelected').jqGrid('sortableRows');

            $('#selectedCheckAll').bind('click', function (e) {
                var checkStatus = $(e.target)[0].checked;
                var allIds = $("#jqGridSelected").getDataIDs();
                var selIds = $("#jqGridSelected").jqGrid('getGridParam', 'selarrrow');
                if (checkStatus) {
                    for (var i = allIds.length - 1; i >= 0; i--) {
                        if ($.inArray(allIds[i], selIds) == -1) {
                            $("#jqGridSelected").setSelection(allIds[i], true);
                        }
                    }
                } else {
                    for (var i = selIds.length - 1; i >= 0; i--) {
                        $("#jqGridSelected").setSelection(selIds[i], true);
                    }
                }

            });
            $('#selectedDeleteAll').bind('click', function () {
                removeAllSelect();
                $('#selectedCheckAll').attr("checked", false);
            });
        }
    }

    function addToSelectedUser(rowId, rowData) {
        // 单选模式下清空已选择
        if (!isShowChebox) {
            if (viewType == "H5KadsView") {
                $("div.userviewkads").remove();
            } else {
                $.each($("#jqGridSelected").getDataIDs(), function (index, elem) {
                    $("#jqGridSelected").delRowData(elem);
                });
            }
        }
        if (viewType == "H5KadsView") {
            var temp = h5KadsView.template();
            h5KadsView.fastAdd(rowData.id, [rowData.id, rowData.name, rowData.deptid, rowData.deptname, rowData.orgIdentity, rowData.loginName], temp.concat());
            var timeout = setTimeout(function () {
                $("img.lazy").lazyload({
                    placeholder: "static/h5/common-ext/userDefault.png",
                    effect: "fadeIn",
                    container: "#_platform-userselect-userview"
                });

            }, 500);
        } else {
            var exist = false;
            var allIds = $("#jqGridSelected").getDataIDs();
            for (var i = 0, len = allIds.length; i < len; i++) {
                if (allIds[i] == rowId) {
                    exist = true;
                    break;
                }
            }
            if (!exist) {
                $("#jqGridSelected").addRowData(rowId, rowData);
            }
        }

        resetSelectNum();
    }

    function addToSelectedUserBatch(addingData) {
        if (!addingData || !addingData.length) {
            return;
        }
        if (viewType == "H5KadsView") {
            var temp = h5KadsView.template();
            $.each(addingData, function (index, rowData) {
                h5KadsView.fastAdd(rowData.id, [rowData.id, rowData.name, rowData.deptid, rowData.deptname, rowData.orgIdentity, rowData.loginName], temp.concat());
            });
            var timeout = setTimeout(function () {
                $("img.lazy").lazyload({
                    placeholder: "static/h5/common-ext/userDefault.png",
                    effect: "fadeIn",
                    container: "#_platform-userselect-userview"
                });

            }, 500);
        } else {
            var jsonData = $("#jqGridSelected").getRowData();
            $.each(addingData, function (index, data) {
                jsonData.push(data);
            });
            $('#jqGridSelected').setGridParam({datastr: jsonData, datatype: 'jsonstring'}).trigger('reloadGrid');
        }

        resetSelectNum();
    }

    /**移除选中的用户并将左侧checkbox取消选中*/
    function deleteSelectedCascade(rowId) {
        removeFromSelectedUser(rowId);
        if (viewType == "H5KadsView") {
            h5KadsView.removeNOEvent(rowId);
        } else {
            var treeObj = $.fn.zTree.getZTreeObj("selectUserTree");
            var nodes = treeObj.getCheckedNodes(true);
            $.each(nodes, function (index, node) {
                if (node.nodeType === "user" && node.id == rowId) {
                    treeObj.checkNode(node, false, true);
                }
            });
        }
    }

    /**移除选中的用户*/
    function removeFromSelectedUser(rowId) {
        if (viewType == "H5KadsView") {
            h5KadsView.removeNOEvent(rowId);
        } else {
            $("#jqGridSelected").delRowData(rowId);
        }

        resetSelectNum();
    }

    /**批量移除选中的用户*/
    function removeFromSelectedUserBatch(delIds) {
        if (!delIds || !delIds.length) {
            return;
        }
        if (viewType == "H5KadsView") {
            $.each(delIds, function (index, rowId) {
                h5KadsView.removeNOEvent(rowId);
            });
        } else {
            // $.each(delIds, function (index, rowId) {
            //     $("#jqGridSelected").delRowData(rowId);
            // });
            var jsonData = $("#jqGridSelected").getRowData();
            for (var i = jsonData.length - 1; i >= 0; i--) {
                if ($.inArray(jsonData[i].id, delIds) > -1) {
                    jsonData.splice(i, 1);
                }
            }
            $('#jqGridSelected').setGridParam({datastr: jsonData, datatype: 'jsonstring'}).trigger('reloadGrid');
        }
        resetSelectNum();
    }

    function formatTitleSelected(cellvalue, options, rowObject) {
        var descElem = '<i class="icon icon-info title-desc" title="' + rowObject.deptname + '"></i>';
        return '<span class="selected-title-span" data-id="' + rowObject.id + '" title="" ><span class="user-name">' + rowObject.name + '</span><em class="orgSelect dept-name">(' + rowObject.deptname + ')</em></span>';
    }

    function formatOp(cellvalue, options, rowObject) {
        return '<span class="icon icon-drag" aria-hidden="true" title="移动"></span><span class="icon icon-close" aria-hidden="true" title="移除" onclick="deleteSelectedCascade(\'' + rowObject.id + '\');"></span>';
    }

    function treeNodeToRowData(treeNode) {
        return {
            id: treeNode.id,
            name: treeNode.text,
            deptid: treeNode.attributes.deptid,
            deptname: treeNode.attributes.deptname,
            orgIdentity: treeNode.orgIdentity,
            loginName: treeNode.loginName
        };
    }

    function resetSelectNum() {
        var selectCnt = 0;
        if (viewType == "H5KadsView") {
            selectCnt = h5KadsView.getKadsSize();
        } else {
            selectCnt = $("#jqGridSelected").getDataIDs().length;
        }
        if (selectCnt) {
            $('.unselected-div').remove();
        } else {
            $('.unselected-div').remove();
            var elemDiv = '<div class="unselected-div"><img src="static/h5/common-ext/userUnselected.png" /><span class="unselected-div-title">暂未选择用户</span></div>';
            $('#gview_jqGridSelected .ui-jqgrid-bdiv').append(elemDiv);
            $('#platform-userselect-userview').append(elemDiv);
        }

        $("#selectedPanelTitle").text("(" + selectCnt + ")");
        var userlist = getUserList();
        if (userlist.userids != "") {
            if (userlist.userids.indexOf(",") > -1) {
                useridArrays = userlist.userids.split(',');
            } else {
                useridArrays = userlist.userids.split(';');
            }

            if (userlist.userdeptids.indexOf(",") > -1) {
                userDeptidsArrays = userlist.userdeptids.split(',');
            } else {
                userDeptidsArrays = userlist.userdeptids.split(';');
            }
        } else {
            useridArrays = [];
            userDeptidsArrays = [];
        }
    }

    function getSelectedUserIds() {
        return useridArrays.join(',');
    }

    function handleCheckedCascade(treeId, treeNode) {
        var treeObj = $.fn.zTree.getZTreeObj("selectUserTree");
        if (treeNode.nodeType === "user") {
            addToSelectedUser(treeNode.id, treeNodeToRowData(treeNode));
        } else if (treeNode.children) {
            var addingData = [];
            var selIds = useridArrays;
            $.each(treeNode.children, function (index, child) {
                if (child.nodeType === "user") {
                    if ($.inArray(child.id, selIds) == -1) {
                        addingData.push(treeNodeToRowData(child));
                        selIds.push(child.id);
                    }
                } else {
                    treeObj.checkNode(child, false, true);
                }
            });
            addToSelectedUserBatch(addingData);
        }
    }

    function handleUncheckedCascade(treeId, treeNode) {
        if (treeNode.nodeType === "user") {
            removeFromSelectedUser(treeNode.id, treeNodeToRowData(treeNode));
        } else {
            var delIds = [];
            treeNode.children && $.each(treeNode.children, function (index, child) {
                if (child.nodeType === "user") {
                    if ($.inArray(child.id, delIds) === -1) {
                        delIds.push(child.id);
                    }
                } else {
                    handleUncheckedCascade(treeId, child);
                }
            });
            removeFromSelectedUserBatch(delIds);
        }
    }

    function getTreeNodeFont(treeId, node) {
        if (node.fontCss) {
            var css = {};
            var attrs = node.fontCss.split(";");
            $.each(attrs, function (index, attr) {
                if (attr && attr.indexOf(":") > -2) {
                    var pairs = attr.split(":");
                    css[pairs[0]] = pairs[1];
                }
            });
            return css;
        }
        return {};
    }

</script>

</HTML>
