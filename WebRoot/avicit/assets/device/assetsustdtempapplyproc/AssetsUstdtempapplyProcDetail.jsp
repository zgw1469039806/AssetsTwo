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

<!DOCTYPE HTML>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsustdtempapplyproc/assetsUstdtempapplyProcController/operation/toDetailJsp" -->
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
    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include2/buttons.jsp"%>

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
                                <label for="subscribeNo">申购单号:</label></th>
                            <td width="15%">
                                <input class="form-control input-sm" type="text" name="subscribeNo" id="subscribeNo" placeholder="系统自动生成" readonly/>
                            </td>

                            <th width="10%">
                                <label for="applyByAlias">申请人:</label></th>
                            <td width="15%">
                                <div class="input-group  input-group-sm">
                                    <input type="hidden" id="applyBy" name="applyBy" value="<%=userId%>" readonly>
                                    <input class="form-control" placeholder="请选择用户" type="text" id="applyByAlias" name="applyByAlias" value="<%=userName%>">
                                    <span class="input-group-addon">
                                        <i class="glyphicon glyphicon-user"></i>
                                    </span>
                                </div>
                            </td>

                            <th width="10%">
                                <label for="applyByDeptAlias">申请人部门:</label></th>
                            <td width="15%">
                                <div class="input-group  input-group-sm">
                                    <input type="hidden" id="applyByDept" name="applyByDept" value="<%=userDeptId%>" readonly>
                                    <input type="hidden" id="createdByDept" name="createdByDept" value="<%=userDeptId%>" readonly>
                                    <input class="form-control" placeholder="请选择部门" type="text" id="applyByDeptAlias" name="applyByDeptAlias" value="<%=userDeptName%>" readonly>
                                    <span class="input-group-addon">
                                        <i class="glyphicon glyphicon-equalizer"></i>
                                    </span>
                                </div>
                            </td>

                            <th width="10%">
                                <label for="deviceName">设备名称:</label></th>
                            <td width="15%">
                                <input class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="deviceCategoryNames">设备类别:</label></th>
                            <td width="15%">
                                <input type="hidden" id="deviceCategory" name="deviceCategory">
                                <input class="form-control input-sm" placeholder="请选择设备类别" type="text" name="deviceCategoryNames" id="deviceCategoryNames" readonly/>
                            </td>

                            <th width="10%">
                                <label for="isHumidityNeed">是否测试设备:</label></th>
                            <td width="15%">
                                <pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG" />
                            </td>

                            <th width="10%">
                                <label for="manufactureUnit">承制单位:</label></th>
                            <td width="15%">
                                <input class="form-control input-sm" type="text" name="manufactureUnit" id="manufactureUnit"/>
                            </td>

                            <th width="10%">
                                <label for="subjectCode">课题代号:</label></th>
                            <td width="15%">
                                <input class="form-control input-sm" type="text" name="subjectCode" id="subjectCode"/>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="competentAuthorityAlias">主管机关:</label></th>
                            <td width="15%">
                                <div class="input-group  input-group-sm">
                                    <input type="hidden" id="competentAuthority" name="competentAuthority">
                                    <input class="form-control" placeholder="请选择部门" type="text" id="competentAuthorityAlias" name="competentAuthorityAlias">
                                    <span class="input-group-addon">
                                        <i class="glyphicon glyphicon-equalizer"></i>
                                    </span>
                                </div>
                            </td>

                            <th width="10%">
                                <label for="modelDirectorAlias">型号主管:</label></th>
                            <td width="15%">
                                <div class="input-group  input-group-sm">
                                    <input type="hidden" id="modelDirector" name="modelDirector">
                                    <input class="form-control" placeholder="请选择用户" type="text" id="modelDirectorAlias" name="modelDirectorAlias">
                                    <span class="input-group-addon">
                                        <i class="glyphicon glyphicon-user"></i>
                                    </span>
                                </div>
                            </td>

                            <th width="10%">
                                <label for="competentLeaderAlias">主管所领导:</label></th>
                            <td width="15%">
                                <div class="input-group  input-group-sm">
                                    <input type="hidden" id="competentLeader" name="competentLeader">
                                    <input class="form-control" placeholder="请选择用户" type="text" id="competentLeaderAlias" name="competentLeaderAlias">
                                    <span class="input-group-addon">
                                        <i class="glyphicon glyphicon-user"></i>
                                    </span>
                                </div>
                            </td>

                            <th width="10%">
                                <label for="financialEstimate">经费概算:</label></th>
                            <td width="15%">
                                <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                    <input class="form-control" type="text" name="financialEstimate" id="financialEstimate" data-min="0.001" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                                    <span class="input-group-addon">
                                        <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
                                        <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
                                    </span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="financialResources">经费来源:</label></th>
                            <td width="15%">
                                <pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources" title="" isNull="true" lookupCode="FINANCIAL_RESOURCES"/>
                            </td>

                            <th width="10%">
                                <label for="replyName">批复名称:</label></th>
                            <td width="15%">
                                <input class="form-control input-sm" type="text" name="replyName" id="replyName" onclick="relateTechTransformProject()"/>
                            </td>

                            <th width="10%">
                                <label for="belongProject">所属项目:</label></th>
                            <td width="15%">
                                <input class="form-control input-sm" type="text" name="belongProject" id="belongProject" onclick="relateTechTransformProject()"/>
                            </td>

                            <th width="10%">
                                <label for="projectNo">项目序号:</label></th>
                            <td width="15%">
                                <input class="form-control input-sm" type="text" name="projectNo" id="projectNo" onclick="relateTechTransformProject()"/>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="approvalFormNumber">立项单号:</label></th>
                            <td width="15%">
                                <input class="form-control input-sm" type="text" name="approvalFormNumber" id="approvalFormNumber"/>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="applyReasonPurpose">申购理由及用途:</label></th>
                            <td width="90%" colspan="7">
                                <textarea class="form-control input-sm" rows="3" name="applyReasonPurpose" id="applyReasonPurpose"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="orignEquipSituation">原有设备的情况:</label></th>
                            <td width="90%" colspan="7">
                                <textarea class="form-control input-sm" rows="3" name="orignEquipSituation" id="orignEquipSituation"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="efficiencySituation">使用效率情况:</label></th>
                            <td width="90%" colspan="7">
                                <textarea class="form-control input-sm" rows="3" name="efficiencySituation" id="efficiencySituation"></textarea>
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

            <div class="yyui_tab" style="margin-top: 30px;">
                <ul style="text-align:left;">
                    <li class="yyui_tab_title_this" style="margin-left:10px;">技术要求</li>
                    <li class="yyui_tab_title">安装要求</li>
                    <li class="yyui_tab_title">计量要求</li>
                </ul>
                <div class="yyui_tab_content_this">
                    <table class="form_commonTable" style="margin-left:2%;">
                        <tr>
                            <th width="10%">
                                <label for="developmentContent">研制内容:</label></th>
                            <td width="90%">
                                <textarea class="form-control input-sm" rows="3"   name="developmentContent" id="developmentContent"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="technicalIndex">技术指标:</label></th>
                            <td width="90%">
                                <textarea class="form-control input-sm" rows="3"   name="technicalIndex" id="technicalIndex"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="developmentCycle">研制周期:</label></th>
                            <td width="90%">
                                <textarea class="form-control input-sm" rows="3"   name="developmentCycle" id="developmentCycle"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="yyui_tab_content">
                    <table class="form_commonTable" style="margin-left: 2%;">
                        <tr>
                            <th width="10%">
                                <label for="isNeedInstall">是否需要安装:</label></th>
                            <td width="15%">
                                <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                            </td>

                            <th width="10%">
                                <label for="positionId">安装地点ID:</label></th>
                            <td width="15%">
                                <input class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                            </td>

                            <th width="10%">
                                <label for="serviceVoltage">使用电压:</label></th>
                            <td width="15%">
                                <input class="form-control input-sm" type="text" name="serviceVoltage" id="serviceVoltage"/>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="isHumidityNeed">是否对温湿度有要求:</label></th>
                            <td width="15%">
                                <pt6:h5select css_class="form-control input-sm" name="isHumidityNeed" id="isHumidityNeed" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                            </td>

                            <th width="10%">
                                <label for="humidityNeed">温湿度要求:</label></th>
                            <td width="65%" colspan="3">
                                <textarea class="form-control input-sm" rows="3" name="humidityNeed" id="humidityNeed"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="isWaterNeed">是否有用水要求:</label></th>
                            <td width="15%">
                                <pt6:h5select css_class="form-control input-sm" name="isWaterNeed" id="isWaterNeed" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                            </td>

                            <th width="10%">
                                <label for="waterNeed">用水要求:</label></th>
                            <td width="65%" colspan="3">
                                <textarea class="form-control input-sm" rows="3" name="waterNeed" id="waterNeed"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="isGasNeed">是否有用气要求:</label></th>
                            <td width="15%">
                                <pt6:h5select css_class="form-control input-sm" name="isGasNeed" id="isGasNeed" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                            </td>

                            <th width="10%">
                                <label for="gasNeed">用气要求:</label></th>
                            <td width="65%" colspan="3">
                                <textarea class="form-control input-sm" rows="3" name="gasNeed" id="gasNeed"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="isLet">是否有气体排放:</label></th>
                            <td width="15%">
                                <pt6:h5select css_class="form-control input-sm" name="isLet" id="isLet" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                            </td>

                            <th width="10%">
                                <label for="letNeed">气体排放要求:</label></th>
                            <td width="65%" colspan="3">
                                <textarea class="form-control input-sm" rows="3" name="letNeed" id="letNeed"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="isOtherNeed">是否有其他特殊要求:</label></th>
                            <td width="15%">
                                <pt6:h5select css_class="form-control input-sm" name="isOtherNeed" id="isOtherNeed" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                            </td>

                            <th width="10%">
                                <label for="otherNeed">其他特殊要求:</label></th>
                            <td width="65%" colspan="6">
                                <textarea class="form-control input-sm" rows="3" name="otherNeed" id="otherNeed"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <label for="isAboveConditions">以上需求条件在拟安装地点是否都已具备:</label></th>
                            <td width="15%">
                                <pt6:h5select css_class="form-control input-sm" name="isAboveConditions" id="isAboveConditions" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="yyui_tab_content">
                    <table class="form_commonTable" style="margin-left: 2%;">
                        <tr>
                            <th width="10%">
                                <label for="isMetering">是否计量:</label></th>
                            <td width="15%">
                                <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                            </td>

                            <th width="10%">
                                <label for="meteringRequirement">计量要求:</label></th>
                            <td width="65%">
                                <textarea class="form-control input-sm" rows="3" name="meteringRequirement" id="meteringRequirement"></textarea>
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
    <script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/jquery.dragsort-0.5.2.min.js"></script>
    <script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/nav.js"></script>
    <script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/main.js"></script>

    <!-- 流程的js -->
    <script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
    <script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/CommonActor.js"></script>
    <script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/BpmActor.js"></script>
    <script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/FlowEditor.js"></script>

    <!-- 业务的js -->
    <script type="text/javascript" src="avicit/assets/device/assetsustdtempapplyproc/js/AssetsUstdtempapplyProcDetail.js"></script>
    <script type="text/javascript" src="static/js/platform/eform/common.js"></script>
    <script type="text/javascript" src="avicit/assets/device/assetsustdtempapplyproc/js/SelfStyleLayout.js"></script>

    <!-- 切换卡的js -->
    <script src="avicit/platform6/switch_card/yyui.js"></script>

    <!-- 自动编码的js -->
    <script src="avicit/platform6/autocode/js/AutoCode.js"></script>

    <script type="text/javascript">
        var procDetail;

        //注册附件上传完毕后执行的方法
        var afterUploadEvent = null;

        $("#financialResources").change(function(){
            var selected = $(this).children('option:selected').val();

            //技改项目
            if(selected == 1){
                $('#replyName').attr("readonly","readonly");//设为只读
                $('#belongProject').attr("readonly","readonly");//设为只读
                $('#projectNo').attr("readonly","readonly");//设为只读

                procDetail.toRelateTechTransformProject();
            }
            //非技改项目
            else{
                $('#replyName').val('');//清空取值
                $('#belongProject').val('');//清空取值
                $('#projectNo').val('');//清空取值
            }
        });

        function relateTechTransformProject(){
            var selected = $('#financialResources').children('option:selected').val();

            //技改项目
            if(selected == 1){
                $('#replyName').attr("readonly","readonly");//设为只读
                $('#belongProject').attr("readonly","readonly");//设为只读
                $('#projectNo').attr("readonly","readonly");//设为只读

                procDetail.toRelateTechTransformProject();
            }
        }

        $(document).ready(function () {
            var autoCode = new AutoCode("ASSETS_USTDTEMPAPPLY_PROC", "subscribeNo", false, "autoCodeValue", "123");

            //创建业务操作JS
            var assetsUstdtempapplyProcDetail = new AssetsUstdtempapplyProcDetail('form');

            //创建流程操作JS
            new FlowEditor(assetsUstdtempapplyProcDetail);

            procDetail = assetsUstdtempapplyProcDetail;

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
            //初始化附件上传组件
            $('#attachment').uploaderExt({
                formId: '<%=formId%>',
                secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
                afterUpload: function () {
                    return afterUploadEvent();
                }
            });
            //绑定表单验证规则
            assetsUstdtempapplyProcDetail.formValidate($('#form'));

            $('#applyByAlias').on('focus', function (e) {
                new H5CommonSelect({type: 'userSelect', idFiled: 'applyBy', textFiled: 'applyByAlias'});
                this.blur();
                nullInput(e);
            });

            //弹框选择操作者后，自动补充操作者部门信息
            $('#applyByAlias').on('blur', function (e) {
                var userId = document.getElementById('applyBy').value;

                if((userId != null) && (userId != undefined) && (userId != '')){
                    $.ajax({
                        url: "assets/device/assetstechtransformperson/assetsTechTransformPersonController/operation/userInfo",
                        data: userId,
                        contentType: 'application/json',
                        type: 'post',
                        dataType: 'json',
                        success: function (r) {
                            console.log(r);
                            if (r.flag == "success") {
                                if((r.userDto.deptName != null) && (r.userDto.deptName != undefined)){
                                    $("#applyByDeptAlias").val(r.userDto.deptName);   //设置b部门名称
                                    $("#applyByDept").val(r.userDto.deptId);   //设置部门id
                                }
                            } else {
                                layer.alert('用户信息获取失败,请联系管理员!', {
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
                }
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
    </script>
</body>
</html>
