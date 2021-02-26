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
    <!-- ControllerPath = "assets/device/assetsdeviceaccount/assetsDeviceAccountController/operation/Add/null" -->
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
                    <label for="assetId">资产编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="assetId" id="assetId"/>
                </td>
                <th width="10%">
                    <label for="unifiedId">统一编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">
                    <label for="deviceCategory">设备类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title=""
                                  isNull="true" lookupCode="DEVICE_CATEGORY"/>
                </td>
                <th width="10%">
                    <label for="deviceName">设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deviceModel">设备型号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
                <th width="10%">
                    <label for="deviceSpec">设备规格:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
                <th width="10%">
                    <label for="ownerIdAlias">责任人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias"
                               name="ownerIdAlias">
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
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               name="ownerDeptAlias">
                        <span class="input-group-addon">
							        <i class="glyphicon glyphicon-equalizer"></i>
							      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="userIdAlias">使用人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userId" name="userId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="userIdAlias" name="userIdAlias">
                        <span class="input-group-addon">
							         <i class="glyphicon glyphicon-user"></i>
							      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="userDeptAlias">使用人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userDept" name="userDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="userDeptAlias"
                               name="userDeptAlias">
                        <span class="input-group-addon">
							        <i class="glyphicon glyphicon-equalizer"></i>
							      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="manufacturerId">生产厂家:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId"/>
                </td>
                <th width="10%">
                    <label for="createdDate">立卡日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDate" id="createdDate"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isManage">是否统管设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isManage" id="isManage" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isInWorkflow">是否在流程中:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isInWorkflow" id="isInWorkflow" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="manageState">统管设备状态:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="manageState" id="manageState" title=""
                                  isNull="true" lookupCode="MANAGE_STATE"/>
                </td>
                <th width="10%">
                    <label for="deviceState">设备状态:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceState" id="deviceState" title=""
                                  isNull="true" lookupCode="DEVICE_STATE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="parentId">父级设备ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="parentId" id="parentId"/>
                </td>
                <th width="10%">
                    <label for="parentName">父级设备名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="parentName" id="parentName"/>
                </td>
                <th width="10%">
                    <label for="commonName">常用名:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="commonName" id="commonName"/>
                </td>
                <th width="10%">
                    <label for="positionId">安装地点ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="abcCategory">ABC分类:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="abcCategory" id="abcCategory" title=""
                                  isNull="true" lookupCode="ABC_CATEGORY"/>
                </td>
                <th width="10%">
                    <label for="isKeyDevice">是否军工关键设备设施:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isKeyDevice" id="isKeyDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isResearch">是否科研生产设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isResearch" id="isResearch" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="productCountry">生产国家和地区:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="productCountry" id="productCountry"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="productFactory">制造厂:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="productFactory" id="productFactory"/>
                </td>
                <th width="10%">
                    <label for="supplier">供应商:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="supplier" id="supplier"/>
                </td>
                <th width="10%">
                    <label for="productDate">出厂日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="productDate" id="productDate"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="productNum">出厂编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="productNum" id="productNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="devicePower">功率(单位：千瓦):</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="devicePower" id="devicePower"/>
                </td>
                <th width="10%">
                    <label for="deviceWeight">重量(单位：公斤):</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceWeight" id="deviceWeight"/>
                </td>
                <th width="10%">
                    <label for="deviceSize">外形尺寸:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSize" id="deviceSize"/>
                </td>
                <th width="10%">
                    <label for="checkDate">验收时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="checkDate" id="checkDate"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="improveProject">技改项目:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="improveProject" id="improveProject"/>
                </td>
                <th width="10%">
                    <label for="unitPrice">单价(单位：元):</label></th>
                <td width="15%">
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
                <th width="10%">
                    <label for="contractNum">合同号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="contractNum" id="contractNum"/>
                </td>
                <th width="10%">
                    <label for="applyNum">申购单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="applyNum" id="applyNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="checkNum">验收单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="checkNum" id="checkNum"/>
                </td>
                <th width="10%">
                    <label for="carFrameNum">车架号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="carFrameNum" id="carFrameNum"/>
                </td>
                <th width="10%">
                    <label for="engineNum">发动机号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="engineNum" id="engineNum"/>
                </td>
                <th width="10%">
                    <label for="carNum">车牌号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="carNum" id="carNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="secretLevel">密级:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title=""
                                  isNull="true" lookupCode="SECRET_LEVEL"/>
                </td>
                <th width="10%">
                    <label for="isMetering">是否计量:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isMaintain">是否保养:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMaintain" id="isMaintain" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isAccuracyCheck">是否精度检查:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAccuracyCheck" id="isAccuracyCheck" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isRegularCheck">是否定检:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isRegularCheck" id="isRegularCheck" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isSpotCheck">是否点检:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpotCheck" id="isSpotCheck" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isSpecialDevice">是否特种设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpecialDevice" id="isSpecialDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isSafetyProduction">是否涉及安全生产:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction"
                                  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="isNeedInstall">是否安装:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isPc">是否计算机:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title="" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="deviceType">设备类型:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType" id="deviceType" title=""
                                  isNull="true" lookupCode="DEVICE_TYPE"/>
                </td>
                <th width="10%">
                    <label for="enableDate">设备启用年月:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="enableDate" id="enableDate"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="runningTime">运行时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="runningTime" id="runningTime"
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
                    <label for="ip">IP地址:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="ip" id="ip"/>
                </td>
                <th width="10%">
                    <label for="mac">MAC地址:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="mac" id="mac"/>
                </td>
                <th width="10%">
                    <label for="diskNum">硬盘序列号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="diskNum" id="diskNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="os">操作系统:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="os" id="os"/>
                </td>
                <th width="10%">
                    <label for="osInstallDate">操作系统安装时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="osInstallDate"
                               id="osInstallDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="meteringId">计量文件受控号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="meteringId" id="meteringId"/>
                </td>
                <th width="10%">
                    <label for="metermanAlias">计量人员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meterman" name="meterman">
                        <input class="form-control" placeholder="请选择用户" type="text" id="metermanAlias"
                               name="metermanAlias">
                        <span class="input-group-addon">
							         <i class="glyphicon glyphicon-user"></i>
							      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="meteringDate">计量时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="meteringDate" id="meteringDate"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="meteringCycle">计量周期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="meteringCycle" id="meteringCycle"
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
                    <label for="lastMeteringDate">上次计量日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMeteringDate"
                               id="lastMeteringDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="nextMeteringDate">下次计量日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMeteringDate"
                               id="nextMeteringDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="planMetermanAlias">计量计划员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="planMeterman" name="planMeterman">
                        <input class="form-control" placeholder="请选择用户" type="text" id="planMetermanAlias"
                               name="planMetermanAlias">
                        <span class="input-group-addon">
							         <i class="glyphicon glyphicon-user"></i>
							      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="meteringDeptAlias">计量单位:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meteringDept" name="meteringDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="meteringDeptAlias"
                               name="meteringDeptAlias">
                        <span class="input-group-addon">
							        <i class="glyphicon glyphicon-equalizer"></i>
							      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="isSceneMetering">计量方式:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSceneMetering" id="isSceneMetering" title=""
                                  isNull="true" lookupCode="METERING_MODE"/>
                </td>
                <th width="10%">
                    <label for="lastMaintainDate">上次保养日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMaintainDate"
                               id="lastMaintainDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="lastAccuracyCheckDate">上次精度检查日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastAccuracyCheckDate"
                               id="lastAccuracyCheckDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="meteringConclution">计量结论:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="meteringConclution" id="meteringConclution"
                                  title="" isNull="true" lookupCode="METERING_CONCLUTION"/>
                </td>
                <th width="10%">
                    <label for="totalBorrow">累计借用天数:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalBorrow" id="totalBorrow"
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
                    <label for="safeInfo">安全信息:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="safeInfo" id="safeInfo"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="useCost">设备使用费:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="useCost" id="useCost"
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
                    <label for="repairDeptAlias">维修部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairDept" name="repairDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="repairDeptAlias"
                               name="repairDeptAlias">
                        <span class="input-group-addon">
							        <i class="glyphicon glyphicon-equalizer"></i>
							      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="stateChangeDate">状态变动日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="stateChangeDate"
                               id="stateChangeDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="deviceSysName">设备系统名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="deviceSysName" id="deviceSysName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="deviceRelatedManAlias">设备关联人员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="deviceRelatedMan" name="deviceRelatedMan">
                        <input class="form-control" placeholder="请选择用户" type="text" id="deviceRelatedManAlias"
                               name="deviceRelatedManAlias">
                        <span class="input-group-addon">
							         <i class="glyphicon glyphicon-user"></i>
							      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="isLabDevice">是否实验室设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLabDevice" id="isLabDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isFixedAssets">是否固定资产:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFixedAssets" id="isFixedAssets" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="assetsFinanceType">资产财务类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="assetsFinanceType" id="assetsFinanceType"
                                  title="" isNull="true" lookupCode="ASSETS_FINANCE_TYPE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="assetsSource">资产来源:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="assetsSource" id="assetsSource" title=""
                                  isNull="true" lookupCode="ASSETS_SOURCE"/>
                </td>
                <th width="10%">
                    <label for="assetsFinanceState">资产财务状态:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="assetsFinanceState" id="assetsFinanceState"
                                  title="" isNull="true" lookupCode="ASSETS_FINANCE_STATE"/>
                </td>
                <th width="10%">
                    <label for="financeEntryDate">财务入账时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="financeEntryDate"
                               id="financeEntryDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="originalValue">原值:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="originalValue" id="originalValue"
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
                    <label for="totalDepreciation">累计折旧:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalDepreciation" id="totalDepreciation"
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
                    <label for="depreciationMethod">折旧方法:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="depreciationMethod" id="depreciationMethod"/>
                </td>
                <th width="10%">
                    <label for="depreciationYear">折旧年限:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="depreciationYear" id="depreciationYear"
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
                    <label for="netSalvageRate">净残值率:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netSalvageRate" id="netSalvageRate"
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
                    <label for="netSalvage">净残值:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netSalvage" id="netSalvage"
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
                    <label for="monthDepreciationRate">月折旧率:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthDepreciationRate" id="monthDepreciationRate"
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
                    <label for="monthDepreciation">月折旧额:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthDepreciation" id="monthDepreciation"
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
                    <label for="yearDepreciationRate">年折旧率:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="yearDepreciationRate" id="yearDepreciationRate"
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
                    <label for="yearDepreciation">年折旧额:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="yearDepreciation" id="yearDepreciation"
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
                    <label for="netValue">净值:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netValue" id="netValue"
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
                    <label for="monthCount">已提月份:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthCount" id="monthCount"
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
                    <label for="monthRemain">未计提月份:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthRemain" id="monthRemain"
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
                <th width="10%">
                    <label for="instituteOrCompany">研究所/公司:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="instituteOrCompany" id="instituteOrCompany"
                                  title="" isNull="true" lookupCode="INSTITUTE_OR_COMPANY"/>
                </td>
                <th width="10%">
                    <label for="indexInfo">指标信息:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="indexInfo" id="indexInfo"/>
                </td>
                <th width="10%">
                    <label for="proofNum">凭证编号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="proofNum" id="proofNum"/>
                </td>
                <th width="10%">
                    <label for="isTransFixed">是否转固:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTransFixed" id="isTransFixed" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="meteringOuterAlias">计量外送员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meteringOuter" name="meteringOuter">
                        <input class="form-control" placeholder="请选择用户" type="text" id="meteringOuterAlias"
                               name="meteringOuterAlias">
                        <span class="input-group-addon">
							         <i class="glyphicon glyphicon-user"></i>
							      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="applyModel">适用机型:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="applyModel" id="applyModel"/>
                </td>
                <th width="10%">
                    <label for="applyProduct">适用产品:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="applyProduct" id="applyProduct"/>
                </td>
                <th width="10%">
                    <label for="testedObject">受测对象:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="testedObject" id="testedObject"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="majorType">专业类别:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="majorType" id="majorType" title=""
                                  isNull="true" lookupCode="MAJOR_TYPE"/>
                </td>
                <th width="10%">
                    <label for="deviceNature">设备性质:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceNature" id="deviceNature" title=""
                                  isNull="true" lookupCode="DEVICE_NATURE"/>
                </td>
                <th width="10%">
                    <label for="softwareNum">软件标识号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="softwareNum" id="softwareNum"/>
                </td>
                <th width="10%">
                    <label for="softwareDesignerAlias">软件设计人员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="softwareDesigner" name="softwareDesigner">
                        <input class="form-control" placeholder="请选择用户" type="text" id="softwareDesignerAlias"
                               name="softwareDesignerAlias">
                        <span class="input-group-addon">
							         <i class="glyphicon glyphicon-user"></i>
							      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="hardwareDesignerAlias">硬件设计人员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="hardwareDesigner" name="hardwareDesigner">
                        <input class="form-control" placeholder="请选择用户" type="text" id="hardwareDesignerAlias"
                               name="hardwareDesignerAlias">
                        <span class="input-group-addon">
							         <i class="glyphicon glyphicon-user"></i>
							      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="isTestDevice">是否测试设备:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">
                    <label for="isNeedCertificate">是否需要操作证:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedCertificate" id="isNeedCertificate" title=""
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">
                    <label for="guaranteePeriod">质保期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="guaranteePeriod" id="guaranteePeriod"
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
                <th width="10%">
                    <label for="guaranteeDate">质保截止日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="guaranteeDate"
                               id="guaranteeDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
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
                       title="保存" id="assetsDeviceAccount_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsDeviceAccount_closeForm">返回</a>
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
        parent.assetsDeviceAccount.closeDialog("insert");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        //限制保存按钮多次点击
        $('#assetsDeviceAccount_saveForm').addClass('disabled').unbind("click");
        parent.assetsDeviceAccount.save($('#form'), "insert");
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

        parent.assetsDeviceAccount.formValidate($('#form'));
        //保存按钮绑定事件
        $('#assetsDeviceAccount_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsDeviceAccount_closeForm').bind('click', function () {
            closeForm();
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
        $('#userIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'userId', textFiled: 'userIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#userDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'userDept', textFiled: 'userDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#metermanAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meterman', textFiled: 'metermanAlias'});
            this.blur();
            nullInput(e);
        });
        $('#planMetermanAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'planMeterman', textFiled: 'planMetermanAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meteringDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'meteringDept', textFiled: 'meteringDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#repairDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'repairDept', textFiled: 'repairDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deviceRelatedManAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'deviceRelatedMan', textFiled: 'deviceRelatedManAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meteringOuterAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meteringOuter', textFiled: 'meteringOuterAlias'});
            this.blur();
            nullInput(e);
        });
        $('#softwareDesignerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'softwareDesigner', textFiled: 'softwareDesignerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#hardwareDesignerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'hardwareDesigner', textFiled: 'hardwareDesignerAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>