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
    <!-- ControllerPath = "assets/device/assetsdevicespotcheck/assetsDeviceSpotCheckController/toAssetsDeviceSpotCheckManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceSpotCheck_button_add"
                               permissionDes="添加">
            <a id="assetsDeviceSpotCheck_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceSpotCheck_button_del"
                               permissionDes="删除">
            <a id="assetsDeviceSpotCheck_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceSpotCheck_button_save"
                               permissionDes="保存">
            <a id="assetsDeviceSpotCheck_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceSpotCheck_button_edit"
                               permissionDes="编辑">
            <a id="assetsDeviceSpotCheck_edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsDeviceSpotCheck_keyWord" id="assetsDeviceSpotCheck_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsDeviceSpotCheck_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsDeviceSpotCheck_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
               role="button">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsDeviceSpotCheckjqGrid"></table>
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
                <th width="10%">设备类别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory"
                                  title="设备类别" isNull="true" lookupCode="DEVICE_CATEGORY"/>
                </td>
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId"
                           id="manufacturerId"/>
                </td>
                <th width="10%">责任人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias"
                               name="ownerIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">责任人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               name="ownerDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">安装地点:</th>
                <td width="15%">
                    <input title="安装地点" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">点检基准书编号:</th>
                <td width="15%">
                    <input title="点检基准书编号" class="form-control input-sm" type="text" name="spotCheckNum"
                           id="spotCheckNum"/>
                </td>
                <th width="10%">点检项目:</th>
                <td width="15%">
                    <input title="点检项目" class="form-control input-sm" type="text" name="spotCheckItem"
                           id="spotCheckItem"/>
                </td>
                <th width="10%">数据项目:</th>
                <td width="15%">
                    <input title="数据项目" class="form-control input-sm" type="text" name="dataItem" id="dataItem"/>
                </td>
                <th width="10%">附件:</th>
                <td width="15%">
                    <input title="附件" class="form-control input-sm" type="text" name="attachment" id="attachment"/>
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
<script src="avicit/assets/device/assetsdevicespotcheck/js/AssetsDeviceSpotCheck.js" type="text/javascript"></script>
<script type="text/javascript">
    //获取后台传递的统一编号
    unifiedId = ${unifiedId};

    //后台获取的通用代码数据
    var deviceCategoryData = ${deviceCategoryData};
    var assetsDeviceSpotCheck;
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>设备名称', name: 'deviceName', width: 150, editable: true}
            , {label: '设备类别id', name: 'deviceCategory', width: 75, hidden: true}
            , {
                label: '设备类别',
                name: 'deviceCategoryName',
                width: 150,
                editable: true,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem1,
                    custom_value: selectValue1,
                    forId: 'deviceCategory',
                    value: deviceCategoryData
                }
            }
            , {label: '设备型号', name: 'deviceModel', width: 150, editable: true}
            , {label: '生产厂家', name: 'manufacturerId', width: 150, editable: true}
            , {
                label: '责任人',
                name: 'ownerIdAlias',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'ownerId'}
            }
            , {label: '责任人id', name: 'ownerId', width: 75, hidden: true, editable: false}
            , {
                label: '责任人部门',
                name: 'ownerDeptAlias',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'ownerDept'}
            }
            , {label: '责任人部门id', name: 'ownerDept', width: 75, hidden: true, editable: false}
            , {label: '安装地点', name: 'positionId', width: 150, editable: true}
            , {label: '点检基准书编号', name: 'spotCheckNum', width: 150, editable: true}
            , {label: '点检项目', name: 'spotCheckItem', width: 150, editable: true}
            , {label: '数据项目', name: 'dataItem', width: 150, editable: true}
            , {label: '附件', name: 'attachment', width: 150, editable: true}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        searchNames.push("deviceName");
        searchTips.push("设备名称");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsDeviceSpotCheck_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsDeviceSpotCheck = new AssetsDeviceSpotCheck('assetsDeviceSpotCheckjqGrid', '${url}', 'searchDialog', 'form', 'assetsDeviceSpotCheck_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsDeviceSpotCheck_insert').bind('click', function () {
            assetsDeviceSpotCheck.insert();
        });
        //删除按钮绑定事件
        $('#assetsDeviceSpotCheck_del').bind('click', function () {
            assetsDeviceSpotCheck.del();
        });
        //保存按钮绑定事件
        $('#assetsDeviceSpotCheck_save').bind('click', function () {
            assetsDeviceSpotCheck.save();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceSpotCheck_edit').bind('click', function () {
            assetsDeviceSpotCheck.edit();
        });
        //查询按钮绑定事件
        $('#assetsDeviceSpotCheck_searchPart').bind('click', function () {
            assetsDeviceSpotCheck.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsDeviceSpotCheck_searchAll').bind('click', function () {
            assetsDeviceSpotCheck.openSearchForm(this);
        });
        //回车键查询
        $('#assetsDeviceSpotCheck_keyWord').on('keydown', function (e) {
            if (e.keyCode == 13) {
                assetsDeviceSpotCheck.searchByKeyWord();
            }
        });
        $('#ownerIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerId', textFiled: 'ownerIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#ownerDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDept', textFiled: 'ownerDeptAlias'});
            this.blur();
            nullInput(e);
        });

        //给子表搜索框赋值（统一编号）
        $("#assetsDeviceSpotCheck_keyWord").val(unifiedId);

    });
</script>
</html>