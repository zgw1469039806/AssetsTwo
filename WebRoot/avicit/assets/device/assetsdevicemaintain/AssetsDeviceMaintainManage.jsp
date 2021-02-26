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
    <!-- ControllerPath = "assets/device/assetsdevicemaintain/assetsDeviceMaintainController/toAssetsDeviceMaintainManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<style>
    /*.ui-jqgrid-bdiv {*/
        /*height: 30%!important;*/
    /*}*/
</style>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMaintain_button_add"
                               permissionDes="添加">
            <a id="assetsDeviceMaintain_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMaintain_button_del"
                               permissionDes="删除">
            <a id="assetsDeviceMaintain_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMaintain_button_save"
                               permissionDes="保存">
            <a id="assetsDeviceMaintain_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceMaintain_button_edit"
                               permissionDes="编辑">
            <a id="assetsDeviceMaintain_edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsDeviceMaintain_keyWord" id="assetsDeviceMaintain_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsDeviceMaintain_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsDeviceMaintain_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
               role="button">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsDeviceMaintainjqGrid"></table>
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
            </tr>
            <tr>
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
                <th width="10%">安装地点ID:</th>
                <td width="15%">
                    <input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">保养部位:</th>
                <td width="15%">
                    <input title="保养部位" class="form-control input-sm" type="text" name="maintainPosition"
                           id="maintainPosition"/>
                </td>
                <th width="10%">保养内容:</th>
                <td width="15%">
                    <input title="保养内容" class="form-control input-sm" type="text" name="maintainContent"
                           id="maintainContent"/>
                </td>
            </tr>
            <tr>
                <th width="10%">保养项目:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="maintainItem" id="maintainItem" title="保养项目"
                                  isNull="true" lookupCode="MAINTAIN_ITEM"/>
                </td>
                <th width="10%">保养方式:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="maintainMode" id="maintainMode" title="保养方式"
                                  isNull="true" lookupCode="MAINTAIN_MODE"/>
                </td>
                <th width="10%">保养周期:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="maintainCycle" id="maintainCycle"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">上次保养时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMaintainDateBegin"
                               id="lastMaintainDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">上次保养时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMaintainDateEnd"
                               id="lastMaintainDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">下次保养时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMaintainDateBegin"
                               id="nextMaintainDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">下次保养时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMaintainDateEnd"
                               id="nextMaintainDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/assetsdevicemaintain/js/AssetsDeviceMaintain.js" type="text/javascript"></script>
<script type="text/javascript">
    //获取后台传递的统一编号
    unifiedId = ${unifiedId};
    //后台获取的通用代码数据
    var deviceCategoryData = ${deviceCategoryData};
    var maintainItemData = ${maintainItemData};
    var maintainModeData = ${maintainModeData};
    var assetsDeviceMaintain;
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150, editable: true}
            , {label: '设备名称', name: 'deviceName', width: 150, editable: true}
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
            , {label: '安装地点ID', name: 'positionId', width: 150, editable: true}
            , {label: '保养部位', name: 'maintainPosition', width: 150, editable: true}
            , {label: '保养内容', name: 'maintainContent', width: 150, editable: true}
            , {label: '保养项目id', name: 'maintainItem', width: 75, hidden: true}
            , {
                label: '保养项目',
                name: 'maintainItemName',
                width: 150,
                editable: true,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem1,
                    custom_value: selectValue1,
                    forId: 'maintainItem',
                    value: maintainItemData
                }
            }
            , {label: '保养方式id', name: 'maintainMode', width: 75, hidden: true}
            , {
                label: '保养方式',
                name: 'maintainModeName',
                width: 150,
                editable: true,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem1,
                    custom_value: selectValue1,
                    forId: 'maintainMode',
                    value: maintainModeData
                }
            }
            , {
                label: '保养周期',
                name: 'maintainCycle',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {
                    custom_element: spinnerElem,
                    custom_value: spinnerValue,
                    min: -<%=Math.pow(10,12)-Math.pow(10,-0)%>,
                    max:<%=Math.pow(10,12)-Math.pow(10,-0)%>,
                    step: 1,
                    precision: 0
                }
            }
            , {
                label: '上次保养时间',
                name: 'lastMaintainDate',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {
                label: '下次保养时间',
                name: 'nextMaintainDate',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        searchNames.push("deviceName");
        searchTips.push("设备名称");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsDeviceMaintain_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsDeviceMaintain = new AssetsDeviceMaintain('assetsDeviceMaintainjqGrid', '${url}', 'searchDialog', 'form', 'assetsDeviceMaintain_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsDeviceMaintain_insert').bind('click', function () {
            assetsDeviceMaintain.insert();
        });
        //删除按钮绑定事件
        $('#assetsDeviceMaintain_del').bind('click', function () {
            assetsDeviceMaintain.del();
        });
        //保存按钮绑定事件
        $('#assetsDeviceMaintain_save').bind('click', function () {
            assetsDeviceMaintain.save();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceMaintain_edit').bind('click', function () {
            assetsDeviceMaintain.edit();
        });
        //查询按钮绑定事件
        $('#assetsDeviceMaintain_searchPart').bind('click', function () {
            assetsDeviceMaintain.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsDeviceMaintain_searchAll').bind('click', function () {
            assetsDeviceMaintain.openSearchForm(this);
        });
        //回车键查询
        $('#assetsDeviceMaintain_keyWord').on('keydown', function (e) {
            if (e.keyCode == 13) {
                assetsDeviceMaintain.searchByKeyWord();
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
        $("#assetsDeviceMaintain_keyWord").val(unifiedId);

    });
</script>
<%@include file="/static/js/assets/ContextMenu.jsp"%>
<script  src="static/js/assets/ContextMenu_jquery.js" type="text/javascript"></script>
<script  src="static/js/assets/ContextMenu.js" type="text/javascript"></script>
</html>