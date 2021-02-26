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
    <!-- ControllerPath = "assets/device/assetsdevicecomponent/assetsDeviceComponentController/toAssetsDeviceComponentManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceComponent_button_add"
                               permissionDes="添加">
            <a id="assetsDeviceComponent_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceComponent_button_del"
                               permissionDes="删除">
            <a id="assetsDeviceComponent_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceComponent_button_save"
                               permissionDes="保存">
            <a id="assetsDeviceComponent_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceComponent_button_edit"
                               permissionDes="编辑">
            <a id="assetsDeviceComponent_edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsDeviceComponent_keyWord" id="assetsDeviceComponent_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsDeviceComponent_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsDeviceComponent_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
               role="button">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsDeviceComponentjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">主设备统一编号:</th>
                <td width="15%">
                    <input title="主设备统一编号" class="form-control input-sm" type="text" name="parentUnifiedId"
                           id="parentUnifiedId"/>
                </td>
                <th width="10%">随机备件名称:</th>
                <td width="15%">
                    <input title="随机备件名称" class="form-control input-sm" type="text" name="componentName"
                           id="componentName"/>
                </td>
                <th width="10%">随机备件类别:</th>
                <td width="15%">
                    <input title="随机备件类别" class="form-control input-sm" type="text" name="componentCategory"
                           id="componentCategory"/>
                </td>
                <th width="10%">随机备件型号:</th>
                <td width="15%">
                    <input title="随机备件型号" class="form-control input-sm" type="text" name="componentModel"
                           id="componentModel"/>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/assetsdevicecomponent/js/AssetsDeviceComponent.js" type="text/javascript"></script>
<script type="text/javascript">
    //获取后台传递的统一编号
    unifiedId = ${unifiedId};

    //后台获取的通用代码数据
    var assetsDeviceComponent;
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '<span style="color:red;">*</span>主设备统一编号', name: 'parentUnifiedId', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>随机备件名称', name: 'componentName', width: 150, editable: true}
            , {label: '随机备件类别', name: 'componentCategory', width: 150, editable: true}
            , {label: '随机备件型号', name: 'componentModel', width: 150, editable: true}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("parentUnifiedId");
        searchTips.push("主设备统一编号");
        searchNames.push("componentName");
        searchTips.push("随机备件名称");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsDeviceComponent_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsDeviceComponent = new AssetsDeviceComponent('assetsDeviceComponentjqGrid', '${url}', 'searchDialog', 'form', 'assetsDeviceComponent_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsDeviceComponent_insert').bind('click', function () {
            assetsDeviceComponent.insert();
        });
        //删除按钮绑定事件
        $('#assetsDeviceComponent_del').bind('click', function () {
            assetsDeviceComponent.del();
        });
        //保存按钮绑定事件
        $('#assetsDeviceComponent_save').bind('click', function () {
            assetsDeviceComponent.save();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceComponent_edit').bind('click', function () {
            assetsDeviceComponent.edit();
        });
        //查询按钮绑定事件
        $('#assetsDeviceComponent_searchPart').bind('click', function () {
            assetsDeviceComponent.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsDeviceComponent_searchAll').bind('click', function () {
            assetsDeviceComponent.openSearchForm(this);
        });
        //回车键查询
        $('#assetsDeviceComponent_keyWord').on('keydown', function (e) {
            if (e.keyCode == 13) {
                assetsDeviceComponent.searchByKeyWord();
            }
        });


        //给子表搜索框赋值（统一编号）
        $("#assetsDeviceComponent_keyWord").val(unifiedId);


    });
</script>
</html>