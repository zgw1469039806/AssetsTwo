<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsoperationcertificate/assetsOperationCertificateController/operation/Edit/id" -->
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id" value="<c:out  value='${assetsOperationDeviceDTO.id}'/>"/>
        <input type="hidden" name="version" value="<c:out  value='${assetsOperationDeviceDTO.version}'/>"/>
        <input type="hidden" name="certificateId" value="<c:out  value='${assetsOperationDeviceDTO.certificateId}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName" readonly="readonly"
                           value="<c:out  value='${assetsOperationDeviceDTO.deviceName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" readonly="readonly"
                           value="<c:out  value='${assetsOperationDeviceDTO.unifiedId}'/>"/>
                </td>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceModel">设备型号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel" readonly="readonly"
                           value="<c:out  value='${assetsOperationDeviceDTO.deviceModel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="ownerIdAlias">责任人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId"
                               value="<c:out  value='${assetsOperationDeviceDTO.ownerId}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" disabled="disabled"
                               name="ownerIdAlias" value="<c:out  value='${assetsOperationDeviceDTO.ownerIdAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-user"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="ownerDeptAlias">责任人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept"
                               value="<c:out  value='${assetsOperationDeviceDTO.ownerDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" disabled="disabled"
                               name="ownerDeptAlias"
                               value="<c:out  value='${assetsOperationDeviceDTO.ownerDeptAlias}'/>">
                        <span class="input-group-addon">
									         <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="positionId">安装位置:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="positionId" id="positionId" readonly="readonly"
                           value="<c:out  value='${assetsOperationDeviceDTO.positionId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="validPeriod">有效期(天):</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="validPeriod" id="validPeriod"
                               value="<c:out  value='${assetsOperationDeviceDTO.validPeriod}'/>"
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
                    <label for="beginDate">生效日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDate" id="beginDate"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsOperationDeviceDTO.beginDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="endDate">失效日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="endDate" id="endDate"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsOperationDeviceDTO.endDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="serialNumber">序号:</label></th>--%>
                <%--<td width="15%">--%>
                    <%--<input class="form-control input-sm" type="text" name="serialNumber" id="serialNumber"--%>
                           <%--value="<c:out  value='${assetsOperationDeviceDTO.serialNumber}'/>"/>--%>
                <%--</td>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="deviceId">设备id:</label></th>--%>
                <td width="15%">
                    <input type="hidden" class="form-control input-sm" type="text" name="deviceId" id="deviceId" readonly="readonly"
                           value="<c:out  value='${assetsOperationDeviceDTO.deviceId}'/>"/>
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
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"
                       id="assetsOperationDevice_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsOperationDevice_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script src="avicit/assets/device/assetsoperationcertificate/js/AssetsOperationDevice.js"></script>

<script type="text/javascript">
    function closeForm() {
        parent.assetsOperationDevice.closeDialog("edit");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        $("#certificateId").val(parent.assetsOperationDevice.pid);
        //限制保存按钮多次点击
        $('#assetsOperationDevice_saveForm').addClass('disabled').unbind("click");
        parent.assetsOperationDevice.save($('#form'), "eidt");
    }

    document.ready = function () {
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
        });

        parent.assetsOperationDevice.formValidate($('#form'));
        //保存按钮绑定事件
        $('#assetsOperationDevice_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsOperationDevice_closeForm').bind('click', function () {
            closeForm();
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

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);

        //设备统一编号绑定弹出选择设备框
        $('#unifiedId').bind('click', function () {
            var operateSelectParam = JSON.stringify({isOperateDeviceSelectPage: "true"});
            openProductModelLayer("false", "", "callBackFn", operateSelectParam);
        });
        //设备名称绑定弹出选择设备框
        $('#deviceName').bind('click', function () {
            var operateSelectParam = JSON.stringify({isOperateDeviceSelectPage: "true"});
            openProductModelLayer("false", "", "callBackFn", operateSelectParam);
        });
    };
</script>
</body>
</html>