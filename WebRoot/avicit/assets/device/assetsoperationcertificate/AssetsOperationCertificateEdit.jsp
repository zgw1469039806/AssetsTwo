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
        <input type="hidden" name="version" value="<c:out  value='${assetsOperationCertificateDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsOperationCertificateDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="certificateName">操作证名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="certificateName" id="certificateName"
                           value="<c:out  value='${assetsOperationCertificateDTO.certificateName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="certificateNum">操作证编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="certificateNum" id="certificateNum"
                           value="<c:out  value='${assetsOperationCertificateDTO.certificateNum}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="certificateType">操作证类型:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="certificateType" id="certificateType" title=""
                                  isNull="true" lookupCode="CERTIFICATE_TYPE"
                                  defaultValue='${assetsOperationCertificateDTO.certificateType}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="certificateStatus">操作证状态:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="certificateStatus" id="certificateStatus"
                                  title="" isNull="true" lookupCode="CERTIFICATE_STATUS"
                                  defaultValue='${assetsOperationCertificateDTO.certificateStatus}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="certificateDeviceCount">操作证设备数量:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="certificateDeviceCount"
                               id="certificateDeviceCount"
                               value="<c:out  value='${assetsOperationCertificateDTO.certificateDeviceCount}'/>"
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
                    <label for="certificateInfo">操作证描述:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="certificateInfo" id="certificateInfo"
                           value="<c:out  value='${assetsOperationCertificateDTO.certificateInfo}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="holderIdAlias">持证人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="holderId" name="holderId"
                               value="<c:out  value='${assetsOperationCertificateDTO.holderId}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="holderIdAlias"
                               name="holderIdAlias"
                               value="<c:out  value='${assetsOperationCertificateDTO.holderIdAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-user"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="holderDeptAlias">持证人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="holderDept" name="holderDept"
                               value="<c:out  value='${assetsOperationCertificateDTO.holderDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="holderDeptAlias"
                               name="holderDeptAlias"
                               value="<c:out  value='${assetsOperationCertificateDTO.holderDeptAlias}'/>">
                        <span class="input-group-addon">
							                 <i class="glyphicon glyphicon-equalizer"></i>
							              </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="holderPhone">持证人联系方式:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="holderPhone" id="holderPhone"
                           value="<c:out  value='${assetsOperationCertificateDTO.holderPhone}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="managerDeptAlias">发证部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="managerDept" name="managerDept"
                               value="<c:out  value='${assetsOperationCertificateDTO.managerDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="managerDeptAlias"
                               name="managerDeptAlias"
                               value="<c:out  value='${assetsOperationCertificateDTO.managerDeptAlias}'/>">
                        <span class="input-group-addon">
							                 <i class="glyphicon glyphicon-equalizer"></i>
							              </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="managerIdAlias">发证人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="managerId" name="managerId"
                               value="<c:out  value='${assetsOperationCertificateDTO.managerId}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="managerIdAlias"
                               name="managerIdAlias"
                               value="<c:out  value='${assetsOperationCertificateDTO.managerIdAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-user"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdDate">发证日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDate" id="createdDate"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsOperationCertificateDTO.createdDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <%--<tr>--%>
                <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                    <%--<label for="serialNumber">序号:</label></th>--%>
                <%--<td width="15%">--%>
                    <%--<input class="form-control input-sm" type="text" name="serialNumber" id="serialNumber"--%>
                           <%--value="<c:out  value='${assetsOperationCertificateDTO.serialNumber}'/>"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
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
                       id="assetsOperationCertificate_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsOperationCertificate_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
    function closeForm() {
        parent.assetsOperationCertificate.closeDialog("edit");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        //限制保存按钮多次点击
        $('#assetsOperationCertificate_saveForm').addClass('disabled').unbind("click");
        parent.assetsOperationCertificate.save($('#form'), "eidt");
    }

    document.ready = function () {
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

        parent.assetsOperationCertificate.formValidate($('#form'));
        //保存按钮绑定事件
        $('#assetsOperationCertificate_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsOperationCertificate_closeForm').bind('click', function () {
            closeForm();
        });

        $('#holderIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'holderId', textFiled: 'holderIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#holderDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'holderDept', textFiled: 'holderDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#managerDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'managerDept', textFiled: 'managerDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#managerIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'managerId', textFiled: 'managerIdAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    };
</script>
</body>
</html>