<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/toAssetsUstdtempapplyCtMainManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<style>
    tbody tr {
        text-align: center;
    }
</style>
<body class="easyui-layout" fit="true">
<div id="panelnorth"
     data-options="region:'north',height:fixheight(1),onResize:function(a){$('#assetsUstdtempapplyCtMain').setGridWidth(a);$('#assetsUstdtempapplyCtMain').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
    <div id="toolbar_assetsUstdtempapplyCtMain" class="toolbar">
        <div class="toolbar-left">
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempapplyCtMain_button_add"
                                   permissionDes="添加">
                <a id="assetsUstdtempapplyCtMain_insert" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i>
                    添加</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempapplyCtMain_button_edit"
                                   permissionDes="编辑">
                <a id="assetsUstdtempapplyCtMain_modify" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="编辑"><i
                        class="fa fa-file-text-o"></i> 编辑</a>
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempapplyCtMain_button_delete"
                                   permissionDes="删除">
                <a id="assetsUstdtempapplyCtMain_del" href="javascript:void(0)"
                   class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="删除"><i
                        class="fa fa-trash-o"></i> 删除</a>
            </sec:accesscontrollist>
        </div>
        <div class="toolbar-right">
            <select id="workFlowSelect"
                    class="form-control input-sm workflow-select">
                <option value="all" selected="selected">全部</option>
                <option value="start">拟稿中</option>
                <option value="active">流转中</option>
                <option value="ended">已完成</option>
            </select>
            <div class="input-group form-tool-search" style="width:125px">
                <input type="text" name="assetsUstdtempapplyCtMain_keyWord" id="assetsUstdtempapplyCtMain_keyWord"
                       style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
                <label id="assetsUstdtempapplyCtMain_searchPart" class="icon icon-search form-tool-searchicon"></label>
            </div>
            <div class="input-group-btn form-tool-searchbtn">
                <a id="assetsUstdtempapplyCtMain_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
                   role="button">高级查询 <span class="caret"></span></a>
            </div>
        </div>
    </div>
    <table id="assetsUstdtempapplyCtMain"></table>
    <div id="assetsUstdtempapplyCtMainPager"></div>
</div>
<%--<div id="centerpanel"--%>
     <%--data-options="region:'center',split:true,onResize:function(a){$('#assetsUstdtempapplyCollect').setGridWidth(a); $('#assetsUstdtempapplyCollect').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">--%>
    <%--<div id="toolbar_assetsUstdtempapplyCollect" class="toolbar">--%>
        <%--<div class="toolbar-right">--%>
            <%--<div class="input-group form-tool-search" style="width:125px">--%>
                <%--<input type="text" name="assetsUstdtempapplyCollect_keyWord" id="assetsUstdtempapplyCollect_keyWord"--%>
                       <%--style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">--%>
                <%--<label id="assetsUstdtempapplyCollect_searchPart" class="icon icon-search form-tool-searchicon"></label>--%>
            <%--</div>--%>
            <%--<div class="input-group-btn form-tool-searchbtn">--%>
                <%--<a id="assetsUstdtempapplyCollect_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"--%>
                   <%--role="button">高级查询 <span class="caret"></span></a>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--&lt;%&ndash;<table id="assetsUstdtempapplyCollect"></table>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<div id="assetsUstdtempapplyCollectPager"></div>&ndash;%&gt;--%>
<%--</div>--%>
</body>
<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">上报人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="author" name="author">
                        <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" name="authorAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">上报日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedateBegin"
                               id="releasedateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上报日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedateEnd" id="releasedateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上报单位:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="dept" name="dept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias" name="deptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">电话:</th>
                <td width="15%">
                    <input title="电话" class="form-control input-sm" type="text" name="tel" id="tel"/>
                </td>
                <th width="10%">关联征集单:</th>
                <td width="15%">
                    <input title="关联征集单" class="form-control input-sm" type="text" name="collectSelect"
                           id="collectSelect"/>
                </td>
                <th width="10%">年度:</th>
                <td width="15%">
                    <input title="年度" class="form-control input-sm" type="text" name="collectYear" id="collectYear"/>
                </td>
                <th width="10%">申购单号:</th>
                <td width="15%">
                    <input title="申购单号" class="form-control input-sm" type="text" name="stdId" id="stdId"/>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </form>
</div>
<!-- 子表高级查询 -->
<%--<div id="searchDialogSub" style="overflow: auto;display: none">--%>
    <%--<form id="formSub">--%>
        <%--<table class="form_commonTable">--%>
            <%--<tr>--%>
                <%--<th width="10%">申购单号:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="申购单号" class="form-control input-sm" type="text" name="stdId" id="stdId"/>--%>
                <%--</td>--%>
                <%--<th width="10%">申请人部门:</th>--%>
                <%--<td width="15%">--%>
                    <%--<div class="input-group  input-group-sm">--%>
                        <%--<input type="hidden" id="createdByDeptSub" name="createdByDept">--%>
                        <%--<input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAliasSub"--%>
                               <%--name="createdByDeptAlias">--%>
                        <%--<span class="input-group-addon">--%>
									        <%--<i class="glyphicon glyphicon-equalizer"></i>--%>
									      <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
                <%--<th width="10%">申请人电话:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="申请人电话" class="form-control input-sm" type="text" name="createdByTel"--%>
                           <%--id="createdByTel"/>--%>
                <%--</td>--%>
                <%--<th width="10%">单据状态:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%">设备名称:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>--%>
                <%--</td>--%>
                <%--<th width="10%">设备类别:</th>--%>
                <%--<td width="15%">--%>
                    <%--<pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory"--%>
                                  <%--title="设备类别" isNull="true" lookupCode="DEVICE_CATEGORY"/>--%>
                <%--</td>--%>
                <%--<th width="10%">承制单位:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="承制单位" class="form-control input-sm" type="text" name="manufactureUnit"--%>
                           <%--id="manufactureUnit"/>--%>
                <%--</td>--%>
                <%--<th width="10%">课题代号:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="课题代号" class="form-control input-sm" type="text" name="subjectCode" id="subjectCode"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%">主管机关:</th>--%>
                <%--<td width="15%">--%>
                    <%--<div class="input-group  input-group-sm">--%>
                        <%--<input type="hidden" id="competentAuthoritySub" name="competentAuthority">--%>
                        <%--<input class="form-control" placeholder="请选择部门" type="text" id="competentAuthorityAliasSub"--%>
                               <%--name="competentAuthorityAlias">--%>
                        <%--<span class="input-group-addon">--%>
									        <%--<i class="glyphicon glyphicon-equalizer"></i>--%>
									      <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
                <%--<th width="10%">型号主管:</th>--%>
                <%--<td width="15%">--%>
                    <%--<div class="input-group  input-group-sm">--%>
                        <%--<input type="hidden" id="modelDirectorSub" name="modelDirector">--%>
                        <%--<input class="form-control" placeholder="请选择用户" type="text" id="modelDirectorAliasSub"--%>
                               <%--name="modelDirectorAlias">--%>
                        <%--<span class="input-group-addon">--%>
										        <%--<i class="glyphicon glyphicon-user"></i>--%>
										      <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
                <%--<th width="10%">主管所领导:</th>--%>
                <%--<td width="15%">--%>
                    <%--<div class="input-group  input-group-sm">--%>
                        <%--<input type="hidden" id="competentLeaderSub" name="competentLeader">--%>
                        <%--<input class="form-control" placeholder="请选择用户" type="text" id="competentLeaderAliasSub"--%>
                               <%--name="competentLeaderAlias">--%>
                        <%--<span class="input-group-addon">--%>
										        <%--<i class="glyphicon glyphicon-user"></i>--%>
										      <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
                <%--<th width="10%">申购理由及用途:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="申购理由及用途" class="form-control input-sm" type="text" name="applyReasonPurpose"--%>
                           <%--id="applyReasonPurpose"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%">原有设备的情况:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="原有设备的情况" class="form-control input-sm" type="text" name="orignEquipSituation"--%>
                           <%--id="orignEquipSituation"/>--%>
                <%--</td>--%>
                <%--<th width="10%">使用效率情况:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="使用效率情况" class="form-control input-sm" type="text" name="efficiencySituation"--%>
                           <%--id="efficiencySituation"/>--%>
                <%--</td>--%>
                <%--<th width="10%">研制内容:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="研制内容" class="form-control input-sm" type="text" name="developmentContent"--%>
                           <%--id="developmentContent"/>--%>
                <%--</td>--%>
                <%--<th width="10%">技术指标:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="技术指标" class="form-control input-sm" type="text" name="technicalIndex"--%>
                           <%--id="technicalIndex"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%">研制周期:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="研制周期" class="form-control input-sm" type="text" name="developmentCycle"--%>
                           <%--id="developmentCycle"/>--%>
                <%--</td>--%>
                <%--<th width="10%">是否需要安装:</th>--%>
                <%--<td width="15%">--%>
                    <%--<pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall"--%>
                                  <%--title="是否需要安装" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>--%>
                <%--</td>--%>
                <%--<th width="10%">安装地点ID:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>--%>
                <%--</td>--%>
                <%--<th width="10%">使用电压:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="使用电压" class="form-control input-sm" type="text" name="serviceVoltage"--%>
                           <%--id="serviceVoltage"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%">是否对温湿度有要求:</th>--%>
                <%--<td width="15%">--%>
                    <%--<pt6:h5select css_class="form-control input-sm" name="isHumidityNeed" id="isHumidityNeed"--%>
                                  <%--title="是否对温湿度有要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>--%>
                <%--</td>--%>
                <%--<th width="10%">温湿度要求:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="温湿度要求" class="form-control input-sm" type="text" name="humidityNeed"--%>
                           <%--id="humidityNeed"/>--%>
                <%--</td>--%>
                <%--<th width="10%">是否有用水要求:</th>--%>
                <%--<td width="15%">--%>
                    <%--<pt6:h5select css_class="form-control input-sm" name="isWaterNeed" id="isWaterNeed" title="是否有用水要求"--%>
                                  <%--isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>--%>
                <%--</td>--%>
                <%--<th width="10%">用水要求:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="用水要求" class="form-control input-sm" type="text" name="waterNeed" id="waterNeed"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%">是否有用气要求:</th>--%>
                <%--<td width="15%">--%>
                    <%--<pt6:h5select css_class="form-control input-sm" name="isGasNeed" id="isGasNeed" title="是否有用气要求"--%>
                                  <%--isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>--%>
                <%--</td>--%>
                <%--<th width="10%">用气要求:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="用气要求" class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"/>--%>
                <%--</td>--%>
                <%--<th width="10%">是否有气体排放:</th>--%>
                <%--<td width="15%">--%>
                    <%--<pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title="是否有气体排放"--%>
                                  <%--isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>--%>
                <%--</td>--%>
                <%--<th width="10%">气体排放要求:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="气体排放要求" class="form-control input-sm" type="text" name="letNeed" id="letNeed"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%">是否有其他特殊要求:</th>--%>
                <%--<td width="15%">--%>
                    <%--<pt6:h5select css_class="form-control input-sm" name="isOtherNeed" id="isOtherNeed"--%>
                                  <%--title="是否有其他特殊要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>--%>
                <%--</td>--%>
                <%--<th width="10%">其他特殊要求:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="其他特殊要求" class="form-control input-sm" type="text" name="otherNeed" id="otherNeed"/>--%>
                <%--</td>--%>
                <%--<th width="10%">以上需求条件在拟安装地点是否都已具备:</th>--%>
                <%--<td width="15%">--%>
                    <%--<pt6:h5select css_class="form-control input-sm" name="isAboveConditions" id="isAboveConditions"--%>
                                  <%--title="以上需求条件在拟安装地点是否都已具备" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>--%>
                <%--</td>--%>
                <%--<th width="10%">是否计量:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="是否计量" class="form-control input-sm" type="text" name="isMetering" id="isMetering"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%">计量要求:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="计量要求" class="form-control input-sm" type="text" name="meteringRequirement"--%>
                           <%--id="meteringRequirement"/>--%>
                <%--</td>--%>
                <%--<th width="10%">经费概算:</th>--%>
                <%--<td width="15%">--%>
                    <%--<div class="input-group input-group-sm spinner" data-trigger="spinner">--%>
                        <%--<input class="form-control" type="text" name="financialEstimate" id="financialEstimate"--%>
                               <%--data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"--%>
                               <%--data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">--%>
                        <%--<span class="input-group-addon">--%>
												    <%--<a href="javascript:;" class="spin-up" data-spin="up"><i--%>
                                                            <%--class="glyphicon glyphicon-triangle-top"></i></a>--%>
												    <%--<a href="javascript:;" class="spin-down" data-spin="down"><i--%>
                                                            <%--class="glyphicon glyphicon-triangle-bottom"></i></a>--%>
												  <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
                <%--<th width="10%">经费来源:</th>--%>
                <%--<td width="15%">--%>
                    <%--<pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources"--%>
                                  <%--title="经费来源" isNull="true" lookupCode="FINANCIAL_RESOURCES"/>--%>
                <%--</td>--%>
                <%--<th width="10%">所属项目:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="所属项目" class="form-control input-sm" type="text" name="belongProject"--%>
                           <%--id="belongProject"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%">项目序号:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="项目序号" class="form-control input-sm" type="text" name="projectNo" id="projectNo"/>--%>
                <%--</td>--%>
                <%--<th width="10%">批复名称:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="批复名称" class="form-control input-sm" type="text" name="replyName" id="replyName"/>--%>
                <%--</td>--%>
                <%--<th width="10%">立项单号:</th>--%>
                <%--<td width="15%">--%>
                    <%--<input title="立项单号" class="form-control input-sm" type="text" name="approvalFormNumber"--%>
                           <%--id="approvalFormNumber"/>--%>
                <%--</td>--%>
                <%--<th width="10%">是否测试设备:</th>--%>
                <%--<td width="15%">--%>
                    <%--<pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title="是否测试设备"--%>
                                  <%--isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th width="10%">主管设备所领导:</th>--%>
                <%--<td width="15%">--%>
                    <%--<div class="input-group  input-group-sm">--%>
                        <%--<input type="hidden" id="competentDeviceLeaderSub" name="competentDeviceLeader">--%>
                        <%--<input class="form-control" placeholder="请选择用户" type="text" id="competentDeviceLeaderAliasSub"--%>
                               <%--name="competentDeviceLeaderAlias">--%>
                        <%--<span class="input-group-addon">--%>
										        <%--<i class="glyphicon glyphicon-user"></i>--%>
										      <%--</span>--%>
                    <%--</div>--%>
                <%--</td>--%>
            <%--</tr>--%>
        <%--</table>--%>
    <%--</form>--%>
<%--</div>--%>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script src="avicit/assets/device/assetsustdtempapplyctmain/js/AssetsUstdtempapplyCtMain.js"
        type="text/javascript"></script>
<script src="avicit/assets/device/assetsustdtempapplyctmain/js/AssetsUstdtempapplyCollect.js"
        type="text/javascript"></script>
<script type="text/javascript">
    var assetsUstdtempapplyCtMain;
    var assetsUstdtempapplyCollect;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsUstdtempapplyCtMain.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsUstdtempapplyCtMain.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsUstdtempapplyCtMain.reLoad();
    };

    $(document).ready(function () {
        var searchMainNames = new Array();
        var searchMainTips = new Array();
        searchMainNames.push("tel");
        searchMainTips.push("电话");
        searchMainNames.push("collectSelect");
        searchMainTips.push("关联征集单");
        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsUstdtempapplyCtMain_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#assetsUstdtempapplyCtMain_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);
        var searchSubNames = new Array();
        var searchSubTips = new Array();
        searchSubNames.push("stdId");
        searchSubTips.push("申购单号");
        searchSubNames.push("createdByTel");
        searchSubTips.push("申请人电话");
        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#assetsUstdtempapplyCollect_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#assetsUstdtempapplyCollect_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);
        var assetsUstdtempapplyCtMainGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '上报人', name: 'authorAlias', width: 150, formatter: formatValue}
            , {label: '上报日期', name: 'releasedate', width: 150, formatter: format}
            , {label: '上报单位', name: 'deptAlias', width: 150}
            , {label: '电话', name: 'tel', width: 150}
            , {label: '关联征集单', name: 'collectSelect', width: 150}
            , {label: '年度', name: 'collectYear', width: 150}
            , {label: '申购单号', name: 'stdId', width: 150}
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            , {label: '流程状态', name: 'businessstate_', width: 150}
        ];
        var assetsUstdtempapplyCollectGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '申购单号', name: 'stdId', width: 150}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            , {label: '单据状态', name: 'formState', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备类别', name: 'deviceCategoryName', width: 150}
            , {label: '承制单位', name: 'manufactureUnit', width: 150}
            , {label: '课题代号', name: 'subjectCode', width: 150}
            , {label: '主管机关', name: 'competentAuthorityAlias', width: 150}
            , {label: '型号主管', name: 'modelDirectorAlias', width: 150}
            , {label: '主管所领导', name: 'competentLeaderAlias', width: 150}
            , {label: '申购理由及用途', name: 'applyReasonPurpose', width: 150}
            , {label: '原有设备的情况', name: 'orignEquipSituation', width: 150}
            , {label: '使用效率情况', name: 'efficiencySituation', width: 150}
            , {label: '研制内容', name: 'developmentContent', width: 150}
            , {label: '技术指标', name: 'technicalIndex', width: 150}
            , {label: '研制周期', name: 'developmentCycle', width: 150}
            , {label: '是否需要安装', name: 'isNeedInstallName', width: 150}
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {label: '使用电压', name: 'serviceVoltage', width: 150}
            , {label: '是否对温湿度有要求', name: 'isHumidityNeedName', width: 150}
            , {label: '温湿度要求', name: 'humidityNeed', width: 150}
            , {label: '是否有用水要求', name: 'isWaterNeedName', width: 150}
            , {label: '用水要求', name: 'waterNeed', width: 150}
            , {label: '是否有用气要求', name: 'isGasNeedName', width: 150}
            , {label: '用气要求', name: 'gasNeed', width: 150}
            , {label: '是否有气体排放', name: 'isLetName', width: 150}
            , {label: '气体排放要求', name: 'letNeed', width: 150}
            , {label: '是否有其他特殊要求', name: 'isOtherNeedName', width: 150}
            , {label: '其他特殊要求', name: 'otherNeed', width: 150}
            , {label: '以上需求条件在拟安装地点是否都已具备', name: 'isAboveConditionsName', width: 150}
            , {label: '是否计量', name: 'isMetering', width: 150}
            , {label: '计量要求', name: 'meteringRequirement', width: 150}
            , {label: '经费概算', name: 'financialEstimate', width: 150}
            , {label: '经费来源', name: 'financialResourcesName', width: 150}
            , {label: '所属项目', name: 'belongProject', width: 150}
            , {label: '项目序号', name: 'projectNo', width: 150}
            , {label: '批复名称', name: 'replyName', width: 150}
            , {label: '立项单号', name: 'approvalFormNumber', width: 150}
            , {label: '是否测试设备', name: 'isTestDeviceName', width: 150}
            , {label: '主管设备所领导', name: 'competentDeviceLeaderAlias', width: 150}
        ];

        assetsUstdtempapplyCtMain = new AssetsUstdtempapplyCtMain('assetsUstdtempapplyCtMain', '${url}', 'form', assetsUstdtempapplyCtMainGridColModel, 'searchDialog',
            function (pid) {
                assetsUstdtempapplyCollect = new AssetsUstdtempapplyCollect('assetsUstdtempapplyCollect', '${surl}', "formSub", assetsUstdtempapplyCollectGridColModel, 'searchDialogSub', pid, searchSubNames, "assetsUstdtempapplyCollect_keyWord");
            },
            function (pid) {
                assetsUstdtempapplyCollect.reLoad(pid);
            },
            searchMainNames,
            "assetsUstdtempapplyCtMain_keyWord");
        //主表操作
        //添加按钮绑定事件
        $('#assetsUstdtempapplyCtMain_insert').bind('click', function () {
            assetsUstdtempapplyCtMain.insert();
        });
        //编辑按钮绑定事件
        $('#assetsUstdtempapplyCtMain_modify').bind('click', function () {
            assetsUstdtempapplyCtMain.modify();
        });
        //删除按钮绑定事件
        $('#assetsUstdtempapplyCtMain_del').bind('click', function () {
            assetsUstdtempapplyCtMain.del();
        });
        //打开高级查询框
        $('#assetsUstdtempapplyCtMain_searchAll').bind('click', function () {
            assetsUstdtempapplyCtMain.openSearchForm(this, $('#assetsUstdtempapplyCtMain'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsUstdtempapplyCtMain_searchPart').bind('click', function () {
            assetsUstdtempapplyCtMain.searchByKeyWord();
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsUstdtempapplyCtMain.initWorkFlow($(this).val());
        });
        //子表操作
        //打开高级查询
        $('#assetsUstdtempapplyCollect_searchAll').bind('click', function () {
            assetsUstdtempapplyCollect.openSearchForm(this, $('#assetsUstdtempapplyCollect'));
        });
        //关键字段查询按钮绑定事件
        $('#assetsUstdtempapplyCollect_searchPart').bind('click', function () {
            assetsUstdtempapplyCollect.searchByKeyWord();
        });

        $('#authorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'author', textFiled: 'authorAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'dept', textFiled: 'deptAlias'});
            this.blur();
            nullInput(e);
        });

        $('#createdByDeptAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDeptSub', textFiled: 'createdByDeptAliasSub'});
            this.blur();
            nullInput(e);
        });
        $('#competentAuthorityAliasSub').on('focus', function (e) {
            new H5CommonSelect({
                type: 'deptSelect',
                idFiled: 'competentAuthoritySub',
                textFiled: 'competentAuthorityAliasSub'
            });
            this.blur();
            nullInput(e);
        });
        $('#modelDirectorAliasSub').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'modelDirectorSub', textFiled: 'modelDirectorAliasSub'});
            this.blur();
            nullInput(e);
        });

        $('#competentLeaderAliasSub').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'competentLeaderSub',
                textFiled: 'competentLeaderAliasSub'
            });
            this.blur();
            nullInput(e);
        });

        $('#competentDeviceLeaderAliasSub').on('focus', function (e) {
            new H5CommonSelect({
                type: 'userSelect',
                idFiled: 'competentDeviceLeaderSub',
                textFiled: 'competentDeviceLeaderAliasSub'
            });
            this.blur();
            nullInput(e);
        });


    });

</script>
</html>