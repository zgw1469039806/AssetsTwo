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
    <!-- ControllerPath = "assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/operation/toDetailJsp" -->
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
                <label for="maintainCode">年度保养单号:</label></th>
            <td width="15%">
                <div id="maintainCode"></div>
            </td>
            <th width="10%">
                <label for="planName">计划名称:</label></th>
            <td width="15%">
                <input class="form-control input-sm" type="text" name="planName" id="planName"/>
            </td>
            <th width="10%">
                <label for="nextMaintainStartDate">年度保养开始时间:</label></th>
            <td width="15%">
                <div class="input-group input-group-sm">
                    <input class="form-control date-picker" type="text"
                           name="nextMaintainStartDate" id="nextMaintainStartDate"/><span
                        class="input-group-addon"><i
                        class="glyphicon glyphicon-calendar"></i></span>
                </div>
            </td>
            <th width="10%">
                <label for="nextMaintainEndDate">年度保养结束时间:</label></th>
            <td width="15%">
                <div class="input-group input-group-sm">
                    <input class="form-control date-picker" type="text"
                           name="nextMaintainEndDate" id="nextMaintainEndDate"/><span
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
                <label for="generateByAlias">计划生成人:</label></th>
            <td width="15%">
                <div class="input-group  input-group-sm">
                    <input type="hidden" id="generateBy" name="generateBy">
                    <input class="form-control" placeholder="请选择用户" type="text"
                           id="generateByAlias" name="generateByAlias">
                    <span class="input-group-addon">
                         <i class="glyphicon glyphicon-user"></i>
                      </span>
                </div>
            </td>
            <th width="10%">
                <label for="maintainNumber">年度保养数量:</label></th>
            <td width="15%">
                <div class="input-group input-group-sm spinner" data-trigger="spinner">
                    <input class="form-control" type="text" name="maintainNumber"
                           id="maintainNumber" data-min="0"
                           data-max="<%=Math.pow(10,11)-Math.pow(10,-0)%>" data-step="1"
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
                     data-options="region:'center',split:true,onResize:function(a){$('#assetsDeviceMcheckPlan').setGridWidth(a); $('#assetsDeviceMcheckPlan').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">

                <div id="toolbar_AssetsDeviceMcheckPlan" class="toolbar">
                    <div class="toolbar-left">
                        <sec:accesscontrollist hasPermission="3"
                                               domainObject="formdialog_AssetsDeviceMcheckPlan_button_add"
                                               permissionDes="选择保养设备">
                            <a id="assetsDeviceMcheckPlan_insert" href="javascript:void(0)"
                               class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                               role="button"
                               title="选择保养设备"><i class="fa fa-plus"></i> 选择保养设备</a>
                        </sec:accesscontrollist>
                    </div>
                    </div>
                </div>
                <table id="assetsDeviceMcheckPlan"></table>
                <div id="assetsDeviceMcheckPlanPager"></div>
            </th>
        </tr>
<%--        <tr>--%>
<%--            <th><label for="attachment">附件</label></th>--%>
<%--            <td colspan="<%=4 * 2 - 1%>">--%>
<%--                <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>--%>
<%--            </td>--%>
<%--        </tr>--%>
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
<script type="text/javascript"
        src="avicit/assets/device/assetsdevicemcheckproc/js/AssetsDeviceMcheckProcDetail.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdevicemcheckproc/js/AssetsDeviceMcheckPlan.js"></script>
<script type="text/javascript" src="static/js/platform/eform/common.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdevicemcheckproc/js/SelfStyleLayout.js"></script>

<!-- 自动编码的js -->
<script src="avicit/platform6/autocode/js/AutoCode.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var deviceCategoryData = null;
    var maintainItemData = null;
    var maintainModeData = null;
    var assetsDeviceMcheckPlan;
    //初始化通用代码值
    function initOnceInAdd() {
        avicAjax.ajax({
            url: "platform/assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/getLookUpCode",
            type: 'post',
            dataType: 'json',
            async: false,
            success: function (r) {
                if (r.flag == "success") {
                    deviceCategoryData = JSON.parse(r.deviceCategoryData);
                    maintainItemData = JSON.parse(r.maintainItemData);
                    maintainModeData = JSON.parse(r.maintainModeData);
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
    var assetsDeviceMcheckPlanGridColModel = null;
    $(document).ready(function () {
        //"CHECKS_CODE" 为编码管理中维护的编码代码
        //"maintainCode" 表单中需要的编码的字段
        var autoCode = new AutoCode("MAINTAIN_CODE", "maintainCode", false, "autoCodeValue");

        var pid = "<%=pid%>";
        var isReload = "true";
        var searchSubNames = "";
        initOnceInAdd(); //初始化通用代码值
        assetsDeviceMcheckPlanGridColModel = [
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
            , {label: '安装地点', name: 'positionId', width: 150}
            , {label: '保养部位', name: 'maintainPosition', width: 150}
            , {label: '保养内容', name: 'maintainContent', width: 150}
            , {label: '保养项目id', name: 'maintainItem', width: 75, hidden: true}
            , {
                label: '保养项目',
                name: 'maintainItemName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'maintainItem',
                    value: maintainItemData
                }
            }
            , {label: '保养方式id', name: 'maintainMode', width: 75, hidden: true}
            , {
                label: '保养方式',
                name: 'maintainModeName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'maintainMode',
                    value: maintainModeData
                }
            }
            , {label: '保养周期', name: 'maintainCycle', width: 150}
            , {
                label: '上次保养时间',
                name: 'lastMaintainDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {
                label: '下次保养时间',
                name: 'nextMaintainDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {label: '台账年度保养表ID', name: 'maintainId', width: 150}
            , {
                label: '保养时间',
                name: 'maintainDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
        ];
        var surl = "platform/assets/device/assetsdevicemcheckproc/assetsDeviceMcheckProcController/operation/sub/";
        var assetsDeviceMcheckPlan = new AssetsDeviceMcheckPlan('assetsDeviceMcheckPlan', surl,
            "formSub",
            assetsDeviceMcheckPlanGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsDeviceMcheckPlan_keyWord', isReload);
        //创建业务操作JS
        var assetsDeviceMcheckProcDetail = new AssetsDeviceMcheckProcDetail('form', assetsDeviceMcheckPlan);
        //创建流程操作JS
        new FlowEditor(assetsDeviceMcheckProcDetail);

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
        assetsDeviceMcheckProcDetail.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=pid%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //添加按钮绑定事件
        $('#assetsDeviceMcheckPlan_insert').bind('click', function () {
            var beginDate = $('#nextMaintainStartDate').val();
            var endDate = $('#nextMaintainEndDate').val();

            var oDate1 = new Date($('#nextMaintainStartDate').val());
            var oDate2 = new Date($('#nextMaintainEndDate').val());
            if (beginDate == "" || endDate == "") {
                layer.alert("时间不能为空!");
                return;
            }
            if (oDate1.getTime() > oDate2.getTime()) {
                layer.alert("开始时间不能大于结束时间!");
                return;
            }
            var param = JSON.stringify({
                nextMaintainDateBegin: $('#nextMaintainStartDate').val(),
                nextMaintainDateEnd: $('#nextMaintainEndDate').val()
            });
            openProductModelLayer("false", "", "callBackFn", param);
        });
        //删除按钮绑定事件
        $('#assetsDeviceMcheckPlan_del').bind('click', function () {
            assetsDeviceMcheckPlan.del();
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