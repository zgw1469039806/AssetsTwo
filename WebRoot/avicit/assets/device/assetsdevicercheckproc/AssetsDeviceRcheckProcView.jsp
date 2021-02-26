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
    <title>申请</title>
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
                               readonly="readonly" name="generateByAlias"
                               value="<c:out  value='${assetsDeviceRcheckProcDTO.generateByAlias}'/>">
                        <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="generateDate">生成时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="generateDate" id="generateDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceRcheckProcDTO.generateDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="implementationDepartmentAlias">实施部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="implementationDepartment" name="implementationDepartment"
                               value="<c:out  value='${assetsDeviceRcheckProcDTO.implementationDepartment}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="implementationDepartmentAlias"
                               readonly="readonly" name="implementationDepartmentAlias"
                               value="<c:out  value='${assetsDeviceRcheckProcDTO.implementationDepartmentAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="checksNumber">定检设备数:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="checksNumber" id="checksNumber"
                               readonly="readonly" value="<c:out  value='${assetsDeviceRcheckProcDTO.checksNumber}'/>"
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
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="state">状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="state" id="state" readonly="readonly"
                           value="<c:out  value='${assetsDeviceRcheckProcDTO.state}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="telephone">联系电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="telephone" id="telephone" readonly="readonly"
                           value="<c:out  value='${assetsDeviceRcheckProcDTO.telephone}'/>"/>
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <table id="assetsDeviceRcheckPlan"></table>
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
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/assets/device/assetsdevicercheckproc/js/AssetsDeviceRcheckPlan.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var deviceCategoryData = ${deviceCategoryData};
    var regularCheckModeData = ${regularCheckModeData};
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
            editable: false,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'deviceCategory',
                value: deviceCategoryData
            }
        }
        , {label: '设备型号', name: 'deviceModel', width: 150, editable: false}
        , {label: '生产厂家', name: 'manufacturerId', width: 150, editable: false}
        , {
            label: '责任人',
            name: 'ownerIdAlias',
            width: 150,
            editable: false,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'ownerId'}
        }
        , {label: '责任人id', name: 'ownerId', width: 75, hidden: true, editable: false}
        , {
            label: '责任人部门',
            name: 'ownerDeptAlias',
            width: 150,
            editable: false,
            edittype: 'custom',
            editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'ownerDept'}
        }
        , {label: '责任人部门id', name: 'ownerDept', width: 75, hidden: true, editable: false}
        , {label: '安装地点', name: 'positionId', width: 150, editable: false}
        , {
            label: '定检周期',
            name: 'regularCheckCycle',
            width: 150,
            editable: false,
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
            editable: false,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'regularCheckMode',
                value: regularCheckModeData
            }
        }

        , {label: '注册号', name: 'registerId', width: 150, editable: false}
        , {label: '附件', name: 'attachment', width: 150, editable: false}
        , {
            label: '定检检时间',
            name: 'regularCheckDate',
            width: 150,
            edittype: 'custom',
            formatter: format,
            editoptions: {custom_element: dateElem, custom_value: dateValue}
        }
    ];
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
        });

        parent.assetsDeviceRcheckProc.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsDeviceRcheckProcDTO.id}',
            allowAdd: false,
            allowDelete: false
        });
    });
    //form控件禁用
    setFormDisabled();
    $(document).keydown(function (event) {
        event.returnValue = false;
        return false;
    });
</script>
</body>
</html>