<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <title>角色选择</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/select2/select2.css"/>
    <link rel="stylesheet" type="text/css" href="avicit/platform6/h5component/common/commonselect.css"/>

</head>
<body class=" easyui-layout" fit="true">
<div data-options="region:'west', width: fixwidth(.50),onResize:function(a){$('#jqGrid').setGridWidth(a);$(window).trigger('resize');}"
     style="overflow-y: hidden; padding: 0 14px;">
    <div id="tableToolbar" class="toolbar">
        <div class="toolbar-right">
            <div class="input-group form-tool-search">
                <input type="text" name="keyWord" id="keyWord"
                       class="form-control input-sm" placeholder="请输入角色名称查询"/> <label
                    id="searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
        </div>
        <table>
            <tr>
                <td>
                    <select class="org-select2">
                    </select>
                </td>
                <td class="appSelectType">
                    <select class="app-select2">
                    </select>
                </td>
            </tr>
        </table>
    </div>
    <table id="jqGrid"></table>
    <div id="jqGridPager"></div>
</div>
<div data-options="region:'center',split:false" style="overflow: hidden;padding:0 14px;">
    <div id="tableToolbarCenter" class="toolbar">
        <div class="toolbar-left selected-check-all">
            <input type="checkbox" id="selectedCheckAll" title="全选"/>
            <span id="selectedCheckboxTitle" class="role-checkbox-title">已选角色</span>
            <span id="selectedPanelTitle" class="selected-panel-title"></span>
        </div>
        <div class="toolbar-right role-delete-all">
            <label id="selectedDeleteAll" class="glyphicon glyphicon-trash" title="删除选中"></label>
        </div>
    </div>
    <table id="jqGridSelected"></table>
</div>
</body>

<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script src="static/js/platform/eform/widget.js"></script>
<script src="static/js/platform/eform/mouse.js"></script>
<script src="static/js/platform/eform/sortable.js"></script>
<script src="static/js/platform/eform/jquery-ui.min.js"></script>
<script src="static/h5/select2/select2.js"></script>
<script>
    var selectModel = null;
    var roleid = null;
    var roleName = null;
    var callBack = null;
    var viewScope = null;
    var orgIdentity = null;
    var defaultOrgId = null;
    var appSelectType = null;
    var setPropertys = null;
    var appId = null;
    var orgId = null;
    var defaultLoadRoleId = null;
    var selectedRoleIds = null;

    var dataGridColModel = [{
        label: 'id',
        name: 'id',
        key: true,
        width: 75,
        hidden: true
    }, {
        label: '全选',
        name: 'title',
        width: 150,
        sortable: false,
        formatter: formatTitle
    }, {
        label: 'roleType',
        name: 'roleType',
        width: 75,
        hidden: true
    }, {
        label: '角色名称',
        name: 'roleName',
        width: 150,
        hidden: true
    }, {
        label: '角色编码',
        name: 'roleCode',
        hidden: true,
        width: 150
    }, {
        label: '角色描述',
        name: 'desc',
        width: 150,
        hidden: true
    }, {
        label: '组织应用ID',
        name: 'orgIdentity',
        width: 150,
        hidden: true
    }, {
        label: '组织应用名称',
        name: 'orgIdentityName',
        width: 150,
        hidden: true
    }, {
        label: '应用名称',
        name: 'sysApplicationName',
        width: 150,
        hidden: true
    }];

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
        label: 'roleType',
        name: 'roleType',
        width: 75,
        hidden: true
    }, {
        label: '角色名称',
        name: 'roleName',
        width: 150,
        hidden: true
    }, {
        label: '角色编码',
        name: 'roleCode',
        hidden: true,
        width: 150
    }, {
        label: '角色描述',
        name: 'desc',
        width: 150,
        hidden: true
    }, {
        label: '组织应用ID',
        name: 'orgIdentity',
        width: 150,
        hidden: true
    }, {
        label: '组织应用名称',
        name: 'orgIdentityName',
        width: 150,
        hidden: true
    }, {
        label: '操作',
        name: 'op',
        width: 60,
        //hidden: true,
        formatter: formatOp,
        classes: 'selected-op-col'
    }, {
        label: '应用名称',
        name: 'sysApplicationName',
        width: 150,
        hidden: true
    }];
    var multi = false;

    function formatTitle(cellvalue, options, rowObject) {
        var roleDescElem = '';
        if (rowObject.desc) {
            roleDescElem = '<i class="icon icon-info title-desc" title="' + rowObject.desc + '"></i>';
        } else {
            roleDescElem = '<i class="icon icon-info title-desc" title="暂无描述"></i>';
        }
        var appNameElem = '';
        if (appSelectType && rowObject.sysApplicationName) {
            appNameElem = '<em class="app-name" title="">(' + rowObject.sysApplicationName + ')</em>';
        }
        return '<span class="selected-title-span" data-id="' + rowObject.id + '" title="" style="width: 360px;"><span class="role-role-name">' + rowObject.roleName + '</span>' + appNameElem + roleDescElem + '</span>';
    }

    function formatTitleSelected(cellvalue, options, rowObject) {
        var roleDescElem = '';
        if (rowObject.desc) {
            roleDescElem = '<i class="icon icon-info title-desc" title="' + rowObject.desc + '"></i>';
        } else {
            roleDescElem = '<i class="icon icon-info title-desc" title="暂无描述"></i>';
        }
        var appNameElem = '';
        if (appSelectType && rowObject.sysApplicationName) {
            appNameElem = '<em class="app-name" title="">(' + rowObject.sysApplicationName + ')</em>';
        }
        return '<span class="selected-title-span" data-id="' + rowObject.id + '" title="" style="width: 360px;"><span class="role-role-name">' + rowObject.roleName + '</span><em class="orgSelect org-name">(' + rowObject.orgIdentityName + ')</em>' + appNameElem + roleDescElem + '</span>';
    }

    function formatOp(cellvalue, options, rowObject) {
        return '<span class="icon icon-drag" aria-hidden="true" title="移动"></span><span class="icon icon-close" aria-hidden="true" title="移除" onclick="deleteSelectedCascade(\'' + rowObject.id + '\');"></span>';
    }

    function selectedRowMouseOver(e) {
        var id = $(e.target).find('span.selected-title-span').data("id");
        $('#jqGridSelectedspan .selected-op-col .glyphicon-remove').hide();
        $('#jqGridSelectedspan .selected-op-col ').find('span.glyphicon-remove[data-id="' + id + '"]').show();
    }

    function selectedRowMouseOut(e) {
        var id = $(e.target).find('span.selected-title-span').data("id");
        $(e.target).find('span.selected-title-span .glyphicon-remove').hide();
    }

    //初始化表格参数
    function init(o) {
        viewScope = o.viewScope;
        defaultOrgId = o.defaultOrgId;
        defaultLoadRoleId = o.defaultLoadRoleId;
        selectModel = o.selectModel;
        orgIdentity = o.orgIdentity;
        appSelectType = o.appSelectType;
        selectedRoleIds = o.roleids;
        roleid = o.roleid;
        roleName = o.roleName;
        callBack = o.callBack;
        setPropertys = o.setPropertys;

        if (!appSelectType) {
            $(".appSelectType").hide();
        }

        if (selectModel == "single") {
            multi = false;
            $("#selectedPanelTitle").hide();
        } else if (selectModel == "multi") {
            multi = true;
        }
        if ($('#orgAlias').val() == null || $('#orgAlias').val() == "" || $('#orgAlias').val() == "所属组织") {
            avicAjax.ajax({
                url: "h5/view/common/select/SelectController/searchOrgName",
                data: {
                    "viewScope": viewScope,
                    "defaultOrgId": defaultOrgId
                },
                type: 'post',
                dataType: 'json',
                async: false,
                success: function (r) {
                    if (r.flag == "success") {
                        $('#orgid').val(r.id);
                        $('#orgAlias').val(r.orgName);
                        $('#jqGrid').jqGrid({
                            url: 'h5/view/common/select/SelectController/getInitRoleInfo',
                            mtype: 'POST',
                            datatype: "json",
                            postData: {
                                viewScope: r.viewScope,
                                defaultOrgId: defaultOrgId,
                                defaultLoadRoleId: defaultLoadRoleId,
                                appSelectType: appSelectType,
                                appId: appId
                            },
                            colModel: dataGridColModel,
                            height: $(window).height() - (multi ? 120 : 85),
                            scrollOffset: 20, //设置垂直滚动条宽度
                            rowNum: 10,
                            rowList: [200, 100, 50, 20, 10, 5],
                            pagerpos: 'left',
                            pager: "#jqGridPager",
                            hasColSet: false,
                            hasTabExport: false,
                            altRows: true,
                            userDataOnFooter: true,
                            pagerpos: 'left',
                            loadonce: false,
                            viewrecords: true,
                            styleUI: 'Bootstrap',
                            multiboxonly: !multi,
                            multiselect: true,
                            autowidth: true,
                            responsive: true,//开启自适应
                            onSelectRow: onSelectRow,//js方法
                            ondblClickRow: ondblClickRow,
                            onSelectAll: onSelectAll,
                            gridComplete: function () {
                                if (selectedRoleIds) {
                                    var role = selectedRoleIds.split(';');
                                    if (selectedRoleIds.indexOf(",") > -1) {
                                        role = selectedRoleIds.split(',');
                                    }
                                    for (var o = 0; o < role.length; o++) {
                                        var id = role[o];
                                        $(this).jqGrid("setSelection", id);
                                    }
                                }
                                $("#jqGrid td[role=\"gridcell\"]").attr("title", "");
                                if (multi) {
                                    $(".ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td").css("padding-left", "0");
                                }
                            }
                        });

                        //单选隐藏checkbox
                        if (multi) {
                            $("#jqgh_jqGrid_title").css("text-align", "left");
                        } else {
                            $("#jqGrid_title").hide();
                            $("#jqGrid").jqGrid('hideCol', 'cb');
                        }
                        //回车查询
                        $('#keyWord').on('keydown', function (e) {
                            if (e.keyCode == '13') {
                                onSeach();
                            }
                        });
                    } else {
                        layer.alert('查询所属组织失败！' + r.error, {
                                icon: 7,
                                area: ['400px', ''], //宽高
                                closeBtn: 0,
                                btn: ['关闭'],
                                title: "提示"
                            }
                        );
                    }
                }
            });
            initSelectedRoleInfo();
            initOrgSelect();
            if (appSelectType) {
                initAppSelect();
            }
        }
    }

    function initSelectedRoleInfo() {
        $('#jqGridSelected').jqGrid({
            colModel: dataGridColModelSelected,
            height: $(window).height() - 85,
            datatype: "local",
            rowNum: 10,
            pagerpos: 'left',
            hasColSet: false,
            hasTabExport: false,
            altRows: true,
            userDataOnFooter: true,
            loadonce: false,
            viewrecords: true,
            styleUI: 'Bootstrap',
            multiboxonly: false,
            multiselect: true,
            autowidth: !multi,
            //rownumbers: true,
            responsive: !multi,//开启自适应
            //onSelectRow: onSelectRow,//js方法
            //ondblClickRow: ondblClickRow,
            gridComplete: function () {
                //单选隐藏checkbox
                if (!multi) {
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
        if (selectedRoleIds) {
            var selectedRoles = [];
            avicAjax.ajax({
                url: 'h5/view/common/select/SelectController/getSelectedRoleInfo',
                type: 'post',
                async: false,
                dataType: 'json',
                data: {
                    viewScope: viewScope,
                    defaultOrgId: defaultOrgId,
                    defaultLoadRoleId: selectedRoleIds,
                    appSelectType: appSelectType,
                    appId: appId
                },
                success: function (r) {
                    if (r && r.rows) {
                        selectedRoles = r.rows;
                    }
                }
            });
            for (var i = 0, len = selectedRoles.length; i < len; i++) {
                addToSelectedRole(selectedRoles[i].id, selectedRoles[i]);
            }
        } else {
            resetSelectNum();
        }

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

    function addToSelectedRole(rowId, rowData) {
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
            allIds.push(rowId);
        }
        selectedRoleIds = allIds.join(';');
        resetSelectNum();
    }

    /**移除选中的角色并将左侧checkbox取消选中*/
    function deleteSelectedCascade(rowId) {
        removeFromSelectedRole(rowId);
        $("#jqGrid").setSelection(rowId, false);
    }

    /**移除选中的群组*/
    function removeFromSelectedRole(rowId) {
        $("#jqGridSelected").delRowData(rowId);
        var allIds = $("#jqGridSelected").getDataIDs();
        selectedRoleIds = allIds.join(';');
        resetSelectNum();
    }

    // 双击
    function ondblClickRow(rowId, iRow, iCol) {
        if (!multi) {
            var ret = {};
            //var rowId = GetJqGridRowValue("#jqGrid", "id");
            var rowData = $("#jqGrid").getRowData(rowId);
            ret.roleids = rowData.id;
            ret.roleNames = rowData.roleName;
            ret.roleType = rowData.roleType;
            ret.orgIdentitys = rowData.orgIdentity;
            ret.rowdatas = [rowData];
            setPropertys(ret);
            if (callBack != null && callBack != 'undefined') {
                if (typeof (callBack) === 'function') {
                    callBack(ret);
                }
            }
            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
            parent.layer.close(index);
        }
    }

    function GetJqGridRowValue(jgrid, code) {
        var KeyValue = "";
        var selectedRowIds = $(jgrid).jqGrid("getGridParam", "selarrrow");
        if (selectedRowIds != "") {
            var len = selectedRowIds.length;
            for (var i = 0; i < len; i++) {
                var rowData = $(jgrid).jqGrid('getRowData', selectedRowIds[i]);
                KeyValue += rowData[code] + ";";
            }
            KeyValue = KeyValue.substr(0, KeyValue.length - 1);
        } else {
            var rowData = $(jgrid).jqGrid('getRowData',
                $(jgrid).jqGrid('getGridParam', 'selrow'));
            KeyValue = rowData[code];
        }
        return KeyValue;
    }

    // 	单选
    function onSelectRow(rowid, status) {
        if (multi) {
            var rowData = $("#jqGrid").jqGrid('getRowData', rowid);
            if (status) {
                addToSelectedRole(rowid, rowData);
            } else {
                removeFromSelectedRole(rowid);
            }
        } else {
            var rowData = $("#jqGrid").jqGrid('getRowData', rowid);
            var selectIds = $("#jqGridSelected").getDataIDs();
            if (selectIds && selectIds.length) {
                for (var i = selectIds.length - 1; i >= 0; i--) {
                    removeFromSelectedRole(selectIds[i]);
                }
            }
            addToSelectedRole(rowid, rowData);
            $("#jqGridSelected").setSelection(rowid, true);
        }
    }

    // 	全选
    function onSelectAll(aRowids, status) {
        if (multi) {
            for (var i = 0, len = aRowids.length; i < len; i++) {
                var rowid = aRowids[i];
                var rowData = $("#jqGrid").jqGrid('getRowData', rowid);
                var allIds = $("#jqGridSelected").getDataIDs();
                var exist = false;
                for (var j = 0, lenSelected = allIds.length; j < lenSelected; j++) {
                    if (allIds[j] == rowid) {
                        exist = true;
                        break;
                    }
                }
                if (status) {
                    if (!exist) {
                        addToSelectedRole(rowid, rowData);
                    }
                } else {
                    removeFromSelectedRole(rowid);
                }
            }
        }
    }

    //关键字段查询
    function onSeach() {
        var searchdata = {search_text: $('#keyWord').val() == $('#keyWord').attr("placeholder") ? "" : $('#keyWord').val()};
        $('#jqGrid').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
    }

    //查询按钮绑定事件
    $('#searchPart').bind('click', function () {
        onSeach();
    });

    //回填数据
    function getRoleList() {
        var roleids = "";
        var roleNames = "";
        var roleType = "";
        var rowdatas = [];
        var orgIdentitys = "";
        var roleidlist = $("#jqGridSelected").getDataIDs();
        for (var i = 0; i < roleidlist.length; i++) {
            var id = roleidlist[i];
            var rowData = $("#jqGridSelected").jqGrid('getRowData', id);
            roleids = roleids + rowData.id + ";";
            roleNames = roleNames + rowData.roleName + ";";
            orgIdentitys = orgIdentitys + rowData.orgIdentity + ";";
            roleType = rowData.roleType;
            rowdatas.push(rowData);
        }
        roleids = roleids.substring(0, roleids.length - 1);
        roleNames = roleNames.substring(0, roleNames.length - 1);
        orgIdentitys = orgIdentitys.substring(0, orgIdentitys.length - 1);

        return {
            roleids: roleids,
            roleNames: roleNames,
            orgIdentitys: orgIdentitys,
            roleType: roleType,
            rowdatas: rowdatas
        };

    }

    //重载
    function reLoad() {
        var searchdata = {orgId: orgId, appId: appId, appSelectType: appSelectType};
        $('#jqGrid').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
    }

    function initOrgSelect() {
        var data = [];
        avicAjax.ajax({
            url: 'h5/view/common/select/SelectController/selectOrgName',
            type: 'post',
            async: false,
            dataType: 'json',
            data: {
                viewScope: viewScope,
                defaultOrgId: defaultOrgId,
                defaultLoadRoleId: selectedRoleIds,
                appSelectType: appSelectType,
                appId: appId
            },
            success: function (rows) {
                if (rows) {
                    $.each(rows, function (index, value) {
                        data.push({id: value.id, text: value.orgName});
                    });
                }
            }
        });

        $(".org-select2").select2({
            width: appSelectType ? '100px' : '150px',
            language: {
                noResults: function (params) {
                    return "暂无数据";
                }
            },
            data: data
        });
        $(".org-select2").on("change", function (e) {
            var newOrgId = $(e.target).val();
            if ($('#orgid').val() != newOrgId) {
                orgId = newOrgId;
                reLoad();
                $('#orgid').val(newOrgId);
                $.each(data, function (index, elem) {
                    if (newOrgId === elem.id) {
                        $('#orgAlias').val(elem.orgName);
                        return false;
                    }
                });
            }
        });
        $(".org-select2").val(orgId);
    }

    function initAppSelect() {
        var data = [];
        data.push({id: '', text: '选请择应用'});
        avicAjax.ajax({
            url: 'h5/view/common/select/SelectController/selectAppName',
            type: 'post',
            async: false,
            dataType: 'json',
            data: {
                appSelectType: appSelectType,
                defaultAppId: appId
            },
            success: function (rows) {
                if (rows) {
                    $.each(rows, function (index, value) {
                        data.push({id: value.id, text: value.applicationName});
                    });
                }
            }
        });

        $(".app-select2").select2({
            width: '110px',
            placeholder: "请选择应用",
            language: {
                noResults: function (params) {
                    return "暂无数据";
                }
            },
            data: data
        });
        $(".app-select2").on("change", function (e) {
            var newAppId = $(e.target).val();
            if (appId != newAppId) {
                appId = newAppId;
                reLoad();
            }
        });
        // $(".app-select2").val("297ee80f73501f9e0173502af4aa0131").select2();
        //$(".app-select2").val("").select2();
        //$(".app-select2").select2("val", "");
        //$(".app-select2").val("297ee80f73501f9e0173502af4aa0131").trigger('change');
        $(".form-tool-search").addClass("app-select");
    }

    function removeAllSelect() {
        if (multi) {
            // 多选时删除选中
            var rows = $("#jqGridSelected").jqGrid('getGridParam', 'selarrrow');
            for (var i = rows.length - 1; i >= 0; i--) {
                var removeId = rows[i];
                deleteSelectedCascade(removeId);
            }
        } else {
            // 单选时删除所有
            $.each($("#jqGridSelected").getDataIDs(), function (index, elem) {
                deleteSelectedCascade(elem);
            });
        }
    }

    function resetSelectNum() {
        var selectCnt = $("#jqGridSelected").getDataIDs().length;
        if(selectCnt){
            $('.unselected-div').remove();
        } else {
            $('.unselected-div').remove();
            var elemDiv = '<div class="unselected-div"><img src="static/h5/common-ext/userUnselected.png" /><span class="unselected-div-title">暂未选择角色</span></div>';
            $('#gview_jqGridSelected .ui-jqgrid-bdiv').append(elemDiv);
        }
        $("#selectedPanelTitle").text("(" + selectCnt + ")");
    }

    $(document).ready(function () {

        $('#appAlias').on('focus', function (e) {
            new H5CommonPopSelect({
                idFiled: 'appid',
                textFiled: 'appAlias',
                divid: 'appselect',
                type: 'appSelect',
                appSelectType: appSelectType,
                contentWidth: '300',
                callBack: function (datas) {
                    appId = datas.id;
                    reLoad();
                }
            });
            this.blur();
            nullInput(e);
        });

        $('.input-group-addon-icon').on('click', function (e) {
            $(this).parent().find('input[type="text"]').trigger('focus');
        });
    });
</script>

</body>
</html>
