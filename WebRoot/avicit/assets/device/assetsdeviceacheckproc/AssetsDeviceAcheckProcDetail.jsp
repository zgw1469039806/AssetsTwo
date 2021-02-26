<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>
<%
    String importlibs = "common,form,table,fileupload,tree";
    String pid = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController/operation/toDetailJsp" -->
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
                    <label for="acheckCode">精度检查单号:</label></th>
                <td width="15%">
                    <div id="acheckCode"></div>
                </td>
                <th width="10%">
                    <label for="planName">计划名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="planName" id="planName"/>
                </td>


                <th width="10%">
                    <label for="nextAccStartDate">精度检查开始时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text"
                               name="nextAccStartDate" id="nextAccStartDate"/><span
                            class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="nextAccEndDate">精度检查结束时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text"
                               name="nextAccEndDate" id="nextAccEndDate"/><span
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
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="generateByAlias">计划生成人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="generateBy" name="generateBy"
                               value="<c:out  value='${assetsDeviceAcheckProcDTO.generateBy}'/>">
                        <input class="form-control" type="text" id="generateByAlias"
                               readonly="readonly" name="generateByAlias"
                               value="<c:out  value='${assetsDeviceAcheckProcDTO.generateByAlias}'/>">
                        <span class="input-group-addon">
                         <i class="glyphicon glyphicon-user"></i>
                      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">

                    <div id="centerpanel"
                         data-options="region:'center',split:true,onResize:function(a){$('#assetsDeviceAcheckPlan').setGridWidth(a); $('#assetsDeviceAcheckPlan').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
                        <div id="toolbar_assetsDeviceAcheckPlan" class="toolbar">
                            <div class="toolbar-left">
                                <sec:accesscontrollist hasPermission="3"
                                                       domainObject="formdialog_AssetsDeviceAcheckPlan_button_add"
                                                       permissionDes="选择精度检查设备">
                                    <a id="assetsDeviceAcheckPlan_insert" href="javascript:void(0)"
                                       class="btn btn-default form-tool-btn btn-sm" role="button"
                                       title="选择精度检查设备"><i class="fa fa-plus"></i> 选择精度检查设备</a>
                                </sec:accesscontrollist>

                            </div>
                        </div>
                    </div>
                    <table id="assetsDeviceAcheckPlan"></table>
                    <div id="assetsDeviceAcheckPlanPager"></div>

                </th>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1%>">
                    <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
                </td>
            </tr>
        </table>
    </form>
    <!-- 业务表单 End -->
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 框架脚本 -->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/jquery.dragsort-0.5.2.min.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/nav.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/main.js"></script>

<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/CommonActor.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/BpmActor.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/FlowEditor.js"></script>
<!-- 业务的js -->

<script type="text/javascript" src="avicit/assets/device/assetsdeviceacheckproc/js/AssetsDeviceAcheckProcDetail.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdeviceacheckproc/js/AssetsDeviceAcheckPlan.js"></script>
<script type="text/javascript" src="static/js/platform/eform/common.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdeviceacheckproc/js/SelfStyleLayout.js"></script>

<!-- 自动编码的js -->
<script src="avicit/platform6/autocode/js/AutoCode.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var deviceCategoryData = null;

    var assetsDeviceAcheckPlan;

    //初始化通用代码值
    function initOnceInAdd() {
        avicAjax.ajax({
            url: "platform/assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController/getLookUpCode",
            type: 'post',
            dataType: 'json',
            async: false,
            success: function (r) {
                if (r.flag == "success") {
                    deviceCategoryData = JSON.parse(r.deviceCategoryData);
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
    var assetsDeviceAcheckPlanGridColModel = null;
    $(document).ready(function () {
        //"CHECKS_CODE" 为编码管理中维护的编码代码
        //"checksNo" 表单中需要的编码的字段
        var autoCode = new AutoCode("ACC_CHECK_CODE", "acheckCode", false, "autoCodeValue");
        var pid = "<%=pid%>";
        var isReload = "true";
        var searchSubNames = "";
        initOnceInAdd(); //初始化通用代码值
        assetsDeviceAcheckPlanGridColModel = [
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
            , {label: '产地', name: 'productArea', width: 150}
            , {label: '安装地点', name: 'positionId', width: 150}
            , {
                label: '出厂日期',
                name: 'productDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {
                label: '使用人',
                name: 'userIdAlias',
                width: 150,

                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'userId'}
            }
            , {label: '使用人id', name: 'userId', width: 75, hidden: true}
            , {
                label: '使用人部门',
                name: 'userDeptAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'userDept'}
            }
            , {label: '使用人部门id', name: 'userDept', width: 75, hidden: true}

            , {
                label: '精度检查周期(天)',
                name: 'accCheckCycle',
                width: 150,
                edittype: 'custom',
                editoptions: {
                    custom_element: spinnerElem,
                    custom_value: spinnerValue,
                    min: 0,
                    max:<%=Math.pow(10,12)-Math.pow(10,-0)%>,
                    step: 1,
                    precision: 0
                }
            }

            , {label: '附件', name: 'attachment', width: 150}
            , {
                label: '精度检查时间',
                name: 'accCheckDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
        ];
        var surl = "platform/assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController/operation/sub/";
        var assetsDeviceAcheckPlan = new AssetsDeviceAcheckPlan('assetsDeviceAcheckPlan', surl,
            "formSub",
            assetsDeviceAcheckPlanGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsDeviceAcheckPlan_keyWord', isReload);
        //创建业务操作JS
        var assetsDeviceAcheckProcDetail = new AssetsDeviceAcheckProcDetail('form', assetsDeviceAcheckPlan);
        //创建流程操作JS
        new FlowEditor(assetsDeviceAcheckProcDetail);

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
        assetsDeviceAcheckProcDetail.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=pid%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //添加按钮绑定事件
        $('#assetsDeviceAcheckPlan_insert').bind('click', function () {
            var beginDate = $('#nextAccStartDate').val();
            var endDate = $('#nextAccEndDate').val();

            var oDate1 = new Date($('#nextAccStartDate').val());
            var oDate2 = new Date($('#nextAccEndDate').val());
            if (beginDate == "" || endDate == "") {
                layer.alert("时间不能为空!");
                return;
            }
            if (oDate1.getTime() > oDate2.getTime()) {
                layer.alert("开始时间不能大于结束时间!");
                return;
            }
            var param = JSON.stringify({
                nextAccCheckDateBegin: $('#nextAccStartDate').val(),
                nextAccCheckDateEnd: $('#nextAccEndDate').val()
            });
            openProductModelLayer("false", "", "callBackFn", param);
        });
        //删除按钮绑定事件
        $('#assetsDeviceAcheckPlan_del').bind('click', function () {
            assetsDeviceAcheckPlan.del();
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
        $('#generateByAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'generateBy', textFiled: 'generateByAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>