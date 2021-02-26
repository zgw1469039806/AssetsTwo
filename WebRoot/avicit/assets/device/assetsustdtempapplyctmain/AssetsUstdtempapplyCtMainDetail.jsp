<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.googlecode.aviator.runtime.function.system.SysDateFunction" %>
<%@ page import="avicit.platform6.commons.utils.DateUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    String importlibs = "common,form,table,fileupload,tree";
    String pid = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/operation/toDetailJsp" -->
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
    <style type="text/css">
        #t_assetsUstdtempapplyCollect {
            display: none;
        }
    </style>
</head>
<style>
    tbody tr {
        text-align: center;
    }
</style>
<body>
<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include2/buttons.jsp"%>
<div id="formTab" style="display: none">
    <!-- 业务表单 Start -->
    <form id='form'>
        <input type="hidden" id="comId" name="id" />
        <input type="hidden" name="version"/>
        <p style="text-align: center; font-size: 18pt;">非标准设备年度申购上报</p>


        <table class="form_commonTable">
            <tr>
                <th width="5%">
                    <label for="authorAlias">上报人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="author" name="author" value=<%=userId%>>
                        <input class="form-control" placeholder="请选择用户" type="text" id="authorAlias" readonly="true"
                               name="authorAlias" value=<%=userName%>>
                        <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="releasedate">上报日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="releasedate"
                               id="releasedate" readonly="true" ><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="deptAlias">上报单位:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="dept" name="dept" value=<%=userDeptId%>>
                        <input class="form-control" placeholder="请选择部门" type="text" id="deptAlias"
                               name="deptAlias" value=<%=userDeptName%>>
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="tel">电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="tel" id="tel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="collectSelect">关联征集单:</label></th>
                <td width="15%" colspan="5">
                    <input class="form-control input-sm" type="text" readonly="readonly" name="collectSelect" onclick=openNoticeList()
                           id="collectSelect"/>
                </td>
                <th width="10%">
                    <label for="collectYear">年度:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="collectYear" readonly="readonly"
                           id="collectYear"/>
                </td>

            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <div id="toolbar_AssetsUstdtempapplyCollect" class="toolbar">
                        <div class="toolbar-left">
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_AssetsUstdtempapplyCollect_button_add"
                                                   permissionDes="添加">
                                <a id="assetsUstdtempapplyCollect_insert" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                   role="button"
                                   title="添加"><i class="fa fa-plus"></i> 添加</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_AssetsUstdtempapplyCollect_button_edit"
                                                   permissionDes="编辑">
                                <a id="assetsUstdtempapplyCollect_edit" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                   role="button"
                                   title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_AssetsUstdtempapplyCollect_button_delete"
                                                   permissionDes="删除">
                                <a id="assetsUstdtempapplyCollect_del" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                   role="button"
                                   title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_AssetsUstdtempapplyCollect_button_excel"
                                                   permissionDes="导入">
                                <a id="assetsUstdtempapplyCollect_excel" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                   role="button"
                                   title="导入"><i class="fa fa-file-text-o"></i> 导入</a>
                            </sec:accesscontrollist>
                            <a class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                               style="display:none" title="子表数据是否可编辑"
                               name="assetsUstdtempapplyCollect_editable"
                               id="assetsUstdtempapplyCollect_editable">是否可编辑</a>
                        </div>
                    </div>
                    <table id="assetsUstdtempapplyCollect"></table>
                </th>
            </tr>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1%>">
                    <div id="attachment" class="attachment_div eform_mutiattach_auth" ></div>
                </td>
            </tr>
        </table>
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
<script type="text/javascript"
        src="avicit/assets/device/assetsustdtempapplyctmain/js/SelfStyleLayout.js"></script>
<script type="text/javascript"
        src="avicit/assets/device/assetsustdtempapplyctmain/js/AssetsUstdtempapplyCtMainDetail.js"></script>
<script type="text/javascript"
        src="avicit/assets/device/assetsustdtempapplyctmain/js/AssetsUstdtempapplyCollect.js"></script>

<script type="text/javascript">
    //后台获取的通用代码数据
    var deviceCategoryData = null;
    var isNeedInstallData = null;
    var isHumidityNeedData = null;
    var isWaterNeedData = null;
    var isGasNeedData = null;
    var isLetData = null;
    var isOtherNeedData = null;
    var isAboveConditionsData = null;
    var financialResourcesData = null;
    var isTestDeviceData = null;
    var assetsUstdtempapplyCollect;

    //初始化通用代码值
    function initOnceInAdd() {
        avicAjax.ajax({
            url: "platform/assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/getLookUpCode",
            type: 'post',
            dataType: 'json',
            async: false,
            success: function (r) {
                if (r.flag == "success") {
                    deviceCategoryData = JSON.parse(r.deviceCategoryData);
                    isNeedInstallData = JSON.parse(r.isNeedInstallData);
                    isHumidityNeedData = JSON.parse(r.isHumidityNeedData);
                    isWaterNeedData = JSON.parse(r.isWaterNeedData);
                    isGasNeedData = JSON.parse(r.isGasNeedData);
                    isLetData = JSON.parse(r.isLetData);
                    isOtherNeedData = JSON.parse(r.isOtherNeedData);
                    isAboveConditionsData = JSON.parse(r.isAboveConditionsData);
                    financialResourcesData = JSON.parse(r.financialResourcesData);
                    isTestDeviceData = JSON.parse(r.isTestDeviceData);
                    financialResourcesData = JSON.parse(r.financialResourcesData);
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
    var assetsUstdtempapplyCollectGridColModel = null;
    $(document).ready(function () {
        var pid = "<%=pid%>";
        var isReload = "true";
        var searchSubNames = "";
        initOnceInAdd(); //初始化通用代码值
        assetsUstdtempapplyCollectGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            ,
             {
                label: '申请人',
                name: 'createdByPersionAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'createdByPersion'}
            },
            {
                label: '申请人部门',
                name: 'createdByDeptAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'createdByDept'}
            }
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {
                label: '设备类别',
                name: 'deviceCategoryName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'deviceCategory',
                    value: deviceCategoryData
                }
            }
            , {label: '所属项目', name: 'belongProject', width: 150}
            , {label: '经费来源',
                name: 'financialResourcesName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'financialResources',
                    value: financialResourcesData
                }}
            , {label: '经费概算', name: 'financialEstimate', width: 150}
            , {label: '批复名称', name: 'replyName', width: 150}
            , {label: '立项单号', name: 'approvalFormNumber', width: 150}

        ];
        var surl = "platform/assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/operation/sub/";
        var assetsUstdtempapplyCollect = new AssetsUstdtempapplyCollect('assetsUstdtempapplyCollect', surl,
            "formSub",
            assetsUstdtempapplyCollectGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsUstdtempapplyCollect_keyWord', isReload);
        //创建业务操作JS
        var assetsUstdtempapplyCtMainDetail = new AssetsUstdtempapplyCtMainDetail('form', assetsUstdtempapplyCollect);
        //创建流程操作JS
        new FlowEditor(assetsUstdtempapplyCtMainDetail);

        $('.date-picker').datepicker("setDate", new Date());
        $('.date-picker').datepicker("disable").attr("readonly","readonly");
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
        //绑定表单验证规则
        assetsUstdtempapplyCtMainDetail.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=pid%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });

        //添加按钮绑定事件
        $('#assetsUstdtempapplyCollect_insert').bind('click', function () {
            //assetsUstdtempapplyCollect.insert();
        });

        //添加按钮绑定事件
        $('#assetsUstdtempapplyCollect_edit').bind('click', function () {
            modify();
        });


        //删除按钮绑定事件
        $('#assetsUstdtempapplyCollect_del').bind('click', function () {
            assetsUstdtempapplyCollect.del();
        });






    });
</script>
</body>
</html>