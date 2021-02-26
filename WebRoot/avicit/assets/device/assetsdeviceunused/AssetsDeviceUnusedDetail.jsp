<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysDept" %>
<%
    String importlibs = "common,form,table,fileupload,tree";
    String pid = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdeviceunused/assetsDeviceUnusedController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>
    <%
        String userId = SessionHelper.getLoginSysUserId(request);   /* 从SessionHelper中获取当前的登录用户ID */
        String deptId = SessionHelper.getCurrentDeptId(request);    /* 从SessionHelper中获取当前的登录部门ID */
        SysUser user = SessionHelper.getLoginSysUser(request);      /* 从SessionHelper中获取当前的登录用户 */
        SysDept dept = SessionHelper.getCurrentDept(request);       /* 从SessionHelper中获取当前的登录部门 */
        String userName = user.getName();
        String deptName = dept.getDeptName();
    %>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

    <style type="text/css">
        #t_assetsDeviceUnusedsub {
            display: none;
        }
    </style>
    <!-- 框架 样式 -->
    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmbusiness/include2/common/css/style.css">

</head>
<body>
<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include2/buttons.jsp"%>
<div id="formTab" style="display: none">
    <p style="text-align: center;">
        <span style="font-size: 32px; text-align: center;">设备闲置申请单</span>
    </p>
    <!-- 业务表单 Start -->
    <form id='form'>
        <input type="hidden" name="id" id="id"/>
        <input type="hidden" name="version" id="version"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="procId">闲置单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" placeholder="系统自动生成" type="text" name="procId" id="procId"/>
                </td>
                <th width="10%">
                    <label for="createdByPersonAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPerson" name="createdByPerson" value="<%=userId%>">
                        <input class="form-control" placeholder="请选择用户" type="text"
                               id="createdByPersonAlias" name="createdByPersonAlias" value="<%=userName%>">
                        <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept" value="<%=deptId%>">
                        <input class="form-control" placeholder="请选择部门" type="text"
                               id="createdByDeptAlias" name="createdByDeptAlias" value="<%=deptName%>">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel"
                           id="createdByTel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="unusedReason">闲置原因:</label></th>
                <td width="90%" colspan="7">
                                        <textarea class="form-control input-sm" rows="5" type="text" name="unusedReason"
                                                  id="unusedReason"/></textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="productRiskAnalyse">有关产品风险分析:</label></th>
                <td width="90%" colspan="7">
                                        <textarea class="form-control input-sm" rows="5" type="text" name="productRiskAnalyse"
                                                  id="productRiskAnalyse"/></textarea>
                </td>
            </tr>
            <tr>
                <th width="10%">
                    <label for="recoveryStore">回收库:</label></th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="recoveryStore"
                                  id="recoveryStore" title="" isNull="true"
                                  lookupCode="RECOVERY_STORE"/>
                </td>
                <th width="10%"></th>
                <td width="15%"></td>

                <th width="10%"></th>
                <td width="15%"></td>

                <th width="10%"></th>
                <td width="15%"></td>
            </tr>
            <%--<tr>--%>
            <%--<th width="10%">--%>
            <%--<label for="procName">流程名称:</label></th>--%>
            <%--<td width="15%">--%>
            <%--<input class="form-control input-sm" type="text" name="procName" id="procName"/>--%>
            <%--</td>--%>
            <%--<th width="10%">--%>
            <%--<label for="formState">单据状态:</label></th>--%>
            <%--<td width="15%">--%>
            <%--<input class="form-control input-sm" type="text" name="formState"--%>
            <%--id="formState"/>--%>
            <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <th><label for="attachment">附件</label></th>
                <td colspan="<%=4 * 2 - 1%>">
                    <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
                </td>
            </tr>
            <tr >
                <td style="text-align:center" colspan="8">
                    <span style="font-family: 微软雅黑; font-size: 14pt;">设备列表</span>
                </td>
            </tr>
            <tr>
                <th width="10%"></th>
                <td width="15%"></td>

                <th width="10%"></th>
                <td width="15%"></td>

                <th width="10%"></th>
                <td width="15%"></td>

                <th width="10%">
                    <label for="totalUnusedMoney">净闲置总金额:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalUnusedMoney"
                               id="totalUnusedMoney"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1"
                               data-precision="3">
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
                <th width="99%" colspan="<%=4 * 2 %>">
                    <div id="toolbar_AssetsDeviceUnusedsub" class="toolbar">
                        <div class="toolbar-left">
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_AssetsDeviceUnusedsub_button_add"
                                                   permissionDes="添加">
                                <a id="assetsDeviceUnusedsub_insert" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                   role="button"
                                   title="添加"><i class="fa fa-plus"></i> 添加</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_AssetsDeviceUnusedsub_button_delete"
                                                   permissionDes="删除">
                                <a id="assetsDeviceUnusedsub_del" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                   role="button"
                                   title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                            </sec:accesscontrollist>
                            <a class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                               style="display:none" title="子表数据是否可编辑"
                               name="assetsDeviceUnusedsub_editable"
                               id="assetsDeviceUnusedsub_editable">是否可编辑</a>
                        </div>
                    </div>
                    <table id="assetsDeviceUnusedsub" name="ASSETS_DEVICE_UNUSEDSUB"
                           class="customform_subtable_bpm_auth"></table>
                    <pt6:h5resource label="统一编号" name="unifiedId"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="资产编号" name="assetId"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="设备类别" name="deviceCategory"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="设备名称" name="deviceName"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="设备型号" name="deviceModel"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="设备规格" name="deviceSpec"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="责任人" name="ownerIdAlias"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="责任人部门" name="ownerDeptAlias"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="使用人" name="userIdAlias"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="使用人部门" name="userDeptAlias"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="生产厂家" name="manufacturerId"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="立卡日期" name="createdDate"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="安装地点ID" name="positionId"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="原值" name="originalValue"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="累计折旧" name="totalDepreciation"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="净值" name="netValue"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="净残值" name="netSalvage"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="密级" name="secretLevel"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                    <pt6:h5resource label="净闲置金额" name="unusedMoney"
                                    ref_table="ASSETS_DEVICE_UNUSEDSUB"></pt6:h5resource>
                </th>
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
<script type="text/javascript" src="avicit/assets/device/assetsdeviceunused/js/AssetsDeviceUnusedDetail.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdeviceunused/js/AssetsDeviceUnusedsub.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdeviceunused/js/SelfStyleLayout.js"></script>
<!-- 自动编码的js -->
<script src="avicit/platform6/autocode/js/AutoCode.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    //初始化通用代码值
    function initOnceInAdd() {
        avicAjax.ajax({
            url: "platform/assets/device/assetsdeviceunused/assetsDeviceUnusedController/getLookUpCode",
            type: 'post',
            dataType: 'json',
            async: false,
            success: function (r) {
                if (r.flag == "success") {
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
    var assetsDeviceUnusedsubGridColModel = null;
    $(document).ready(function () {
        /***********************************************************************************
         编码规则
         var autoCode = new AutoCode("USER_CODE", "employeeNo", false, "autoCodeValue");
         "USER_CODE"为编码管理中维护的编码代码
         "employeeNo"为表单中需要编码的字段
         false表示编码是否可编辑
         "autoCodeValue"为固定写法，表示编码值
         参数5可以设置为任意值，如123（编码规则包含函数类型时，该参数必须传值）
         ***********************************************************************************/

        //自动生成设备闲置编号
        var autoCode = new AutoCode("DEVICE_UNUSED_PROC", "procId", false, "autoCodeValue", "123");

        var pid = "<%=pid%>";
        var isReload = "true";
        var searchSubNames = "";
        initOnceInAdd(); //初始化通用代码值
        assetsDeviceUnusedsubGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            ,{ label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '资产编号', name: 'assetId', width: 150}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {
                label: '责任人',
                name: 'ownerIdAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'ownerId'}
            }
            , {label: '责任人id', name: 'ownerId', width: 75, hidden: true}
            , {
                label: '责任人部门',
                name: 'ownerDeptAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'ownerDept'}
            }
            , {label: '责任人部门id', name: 'ownerDept', width: 75, hidden: true}
            // , {
            //     label: '使用人',
            //     name: 'userIdAlias',
            //     width: 150,
            //     edittype: 'custom',
            //     editoptions: {custom_element: userElem, custom_value: userValue, forId: 'userId'}
            // }
            , {label: '使用人id', name: 'userId', width: 75, hidden: true}
            // , {
            //     label: '使用人部门',
            //     name: 'userDeptAlias',
            //     width: 150,
            //     edittype: 'custom',
            //     editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'userDept'}
            // }
            , {label: '使用人部门id', name: 'userDept', width: 75, hidden: true}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {
                label: '立卡日期',
                name: 'createdDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {
                label: '原值',
                name: 'originalValue',
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
            , {
                label: '累计折旧',
                name: 'totalDepreciation',
                width: 150,
                edittype: 'custom',
                editoptions: {
                    custom_element: spinnerElem,
                    custom_value: spinnerValue,
                    min: -<%=Math.pow(10,12)-Math.pow(10,-0)%>,
                    max:<%=Math.pow(10,12)-Math.pow(10,-0)%>,
                    step: 1,
                    precision: 0
                }
            }
            , {
                label: '净值',
                name: 'netValue',
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
            , {
                label: '净残值',
                name: 'netSalvage',
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
            , {label: '密级', name: 'secretLevel', width: 150}
            , {
                label: '净闲置金额',
                name: 'unusedMoney',
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
        ];

        var surl = "platform/assets/device/assetsdeviceunused/assetsDeviceUnusedController/operation/sub/";
        var assetsDeviceUnusedsub = new AssetsDeviceUnusedsub('assetsDeviceUnusedsub', surl,
            "formSub",
            assetsDeviceUnusedsubGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsDeviceUnusedsub_keyWord', isReload);
        //创建业务操作JS
        var assetsDeviceUnusedDetail = new AssetsDeviceUnusedDetail('form', assetsDeviceUnusedsub);
        //创建流程操作JS
        new FlowEditor(assetsDeviceUnusedDetail);

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
        $('.date-picker').datepicker({yearRange: "c-100:c+10"}); //时间控件增加年度选择

        // $("#assetsDeviceUnusedsub").jqGrid({
        //     gridComplete:TotalunusedMoney
        // });
        // function TotalunusedMoney(){
        //     var total = $("#assetsDeviceUnusedsub").getCol('unusedMoney',false,'sum');
        // }
        //绑定表单验证规则
        assetsDeviceUnusedDetail.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=pid%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //添加按钮绑定事件
        $('#assetsDeviceUnusedsub_insert').bind('click', function () {
            // assetsDeviceUnusedsub.insert();
            var param =  JSON.stringify({DEVICE_STATE:"1"}); /* 筛选在用状态的设备 */
            openProductModelLayer("false","","callBackFn",param);
        });
        //删除按钮绑定事件
        $('#assetsDeviceUnusedsub_del').bind('click', function () {
            assetsDeviceUnusedsub.del();
        });

        $('#createdByPersonAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPerson', textFiled: 'createdByPersonAlias'});
            this.blur();
            nullInput(e);
        });
        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });

    /* 将子表的全部复选框的禁用功能取消 */
    window.onload = function () {
        $('#cb_assetsDeviceUnusedsub').attr("disabled", false);
    }
</script>
</body>
</html>