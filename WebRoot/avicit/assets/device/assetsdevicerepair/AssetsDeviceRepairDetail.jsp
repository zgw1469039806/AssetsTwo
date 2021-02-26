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
    String formId = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdevicerepair/assetsDeviceRepairController/operation/toDetailJsp" -->
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
    <!-- 当前页 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/editForm.css">
    <!-- 定制tab标签样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/avictabs.css">
    <!-- 流程标签 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/workflow.css">
    <!-- 时间轴 样式 -->
    <link rel="stylesheet" type="text/css" href="static/h5/timeliner/css/timeliner.css">
</head>
<body>
<div class="main">
    <!-- 右侧工具栏 Start -->
    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttons.jsp" %>
    <!-- 右侧工具栏 End -->
    <!-- 正文内容 Start -->
    <div class="content">
        <!-- 简单tab Start -->
        <div class="avic-tab">
            <div class="tab-bar">
                <ul>
                    <li class="on">表单信息</li>
                    <li>流程跟踪</li>
                    <li>引用文档</li>
                    <li>关联流程</li>
                </ul>
            </div>
            <div class="btn-bar on">
                <!-- 暂存 关注 正文 等流程代理的按钮 -->
                <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttonBar.jsp" %>
            </div>
            <div class="tab-panel">
                <div class="panel-body on">
                    <div class="panel-main">
                        <!-- 业务表单 Start -->
                        <form id='form'>
                            <input type="hidden" name="id" id="id"/>
                            <input type="hidden" name="version" id="version"/>
                            <table class="form_commonTable">
                                <tr>
                                    <th width="10%">
                                        <label for="applicantIdAlias">申请人:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="applicantId" name="applicantId" value="<%=userId%>">
                                            <input class="form-control" placeholder="请选择用户" type="text"
                                                   id="applicantIdAlias" name="applicantIdAlias" value="<%=userName%>">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="applicantDepartAlias">申请人部门:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="applicantDepart" name="applicantDepart" value="<%=userDeptId%>">
                                            <input class="form-control" placeholder="请选择部门" type="text"
                                                   id="applicantDepartAlias" name="applicantDepartAlias" value="<%=userDeptName%>">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="ownerIdAlias">责任人:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="ownerId" name="ownerId">
                                            <input class="form-control" placeholder="请选择用户" type="text"
                                                   id="ownerIdAlias" name="ownerIdAlias">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="ownerDeptAlias">责任人部门:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="ownerDept" name="ownerDept">
                                            <input class="form-control" placeholder="请选择部门" type="text"
                                                   id="ownerDeptAlias" name="ownerDeptAlias">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="unifiedId">统一编号:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="unifiedId"
                                               id="unifiedId"/>
                                    </td>
                                    <th width="10%">
                                        <label for="deviceName">设备名称:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="deviceName"
                                               id="deviceName"/>
                                    </td>
                                    <th width="10%">
                                        <label for="deviceCategory">设备类别:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="deviceCategory"
                                               id="deviceCategory"/>
                                    </td>
                                    <th width="10%">
                                        <label for="deviceModel">设备型号:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="deviceModel"
                                               id="deviceModel"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="deviceSpec">设备规格:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="deviceSpec"
                                               id="deviceSpec"/>
                                    </td>
                                    <th width="10%">
                                        <label for="position">安装地点:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="position" id="position"/>
                                    </td>
                                    <th width="10%">
                                        <label for="manufacturer">生产厂家:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="manufacturer"
                                               id="manufacturer"/>
                                    </td>
                                    <th width="10%">
                                        <label for="repairDeptAlias">维修部门:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="repairDept" name="repairDept">
                                            <input class="form-control" placeholder="请选择部门" type="text"
                                                   id="repairDeptAlias" name="repairDeptAlias">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="isPc">是否计算机:</label></th>
                                    <td width="15%">
                                        <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title=""
                                                      isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                                    </td>
                                    <th width="10%">
                                        <label for="isTestDevice">是否测试设备:</label></th>
                                    <td width="15%">
                                        <pt6:h5select css_class="form-control input-sm" name="isTestDevice"
                                                      id="isTestDevice" title="" isNull="true"
                                                      lookupCode="PLATFORM_YES_NO_FLAG"/>
                                    </td>
                                    <th width="10%">
                                        <label for="isMetering">是否需要计量:</label></th>
                                    <td width="15%">
                                        <pt6:h5select css_class="form-control input-sm" name="isMetering"
                                                      id="isMetering" title="" isNull="true"
                                                      lookupCode="PLATFORM_YES_NO_FLAG"/>
                                    </td>
                                    <th width="10%">
                                        <label for="hasExtraExpense">是否存在额外开支:</label></th>
                                    <td width="15%">
                                        <pt6:h5select css_class="form-control input-sm" name="hasExtraExpense"
                                                      id="hasExtraExpense" title="" isNull="true"
                                                      lookupCode="PLATFORM_YES_NO_FLAG"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="repairPlanStaffAlias">维修计划员:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="repairPlanStaff" name="repairPlanStaff">
                                            <input class="form-control" placeholder="请选择用户" type="text"
                                                   id="repairPlanStaffAlias" name="repairPlanStaffAlias">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="repairStaffAlias">维修员:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="repairStaff" name="repairStaff">
                                            <input class="form-control" placeholder="请选择用户" type="text"
                                                   id="repairStaffAlias" name="repairStaffAlias">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                    <th width="10%">
                                        <label for="meterPlanStaffAlias">计量计划员:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="meterPlanStaff" name="meterPlanStaff">
                                            <input class="form-control" placeholder="请选择用户" type="text"
                                                   id="meterPlanStaffAlias" name="meterPlanStaffAlias">
                                            <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="failureDesc">故障现象描述:</label></th>
                                    <td width="90%" colspan="7">
                                        <textarea class="form-control input-sm" rows="3" name="failureDesc"
                                                  id="failureDesc"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="failureAnalysisId">故障分析:</label></th>
                                    <td width="90%" colspan="7">
                                        <pt6:h5checkbox css_class="checkbox-inline" name="failureAnalysisId" title=""
                                                        canUse="0" lookupCode="FAILURE_TYPE_ANALYSE"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="failureAnalysisDesc">故障分析描述:</label></th>
                                    <td width="90%" colspan="7">
                                            <textarea class="form-control input-sm" rows="3" name="failureAnalysisDesc"
                                                      id="failureAnalysisDesc"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="repairDesc">故障维修记录:</label></th>
                                    <td width="90%" colspan="7">
                                        <textarea class="form-control input-sm" rows="3" name="repairDesc"
                                                  id="repairDesc"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="finishAck">结果确认:</label></th>
                                    <td width="15%">
                                        <pt6:h5select css_class="form-control input-sm" name="finishAck" id="finishAck"
                                                      title="" isNull="true" lookupCode="RESULT_CHECK"/>
                                    </td>
                                    <th width="10%">
                                        <label for="repairQuality">维修质量:</label></th>
                                    <td width="15%">
                                        <pt6:h5select css_class="form-control input-sm" name="repairQuality"
                                                      id="repairQuality" title="" isNull="true"
                                                      lookupCode="REPAIR_ASSESSMENT"/>
                                    </td>
                                    <th width="10%">
                                        <label for="serviceAttitude">服务态度:</label></th>
                                    <td width="15%">
                                        <pt6:h5select css_class="form-control input-sm" name="serviceAttitude"
                                                      id="serviceAttitude" title="" isNull="true"
                                                      lookupCode="REPAIR_ASSESSMENT"/>
                                    </td>
                                    <th width="10%">
                                        <label for="repairProgress">维修进度:</label></th>
                                    <td width="15%">
                                        <pt6:h5select css_class="form-control input-sm" name="repairProgress"
                                                      id="repairProgress" title="" isNull="true"
                                                      lookupCode="REPAIR_ASSESSMENT"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="extraExpenseExplain">额外开支说明:</label></th>
                                    <td width="90%" colspan="7">
                                        <textarea class="form-control input-sm" rows="3" name="extraExpenseExplain"
                                                  id="extraExpenseExplain"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="repairFinishTime">维修完成时间:</label></th>
                                    <td width="15%" >
                                        <div class="input-group input-group-sm">
                                            <input class="form-control date-picker" type="text" name="repairFinishTime"
                                                   id="repairFinishTime"/><span class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
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
                        <!-- 业务表单 End -->
                    </div>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/tracks.jsp" %>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/files.jsp" %>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/processlevel.jsp" %>
                </div>
            </div>
        </div>
        <!-- 简单tab End -->
    </div>
    <!-- 正文内容 End -->
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 页面脚本 avictabs.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/avictabs.js"></script>
<!-- 时间轴组件 timeliner.js-->
<script type="text/javascript" src="static/h5/timeliner/js/timeliner.js"></script>
<!-- 页面脚本 editForm.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/editForm.js"></script>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowEditor.js"></script>
<!-- 业务的js -->
<script src="avicit/assets/device/assetsdevicerepair/js/AssetsDeviceRepairDetail.js"></script>
<script type="text/javascript">
    //注册附件上传完毕后执行的方法
    var afterUploadEvent = null;
    $(document).ready(function () {
        //创建业务操作JS
        var assetsDeviceRepairDetail = new AssetsDeviceRepairDetail('form');
        //创建流程操作JS
        new FlowEditor(assetsDeviceRepairDetail);

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
            formId: '<%=formId%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //绑定表单验证规则
        assetsDeviceRepairDetail.formValidate($('#form'));

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