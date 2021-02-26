<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>

<%
    String importlibs = "common,form,table,fileupload,tree";
    String formId = request.getParameter("id");
%>

<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsustdregisterproc/assetsUstdregisterProcController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>

    <%
        String userId = SessionHelper.getLoginSysUserId(request);
        SysUser user = SessionHelper.getLoginSysUser(request);
        String userName = user.getName();
        String userDeptId = SessionHelper.getCurrentDeptId(request);
        String userDeptName = SessionHelper.getCurrentDeptName(request);
    %>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

    <!-- 框架 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmbusiness/include2/common/css/style.css">

    <!-- 切换卡 样式 -->
    <link href="avicit/platform6/switch_card/yyui.css" rel="stylesheet" type="text/css">
</head>

<body>
<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include2/buttons.jsp" %>

<div id="formTab" style="display: none">
    <!-- 业务表单 Start -->
    <form id='form'>
        <input type="hidden" name="id" id="id"/>
        <input type="hidden" name="version" id="version"/>

        <div class="yyui_tab">
            <ul style="text-align:left;">
                <li class="yyui_tab_title_this" style="margin-left:10px;">基础信息</li>
            </ul>
            <div class="yyui_tab_content_this">
                <table class="form_commonTable">
                    <tr>
                        <th width="10%">
                            <label for="registerNo">立项编号:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" placeholder="系统自动生成" name="registerNo"
                                   id="registerNo" readonly/>
                        </td>

                        <th width="10%">
                            <label for="createdByAlias">申请人:</label></th>
                        <td width="15%">
                            <input type="hidden" id="createdBy" name="createdBy" value="<%=userId%>" readonly>
                            <input class="form-control" placeholder="请选择用户" type="text" id="createdByAlias"
                                   name="createdByAlias" value="<%=userName%>" readonly>
                        </td>

                        <th width="10%">
                            <label for="createdByDeptAlias">申请人部门:</label></th>
                        <td width="15%">
                            <input type="hidden" id="createdByDept" name="createdByDept" value="<%=userDeptId%>">
                            <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                                   name="createdByDeptAlias" value="<%=userDeptName%>" readonly>
                        </td>

                        <th width="10%">
                            <label for="createdByTel">申请人电话:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"
                                   value="<%=user.getMobile()%>"/>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="deviceName">设备名称:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                        </td>

                        <th width="10%">
                            <label for="deviceCategory">设备类别:</label></th>
                        <td width="15%">
							<input type="hidden" id="deviceCategory" name="deviceCategory">
							<input class="form-control input-sm" placeholder="请选择设备类别" type="text" name="deviceCategoryNames" id="deviceCategoryNames" readonly/>
                        </td>

                        <th width="10%">
                            <label for="techInchargeAlias">技术负责人:</label></th>
                        <td width="15%">
                            <div class="input-group  input-group-sm">
                                <input type="hidden" id="techIncharge" name="techIncharge">
                                <input class="form-control" placeholder="请选择用户" type="text" id="techInchargeAlias"
                                       name="techInchargeAlias">
                                <span class="input-group-addon">
										<i class="glyphicon glyphicon-user"></i>
									</span>
                            </div>
                        </td>

                        <th width="10%">
                            <label for="projectDirectorAlias">项目主管:</label></th>
                        <td width="15%">
                            <div class="input-group  input-group-sm">
                                <input type="hidden" id="projectDirector" name="projectDirector">
                                <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias"
                                       name="projectDirectorAlias">
                                <span class="input-group-addon">
										<i class="glyphicon glyphicon-user"></i>
									</span>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="singleOrSet">台/套:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="singleOrSet" id="singleOrSet" title=""
                                          isNull="true" lookupCode="SINGLE_OR_SET"/>
                        </td>

                        <th width="10%">
                            <label for="setCount">台(套)数:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="setCount" id="setCount"
                                       onchange="calculateEstimate()" data-min="1"
                                       data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">

                                <span class="input-group-addon" id="changeSetCount">
										<a href="javascript:;" class="spin-up" data-spin="up"><i
                                                class="glyphicon glyphicon-triangle-top"></i></a>
										<a href="javascript:;" class="spin-down" data-spin="down"><i
                                                class="glyphicon glyphicon-triangle-bottom"></i></a>
									</span>
                            </div>
                        </td>

                        <th width="10%">
                            <label for="budgetPrice">预算单价:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="budgetPrice" id="budgetPrice"
                                       onchange="calculateEstimate()" data-min="0.001"
                                       data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">

                                <span class="input-group-addon">
										<a href="javascript:;" class="spin-up" data-spin="up"><i
                                                class="glyphicon glyphicon-triangle-top"
                                                onclick="calculateEstimate()"></i></a>
										<a href="javascript:;" class="spin-down" data-spin="down"><i
                                                class="glyphicon glyphicon-triangle-bottom"
                                                onclick="calculateEstimate()"></i></a>
									</span>
                            </div>
                        </td>

                        <th width="10%">
                            <label for="financialEstimate">经费概算:</label></th>
                        <td width="15%">
                            <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                <input class="form-control" type="text" name="financialEstimate" id="financialEstimate"
                                       readonly>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="financialResources">经费来源:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="financialResources"
                                          id="financialResources" title="" isNull="true"
                                          lookupCode="FINANCIAL_RESOURCES"/>
                        </td>

                        <th width="10%">
                            <label for="belongProject">所属项目:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="belongProject" id="belongProject"
                                   readonly onclick="relateTechTransformProject()"/>
                        </td>

                        <th width="10%">
                            <label for="projectNo">项目序号:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="projectNo" id="projectNo" readonly
                                   onclick="relateTechTransformProject()"/>
                        </td>

                        <th width="10%">
                            <label for="installPosition">安装地点:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="installPosition"
                                   id="installPosition"/>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="simpleOrLarge">简易/大型设备:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="simpleOrLarge" id="simpleOrLarge"
                                          title="" isNull="true" lookupCode="SIMPLE_LARGE_SCALE"/>
                        </td>
                    </tr>

                    <tr>
                        <th><label for="attachment">附件</label></th>
                        <td colspan="<%=4 * 2 - 1%>">
                            <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="yyui_tab" id="largeFieldRegion" style="margin-top:30px; display:none;">
            <ul style="text-align:left;">
                <li class="yyui_tab_title_this" style="margin-left:10px;">大型设备要求</li>
            </ul>
            <div class="yyui_tab_content_this">
                <table class="form_commonTable" style="margin-left:2%;">
                    <tr>
                        <th width="10%">
                            <label for="isSatisfyBearing">安装设备楼层承重能否满足:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="isSatisfyBearing"
                                          id="isSatisfyBearing" title="" isNull="true"
                                          lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <th width="10%">
                            <label for="hasFoundation">所安装位置是否具备设置地基条件:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="hasFoundation" id="hasFoundation"
                                          title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <th width="10%">
                            <label for="hasOutdoorUnit">设备是否有室外机:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="hasOutdoorUnit" id="hasOutdoorUnit"
                                          title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <th width="10%">
                            <label for="isAllowOutdoorunit">所安装位置是否允许安装室外机:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="isAllowOutdoorunit"
                                          id="isAllowOutdoorunit" title="" isNull="true"
                                          lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="useVoltage">使用电压:</label></th>
                        <td width="15%">
                            <input class="form-control input-sm" type="text" name="useVoltage" id="useVoltage"/>
                        </td>

                        <th width="10%">
                            <label for="hasVoltageCondition">安装位置是否具备电压条件:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="hasVoltageCondition"
                                          id="hasVoltageCondition" title="" isNull="true"
                                          lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="hasHumidityNeed">是否有温湿度要求:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="hasHumidityNeed" id="hasHumidityNeed"
                                          title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <th width="10%">
                            <label for="humidityNeed">温湿度要求:</label></th>
                        <td width="65%" colspan="5">
                            <textarea class="form-control input-sm" rows="3" name="humidityNeed"
                                      id="humidityNeed"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="hasCleanlinessNeed">是否有洁净度要求:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="hasCleanlinessNeed"
                                          id="hasCleanlinessNeed" title="" isNull="true"
                                          lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <th width="10%">
                            <label for="cleanlinessNeed">净度要求:</label></th>
                        <td width="65%" colspan="5">
                            <textarea class="form-control input-sm" rows="3" name="cleanlinessNeed"
                                      id="cleanlinessNeed"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="hasWaterNeed">是否有用水要求:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="hasWaterNeed" id="hasWaterNeed"
                                          title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <th width="10%">
                            <label for="waterNeed">用水要求:</label></th>
                        <td width="65%" colspan="5">
                            <textarea class="form-control input-sm" rows="3" name="waterNeed" id="waterNeed"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="hasGasNeed">是否有用气要求:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="hasGasNeed" id="hasGasNeed" title=""
                                          isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <th width="10%">
                            <label for="gasNeed">用气要求:</label></th>
                        <td width="65%" colspan="5">
                            <textarea class="form-control input-sm" rows="3" name="gasNeed" id="gasNeed"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="hasLetNeed">是否有气体排放要求:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="hasLetNeed" id="hasLetNeed" title=""
                                          isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <th width="10%">
                            <label for="letNeed">气体排放要求:</label></th>
                        <td width="65%" colspan="5">
                            <textarea class="form-control input-sm" rows="3" name="letNeed" id="letNeed"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="hasOtherNeed">是否有其他特殊要求:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="hasOtherNeed" id="hasOtherNeed"
                                          title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <th width="10%">
                            <label for="otherNeed">其他特殊要求:</label></th>
                        <td width="65%" colspan="5">
                            <textarea class="form-control input-sm" rows="3" name="otherNeed" id="otherNeed"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <th width="10%">
                            <label for="hasAboveConditions">以上需求条件在拟安装地点是否都已具备:</label></th>
                        <td width="15%">
                            <pt6:h5select css_class="form-control input-sm" name="hasAboveConditions"
                                          id="hasAboveConditions" title="" isNull="true"
                                          lookupCode="PLATFORM_YES_NO_FLAG"/>
                        </td>

                        <th width="10%">
                            <label for="supplementaryNotes">条件不具备补充说明:</label></th>
                        <td width="65%" colspan="5">
                            <textarea class="form-control input-sm" rows="3" name="supplementaryNotes"
                                      id="supplementaryNotes"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
    <!-- 业务表单 End -->
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<!-- 框架脚本 -->
<script type="text/javascript"
        src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/jquery.dragsort-0.5.2.min.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/nav.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/main.js"></script>

<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/CommonActor.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/BpmActor.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/FlowEditor.js"></script>

<!-- 业务的js -->
<script type="text/javascript"
        src="avicit/assets/device/assetsustdregisterproc/js/AssetsUstdregisterProcDetail.js"></script>
<script type="text/javascript" src="static/js/platform/eform/common.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsustdregisterproc/js/SelfStyleLayout.js"></script>

<!-- 切换卡的js -->
<script src="avicit/platform6/switch_card/yyui.js"></script>

<!-- 自动编码的js -->
<script src="avicit/platform6/autocode/js/AutoCode.js"></script>

<script type="text/javascript">
    var procDetail;

    //注册附件上传完毕后执行的方法
    var afterUploadEvent = null;

    //监控单价和数量输入框的变化
    function calculateEstimate() {
        var budgetPrice = document.getElementById('budgetPrice').value;
        var setCount = document.getElementById('setCount').value;

        if (((budgetPrice != null) && (budgetPrice != undefined) && (budgetPrice != "")) && ((setCount != null) && (setCount != undefined) && (setCount != ""))) {
            document.getElementById('financialEstimate').value = budgetPrice * setCount;
        }
    }

    //监控单价、数量调整按钮的点击事件
    $("body").on("click", ".input-group-addon", function () {
        calculateEstimate();
    });

    //监控“经费来源”取值变化
    $("#financialResources").change(function () {
        var selected = $(this).children('option:selected').val();

        //技改项目
        if (selected == 1) {
            procDetail.toRelateTechTransformProject();
        }
        //非技改项目
        else {
            $('#replyName').val('');//清空取值
            $('#belongProject').val('');//清空取值
            $('#projectNo').val('');//清空取值
        }
    });

    function relateTechTransformProject() {
        var selected = $('#financialResources').children('option:selected').val();

        //技改项目
        if (selected == 1) {
            procDetail.toRelateTechTransformProject();
        }
    }

    //监控“简易/大型设备”字段的取值变化情况
    $("#simpleOrLarge").change(function () {
        var selected = $(this).children('option:selected').val();

        //大型设备
        if (selected == 1) {
            $("#largeFieldRegion").css('display', 'block');  //显示大型设备字段区域

            /*设置字段必填——开始*/
            $('#isSatisfyBearing').attr('required', true);    //安装设备楼层承重能否满足
            $('#hasFoundation').attr('required', true); 	  //所安装位置是否具备设置地基条件
            $('#hasOutdoorUnit').attr('required', true); 	  //设备是否有室外机

            $('#hasVoltageCondition').attr('required', true);    //安装位置是否具备电压条件
            $('#hasHumidityNeed').attr('required', true);     	 //是否有温湿度要求
            $('#hasCleanlinessNeed').attr('required', true);     //是否有洁净度要求

            $('#hasWaterNeed').attr('required', true);  //是否有用水要求
            $('#hasGasNeed').attr('required', true);    //是否有用气要求
            $('#hasLetNeed').attr('required', true); 	//是否有气体排放要求

            $('#hasOtherNeed').attr('required', true);          //是否有其他特殊要求
            $('#hasAboveConditions').attr('required', true); 	//以上需求条件在拟安装地点是否都已具备
            /*设置字段必填——结束*/
        }
        //非大型设备
        else {
            $("#largeFieldRegion").css('display', 'none');	//隐藏大型设备字段区域

            /*取消字段必填——开始*/
            $('#isSatisfyBearing').attr('required', false);    //安装设备楼层承重能否满足
            $('#hasFoundation').attr('required', false); 	  //所安装位置是否具备设置地基条件
            $('#hasOutdoorUnit').attr('required', false); 	  //设备是否有室外机

            $('#hasVoltageCondition').attr('required', false);    //安装位置是否具备电压条件
            $('#hasHumidityNeed').attr('required', false);     	 //是否有温湿度要求
            $('#hasCleanlinessNeed').attr('required', false);     //是否有洁净度要求

            $('#hasWaterNeed').attr('required', false);  //是否有用水要求
            $('#hasGasNeed').attr('required', false);    //是否有用气要求
            $('#hasLetNeed').attr('required', false); 	//是否有气体排放要求

            $('#hasOtherNeed').attr('required', true);          //是否有其他特殊要求
            $('#hasAboveConditions').attr('required', false); 	//以上需求条件在拟安装地点是否都已具备
            /*取消字段必填——结束*/
        }
    });

    //监控“设备是否有室外机”字段的取值变化情况
    $("#hasOutdoorUnit").change(function () {
        var selected = $(this).children('option:selected').val();

        //有要求
        if (selected == 'Y') {
            $('#isAllowOutdoorunit').attr('required', true);  //“所安装位置是否允许安装室外机”必填
        }
        //无要求
        else {
            $('#isAllowOutdoorunit').attr('required', false);  //“所安装位置是否允许安装室外机”取消必填
        }
    });

    //监控“是否有温湿度要求”字段的取值变化情况
    $("#hasHumidityNeed").change(function () {
        var selected = $(this).children('option:selected').val();

        //有要求
        if (selected == 'Y') {
            $('#humidityNeed').attr('required', true);  //“温湿度要求”必填
        }
        //无要求
        else {
            $('#humidityNeed').attr('required', false);  //“温湿度要求”取消必填
        }
    });

    //监控“是否有洁净度要求”字段的取值变化情况
    $("#hasCleanlinessNeed").change(function () {
        var selected = $(this).children('option:selected').val();

        //有要求
        if (selected == 'Y') {
            $('#cleanlinessNeed').attr('required', true);  //“洁净度要求”必填
        }
        //无要求
        else {
            $('#cleanlinessNeed').attr('required', false);  //“洁净度要求”取消必填
        }
    });

    //监控“是否有用水要求”字段的取值变化情况
    $("#hasWaterNeed").change(function () {
        var selected = $(this).children('option:selected').val();

        //有要求
        if (selected == 'Y') {
            $('#waterNeed').attr('required', true);  //“用水要求”必填
        }
        //无要求
        else {
            $('#waterNeed').attr('required', false);  //“用水要求”取消必填
        }
    });

    //监控“是否有用气要求”字段的取值变化情况
    $("#hasGasNeed").change(function () {
        var selected = $(this).children('option:selected').val();

        //有要求
        if (selected == 'Y') {
            $('#gasNeed').attr('required', true);  //“用气要求”必填
        }
        //无要求
        else {
            $('#gasNeed').attr('required', false);  //“用气要求”取消必填
        }
    });

    //监控“是否有气体排放要求”字段的取值变化情况
    $("#hasLetNeed").change(function () {
        var selected = $(this).children('option:selected').val();

        //有要求
        if (selected == 'Y') {
            $('#letNeed').attr('required', true);  //“气体排放要求”必填
        }
        //无要求
        else {
            $('#letNeed').attr('required', false);  //“气体排放要求”取消必填
        }
    });

    //监控“是否有其他特殊要求”字段的取值变化情况
    $("#hasOtherNeed").change(function () {
        var selected = $(this).children('option:selected').val();

        //有要求
        if (selected == 'Y') {
            $('#otherNeed').attr('required', true);  //“其他特殊要求”必填
        }
        //无要求
        else {
            $('#otherNeed').attr('required', false);  //“其他特殊要求”取消必填
        }
    });

    //监控“以上需求条件在拟安装地点是否都已具备”字段的取值变化情况
    $("#hasAboveConditions").change(function () {
        var selected = $(this).children('option:selected').val();

        //有要求
        if (selected == 'Y') {
            $('#supplementaryNotes').attr('required', true);  //“条件不具备补充说明”必填
        }
        //无要求
        else {
            $('#supplementaryNotes').attr('required', false);  //“条件不具备补充说明”取消必填
        }
    });

    $(document).ready(function () {
        //自动生成非标立项编号
        var autoCode = new AutoCode("ASSETS_USTDREGISTER_PROC", "registerNo", false, "autoCodeValue", "123");

        //创建业务操作JS
        var assetsUstdregisterProcDetail = new AssetsUstdregisterProcDetail('form');

        //创建流程操作JS
        new FlowEditor(assetsUstdregisterProcDetail);

        procDetail = assetsUstdregisterProcDetail;

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

        $('#attachment').uploaderExt({
            formId: '<%=formId%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });//初始化附件上传组件

        assetsUstdregisterProcDetail.formValidate($('#form'));//绑定表单验证规则

        $('#techInchargeAlias').on('focus', function (e) {	//技术负责人绑定事件
            new H5CommonSelect({type: 'userSelect', idFiled: 'techIncharge', textFiled: 'techInchargeAlias'});
            this.blur();
            nullInput(e);
        });

        $('#projectDirectorAlias').on('focus', function (e) {	//项目主管绑定事件
            new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
            this.blur();
            nullInput(e);
        });

		$('#deviceCategoryNames').on('focus', function (e) {	//设备分类绑定事件
			//获取当前已选中的分类
			var defaultLoadCategoryId = $('#deviceCategory').val();

			new H5CommonSelect({type: 'categorySelect', idFiled: 'deviceCategory', textFiled: 'deviceCategoryNames', currentCategory: 'NationalStandard', defaultLoadCategoryId: defaultLoadCategoryId});
			this.blur();
			nullInput(e);
		});

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });

    window.onload = function (ev) {
        if ($("#financialResources").val() == '1') {
            $("#largeFieldRegion").css('display', 'block');  //显示大型设备字段区域
        }
    }
</script>
</body>
</html>