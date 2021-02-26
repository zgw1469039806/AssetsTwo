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
    <!-- ControllerPath = "assets/device/assetsdeviceregularcheck/assetsDeviceRegularCheckController/toAssetsDeviceRegularCheckManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceRegularCheck_button_add"
                               permissionDes="添加">
            <a id="assetsDeviceRegularCheck_insert" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceRegularCheck_button_del"
                               permissionDes="删除">
            <a id="assetsDeviceRegularCheck_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceRegularCheck_button_save"
                               permissionDes="保存">
            <a id="assetsDeviceRegularCheck_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceRegularCheck_button_edit"
                               permissionDes="编辑">
            <a id="assetsDeviceRegularCheck_edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsDeviceRegularCheck_keyWord" id="assetsDeviceRegularCheck_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsDeviceRegularCheck_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsDeviceRegularCheck_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
               role="button">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsDeviceRegularCheckjqGrid"></table>
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
                <th width="10%">定检周期:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="regularCheckCycle" id="regularCheckCycle"
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
                <th width="10%">定检方式:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="regularCheckMode" id="regularCheckMode"
                                  title="定检方式" isNull="true" lookupCode="REGULAR_CHECK_MODE"/>
                </td>
                <th width="10%">上次定检时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastRegularCheckDateBegin"
                               id="lastRegularCheckDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上次定检时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastRegularCheckDateEnd"
                               id="lastRegularCheckDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">下次定检时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextRegularCheckDateBegin"
                               id="nextRegularCheckDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">下次定检时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextRegularCheckDateEnd"
                               id="nextRegularCheckDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">定检结论:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="regularCheckConclution"
                                  id="regularCheckConclution" title="定检结论" isNull="true"
                                  lookupCode="REGULAR_CHECK_CONCLUTION"/>
                </td>
                <th width="10%">注册号:</th>
                <td width="15%">
                    <input title="注册号" class="form-control input-sm" type="text" name="registerId" id="registerId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">附件:</th>
                <td width="15%">
                    <input title="附件" class="form-control input-sm" type="text" name="attachment" id="attachment"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/assetsdeviceregularcheck/js/AssetsDeviceRegularCheck.js"
        type="text/javascript"></script>
<script type="text/javascript">
    //获取后台传递的统一编号
    unifiedId = ${unifiedId};

    //后台获取的通用代码数据
    var deviceCategoryData = ${deviceCategoryData};
    var regularCheckModeData = ${regularCheckModeData};
    var regularCheckConclutionData = ${regularCheckConclutionData};
    var assetsDeviceRegularCheck;
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
            , {label: '责任人id', name: 'ownerId', width: 75, hidden: true, editable: true}
            , {
                label: '责任人部门',
                name: 'ownerDeptAlias',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'ownerDept'}
            }
            , {label: '责任人部门id', name: 'ownerDept', width: 75, hidden: true, editable: true}
            , {label: '安装地点', name: 'positionId', width: 150, editable: true}
            , {
                label: '定检周期',
                name: 'regularCheckCycle',
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
            , {label: '定检方式id', name: 'regularCheckMode', width: 75, hidden: true}
            , {
                label: '定检方式',
                name: 'regularCheckModeName',
                width: 150,
                editable: true,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem1,
                    custom_value: selectValue1,
                    forId: 'regularCheckMode',
                    value: regularCheckModeData
                }
            }
            , {
                label: '上次定检时间',
                name: 'lastRegularCheckDate',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {
                label: '下次定检时间',
                name: 'nextRegularCheckDate',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {label: '定检结论id', name: 'regularCheckConclution', width: 75, hidden: true}
            , {
                label: '定检结论',
                name: 'regularCheckConclutionName',
                width: 150,
                editable: true,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem1,
                    custom_value: selectValue1,
                    forId: 'regularCheckConclution',
                    value: regularCheckConclutionData
                }
            }
            , {label: '注册号', name: 'registerId', width: 150, editable: true}
            , {label: '附件', name: 'attachment', width: 150, editable: true, hidden: true}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        searchNames.push("deviceName");
        searchTips.push("设备名称");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsDeviceRegularCheck_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsDeviceRegularCheck = new AssetsDeviceRegularCheck('assetsDeviceRegularCheckjqGrid', '${url}', 'searchDialog', 'form', 'assetsDeviceRegularCheck_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsDeviceRegularCheck_insert').bind('click', function () {
            assetsDeviceRegularCheck.insert();
        });
        //删除按钮绑定事件
        $('#assetsDeviceRegularCheck_del').bind('click', function () {
            assetsDeviceRegularCheck.del();
        });
        //保存按钮绑定事件
        $('#assetsDeviceRegularCheck_save').bind('click', function () {
            assetsDeviceRegularCheck.save();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceRegularCheck_edit').bind('click', function () {
            assetsDeviceRegularCheck.edit();
        });
        //查询按钮绑定事件
        $('#assetsDeviceRegularCheck_searchPart').bind('click', function () {
            assetsDeviceRegularCheck.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsDeviceRegularCheck_searchAll').bind('click', function () {
            assetsDeviceRegularCheck.openSearchForm(this);
        });
        //回车键查询
        $('#assetsDeviceRegularCheck_keyWord').on('keydown', function (e) {
            if (e.keyCode == 13) {
                assetsDeviceRegularCheck.searchByKeyWord();
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
        $("#assetsDeviceRegularCheck_keyWord").val(unifiedId);


    });
</script>
</html>