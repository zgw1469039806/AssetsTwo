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
    <!-- ControllerPath = "assets/device/assetstdevicecomponent/assetsTdeviceComponentController/toAssetsTdeviceComponentManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceComponent_button_add"
                               permissionDes="添加">
            <a id="assetsTdeviceComponent_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceComponent_button_del"
                               permissionDes="删除">
            <a id="assetsTdeviceComponent_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceComponent_button_save"
                               permissionDes="保存">
            <a id="assetsTdeviceComponent_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceComponent_button_edit"
                               permissionDes="编辑">
            <a id="assetsTdeviceComponent_edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsTdeviceComponent_keyWord" id="assetsTdeviceComponent_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsTdeviceComponent_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsTdeviceComponent_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
               role="button">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsTdeviceComponentjqGrid"></table>
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
                <th width="10%">组件型号:</th>
                <td width="15%">
                    <input title="组件型号" class="form-control input-sm" type="text" name="componentModel"
                           id="componentModel"/>
                </td>
                <th width="10%">组件编号:</th>
                <td width="15%">
                    <input title="组件编号" class="form-control input-sm" type="text" name="componentNum"
                           id="componentNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">组件名称:</th>
                <td width="15%">
                    <input title="组件名称" class="form-control input-sm" type="text" name="componentName"
                           id="componentName"/>
                </td>
                <th width="10%">厂家名称:</th>
                <td width="15%">
                    <input title="厂家名称" class="form-control input-sm" type="text" name="componentManufacturer"
                           id="componentManufacturer"/>
                </td>
                <th width="10%">安装槽位:</th>
                <td width="15%">
                    <input title="安装槽位" class="form-control input-sm" type="text" name="componentInstallPosition"
                           id="componentInstallPosition"/>
                </td>
                <th width="10%">驱动ID:</th>
                <td width="15%">
                    <input title="驱动ID" class="form-control input-sm" type="text" name="componentDriverId"
                           id="componentDriverId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">驱动版本:</th>
                <td width="15%">
                    <input title="驱动版本" class="form-control input-sm" type="text" name="componentDriverVersion"
                           id="componentDriverVersion"/>
                </td>
                <th width="10%">逻辑ID:</th>
                <td width="15%">
                    <input title="逻辑ID" class="form-control input-sm" type="text" name="componentLogicId"
                           id="componentLogicId"/>
                </td>
                <th width="10%">逻辑版本:</th>
                <td width="15%">
                    <input title="逻辑版本" class="form-control input-sm" type="text" name="componentLogicVersion"
                           id="componentLogicVersion"/>
                </td>
                <th width="10%">组件资料:</th>
                <td width="15%">
                    <input title="组件资料" class="form-control input-sm" type="text" name="componentDocument"
                           id="componentDocument"/>
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
<script src="avicit/assets/device/assetstdevicecomponent/js/AssetsTdeviceComponent.js" type="text/javascript"></script>
<script type="text/javascript">
    //获取后台传递的统一编号
    unifiedId = ${unifiedId};

    //后台获取的通用代码数据
    var assetsTdeviceComponent;
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>设备名称', name: 'deviceName', width: 150, editable: true}
            , {label: '组件型号', name: 'componentModel', width: 150, editable: true}
            , {label: '组件编号', name: 'componentNum', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>组件名称', name: 'componentName', width: 150, editable: true}
            , {label: '厂家名称', name: 'componentManufacturer', width: 150, editable: true}
            , {label: '安装槽位', name: 'componentInstallPosition', width: 150, editable: true}
            , {label: '驱动ID', name: 'componentDriverId', width: 150, editable: true}
            , {label: '驱动版本', name: 'componentDriverVersion', width: 150, editable: true}
            , {label: '逻辑ID', name: 'componentLogicId', width: 150, editable: true}
            , {label: '逻辑版本', name: 'componentLogicVersion', width: 150, editable: true}
            , {label: '组件资料', name: 'componentDocument', width: 150, editable: true}
            , {label: '备注', name: 'remarks', width: 150, editable: true}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        searchNames.push("deviceName");
        searchTips.push("设备名称");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsTdeviceComponent_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsTdeviceComponent = new AssetsTdeviceComponent('assetsTdeviceComponentjqGrid', '${url}', 'searchDialog', 'form', 'assetsTdeviceComponent_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsTdeviceComponent_insert').bind('click', function () {
            assetsTdeviceComponent.insert();
        });
        //删除按钮绑定事件
        $('#assetsTdeviceComponent_del').bind('click', function () {
            assetsTdeviceComponent.del();
        });
        //保存按钮绑定事件
        $('#assetsTdeviceComponent_save').bind('click', function () {
            assetsTdeviceComponent.save();
        });
        //编辑按钮绑定事件
        $('#assetsTdeviceComponent_edit').bind('click', function () {
            assetsTdeviceComponent.edit();
        });
        //查询按钮绑定事件
        $('#assetsTdeviceComponent_searchPart').bind('click', function () {
            assetsTdeviceComponent.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsTdeviceComponent_searchAll').bind('click', function () {
            assetsTdeviceComponent.openSearchForm(this);
        });
        //回车键查询
        $('#assetsTdeviceComponent_keyWord').on('keydown', function (e) {
            if (e.keyCode == 13) {
                assetsTdeviceComponent.searchByKeyWord();
            }
        });

        //给子表搜索框赋值（统一编号）
        $("#assetsTdeviceComponent_keyWord").val(unifiedId);

    });
</script>
</html>