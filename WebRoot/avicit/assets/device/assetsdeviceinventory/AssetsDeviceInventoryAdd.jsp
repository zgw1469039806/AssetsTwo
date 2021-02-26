<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>
<%
    String importlibs = "common,form,table,fileupload,tree";
    String pid = request.getParameter("id");
%>
<%
    String userId = SessionHelper.getLoginSysUserId(request);
    SysUser user = SessionHelper.getLoginSysUser(request);
    String id = user.getId();
    String userName = user.getName();
    String userDeptId = SessionHelper.getCurrentDeptId(request);
    String userDeptName = SessionHelper.getCurrentDeptName(request);
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdeviceinventory/assetsDeviceInventoryController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

    <style type="text/css">
        #t_assetsDeviceInventorySub {
            display: none;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <!-- 业务表单 Start -->
    <form id='form'>
        <input type="hidden" name="id" id="id"/>
        <input type="hidden" name="version" id="version"/>
        <table class="form_commonTable" style="margin: 10px 0% 0 0%;">
            <tr>
                <th width="10%">
                    <label for="inventoryName">盘点名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="inventoryName"
                           id="inventoryName"/>
                </td>
                <th width="10%">
                    <label for="inventoryId">盘点单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="inventoryId"
                           id="inventoryId" disabled="disabled" value="系统自动生成单号"/>
                    <%--                <td width="10%"><div id="inventoryId"></div></td>&ndash;%&gt;--%>
                    <%--                    <input class="form-control input-sm" placeholder="系统自动生成" type="text" name="procId" id="procId"/>--%>
                </td>
                <th width="10%">
                    <label for="createdByPersonAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPerson" name="createdByPerson" value="<%=id%>">
                        <input class="form-control" placeholder="请选择用户" type="text"
                               id="createdByPersonAlias" name="createdByPersonAlias" readonly="readonly"
                               value=<%=userName%>>
                        <span class="input-group-addon">
                             <i class="glyphicon glyphicon-user"></i>
                        </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept" value="<%=userDeptId%>">
                        <input class="form-control" placeholder="请选择部门" type="text"
                               id="createdByDeptAlias" name="createdByDeptAlias" readonly="readonly"
                               value="<%=userDeptName%>">
                        <span class="input-group-addon">
                            <i class="glyphicon glyphicon-equalizer"></i>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="createDate">创建日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createDate"
                               id="createDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="beginDate">基准日:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDate"
                               id="beginDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <div id="centerpanel"
                         data-options="region:'center',split:true,onResize:function(a){$('#assetsDeviceInventorySub').setGridWidth(a); $('#assetsDeviceInventorySub').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
                        <div id="toolbar_assetsDeviceInventorySub" class="toolbar">
                            <div class="toolbar-right">
                                <div class="input-group-btn form-tool-searchbtn">
                                    <a id="assetsDeviceInventorySub_searchAll" href="javascript:void(0)"
                                       class="btn btn-defaul btn-sm"
                                       role="button">高级查询 <span class="caret"></span></a>
                                </div>
                            </div>
                        </div>
                        <table id="assetsDeviceInventorySub"></table>
                        <div id="assetsDeviceInventorySubPager"></div>
                    </div>

                </th>
            </tr>
        </table>
    </form>
    <!-- 业务表单 End -->
</div>

<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                       title="生成盘点清单" id="assetsDeviceInventory_saveForm">生成盘点清单</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsDeviceInventory_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<!-- 业务的js -->

<script type="text/javascript"
        src="avicit/assets/device/assetsdeviceinventory/js/AssetsDeviceInventoryDetail.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdeviceinventory/js/AssetsDeviceInventorySub.js"></script>
<script type="text/javascript" src="avicit/platform6/autocode/js/AutoCode.js"></script>
<script src="avicit/assets/device/assetsdeviceinventory/js/AssetsDeviceInventory.js" type="text/javascript"></script>


<script type="text/javascript">

    var autoCode = new AutoCode("DEVICE_INVENTORY_CODE", "inventoryId", false, "autoCodeValue");


    //后台获取的通用代码数据
    var deviceStateData = null;
    var inventoryStateData = null;
    var inventoryResultData = null;

    //初始化通用代码值
    function initOnceInAdd() {
        avicAjax.ajax({
            url: "platform/assets/device/assetsdeviceinventory/assetsDeviceInventoryController/getLookUpCode",
            type: 'post',
            dataType: 'json',
            async: false,
            success: function (r) {
                if (r.flag == "success") {
                    deviceStateData = JSON.parse(r.deviceStateData);
                    inventoryStateData = JSON.parse(r.inventoryStateData);
                    inventoryResultData = JSON.parse(r.inventoryResultData);
                } else {
                    layer.alert('获取失败！' + r.error, {
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
    };

    var afterUploadEvent = null;
    var assetsDeviceInventorySubGridColModel = null;
    $(document).ready(function () {
        var pid = "<%=pid%>";
        var isReload = "true";
        var searchSubNames = "";
        initOnceInAdd(); //初始化通用代码值
        assetsDeviceInventorySubGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '设备ID', name: 'id', width: 150}
            , {label: '资产编号', name: 'assetId', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {
                label: '责任人',
                name: 'ownerIdAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'ownerId'}
            }
            , {label: '责任人id', name: 'ownerId', width: 75, hidden: true}
            , {
                label: '责任人部门',
                name: 'ownerDeptAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'ownerDept'}
            }
            , {label: '责任人部门id', name: 'ownerDept', width: 75, hidden: true}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '供应商', name: 'supplier', width: 150}
            , {
                label: '立卡日期',
                name: 'createdDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {
                label: '原值',
                name: 'originalValue',
                width: 150,
                edittype: 'custom',
                editoptions: {
                    custom_element: spinnerElem,
                    custom_value: spinnerValue,
                    min: -<%=Math.pow(10,12)-Math.pow(10,-3)%>,
                    max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,
                    step: 1,
                    precision: 3
                }
            }
            , {
                label: '净值',
                name: 'netValue',
                width: 150,
                edittype: 'custom',
                editoptions: {
                    custom_element: spinnerElem,
                    custom_value: spinnerValue,
                    min: -<%=Math.pow(10,12)-Math.pow(10,-3)%>,
                    max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,
                    step: 1,
                    precision: 3
                }
            }
            , {label: '设备状态id', name: 'deviceState', width: 75, hidden: true}
            , {
                label: '设备状态',
                name: 'deviceStateName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'deviceState',
                    value: deviceStateData
                }
            }
            , {
                label: '盘点人',
                name: 'inventoryPersonAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'inventoryPerson'}
            }
            , {label: '盘点人id', name: 'inventoryPerson', width: 75, hidden: true}
            , {
                label: '盘点人部门',
                name: 'inventoryDeptAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'inventoryDept'}
            }
            , {label: '盘点人部门id', name: 'inventoryDept', width: 75, hidden: true}
            , {
                label: '盘点时间',
                name: 'inventoryDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {
                label: '备注',
                name: 'remarks',
                width: 150,
                edittype: "textarea",
                editoptions: {rows: '1', maxlength: "1024"}
            }
            , {label: '标志位', name: 'flag', width: 150}
            , {label: '盘点状态id', name: 'inventoryState', width: 75, hidden: true}
            , {
                label: '盘点状态',
                name: 'inventoryStateName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'inventoryState',
                    value: inventoryStateData
                }
            }
            , {label: '盘点结果id', name: 'inventoryResult', width: 75, hidden: true}
            , {
                label: '盘点结果',
                name: 'inventoryResultName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'inventoryResult',
                    value: inventoryResultData
                }
            }
        ];
        var surl = "assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/getAssetsDeviceAccountsByPage";
        var assetsDeviceInventorySub = new AssetsDeviceInventorySub('assetsDeviceInventorySub', surl,
            "formSub",
            assetsDeviceInventorySubGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsDeviceInventorySub_keyWord', isReload);
        //创建业务操作JS
        var assetsDeviceInventoryDetail = new AssetsDeviceInventoryDetail('form', assetsDeviceInventorySub);
        //限制保存按钮多次点击
        // $('#assetsDeviceInventory_saveForm').addClass('disabled').unbind("click");
        // parent.assetsDeviceInventory.save($('#form'), window.name, dataSub);

        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
            beforeShow: function (selectedDate) {
                if ($('#' + selectedDate.id).val() == "") {
                    $(this).datetimepicker("setDate", new Date());
                    $('#' + selectedDate.id).val('');
                }
            }
        });
        $('.date-picker').datepicker({yearRange: "c-100:c+10"}); //时间控件增加年度选择

        //绑定表单验证规则
        assetsDeviceInventoryDetail.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=pid%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });

        //保存按钮绑定事件
        $('#assetsDeviceInventory_saveForm').bind('click', function () {
            // alert("callBcak");
            assetsDeviceInventoryDetail.save01();
        });
        //返回按钮绑定事件
        $('#assetsDeviceInventory_closeForm').bind('click', function () {
            // closeForm();
            closeDialog();
        });
        //添加按钮绑定事件
        $('#assetsDeviceInventorySub_insert').bind('click', function () {
            assetsDeviceInventorySub.insert();
        });
        //删除按钮绑定事件
        $('#assetsDeviceInventorySub_del').bind('click', function () {
            assetsDeviceInventorySub.del();
        });
        //子表操作
        //打开高级查询
        $('#assetsDeviceInventorySub_searchAll').bind('click', function () {
            assetsDeviceInventorySub.openSearchForm(this, $('#assetsDeviceInventorySub'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsDeviceInventorySub_searchPart').bind('click', function () {
            assetsDeviceInventorySub.searchByKeyWord();
        });
        // $('#createdByPersonAlias').on('focus', function (e) {
        //     new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPerson', textFiled: 'createdByPersonAlias'});
        //     this.blur();
        //     nullInput(e);
        // });
        // $('#createdByDeptAlias').on('focus', function (e) {
        //     new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
        //     this.blur();
        //     nullInput(e);
        // });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });

    /* 关闭弹窗 */
    function closeDialog() {
        var index = parent.layer.getFrameIndex(window.name);    //获取窗口索引
        parent.layer.close(index);  // 关闭layer
    }
</script>
</body>
<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
    <form id="formSub">
        <table class="form_commonTable">
            <tr>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">设备ID:</th>
                <td width="15%">
                    <input title="设备ID" class="form-control input-sm" type="text" name="deviceId" id="deviceId"/>
                </td>
                <th width="10%">资产编号:</th>
                <td width="15%">
                    <input title="资产编号" class="form-control input-sm" type="text" name="assetId" id="assetId"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
                <th width="10%">责任人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerIdSub" name="ownerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAliasSub"
                               name="ownerIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">责任人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDeptSub" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAliasSub"
                               name="ownerDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId"
                           id="manufacturerId"/>
                </td>
                <th width="10%">供应商:</th>
                <td width="15%">
                    <input title="供应商" class="form-control input-sm" type="text" name="supplier" id="supplier"/>
                </td>
                <th width="10%">立卡日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateBegin"
                               id="createdDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">立卡日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateEnd" id="createdDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">安装地点ID:</th>
                <td width="15%">
                    <input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">原值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="originalValue" id="originalValue"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">净值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netValue" id="netValue"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">设备状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceState" id="deviceState" title="设备状态"
                                  isNull="true" lookupCode="DEVICE_STATE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">盘点人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="inventoryPersonSub" name="inventoryPerson">
                        <input class="form-control" placeholder="请选择用户" type="text" id="inventoryPersonAliasSub"
                               name="inventoryPersonAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">盘点人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="inventoryDeptSub" name="inventoryDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="inventoryDeptAliasSub"
                               name="inventoryDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">盘点时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="inventoryDateBegin"
                               id="inventoryDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">盘点时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="inventoryDateEnd"
                               id="inventoryDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">备注:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="备注" name="remarks" id="remarks"></textarea>
                </td>
                <th width="10%">标志位:</th>
                <td width="15%">
                    <input title="标志位" class="form-control input-sm" type="text" name="flag" id="flag"/>
                </td>
                <th width="10%">盘点状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="inventoryState" id="inventoryState"
                                  title="盘点状态" isNull="true" lookupCode="INVENTORY_STATE"/>
                </td>
                <th width="10%">盘点结果:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="inventoryResult" id="inventoryResult"
                                  title="盘点结果" isNull="true" lookupCode="INVENTORY_RESULT"/>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </form>
</div>

</html>