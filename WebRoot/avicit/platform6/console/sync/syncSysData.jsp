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
    <title>数据同步</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <table class="form_commonTable">
        <tr>
            <th width="150" style="word-break: break-all; word-warp: break-word;">
                <label>同步数据源：</label>
            </th>
            <td width="90%">
                <input type="hidden" id="datasource_id" name="datasource_id">
                <input type="text" id="datasource_name" name="datasource_name" class="form-control" readonly
                       placeholder="请选择数据源">
            </td>
        </tr>

        <tr>
            <th width="150" style="word-break: break-all; word-warp: break-word;">
                <label>同步类型：</label>
            </th>
            <td width="90%">
                <select class="form-control input-sm" id="syncType" name="syncType">
                    <option value="0" selected disabled>请选择</option>
                    <option value="sys">系统数据</option>
                    <option value="eform">表单数据</option>
                    <option value="view">视图数据</option>
                    <option value="bpm">流程数据</option>
                </select>
            </td>
        </tr>

        <tr>
            <th width="150" style="word-break: break-all; word-warp: break-word;">
                <label>同步数据：</label>
            </th>
            <td width="90%">
                <div id="syncOptionDiv"></div>
            </td>
        </tr>
    </table>
</div>

<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
                    <a href="javascript:" style="margin-right:10px;" class="btn btn-primary form-tool-btn btn-sm btn-point"
                       role="button" title="同步数据" id="doSyncData"><i class="icon icon-daochu"></i>同步数据</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script src="avicit/platform6/console/sync/selectDSConnect/selectDSConnect.js"
        type="text/javascript"></script>
<script src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"
        type="text/javascript"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/workhand/js/BpmModuleSelect.js"
        type="text/javascript"></script>
<script type="text/javascript">
    /**
     * 验证是否为空
     * @param value
     */
    function isBlank(value) {
        if (value == null || value == undefined) {
            return true;
        }

        var regExp = /[\S+]/i;
        if (regExp.test(value)) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 表单序列化转换json
     * @param form
     */
    function serializeFormJson(form) {
        var serializeObj = {};

        var array = $(form).serializeArray();
        $(array).each(function () {
            if (serializeObj[this.name]) {
                if ($.isArray(serializeObj[this.name])) {
                    serializeObj[this.name].push(this.value);
                } else {
                    serializeObj[this.name] = [serializeObj[this.name], this.value];
                }
            } else {
                serializeObj[this.name] = this.value;
            }
        });

        //return JSON.stringify(serializeObj);
        return serializeObj;
    }

    //同步数据源
    var selectDSConnect = new SelectDSConnect("datasource_id", "datasource_name");
    selectDSConnect.init(function (data) {
        //alert(data.id + "," + data.name);
    });

    var syncType = null;
    var sysDataTable = null;
    $("#syncType").on("change", function () {
        syncType = $(this).val();
        drawSyncOptionArea(syncType);
    });

    function drawSyncOptionArea(syncType) {
        var syncOptionDiv = $("#syncOptionDiv");
        syncOptionDiv.empty();

        //系统数据
        if (syncType == "sys") {
            sysDataTable = null;

            var area = "";
            area += "<select class='form-control input-sm' id='sysDataType' name='sysDataType'>";
            area += "    <option value='0' selected disabled>请选择</option>";
            area += "    <option value='lookupcode'>通用代码</option>";
            area += "</select>";
            area += "<div style='margin-top: 10px;'>";
            area += "    <table id='sysDataTable'></table>";
            area += "    <div id='sysDataTablePager'></div>";
            area += "</div>";
            syncOptionDiv.append(area);

            syncOptionDiv.find("#sysDataType").on("change", function () {
                syncOptionDiv.find("#sysDataTable").empty();
                syncOptionDiv.find("#sysDataTablePager").empty();

                var sysDataType = $(this).val();
                //通用代码
                if (sysDataType == 'lookupcode') {
                    var colModel = [{
                        label: 'id',
                        name: 'id',
                        key: true,
                        width: 75,
                        hidden: true
                    }, {
                        label: '代码类型',
                        name: 'lookupType',
                        width: 150
                    }, {
                        label: '代码类型名称',
                        name: 'lookupTypeName',
                        width: 150
                    }, {
                        label: '代码类型描述',
                        name: 'lookupTypeDesc',
                        width: 150
                    }, {
                        label: '是否有效',
                        name: 'validFlag',
                        width: 150,
                        edittype: "custom",
                        editoptions: {
                            custom_element: selectElem,
                            custom_value: selectValue,
                            forId: 'PLATFORM_VALID_FLAG',
                            value: {1: "有效", 0: "无效"}
                        }
                    }, {
                        label: '使用级别',
                        name: 'usageModifier',
                        width: 150
                    }];

                    sysDataTable = syncOptionDiv.find("#sysDataTable").jqGrid({
                        url: 'console/lookup/operation/getSysLookupTypesByPage.json',
                        mtype: 'POST',
                        multiselect: true,
                        datatype: "json",
                        colModel: colModel,
                        height: $(window).height() - 270,
                        scrollOffset: 10,
                        rowNum: 20,
                        rowList: [200, 100, 50, 30, 20, 10],
                        altRows: true,
                        pagerpos: 'left',
                        styleUI: 'Bootstrap',
                        hasTabExport: false,
                        hasColSet: false,
                        viewrecords: true,
                        autowidth: true,
                        responsive: true,
                        pager: "#sysDataTablePager",
                    });
                }
                //xxx
                if (sysDataType == 'xxx') {

                }
            });
        }
        //表单数据
        if (syncType == "eform") {
            syncOptionDiv.append("<input type='hidden' id='formId' name='formId'>");
            syncOptionDiv.append("<input type='text' id='formName' name='formName' class='form-control' readonly placeholder='请选择表单'>");

            var selectPublishEform = new SelectPublishEform("formId", "formName", null, "", "eform");
            selectPublishEform.init();
        }
        //视图数据
        if (syncType == "view") {
            syncOptionDiv.append("<input type='hidden' id='viewId' name='viewId'>");
            syncOptionDiv.append("<input type='text' id='viewName' name='viewName' class='form-control' readonly placeholder='请选择视图'>");

            var selectView = new SelectPublishEform("viewId", "viewName", null, "", "view");
            selectView.init();
        }
        //流程数据
        if (syncType == "bpm") {
            syncOptionDiv.append("<input type='hidden' id='bpmId' name='bpmId'>");
            syncOptionDiv.append("<input type='text' id='bpmName' name='bpmName' class='form-control' readonly placeholder='请选择流程'>");

            var bpmModuleSelect = new BpmModuleSelect("bpmId", "bpmName", function (data) {
                if (data.ids == '') {
                    layer.msg('请选择流程', {icon: 7});
                    return;
                }
                if (data.ids.indexOf(',') != -1) {
                    layer.msg('只能选择一个流程', {icon: 7});
                    return;
                }

                $("#bpmId").val(data.ids);
                $("#bpmName").val(data.texts);
            }, undefined, $("#bpmId"), $("#bpmName"), undefined, true);
        }
    }

    function getSyncData() {
        if (isBlank(syncType) || syncType == '0') {
            layer.msg('请选择同步类型', {icon: 7});
            return false;
        }

        var data = {
            syncType: syncType
        };
        //系统数据
        if (syncType === 'sys') {
            if (isBlank($("#sysDataType").val()) || $("#sysDataType").val() == '0' || sysDataTable == null) {
                layer.msg('请选择系统数据类型', {icon: 7});
                return false;
            }

            var idArray = [];
            var rows = sysDataTable.jqGrid('getGridParam', 'selarrrow');
            var i = rows.length;
            for (; i--;) {
                idArray.push(rows[i]);
            }

            if (idArray.length == 0) {
                layer.msg('请选择系统数据', {icon: 7});
                return false;
            }

            data['sysDataType'] = $("#sysDataType").val();
            data['sysDataIds'] = idArray.join(",");
        }
        //表单数据
        if (syncType === 'eform') {
            if (isBlank($("#formId").val())) {
                layer.msg('请选择表单', {icon: 7});
                return false;
            }

            data['formId'] = $("#formId").val();
        }
        //视图数据
        if (syncType === 'view') {
            if (isBlank($("#viewId").val())) {
                layer.msg('请选择视图', {icon: 7});
                return false;
            }

            data['viewId'] = $("#viewId").val();
        }
        //流程数据
        if (syncType === 'bpm') {
            if (isBlank($("#bpmId").val())) {
                layer.msg('请选择流程', {icon: 7});
                return false;
            }

            data['bpmId'] = $("#bpmId").val();
        }

        return data;
    }

    /**
     * 执行同步数据
     */
    $("#doSyncData").click(function () {
        var datasource_id = $('#datasource_id').val();
        if (isBlank(datasource_id)) {
            layer.msg('请选择数据源', {icon: 7});
            return;
        }

        var syncData = getSyncData();
        if (syncData) {
            layer.confirm('确认要同步数据吗？该操作不可撤销', {icon: 3, title: '提示'}, function (index) {
                $.ajax({
                    url: 'platform/syncController/doSyncData',
                    data: {
                        datasource_id: datasource_id,
                        syncData: JSON.stringify(syncData)
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (result) {
                        if (result.success == true) {
                            layer.msg('数据同步成功！请在被同步的系统中及时刷新全部缓存！', {icon: 1});
                        } else {
                            layer.msg(result.msg, {icon: 2});
                        }
                    }
                });

                layer.close(index);
            });
        }
    });
</script>
</body>
</html>
