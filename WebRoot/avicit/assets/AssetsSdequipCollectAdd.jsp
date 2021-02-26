<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetssdequipcollect/assetsSdequipCollectController/operation/Add/null" -->
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="stdId">申购单号:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="stdId" id="stdId"/>
                </td>
                <th width="10%">
                    <label for="createdByPersion">申请人:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="createdByPersion" id="createdByPersion"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="createdByDept">申请人部门:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="createdByDept" id="createdByDept"/>
                </td>
                <th width="10%">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="formState">单据状态:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
                <th width="10%">
                    <label for="deviceName">设备名称:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deviceSpec">设备规格:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
                <th width="10%">
                    <label for="deviceModel">设备型号:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="secretLevel">密级:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="secretLevel" id="secretLevel"/>
                </td>
                <th width="10%">
                    <label for="referencePlant">参考厂家:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="referencePlant" id="referencePlant"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deviceNum">台（套）数:</label></th>
                <td width="39%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="deviceNum" id="deviceNum"
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
                <th width="10%">
                    <label for="unitPrice">单价(元):</label></th>
                <td width="39%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice"
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
            </tr>
            <tr>
                <th width="10%">
                    <label for="totalPrice">总金额（元）:</label></th>
                <td width="39%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalPrice" id="totalPrice"
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
                <th width="10%">
                    <label for="deviceType">设备类型:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceType" id="deviceType"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceCategory" id="deviceCategory"/>
                </td>
                <th width="10%">
                    <label for="isMetering">是否计量:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isMetering" id="isMetering"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isSceneMetering">是否现场计量:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isSceneMetering" id="isSceneMetering"/>
                </td>
                <th width="10%">
                    <label for="isMaintain">是否保养:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isMaintain" id="isMaintain"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isAccuracyCheck">是否精度检查:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isAccuracyCheck" id="isAccuracyCheck"/>
                </td>
                <th width="10%">
                    <label for="isRegularCheck">是否定检:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isRegularCheck" id="isRegularCheck"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isSpotCheck">是否点检:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isSpotCheck" id="isSpotCheck"/>
                </td>
                <th width="10%">
                    <label for="isSpecialDevice">是否特种设备:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isSpecialDevice" id="isSpecialDevice"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isPrecisionIndex">是否精度指标:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isPrecisionIndex" id="isPrecisionIndex"/>
                </td>
                <th width="10%">
                    <label for="isNeedInstall">是否需要安装:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isNeedInstall" id="isNeedInstall"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="installPosition">安装地点:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="installPosition" id="installPosition"/>
                </td>
                <th width="10%">
                    <label for="isFoundation">是否需要地基基础:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isFoundation" id="isFoundation"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isSafetyProduction">是否涉及安全生产:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isSafetyProduction" id="isSafetyProduction"/>
                </td>
                <th width="10%">
                    <label for="financialResources">经费来源:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="financialResources" id="financialResources"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="toProject">所属项目:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="toProject" id="toProject"/>
                </td>
                <th width="10%">
                    <label for="approvalName">批复名称:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="approvalName" id="approvalName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="chiefEngineer">主管总师:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="chiefEngineer" id="chiefEngineer"/>
                </td>
                <th width="10%">
                    <label for="projectNum">项目序号:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="projectNum" id="projectNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="projectDirector">项目主管:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="projectDirector" id="projectDirector"/>
                </td>
                <th width="10%">
                    <label for="demandUrgencyDegree">需求紧急程度:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="demandUrgencyDegree"
                           id="demandUrgencyDegree"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isTrain">是否需要设备培训:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isTrain" id="isTrain"/>
                </td>
                <th width="10%">
                    <label for="isPc">是否是计算机:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isPc" id="isPc"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="planDeliveryTime">计划到货时间:</label></th>
                <td width="39%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="planDeliveryTime"
                               id="planDeliveryTime"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="buyer">采购员:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="buyer" id="buyer"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="planBuyer">采购计划员:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="planBuyer" id="planBuyer"/>
                </td>
                <th width="10%">
                    <label for="isWireless">是否具有无线功能:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isWireless" id="isWireless"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="devicePurchaseType">设备购置类型:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="devicePurchaseType" id="devicePurchaseType"/>
                </td>
                <th width="10%">
                    <label for="devicePurchaseCause">设备购置原因:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="devicePurchaseCause"
                           id="devicePurchaseCause"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="technicalIndex">技术指标:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="technicalIndex" id="technicalIndex"/>
                </td>
                <th width="10%">
                    <label for="technicalIndex02">技术指标:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="technicalIndex02" id="technicalIndex02"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="advancement">指标先进性:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="advancement" id="advancement"/>
                </td>
                <th width="10%">
                    <label for="deviceReliability">设备可靠性:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deviceReliability" id="deviceReliability"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isWeedOut">是否属于即将产能淘汰设备:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isWeedOut" id="isWeedOut"/>
                </td>
                <th width="10%">
                    <label for="notMeetDemand">已有设备为什么不能满足要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="notMeetDemand" id="notMeetDemand"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="useRatio">设备利用率情况:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="useRatio" id="useRatio"/>
                </td>
                <th width="10%">
                    <label for="energyConsumption">设备能耗情况 :</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="energyConsumption" id="energyConsumption"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="consumableEconomics">设备耗材经济性:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="consumableEconomics"
                           id="consumableEconomics"/>
                </td>
                <th width="10%">
                    <label for="universality">设备通用性:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="universality" id="universality"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="maintainCost">设备维保费用情况:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="maintainCost" id="maintainCost"/>
                </td>
                <th width="10%">
                    <label for="security">安全性:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="security" id="security"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isBearingMeet">安装设备楼层承重是否满足:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isBearingMeet" id="isBearingMeet"/>
                </td>
                <th width="10%">
                    <label for="isOutdoorUnit">设备是否有室外机:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isOutdoorUnit" id="isOutdoorUnit"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isAllowOutdoorUnit">所安装位置是否允许安装室外机:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isAllowOutdoorUnit" id="isAllowOutdoorUnit"/>
                </td>
                <th width="10%">
                    <label for="isNeedFoundation">设备是否需要地基基础:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isNeedFoundation" id="isNeedFoundation"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isFoundationCondition">所安装位置是否具备设置地基条件:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isFoundationCondition"
                           id="isFoundationCondition"/>
                </td>
                <th width="10%">
                    <label for="serviceVoltage">使用电压:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="serviceVoltage" id="serviceVoltage"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isVoltageCondition">安装位置是否具备电压条件:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isVoltageCondition" id="isVoltageCondition"/>
                </td>
                <th width="10%">
                    <label for="isHumidityNeed">是否对温湿度有要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isHumidityNeed" id="isHumidityNeed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="humidityNeed">温湿度要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="humidityNeed" id="humidityNeed"/>
                </td>
                <th width="10%">
                    <label for="isCleanlinessNeed">是否对洁净度有要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isCleanlinessNeed" id="isCleanlinessNeed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="cleanlinessNeed">洁净度要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="cleanlinessNeed" id="cleanlinessNeed"/>
                </td>
                <th width="10%">
                    <label for="isWaterNeed">是否有用水要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isWaterNeed" id="isWaterNeed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="waterNeed">用水要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="waterNeed" id="waterNeed"/>
                </td>
                <th width="10%">
                    <label for="isGasNeed">是否有用气要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isGasNeed" id="isGasNeed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="gasNeed">用气要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"/>
                </td>
                <th width="10%">
                    <label for="isLet">是否是否有气体、污水排放:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isLet" id="isLet"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="letNeed">气体、污水排放要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="letNeed" id="letNeed"/>
                </td>
                <th width="10%">
                    <label for="isOtherNeed">是否有其他特殊要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isOtherNeed" id="isOtherNeed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="otherNeed">其他特殊要求:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="otherNeed" id="otherNeed"/>
                </td>
                <th width="10%">
                    <label for="isNoise">是否有噪音:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isNoise" id="isNoise"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isNoiseInfluence">噪音是否影响安装地工作办公:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="isNoiseInfluence" id="isNoiseInfluence"/>
                </td>
                <th width="10%">
                    <label for="aboveNeedHave">以上需求条件在拟安装地点是否都已具备:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="aboveNeedHave" id="aboveNeedHave"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="examineApproveEngineer">审批总师:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="examineApproveEngineer"
                           id="examineApproveEngineer"/>
                </td>
                <th width="10%">
                    <label for="professionalAuditor">专业审核员:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="professionalAuditor"
                           id="professionalAuditor"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="competentLeader">主管所领导:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="competentLeader" id="competentLeader"/>
                </td>
                <th width="10%">
                    <label for="deptHeadConclusion">部门领导结论:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deptHeadConclusion" id="deptHeadConclusion"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deptHeadOpinion">部门领导意见:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="deptHeadOpinion" id="deptHeadOpinion"/>
                </td>
                <th width="10%">
                    <label for="professionalAuditorOpinion">专业审核员意见:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="professionalAuditorOpinion"
                           id="professionalAuditorOpinion"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="chiefEngineerConclusion">总师结论:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="chiefEngineerConclusion"
                           id="chiefEngineerConclusion"/>
                </td>
                <th width="10%">
                    <label for="chiefEngineerOpinion">总师意见:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="chiefEngineerOpinion"
                           id="chiefEngineerOpinion"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="competentLeaderConclusion">主管所领导结论:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="competentLeaderConclusion"
                           id="competentLeaderConclusion"/>
                </td>
                <th width="10%">
                    <label for="competentLeaderOpinion">主管所领导意见:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="competentLeaderOpinion"
                           id="competentLeaderOpinion"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="largeDeviceType">简易/大型设备:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="largeDeviceType" id="largeDeviceType"/>
                </td>
                <th width="10%">
                    <label for="instituteOrCompany">研究所/公司:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="instituteOrCompany" id="instituteOrCompany"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="positionId">安装地点（未使用）:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">
                    <label for="parentId">标准设备年度申购征集通知单id:</label></th>
                <td width="39%">
                    <input class="form-control input-sm" type="text" name="parentId" id="parentId"/>
                </td>
            </tr>
            <tr>
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
                       title="保存" id="assetsSdequipCollect_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsSdequipCollect_closeForm">返回</a>
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
        parent.assetsSdequipCollect.closeDialog("insert");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
        //限制保存按钮多次点击
        $('#assetsSdequipCollect_saveForm').addClass('disabled');
        parent.assetsSdequipCollect.save($('#form'), "insert");
    }

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

        parent.assetsSdequipCollect.formValidate($('#form'));
        //保存按钮绑定事件
        $('#assetsSdequipCollect_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsSdequipCollect_closeForm').bind('click', function () {
            closeForm();
        });


        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>