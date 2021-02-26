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
    <title>岗位选择</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/select2/select2.css" />
    <link rel="stylesheet" type="text/css" href="avicit/platform6/h5component/common/commonselect.css"/>
</head>
<body class=" easyui-layout" fit="true">
<div data-options="region:'west', width: fixwidth(.5),onResize:function(a){$('#jqGrid').setGridWidth(a);$(window).trigger('resize');}"
     style="overflow-y: hidden; padding: 0 14px;">
    <div id="tableToolbar" class="toolbar">
        <div class="toolbar-right">
            <div class="input-group form-tool-search">
                <input type="text" name="keyWord" id="keyWord"
                       class="form-control input-sm" placeholder="请输入岗位名称查询" /> <label
                    id="demoSingle_searchPart"
                    class="icon icon-search form-tool-searchicon"></label>
            </div>
        </div>
        <div class="toolbar-left">
            <table>
                <tr>
                    <td >
                        <select class="org-select2" style="width: 150px;" >
                        </select>
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
        <div class="toolbar-left selected-check-all" >
            <input type="checkbox" id="selectedCheckAll" title="全选"/>
            <span id="selectedCheckboxTitle" class="role-checkbox-title">已选岗位</span>
            <span id="selectedPanelTitle" class="selected-panel-title"></span>
        </div>
        <div class="toolbar-right position-delete-all">
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
    var prositionName = null;
    var prositionid = null;
    var orgIdentity = null;
    var callBack = null;
    var viewScope = null;
    var defaultOrgId = null;
    var setPropertys = null;
    var defaultLoadPositionId = null;
    var selectedPositionIds = null;
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
        label: '岗位名称',
        name: 'positionName',
        width: 150,
        hidden: true
    }, {
        label: '岗位编码',
        name: 'positionCode',
        width: 150,
        hidden: true
    }, {
        label: '岗位描述',
        name: 'positionDesc',
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
        label: '岗位名称',
        name: 'positionName',
        width: 150,
        hidden: true
    }, {
        label: '岗位编码',
        name: 'positionCode',
        width: 150,
        hidden: true
    }, {
        label: '岗位描述',
        name: 'positionDesc',
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
    }, {
        label: '组织应用ID',
        name: 'orgIdentityName',
        width: 150,
        hidden: true
    }];
    var multi = false;

    //初始化表格参数
    function init(o) {
        viewScope = o.viewScope;
        defaultOrgId = o.defaultOrgId;
        defaultLoadPositionId = o.defaultLoadPositionId;
        selectModel = o.selectModel;
        selectedPositionIds = o.positionids;
        prositionid = o.prositionid;
        prositionName = o.prositionName;
        orgIdentity = o.orgIdentity;
        callBack = o.callBack;
        setPropertys = o.setPropertys;
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
                            url: 'h5/view/common/select/SelectController/getInitPositionInfo',
                            mtype: 'POST',
                            datatype: "json",
                            postData: {
                                viewScope: 'currentOrg',
                                defaultOrgId: defaultOrgId,
                                defaultLoadPositionId: defaultLoadPositionId
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
                                if (selectedPositionIds) {
                                    var pos = selectedPositionIds.split(';');
                                    if (selectedPositionIds.indexOf(",") > -1) {
                                        pos = selectedPositionIds.split(',');
                                    }

                                    for (var o = 0; o < pos.length; o++) {
                                        var id = pos[o];
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
            initSelectedPositionInfo();
            initOrgSelect();
        }
    };
    
    function initSelectedPositionInfo() {
        $('#jqGridSelected').jqGrid({
            datatype: "local",
            colModel: dataGridColModelSelected,
            height: $(window).height() - 55,
            scrollOffset: 20, //设置垂直滚动条宽度
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
        if(selectedPositionIds) {
            var selectedPositions = [];
            avicAjax.ajax({
                url: 'h5/view/common/select/SelectController/getSelectedPositionInfo',
                type: 'post',
                async: false,
                dataType: 'json',
                data: {
                    viewScope: viewScope,
                    defaultOrgId: defaultOrgId,
                    defaultLoadPositionId: selectedPositionIds
                },
                success: function (r) {
                    if(r && r.rows){
                        selectedPositions = r.rows;
                    }
                }
            });
            for (var i = 0, len = selectedPositions.length; i < len; i++) {
                addToSelectedPosition(selectedPositions[i].id, selectedPositions[i]);
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
            if(checkStatus) {
                for (var i = allIds.length-1; i >= 0; i--) {
                    if($.inArray(allIds[i], selIds) == -1) {
                        $("#jqGridSelected").setSelection(allIds[i], true);
                    }
                }
            } else {
                for (var i = selIds.length-1; i >= 0; i--) {
                    $("#jqGridSelected").setSelection(selIds[i], true);
                }
            }

        });
        $('#selectedDeleteAll').bind('click', function () {
            removeAllSelect();
            $('#selectedCheckAll').attr("checked",false);
        });
    }

    function addToSelectedPosition(rowId, rowData) {
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
        selectedPositionIds = allIds.join(';');
        resetSelectNum();
    }
    /**移除选中的岗位*/
    function removeFromSelectedPosition(rowId){
        $("#jqGridSelected").delRowData(rowId);
        var allIds = $("#jqGridSelected").getDataIDs();
        selectedPositionIds = allIds.join(';');
    }

    /**移除选中的岗位并将左侧checkbox取消选中*/
    function deleteSelectedCascade(rowId){
        $("#jqGridSelected").delRowData(rowId);
        var allIds = $("#jqGridSelected").getDataIDs();
        selectedPositionIds = allIds.join(';');
        $("#jqGrid").setSelection(rowId, false);
        resetSelectNum();
    }

    function formatTitle(cellvalue, options, rowObject) {
        var positionDescElem = '';
        if (rowObject.positionDesc) {
            positionDescElem = '<i class="icon icon-info title-desc" title="' + rowObject.positionDesc + '"></i>';
        } else {
            positionDescElem = '<i class="icon icon-info title-desc" title="暂无描述"></i>';
        }
        return '<span title="" style="width: 360px;"><span class="position-position-name">' + rowObject.positionName + '</span>' + positionDescElem + '</span>';
    }
    function formatTitleSelected(cellvalue, options, rowObject) {
        var positionDescElem = '';
        if (rowObject.positionDesc) {
            positionDescElem = '<i class="icon icon-info title-desc" title="' + rowObject.positionDesc + '"></i>';
        } else {
            positionDescElem = '<i class="icon icon-info title-desc" title="暂无描述"></i>';
        }
        return '<span title="" style="width: 360px;"><span class="position-position-name">' + rowObject.positionName + '</span><em class="orgSelect org-name">(' + rowObject.orgIdentityName + ')</em>' + positionDescElem + '</span>';
    }

    function formatOp(cellvalue, options, rowObject) {
        return '<span class="icon icon-drag" aria-hidden="true" title="移动"></span><span class="icon icon-close" aria-hidden="true" title="移除" onclick="deleteSelectedCascade(\'' + rowObject.id + '\');"></span>';
    }

    //验证单选
    function onSelectRow(rowid, status) {
        if (multi) {
            var rowData = $("#jqGrid").jqGrid('getRowData', rowid);
            if (status) {
                addToSelectedPosition(rowid, rowData);
            } else {
                removeFromSelectedPosition(rowid);
            }
        } else {
            var rowData = $("#jqGrid").jqGrid('getRowData', rowid);
            var selectIds = $("#jqGridSelected").getDataIDs();
            if (selectIds && selectIds.length) {
                for (var i = selectIds.length - 1; i >= 0; i--) {
                    removeFromSelectedPosition(selectIds[i]);
                }
            }
            addToSelectedPosition(rowid, rowData);
            $("#jqGridSelected").setSelection(rowid, true);
        }
    }

    function ondblClickRow(rowId, iRow, iCol) {
        if (!multi) {
            var ret = {};
            var rowData = $("#jqGrid").jqGrid('getRowData', rowId);
            ret.positionids = rowData.id;
            ret.positionNames = rowData.positionName;
            ret.orgIdentity = rowData.orgIdentity;
            ret.rowdatas = [rowData];
            setPropertys(ret);
            if(callBack!=null && callBack!='undefined'){
                if(typeof(callBack) === 'function'){
                    callBack(ret);
                }
            }
            var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
            parent.layer.close(index);
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
                        addToSelectedPosition(rowid, rowData);
                    }
                } else {
                    removeFromSelectedPosition(rowid);
                }
            }
        }
    }

    //关键字段查询
    function onSeach() {
        var searchdata = {search_text: $('#keyWord').val() == $('#keyWord').attr("placeholder") ? "" : $('#keyWord').val()};
        $('#jqGrid').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
    };
    //查询按钮绑定事件
    $('#demoSingle_searchPart').bind('click', function () {
        onSeach();
    });

    //回填数据
    function getPositionList() {
        var positionids = "";
        var positionNames = "";
        var orgIdentitys = ""
        var rowdatas = [];
        var positionidlist = $("#jqGridSelected").getDataIDs();
        for (var i = 0; i < positionidlist.length; i++) {
            var id = positionidlist[i];
            var rowData = $("#jqGridSelected").jqGrid('getRowData', id);
            rowdatas.push(rowData);
            positionids = positionids + rowData.id + ";";
            positionNames = positionNames + rowData.positionName + ";";
            orgIdentitys = orgIdentitys + rowData.orgIdentity + ";";
        }
        positionids = positionids.substring(0, positionids.length - 1);
        positionNames = positionNames.substring(0, positionNames.length - 1);
        orgIdentitys = orgIdentitys.substring(0, orgIdentitys.length - 1);
        return {
            positionids: positionids,
            positionNames: positionNames,
            orgIdentitys: orgIdentitys,
            rowdatas: rowdatas
        };
    };

    //重载
    function reLoad(orgId) {
        var searchdata = {orgId: orgId};
        $('#jqGrid').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
    }

    //回调函数
    function searchOrgByOrgId(datas) {

        reLoad(datas.id);
    }

    function initOrgSelect(){
        var data = [];
        avicAjax.ajax({
            url: 'h5/view/common/select/SelectController/selectOrgName',
            type: 'post',
            async: false,
            dataType: 'json',
            data: {
                viewScope: viewScope,
                defaultOrgId: defaultOrgId,
                defaultLoadPositionId: selectedPositionIds
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
            if($('#orgid').val() != newOrgId){
                reLoad(newOrgId);
                $('#orgid').val(newOrgId);
                $.each(data, function (index, elem) {
                    if(newOrgId === elem.id){
                        $('#orgAlias').val(elem.orgName);
                        return false;
                    }
                });
            }
        })
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
            var elemDiv = '<div class="unselected-div"><img src="static/h5/common-ext/userUnselected.png" /><span class="unselected-div-title">暂未选择岗位</span></div>';
            $('#gview_jqGridSelected .ui-jqgrid-bdiv').append(elemDiv);
        }
        $("#selectedPanelTitle").text("(" + selectCnt + ")");
    }


    $(document).ready(function () {

        $('.input-group-addon-icon').on('click',function(e){
            $(this).parent().find('input[type="text"]').trigger('focus');
        });
    });
</script>
</body>
</html>
