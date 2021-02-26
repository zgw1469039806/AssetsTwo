<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form,fileupload";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/operation/Edit/id" -->
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style type="text/css">
        #t_assetsSupplier {
            display: none;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsStdtempapplyProcDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsStdtempapplyProcDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="stdId">申购单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="stdId" id="stdId"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.stdId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.createdByTel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="formState">单据状态 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.formState}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceName">设备名称 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.deviceName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceSpec">设备规格 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.deviceSpec}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceModel">设备型号 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.deviceModel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="secretLevel">密级 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title=""
                                  isNull="true" lookupCode="SECRET_LEVEL"
                                  defaultValue='${assetsStdtempapplyProcDTO.secretLevel}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="referencePlant">参考厂家 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="referencePlant" id="referencePlant"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.referencePlant}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceNum">台（套）数 :</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="deviceNum" id="deviceNum"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.deviceNum}'/>"
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
                    <label for="unitPrice">单价(元) :</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.unitPrice}'/>"
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
                    <label for="totalPrice">总金额（元） :</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalPrice" id="totalPrice"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.totalPrice}'/>"
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
                    <label for="deviceType">设备类型 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType" id="deviceType" title=""
                                  isNull="true" lookupCode="DEVICE_TYPE"
                                  defaultValue='${assetsStdtempapplyProcDTO.deviceType}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceCategory">设备类别 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title=""
                                  isNull="true" lookupCode="DEVICE_CATEGORY"
                                  defaultValue='${assetsStdtempapplyProcDTO.deviceCategory}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isMetering">是否计量 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isMetering}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSceneMetering">是否现场计量 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSceneMetering" id="isSceneMetering" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isSceneMetering}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isMaintain">是否保养 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMaintain" id="isMaintain" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isMaintain}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isAccuracyCheck">是否精度检查 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAccuracyCheck" id="isAccuracyCheck" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isAccuracyCheck}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isRegularCheck">是否定检 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isRegularCheck" id="isRegularCheck" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isRegularCheck}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSpotCheck">是否点检 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpotCheck" id="isSpotCheck" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isSpotCheck}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSpecialDevice">是否特种设备 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpecialDevice" id="isSpecialDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isSpecialDevice}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isPrecisionIndex">是否精度指标 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPrecisionIndex" id="isPrecisionIndex"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isPrecisionIndex}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNeedInstall">是否需要安装 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isNeedInstall}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="installPosition">安装地点 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="installPosition" id="installPosition"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.installPosition}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isFoundation">是否需要地基基础 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFoundation" id="isFoundation" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isFoundation}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSafetyProduction">是否涉及安全生产 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isSafetyProduction}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="financialResources">经费来源 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources"
                                  title="" isNull="true" lookupCode="FINANCIAL_RESOURCES"
                                  defaultValue='${assetsStdtempapplyProcDTO.financialResources}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="toProject">所属项目:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="toProject" id="toProject"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.toProject}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="approvalName">批复名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="approvalName" id="approvalName"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.approvalName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="chiefEngineerAlias">主管总师:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="chiefEngineer" name="chiefEngineer"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.chiefEngineer}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="chiefEngineerAlias"
                               name="chiefEngineerAlias"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.chiefEngineerAlias}'/>">
                        <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="projectNum">项目序号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="projectNum" id="projectNum"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.projectNum}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="projectDirectorAlias">项目主管:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="projectDirector" name="projectDirector"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.projectDirector}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias"
                               name="projectDirectorAlias"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.projectDirectorAlias}'/>">
                        <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="demandUrgencyDegree">需求紧急程度 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="demandUrgencyDegree" id="demandUrgencyDegree"
                                  title="" isNull="true" lookupCode="DEMAND_URGENCY_DEGREE"
                                  defaultValue='${assetsStdtempapplyProcDTO.demandUrgencyDegree}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isTrain">是否需要设备培训 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTrain" id="isTrain" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isTrain}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isPc">是否是计算机 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsStdtempapplyProcDTO.isPc}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="planDeliveryTime">计划到货时间 :</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="planDeliveryTime"
                               id="planDeliveryTime"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsStdtempapplyProcDTO.planDeliveryTime}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="buyerAlias">采购员 :</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="buyer" name="buyer"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.buyer}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="buyerAlias" name="buyerAlias"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.buyerAlias}'/>">
                        <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="planBuyerAlias">采购计划员 :</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="planBuyer" name="planBuyer"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.planBuyer}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="planBuyerAlias"
                               name="planBuyerAlias"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.planBuyerAlias}'/>">
                        <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isWireless">是否具有无线功能 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWireless" id="isWireless" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isWireless}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="devicePurchaseType">设备购置类型 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="devicePurchaseType" id="devicePurchaseType"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.devicePurchaseType}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="devicePurchaseCause">设备购置原因 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="devicePurchaseCause" id="devicePurchaseCause"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.devicePurchaseCause}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="technicalIndex">技术指标 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="technicalIndex" id="technicalIndex"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.technicalIndex}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="technicalIndex02">技术指标 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="technicalIndex02" id="technicalIndex02"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.technicalIndex02}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="advancement">指标先进性 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="advancement" id="advancement"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.advancement}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceReliability">设备可靠性 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceReliability" id="deviceReliability"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.deviceReliability}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isWeedOut">是否属于即将产能淘汰设备 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWeedOut" id="isWeedOut" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isWeedOut}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="notMeetDemand">已有设备为什么不能满足要求 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="notMeetDemand" id="notMeetDemand"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.notMeetDemand}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="useRatio">设备利用率情况 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="useRatio" id="useRatio"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.useRatio}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="energyConsumption">设备能耗情况 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="energyConsumption" id="energyConsumption"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.energyConsumption}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="consumableEconomics">设备耗材经济性 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="consumableEconomics" id="consumableEconomics"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.consumableEconomics}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="universality">设备通用性 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="universality" id="universality"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.universality}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="maintainCost">设备维保费用情况 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="maintainCost" id="maintainCost"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.maintainCost}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="security">安全性 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="security" id="security"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.security}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isBearingMeet">安装设备楼层承重是否满足 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isBearingMeet" id="isBearingMeet" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isBearingMeet}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isOutdoorUnit">设备是否有室外机 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOutdoorUnit" id="isOutdoorUnit" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isOutdoorUnit}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isAllowOutdoorUnit">所安装位置是否允许安装室外机 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAllowOutdoorUnit" id="isAllowOutdoorUnit"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isAllowOutdoorUnit}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNeedFoundation">设备是否需要地基基础 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedFoundation" id="isNeedFoundation"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isNeedFoundation}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isFoundationCondition">所安装位置是否具备设置地基条件 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFoundationCondition"
                                  id="isFoundationCondition" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isFoundationCondition}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="serviceVoltage">使用电压 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="serviceVoltage" id="serviceVoltage"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.serviceVoltage}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isVoltageCondition">安装位置是否具备电压条件 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isVoltageCondition" id="isVoltageCondition"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isVoltageCondition}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isHumidityNeed">是否对温湿度有要求 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isHumidityNeed" id="isHumidityNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isHumidityNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="humidityNeed">温湿度要求 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="humidityNeed" id="humidityNeed"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.humidityNeed}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isCleanlinessNeed">是否对洁净度有要求 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isCleanlinessNeed" id="isCleanlinessNeed"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isCleanlinessNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="cleanlinessNeed">洁净度要求 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="cleanlinessNeed" id="cleanlinessNeed"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.cleanlinessNeed}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isWaterNeed">是否有用水要求 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isWaterNeed" id="isWaterNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isWaterNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="waterNeed">用水要求 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="waterNeed" id="waterNeed"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.waterNeed}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isGasNeed">是否有用气要求 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isGasNeed" id="isGasNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isGasNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="gasNeed">用气要求 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.gasNeed}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isLet">是否是否有气体、污水排放 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsStdtempapplyProcDTO.isLet}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="letNeed">气体、污水排放要求 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="letNeed" id="letNeed"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.letNeed}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isOtherNeed">是否有其他特殊要求 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isOtherNeed" id="isOtherNeed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isOtherNeed}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="otherNeed">其他特殊要求 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="otherNeed" id="otherNeed"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.otherNeed}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNoise">是否有噪音 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNoise" id="isNoise" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isNoise}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNoiseInfluence">噪音是否影响安装地工作办公 :</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNoiseInfluence" id="isNoiseInfluence"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsStdtempapplyProcDTO.isNoiseInfluence}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="aboveNeedHave">以上需求条件在拟安装地点是否都已具备 :</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="aboveNeedHave" id="aboveNeedHave"
                           value="<c:out  value='${assetsStdtempapplyProcDTO.aboveNeedHave}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="largeDeviceType">简易/大型设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="largeDeviceType" id="largeDeviceType" title=""
                                  isNull="true" lookupCode="simple_large_scale"
                                  defaultValue='${assetsStdtempapplyProcDTO.largeDeviceType}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="instituteOrCompany">研究所/公司:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="instituteOrCompany" id="instituteOrCompany"
                                  title="" isNull="true" lookupCode="LARGE_DEVICE_TYPE"
                                  defaultValue='${assetsStdtempapplyProcDTO.instituteOrCompany}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByPersionAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPersion" name="createdByPersion"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.createdByPersion}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersionAlias"
                               name="createdByPersionAlias"
                               value="<c:out  value='${assetsStdtempapplyProcDTO.createdByPersionAlias}'/>">
                        <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <div id="toolbar_assetsSupplier" class="toolbar">
                        <div class="toolbar-left">
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_assetsSupplier_button_add"
                                                   permissionDes="添加">
                                <a id="assetsSupplier_insert" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button"
                                   title="添加"><i class="fa fa-plus"></i> 添加</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_assetsSupplier_button_delete"
                                                   permissionDes="删除">
                                <a id="assetsSupplier_del" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button"
                                   title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                            </sec:accesscontrollist>
                        </div>
                    </div>
                    <table id="assetsSupplier"></table>
                </th>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1%>">
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
                       title="保存" id="assetsStdtempapplyProc_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsStdtempapplyProc_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/assets/device/assetsstdtempapplyproc/js/AssetsSupplier.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var afterUploadEvent = null;
    var assetsSupplier;
    var assetsSupplierGridColModel = [
        {label: 'id', name: 'id', key: true, width: 75, hidden: true}
        , {label: '供应商名称', name: 'name', width: 150, editable: true}
        , {label: '供应商地址', name: 'address', width: 150, editable: true}
        , {label: '联系人', name: 'contact', width: 150, editable: true}
        , {label: '联系电话', name: 'contactNumber', width: 150, editable: true}
        , {label: '经验范围', name: 'businessScope', width: 150, editable: true}
        , {label: '供应商状态：0:正常状态 2:停用', name: 'status', width: 150, editable: true}
    ];

    function closeForm() {
        parent.assetsStdtempapplyProc.closeDialog(window.name);
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
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
        $('#assetsStdtempapplyProc_saveForm').addClass('disabled').unbind("click");
        parent.assetsStdtempapplyProc.save($('#form'), window.name);
    }

    $(document).ready(function () {
        var pid = "${assetsStdtempapplyProcDTO.id}";
        var isReload = "edit";
        var searchSubNames = "";
        var surl = "platform/assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/operation/sub/";
        assetsSupplier = new AssetsSupplier('assetsSupplier', surl,
            "formSub",
            assetsSupplierGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsSupplier_keyWord', isReload);
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

        parent.assetsStdtempapplyProc.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsStdtempapplyProcDTO.id}',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //保存按钮绑定事件
        $('#assetsStdtempapplyProc_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsStdtempapplyProc_closeForm').bind('click', function () {
            closeForm();
        });
        //添加按钮绑定事件
        $('#assetsSupplier_insert').bind('click', function () {
            assetsSupplier.insert();
        });
        //删除按钮绑定事件
        $('#assetsSupplier_del').bind('click', function () {
            assetsSupplier.del();
        });

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
</script>
</body>
</html>