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
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdevicercheckproc/assetsDeviceRcheckProcController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>
    <%
        String userId = SessionHelper.getLoginSysUserId(request);
        SysUser user = SessionHelper.getLoginSysUser(request);
        String userName = user.getName();
        String userDeptId = SessionHelper.getCurrentDeptId(request);
        String userDeptName = SessionHelper.getCurrentDeptName(request);
    %>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <!-- 框架 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmbusiness/include2/common/css/style.css">
</head>
<body>
<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include2/buttons.jsp" %>
<div id="formTab" style="display: none">
    <!-- 业务表单 Start -->
    <form id='form'>
        <input type="hidden" name="id" id="id"/>
        <input type="hidden" name="version" id="version"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="checksNo">定检单号:</label></th>
                <td width="15%">
                    <div id="checksNo"></div>
                </td>
                <th width="10%">
                    <label for="planName">计划名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="planName" id="planName"/>
                </td>
                <th width="10%">
                    <label for="nextRegularStartDate">定检开始时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text"
                               name="nextRegularStartDate"
                               id="nextRegularStartDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="nextRegularEndDate">定检结束时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text"
                               name="nextRegularEndDate" id="nextRegularEndDate"/><span
                            class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

            </tr>
            <tr>
                <th width="10%">
                    <label for="implementationDepartmentAlias">实施部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="implementationDepartment"
                               name="implementationDepartment">
                        <input class="form-control" placeholder="请选择部门" type="text"
                               id="implementationDepartmentAlias"
                               name="implementationDepartmentAlias">
                        <span class="input-group-addon">
            <i class="glyphicon glyphicon-equalizer"></i>
            </span>
                    </div>
                </td>

                <th width="10%">
                    <label for="telephone">联系电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="telephone"
                           id="telephone"/>
                </td>
                <th width="10%">
                    <label for="checksNumber">定检计划数:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="checksNumber"
                               id="checksNumber" data-min="0"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1"
                               data-precision="0">
                        <span class="input-group-addon">
                    <a href="javascript:;" class="spin-up" data-spin="up"><i
                            class="glyphicon glyphicon-triangle-top"></i></a>
                    <a href="javascript:;" class="spin-down" data-spin="down"><i
                            class="glyphicon glyphicon-triangle-bottom"></i></a>
                    </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="generateByAlias">生成人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="generateBy" name="generateBy">
                        <input class="form-control" type="text"
                               id="generateByAlias" name="generateByAlias">
                        <span class="input-group-addon">
        <i class="glyphicon glyphicon-user"></i>
        </span>
                    </div>
                </td>


            </tr>
            <tr>
                <th width="10%">
                    <label for="generateDate">生成时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="generateDate"
                               id="generateDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <div id="centerpanel"
                         data-options="region:'center',split:true,onResize:function(a){$('#assetsDeviceRcheckPlan').setGridWidth(a); $('#assetsDeviceRcheckPlan').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
                        <div id="toolbar_AssetsDeviceRcheckPlan" class="toolbar">
                            <div class="toolbar-left">
                                <sec:accesscontrollist hasPermission="3"
                                                       domainObject="formdialog_AssetsDeviceRcheckPlan_button_add"
                                                       permissionDes="选择定检设备">
                                    <a id="assetsDeviceRcheckPlan_insert" href="javascript:void(0)"
                                       class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                       role="button"
                                       title="选择定检设备"><i class="fa fa-plus"></i> 选择定检设备</a>
                                </sec:accesscontrollist>
                            </div>
                        </div>
                    </div>
                    <table id="assetsDeviceRcheckPlan"></table>
                    <div id="assetsDeviceRcheckPlanPager"></div>
                </th>
            </tr>

        </table>
    </form>
    <!-- 业务表单 End -->
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 页面脚本 avictabs.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/jquery.dragsort-0.5.2.min.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/nav.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/main.js"></script>

<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/CommonActor.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/BpmActor.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/FlowEditor.js"></script>
<!-- 业务的js -->
<script type="text/javascript" src="avicit/assets/device/assetsdevicercheckproc/js/AssetsDeviceRcheckProcDetail.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdevicercheckproc/js/AssetsDeviceRcheckPlan.js"></script>
<script type="text/javascript" src="static/js/platform/eform/common.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdevicercheckproc/js/SelfStyleLayout.js"></script>
<!-- 自动编码的js -->
<script src="avicit/platform6/autocode/js/AutoCode.js"></script>

<script type="text/javascript">
    //后台获取的通用代码数据
    var deviceCategoryData = null;
    var regularCheckModeData = null;
    var regularCheckConclutionData = null;
    var assetsDeviceRcheckPlan;

    //初始化通用代码值
    function initOnceInAdd() {
        avicAjax.ajax({
            url: "platform/assets/device/assetsdevicercheckproc/assetsDeviceRcheckProcController/getLookUpCode",
            type: 'post',
            dataType: 'json',
            async: false,
            success: function (r) {
                if (r.flag == "success") {
                    deviceCategoryData = JSON.parse(r.deviceCategoryData);
                    regularCheckModeData = JSON.parse(r.regularCheckModeData);
                    regularCheckConclutionData = JSON.parse(r.regularCheckConclutionData);
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
    var assetsDeviceRcheckPlanGridColModel = null;
    $(document).ready(function () {
        //"CHECKS_CODE" 为编码管理中维护的编码代码
//"checksNo" 表单中需要的编码的字段
        var autoCode = new AutoCode("CHECKS_CODE", "checksNo", false, "autoCodeValue");
        var pid = "<%=pid%>";
        var isReload = "true";
        var searchSubNames = "";
        initOnceInAdd(); //初始化通用代码值
        assetsDeviceRcheckPlanGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备类别id', name: 'deviceCategory', width: 75, hidden: true}
            , {
                label: '设备类别',
                name: 'deviceCategoryName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'deviceCategory',
                    value: deviceCategoryData
                }
            }
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '责任人', name: 'ownerId', width: 150}
            , {label: '责任人部门', name: 'ownerDept', width: 150}
            , {label: '安装地点', name: 'positionId', width: 150}
            , {
                label: '定检周期',
                name: 'regularCheckCycle',
                width: 150,
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
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'regularCheckMode',
                    value: regularCheckModeData
                }
            }
            , {
                label: '上次定检时间',
                name: 'lastRegularCheckDate',
                width: 150,
                hidden: true,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {
                label: '下次定检时间',
                name: 'nextRegularCheckDate',
                width: 150,
                hidden: true,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {label: '定检结论id', name: 'regularCheckConclution', width: 75, hidden: true}
            , {
                label: '定检结论',
                name: 'regularCheckConclutionName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'regularCheckConclution',
                    value: regularCheckConclutionData
                }
            }
            , {label: '注册号', name: 'registerId', width: 150,hidden: true}
            , {label: '附件', name: 'attachment', width: 150}
            , {label: '台账的定检信息ID', name: 'checkId', width: 150,hidden: true}
            , {
                label: '定检检时间',
                name: 'regularCheckDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
        ];
        var surl = "platform/assets/device/assetsdevicercheckproc/assetsDeviceRcheckProcController/operation/sub/";
        var assetsDeviceRcheckPlan = new AssetsDeviceRcheckPlan('assetsDeviceRcheckPlan', surl,
            "formSub",
            assetsDeviceRcheckPlanGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsDeviceRcheckPlan_keyWord', isReload);
//创建业务操作JS
        var assetsDeviceRcheckProcDetail = new AssetsDeviceRcheckProcDetail('form', assetsDeviceRcheckPlan);
//创建流程操作JS
        new FlowEditor(assetsDeviceRcheckProcDetail);

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
        assetsDeviceRcheckProcDetail.formValidate($('#form'));
//初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=pid%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
//添加按钮绑定事件
        $('#assetsDeviceRcheckPlan_insert').bind('click', function () {
            var beginDate = $('#nextRegularStartDate').val();
            var endDate = $('#nextRegularEndDate').val();

            var oDate1 = new Date($('#nextRegularStartDate').val());
            var oDate2 = new Date($('#nextRegularEndDate').val());
            if (beginDate == "" || endDate == "") {
                layer.alert("时间不能为空!");
                return;
            }
            if (oDate1.getTime() > oDate2.getTime()) {
                layer.alert("开始时间不能大于结束时间!");
                return;
            }
            var param = JSON.stringify({
                nextRegularCheckDateBegin: $('#nextRegularStartDate').val(),
                nextRegularCheckDateEnd: $('#nextRegularEndDate').val()
            });
            openProductModelLayer("false", "", "callBackFn", param);
        });
//删除按钮绑定事件
        $('#assetsDeviceRcheckPlan_del').bind('click', function () {
            assetsDeviceRcheckPlan.del();
        });

        $('#generateByAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'generateBy', textFiled: 'generateByAlias'});
            this.blur();
            nullInput(e);
        });
        $('#implementationDepartmentAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'deptSelect',
                idFiled: 'implementationDepartment',
                textFiled: 'implementationDepartmentAlias'
            });
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>