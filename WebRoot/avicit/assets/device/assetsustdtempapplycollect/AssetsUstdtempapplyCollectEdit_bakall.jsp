<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsustdtempapplycollect/assetsUstdtempapplyCollectController/operation/Edit/id" -->
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsUstdtempapplyCollectDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsUstdtempapplyCollectDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="stdId">申购单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="stdId" id="stdId"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.stdId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.createdByTel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="formState">单据状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.formState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.deviceName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title=""
                                  isNull="true" lookupCode="DEVICE_CATEGORY"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.deviceCategory}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="manufactureUnitAlias">承制单位:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="manufactureUnit" name="manufactureUnit"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.manufactureUnit}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="manufactureUnitAlias"
                               name="manufactureUnitAlias"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.manufactureUnitAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="subjectCode">课题代号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="subjectCode" id="subjectCode"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.subjectCode}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="competentAuthorityAlias">主管机关:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="competentAuthority" name="competentAuthority"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.competentAuthority}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="competentAuthorityAlias"
                               name="competentAuthorityAlias"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.competentAuthorityAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="modelDirectorAlias">型号主管:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="modelDirector" name="modelDirector"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.modelDirector}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="modelDirectorAlias"
                               name="modelDirectorAlias"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.modelDirectorAlias}'/>">
                        <span class="input-group-addon">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="competentLeaderAlias">主管所领导:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="competentLeader" name="competentLeader"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.competentLeader}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="competentLeaderAlias"
                               name="competentLeaderAlias"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.competentLeaderAlias}'/>">
                        <span class="input-group-addon">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="applyReasonPurpose">申购理由及用途:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="applyReasonPurpose" id="applyReasonPurpose"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.applyReasonPurpose}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="orignEquipSituation">原有设备的情况:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="orignEquipSituation" id="orignEquipSituation"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.orignEquipSituation}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="efficiencySituation">使用效率情况:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="efficiencySituation" id="efficiencySituation"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.efficiencySituation}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="developmentContent">研制内容:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="developmentContent" id="developmentContent"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.developmentContent}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="technicalIndex">技术指标:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="technicalIndex" id="technicalIndex"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.technicalIndex}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="developmentCycle">研制周期:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="developmentCycle" id="developmentCycle"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.developmentCycle}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNeedInstall">是否需要安装:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.isNeedInstall}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="positionId">安装地点ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="positionId" id="positionId"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.positionId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="serviceVoltage">使用电压:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="serviceVoltage" id="serviceVoltage"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.serviceVoltage}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isHumidityNeed">是否对温湿度有要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isHumidityNeed" id="isHumidityNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.isHumidityNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="humidityNeed">温湿度要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="humidityNeed" id="humidityNeed"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.humidityNeed}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isWaterNeed">是否有用水要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWaterNeed" id="isWaterNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.isWaterNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="waterNeed">用水要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="waterNeed" id="waterNeed"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.waterNeed}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isGasNeed">是否有用气要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isGasNeed" id="isGasNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.isGasNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="gasNeed">用气要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.gasNeed}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isLet">是否有气体排放:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.isLet}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="letNeed">气体排放要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="letNeed" id="letNeed"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.letNeed}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isOtherNeed">是否有其他特殊要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOtherNeed" id="isOtherNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.isOtherNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="otherNeed">其他特殊要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="otherNeed" id="otherNeed"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.otherNeed}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isAboveConditions">以上需求条件在拟安装地点是否都已具备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAboveConditions" id="isAboveConditions"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.isAboveConditions}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isMetering">是否计量:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.isMetering}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="meteringRequirement">计量要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="meteringRequirement" id="meteringRequirement"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.meteringRequirement}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="financialEstimate">经费概算:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="financialEstimate" id="financialEstimate"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.financialEstimate}'/>"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
											    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                        class="glyphicon glyphicon-triangle-top"></i></a>
											    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                        class="glyphicon glyphicon-triangle-bottom"></i></a>
											  </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="financialResources">经费来源:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources"
                                  title="" isNull="true" lookupCode="FINANCIAL_RESOURCES"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.financialResources}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="belongProject">所属项目:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="belongProject" id="belongProject"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.belongProject}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="projectNo">项目序号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="projectNo" id="projectNo"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.projectNo}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="replyName">批复名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="replyName" id="replyName"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.replyName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="approvalFormNumber">立项单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="approvalFormNumber" id="approvalFormNumber"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.approvalFormNumber}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isTestDevice">是否测试设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsUstdtempapplyCollectDTO.isTestDevice}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="competentDeviceLeaderAlias">主管设备所领导:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="competentDeviceLeader" name="competentDeviceLeader"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.competentDeviceLeader}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="competentDeviceLeaderAlias"
                               name="competentDeviceLeaderAlias"
                               value="<c:out  value='${assetsUstdtempapplyCollectDTO.competentDeviceLeaderAlias}'/>">
                        <span class="input-group-addon">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="headerId">主表id:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="headerId" id="headerId"
                           value="<c:out  value='${assetsUstdtempapplyCollectDTO.headerId}'/>"/>
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
                       title="保存" id="assetsUstdtempapplyCollect_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsUstdtempapplyCollect_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/assets/device/assetsustdtempapplycollect/js/AssetsUstdtempapplyCollect.js"></script>
<script type="text/javascript">
    function closeForm() {
        parent.assetsUstdtempapplyCollect.closeDialog("edit");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
        //限制保存按钮多次点击
        $('#assetsUstdtempapplyCollect_saveForm').addClass('disabled');
        save($('#form'), "eidt");
    }

    $(document).ready(function () {
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
        });

       // parent.assetsUstdtempapplyCollect.formValidate($('#form'));
        //保存按钮绑定事件
        $('#assetsUstdtempapplyCollect_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsUstdtempapplyCollect_closeForm').bind('click', function () {
            closeForm();
        });

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#manufactureUnitAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'manufactureUnit', textFiled: 'manufactureUnitAlias'});
            this.blur();
            nullInput(e);
        });
        $('#competentAuthorityAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'deptSelect',
                idFiled: 'competentAuthority',
                textFiled: 'competentAuthorityAlias'
            });
            this.blur();
            nullInput(e);
        });
        $('#modelDirectorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'modelDirector', textFiled: 'modelDirectorAlias'});
            this.blur();
            nullInput(e);
        });

        $('#competentLeaderAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'competentLeader', textFiled: 'competentLeaderAlias'});
            this.blur();
            nullInput(e);
        });

        $('#competentDeviceLeaderAlias').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'competentDeviceLeader',
                textFiled: 'competentDeviceLeaderAlias'
            });
            this.blur();
            nullInput(e);
        });


        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>