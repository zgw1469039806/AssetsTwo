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
    <!-- ControllerPath = "assets/device/assetsdeviceacccheck/assetsDeviceAccCheckController/toAssetsDeviceAccCheckManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceAccCheck_button_add"
                               permissionDes="添加">
            <a id="assetsDeviceAccCheck_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceAccCheck_button_del"
                               permissionDes="删除">
            <a id="assetsDeviceAccCheck_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceAccCheck_button_save"
                               permissionDes="保存">
            <a id="assetsDeviceAccCheck_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceAccCheck_button_edit"
                               permissionDes="编辑">
            <a id="assetsDeviceAccCheck_edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsDeviceAccCheck_keyWord" id="assetsDeviceAccCheck_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsDeviceAccCheck_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsDeviceAccCheck_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
               role="button">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsDeviceAccCheckjqGrid"></table>
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
                <th width="10%">安装地点:</th>
                <td width="15%">
                    <input title="安装地点" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">出厂日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="productDateBegin"
                               id="productDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">出厂日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="productDateEnd" id="productDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="productArea" id="productArea"/>
                </td>
            </tr>
            <tr>
                <th width="10%">使用人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userId" name="userId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="userIdAlias" name="userIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">使用人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userDept" name="userDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="userDeptAlias"
                               name="userDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">上次精度检查时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastAccCheckDateBegin"
                               id="lastAccCheckDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上次精度检查时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastAccCheckDateEnd"
                               id="lastAccCheckDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">精度检查周期:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="accCheckCycle" id="accCheckCycle"
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
                <th width="10%">下次精度检查时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextAccCheckDateBegin"
                               id="nextAccCheckDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">下次精度检查时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextAccCheckDateEnd"
                               id="nextAccCheckDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
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
<script src="avicit/assets/device/assetsdeviceacccheck/js/AssetsDeviceAccCheck.js" type="text/javascript"></script>
<script type="text/javascript">
    //获取后台传递的统一编号
    unifiedId = ${unifiedId};

    //后台获取的通用代码数据
    var deviceCategoryData = ${deviceCategoryData};
    var assetsDeviceAccCheck;
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>设备名称', name: 'deviceName', width: 150, editable: true}
            <sec:accesscontrollist hasPermission="3" domainObject="assetsDeviceAccCheck_table_deviceCategory" permissionDes="设备类别">
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
            </sec:accesscontrollist>
            , {label: '设备型号', name: 'deviceModel', width: 150, editable: true}
            , {label: '安装地点', name: 'positionId', width: 150, editable: true}
            , {
                label: '出厂日期',
                name: 'productDate',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {label: '产地', name: 'productArea', width: 150, editable: true}
            , {
                label: '使用人',
                name: 'userIdAlias',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'userId'}
            }
            , {label: '使用人id', name: 'userId', width: 75, hidden: true, editable: false}
            , {
                label: '使用人部门',
                name: 'userDeptAlias',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'userDept'}
            }
            , {label: '使用人部门id', name: 'userDept', width: 75, hidden: true, editable: false}
            , {
                label: '上次精度检查时间',
                name: 'lastAccCheckDate',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {
                label: '精度检查周期',
                name: 'accCheckCycle',
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
                label: '下次精度检查时间',
                name: 'nextAccCheckDate',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {label: '附件', name: 'attachment', width: 150, editable: true}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        searchNames.push("deviceName");
        searchTips.push("设备名称");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsDeviceAccCheck_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsDeviceAccCheck = new AssetsDeviceAccCheck('assetsDeviceAccCheckjqGrid', '${url}', 'searchDialog', 'form', 'assetsDeviceAccCheck_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsDeviceAccCheck_insert').bind('click', function () {
            assetsDeviceAccCheck.insert();
        });
        //删除按钮绑定事件
        $('#assetsDeviceAccCheck_del').bind('click', function () {
            assetsDeviceAccCheck.del();
        });
        //保存按钮绑定事件
        $('#assetsDeviceAccCheck_save').bind('click', function () {
            assetsDeviceAccCheck.save();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceAccCheck_edit').bind('click', function () {
            assetsDeviceAccCheck.edit();
        });
        //查询按钮绑定事件
        $('#assetsDeviceAccCheck_searchPart').bind('click', function () {
            assetsDeviceAccCheck.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsDeviceAccCheck_searchAll').bind('click', function () {
            assetsDeviceAccCheck.openSearchForm(this);
        });
        //回车键查询
        $('#assetsDeviceAccCheck_keyWord').on('keydown', function (e) {
            if (e.keyCode == 13) {
                assetsDeviceAccCheck.searchByKeyWord();
            }
        });
        $('#userIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'userId', textFiled: 'userIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#userDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'userDept', textFiled: 'userDeptAlias'});
            this.blur();
            nullInput(e);
        });

        //给子表搜索框赋值（统一编号）
        $("#assetsDeviceAccCheck_keyWord").val(unifiedId);

    });
</script>
</html>