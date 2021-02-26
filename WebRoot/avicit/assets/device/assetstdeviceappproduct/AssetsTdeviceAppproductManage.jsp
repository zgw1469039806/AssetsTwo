<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetstdeviceappproduct/assetsTdeviceAppproductController/toAssetsTdeviceAppproductManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceAppproduct_button_add"
                               permissionDes="添加">
            <a id="assetsTdeviceAppproduct_insert" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceAppproduct_button_del"
                               permissionDes="删除">
            <a id="assetsTdeviceAppproduct_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceAppproduct_button_save"
                               permissionDes="保存">
            <a id="assetsTdeviceAppproduct_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceAppproduct_button_edit"
                               permissionDes="编辑">
            <a id="assetsTdeviceAppproduct_edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsTdeviceAppproduct_keyWord" id="assetsTdeviceAppproduct_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsTdeviceAppproduct_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsTdeviceAppproduct_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
               role="button">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsTdeviceAppproductjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
                <th width="10%">适用产品机型:</th>
                <td width="15%">
                    <input title="适用产品机型" class="form-control input-sm" type="text" name="planeModel" id="planeModel"/>
                </td>
                <th width="10%">适用产品专业:</th>
                <td width="15%">
                    <input title="适用产品专业" class="form-control input-sm" type="text" name="majorType" id="majorType"/>
                </td>
            </tr>
            <tr>
                <th width="10%">适用产品名称:</th>
                <td width="15%">
                    <input title="适用产品名称" class="form-control input-sm" type="text" name="productName"
                           id="productName"/>
                </td>
                <th width="10%">适用产品型号:</th>
                <td width="15%">
                    <input title="适用产品型号" class="form-control input-sm" type="text" name="productModel"
                           id="productModel"/>
                </td>
                <th width="10%">软件配置项名称:</th>
                <td width="15%">
                    <input title="软件配置项名称" class="form-control input-sm" type="text" name="productSoftwareName"
                           id="productSoftwareName"/>
                </td>
                <th width="10%">软件配置项标识:</th>
                <td width="15%">
                    <input title="软件配置项标识" class="form-control input-sm" type="text" name="productSoftwareId"
                           id="productSoftwareId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">备注:</th>
                <td width="15%">
                    <input title="备注" class="form-control input-sm" type="text" name="remarks" id="remarks"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/assetstdeviceappproduct/js/AssetsTdeviceAppproduct.js"
        type="text/javascript"></script>
<script type="text/javascript">
    //获取后台传递的统一编号
    unifiedId = ${unifiedId};

    //后台获取的通用代码数据
    var assetsTdeviceAppproduct;
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>设备名称', name: 'deviceName', width: 150, editable: true}
            , {label: '适用产品机型', name: 'planeModel', width: 150, editable: true}
            , {label: '适用产品专业', name: 'majorType', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>适用产品名称', name: 'productName', width: 150, editable: true}
            , {label: '适用产品型号', name: 'productModel', width: 150, editable: true}
            , {label: '软件配置项名称', name: 'productSoftwareName', width: 150, editable: true}
            , {label: '软件配置项标识', name: 'productSoftwareId', width: 150, editable: true}
            , {label: '备注', name: 'remarks', width: 150, editable: true}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        searchNames.push("deviceName");
        searchTips.push("设备名称");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsTdeviceAppproduct_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsTdeviceAppproduct = new AssetsTdeviceAppproduct('assetsTdeviceAppproductjqGrid', '${url}', 'searchDialog', 'form', 'assetsTdeviceAppproduct_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsTdeviceAppproduct_insert').bind('click', function () {
            assetsTdeviceAppproduct.insert();
        });
        //删除按钮绑定事件
        $('#assetsTdeviceAppproduct_del').bind('click', function () {
            assetsTdeviceAppproduct.del();
        });
        //保存按钮绑定事件
        $('#assetsTdeviceAppproduct_save').bind('click', function () {
            assetsTdeviceAppproduct.save();
        });
        //保存按钮绑定事件
        $('#assetsTdeviceAppproduct_edit').bind('click', function () {
            assetsTdeviceAppproduct.edit();
        });
        //查询按钮绑定事件
        $('#assetsTdeviceAppproduct_searchPart').bind('click', function () {
            assetsTdeviceAppproduct.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsTdeviceAppproduct_searchAll').bind('click', function () {
            assetsTdeviceAppproduct.openSearchForm(this);
        });
        //回车键查询
        $('#assetsTdeviceAppproduct_keyWord').on('keydown', function (e) {
            if (e.keyCode == 13) {
                assetsTdeviceAppproduct.searchByKeyWord();
            }
        });

        //给子表搜索框赋值（统一编号）
        $("#assetsTdeviceAppproduct_keyWord").val(unifiedId);


    });
</script>
</html>