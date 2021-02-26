<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>
<%
    String importlibs = "common,form";
    String callBackFnList = request.getParameter("callBackFnList");
    request.getParameter("callBackFnList");// 回调函数名称
    String pid = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetssdequipcollect/assetsSdequipCollectController/operation/Add/null" -->
    <title>添加</title>
    <%
        String userId = SessionHelper.getLoginSysUserId(request);
        SysUser user = SessionHelper.getLoginSysUser(request);
        String userName = user.getName();
        String userDeptId = SessionHelper.getCurrentDeptId(request);
        String userDeptName = SessionHelper.getCurrentDeptName(request);
    %>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<style type="text/css">
    #t_assetsSupplier {
        display: none;
    }

    .isSimple td {
        display: none;
    }

    .isSimple th {
        display: none;
    }

    th {
        text-align: left;
    }

    .form_commonTable {
        border-spacing: 0;
    }

    .form_commonTable tr.commonTableTr th {
        text-align: left;
        background-color: rgba(228, 228, 228, 1);
        border-bottom: 2px solid #ffffff;
        padding: 0 5px;
    }

    .form_commonTable tr.isSimple th {
        text-align: left;
        background-color: rgba(228, 228, 228, 1);
        border-bottom: 2px solid #ffffff;
        padding: 0 5px;
    }

    .tab-paneOne, .tab-paneTwo {
        width: 100%;
        margin-top: 10px;
    }

    .tab-paneOne tr td textarea {
        padding: 6px;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        line-height: 20px;
        font-size: 14px;
        color: #333333;
        width: 100%;
        height: 100px;
        margin-top: 10px;
        border: 1px solid #cccccc;

    }

    .tab-paneTwo tr td textarea {
        padding: 6px;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        line-height: 20px;
        font-size: 14px;
        color: #333333;
        width: 100%;
        height: 50px;
        margin-top: 10px;
        border: 1px solid #cccccc;

    }
</style>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id"/>
        <table class="form_commonTable">
            <tr class="commonTableTr">
                <th width="10%">
                    <label for="stdId">申购单号</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="stdId" id="stdId"/>
                </td>
                <th width="10%">
                    <label for="deviceName">设备名称</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName"
                           id="deviceName"/>
                </td>
                <th width="10%">
                    <label for="deviceCategory">设备类别</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory"
                                  id="deviceCategory" title="" isNull="true"
                                  lookupCode="DEVICE_CATEGORY"/>
                </td>
                <th width="10%">
                    <label for="createdByPersionAlias">申购人</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPersion" name="createdByPersion"
                               value="<%=userId%>">
                        <input class="form-control" placeholder="请选择用户" type="text"
                               id="createdByPersionAlias" name="createdByPersionAlias"
                               aria-invalid="false" value="<%=userName%>">
                        <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
            <tr class="commonTableTr">
                <th width="10%">
                    <label for="createdByDeptAlias">申购部门</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<%=userDeptId%>">
                        <input class="form-control" placeholder="请选择部门" type="text"
                               id="createdByDeptAlias" name="createdByDeptAlias"
                               value="<%=userDeptName%>">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="createdByTel">申购人联系方式</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel"
                           id="createdByTel"/>
                </td>
                <th width="10%">
                    <label for="financialResources">经费来源</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources"
                                  id="financialResources" title="" isNull="true"
                                  lookupCode="FINANCIAL_RESOURCES"/>
                </td>
                <th width="10%">
                    <label for="toProject">所属项目</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="toProject"
                           id="toProject"/>
                </td>

            </tr>
            <tr class="commonTableTr">
                <th width="10%">
                    <label for="approvalName">批复名称</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="approvalName"
                           id="approvalName"/>
                </td>
                <th width="10%">
                    <label for="chiefEngineerAlias">主管总师</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="chiefEngineer" name="chiefEngineer">
                        <input class="form-control" placeholder="请选择用户" type="text"
                               id="chiefEngineerAlias" name="chiefEngineerAlias">
                        <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="projectNum">项目序号</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="projectNum"
                           id="projectNum"/>
                </td>
                <th width="10%">
                    <label for="projectDirectorAlias">项目主管</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="projectDirector" name="projectDirector">
                        <input class="form-control" placeholder="请选择用户" type="text"
                               id="projectDirectorAlias" name="projectDirectorAlias">
                        <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>

            </tr>
            <tr class="commonTableTr">
                <th width="10%">
                    <label for="deviceNum">台（套）数</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="deviceNum" id="deviceNum"
                               data-min="0"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1"
                               data-precision="0">
                        <span class="inpu t-group-addon">
													    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                                class="glyphicon glyphicon-triangle-top"></i></a>
													    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                                class="glyphicon glyphicon-triangle-bottom"></i></a>
													  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="unitPrice">单价(元)</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice"
                               data-min="0"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1"
                               data-precision="3">
                        <span class="input-group-addon">
													    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                                class="glyphicon glyphicon-triangle-top"></i></a>
													    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                                class="glyphicon glyphicon-triangle-bottom"></i></a>
													  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="totalPrice">总金额（元）</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalPrice" id="totalPrice"
                               data-min="0"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1"
                               data-precision="3">
                        <span class="input-group-addon">
													    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                                class="glyphicon glyphicon-triangle-top"></i></a>
													    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                                class="glyphicon glyphicon-triangle-bottom"></i></a>
													  </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="deviceSpec">设备规格</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSpec"
                           id="deviceSpec"/>
                </td>

            </tr>
            <tr class="commonTableTr">

                <%--<th width="10%">--%>
                <%--<label for="formState">单据状态 </label></th>--%>
                <%--<td width="15%">--%>
                <%--<input class="form-control input-sm" type="text" name="formState"--%>
                <%--id="formState"/>--%>
                <%--</td>--%>


                <th width="10%">
                    <label for="deviceModel">设备型号</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceModel"
                           id="deviceModel"/>
                </td>
                <th width="10%">
                    <label for="secretLevel">密级</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel"
                                  id="secretLevel" title="" isNull="true"
                                  lookupCode="SECRET_LEVEL"/>
                </td>
                <th width="10%">
                    <label for="planDeliveryTime">计划到货时间</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="planDeliveryTime"
                               id="planDeliveryTime"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="deviceType">设备类型</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType"
                                  id="deviceType" title="" isNull="true" lookupCode="DEVICE_TYPE"/>
                </td>
                <%--<th width="10%">--%>
                <%--<label for="referencePlant">参考厂家 </label></th>--%>
                <%--<td width="15%">--%>
                <%--<input class="form-control input-sm" type="text" name="referencePlant"--%>
                <%--id="referencePlant"/>--%>
                <%--</td>--%>

            </tr>

            <tr class="commonTableTr">
                <th width="10%">
                    <label for="demandUrgencyDegree">需求紧急程度</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="demandUrgencyDegree"
                                  id="demandUrgencyDegree" title="" isNull="true"
                                  lookupCode="DEMAND_URGENCY_DEGREE"/>
                </td>


                <th width="10%">
                    <label for="isMetering">是否计量</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering"
                                  id="isMetering" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isSceneMetering">是否现场计量</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSceneMetering"
                                  id="isSceneMetering" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isMaintain">是否保养</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMaintain"
                                  id="isMaintain" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>


            </tr>
            <tr class="commonTableTr">
                <th width="10%">
                    <label for="isRegularCheck">是否定检</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isRegularCheck"
                                  id="isRegularCheck" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isSpotCheck">是否点检</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpotCheck"
                                  id="isSpotCheck" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>


                <th width="10%">
                    <label for="isAccuracyCheck">是否精度检查</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAccuracyCheck"
                                  id="isAccuracyCheck" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isSpecialDevice">是否特种设备</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpecialDevice"
                                  id="isSpecialDevice" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

            </tr>
            <tr class="commonTableTr">


                <th width="10%">
                    <label for="isPrecisionIndex">是否精度指标</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPrecisionIndex"
                                  id="isPrecisionIndex" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isNeedInstall">是否需要安装</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall"
                                  id="isNeedInstall" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="installPosition">安装地点</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="installPosition"
                           id="installPosition"/>
                </td>
                <th width="10%">
                    <label for="devicePurchaseCause">设备购置原因</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="devicePurchaseCause"
                           id="devicePurchaseCause"/>
                </td>
            </tr>
            <tr class="commonTableTr">


                <th width="10%">
                    <label for="isFoundation">是否需要地基基础</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFoundation"
                                  id="isFoundation" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isTrain">是否需要设备培训</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTrain" id="isTrain"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isPc">是否是计算机</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isSafetyProduction">是否涉及安全生产</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSafetyProduction"
                                  id="isSafetyProduction" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

            </tr>

            <tr class="commonTableTr">


                <th width="10%">
                    <label for="buyerAlias">采购员</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="buyer" name="buyer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="buyerAlias"
                               name="buyerAlias">
                        <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="planBuyerAlias">采购计划员</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="planBuyer" name="planBuyer">
                        <input class="form-control" placeholder="请选择用户" type="text"
                               id="planBuyerAlias" name="planBuyerAlias">
                        <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="isWireless">是否具有无线功能</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWireless"
                                  id="isWireless" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="devicePurchaseType">设备购置类型</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="devicePurchaseType"
                           id="devicePurchaseType"/>
                </td>
            </tr>
            <tr class="commonTableTr">


                <th width="10%">
                    <label for="technicalIndex02">技术指标</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="technicalIndex02"
                           id="technicalIndex02"/>
                </td>
                <th width="10%">
                    <label for="security">安全性</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="security" id="security"/>
                </td>
                <th width="10%" style="display: none">
                    <label for="security" style="display: none">征集通知单id</label></th>
                <td width="15%" style="display: none">
                    <input class="form-control input-sm" type="text" name="parentId" id="parentId"
                           style="display: none"/>
                </td>
                <th width="10%" style="display: none">
                    <label for="security" style="display: none">上报单id</label></th>
                <td width="15%" style="display: none">
                    <input class="form-control input-sm" type="text" name="attribute01" id="attribute01"
                           style="display: none"/>
                </td>
                <th width="10%">
                    <label for="instituteOrCompany">研究所/公司</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="instituteOrCompany"
                                  id="instituteOrCompany" title="" isNull="true"
                                  lookupCode="INSTITUTE_OR_COMPANY"/>
                </td>
                <th width="10%">
                    <label for="largeDeviceType">简易/大型设备</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="largeDeviceType"
                                  id="largeDeviceType" title="" isNull="true"
                                  lookupCode="LARGE_DEVICE_TYPE"/>
                </td>
            </tr>
            <tr>
            </tr>
            <tr class="isSimple">
                <th width="10%">
                    <label for="isBearingMeet">安装设备楼层承重是否满足</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isBearingMeet"
                                  id="isBearingMeet" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isOutdoorUnit">设备是否有室外机</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOutdoorUnit"
                                  id="isOutdoorUnit" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isAllowOutdoorUnit">所安装位置是否允许安装室外机</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAllowOutdoorUnit"
                                  id="isAllowOutdoorUnit" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">
                    <label for="isNeedFoundation">设备是否需要地基基础</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedFoundation"
                                  id="isNeedFoundation" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr class="isSimple">


                <th width="10%">
                    <label for="isFoundationCondition">所安装位置是否具备设置地基条件</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFoundationCondition"
                                  id="isFoundationCondition" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="serviceVoltage">使用电压</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="serviceVoltage"
                           id="serviceVoltage"/>
                </td>
                <th width="10%">
                    <label for="isVoltageCondition">安装位置是否具备电压条件</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isVoltageCondition"
                                  id="isVoltageCondition" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isHumidityNeed">是否对温湿度有要求</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isHumidityNeed"
                                  id="isHumidityNeed" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr class="isSimple">


                <th width="10%">
                    <label for="humidityNeed">温湿度要求</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="humidityNeed"
                           id="humidityNeed"/>
                </td>
                <th width="10%">
                    <label for="isCleanlinessNeed">是否对洁净度有要求</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isCleanlinessNeed"
                                  id="isCleanlinessNeed" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="cleanlinessNeed">洁净度要求</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="cleanlinessNeed"
                           id="cleanlinessNeed"/>
                </td>

                <th width="10%">
                    <label for="isWaterNeed">是否有用水要求</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWaterNeed"
                                  id="isWaterNeed" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr class="isSimple">


                <th width="10%">
                    <label for="waterNeed">用水要求</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="waterNeed"
                           id="waterNeed"/>
                </td>
                <th width="10%">
                    <label for="isGasNeed">是否有用气要求</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isGasNeed" id="isGasNeed"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="gasNeed">用气要求</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"/>
                </td>

                <th width="10%">
                    <label for="isLet">是否是否有气体、污水排放</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr class="isSimple">


                <th width="10%">
                    <label for="letNeed">气体、污水排放要求</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="letNeed" id="letNeed"/>
                </td>
                <th width="10%">
                    <label for="isOtherNeed">是否有其他特殊要求</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOtherNeed"
                                  id="isOtherNeed" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="otherNeed">其他特殊要求</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="otherNeed"
                           id="otherNeed"/>
                </td>
                <th width="10%">
                    <label for="isNoise">是否有噪音</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNoise" id="isNoise"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr class="isSimple">


                <th width="10%">
                    <label for="isNoiseInfluence">噪音是否影响安装地工作办公</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNoiseInfluence"
                                  id="isNoiseInfluence" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="aboveNeedHave">以上需求条件在拟安装地点是否都已具备</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="aboveNeedHave"
                           id="aboveNeedHave"/>
                </td>

            </tr>
        </table>
        <div class="eform-tab" contenteditable="false" data-mce-style="border: 1px dashed #BBB;">
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" onclick="$(window).trigger('resize');"
                    class="presentation active" contenteditable="false"><a
                        href="#d7452438-a1be-4dff-9192-9be548511185"
                        aria-controls="d7452438-a1be-4dff-9192-9be548511185" role="tab"
                        data-toggle="tab"
                        data-mce-href="#d7452438-a1be-4dff-9192-9be548511185">技术性</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation"
                    contenteditable="false"><a href="#34bb457d-6d56-454f-be69-65de7d2f9679"
                                               aria-controls="34bb457d-6d56-454f-be69-65de7d2f9679"
                                               role="tab" data-toggle="tab"
                                               data-mce-href="#34bb457d-6d56-454f-be69-65de7d2f9679">经济性</a>
                </li>
            </ul>
            <div class="tab-content" style="height: 100%; min-height: 40px;"
                 data-mce-style="height: 100%; min-height: 40px;">
                <div role="tabpanel" class="tab-pane active" contenteditable="true"
                     id="d7452438-a1be-4dff-9192-9be548511185"
                     style="height: 100%; min-height: 40px;"
                     data-mce-style="height: 100%; min-height: 40px;">
                    <table class="tab-paneOne">
                        <tr>
                            <th width="14%">
                                <label for="isWeedOut">是否属于即将产能淘汰设备</label></th>
                            <td width="86%">
                                <pt6:h5select css_class="form-control input-sm" name="isWeedOut"
                                              id="isWeedOut"
                                              title="" isNull="true"
                                              lookupCode="PLATFORM_YES_NO_FLAG"/>
                            </td>
                        </tr>
                        <tr>
                            <th width="14%">
                                <label for="technicalIndex">技术指标</label></th>
                            <td width="86%">
                                <%--<input class="form-control input-sm" type="text" name="technicalIndex"--%>
                                <%--id="technicalIndex"/>--%>
                                <textarea name="technicalIndex" id="technicalIndex" cols="30"
                                          rows="10"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="14%">
                                <label for="deviceReliability">设备可靠性</label></th>
                            <td width="86%">
                                <%--<input class="form-control input-sm" type="text" name="deviceReliability"--%>
                                <%--id="deviceReliability"/>--%>
                                <textarea name="deviceReliability" id="deviceReliability" cols="30"
                                          rows="10"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="14%">
                                <label for="advancement">指标先进性</label></th>
                            <td width="86%">
                                <%--<input class="form-control input-sm" type="text" name="advancement"--%>
                                <%--id="advancement"/>--%>
                                <textarea name="advancement" id="advancement" cols="30"
                                          rows="10"></textarea>
                            </td>

                        </tr>
                    </table>


                </div>
                <div role="tabpanel" class="tab-pane" contenteditable="true"
                     id="34bb457d-6d56-454f-be69-65de7d2f9679"
                     style="height: 100%; min-height: 40px;"
                     data-mce-style="height: 100%; min-height: 40px;">
                    <table class="tab-paneTwo">
                        <tr>
                            <th width="16%">
                                <label for="universality">设备通用性</label></th>
                            <td width="84%">
                                <%--<input class="form-control input-sm" type="text" name="universality"--%>
                                <%--id="universality"/>--%>
                                <textarea name="universality" id="universality" cols="30"
                                          rows="10"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="16%">
                                <label for="useRatio">设备利用率情况</label></th>
                            <td width="84%">
                                <%--<input class="form-control input-sm" type="text" name="useRatio" id="useRatio"/>--%>
                                <textarea name="useRatio" id="useRatio" cols="30"
                                          rows="10"></textarea>
                            </td>

                        </tr>
                        <tr>
                            <th width="16%">
                                <label for="consumableEconomics">设备耗材经济性</label></th>
                            <td width="84%">
                                <%--<input class="form-control input-sm" type="text" name="consumableEconomics"--%>
                                <%--id="consumableEconomics"/>--%>
                                <textarea name="consumableEconomics" id="consumableEconomics"
                                          cols="30" rows="10"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="16%">
                                <label for="notMeetDemand">已有设备为什么不能满足要求</label></th>
                            <td width="84%">
                                <%--<input class="form-control input-sm" type="text" name="notMeetDemand"--%>
                                <%--id="notMeetDemand"/>--%>
                                <textarea name="notMeetDemand" id="notMeetDemand" cols="30"
                                          rows="10"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="16%">
                                <label for="maintainCost">设备维保费用情况</label></th>
                            <td width="84%">
                                <%--<input class="form-control input-sm" type="text" name="maintainCost"--%>
                                <%--id="maintainCost"/>--%>
                                <textarea name="maintainCost" id="maintainCost" cols="30"
                                          rows="10"></textarea>
                            </td>
                        </tr>
                        <tr>

                            <th width="16%">
                                <label for="energyConsumption">设备能耗情况</label></th>
                            <td width="84%">
                                <%--<input class="form-control input-sm" type="text" name="energyConsumption"--%>
                                <%--id="energyConsumption"/>--%>
                                <textarea name="energyConsumption" id="energyConsumption" cols="30"
                                          rows="10"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"
                       id="assetsSdequipCollect_saveForm">保存</a>
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
<!-- 页面脚本 avictabs.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/avictabs.js"></script>
<!-- 时间轴组件 timeliner.js-->
<script type="text/javascript" src="static/h5/timeliner/js/timeliner.js"></script>
<!-- 页面脚本 editForm.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/editForm.js"></script>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowEditor.js"></script>
<!-- 自动编码的js -->
<script src="avicit/platform6/autocode/js/AutoCode.js"></script>
<script src="avicit/assets/device/dynsdcollecmain/js/AssetsSdequipCollect.js" type="text/javascript"></script>
<script src="static/h5/jqGrid-5.2.0/jqGrid.js" type="text/javascript"></script>

<script type="text/javascript">
    //后台获取的通用代码数据
    //初始化通用代码值
    function initOnceInAdd() {
        avicAjax.ajax({
            url: "platform/assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/getLookUpCode",
            type: 'post',
            dataType: 'json',
            async: false,
            success: function (r) {
                if (r.flag == "success") {
                } else {
                    layer.alert('获取失败！' + r.error, {
                            icon: 7,
                            area: ['400px', ''], //宽高
                            closeBtn: 0,
                            btn: ['关闭'],
                            title: "提示"
                        }
                    );
                }
            }
        });
    };

    var afterUploadEvent = null;
    $(document).ready(function () {
        var autoCode = new AutoCode("ASSETS_STDTEMPAPPLY_PROC", "stdId", false, "autoCodeValue", "123");
        var pid = "<%=pid%>";
        var isReload = "true";
        var searchSubNames = "";
        initOnceInAdd(); //初始化通用代码值
        //创建业务操作JS
        //创建流程操作JS

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
        $('.date-picker').datepicker({yearRange: "c-100:c+10"}); //时间控件增加年度选择

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#chiefEngineerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'chiefEngineer', textFiled: 'chiefEngineerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#projectDirectorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
            this.blur();
            nullInput(e);
        });
        $('#buyerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'buyer', textFiled: 'buyerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#planBuyerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'planBuyer', textFiled: 'planBuyerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#createdByPersionAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPersion', textFiled: 'createdByPersionAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
    $("#largeDeviceType").change(function () {
        if ($(this).val() != 1) {
            $(".isSimple>th").show();
            $(".isSimple>td").show();
        } else {
            $(".isSimple>th").hide();
            $(".isSimple>td").hide();
        }
    });
    var deviceNum = 0;
    var unitPrice = 0;
    var totalPrice = 0;
    $("#deviceNum").val(0);
    $("#unitPrice").val(0);
    $("#totalPrice").val(0);
    $("#deviceNum").blur(function () {
        deviceNum = $("#deviceNum").val();
        if (unitPrice != 0) {
            totalPrice = deviceNum * unitPrice;
        }
        $("#totalPrice").val(totalPrice);
    });
    $("#unitPrice").blur(function () {
        unitPrice = $("#unitPrice").val();
        if (deviceNum != 0) {
            totalPrice = deviceNum * unitPrice;
        }
        $("#totalPrice").val(totalPrice);

    });
    // sessionHelper.
    <%--alert(<%=sessionHelper.userId%>);--%>

</script>


<script type="text/javascript">
    $("#parentId").val($("#comId",window.parent.document).val());
    $("#attribute01").val(parent.noticeId);
    var callBackFnList = '<%=callBackFnList%>';
    $("#assetsSdequipCollect_saveForm").on("click", function () {
        save($('#form'), "insert");
        parent["callBackFnList"]();
    })
    $("#assetsSdequipCollect_closeForm").on("click", function () {
        var closewindow = window.parent.document.getElementsByClassName("layui-layer-ico layui-layer-close layui-layer-close1");
        closewindow[0].click();
    })

</script>
</body>
</html>