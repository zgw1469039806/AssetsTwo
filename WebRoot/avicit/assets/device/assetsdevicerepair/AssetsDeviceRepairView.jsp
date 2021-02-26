<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<HEAD>
    <title>详细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- ControllerPath = "assets/device/assetsdevicerepair/assetsDeviceRepairController/operation/Detail/id" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id" value="<c:out  value='${assetsDeviceRepairDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="applicantIdAlias">申请人:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applicantId" name="applicantId"
                               value="<c:out  value='${assetsDeviceRepairDTO.applicantId}'/>"/>
                        <input class="form-control" placeholder="请选择用户" type="text" id="applicantIdAlias"
                               name="applicantIdAlias" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRepairDTO.applicantIdAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="applicantDepartAlias">申请人部门:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applicantDepart" name="applicantDepart"
                               value="<c:out  value='${assetsDeviceRepairDTO.applicantDepart}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="applicantDepartAlias"
                               name="applicantDepartAlias" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRepairDTO.applicantDepartAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" readonly="readonly"
                           value="<c:out value='${assetsDeviceRepairDTO.unifiedId}'/>"/>
                </td>
                <th width="10%">
                    <label for="formState">表单状态:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState" readonly="readonly"
                           value="<c:out value='${assetsDeviceRepairDTO.formState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deviceName">设备名称:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           readonly="readonly" value="<c:out value='${assetsDeviceRepairDTO.deviceName}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceCategory" id="deviceCategory"
                           readonly="readonly" value="<c:out value='${assetsDeviceRepairDTO.deviceCategory}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deviceSpec">设备规格:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"
                           readonly="readonly" value="<c:out value='${assetsDeviceRepairDTO.deviceSpec}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceModel">设备型号:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"
                           readonly="readonly" value="<c:out value='${assetsDeviceRepairDTO.deviceModel}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="ownerIdAlias">责任人:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId"
                               value="<c:out  value='${assetsDeviceRepairDTO.ownerId}'/>"/>
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias"
                               name="ownerIdAlias" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRepairDTO.ownerIdAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="ownerDeptAlias">责任人部门:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept"
                               value="<c:out  value='${assetsDeviceRepairDTO.ownerDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               name="ownerDeptAlias" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRepairDTO.ownerDeptAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="contact">责任人联系方式:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="contact" id="contact" readonly="readonly"
                           value="<c:out value='${assetsDeviceRepairDTO.contact}'/>"/>
                </td>
                <th width="10%">
                    <label for="position">安装地点:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="position" id="position" readonly="readonly"
                           value="<c:out value='${assetsDeviceRepairDTO.position}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="manufacturer">生产厂家:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="manufacturer" id="manufacturer"
                           readonly="readonly" value="<c:out value='${assetsDeviceRepairDTO.manufacturer}'/>"/>
                </td>
                <th width="10%">
                    <label for="isPc">是否计算机:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsDeviceRepairDTO.isPc}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isTestDevice">是否测试设备:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceRepairDTO.isTestDevice}'/>
                </td>
                <th width="10%">
                    <label for="isMetering">是否需要计量:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceRepairDTO.isMetering}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="repairDeptAlias">维修部门:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairDept" name="repairDept"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="repairDeptAlias"
                               name="repairDeptAlias" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairDeptAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="failureDesc">故障现象描述:</label></th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" name="failureDesc" id="failureDesc"
                              readonly="readonly">${assetsDeviceRepairDTO.failureDesc}</textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="repairDesc">故障维修记录:</label></th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" name="repairDesc" id="repairDesc"
                              readonly="readonly">${assetsDeviceRepairDTO.repairDesc}</textarea>
                </td>
                <th width="10%">
                    <label for="repairFinishTime">维修完成时间:</label></th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="repairFinishTime" readonly="readonly"
                               id="repairFinishTime"
                               value="<fmt:formatDate pattern="yyyy-MM-dd"  value="${assetsDeviceRepairDTO.repairFinishTime}"/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="finishAck">结果确认:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="finishAck" id="finishAck" title=""
                                  isNull="true" lookupCode="RESULT_CHECK"
                                  defaultValue='${assetsDeviceRepairDTO.finishAck}'/>
                </td>
                <th width="10%">
                    <label for="repairQuality">维修质量:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="repairQuality" id="repairQuality" title=""
                                  isNull="true" lookupCode="REPAIR_ASSESSMENT"
                                  defaultValue='${assetsDeviceRepairDTO.repairQuality}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="failureAnalysisId">故障分析:</label></th>
                <td width="39%">
                    <pt6:h5checkbox css_class="checkbox-inline" name="failureAnalysisId" title="" canUse="0"
                                    lookupCode="FAILURE_TYPE_ANALYSE"
                                    defaultValue='${assetsDeviceRepairDTO.failureAnalysisId}'/>
                </td>
                <th width="10%">
                    <label for="failureAnalysisDesc">故障分析描述:</label></th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" name="failureAnalysisDesc" id="failureAnalysisDesc"
                              readonly="readonly">${assetsDeviceRepairDTO.failureAnalysisDesc}</textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="serviceAttitude">服务态度:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="serviceAttitude" id="serviceAttitude" title=""
                                  isNull="true" lookupCode="REPAIR_ASSESSMENT"
                                  defaultValue='${assetsDeviceRepairDTO.serviceAttitude}'/>
                </td>
                <th width="10%">
                    <label for="repairProgress">维修进度:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="repairProgress" id="repairProgress" title=""
                                  isNull="true" lookupCode="REPAIR_ASSESSMENT"
                                  defaultValue='${assetsDeviceRepairDTO.repairProgress}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="repairPlanStaffAlias">维修计划员:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairPlanStaff" name="repairPlanStaff"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairPlanStaff}'/>"/>
                        <input class="form-control" placeholder="请选择用户" type="text" id="repairPlanStaffAlias"
                               name="repairPlanStaffAlias" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairPlanStaffAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="repairStaffAlias">维修员:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairStaff" name="repairStaff"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairStaff}'/>"/>
                        <input class="form-control" placeholder="请选择用户" type="text" id="repairStaffAlias"
                               name="repairStaffAlias" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRepairDTO.repairStaffAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="meterPlanStaffAlias">计量计划员:</label></th>
                <td width="39%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meterPlanStaff" name="meterPlanStaff"
                               value="<c:out  value='${assetsDeviceRepairDTO.meterPlanStaff}'/>"/>
                        <input class="form-control" placeholder="请选择用户" type="text" id="meterPlanStaffAlias"
                               name="meterPlanStaffAlias" readonly="readonly"
                               value="<c:out  value='${assetsDeviceRepairDTO.meterPlanStaffAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="hasExtraExpense">是否存在额外开支:</label></th>
                <td width="39%">
                    <pt6:h5select css_class="form-control input-sm" name="hasExtraExpense" id="hasExtraExpense" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceRepairDTO.hasExtraExpense}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="extraExpenseExplain">额外开支说明:</label></th>
                <td width="39%">
                    <textarea class="form-control input-sm" rows="3" name="extraExpenseExplain" id="extraExpenseExplain"
                              readonly="readonly">${assetsDeviceRepairDTO.extraExpenseExplain}</textarea>
                </td>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=2 * 2 - 1 %>">
                    <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
    //加载完后初始化
    $(document).ready(function () {
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsDeviceRepairDTO.id}',
            allowAdd: false,
            allowDelete: false
        });
        //form控件禁用
        setFormDisabled();
        $(document).keydown(function (event) {
            event.returnValue = false;
            return false;
        });
    });
</script>
</body>
</html>