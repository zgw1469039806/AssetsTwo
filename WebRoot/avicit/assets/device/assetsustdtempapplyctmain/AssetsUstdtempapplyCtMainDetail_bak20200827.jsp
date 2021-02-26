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
        //Date releaseDate = new Date();
        String releaseDate = DateUtil.getCurDateStr("yyyy-MM-dd");
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    %>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <!-- 当前页 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/editForm.css">
    <!-- 定制tab标签样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/avictabs.css">
    <!-- 流程标签 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/workflow.css">
    <!-- 时间轴 样式 -->
    <link rel="stylesheet" type="text/css" href="static/h5/timeliner/css/timeliner.css">
    <style type="text/css">
        #t_assetsUstdtempapplyCollect {
            display: none;
        }
    </style>
</head>
<body>
<div class="main">
    <!-- 右侧工具栏 Start -->
    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttons.jsp" %>
    <!-- 右侧工具栏 End -->
    <!-- 正文内容 Start -->
    <div class="content">
        <!-- 简单tab Start -->
        <div class="avic-tab">
            <div class="tab-bar">
                <ul>
                    <li class="on">表单信息</li>
                    <li>流程跟踪</li>
                    <li>引用文档</li>
                    <li>关联流程</li>
                </ul>
            </div>
            <div class="btn-bar on">
                <!-- 暂存 关注 正文 等流程代理的按钮 -->
                <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttonBar.jsp" %>
            </div>
            <div class="tab-panel">
                <div class="panel-body on">
                    <div class="panel-main">
                        <!-- 业务表单 Start -->
                        <form id='form'>
                            <input type="hidden" name="id"/>
                            <input type="hidden" name="version"/>
                            <p style="text-align: center; font-size: 18pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;非标准设备年度申购上报</p>


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
                                            <input class="form-control" type="text" name="releasedate"
                                                   id="releasedate" readonly="true" value=<%=releaseDate%>><span class="input-group-addon"><i
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
                                        <input class="form-control input-sm" type="text" name="collectSelect"
                                               id="collectSelect"/>
                                    </td>
                                    <th width="10%">
                                        <label for="collectYear">年度:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="collectYear"
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
                                                                       domainObject="formdialog_AssetsUstdtempapplyCollect_button_delete"
                                                                       permissionDes="删除">
                                                    <a id="assetsUstdtempapplyCollect_del" href="javascript:void(0)"
                                                       class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                                       role="button"
                                                       title="删除"><i class="fa fa-trash-o"></i> 删除</a>
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
                                        <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
                                    </td>
                                </tr>
                            </table>
                        </form>
                        <!-- 业务表单 End -->
                    </div>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/tracks.jsp" %>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/files.jsp" %>
                </div>
                <div class="panel-body">
                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/processlevel.jsp" %>
                </div>
            </div>
        </div>
        <!-- 简单tab End -->
    </div>
    <!-- 正文内容 End -->
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 页面脚本 avictabs.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/avictabs.js"></script>
<!-- 时间轴组件 timeliner.js-->
<script type="text/javascript" src="static/h5/timeliner/js/timeliner.js"></script>
<!-- 页面脚本 editForm.js-->
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/editForm.js"></script>
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowEditor.js"></script>
<!-- 业务的js -->
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
            , {label: '<span style="color:red;">*</span>申购单号', name: 'stdId', width: 150}
            , {
                label: '申请人部门',
                name: 'createdByDeptAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'createdByDept'}
            }
            , {label: '申请人部门id', name: 'createdByDept', width: 75, hidden: true}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            , {label: '单据状态', name: 'formState', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备类别id', name: 'deviceCategory', width: 75, hidden: true}
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
            , {label: '承制单位', name: 'manufactureUnit', width: 150}
            , {label: '课题代号', name: 'subjectCode', width: 150}
            , {
                label: '主管机关',
                name: 'competentAuthorityAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'competentAuthority'}
            }
            , {label: '主管机关id', name: 'competentAuthority', width: 75, hidden: true}
            , {
                label: '型号主管',
                name: 'modelDirectorAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'modelDirector'}
            }
            , {label: '型号主管id', name: 'modelDirector', width: 75, hidden: true}
            , {
                label: '主管所领导',
                name: 'competentLeaderAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'competentLeader'}
            }
            , {label: '主管所领导id', name: 'competentLeader', width: 75, hidden: true}
            , {label: '申购理由及用途', name: 'applyReasonPurpose', width: 150}
            , {label: '原有设备的情况', name: 'orignEquipSituation', width: 150}
            , {label: '使用效率情况', name: 'efficiencySituation', width: 150}
            , {label: '研制内容', name: 'developmentContent', width: 150}
            , {label: '技术指标', name: 'technicalIndex', width: 150}
            , {label: '研制周期', name: 'developmentCycle', width: 150}
            , {label: '是否需要安装id', name: 'isNeedInstall', width: 75, hidden: true}
            , {
                label: '是否需要安装',
                name: 'isNeedInstallName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'isNeedInstall',
                    value: isNeedInstallData
                }
            }
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {label: '使用电压', name: 'serviceVoltage', width: 150}
            , {label: '是否对温湿度有要求id', name: 'isHumidityNeed', width: 75, hidden: true}
            , {
                label: '是否对温湿度有要求',
                name: 'isHumidityNeedName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'isHumidityNeed',
                    value: isHumidityNeedData
                }
            }
            , {label: '温湿度要求', name: 'humidityNeed', width: 150}
            , {label: '是否有用水要求id', name: 'isWaterNeed', width: 75, hidden: true}
            , {
                label: '是否有用水要求',
                name: 'isWaterNeedName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'isWaterNeed',
                    value: isWaterNeedData
                }
            }
            , {label: '用水要求', name: 'waterNeed', width: 150}
            , {label: '是否有用气要求id', name: 'isGasNeed', width: 75, hidden: true}
            , {
                label: '是否有用气要求',
                name: 'isGasNeedName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'isGasNeed',
                    value: isGasNeedData
                }
            }
            , {label: '用气要求', name: 'gasNeed', width: 150}
            , {label: '是否有气体排放id', name: 'isLet', width: 75, hidden: true}
            , {
                label: '是否有气体排放',
                name: 'isLetName',
                width: 150,
                edittype: "custom",
                editoptions: {custom_element: selectElem, custom_value: selectValue, forId: 'isLet', value: isLetData}
            }
            , {label: '气体排放要求', name: 'letNeed', width: 150}
            , {label: '是否有其他特殊要求id', name: 'isOtherNeed', width: 75, hidden: true}
            , {
                label: '是否有其他特殊要求',
                name: 'isOtherNeedName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'isOtherNeed',
                    value: isOtherNeedData
                }
            }
            , {label: '其他特殊要求', name: 'otherNeed', width: 150}
            , {label: '以上需求条件在拟安装地点是否都已具备id', name: 'isAboveConditions', width: 75, hidden: true}
            , {
                label: '以上需求条件在拟安装地点是否都已具备',
                name: 'isAboveConditionsName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'isAboveConditions',
                    value: isAboveConditionsData
                }
            }
            , {label: '是否计量', name: 'isMetering', width: 150}
            , {label: '计量要求', name: 'meteringRequirement', width: 150}
            , {
                label: '经费概算',
                name: 'financialEstimate',
                width: 150,
                edittype: 'custom',
                editoptions: {
                    custom_element: spinnerElem,
                    custom_value: spinnerValue,
                    min: -<%=Math.pow(10,12)-Math.pow(10,-3)%>,
                    max:<%=Math.pow(10,12)-Math.pow(10,-3)%>,
                    step: 1,
                    precision: 3
                }
            }
            , {label: '经费来源id', name: 'financialResources', width: 75, hidden: true}
            , {
                label: '经费来源',
                name: 'financialResourcesName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'financialResources',
                    value: financialResourcesData
                }
            }
            , {label: '所属项目', name: 'belongProject', width: 150}
            , {label: '项目序号', name: 'projectNo', width: 150}
            , {label: '批复名称', name: 'replyName', width: 150}
            , {label: '立项单号', name: 'approvalFormNumber', width: 150}
            , {label: '是否测试设备id', name: 'isTestDevice', width: 75, hidden: true}
            , {
                label: '是否测试设备',
                name: 'isTestDeviceName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'isTestDevice',
                    value: isTestDeviceData
                }
            }
            , {
                label: '主管设备所领导',
                name: 'competentDeviceLeaderAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'competentDeviceLeader'}
            }
            , {label: '主管设备所领导id', name: 'competentDeviceLeader', width: 75, hidden: true}
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
            assetsUstdtempapplyCollect.insert();
        });
        //删除按钮绑定事件
        $('#assetsUstdtempapplyCollect_del').bind('click', function () {
            assetsUstdtempapplyCollect.del();
        });

    });
</script>
</body>
</html>