<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdevicerepair/assetsDeviceRepairController/operation/Edit/id" -->
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsDeviceRepairDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsDeviceRepairDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="applicantIdAlias">申请人:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applicantId" name="applicantId"
                               value="<c:out  value='${assetsDeviceRepairDTO.applicantId}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="applicantIdAlias"
                               name="applicantIdAlias"
                               value="<c:out  value='${assetsDeviceRepairDTO.applicantIdAlias}'/>">
                        <span class="input-group-addon">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="applicantDepartAlias">申请人部门:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applicantDepart" name="applicantDepart"
                               value="<c:out  value='${assetsDeviceRepairDTO.applicantDepart}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="applicantDepartAlias"
                               name="applicantDepartAlias"
                               value="<c:out  value='${assetsDeviceRepairDTO.applicantDepartAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"
                           value="<c:out  value='${assetsDeviceRepairDTO.unifiedId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="formState">表单状态:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState"
                           value="<c:out  value='${assetsDeviceRepairDTO.formState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceName">设备名称:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           value="<c:out  value='${assetsDeviceRepairDTO.deviceName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceCategory" id="deviceCategory"
                           value="<c:out  value='${assetsDeviceRepairDTO.deviceCategory}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceSpec">设备规格:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"
                           value="<c:out  value='${assetsDeviceRepairDTO.deviceSpec}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceModel">设备型号:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"
                           value="<c:out  value='${assetsDeviceRepairDTO.deviceModel}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="ownerIdAlias">责任人:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId"
                               value="<c:out  value='${assetsDeviceRepairDTO.ownerId}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias"
                               name="ownerIdAlias" value="<c:out  value='${assetsDeviceRepairDTO.ownerIdAlias}'/>">
                        <span class="input-group-addon">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="ownerDeptAlias">责任人部门:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept"
                               value="<c:out  value='${assetsDeviceRepairDTO.ownerDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               name="ownerDeptAlias" value="<c:out  value='${assetsDeviceRepairDTO.ownerDeptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="contact">责任人联系方式:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="contact" id="contact"
                           value="<c:out  value='${assetsDeviceRepairDTO.contact}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="position">安装地点:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="position" id="position"
                           value="<c:out  value='${assetsDeviceRepairDTO.position}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="manufacturer">生产厂家:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="manufacturer" id="manufacturer"
                           value="<c:out  value='${assetsDeviceRepairDTO.manufacturer}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isPc">是否计算机:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsDeviceRepairDTO.isPc}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isTestDevice">是否测试设备:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceRepairDTO.isTestDevice}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isMetering">是否需要计量:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceRepairDTO.isMetering}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="repairDeptAlias">维修部门:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairDept" name="repairDept"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="repairDeptAlias"
                               name="repairDeptAlias"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairDeptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="failureDesc">故障现象描述:</label></th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" name="failureDesc" id="failureDesc"><c:out
                            value='${assetsDeviceRepairDTO.failureDesc}'/></textarea>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="repairDesc">故障维修记录:</label></th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" name="repairDesc" id="repairDesc"><c:out
                            value='${assetsDeviceRepairDTO.repairDesc}'/></textarea>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="repairFinishTime">维修完成时间:</label></th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="repairFinishTime"
                               id="repairFinishTime"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceRepairDTO.repairFinishTime}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="finishAck">结果确认:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="finishAck" id="finishAck" title=""
                                  isNull="true" lookupCode="RESULT_CHECK"
                                  defaultValue='${assetsDeviceRepairDTO.finishAck}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="repairQuality">维修质量:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="repairQuality" id="repairQuality" title=""
                                  isNull="true" lookupCode="REPAIR_ASSESSMENT"
                                  defaultValue='${assetsDeviceRepairDTO.repairQuality}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="failureAnalysisId">故障分析:</label></th>
                <td width="39%">
                    <pt6:h5checkbox css_class="checkbox-inline" name="failureAnalysisId" title="" canUse="0"
                                    lookupCode="FAILURE_TYPE_ANALYSE"
                                    defaultValue='${assetsDeviceRepairDTO.failureAnalysisId}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="failureAnalysisDesc">故障分析描述:</label></th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" name="failureAnalysisDesc"
                              id="failureAnalysisDesc"><c:out
                            value='${assetsDeviceRepairDTO.failureAnalysisDesc}'/></textarea>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="serviceAttitude">服务态度:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="serviceAttitude" id="serviceAttitude" title=""
                                  isNull="true" lookupCode="REPAIR_ASSESSMENT"
                                  defaultValue='${assetsDeviceRepairDTO.serviceAttitude}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="repairProgress">维修进度:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="repairProgress" id="repairProgress" title=""
                                  isNull="true" lookupCode="REPAIR_ASSESSMENT"
                                  defaultValue='${assetsDeviceRepairDTO.repairProgress}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="repairPlanStaffAlias">维修计划员:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairPlanStaff" name="repairPlanStaff"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairPlanStaff}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="repairPlanStaffAlias"
                               name="repairPlanStaffAlias"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairPlanStaffAlias}'/>">
                        <span class="input-group-addon">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="repairStaffAlias">维修员:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairStaff" name="repairStaff"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairStaff}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="repairStaffAlias"
                               name="repairStaffAlias"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairStaffAlias}'/>">
                        <span class="input-group-addon">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="meterPlanStaffAlias">计量计划员:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meterPlanStaff" name="meterPlanStaff"
                               value="<c:out  value='${assetsDeviceRepairDTO.meterPlanStaff}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="meterPlanStaffAlias"
                               name="meterPlanStaffAlias"
                               value="<c:out  value='${assetsDeviceRepairDTO.meterPlanStaffAlias}'/>">
                        <span class="input-group-addon">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="hasExtraExpense">是否存在额外开支:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="hasExtraExpense" id="hasExtraExpense" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceRepairDTO.hasExtraExpense}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="extraExpenseExplain">额外开支说明:</label></th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" name="extraExpenseExplain"
                              id="extraExpenseExplain"><c:out
                            value='${assetsDeviceRepairDTO.extraExpenseExplain}'/></textarea>
                </td>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=2 * 2 - 1%>">
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
                       title="保存" id="assetsDeviceRepair_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsDeviceRepair_closeForm">返回</a>
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
        parent.assetsDeviceRepair.closeDialog(window.name);
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        //验证附件密级
        var files = $('#attachment').uploaderExt('getUploadFiles');
        for (var i = 0; i < files.length; i++) {
            var name = files[i].name;
            var secretLevel = files[i].secretLevel;
            //这里验证密级
        }
        //限制保存按钮多次点击
        $('#assetsDeviceRepair_saveForm').addClass('disabled').unbind("click");
        parent.assetsDeviceRepair.save($('#form'), window.name, callback);
    }

    //附件操作
    function callback(id) {
        var files = $('#attachment').uploaderExt('getUploadFiles');
        if (files == 0) {
            closeForm();
        } else {
            $("#id").val(id);
            $('#attachment').uploaderExt('doUpload', id);
        }
    }//上传附件完成后操作
    function afterUploadEvent() {
        closeForm();
    }

    /**
     * 加载完后初始化
     */
    $(document).ready(function () {
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
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsDeviceRepairDTO.id}',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: afterUploadEvent
        });
        //绑定表单验证规则
        parent.assetsDeviceRepair.formValidate($('#form'));
        //保存按钮绑定事件
        $('#assetsDeviceRepair_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsDeviceRepair_closeForm').bind('click', function () {
            closeForm();
        });

        $('#applicantIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'applicantId', textFiled: 'applicantIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#applicantDepartAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'applicantDepart', textFiled: 'applicantDepartAlias'});
            this.blur();
            nullInput(e);
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
        $('#repairDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'repairDept', textFiled: 'repairDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#repairPlanStaffAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'repairPlanStaff', textFiled: 'repairPlanStaffAlias'});
            this.blur();
            nullInput(e);
        });
        $('#repairStaffAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'repairStaff', textFiled: 'repairStaffAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meterPlanStaffAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meterPlanStaff', textFiled: 'meterPlanStaffAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>