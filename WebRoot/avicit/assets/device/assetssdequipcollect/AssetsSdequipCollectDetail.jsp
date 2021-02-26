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
    <!-- ControllerPath = "assets/device/assetssdequipcollect/assetsSdequipCollectController/operation/Edit/id" -->
    <title>详细</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsSdequipCollectDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsSdequipCollectDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByPersionAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPersion" name="createdByPersion"
                               value="<c:out  value='${assetsSdequipCollectDTO.createdByPersion}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersionAlias"
                               readonly="readonly" name="createdByPersionAlias"
                               value="<c:out  value='${assetsSdequipCollectDTO.createdByPersionAlias}'/>">
                        <span class="input-group-addon">
									           <i class="glyphicon glyphicon-user"></i>
									          </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsSdequipCollectDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias" readonly="readonly"
                               value="<c:out  value='${assetsSdequipCollectDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon">
									         <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.createdByTel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="formState">单据状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.formState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.deviceName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceSpec">设备规格:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.deviceSpec}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceModel">设备型号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.deviceModel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="secretLevel">密级:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title=""
                                  isNull="true" lookupCode="SECRET_LEVEL"
                                  defaultValue='${assetsSdequipCollectDTO.secretLevel}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="referencePlant">参考厂家:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="referencePlant" id="referencePlant"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.referencePlant}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceNum">台（套）数:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="deviceNum" id="deviceNum" readonly="readonly"
                               value="<c:out  value='${assetsSdequipCollectDTO.deviceNum}'/>"
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
                    <label for="unitPrice">单价(元):</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice" readonly="readonly"
                               value="<c:out  value='${assetsSdequipCollectDTO.unitPrice}'/>"
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
                    <label for="totalPrice">总金额（元）:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalPrice" id="totalPrice" readonly="readonly"
                               value="<c:out  value='${assetsSdequipCollectDTO.totalPrice}'/>"
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
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceType">设备类型:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType" id="deviceType" title=""
                                  isNull="true" lookupCode="DEVICE_TYPE"
                                  defaultValue='${assetsSdequipCollectDTO.deviceType}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title=""
                                  isNull="true" lookupCode="DEVICE_CATEGORY"
                                  defaultValue='${assetsSdequipCollectDTO.deviceCategory}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isMetering">是否计量:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isMetering}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSceneMetering">是否现场计量:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSceneMetering" id="isSceneMetering" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isSceneMetering}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isMaintain">是否保养:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMaintain" id="isMaintain" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isMaintain}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isAccuracyCheck">是否精度检查:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAccuracyCheck" id="isAccuracyCheck" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isAccuracyCheck}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isRegularCheck">是否定检:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isRegularCheck" id="isRegularCheck" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isRegularCheck}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSpotCheck">是否点检:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpotCheck" id="isSpotCheck" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isSpotCheck}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSpecialDevice">是否特种设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpecialDevice" id="isSpecialDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isSpecialDevice}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isPrecisionIndex">是否精度指标:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPrecisionIndex" id="isPrecisionIndex"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isPrecisionIndex}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNeedInstall">是否需要安装:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isNeedInstall}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="installPosition">安装地点:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="installPosition" id="installPosition"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.installPosition}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isFoundation">是否需要地基基础:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFoundation" id="isFoundation" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isFoundation}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSafetyProduction">是否涉及安全生产:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isSafetyProduction}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="financialResources">经费来源:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources"
                                  title="" isNull="true" lookupCode="FINANCIAL_RESOURCES"
                                  defaultValue='${assetsSdequipCollectDTO.financialResources}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="toProject">所属项目:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="toProject" id="toProject" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.toProject}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="approvalName">批复名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="approvalName" id="approvalName"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.approvalName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="chiefEngineerAlias">主管总师:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="chiefEngineer" name="chiefEngineer"
                               value="<c:out  value='${assetsSdequipCollectDTO.chiefEngineer}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="chiefEngineerAlias"
                               readonly="readonly" name="chiefEngineerAlias"
                               value="<c:out  value='${assetsSdequipCollectDTO.chiefEngineerAlias}'/>">
                        <span class="input-group-addon">
									           <i class="glyphicon glyphicon-user"></i>
									          </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="projectNum">项目序号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="projectNum" id="projectNum"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.projectNum}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="projectDirectorAlias">项目主管:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="projectDirector" name="projectDirector"
                               value="<c:out  value='${assetsSdequipCollectDTO.projectDirector}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias"
                               readonly="readonly" name="projectDirectorAlias"
                               value="<c:out  value='${assetsSdequipCollectDTO.projectDirectorAlias}'/>">
                        <span class="input-group-addon">
									           <i class="glyphicon glyphicon-user"></i>
									          </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="demandUrgencyDegree">需求紧急程度:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="demandUrgencyDegree" id="demandUrgencyDegree"
                                  title="" isNull="true" lookupCode="DEMAND_URGENCY_DEGREE"
                                  defaultValue='${assetsSdequipCollectDTO.demandUrgencyDegree}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isTrain">是否需要设备培训:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTrain" id="isTrain" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsSdequipCollectDTO.isTrain}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isPc">是否是计算机:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsSdequipCollectDTO.isPc}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="planDeliveryTime">计划到货时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="planDeliveryTime"
                               id="planDeliveryTime" readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsSdequipCollectDTO.planDeliveryTime}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="buyerAlias">采购员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="buyer" name="buyer"
                               value="<c:out  value='${assetsSdequipCollectDTO.buyer}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="buyerAlias" readonly="readonly"
                               name="buyerAlias" value="<c:out  value='${assetsSdequipCollectDTO.buyerAlias}'/>">
                        <span class="input-group-addon">
									           <i class="glyphicon glyphicon-user"></i>
									          </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="planBuyerAlias">采购计划员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="planBuyer" name="planBuyer"
                               value="<c:out  value='${assetsSdequipCollectDTO.planBuyer}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="planBuyerAlias"
                               readonly="readonly" name="planBuyerAlias"
                               value="<c:out  value='${assetsSdequipCollectDTO.planBuyerAlias}'/>">
                        <span class="input-group-addon">
									           <i class="glyphicon glyphicon-user"></i>
									          </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isWireless">是否具有无线功能:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWireless" id="isWireless" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isWireless}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="devicePurchaseType">设备购置类型:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="devicePurchaseType" id="devicePurchaseType"
                                  title="" isNull="true" lookupCode="DEVICE_PURCHASE_TYPE"
                                  defaultValue='${assetsSdequipCollectDTO.devicePurchaseType}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="devicePurchaseCause">设备购置原因:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="devicePurchaseCause" id="devicePurchaseCause"
                           readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.devicePurchaseCause}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="technicalIndex">技术指标:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="technicalIndex" id="technicalIndex"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.technicalIndex}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="technicalIndex02">技术指标:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="technicalIndex02" id="technicalIndex02"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.technicalIndex02}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="advancement">指标先进性:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="advancement" id="advancement"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.advancement}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceReliability">设备可靠性:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceReliability" id="deviceReliability"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.deviceReliability}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isWeedOut">是否属于即将产能淘汰设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWeedOut" id="isWeedOut" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isWeedOut}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="notMeetDemand">已有设备为什么不能满足要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="notMeetDemand" id="notMeetDemand"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.notMeetDemand}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="useRatio">设备利用率情况:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="useRatio" id="useRatio" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.useRatio}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="energyConsumption">设备能耗情况 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="energyConsumption" id="energyConsumption"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.energyConsumption}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="consumableEconomics">设备耗材经济性:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="consumableEconomics" id="consumableEconomics"
                           readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.consumableEconomics}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="universality">设备通用性:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="universality" id="universality"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.universality}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="maintainCost">设备维保费用情况:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="maintainCost" id="maintainCost"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.maintainCost}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="security">安全性:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="security" id="security" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.security}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isBearingMeet">安装设备楼层承重是否满足:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isBearingMeet" id="isBearingMeet" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isBearingMeet}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isOutdoorUnit">设备是否有室外机:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOutdoorUnit" id="isOutdoorUnit" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isOutdoorUnit}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isAllowOutdoorUnit">所安装位置是否允许安装室外机:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAllowOutdoorUnit" id="isAllowOutdoorUnit"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isAllowOutdoorUnit}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNeedFoundation">设备是否需要地基基础:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedFoundation" id="isNeedFoundation"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isNeedFoundation}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isFoundationCondition">所安装位置是否具备设置地基条件:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFoundationCondition"
                                  id="isFoundationCondition" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isFoundationCondition}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="serviceVoltage">使用电压:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="serviceVoltage" id="serviceVoltage"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.serviceVoltage}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isVoltageCondition">安装位置是否具备电压条件:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isVoltageCondition" id="isVoltageCondition"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isVoltageCondition}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isHumidityNeed">是否对温湿度有要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isHumidityNeed" id="isHumidityNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isHumidityNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="humidityNeed">温湿度要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="humidityNeed" id="humidityNeed"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.humidityNeed}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isCleanlinessNeed">是否对洁净度有要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isCleanlinessNeed" id="isCleanlinessNeed"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isCleanlinessNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="cleanlinessNeed">洁净度要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="cleanlinessNeed" id="cleanlinessNeed"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.cleanlinessNeed}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isWaterNeed">是否有用水要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWaterNeed" id="isWaterNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isWaterNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="waterNeed">用水要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="waterNeed" id="waterNeed" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.waterNeed}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isGasNeed">是否有用气要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isGasNeed" id="isGasNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isGasNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="gasNeed">用气要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="gasNeed" id="gasNeed" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.gasNeed}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isLet">是否是否有气体、污水排放:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsSdequipCollectDTO.isLet}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="letNeed">气体、污水排放要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="letNeed" id="letNeed" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.letNeed}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isOtherNeed">是否有其他特殊要求:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOtherNeed" id="isOtherNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isOtherNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="otherNeed">其他特殊要求:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="otherNeed" id="otherNeed" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.otherNeed}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNoise">是否有噪音:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNoise" id="isNoise" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsSdequipCollectDTO.isNoise}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNoiseInfluence">噪音是否影响安装地工作办公:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNoiseInfluence" id="isNoiseInfluence"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.isNoiseInfluence}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="aboveNeedHave">以上需求条件在拟安装地点是否都已具备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="aboveNeedHave" id="aboveNeedHave" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsSdequipCollectDTO.aboveNeedHave}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="examineApproveEngineerAlias">审批总师:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="examineApproveEngineer" name="examineApproveEngineer"
                               value="<c:out  value='${assetsSdequipCollectDTO.examineApproveEngineer}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="examineApproveEngineerAlias"
                               readonly="readonly" name="examineApproveEngineerAlias"
                               value="<c:out  value='${assetsSdequipCollectDTO.examineApproveEngineerAlias}'/>">
                        <span class="input-group-addon">
									           <i class="glyphicon glyphicon-user"></i>
									          </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="professionalAuditorAlias">专业审核员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="professionalAuditor" name="professionalAuditor"
                               value="<c:out  value='${assetsSdequipCollectDTO.professionalAuditor}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="professionalAuditorAlias"
                               readonly="readonly" name="professionalAuditorAlias"
                               value="<c:out  value='${assetsSdequipCollectDTO.professionalAuditorAlias}'/>">
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
                               value="<c:out  value='${assetsSdequipCollectDTO.competentLeader}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="competentLeaderAlias"
                               readonly="readonly" name="competentLeaderAlias"
                               value="<c:out  value='${assetsSdequipCollectDTO.competentLeaderAlias}'/>">
                        <span class="input-group-addon">
									           <i class="glyphicon glyphicon-user"></i>
									          </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deptHeadConclusion">部门领导结论:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deptHeadConclusion" id="deptHeadConclusion"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.deptHeadConclusion}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deptHeadOpinion">部门领导意见:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deptHeadOpinion" id="deptHeadOpinion"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.deptHeadOpinion}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="professionalAuditorOpinion">专业审核员意见:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="professionalAuditorOpinion"
                           id="professionalAuditorOpinion" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.professionalAuditorOpinion}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="chiefEngineerConclusion">总师结论:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="chiefEngineerConclusion"
                           id="chiefEngineerConclusion" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.chiefEngineerConclusion}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="chiefEngineerOpinion">总师意见:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="chiefEngineerOpinion"
                           id="chiefEngineerOpinion" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.chiefEngineerOpinion}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="competentLeaderConclusion">主管所领导结论:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="competentLeaderConclusion"
                           id="competentLeaderConclusion" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.competentLeaderConclusion}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="competentLeaderOpinion">主管所领导意见:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="competentLeaderOpinion"
                           id="competentLeaderOpinion" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.competentLeaderOpinion}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="largeDeviceType">简易/大型设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="largeDeviceType" id="largeDeviceType" title=""
                                  isNull="true" lookupCode="LARGE_DEVICE_TYPE"
                                  defaultValue='${assetsSdequipCollectDTO.largeDeviceType}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="instituteOrCompany">研究所/公司:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="instituteOrCompany" id="instituteOrCompany"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.instituteOrCompany}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="positionId">安装地点（未使用）:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="positionId" id="positionId"
                           readonly="readonly" value="<c:out  value='${assetsSdequipCollectDTO.positionId}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="parentId">标准设备年度申购征集通知单id:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="parentId" id="parentId" readonly="readonly"
                           value="<c:out  value='${assetsSdequipCollectDTO.parentId}'/>"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
    document.ready = function () {
        parent.assetsSdequipCollect.formValidate($('#form'));
    };
    //form控件禁用
    setFormDisabled();
    $(document).keydown(function (event) {
        event.returnValue = false;
        return false;
    });
</script>
</body>
</html>