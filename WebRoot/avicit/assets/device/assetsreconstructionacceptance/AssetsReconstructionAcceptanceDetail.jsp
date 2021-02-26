<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
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
    <!-- ControllerPath = "assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/operation/toDetailJsp" -->
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
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <!-- 框架 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmbusiness/include2/common/css/style.css">
</head>
<body>
<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include2/buttons.jsp" %>
<div id="formTab" style="display: none">
    <!-- 业务表单 Start -->
    <form id='form'>
        <input type="hidden" name="id" id="id"/> <input type="hidden"
                                                        name="version" id="version"/><input type="hidden"
                                                                                            name="attribute10"
                                                                                            id="attribute10"/>
        <table class="form_commonTable">
            <tr class="commonTableTr">
                <th width="10%"><label for="acceptanceId">验收单号:</label></th>
                <td colspan="2"><input class="form-control input-sm"
                                       type="text" name="acceptanceId" id="acceptanceId"/></td>
            </tr>
            <tr class="commonTableTr">
                <th width="10%"><label for="deviceName">设备名称:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="deviceName" id="deviceName"/></td>
                <th width="10%"><label for="unifiedId">统一编号:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="unifiedId" id="unifiedId"/></td>
                <th width="10%"><label for="stdId">申购单号:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="stdId" id="stdId"/></td>
                <th width="10%"><label for="createdByAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdBy" name="createdBy" value="<%=userId%>" readonly>
                        <input class="form-control" placeholder="请选择用户" type="text" value="<%=userName%>" readonly
                               id="createdByAlias" name="createdByAlias"> <span
                            class="input-group-addon"> <i
                            class="glyphicon glyphicon-user"></i>
												</span>
                    </div>
                </td>
            </tr>
            <tr class="commonTableTr">
                <th width="10%"><label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept" value="<%=userDeptId%>">
                        <input class="form-control" placeholder="请选择部门" type="text" value="<%=userDeptName%>"
                               id="createdByDeptAlias" name="createdByDeptAlias">
                        <span class="input-group-addon"> <i
                                class="glyphicon glyphicon-equalizer"></i>
												</span>
                    </div>
                </td>
                <th width="10%"><label for="chargePersonTel">责任人联系方式:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="chargePersonTel" id="chargePersonTel"/></td>
                <th width="10%"><label for="contractNum">合同编号:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="contractNum" id="contractNum"/></td>
                <th width="10%"><label for="chargeDeptAlias">责任部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="chargeDept" name="chargeDept">
                        <input class="form-control" placeholder="请选择部门" type="text"
                               id="chargeDeptAlias" name="chargeDeptAlias"> <span
                            class="input-group-addon"> <i
                            class="glyphicon glyphicon-equalizer"></i>
												</span>
                    </div>
                </td>
            </tr>
            <tr class="commonTableTr">
                <th width="10%"><label for="chargePersonAlias">责任人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="chargePerson" name="chargePerson">
                        <input class="form-control" placeholder="请选择用户" type="text"
                               id="chargePersonAlias" name="chargePersonAlias"> <span
                            class="input-group-addon"> <i
                            class="glyphicon glyphicon-user"></i>
												</span>
                    </div>
                </td>
                <th width="10%"><label for="deviceCategory">设备类别:</label></th>
                <td width="15%"><pt6:h5select
                        css_class="form-control input-sm" name="deviceCategory"
                        id="deviceCategory" title="" isNull="true"
                        lookupCode="DEVICE_CATEGORY"/></td>
                <th width="10%"><label for="unitPrice">单价(元):</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner"
                         data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice"
                               id="unitPrice"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-step="1" data-precision="3"> <span
                            class="input-group-addon"> <a href="javascript:;"
                                                          class="spin-up" data-spin="up"><i
                            class="glyphicon glyphicon-triangle-top"></i></a> <a
                            href="javascript:;" class="spin-down" data-spin="down"><i
                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												</span>
                    </div>
                </td>
                <th width="10%"><label for="secretLevel">密级:</label></th>
                <td width="15%"><pt6:h5select
                        css_class="form-control input-sm" name="secretLevel"
                        id="secretLevel" title="" isNull="true"
                        lookupCode="SECRET_LEVEL"/></td>
            </tr>
            <tr class="commonTableTr">
                <th width="10%"><label for="isRegularCheck">是否定检:</label></th>
                <td width="15%"><pt6:h5select
                        css_class="form-control input-sm" name="isRegularCheck"
                        id="isRegularCheck" title="" isNull="true"
                        lookupCode="PLATFORM_YES_NO_FLAG"/></td>
                <th width="10%"><label for="isSpotCheck">是否点检:</label></th>
                <td width="15%"><pt6:h5select
                        css_class="form-control input-sm" name="isSpotCheck"
                        id="isSpotCheck" title="" isNull="true"
                        lookupCode="PLATFORM_YES_NO_FLAG"/></td>
                <th width="10%"><label for="isAccuracyCheck">是否精度检查:</label></th>
                <td width="15%"><pt6:h5select
                        css_class="form-control input-sm" name="isAccuracyCheck"
                        id="isAccuracyCheck" title="" isNull="true"
                        lookupCode="PLATFORM_YES_NO_FLAG"/></td>
                <th width="10%"><label for="isNeedInstall">是否需要安装:</label></th>
                <td width="15%"><pt6:h5select
                        css_class="form-control input-sm" name="isNeedInstall"
                        id="isNeedInstall" title="" isNull="true"
                        lookupCode="PLATFORM_YES_NO_FLAG"/></td>
            </tr>
            <tr class="commonTableTr">
                <th width="10%"><label for="position">安装地点:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="position" id="position"/></td>
                <th width="10%"><label for="isMetering">是否计量:</label></th>
                <td width="15%"><pt6:h5select
                        css_class="form-control input-sm" name="isMetering"
                        id="isMetering" title="" isNull="true"
                        lookupCode="PLATFORM_YES_NO_FLAG"/></td>
                <th width="10%"><label for="isSafetyProduction">是否涉及安全生产:</label></th>
                <td width="15%"><pt6:h5select
                        css_class="form-control input-sm" name="isSafetyProduction"
                        id="isSafetyProduction" title="" isNull="true"
                        lookupCode="PLATFORM_YES_NO_FLAG"/></td>
                <th width="10%"><label for="financialResources">经费来源:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="financialResources" id="financialResources"/>
                </td>
            </tr>
            <tr class="commonTableTr">
                <th width="10%"><label for="belongProject">所属项目:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="belongProject" id="belongProject"/></td>
                <th width="10%"><label for="projectNo">项目序号:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="projectNo" id="projectNo"/></td>
                <th width="10%"><label for="replyName">批复名称:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="replyName" id="replyName"/></td>
                <th width="10%"><label for="approvalFormNumber">立项单号:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="approvalFormNumber" id="approvalFormNumber"/>
                </td>
            </tr>
            <tr class="commonTableTr">
                <th width="10%"><label for="manufacturerId">生产厂家:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="manufacturerId" id="manufacturerId"/></td>
                <th width="10%"><label for="formState">单据状态:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="formState" id="formState"/></td>
                <th width="10%"><label for="isMaintain">是否保养:</label></th>
                <td width="15%"><pt6:h5select
                        css_class="form-control input-sm" name="isMaintain"
                        id="isMaintain" title="" isNull="true"
                        lookupCode="PLATFORM_YES_NO_FLAG"/></td>
                <th width="10%"><label for="isSceneMetering">是否现场计量:</label></th>
                <td width="15%"><pt6:h5select
                        css_class="form-control input-sm" name="isSceneMetering"
                        id="isSceneMetering" title="" isNull="true"
                        lookupCode="PLATFORM_YES_NO_FLAG"/></td>
            </tr>
            <tr class="commonTableTr">
                <th width="10%"><label for="meteringId">计量标识:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="meteringId" id="meteringId"/></td>
                <th width="10%"><label for="metermanAlias">计量人员:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meterman" name="meterman">
                        <input class="form-control" placeholder="请选择用户" type="text"
                               id="metermanAlias" name="metermanAlias"> <span
                            class="input-group-addon"> <i
                            class="glyphicon glyphicon-user"></i>
												</span>
                    </div>
                </td>
                <th width="10%"><label for="meteringDate">计量时间:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text"
                               name="meteringDate" id="meteringDate"/><span
                            class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%"><label for="meteringCycle">计量周期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner"
                         data-trigger="spinner">
                        <input class="form-control" type="text" name="meteringCycle"
                               id="meteringCycle"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-step="1" data-precision="0"> <span
                            class="input-group-addon"> <a href="javascript:;"
                                                          class="spin-up" data-spin="up"><i
                            class="glyphicon glyphicon-triangle-top"></i></a> <a
                            href="javascript:;" class="spin-down" data-spin="down"><i
                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												</span>
                    </div>
                </td>
            </tr>
            <tr class="commonTableTr">

                <th width="10%"><label for="abcCategory">ABC分类:</label></th>
                <td width="15%"><input class="form-control input-sm"
                                       type="text" name="abcCategory" id="abcCategory"/></td>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1%>">
                    <div id="attachment"
                         class="attachment_div eform_mutiattach_auth"></div>
                </td>
            </tr>
        </table>
    </form>
    <!-- 业务表单 End -->
</div>

<jsp:include
        page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
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
<script
        src="avicit/assets/device/assetsreconstructionacceptance/js/AssetsReconstructionAcceptanceDetail.js"></script>
<script
        src="avicit/assets/device/assetsreconstructionacceptance/js/SelfStyleLayout.js"></script>
<!-- 自动编码的js -->
<script src="avicit/platform6/autocode/js/AutoCode.js"></script>
<script type="text/javascript">
    //注册附件上传完毕后执行的方法
    var afterUploadEvent = null;
    $(document).ready(function () {

        var autoCode = new AutoCode("ASSETS_USTDTEMP_ACCEPTANCE",
            "acceptanceId", false, "autoCodeValue", "123");
        var autoCode2 = new AutoCode("ASSETS_USTDTEMP_UNIFIED",
            "unifiedId", false, "autoCodeValue2", "123");
        var autoCode3 = new AutoCode("ASSETS_DEVICE_ACCOUNT",
            "attribute10", false, "autoCodeValue3", "123");
        //创建业务操作JS
        var assetsUstdtempAcceptanceDetail = new AssetsUstdtempAcceptanceDetail('form');
        //创建流程操作JS
        new FlowEditor(assetsUstdtempAcceptanceDetail);

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
        assetsUstdtempAcceptanceDetail.formValidate($('#form'));

        $('#createdByAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdBy', textFiled: 'createdByAlias'});
            this.blur();
            nullInput(e);
        });
        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#chargeDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'chargeDept', textFiled: 'chargeDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#chargePersonAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'chargePerson', textFiled: 'chargePersonAlias'});
            this.blur();
            nullInput(e);
        });
        $('#metermanAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meterman', textFiled: 'metermanAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>