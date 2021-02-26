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
    <title>群组选择</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/select2/select2.css"/>
    <link rel="stylesheet" type="text/css" href="avicit/platform6/h5component/common/commonselect.css"/>
</head>
<body class=" easyui-layout" fit="true">
<div data-options="region:'west', width: fixwidth(.5),onResize:function(a){$('#jqGrid').setGridWidth(a);$(window).trigger('resize');}"
     style="overflow-y: hidden; padding: 0 14px;">
    <div id="tableToolbar" class="toolbar">
        <div class="toolbar-right">
            <div class="input-group form-tool-search">
                <input type="text" name="keyWord" id="keyWord"
                       class="form-control input-sm" placeholder="请输入群组名称查询" /> <label
                    id="Group_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
        </div>
        <div class="toolbar-left">
            <table>
                <tr>
                    <td>
                        <select class="org-select2" style="width: 150px;">
                        </select>
                    </td>
                    <td> &nbsp;</td>
                    <td class="appSelectType">
                        <div id="appselect" class="input-group input-group-sm avicselect">
                            <input type="hidden" name="appid" id="appid" />
                            <input type="text" class="form-control" name="appAlias" id="appAlias" style="width: 130px;"
                                   placeholder="所属应用" />
                            <span class="input-group-addon-icon input-group-addon avicselect-act"><i
                                    class="glyphicon glyphicon-list"></i></span>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <table id="jqGrid"></table>
    <div id="jqGridPager"></div>
</div>
<div data-options="region:'center',split:false" style="overflow-y: hidden; padding: 0 14px;">
    <div id="tableToolbarCenter" class="toolbar">
        <div class="toolbar-left selected-check-all">
            <input type="checkbox" id="selectedCheckAll" title="全选"/>
            <span id="selectedCheckboxTitle" class="role-checkbox-title">已选群组</span>
            <span id="selectedPanelTitle" class="selected-panel-title"></span>
        </div>
        <div class="toolbar-right group-delete-all">
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
    var groupid = null;
    var groupName = null;
    var orgIdentity = null;
    var callBack = null;
    var viewScope = null;
    var defaultOrgId = null;
    var defaultLoadGroupId = null;
    var selectedGroupIds = null;
    var appSelectType = null;
    var setPropertys = null;
    var appId = null;
    var orgId = null;
    var multi;

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
        label: '群组名称',
        name: 'groupName',
        width: 150,
        hidden: true
    }, {
        label: '群组描述',
        name: 'groupDesc',
        width: 150,
        hidden: true
    }, {
        label: '组织应用ID',
        name: 'orgIdentity',
        width: 150,
        hidden: true
    }, {
        label: '组织应用ID',
        name: 'orgIdentityName',
        width: 150,
        hidden: true
    }, {
        label: '应用名称',
        name: 'applicationName',
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
        sortable: false,
        formatter: formatTitleSelected,
        classes: 'selected-title-col'
    }, {
        label: '操作',
        name: 'op',
        width: 60,
        //hidden: true,
        formatter: formatOp,
        classes: 'selected-op-col'
    }, {
        label: '群组名称',
        name: 'groupName',
        width: 150,
        hidden: true
    }, {
        label: '群组描述',
        name: 'groupDesc',
        width: 150,
        hidden: true
    }, {
        label: '组织应用ID',
        name: 'orgIdentity',
        width: 150,
        hidden: true
    }, {
        label: '组织应用ID',
        name: 'orgIdentityName',
        width: 150,
        hidden: true
    }, {
        label: '应用名称',
        name: 'applicationName',
        width: 150,
        hidden: true
    }];

    //初始化表格参数
    function init(o) {
        selectModel = o.selectModel;
        selectedGroupIds = o.groupids;
        groupid = o.groupid;
        groupName = o.groupName;
        orgIdentity = o.orgIdentity;
        viewScope = o.viewScope;
        defaultOrgId = o.defaultOrgId;
        defaultLoadGroupId = o.defaultLoadGroupId;
        appSelectType = o.appSelectType;
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
                            url: 'h5/view/common/select/SelectController/getInitGroupInfo',
                            mtype: 'POST',
                            datatype: "json",
                            postData: {
                                viewScope: 'currentOrg',
                                defaultOrgId: defaultOrgId,
                                defaultLoadGroupId: defaultLoadGroupId,
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
                            loadonce: false,
                            viewrecords: true,
                            styleUI: 'Bootstrap',
                            multiboxonly: !multi,
                            multiselect: true,
                            autowidth: true,
                            responsive: true,//开启自适应
                            onSelectRow: onSelectRow,//js方法
                            ondblClickRow: ondblClickRow, //双击事件
                            onSelectAll: onSelectAll,
                            gridComplete: function () {
                                if (selectedGroupIds) {
                                    var group = selectedGroupIds.split(';');
                                    if (selectedGroupIds.indexOf(",") > -1) {
                                        group = selectedGroupIds.split(',');
                                    }
                                    for (var o = 0; o < group.length; o++) {
                                        var id = group[o];
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
            initSelectedGroupInfo();
            initOrgSelect();
        }
    };

    function initSelectedGroupInfo() {
        $('#jqGridSelected').jqGrid({
            datatype: "local",
            colModel: dataGridColModelSelected,
            height: $(window).height() - 55,
            scrollOffset: 20, //设置垂直滚动条宽度
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
        if (selectedGroupIds) {
            var selectedGroups = [];
            avicAjax.ajax({
                url: 'h5/view/common/select/SelectController/getSelectedGroupInfo',
                type: 'post',
                async: false,
                dataType: 'json',
                data: {
                    viewScope: viewScope,
                    defaultOrgId: defaultOrgId,
                    defaultLoadGroupId: selectedGroupIds
                },
                success: function (r) {
                    if (r && r.rows) {
                        selectedGroups = r.rows;
                    }
                }
            });
            for (var i = 0, len = selectedGroups.length; i < len; i++) {
                addToSelectedGroup(selectedGroups[i].id, selectedGroups[i]);
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

    function addToSelectedGroup(rowId, rowData) {
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
        selectedGroupIds = allIds.join(';');
        resetSelectNum();
    }

    /**移除选中的群组*/
    function removeFromSelectedGroup(rowId) {
        $("#jqGridSelected").delRowData(rowId);
        var allIds = $("#jqGridSelected").getDataIDs();
        selectedGroupIds = allIds.join(';');
    }

    /**移除选中的群组并将左侧checkbox取消选中*/
    function deleteSelectedCascade(rowId) {
        $("#jqGridSelected").delRowData(rowId);
        var allIds = $("#jqGridSelected").getDataIDs();
        selectedGroupIds = allIds.join(';');
        $("#jqGrid").setSelection(rowId, false);
        resetSelectNum();
    }

    function formatTitle(cellvalue, options, rowObject) {
        var groupDescElem = '';
        if (rowObject.groupDesc) {
            groupDescElem = '<i class="icon icon-info title-desc" title="' + rowObject.groupDesc + '"></i>';
        } else {
            groupDescElem = '<i class="icon icon-info title-desc" title="暂无描述"></i>';
        }
        return '<span title="" style="width: 360px;"><span class="group-group-name">' + rowObject.groupName + '</span>' + groupDescElem + '</span>';
    }

    function formatTitleSelected(cellvalue, options, rowObject) {
        var groupDescElem = '';
        if (rowObject.groupDesc) {
            groupDescElem = '<i class="icon icon-info title-desc" title="' + rowObject.groupDesc + '"></i>';
        } else {
            groupDescElem = '<i class="icon icon-info title-desc" title="暂无描述"></i>';
        }
        return '<span title="" style="width: 360px;"><span class="group-group-name">' + rowObject.groupName + '</span><em class="orgSelect org-name">(' + rowObject.orgIdentityName + ')</em>' + groupDescElem + '</span>';
    }

    function formatOp(cellvalue, options, rowObject) {
        return '<span class="icon icon-drag" aria-hidden="true" title="移动"></span><span class="icon icon-close" aria-hidden="true" title="移除" onclick="deleteSelectedCascade(\'' + rowObject.id + '\');"></span>';
    }

    function ondblClickRow(rowId, iRow, iCol) {
        if (!multi) {
            var ret = {};
            var rowData = $("#jqGrid").jqGrid('getRowData', rowId);
            ret.groupids = rowData.id;
            ret.groupNames = rowData.groupName;
            ret.orgIdentity = rowData.orgIdentity;
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

    //验证单选
    function onSelectRow(rowid, status) {
        if (multi) {
            var rowData = $("#jqGrid").jqGrid('getRowData', rowid);
            if (status) {
                addToSelectedGroup(rowid, rowData);
            } else {
                removeFromSelectedGroup(rowid);
            }
        } else {
            var rowData = $("#jqGrid").jqGrid('getRowData', rowid);
            var selectIds = $("#jqGridSelected").getDataIDs();
            if (selectIds && selectIds.length) {
                for (var i = selectIds.length - 1; i >= 0; i--) {
                    removeFromSelectedGroup(selectIds[i]);
                }
            }
            addToSelectedGroup(rowid, rowData);
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
                        addToSelectedGroup(rowid, rowData);
                    }
                } else {
                    removeFromSelectedGroup(rowid);
                }
            }
        }
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
                defaultLoadGroupId: selectedGroupIds
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
            width: '150px',
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
        })
    }

    //关键字段查询
    function onSeach() {
        var searchdata = {search_text: $('#keyWord').val() == $('#keyWord').attr("placeholder") ? "" : $('#keyWord').val()};
        $('#jqGrid').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
    };
    //查询按钮绑定事件
    $('#Group_searchPart').bind('click', function () {
        onSeach();
    });

    //回填数据
    function getGroupList() {
        var groupids = "";
        var groupNames = "";
        var orgIdentitys = ""
        var rowdatas = [];
        var groupidlist = $("#jqGridSelected").getDataIDs();
        for (var i = 0; i < groupidlist.length; i++) {
            var id = groupidlist[i];
            var rowData = $("#jqGridSelected").jqGrid('getRowData', id);
            rowdatas.push(rowData);
            groupids = groupids + rowData.id + ";";
            groupNames = groupNames + rowData.groupName + ";";
            orgIdentitys = orgIdentitys + rowData.orgIdentity + ";";
        }
        groupids = groupids.substring(0, groupids.length - 1);
        groupNames = groupNames.substring(0, groupNames.length - 1);
        orgIdentitys = orgIdentitys.substring(0, orgIdentitys.length - 1);

        return {
            groupids: groupids,
            groupNames: groupNames,
            orgIdentitys: orgIdentitys,
            rowdatas: rowdatas
        };
    };

    //重载
    function reLoad() {
        var searchdata = {orgId: orgId, appId: appId, appSelectType: appSelectType};
        $('#jqGrid').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
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
            var elemDiv = '<div class="unselected-div"><img src="static/h5/common-ext/userUnselected.png" /><span class="unselected-div-title">暂未选择群组</span></div>';
            $('#gview_jqGridSelected .ui-jqgrid-bdiv').append(elemDiv);
        }
        $("#selectedPanelTitle").text("(" + selectCnt + ")");
    }

    $(document).ready(function () {
        // $('#orgAlias').on('focus', function (e) {
        //     new H5CommonPopSelect({
        //         idFiled: 'orgid',
        //         textFiled: 'orgAlias',
        //         divid: 'orgselect',
        //         type: 'orgSelect',
        //         viewScope: viewScope,
        //         defaultOrgId: defaultOrgId,
        //         contentWidth: '300',
        //         callBack: function (datas) {
        //             return reLoad(datas);
        //         }
        //     });
        //     this.blur();
        //     nullInput(e);
        // });

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
