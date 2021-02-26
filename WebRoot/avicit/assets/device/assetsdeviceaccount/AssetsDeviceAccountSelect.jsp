<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
    String singleSelect = request.getParameter("singleSelect"); // 是否单选参数（true-单选,flae-多选）
    if ("undefined".equals(singleSelect) || "".equals(singleSelect) || !"false".equals(singleSelect)) { // 如果不传或者传false以外的值时默认单选
        singleSelect = "true";
    }
    String requestType = request.getParameter("requestType"); // 页面调用字段识别，用于一个页面有多个相同弹出页面时使用
    if ("undefined".equals(requestType) || "".equals(requestType)) {
        requestType = "productModelSelect";
    }
    String callBackFn = request.getParameter("callBackFn"); // 回调函数名称


%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "device/assetsdeviceaccount/assetsDeviceAccountController/toAssetsDeviceAccountManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceAccount_button_add"--%>
        <%--permissionDes="添加">--%>
        <%--<a id="assetsDeviceAccount_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"--%>
        <%--role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>--%>
        <%--</sec:accesscontrollist>--%>
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceAccount_button_edit"--%>
        <%--permissionDes="编辑">--%>
        <%--<a id="assetsDeviceAccount_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"--%>
        <%--role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>--%>
        <%--</sec:accesscontrollist>--%>
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceAccount_button_delete"--%>
        <%--permissionDes="删除">--%>
        <%--<a id="assetsDeviceAccount_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"--%>
        <%--role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>--%>
        <%--</sec:accesscontrollist>--%>
        <sec:accesscontrollist hasPermission="3"
                               domainObject="formdialog_cspBdProductModel_button_add"
                               permissionDes="提交">
            <a id="cspBdProductModel_insert" href="javascript:void(0)"
               class="btn btn-primary form-tool-btn btn-sm" role="button"
               title="提交"><i class="fa fa-plus"></i>提交</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsDeviceAccount_keyWord" id="assetsDeviceAccount_keyWord" style="width:240px;"
                   class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsDeviceAccount_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsDeviceAccount_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button"
               title="高级查询">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsDeviceAccountjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">资产编号:</th>
                <td width="15%">
                    <input title="资产编号" class="form-control input-sm" type="text" name="assetId" id="assetId"/>
                </td>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">设备类别:</th>
                <td width="15%">
                    <input title="设备类别" class="form-control input-sm" type="text" name="deviceCategory"
                           id="deviceCategory"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
                <th width="10%">责任人:</th>
                <td width="15%">
                    <input title="责任人" class="form-control input-sm" type="text" name="ownerId" id="ownerId"/>
                </td>
                <th width="10%">责任人部门:</th>
                <td width="15%">
                    <input title="责任人部门" class="form-control input-sm" type="text" name="ownerDept" id="ownerDept"/>
                </td>
            </tr>
            <tr>
                <th width="10%">使用人:</th>
                <td width="15%">
                    <input title="使用人" class="form-control input-sm" type="text" name="userId" id="userId"/>
                </td>
                <th width="10%">使用人部门:</th>
                <td width="15%">
                    <input title="使用人部门" class="form-control input-sm" type="text" name="userDept" id="userDept"/>
                </td>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId"
                           id="manufacturerId"/>
                </td>
                <th width="10%">立卡日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateBegin"
                               id="createdDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">立卡日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateEnd" id="createdDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">是否统管设备:</th>
                <td width="15%">
                    <input title="是否统管设备" class="form-control input-sm" type="text" name="isManage" id="isManage"/>
                </td>
                <th width="10%">是否在流程中:</th>
                <td width="15%">
                    <input title="是否在流程中" class="form-control input-sm" type="text" name="isInWorkflow"
                           id="isInWorkflow"/>
                </td>
                <th width="10%">统管设备状态:</th>
                <td width="15%">
                    <input title="统管设备状态" class="form-control input-sm" type="text" name="manageState"
                           id="manageState"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备状态:</th>
                <td width="15%">
                    <input title="设备状态" class="form-control input-sm" type="text" name="deviceState" id="deviceState"/>
                </td>
                <th width="10%">父级设备ID:</th>
                <td width="15%">
                    <input title="父级设备ID" class="form-control input-sm" type="text" name="parentId" id="parentId"/>
                </td>
                <th width="10%">父级设备名称:</th>
                <td width="15%">
                    <input title="父级设备名称" class="form-control input-sm" type="text" name="parentName" id="parentName"/>
                </td>
                <th width="10%">常用名:</th>
                <td width="15%">
                    <input title="常用名" class="form-control input-sm" type="text" name="commonName" id="commonName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">安装地点ID:</th>
                <td width="15%">
                    <input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">ABC分类:</th>
                <td width="15%">
                    <input title="ABC分类" class="form-control input-sm" type="text" name="abcCategory" id="abcCategory"/>
                </td>
                <th width="10%">是否军工关键设备设施:</th>
                <td width="15%">
                    <input title="是否军工关键设备设施" class="form-control input-sm" type="text" name="isKeyDevice"
                           id="isKeyDevice"/>
                </td>
                <th width="10%">是否科研生产设备:</th>
                <td width="15%">
                    <input title="是否科研生产设备" class="form-control input-sm" type="text" name="isResearch"
                           id="isResearch"/>
                </td>
            </tr>
            <tr>
                <th width="10%">生产国家和地区:</th>
                <td width="15%">
                    <input title="生产国家和地区" class="form-control input-sm" type="text" name="productCountry"
                           id="productCountry"/>
                </td>
                <th width="10%">制造厂:</th>
                <td width="15%">
                    <input title="制造厂" class="form-control input-sm" type="text" name="productFactory"
                           id="productFactory"/>
                </td>
                <th width="10%">供应商:</th>
                <td width="15%">
                    <input title="供应商" class="form-control input-sm" type="text" name="supplier" id="supplier"/>
                </td>
                <th width="10%">出厂日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="productDateBegin"
                               id="productDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">出厂日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="productDateEnd" id="productDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">出厂编号:</th>
                <td width="15%">
                    <input title="出厂编号" class="form-control input-sm" type="text" name="productNum" id="productNum"/>
                </td>
                <th width="10%">功率(单位：千瓦):</th>
                <td width="15%">
                    <input title="功率(单位：千瓦)" class="form-control input-sm" type="text" name="devicePower"
                           id="devicePower"/>
                </td>
                <th width="10%">重量(单位：公斤):</th>
                <td width="15%">
                    <input title="重量(单位：公斤)" class="form-control input-sm" type="text" name="deviceWeight"
                           id="deviceWeight"/>
                </td>
            </tr>
            <tr>
                <th width="10%">外形尺寸:</th>
                <td width="15%">
                    <input title="外形尺寸" class="form-control input-sm" type="text" name="deviceSize" id="deviceSize"/>
                </td>
                <th width="10%">验收时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="checkDateBegin" id="checkDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">验收时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="checkDateEnd" id="checkDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">技改项目:</th>
                <td width="15%">
                    <input title="技改项目" class="form-control input-sm" type="text" name="improveProject"
                           id="improveProject"/>
                </td>
            </tr>
            <tr>
                <th width="10%">单价(单位：元):</th>
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
                <th width="10%">合同号:</th>
                <td width="15%">
                    <input title="合同号" class="form-control input-sm" type="text" name="contractNum" id="contractNum"/>
                </td>
                <th width="10%">申购单号:</th>
                <td width="15%">
                    <input title="申购单号" class="form-control input-sm" type="text" name="applyNum" id="applyNum"/>
                </td>
                <th width="10%">验收单号:</th>
                <td width="15%">
                    <input title="验收单号" class="form-control input-sm" type="text" name="checkNum" id="checkNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">车架号:</th>
                <td width="15%">
                    <input title="车架号" class="form-control input-sm" type="text" name="carFrameNum" id="carFrameNum"/>
                </td>
                <th width="10%">发动机号:</th>
                <td width="15%">
                    <input title="发动机号" class="form-control input-sm" type="text" name="engineNum" id="engineNum"/>
                </td>
                <th width="10%">车牌号:</th>
                <td width="15%">
                    <input title="车牌号" class="form-control input-sm" type="text" name="carNum" id="carNum"/>
                </td>
                <th width="10%">密级:</th>
                <td width="15%">
                    <input title="密级" class="form-control input-sm" type="text" name="secretLevel" id="secretLevel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否计量:</th>
                <td width="15%">
                    <input title="是否计量" class="form-control input-sm" type="text" name="isMetering" id="isMetering"/>
                </td>
                <th width="10%">是否保养:</th>
                <td width="15%">
                    <input title="是否保养" class="form-control input-sm" type="text" name="isMaintain" id="isMaintain"/>
                </td>
                <th width="10%">是否精度检查:</th>
                <td width="15%">
                    <input title="是否精度检查" class="form-control input-sm" type="text" name="isAccuracyCheck"
                           id="isAccuracyCheck"/>
                </td>
                <th width="10%">是否定检:</th>
                <td width="15%">
                    <input title="是否定检" class="form-control input-sm" type="text" name="isRegularCheck"
                           id="isRegularCheck"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否点检:</th>
                <td width="15%">
                    <input title="是否点检" class="form-control input-sm" type="text" name="isSpotCheck" id="isSpotCheck"/>
                </td>
                <th width="10%">是否特种设备:</th>
                <td width="15%">
                    <input title="是否特种设备" class="form-control input-sm" type="text" name="isSpecialDevice"
                           id="isSpecialDevice"/>
                </td>
                <th width="10%">是否涉及安全生产:</th>
                <td width="15%">
                    <input title="是否涉及安全生产" class="form-control input-sm" type="text" name="isSafetyProduction"
                           id="isSafetyProduction"/>
                </td>
                <th width="10%">是否安装:</th>
                <td width="15%">
                    <input title="是否安装" class="form-control input-sm" type="text" name="isNeedInstall"
                           id="isNeedInstall"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否计算机:</th>
                <td width="15%">
                    <input title="是否计算机" class="form-control input-sm" type="text" name="isPc" id="isPc"/>
                </td>
                <th width="10%">设备类型:</th>
                <td width="15%">
                    <input title="设备类型" class="form-control input-sm" type="text" name="deviceType" id="deviceType"/>
                </td>
                <th width="10%">设备启用年月(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="enableDateBegin"
                               id="enableDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">设备启用年月(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="enableDateEnd" id="enableDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">运行时间:</th>
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
                <th width="10%">IP地址:</th>
                <td width="15%">
                    <input title="IP地址" class="form-control input-sm" type="text" name="ip" id="ip"/>
                </td>
                <th width="10%">MAC地址:</th>
                <td width="15%">
                    <input title="MAC地址" class="form-control input-sm" type="text" name="mac" id="mac"/>
                </td>
                <th width="10%">硬盘序列号:</th>
                <td width="15%">
                    <input title="硬盘序列号" class="form-control input-sm" type="text" name="diskNum" id="diskNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">操作系统:</th>
                <td width="15%">
                    <input title="操作系统" class="form-control input-sm" type="text" name="os" id="os"/>
                </td>
                <th width="10%">操作系统安装时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="osInstallDateBegin"
                               id="osInstallDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">操作系统安装时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="osInstallDateEnd"
                               id="osInstallDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计量文件受控号:</th>
                <td width="15%">
                    <input title="计量文件受控号" class="form-control input-sm" type="text" name="meteringId" id="meteringId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">计量人员:</th>
                <td width="15%">
                    <input title="计量人员" class="form-control input-sm" type="text" name="meterman" id="meterman"/>
                </td>
                <th width="10%">计量时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="meteringDateBegin"
                               id="meteringDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计量时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="meteringDateEnd"
                               id="meteringDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计量周期:</th>
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
            </tr>
            <tr>
                <th width="10%">上次计量日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMeteringDateBegin"
                               id="lastMeteringDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上次计量日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMeteringDateEnd"
                               id="lastMeteringDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">下次计量日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMeteringDateBegin"
                               id="nextMeteringDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">下次计量日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMeteringDateEnd"
                               id="nextMeteringDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">计量计划员:</th>
                <td width="15%">
                    <input title="计量计划员" class="form-control input-sm" type="text" name="planMeterman"
                           id="planMeterman"/>
                </td>
                <th width="10%">计量单位:</th>
                <td width="15%">
                    <input title="计量单位" class="form-control input-sm" type="text" name="meteringDept"
                           id="meteringDept"/>
                </td>
                <th width="10%">是否现场计量:</th>
                <td width="15%">
                    <input title="是否现场计量" class="form-control input-sm" type="text" name="isSceneMetering"
                           id="isSceneMetering"/>
                </td>
                <th width="10%">上次保养日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMaintainDateBegin"
                               id="lastMaintainDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">上次保养日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMaintainDateEnd"
                               id="lastMaintainDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上次精度检查日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastAccuracyCheckDateBegin"
                               id="lastAccuracyCheckDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上次精度检查日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastAccuracyCheckDateEnd"
                               id="lastAccuracyCheckDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计量结论:</th>
                <td width="15%">
                    <input title="计量结论" class="form-control input-sm" type="text" name="meteringConclution"
                           id="meteringConclution"/>
                </td>
            </tr>
            <tr>
                <th width="10%">累计借用天数:</th>
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
                <th width="10%">安全信息:</th>
                <td width="15%">
                    <input title="安全信息" class="form-control input-sm" type="text" name="safeInfo" id="safeInfo"/>
                </td>
                <th width="10%">设备使用费:</th>
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
                <th width="10%">维修部门:</th>
                <td width="15%">
                    <input title="维修部门" class="form-control input-sm" type="text" name="repairDept" id="repairDept"/>
                </td>
            </tr>
            <tr>
                <th width="10%">状态变动日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="stateChangeDateBegin"
                               id="stateChangeDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">状态变动日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="stateChangeDateEnd"
                               id="stateChangeDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">设备系统名称:</th>
                <td width="15%">
                    <input title="设备系统名称" class="form-control input-sm" type="text" name="deviceSysName"
                           id="deviceSysName"/>
                </td>
                <th width="10%">设备关联人员:</th>
                <td width="15%">
                    <input title="设备关联人员" class="form-control input-sm" type="text" name="deviceRelatedMan"
                           id="deviceRelatedMan"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否实验室设备:</th>
                <td width="15%">
                    <input title="是否实验室设备" class="form-control input-sm" type="text" name="isLabDevice"
                           id="isLabDevice"/>
                </td>
                <th width="10%">是否固定资产:</th>
                <td width="15%">
                    <input title="是否固定资产" class="form-control input-sm" type="text" name="isFixedAssets"
                           id="isFixedAssets"/>
                </td>
                <th width="10%">资产财务类别:</th>
                <td width="15%">
                    <input title="资产财务类别" class="form-control input-sm" type="text" name="assetsFinanceType"
                           id="assetsFinanceType"/>
                </td>
                <th width="10%">资产来源:</th>
                <td width="15%">
                    <input title="资产来源" class="form-control input-sm" type="text" name="assetsSource"
                           id="assetsSource"/>
                </td>
            </tr>
            <tr>
                <th width="10%">资产财务状态:</th>
                <td width="15%">
                    <input title="资产财务状态" class="form-control input-sm" type="text" name="assetsFinanceState"
                           id="assetsFinanceState"/>
                </td>
                <th width="10%">财务入账时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="financeEntryDateBegin"
                               id="financeEntryDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">财务入账时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="financeEntryDateEnd"
                               id="financeEntryDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">原值:</th>
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
                <th width="10%">累计折旧:</th>
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
                <th width="10%">折旧方法:</th>
                <td width="15%">
                    <input title="折旧方法" class="form-control input-sm" type="text" name="depreciationMethod"
                           id="depreciationMethod"/>
                </td>
                <th width="10%">折旧年限:</th>
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
                <th width="10%">净残值率:</th>
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
                <th width="10%">净残值:</th>
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
                <th width="10%">月折旧率:</th>
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
                <th width="10%">月折旧额:</th>
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
                <th width="10%">年折旧率:</th>
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
                <th width="10%">年折旧额:</th>
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
                <th width="10%">净值:</th>
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
                <th width="10%">已提月份:</th>
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
                <th width="10%">未计提月份:</th>
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
                <th width="10%">研究所/公司:</th>
                <td width="15%">
                    <input title="研究所/公司" class="form-control input-sm" type="text" name="instituteOrCompany"
                           id="instituteOrCompany"/>
                </td>
                <th width="10%">指标信息:</th>
                <td width="15%">
                    <input title="指标信息" class="form-control input-sm" type="text" name="indexInfo" id="indexInfo"/>
                </td>
                <th width="10%">是否需要操作证:</th>
                <td width="15%">
                    <input title="是否需要操作证" class="form-control input-sm" type="text" name="isNeedCertificate"
                           id="isNeedCertificate"/>
                </td>
                <th width="10%">是否转固:</th>
                <td width="15%">
                    <input title="是否转固" class="form-control input-sm" type="text" name="isTransFixed"
                           id="isTransFixed"/>
                </td>
            </tr>
            <tr>
                <th width="10%">计量外送员:</th>
                <td width="15%">
                    <input title="计量外送员" class="form-control input-sm" type="text" name="meteringOuter"
                           id="meteringOuter"/>
                </td>
                <th width="10%">适用机型:</th>
                <td width="15%">
                    <input title="适用机型" class="form-control input-sm" type="text" name="applyModel" id="applyModel"/>
                </td>
                <th width="10%">适用产品:</th>
                <td width="15%">
                    <input title="适用产品" class="form-control input-sm" type="text" name="applyProduct"
                           id="applyProduct"/>
                </td>
                <th width="10%">受测对象:</th>
                <td width="15%">
                    <input title="受测对象" class="form-control input-sm" type="text" name="testedObject"
                           id="testedObject"/>
                </td>
            </tr>
            <tr>
                <th width="10%">专业类别:</th>
                <td width="15%">
                    <input title="专业类别" class="form-control input-sm" type="text" name="majorType" id="majorType"/>
                </td>
                <th width="10%">设备性质:</th>
                <td width="15%">
                    <input title="设备性质" class="form-control input-sm" type="text" name="deviceNature"
                           id="deviceNature"/>
                </td>
                <th width="10%">软件标识号:</th>
                <td width="15%">
                    <input title="软件标识号" class="form-control input-sm" type="text" name="softwareNum" id="softwareNum"/>
                </td>
                <th width="10%">软件设计人员:</th>
                <td width="15%">
                    <input title="软件设计人员" class="form-control input-sm" type="text" name="softwareDesigner"
                           id="softwareDesigner"/>
                </td>
            </tr>
            <tr>
                <th width="10%">硬件设计人员:</th>
                <td width="15%">
                    <input title="硬件设计人员" class="form-control input-sm" type="text" name="hardwareDesigner"
                           id="hardwareDesigner"/>
                </td>
                <th width="10%">是否测试设备:</th>
                <td width="15%">
                    <input title="是否测试设备" class="form-control input-sm" type="text" name="isTestDevice"
                           id="isTestDevice"/>
                </td>
                <th width="10%">凭证编号:</th>
                <td width="15%">
                    <input title="凭证编号" class="form-control input-sm" type="text" name="proofNum" id="proofNum"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script src="avicit/assets/device/assetsdeviceaccount/js/AssetsDeviceAccountSelect.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsDeviceAccountSelect;
    var singleSelect = '<%=singleSelect%>';
    var requestType = '<%=requestType%>';
    var callBackFn = '<%=callBackFn%>';

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsDeviceAccountSelect.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsDeviceAccountSelect.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '资产编号', name: 'assetId', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '设备类别CODE', name: 'deviceCategoryId', width: 150,hidden: true}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '责任人', name: 'ownerId', width: 150, hidden: true}
            , {label: '责任人部门', name: 'ownerDept', width: 150, hidden: true}
            , {label: '使用人', name: 'userId', width: 150, hidden: true}
            , {label: '使用人', name: 'userIdAlias', width: 150, hidden: true}
            , {label: '使用人部门', name: 'userDept', width: 150, hidden: true}
            , {label: '使用人部门', name: 'userDeptAlias', width: 150, hidden: true}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            , {label: '责任人部门', name: 'ownerDeptAlias', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '立卡日期', name: 'createdDate', width: 150, formatter: format}
            , {label: '是否统管设备', name: 'isManage', width: 150, hidden: true}
            , {label: '是否在流程中', name: 'isInWorkflow', width: 150, hidden: true}
            , {label: '统管设备状态', name: 'manageState', width: 150, hidden: true}
            , {label: '设备状态', name: 'deviceState', width: 150, hidden: true}
            , {label: '父级设备ID', name: 'parentId', width: 150, hidden: true}
            , {label: '父级设备名称', name: 'parentName', width: 150, hidden: true}
            , {label: '常用名', name: 'commonName', width: 150, hidden: true}
            , {label: '安装地点ID', name: 'positionId', width: 150, hidden: true}
            , {label: 'ABC分类', name: 'abcCategory', width: 150, hidden: true}
            , {label: '是否军工关键设备设施', name: 'isKeyDevice', width: 150, hidden: true}
            , {label: '是否科研生产设备', name: 'isResearch', width: 150, hidden: true}
            , {label: '生产国家和地区', name: 'productCountry', width: 150, hidden: true}
            , {label: '制造厂', name: 'productFactory', width: 150, hidden: true}
            , {label: '供应商', name: 'supplier', width: 150, hidden: true}
            , {label: '出厂日期', name: 'productDate', width: 150, formatter: format, hidden: true}
            , {label: '出厂编号', name: 'productNum', width: 150, hidden: true}
            , {label: '功率(单位：千瓦)', name: 'devicePower', width: 150, hidden: true}
            , {label: '重量(单位：公斤)', name: 'deviceWeight', width: 150, hidden: true}
            , {label: '外形尺寸', name: 'deviceSize', width: 150, hidden: true}
            , {label: '验收时间', name: 'checkDate', width: 150, formatter: format, hidden: true}
            , {label: '技改项目', name: 'improveProject', width: 150, hidden: true}
            , {label: '单价(单位：元)', name: 'unitPrice', width: 150, hidden: true}
            , {label: '合同号', name: 'contractNum', width: 150, hidden: true}
            , {label: '申购单号', name: 'applyNum', width: 150, hidden: true}
            , {label: '验收单号', name: 'checkNum', width: 150, hidden: true}
            , {label: '车架号', name: 'carFrameNum', width: 150, hidden: true}
            , {label: '发动机号', name: 'engineNum', width: 150, hidden: true}
            , {label: '车牌号', name: 'carNum', width: 150, hidden: true}
            , {label: '密级', name: 'secretLevel', width: 150, hidden: true}
            , {label: '是否计量', name: 'isMetering', width: 150, hidden: true}
            , {label: '是否保养', name: 'isMaintain', width: 150, hidden: true}
            , {label: '是否精度检查', name: 'isAccuracyCheck', width: 150, hidden: true}
            , {label: '是否定检', name: 'isRegularCheck', width: 150, hidden: true}
            , {label: '是否点检', name: 'isSpotCheck', width: 150, hidden: true}
            , {label: '是否特种设备', name: 'isSpecialDevice', width: 150, hidden: true}
            , {label: '是否涉及安全生产', name: 'isSafetyProduction', width: 150, hidden: true}
            , {label: '是否安装', name: 'isNeedInstall', width: 150, hidden: true}
            , {label: '是否计算机', name: 'isPc', width: 150, hidden: true}
            , {label: '设备类型', name: 'deviceType', width: 150, hidden: true}
            , {label: '设备启用年月', name: 'enableDate', width: 150, formatter: format, hidden: true}
            , {label: '运行时间', name: 'runningTime', width: 150, hidden: true}
            , {label: 'IP地址', name: 'ip', width: 150, hidden: true}
            , {label: 'MAC地址', name: 'mac', width: 150, hidden: true}
            , {label: '硬盘序列号', name: 'diskNum', width: 150, hidden: true}
            , {label: '操作系统', name: 'os', width: 150, hidden: true}
            , {label: '操作系统安装时间', name: 'osInstallDate', width: 150, formatter: format, hidden: true}
            , {label: '计量文件受控号', name: 'meteringId', width: 150, hidden: true}
            , {label: '计量人员ID', name: 'meterman', width: 150, hidden: true}
            , {label: '计量人员', name: 'metermanAlias', width: 150, hidden: true}
            , {label: '计量时间', name: 'meteringDate', width: 150, formatter: format, hidden: true}
            , {label: '计量周期', name: 'meteringCycle', width: 150, hidden: true}
            , {label: '上次计量日期', name: 'lastMeteringDate', width: 150, formatter: format, hidden: true}
            , {label: '下次计量日期', name: 'nextMeteringDate', width: 150, formatter: format, hidden: true}
            , {label: '计量计划员ID', name: 'planMeterman', width: 150, hidden: true}
            , {label: '计量计划员', name: 'planMetermanAlias', width: 150, hidden: true}
            , {label: '计量单位', name: 'meteringDept', width: 150, hidden: true}
            , {label: '是否现场计量', name: 'isSceneMetering', width: 150, hidden: true}
            , {label: '上次保养日期', name: 'lastMaintainDate', width: 150, formatter: format, hidden: true}
            , {label: '上次精度检查日期', name: 'lastAccuracyCheckDate', width: 150, formatter: format, hidden: true}
            , {label: '计量结论', name: 'meteringConclution', width: 150, hidden: true}
            , {label: '累计借用天数', name: 'totalBorrow', width: 150, hidden: true}
            , {label: '安全信息', name: 'safeInfo', width: 150, hidden: true}
            , {label: '设备使用费', name: 'useCost', width: 150, hidden: true}
            , {label: '维修部门', name: 'repairDept', width: 150, hidden: true}
            , {label: '状态变动日期', name: 'stateChangeDate', width: 150, formatter: format, hidden: true}
            , {label: '设备系统名称', name: 'deviceSysName', width: 150, hidden: true}
            , {label: '设备关联人员', name: 'deviceRelatedMan', width: 150, hidden: true}
            , {label: '是否实验室设备', name: 'isLabDevice', width: 150, hidden: true}
            , {label: '是否固定资产', name: 'isFixedAssets', width: 150, hidden: true}
            , {label: '资产财务类别', name: 'assetsFinanceType', width: 150, hidden: true}
            , {label: '资产来源', name: 'assetsSource', width: 150, hidden: true}
            , {label: '资产财务状态', name: 'assetsFinanceState', width: 150, hidden: true}
            , {label: '财务入账时间', name: 'financeEntryDate', width: 150, formatter: format, hidden: true}
            , {label: '原值', name: 'originalValue', width: 150, hidden: true}
            , {label: '累计折旧', name: 'totalDepreciation', width: 150, hidden: true}
            , {label: '折旧方法', name: 'depreciationMethod', width: 150, hidden: true}
            , {label: '折旧年限', name: 'depreciationYear', width: 150, hidden: true}
            , {label: '净残值率', name: 'netSalvageRate', width: 150, hidden: true}
            , {label: '净残值', name: 'netSalvage', width: 150, hidden: true}
            , {label: '月折旧率', name: 'monthDepreciationRate', width: 150, hidden: true}
            , {label: '月折旧额', name: 'monthDepreciation', width: 150, hidden: true}
            , {label: '年折旧率', name: 'yearDepreciationRate', width: 150, hidden: true}
            , {label: '年折旧额', name: 'yearDepreciation', width: 150, hidden: true}
            , {label: '净值', name: 'netValue', width: 150, hidden: true}
            , {label: '已提月份', name: 'monthCount', width: 150, hidden: true}
            , {label: '未计提月份', name: 'monthRemain', width: 150, hidden: true}
            , {label: '研究所/公司', name: 'instituteOrCompany', width: 150, hidden: true}
            , {label: '指标信息', name: 'indexInfo', width: 150, hidden: true}
            , {label: '是否需要操作证', name: 'isNeedCertificate', width: 150, hidden: true}
            , {label: '是否转固', name: 'isTransFixed', width: 150, hidden: true}
            , {label: '计量外送员', name: 'meteringOuter', width: 150, hidden: true}
            , {label: '适用机型', name: 'applyModel', width: 150, hidden: true}
            , {label: '适用产品', name: 'applyProduct', width: 150, hidden: true}
            , {label: '受测对象', name: 'testedObject', width: 150, hidden: true}
            , {label: '专业类别', name: 'majorType', width: 150, hidden: true}
            , {label: '设备性质', name: 'deviceNature', width: 150, hidden: true}
            , {label: '软件标识号', name: 'softwareNum', width: 150, hidden: true}
            , {label: '软件设计人员', name: 'softwareDesigner', width: 150, hidden: true}
            , {label: '硬件设计人员', name: 'hardwareDesigner', width: 150, hidden: true}
            , {label: '是否测试设备', name: 'isTestDevice', width: 150, hidden: true}
            , {label: '凭证编号', name: 'proofNum', width: 150, hidden: true}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("assetId");
        searchTips.push("资产编号");
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsDeviceAccount_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsDeviceAccountSelect = new AssetsDeviceAccount('assetsDeviceAccountjqGrid', '${url}', 'searchDialog', 'form', 'assetsDeviceAccount_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsDeviceAccount_insert').bind('click', function () {
            assetsDeviceAccountSelect.insert();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceAccount_modify').bind('click', function () {
            assetsDeviceAccountSelect.modify();
        });
        //删除按钮绑定事件
        $('#assetsDeviceAccount_del').bind('click', function () {
            assetsDeviceAccountSelect.del();
        });
        //查询按钮绑定事件
        $('#assetsDeviceAccount_searchPart').bind('click', function () {
            assetsDeviceAccountSelect.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsDeviceAccount_searchAll').bind('click', function () {
            assetsDeviceAccountSelect.openSearchForm(this);
        });

    });
    $('#cspBdProductModel_insert').bind('click',
        function () {
            assetsDeviceAccountSelect.submit();
        });

</script>
</html>