<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form,fileupload";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdevicercheckproc/assetsDeviceRcheckProcController/operation/Edit/id" -->
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style type="text/css">
        #t_assetsDeviceRcheckPlan {
            display: none;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsDeviceRcheckProcDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsDeviceRcheckProcDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="checksNo">定检单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="checksNo" id="checksNo" readonly="readonly"
                           value="<c:out  value='${assetsDeviceRcheckProcDTO.checksNo}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="planName">计划名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="planName" id="planName" readonly="readonly"
                           value="<c:out  value='${assetsDeviceRcheckProcDTO.planName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="generateByAlias">生成人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="generateBy" name="generateBy"
                               value="<c:out  value='${assetsDeviceRcheckProcDTO.generateBy}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="generateByAlias"
                               name="generateByAlias" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRcheckProcDTO.generateByAlias}'/>">
                        <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="generateDate">生成时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="generateDate" id="generateDate" readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceRcheckProcDTO.generateDate}'/>"/>
						<span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="implementationDepartmentAlias">实施部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="implementationDepartment" name="implementationDepartment" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRcheckProcDTO.implementationDepartment}' />">
                        <input class="form-control" placeholder="请选择部门" type="text" id="implementationDepartmentAlias"
                               name="implementationDepartmentAlias" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRcheckProcDTO.implementationDepartmentAlias}'/>">
                        <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="checksNumber">定检计划数:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="checksNumber" id="checksNumber" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRcheckProcDTO.checksNumber}'/>"
                               data-min="0"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                    </div>
                </td>
                    <th width="10%">定检开始时间:</th>
                    <td width="15%">
                        <div class="input-group input-group-sm">
                            <input class="form-control date-picker" type="text" name="generateDate" id="nextRegularCheckDateBegin" readonly="readonly"
                                   value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceRcheckProcDTO.nextRegularCheckDateBegin}'/>"/>
                            <span
                                    class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </td>
                    <th width="10%">定检结束时间:</th>
                    <td width="15%">
                        <div class="input-group input-group-sm">
                            <input class="form-control date-picker" type="text" name="generateDate" id="nextRegularCheckDateEnd" readonly="readonly"
                                   value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceRcheckProcDTO.nextRegularCheckDateEnd}'/>"/>
                            <span
                                    class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>

                        </div>
                    </td>
            </tr>
            <tr>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <table id="assetsDeviceRcheckPlan"></table>
                    <div id="assetsDeviceRcheckPlanPager"></div>
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
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                       title="保存" id="assetsDeviceRcheckProc_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsDeviceRcheckProc_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/assets/device/assetsdevicercheckproc/js/AssetsDeviceRcheckPlan.js"></script>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var deviceCategoryData = ${deviceCategoryData};
    var regularCheckModeData = ${regularCheckModeData};
    var afterUploadEvent = null;
    var assetsDeviceRcheckPlan;
    var assetsDeviceRcheckPlanGridColModel = [
        {label: 'id', name: 'id', key: true, width: 75, hidden: true}
        , {label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150, editable: false}
        , {label: '<span style="color:red;">*</span>设备名称', name: 'deviceName', width: 150, editable: false}
        , {label: '设备类别id', name: 'deviceCategory', width: 75, hidden: true}
        , {
            label: '设备类别',
            name: 'deviceCategoryName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'deviceCategory',
                value: deviceCategoryData
            }, editable: false
        }
        , {label: '设备型号', name: 'deviceModel', width: 150, editable: true, editable: false}
        , {label: '生产厂家', name: 'manufacturerId', width: 150, editable: true, editable: false}
        , {
            label: '责任人',
            name: 'ownerIdAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'ownerId'}, editable: false
        }
        , {label: '责任人id', name: 'ownerId', width: 75, hidden: true, editable: true}
        , {
            label: '责任人部门',
            name: 'ownerDeptAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'ownerDept'}, editable: false
        }
        , {label: '责任人部门id', name: 'ownerDept', width: 75, hidden: true, editable: true}
        , {label: '安装地点', name: 'positionId', width: 150, editable: true, editable: false}
        , {
            label: '定检周期',
            name: 'regularCheckCycle',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {
                custom_element: spinnerElem,
                custom_value: spinnerValue,
                min: 0,
                max:<%=Math.pow(10,12)-Math.pow(10,-0)%>,
                step: 1,
                precision: 0
            }, editable: false
        }
        , {label: '定检方式id', name: 'regularCheckMode', width: 75, hidden: true}
        , {
            label: '定检方式',
            name: 'regularCheckModeName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'regularCheckMode',
                value: regularCheckModeData
            }, editable: false
        }

        , {label: '注册号', name: 'registerId', width: 150, editable: true, editable: false}
        , {label: '附件', name: 'attachment', width: 150, editable: true, editable: false}
        , {
            label: '定检检时间',
            name: 'regularCheckDate',
            width: 150,
            edittype: 'custom',
            formatter: format,
            editoptions: {custom_element: dateElem, custom_value: dateValue}
        }
    ];

    function closeForm() {
        parent.assetsDeviceRcheckProc.closeDialog(window.name);
    }

    function saveForm() {
        //主表表单校验
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        //子表校验
        var msg = assetsDeviceRcheckPlan.valid();
        if (msg && msg != "") {
            layer.alert(msg, {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            });
            return false;
        }
        //子表数据
        $(assetsDeviceRcheckPlan._datagridId).jqGrid('endEditCell');
        var dataSubVo = $(assetsDeviceRcheckPlan._datagridId).jqGrid('getRowData');
        var dataSub = JSON.stringify(dataSubVo);
        //验证附件密级
        var files = $('#attachment').uploaderExt('getUploadFiles');
        for (var i = 0; i < files.length; i++) {
            var name = files[i].name;
            var secretLevel = files[i].secretLevel;
            //这里验证密级
        }
        //限制保存按钮多次点击
        $('#assetsDeviceRcheckProc_saveForm').addClass('disabled').unbind("click");
        parent.assetsDeviceRcheckProc.save($('#form'), window.name, dataSub);
    }

    $(document).ready(function () {
        var pid = "${assetsDeviceRcheckProcDTO.id}";
        var isReload = "edit";
        var searchSubNames = "";
        var surl = "platform/assets/device/assetsdevicercheckproc/assetsDeviceRcheckProcController/operation/sub/";
        assetsDeviceRcheckPlan = new AssetsDeviceRcheckPlan('assetsDeviceRcheckPlan', surl,
            "formSub",
            assetsDeviceRcheckPlanGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsDeviceRcheckPlan_keyWord', isReload);
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

        parent.assetsDeviceRcheckProc.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsDeviceRcheckProcDTO.id}',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //保存按钮绑定事件
        $('#assetsDeviceRcheckProc_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsDeviceRcheckProc_closeForm').bind('click', function () {
            closeForm();
        });
        //添加按钮绑定事件
        $('#assetsDeviceRcheckPlan_insert').bind('click', function () {
            assetsDeviceRcheckPlan.insert();
        });
        //删除按钮绑定事件
        $('#assetsDeviceRcheckPlan_del').bind('click', function () {
            assetsDeviceRcheckPlan.del();
        });
        //导出
        $('#assetsDeviceRcheckPlan_export').bind('click',function(){
            assetsDeviceRcheckPlan.exportClientData();
        })
        // $('#generateByAlias').on('focus', function (e) {
        //     new H5CommonSelect({type: 'userSelect', idFiled: 'generateBy', textFiled: 'generateByAlias'});
        //     this.blur();
        //     nullInput(e);
        // });
        //
        // $('#implementationDepartmentAlias').on('focus', function (e) {
        //     new H5CommonSelect({
        //         type: 'deptSelect',
        //         idFiled: 'implementationDepartment',
        //         textFiled: 'implementationDepartmentAlias'
        //     });
        //     this.blur();
        //     nullInput(e);
        // });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>