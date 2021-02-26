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
    <!-- ControllerPath = "assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/Edit/id" -->
    <title>详细</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<style>
    .ui-jqgrid .ui-jqgrid-bdiv {
        height: 500px!important;
    }
    .ui-jqgrid .ui-jqgrid-hbox {
        padding-right: 0px!important;
    }
</style>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsDeviceAccountDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsDeviceAccountDTO.id}'/>"/>
        <div style="font-size:18px; font-weight:bold; margin-left: 2%; margin-top: 20px">基本信息</div>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="assetId">资产编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="assetId" id="assetId" readonly="readonly"
                           value="<c:out  value='${assetsDeviceAccountDTO.assetId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"
                           readonly="readonly"
                           value="<c:out  value='${assetsDeviceAccountDTO.unifiedId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory"
                                  title=""
                                  isNull="true" lookupCode="DEVICE_CATEGORY"
                                  defaultValue='${assetsDeviceAccountDTO.deviceCategory}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.deviceName}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceModel">设备型号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.deviceModel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceSpec">设备规格:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.deviceSpec}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="ownerIdAlias">责任人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId"
                               value="<c:out  value='${assetsDeviceAccountDTO.ownerId}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias"
                               readonly="readonly" name="ownerIdAlias"
                               value="<c:out  value='${assetsDeviceAccountDTO.ownerIdAlias}'/>">
                        <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="ownerDeptAlias">责任人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept"
                               value="<c:out  value='${assetsDeviceAccountDTO.ownerDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               readonly="readonly" name="ownerDeptAlias"
                               value="<c:out  value='${assetsDeviceAccountDTO.ownerDeptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="userIdAlias">使用人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userId" name="userId"
                               value="<c:out  value='${assetsDeviceAccountDTO.userId}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="userIdAlias"
                               readonly="readonly"
                               name="userIdAlias" value="<c:out  value='${assetsDeviceAccountDTO.userIdAlias}'/>">
                        <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="userDeptAlias">使用人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userDept" name="userDept"
                               value="<c:out  value='${assetsDeviceAccountDTO.userDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="userDeptAlias"
                               readonly="readonly" name="userDeptAlias"
                               value="<c:out  value='${assetsDeviceAccountDTO.userDeptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="manufacturerId">生产厂家:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.manufacturerId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdDate">立卡日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDate" id="createdDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.createdDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isManage">是否统管设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isManage" id="isManage" title=""
                                  isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isManage}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isInWorkflow">是否在流程中:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isInWorkflow" id="isInWorkflow" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isInWorkflow}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="manageState">统管设备状态:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="manageState" id="manageState" title=""
                                  isNull="true" lookupCode="MANAGE_STATE"
                                  defaultValue='${assetsDeviceAccountDTO.manageState}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceState">设备状态:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceState" id="deviceState" title=""
                                  isNull="true" lookupCode="DEVICE_STATE"
                                  defaultValue='${assetsDeviceAccountDTO.deviceState}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="parentId">父级设备ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="parentId" id="parentId"
                           readonly="readonly"
                           value="<c:out  value='${assetsDeviceAccountDTO.parentId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="parentName">父级设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="parentName" id="parentName"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.parentName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="commonName">常用名:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="commonName" id="commonName"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.commonName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="positionId">安装地点ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="positionId" id="positionId"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.positionId}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="abcCategory">ABC分类:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="abcCategory" id="abcCategory" title=""
                                  isNull="true" lookupCode="ABC_CATEGORY"
                                  defaultValue='${assetsDeviceAccountDTO.abcCategory}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isKeyDevice">是否军工关键设备设施:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isKeyDevice" id="isKeyDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isKeyDevice}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isResearch">是否科研生产设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isResearch" id="isResearch" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isResearch}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="productCountry">生产国家和地区:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="productCountry" id="productCountry"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.productCountry}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="productFactory">制造厂:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="productFactory" id="productFactory"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.productFactory}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="supplier">供应商:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="supplier" id="supplier"
                           readonly="readonly"
                           value="<c:out  value='${assetsDeviceAccountDTO.supplier}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="productDate">出厂日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="productDate" id="productDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.productDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="productNum">出厂编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="productNum" id="productNum"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.productNum}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="devicePower">功率(单位：千瓦):</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="devicePower" id="devicePower"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.devicePower}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceWeight">重量(单位：公斤):</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceWeight" id="deviceWeight"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.deviceWeight}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceSize">外形尺寸:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSize" id="deviceSize"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.deviceSize}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="checkDate">验收时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="checkDate" id="checkDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.checkDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="improveProject">技改项目:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="improveProject" id="improveProject"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.improveProject}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="unitPrice">单价(单位：元):</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice" readonly="readonly"
                               value="<c:out  value='${assetsDeviceAccountDTO.unitPrice}'/>"
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
                    <label for="applyNum">申购单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="applyNum" id="applyNum"
                           readonly="readonly"
                           value="<c:out  value='${assetsDeviceAccountDTO.applyNum}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="checkNum">验收单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="checkNum" id="checkNum"
                           readonly="readonly"
                           value="<c:out  value='${assetsDeviceAccountDTO.checkNum}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="carFrameNum">车架号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="carFrameNum" id="carFrameNum"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.carFrameNum}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="engineNum">发动机号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="engineNum" id="engineNum"
                           readonly="readonly"
                           value="<c:out  value='${assetsDeviceAccountDTO.engineNum}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="carNum">车牌号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="carNum" id="carNum" readonly="readonly"
                           value="<c:out  value='${assetsDeviceAccountDTO.carNum}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="secretLevel">密级:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title=""
                                  isNull="true" lookupCode="SECRET_LEVEL"
                                  defaultValue='${assetsDeviceAccountDTO.secretLevel}'/>
                </td>
            </tr>
            <tr>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isMetering">是否计量:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isMetering}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isMaintain">是否保养:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMaintain" id="isMaintain" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isMaintain}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isAccuracyCheck">是否精度检查:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAccuracyCheck" id="isAccuracyCheck"
                                  title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isAccuracyCheck}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isRegularCheck">是否定检:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isRegularCheck" id="isRegularCheck"
                                  title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isRegularCheck}'/>
                </td>
            </tr>
            <tr>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSpotCheck">是否点检:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpotCheck" id="isSpotCheck" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isSpotCheck}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSpecialDevice">是否特种设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpecialDevice" id="isSpecialDevice"
                                  title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isSpecialDevice}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isSafetyProduction">是否涉及安全生产:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSafetyProduction"
                                  id="isSafetyProduction"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isSafetyProduction}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNeedInstall">是否安装:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isNeedInstall}'/>
                </td>
            </tr>
            <tr>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isPc">是否计算机:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG" defaultValue='${assetsDeviceAccountDTO.isPc}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceType">设备类型:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType" id="deviceType" title=""
                                  isNull="true" lookupCode="DEVICE_TYPE"
                                  defaultValue='${assetsDeviceAccountDTO.deviceType}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="enableDate">设备启用年月:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="enableDate" id="enableDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.enableDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="runningTime">运行时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="runningTime" id="runningTime"
                               readonly="readonly"
                               value="<c:out  value='${assetsDeviceAccountDTO.runningTime}'/>"
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
            </tr>
            <tr>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="lastMaintainDate">上次保养日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMaintainDate"
                               id="lastMaintainDate" readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.lastMaintainDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="lastAccuracyCheckDate">上次精度检查日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastAccuracyCheckDate"
                               id="lastAccuracyCheckDate" readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.lastAccuracyCheckDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="totalBorrow">累计借用天数:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalBorrow" id="totalBorrow"
                               readonly="readonly"
                               value="<c:out  value='${assetsDeviceAccountDTO.totalBorrow}'/>"
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
                    <label for="useCost">设备使用费:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="useCost" id="useCost" readonly="readonly"
                               value="<c:out  value='${assetsDeviceAccountDTO.useCost}'/>"
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
                    <label for="repairDeptAlias">维修部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairDept" name="repairDept"
                               value="<c:out  value='${assetsDeviceAccountDTO.repairDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="repairDeptAlias"
                               readonly="readonly" name="repairDeptAlias"
                               value="<c:out  value='${assetsDeviceAccountDTO.repairDeptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="stateChangeDate">状态变动日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="stateChangeDate"
                               id="stateChangeDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.stateChangeDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isNeedCertificate">是否需要操作证:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedCertificate" id="isNeedCertificate" title=""
                                  isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isNeedCertificate}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceSysName">设备系统名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSysName" id="deviceSysName"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.deviceSysName}'/>"/>
                </td>
            </tr>
            <tr>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceRelatedManAlias">设备关联人员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="deviceRelatedMan" name="deviceRelatedMan"
                               value="<c:out  value='${assetsDeviceAccountDTO.deviceRelatedMan}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="deviceRelatedManAlias"
                               readonly="readonly" name="deviceRelatedManAlias"
                               value="<c:out  value='${assetsDeviceAccountDTO.deviceRelatedManAlias}'/>">
                        <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isLabDevice">是否实验室设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLabDevice" id="isLabDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isLabDevice}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isFixedAssets">是否固定资产:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFixedAssets" id="isFixedAssets" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isFixedAssets}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isTransFixed">是否转固:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTransFixed" id="isTransFixed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isTransFixed}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="indexInfo">指标信息:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="indexInfo" id="indexInfo"
                           readonly="readonly"
                           value="<c:out  value='${assetsDeviceAccountDTO.indexInfo}'/>"/>
                </td>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="applyModel">适用机型:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="applyModel" id="applyModel"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.applyModel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="applyProduct">适用产品:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="applyProduct" id="applyProduct"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.applyProduct}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="testedObject">受测对象:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="testedObject" id="testedObject"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.testedObject}'/>"/>
                </td>

            </tr>
            <tr>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="majorType">专业类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="majorType" id="majorType" title=""
                                  isNull="true" lookupCode="MAJOR_TYPE"
                                  defaultValue='${assetsDeviceAccountDTO.majorType}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="deviceNature">设备性质:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceNature" id="deviceNature" title=""
                                  isNull="true" lookupCode="DEVICE_NATURE"
                                  defaultValue='${assetsDeviceAccountDTO.deviceNature}'/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="softwareNum">软件标识号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareNum" id="softwareNum"
                           readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.softwareNum}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="isTestDevice">是否测试设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
                                  defaultValue='${assetsDeviceAccountDTO.isTestDevice}'/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="softwareDesignerAlias">软件设计人员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="softwareDesigner" name="softwareDesigner"
                               value="<c:out  value='${assetsDeviceAccountDTO.softwareDesigner}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="softwareDesignerAlias"
                               readonly="readonly" name="softwareDesignerAlias"
                               value="<c:out  value='${assetsDeviceAccountDTO.softwareDesignerAlias}'/>">
                        <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="hardwareDesignerAlias">硬件设计人员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="hardwareDesigner" name="hardwareDesigner"
                               value="<c:out  value='${assetsDeviceAccountDTO.hardwareDesigner}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="hardwareDesignerAlias"
                               readonly="readonly" name="hardwareDesignerAlias"
                               value="<c:out  value='${assetsDeviceAccountDTO.hardwareDesignerAlias}'/>">
                        <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                    </div>
                </td>

                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="runningTime">质保期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="guaranteePeriod" id="guaranteePeriod"
                               readonly="readonly"
                               value="<c:out  value='${assetsDeviceAccountDTO.guaranteePeriod}'/>"
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
                    <label for="enableDate">质保截止日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="guaranteeDate" id="guaranteeDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.guaranteeDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

            </tr>

        </table>

    <!-- Tab页begin -->
    <div class="eform-tab" style="border: 1px dashed #BBB; margin-left: 0%; margin-top: 50px;" contenteditable="false">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation active" contenteditable="false"><a href="#FinanceInfo" aria-controls="FinanceInfo" role="tab" data-toggle="tab">财务信息</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#ComputerInfo" aria-controls="ComputerInfo" role="tab" data-toggle="tab">计算机信息</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#MeteringInfo" aria-controls="MeteringInfo" role="tab" data-toggle="tab">计量信息</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#SafeInfoTab" aria-controls="SafeInfoTab" role="tab" data-toggle="tab">安全信息</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#Attachment" aria-controls="Attachment" role="tab" data-toggle="tab">设备附表</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#ComponentInfo" aria-controls="ComponentInfo" role="tab" data-toggle="tab">随机附件</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#MaintainInfo" aria-controls="MaintainInfo" role="tab" data-toggle="tab">年度保养</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#RegularCheckInfo" aria-controls="RegularCheckInfo" role="tab" data-toggle="tab">定期检验</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#SpotCheckInfo" aria-controls="SpotCheckInfo" role="tab" data-toggle="tab">点检信息</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#ACCCheckInfo" aria-controls="ACCCheckInfo" role="tab" data-toggle="tab">精度检查信息</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#TDeviceComponentInfo" aria-controls="TDeviceComponentInfo" role="tab" data-toggle="tab">测试设备组件</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#TDeviceSoftwareInfo" aria-controls="TDeviceSoftwareInfo" role="tab" data-toggle="tab">测试设备软件</a></li>
            <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a href="#TDeviceAppProductInfo" aria-controls="TDeviceAppProductInfo" role="tab" data-toggle="tab">测试设备适用产品</a></li>
        </ul>
        <div class="tab-content" style="height: 100%; min-height: 20px; margin-left: 0px;">
            <div role="tabpanel" class="tab-pane active" contenteditable="false" id="FinanceInfo" style="height: 100%; min-height: 40px;">
                <table class="form_commonTable">
                    <tr>
                        <!-- 资产财务类别 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="assetsFinanceType">资产财务类别:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="assetsFinanceType" id="assetsFinanceType"
                                          title="" isNull="true" lookupCode="ASSETS_FINANCE_TYPE"
                                          defaultValue='${assetsDeviceAccountDTO.assetsFinanceType}'/>
                        </td>
                        <!-- 资产来源 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="assetsSource">资产来源:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="assetsSource" id="assetsSource" title=""
                                          isNull="true" lookupCode="ASSETS_SOURCE"
                                          defaultValue='${assetsDeviceAccountDTO.assetsSource}'/>
                        </td>
                        <!-- 资产财务状态 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="assetsFinanceState">资产财务状态:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="assetsFinanceState" id="assetsFinanceState"
                                          title="" isNull="true" lookupCode="ASSETS_FINANCE_STATE"
                                          defaultValue='${assetsDeviceAccountDTO.assetsFinanceState}'/>
                        </td>
                        <!-- 财务入账时间 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="financeEntryDate">财务入账时间:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm">
                                <input class="form-control date-picker" type="text" name="financeEntryDate"
                                       id="financeEntryDate" readonly="readonly"
                                       value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.financeEntryDate}'/>"/><span
                                    class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <!-- 原值 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="originalValue">原值:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="originalValue" id="originalValue"
                                       readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.originalValue}'/>"
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
                        <!-- 累计折旧 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="totalDepreciation">累计折旧:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="totalDepreciation" id="totalDepreciation"
                                       readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.totalDepreciation}'/>"
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
                        <!-- 折旧方法 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="depreciationMethod">折旧方法:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="depreciationMethod" id="depreciationMethod"
                                   readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.depreciationMethod}'/>"/>
                        </td>
                        <!-- 折旧年限 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="depreciationYear">折旧年限:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="depreciationYear" id="depreciationYear"
                                       readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.depreciationYear}'/>"
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
                        <!-- 净残值率 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="netSalvageRate">净残值率:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="netSalvageRate" id="netSalvageRate"
                                       readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.netSalvageRate}'/>"
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
                        <!-- 净残值 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="netSalvage">净残值:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="netSalvage" id="netSalvage" readonly="readonly"
                                       value="<c:out  value='${assetsDeviceAccountDTO.netSalvage}'/>"
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
                        <!-- 月折旧率 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="monthDepreciationRate">月折旧率:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="monthDepreciationRate" id="monthDepreciationRate"
                                       readonly="readonly"
                                       value="<c:out  value='${assetsDeviceAccountDTO.monthDepreciationRate}'/>"
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
                        <!-- 月折旧额 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="monthDepreciation">月折旧额:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="monthDepreciation" id="monthDepreciation"
                                       readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.monthDepreciation}'/>"
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
                        <!-- 年折旧率 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="yearDepreciationRate">年折旧率:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="yearDepreciationRate" id="yearDepreciationRate"
                                       readonly="readonly"
                                       value="<c:out  value='${assetsDeviceAccountDTO.yearDepreciationRate}'/>"
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
                        <!-- 年折旧额 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="yearDepreciation">年折旧额:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="yearDepreciation" id="yearDepreciation"
                                       readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.yearDepreciation}'/>"
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
                        <!-- 净值 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="netValue">净值:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="netValue" id="netValue" readonly="readonly"
                                       value="<c:out  value='${assetsDeviceAccountDTO.netValue}'/>"
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
                        <!-- 已提月份 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="monthCount">已提月份:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="monthCount" id="monthCount" readonly="readonly"
                                       value="<c:out  value='${assetsDeviceAccountDTO.monthCount}'/>"
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
                    </tr>
                    <tr>
                        <!-- 未计提月份 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="monthRemain">未计提月份:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="monthRemain" id="monthRemain" readonly="readonly"
                                       value="<c:out  value='${assetsDeviceAccountDTO.monthRemain}'/>"
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
                        <!-- 研究所 -->
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="instituteOrCompany">研究所/公司:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="instituteOrCompany"
                                          id="instituteOrCompany"
                                          title="" isNull="true" lookupCode="INSTITUTE_OR_COMPANY"
                                          defaultValue='${assetsDeviceAccountDTO.instituteOrCompany}'/>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="proofNum">凭证编号:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="proofNum" id="proofNum" readonly="readonly"
                                   value="<c:out  value='${assetsDeviceAccountDTO.proofNum}'/>"/>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="contractNum">合同号:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="contractNum" id="contractNum"
                                   readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.contractNum}'/>"/>
                        </td>
                    </tr>
                </table>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="ComputerInfo" style="height: 100%; min-height: 40px;">
                <table class="form_commonTable">
                    <tr>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="ip">IP地址:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="ip" id="ip" readonly="readonly"
                                   value="<c:out  value='${assetsDeviceAccountDTO.ip}'/>"/>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="mac">MAC地址:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="mac" id="mac" readonly="readonly"
                                   value="<c:out  value='${assetsDeviceAccountDTO.mac}'/>"/>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="diskNum">硬盘序列号:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="diskNum" id="diskNum"
                                   readonly="readonly"
                                   value="<c:out  value='${assetsDeviceAccountDTO.diskNum}'/>"/>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="os">操作系统:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="os" id="os" readonly="readonly"
                                   value="<c:out  value='${assetsDeviceAccountDTO.os}'/>"/>
                        </td>
                    </tr>
                    <tr>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="osInstallDate">操作系统安装时间:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm">
                                <input class="form-control date-picker" type="text" name="osInstallDate" id="osInstallDate"
                                       readonly="readonly"
                                       value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.osInstallDate}'/>"/><span
                                    class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="MeteringInfo" style="height: 100%; min-height: 40px;">
                <table class="form_commonTable">
                    <tr>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="meteringId">计量文件受控号:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="meteringId" id="meteringId"
                                   readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.meteringId}'/>"/>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="metermanAlias">计量人员:</label></th>
                        <td width="15%">
                            <div class="input-group  input-group-sm">
                                <input type="hidden" id="meterman" name="meterman"
                                       value="<c:out  value='${assetsDeviceAccountDTO.meterman}'/>">
                                <input class="form-control" placeholder="请选择用户" type="text" id="metermanAlias"
                                       readonly="readonly" name="metermanAlias"
                                       value="<c:out  value='${assetsDeviceAccountDTO.metermanAlias}'/>">
                                <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                            </div>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="meteringDate">计量时间:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm">
                                <input class="form-control date-picker" type="text" name="meteringDate" id="meteringDate"
                                       readonly="readonly"
                                       value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.meteringDate}'/>"/><span
                                    class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="meteringCycle">计量周期:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="meteringCycle" id="meteringCycle"
                                       readonly="readonly" value="<c:out  value='${assetsDeviceAccountDTO.meteringCycle}'/>"
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
                    </tr>
                    <tr>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="lastMeteringDate">上次计量日期:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm">
                                <input class="form-control date-picker" type="text" name="lastMeteringDate"
                                       id="lastMeteringDate" readonly="readonly"
                                       value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.lastMeteringDate}'/>"/><span
                                    class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="nextMeteringDate">下次计量日期:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm">
                                <input class="form-control date-picker" type="text" name="nextMeteringDate"
                                       id="nextMeteringDate" readonly="readonly"
                                       value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.nextMeteringDate}'/>"/><span
                                    class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </td>

                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="planMetermanAlias">计量计划员:</label></th>
                        <td width="15%">
                            <div class="input-group  input-group-sm">
                                <input type="hidden" id="planMeterman" name="planMeterman"
                                       value="<c:out  value='${assetsDeviceAccountDTO.planMeterman}'/>">
                                <input class="form-control" placeholder="请选择用户" type="text" id="planMetermanAlias"
                                       readonly="readonly" name="planMetermanAlias"
                                       value="<c:out  value='${assetsDeviceAccountDTO.planMetermanAlias}'/>">
                                <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                            </div>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="meteringDeptAlias">计量单位:</label></th>
                        <td width="15%">
                            <div class="input-group  input-group-sm">
                                <input type="hidden" id="meteringDept" name="meteringDept"
                                       value="<c:out  value='${assetsDeviceAccountDTO.meteringDept}'/>">
                                <input class="form-control" placeholder="请选择部门" type="text" id="meteringDeptAlias"
                                       readonly="readonly" name="meteringDeptAlias"
                                       value="<c:out  value='${assetsDeviceAccountDTO.meteringDeptAlias}'/>">
                                <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
                            </div>
                        </td>
                    </tr>
                    <tr>

                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="isSceneMetering">计量方式:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="isSceneMetering" id="isSceneMetering" title=""
                                          isNull="true" lookupCode="METERING_MODE"
                                          defaultValue='${assetsDeviceAccountDTO.isSceneMetering}'/>
                        </td>

                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="meteringConclution">计量结论:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="meteringConclution" id="meteringConclution"
                                          title="" isNull="true" lookupCode="METERING_CONCLUTION"
                                          defaultValue='${assetsDeviceAccountDTO.meteringConclution}'/>
                        </td>

                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="meteringOuterAlias">计量外送员:</label></th>
                        <td width="15%">
                            <div class="input-group  input-group-sm">
                                <input type="hidden" id="meteringOuter" name="meteringOuter"
                                       value="<c:out  value='${assetsDeviceAccountDTO.meteringOuter}'/>">
                                <input class="form-control" placeholder="请选择用户" type="text" id="meteringOuterAlias"
                                       readonly="readonly" name="meteringOuterAlias"
                                       value="<c:out  value='${assetsDeviceAccountDTO.meteringOuterAlias}'/>">
                                <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="SafeInfoTab" style="height: 100%; min-height: 40px;">
                <table class="form_commonTable">
                    <tr>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;">
                            <label for="safeInfo">安全信息:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="safeInfo" id="safeInfo"
                                   readonly="readonly"
                                   value="<c:out  value='${assetsDeviceAccountDTO.safeInfo}'/>"/>
                        </td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;"></th>
                        <td width="15%"></td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;"></th>
                        <td width="15%"></td>
                        <th width="10%" style="word-break:break-all;word-warp:break-word;"></th>
                        <td width="15%"></td>
                    </tr>
                </table>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="Attachment"
                 style="height: 100%; min-height: 40px;">
                <div class="ui-jqgrid " id="gbox_DYN_SUB" dir="ltr" style="width: 100%;">
                    <div class="jqgrid-overlay ui-overlay" id="lui_DYN_SUB"></div>
                    <div class="loading row" id="load_DYN_SUB" style="display: none;">读取中...</div>
                    <div class="ui-jqgrid-view table-responsive" role="grid" id="gview_DYN_SUB" style="width: 100%;">
                        <div class="ui-jqgrid-titlebar ui-jqgrid-caption" style="display: none;"><a role="link"
                                                                                                    class="ui-jqgrid-titlebar-close HeaderButton "
                                                                                                    title="切换 展开 折叠 表格"
                                                                                                    style="right: 0px;"><span
                                class="ui-jqgrid-headlink glyphicon glyphicon-circle-arrow-up"></span></a><span
                                class="ui-jqgrid-title"></span></div>

                        <%--<div class="ui-userdata ui-userdata-top" id="t_DYN_SUB" style="width: 100%;">--%>
                        <%--<div id="DYN_SUBToolbar" class="toolbar">--%>
                        <%--&lt;%&ndash;<div class="toolbar-left">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<a id="DYN_SUB_insertBtn" href="javascript:void(0)"&ndash;%&gt;--%>
                        <%--&lt;%&ndash;class="btn btn-primary form-tool-btn btn-sm eform_subtable_bpm_button_auth"&ndash;%&gt;--%>
                        <%--&lt;%&ndash;role="button" title="添加"><i class="icon icon-add"></i> 添加</a>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<a id="DYN_SUB_deleteBtn" href="javascript:void(0)"&ndash;%&gt;--%>
                        <%--&lt;%&ndash;class="btn btn-primary form-tool-btn btn-sm eform_subtable_bpm_button_auth"&ndash;%&gt;--%>
                        <%--&lt;%&ndash;role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<div class="toolbar-right">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<div class="input-group form-tool-search">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<input type="text" name="DYN_SUB_keyWord" id="DYN_SUB_keyWord" style="width: 240px;"&ndash;%&gt;--%>
                        <%--&lt;%&ndash;class="form-control input-sm" placeholder="请输入统一编号或附件名称">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<label id="DYN_SUB_searchPart" class="icon icon-search form-tool-searchicon"&ndash;%&gt;--%>
                        <%--&lt;%&ndash;style="top: 7px;right: 5px;"></label>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<div class="input-group-btn form-tool-searchbtn" style="right: 5px;">&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<a id="DYN_SUB_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"&ndash;%&gt;--%>
                        <%--&lt;%&ndash;role="button" title="高级查询">高级查询 <span class="caret"></span></a>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                        <%--</div>--%>
                        <%--</div>--%>

                        <div class="ui-jqgrid-hdiv" style="width: 100%;">
                            <div class="ui-jqgrid-hbox">
                                <table class="ui-jqgrid-htable ui-common-table table table-bordered" style="width: 100%;"
                                       role="presentation" aria-labelledby="gbox_DYN_SUB">
                                    <thead>
                                    <tr class="ui-jqgrid-labels" role="row">
                                        <%--<th id="DYN_SUB_cb" role="columnheader" class="ui-th-column ui-th-ltr"--%>
                                        <%--style="text-align: left; width: 35px;">--%>
                                        <%--<div class="ui-th-div" id="jqgh_DYN_SUB_cb"><input role="checkbox"--%>
                                        <%--id="cb_DYN_SUB" class="cbox"--%>
                                        <%--type="checkbox"><span--%>
                                        <%--class="s-ico" style="display:none"><span sort="asc"--%>
                                        <%--class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span--%>
                                        <%--sort="desc"--%>
                                        <%--class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>--%>
                                        <%--</div>--%>
                                        </th>
                                        <th id="DYN_SUB_ID" role="columnheader" class="ui-th-column ui-th-ltr "
                                            style=" display: none;"><span
                                                class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                            <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_ID">ID<span
                                                    class="s-ico" style="display:none"><span sort="asc"
                                                                                             class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                    sort="desc"
                                                    class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                            </div>
                                        </th>
                                        <th id="DYN_SUB_DATA_1" role="columnheader" class="ui-th-column ui-th-ltr"
                                            style="width: 4%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                     style="cursor: col-resize;">&nbsp;</span>
                                            <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DATA_1">序号<span
                                                    class="s-ico" style="display:none"><span sort="asc"
                                                                                             class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                    sort="desc"
                                                    class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                            </div>
                                        </th>
                                        <th id="DYN_SUB_UNIFIED_ID" role="columnheader" class="ui-th-column ui-th-ltr"
                                            style="width: 16%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                      style="cursor: col-resize;">&nbsp;</span>
                                            <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_UNIFIED_ID"><font
                                                    color="red">*</font>统一编号<span class="s-ico" style="display:none"><span
                                                    sort="asc"
                                                    class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                    sort="desc"
                                                    class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                            </div>
                                        </th>

                                        <%--<th id="DYN_SUB_DEVICE_CATEGORYName" role="columnheader"--%>
                                        <%--class="ui-th-column ui-th-ltr" style="width: 275px;"><span--%>
                                        <%--class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>--%>
                                        <%--<div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DEVICE_CATEGORYName">--%>
                                        <%--附件类别<span class="s-ico" style="display:none"><span sort="asc"--%>
                                        <%--class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span--%>
                                        <%--sort="desc"--%>
                                        <%--class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>--%>
                                        <%--</div>--%>
                                        <%--</th>--%>
                                        <th id="DYN_SUB_DEVICE_NAME" role="columnheader" class="ui-th-column ui-th-ltr "
                                            style="width: 16%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                      style="cursor: col-resize;">&nbsp;</span>
                                            <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DEVICE_NAME">
                                                附件名称<span class="s-ico" style="display:none"><span sort="asc"
                                                                                                   class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                    sort="desc"
                                                    class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                            </div>
                                        </th>
                                        <th id="DYN_SUB_DEVICE_MODEl" role="columnheader" class="ui-th-column ui-th-ltr "
                                            style="width: 16%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                      style="cursor: col-resize;">&nbsp;</span>
                                            <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DEVICE_MODEl">
                                                附件型号<span class="s-ico" style="display:none"><span sort="asc"
                                                                                                   class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                    sort="desc"
                                                    class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                            </div>
                                        </th>
                                        <th id="DYN_SUB_DEVICE_SPEC" role="columnheader" class="ui-th-column ui-th-ltr"
                                            style="width: 16%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                      style="cursor: col-resize;">&nbsp;</span>
                                            <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DEVICE_SPEC">
                                                附件规格<span class="s-ico" style="display:none"><span sort="asc"
                                                                                                   class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                    sort="desc"
                                                    class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                            </div>
                                        </th>
                                        <th id="DYN_SUB_OWNER_ID" role="columnheader" class="ui-th-column ui-th-ltr "
                                            style=" display: none;"><span
                                                class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                            <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_OWNER_ID">责任人Id<span
                                                    class="s-ico" style="display:none"><span sort="asc"
                                                                                             class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                    sort="desc"
                                                    class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                            </div>
                                        </th>
                                        <th id="DYN_SUB_OWNER_IDName" role="columnheader" class="ui-th-column ui-th-ltr"
                                            style="width: 16%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                      style="cursor: col-resize;">&nbsp;</span>
                                            <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_OWNER_IDName">
                                                责任人
                                            </div>
                                        </th>
                                        <th id="DYN_SUB_DEVICE_POSITION" role="columnheader" class="ui-th-column ui-th-ltr "
                                            style="width: 16%;"><span
                                                class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                            <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DEVICE_POSITION">
                                                安装地点
                                            </div>
                                        </th>
                                        <th id="DYN_SUB_FK_SUB_COL_ID" role="columnheader" class="ui-th-column ui-th-ltr "
                                            style="display: none;"><span
                                                class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                            <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_FK_SUB_COL_ID">
                                                外键<span class="s-ico" style="display:none"><span sort="asc"
                                                                                                 class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                    sort="desc"
                                                    class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                            </div>
                                        </th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <div class="ui-jqgrid-bdiv" style="height: 125px; width: 100%; max-height: 150px;">
                            <div style="position:relative;">
                                <div></div>
                                <table id="DYN_SUB" class="datatable ui-jqgrid-btable ui-common-table table table-bordered"
                                       datapermission="eform_data_DYN_SUB" tabindex="0" role="presentation"
                                       aria-multiselectable="true" aria-labelledby="gbox_DYN_SUB" style="width: 100%;">
                                    <tbody>
                                    <tr class="jqgfirstrow ui-priority-secondary" role="row">
                                        <%--<td role="gridcell" style="height:0px;width:35px;"></td>--%>
                                        <td role="gridcell" style="height:0px;width: 4%;display:none;"></td>
                                        <td role="gridcell" style="height: 0px; width: 4%;"></td>
                                        <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                        <td role="gridcell" style="height:0px;width:16%;display:none;"></td>
                                        <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                        <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                        <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                        <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                        <td role="gridcell" style="height:0px;width:16%;display:none;"></td>
                                        <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                        <td role="gridcell" style="height:0px;width:16%;display:none;"></td>
                                    </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="ui-jqgrid-resize-mark" id="rs_mDYN_SUB">&nbsp;</div>

                    <%--<div id="DYN_SUBPager" class="ui-jqgrid-pager" dir="ltr" style="width: 100%;">--%>
                    <%--<div id="pg_DYN_SUBPager" class="ui-pager-control" role="group">--%>
                    <%--<table class="ui-pg-table ui-common-table ui-pager-table table">--%>
                    <%--<tbody>--%>
                    <%--<tr>--%>
                    <%--<td id="DYN_SUBPager_left" align="left" style="width: 396px;">--%>
                    <%--<table class="ui-pg-table ui-common-table ui-paging-pager">--%>
                    <%--<tbody>--%>
                    <%--<tr>--%>
                    <%--<td class="ui-pg-button ui-disabled"><span class="ui-separator"></span></td>--%>
                    <%--<td id="first_DYN_SUBPager" class="ui-pg-button ui-disabled" title="第一页"--%>
                    <%--style="cursor: default;"><span--%>
                    <%--class="glyphicon glyphicon-step-backward"></span></td>--%>
                    <%--<td id="prev_DYN_SUBPager" class="ui-pg-button ui-disabled" title="上一页">--%>
                    <%--<span class="glyphicon glyphicon-backward"></span></td>--%>
                    <%--<td class="ui-pg-button ui-disabled" style="cursor: default;"><span--%>
                    <%--class="ui-separator"></span></td>--%>
                    <%--<td id="input_DYN_SUBPager" dir="ltr">第<input--%>
                    <%--class="ui-pg-input form-control" type="text" size="2" value="0"--%>
                    <%--role="textbox">页　共<span id="sp_1_DYN_SUBPager">0</span>页--%>
                    <%--</td>--%>
                    <%--<td class="ui-pg-button ui-disabled" style="cursor: default;"><span--%>
                    <%--class="ui-separator"></span></td>--%>
                    <%--<td id="next_DYN_SUBPager" class="ui-pg-button" title="下一页"><span--%>
                    <%--class="glyphicon glyphicon-forward"></span></td>--%>
                    <%--<td id="last_DYN_SUBPager" class="ui-pg-button" title="最后一页"--%>
                    <%--style="cursor: default;"><span--%>
                    <%--class="glyphicon glyphicon-step-forward"></span></td>--%>
                    <%--<td dir="ltr"><select class="ui-pg-selbox form-control" role="listbox"--%>
                    <%--title="每页记录数">--%>
                    <%--<option role="option" value="5">5</option>--%>
                    <%--<option role="option" value="10" selected="selected">10</option>--%>
                    <%--<option role="option" value="20">20</option>--%>
                    <%--<option role="option" value="50">50</option>--%>
                    <%--<option role="option" value="100">100</option>--%>
                    <%--<option role="option" value="500">500</option>--%>
                    <%--</select></td>--%>
                    <%--</tr>--%>
                    <%--</tbody>--%>
                    <%--</table>--%>
                    <%--</td>--%>
                    <%--<td id="DYN_SUBPager_center" align="center" style="white-space:pre;display:none;"></td>--%>
                    <%--<td id="DYN_SUBPager_right" align="right">--%>
                    <%--<div dir="ltr" style="text-align:right" class="ui-paging-info">第1到第1条　共 1 条</div>--%>
                    <%--</td>--%>
                    <%--</tr>--%>
                    <%--</tbody>--%>
                    <%--</table>--%>
                    <%--</div>--%>
                    <%--</div>--%>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="ComponentInfo" style="height: 250px;">
                <iframe name="componentIframe" id="componentIframe" src="assets/device/assetsdevicecomponent/assetsDeviceComponentController/toAssetsDeviceComponentManage/'${assetsDeviceAccountDTO.unifiedId}'" frameborder="0" align="left" width="100%" height="100%" scrolling="auto">
                </iframe>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="MaintainInfo" style="height: 250px;">
                <iframe name="maintainIframe" id="maintainIframe" src="assets/device/assetsdevicemaintain/assetsDeviceMaintainController/toAssetsDeviceMaintainManage/'${assetsDeviceAccountDTO.unifiedId}'" frameborder="0" align="left" width="100%" height="100%" scrolling="auto">
                </iframe>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="RegularCheckInfo" style="height: 250px;">
                <iframe name="regularCheckIframe" id="regularCheckIframe" src="assets/device/assetsdeviceregularcheck/assetsDeviceRegularCheckController/toAssetsDeviceRegularCheckManage/'${assetsDeviceAccountDTO.unifiedId}'" frameborder="0" align="left" width="100%" height="100%" scrolling="auto">
                </iframe>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="SpotCheckInfo" style="height: 250px;">
                <iframe name="spotCheckIframe" id="spotCheckIframe" src="assets/device/assetsdevicespotcheck/assetsDeviceSpotCheckController/toAssetsDeviceSpotCheckManage/'${assetsDeviceAccountDTO.unifiedId}'" frameborder="0" align="left" width="100%" height="100%" scrolling="auto">
                </iframe>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="ACCCheckInfo" style="height: 250px;">
                <iframe name="accCheckIframe" id="accCheckIframe" src="assets/device/assetsdeviceacccheck/assetsDeviceAccCheckController/toAssetsDeviceAccCheckManage/'${assetsDeviceAccountDTO.unifiedId}'" frameborder="0" align="left" width="100%" height="100%" scrolling="auto">
                </iframe>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="TDeviceComponentInfo" style="height: 250px;">
                <iframe name="tDeviceComponentIframe" id="tDeviceComponentIframe" src="assets/device/assetstdevicecomponent/assetsTdeviceComponentController/toAssetsTdeviceComponentManage/'${assetsDeviceAccountDTO.unifiedId}'" frameborder="0" align="left" width="100%" height="100%" scrolling="auto">
                </iframe>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="TDeviceSoftwareInfo" style="height: 250px;">
                <iframe name="tDeviceSoftwareIframe" id="tDeviceSoftwareIframe" src="assets/device/assetstdevicesoftware/assetsTdeviceSoftwareController/toAssetsTdeviceSoftwareManage/'${assetsDeviceAccountDTO.unifiedId}'" frameborder="0" align="left" width="100%" height="100%" scrolling="auto">
                </iframe>
            </div>
            <div role="tabpanel" class="tab-pane" contenteditable="false" id="TDeviceAppProductInfo" style="height: 250px;">
                <iframe name="tDeviceAppProductIframe" id="tDeviceAppProductIframe" src="assets/device/assetstdeviceappproduct/assetsTdeviceAppproductController/toAssetsTdeviceAppproductManage/'${assetsDeviceAccountDTO.unifiedId}'" frameborder="0" align="left" width="100%" height="100%" scrolling="auto">
                </iframe>
            </div>
        </div>
    </div>
    <!-- Tab页end -->
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">

    document.ready = function () {
        parent.assetsDeviceAccount.formValidate($('#form'));

    };
    //form控件禁用
    setFormDisabled();
    $(document).keydown(function (event) {
        event.returnValue = false;
        return false;
    });

    <!-- 构建附件列表begin -->
    var tdArr = document.getElementById('DYN_SUB').firstElementChild;
    //删除可能存在的已构建的附件行
    var attachmentRowList = document.getElementsByName("attachmentRow");
    if (attachmentRowList != null) {
        var attachmentRowListLength = attachmentRowList.length;
        // for(i = attachmentRowListLength-1; i > -1; i--){
        //     attachmentRowList[i].remove();
        // }
        while (attachmentRowList.length > 0) {
            attachmentRowList[0].remove();
        }
    }
    //var AttachmentTabChoosed = document.getElementsByClassName('tab-pane active')[0].outerHTML.indexOf('Attachment');
    //if(!((isSameRow == "Y") && (AttachmentTabChoosed != -1))){
    if (true) {
        avicAjax.ajax({
            url:  'platform/assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/' + 'getAttachmentList',
            //_self.getUrl() = platform/assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/
            type: 'POST',
            async: true,
            dataType: 'json',
            data: JSON.stringify({"id": '${assetsDeviceAccountDTO.id}'}),
            contentType: "application/json",
            success: function (assetsDeviceAccountDTOMap) {
                for (i = 0; i < assetsDeviceAccountDTOMap["attachmentList"].length; i++) {
                    var index = i + 1;
                    var unified_id = assetsDeviceAccountDTOMap["attachmentList"][i].unifiedId;
                    var deviceName = assetsDeviceAccountDTOMap["attachmentList"][i].deviceName;
                    var deviceModel = assetsDeviceAccountDTOMap["attachmentList"][i].deviceModel;
                    var deviceSpec = assetsDeviceAccountDTOMap["attachmentList"][i].deviceSpec;
                    var ownerId = assetsDeviceAccountDTOMap["attachmentList"][i].ownerId;
                    var ownerIdAlias = assetsDeviceAccountDTOMap["attachmentList"][i].ownerIdAlias;
                    var positionId = assetsDeviceAccountDTOMap["attachmentList"][i].positionId;
                    var tr = document.createElement("tr");
                    tr.setAttribute("name", "attachmentRow");
                    tr.innerHTML =
                        '<td>' + index + '</td>' +
                        '<td>' + unified_id + '</td>' +
                        '<td>' + deviceName + '</td>' +
                        '<td>' + deviceModel + '</td>' +
                        '<td>' + deviceSpec + '</td>' +
                        '<td>' + ownerIdAlias + '</td>' +
                        '<td>' + positionId + '</td>';
                    ;
                    tdArr.appendChild(tr);
                }
            }
        });
    }
    <!-- 构建附件列表end -->
</script>
</body>
</html>