<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
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
    <!-- ControllerPath = "assets/device/assetsustdtempapplyproc/assetsUstdtempapplyProcController/operation/Detail/id" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id" value="<c:out  value='${assetsUstdtempapplyProcDTO.id}'/>" />
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="stdId">申购单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="stdId"  id="stdId" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.stdId}'/>"/>
                </td>
                <th width="10%">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden"  id="createdByDept" name="createdByDept"  value="<c:out  value='${assetsUstdtempapplyProcDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" readonly="readonly" value="<c:out  value='${assetsUstdtempapplyProcDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel"  id="createdByTel" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.createdByTel}'/>"/>
                </td>
                <th width="10%">
                    <label for="formState">单据状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="formState"  id="formState" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.formState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName"  id="deviceName" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.deviceName}'/>"/>
                </td>
                <th width="10%">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title="" isNull="true" lookupCode="DEVICE_CATEGORY" defaultValue='${assetsUstdtempapplyProcDTO.deviceCategory}'/>
                </td>
                <th width="10%">
                    <label for="manufactureUnit">承制单位:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="manufactureUnit"  id="manufactureUnit" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.manufactureUnit}'/>"/>
                </td>
                <th width="10%">
                    <label for="subjectCode">课题代号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="subjectCode"  id="subjectCode" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.subjectCode}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="competentAuthorityAlias">主管机关:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden"  id="competentAuthority" name="competentAuthority"  value="<c:out  value='${assetsUstdtempapplyProcDTO.competentAuthority}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="competentAuthorityAlias" name="competentAuthorityAlias" readonly="readonly" value="<c:out  value='${assetsUstdtempapplyProcDTO.competentAuthorityAlias}'/>">
                        <span class="input-group-addon">
									  <i class="glyphicon glyphicon-equalizer"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="modelDirectorAlias">型号主管:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden"  id="modelDirector" name="modelDirector"  value="<c:out  value='${assetsUstdtempapplyProcDTO.modelDirector}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="modelDirectorAlias" name="modelDirectorAlias" readonly="readonly" value="<c:out  value='${assetsUstdtempapplyProcDTO.modelDirectorAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="competentLeaderAlias">主管所领导:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden"  id="competentLeader" name="competentLeader"  value="<c:out  value='${assetsUstdtempapplyProcDTO.competentLeader}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="competentLeaderAlias" name="competentLeaderAlias" readonly="readonly" value="<c:out  value='${assetsUstdtempapplyProcDTO.competentLeaderAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="applyReasonPurpose">申购理由及用途:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="applyReasonPurpose" id="applyReasonPurpose">${assetsUstdtempapplyProcDTO.applyReasonPurpose}</textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="orignEquipSituation">原有设备的情况:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="orignEquipSituation" id="orignEquipSituation">${assetsUstdtempapplyProcDTO.orignEquipSituation}</textarea>
                </td>
                <th width="10%">
                    <label for="efficiencySituation">使用效率情况:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="efficiencySituation" id="efficiencySituation">${assetsUstdtempapplyProcDTO.efficiencySituation}</textarea>
                </td>
                <th width="10%">
                    <label for="developmentContent">研制内容:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="developmentContent" id="developmentContent">${assetsUstdtempapplyProcDTO.developmentContent}</textarea>
                </td>
                <th width="10%">
                    <label for="technicalIndex">技术指标:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="technicalIndex" id="technicalIndex">${assetsUstdtempapplyProcDTO.technicalIndex}</textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="developmentCycle">研制周期:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="developmentCycle" id="developmentCycle">${assetsUstdtempapplyProcDTO.developmentCycle}</textarea>
                </td>
                <th width="10%">
                    <label for="isNeedInstall">是否需要安装:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempapplyProcDTO.isNeedInstall}'/>
                </td>
                <th width="10%">
                    <label for="positionId">安装地点ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="positionId"  id="positionId" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.positionId}'/>"/>
                </td>
                <th width="10%">
                    <label for="serviceVoltage">使用电压:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="serviceVoltage"  id="serviceVoltage" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.serviceVoltage}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isHumidityNeed">是否对温湿度有要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isHumidityNeed" id="isHumidityNeed" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempapplyProcDTO.isHumidityNeed}'/>
                </td>
                <th width="10%">
                    <label for="humidityNeed">温湿度要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="humidityNeed" id="humidityNeed">${assetsUstdtempapplyProcDTO.humidityNeed}</textarea>
                </td>
                <th width="10%">
                    <label for="isWaterNeed">是否有用水要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWaterNeed" id="isWaterNeed" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempapplyProcDTO.isWaterNeed}'/>
                </td>
                <th width="10%">
                    <label for="waterNeed">用水要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="waterNeed" id="waterNeed">${assetsUstdtempapplyProcDTO.waterNeed}</textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isGasNeed">是否有用气要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isGasNeed" id="isGasNeed" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempapplyProcDTO.isGasNeed}'/>
                </td>
                <th width="10%">
                    <label for="gasNeed">用气要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="gasNeed" id="gasNeed">${assetsUstdtempapplyProcDTO.gasNeed}</textarea>
                </td>
                <th width="10%">
                    <label for="isLet">是否有气体排放:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempapplyProcDTO.isLet}'/>
                </td>
                <th width="10%">
                    <label for="letNeed">气体排放要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="letNeed" id="letNeed">${assetsUstdtempapplyProcDTO.letNeed}</textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isOtherNeed">是否有其他特殊要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOtherNeed" id="isOtherNeed" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempapplyProcDTO.isOtherNeed}'/>
                </td>
                <th width="10%">
                    <label for="otherNeed">其他特殊要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="otherNeed" id="otherNeed">${assetsUstdtempapplyProcDTO.otherNeed}</textarea>
                </td>
                <th width="10%">
                    <label for="isAboveConditions">以上需求条件在拟安装地点是否都已具备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAboveConditions" id="isAboveConditions" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempapplyProcDTO.isAboveConditions}'/>
                </td>
                <th width="10%">
                    <label for="isMetering">是否计量:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempapplyProcDTO.isMetering}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="meteringRequirement">计量要求:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3"  readonly="readonly"  name="meteringRequirement" id="meteringRequirement">${assetsUstdtempapplyProcDTO.meteringRequirement}</textarea>
                </td>
                <th width="10%">
                    <label for="financialEstimate">经费概算:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input  class="form-control"  type="text" name="financialEstimate" id="financialEstimate" readonly="readonly" value="<c:out  value='${assetsUstdtempapplyProcDTO.financialEstimate}'/>" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="financialResources">经费来源:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources" title="" isNull="true" lookupCode="FINANCIAL_RESOURCES" defaultValue='${assetsUstdtempapplyProcDTO.financialResources}'/>
                </td>
                <th width="10%">
                    <label for="belongProject">所属项目:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="belongProject"  id="belongProject" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.belongProject}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="projectNo">项目序号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="projectNo"  id="projectNo" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.projectNo}'/>"/>
                </td>
                <th width="10%">
                    <label for="replyName">批复名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="replyName"  id="replyName" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.replyName}'/>"/>
                </td>
                <th width="10%">
                    <label for="approvalFormNumber">立项单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="approvalFormNumber"  id="approvalFormNumber" readonly="readonly" value="<c:out value='${assetsUstdtempapplyProcDTO.approvalFormNumber}'/>"/>
                </td>
                <th width="10%">
                    <label for="isTestDevice">是否测试设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsUstdtempapplyProcDTO.isTestDevice}'/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="competentDeviceLeaderAlias">主管设备所领导:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden"  id="competentDeviceLeader" name="competentDeviceLeader"  value="<c:out  value='${assetsUstdtempapplyProcDTO.competentDeviceLeader}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="competentDeviceLeaderAlias" name="competentDeviceLeaderAlias" readonly="readonly" value="<c:out  value='${assetsUstdtempapplyProcDTO.competentDeviceLeaderAlias}'/>">
                        <span class="input-group-addon">
									 <i class="glyphicon glyphicon-user"></i>
								  </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1 %>">
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
            formId: '${assetsUstdtempapplyProcDTO.id}',
            allowAdd: false,
            allowDelete: false
        });
        //form控件禁用
        setFormDisabled();
        $(document).keydown(function(event){
            event.returnValue = false;
            return false;
        });
    });
</script>
</body>
</html>