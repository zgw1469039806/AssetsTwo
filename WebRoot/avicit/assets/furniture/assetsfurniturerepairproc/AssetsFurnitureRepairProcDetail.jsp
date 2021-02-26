<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,table,fileupload,tree";
    String pid = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/furniture/assetsfurniturerepairproc/assetsFurnitureRepairProcController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>
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
        #t_assetsFurnitureRepairSub {
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
                            <input type="hidden" name="id" id="id"/>
                            <input type="hidden" name="version" id="version"/>
                            <table class="form_commonTable">
                                <tr>
                                    <th width="10%">
                                        <label for="procName">流程名称:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="procName" id="procName"/>
                                    </td>
                                    <th width="10%">
                                        <label for="procId">流程ID:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="procId" id="procId"/>
                                    </td>
                                    <th width="10%">
                                        <label for="formState">单据状态:</label></th>
                                    <td width="15%">
                                        <input class="form-control input-sm" type="text" name="formState"
                                               id="formState"/>
                                    </td>
                                    <th width="10%">
                                        <label for="createdByPersonAlias">申请人:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="createdByPerson" name="createdByPerson">
                                            <input class="form-control" placeholder="请选择用户" type="text"
                                                   id="createdByPersonAlias" name="createdByPersonAlias">
                                            <span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="createdByDeptAlias">申请人部门:</label></th>
                                    <td width="15%">
                                        <div class="input-group  input-group-sm">
                                            <input type="hidden" id="createdByDept" name="createdByDept">
                                            <input class="form-control" placeholder="请选择部门" type="text"
                                                   id="createdByDeptAlias" name="createdByDeptAlias">
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
                                    <th width="10%">
                                        <label for="repairReason">家具损坏原因及损坏情况:</label></th>
                                    <td width="15%">
                                        <textarea class="form-control input-sm" rows="3" name="repairReason"
                                                  id="repairReason"></textarea>
                                    </td>
                                    <th width="10%">
                                        <label for="repairCondition">修理情况:</label></th>
                                    <td width="15%">
                                        <textarea class="form-control input-sm" rows="3" name="repairCondition"
                                                  id="repairCondition"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th width="10%">
                                        <label for="remarks">备注:</label></th>
                                    <td width="15%">
                                        <textarea class="form-control input-sm" rows="3" name="remarks"
                                                  id="remarks"></textarea>
                                    </td>
                                    <th width="10%">
                                        <label for="repairExpenses">维修费用:</label></th>
                                    <td width="15%">
                                        <div class="input-group input-group-sm spinner" data-trigger="spinner">
                                            <input class="form-control" type="text" name="repairExpenses"
                                                   id="repairExpenses" data-min="-<%=Math.pow(10,12)-Math.pow(10,-2)%>"
                                                   data-max="<%=Math.pow(10,12)-Math.pow(10,-2)%>" data-step="1"
                                                   data-precision="2">
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
                                        <div id="toolbar_AssetsFurnitureRepairSub" class="toolbar">
                                            <div class="toolbar-left">
                                                <sec:accesscontrollist hasPermission="3"
                                                                       domainObject="formdialog_AssetsFurnitureRepairSub_button_add"
                                                                       permissionDes="添加">
                                                    <a id="assetsFurnitureRepairSub_insert" href="javascript:void(0)"
                                                       class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                                       role="button"
                                                       title="添加"><i class="fa fa-plus"></i> 添加</a>
                                                </sec:accesscontrollist>
                                                <sec:accesscontrollist hasPermission="3"
                                                                       domainObject="formdialog_AssetsFurnitureRepairSub_button_delete"
                                                                       permissionDes="删除">
                                                    <a id="assetsFurnitureRepairSub_del" href="javascript:void(0)"
                                                       class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                                       role="button"
                                                       title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                                                </sec:accesscontrollist>
                                                <a class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                                   style="display:none" title="子表数据是否可编辑"
                                                   name="assetsFurnitureRepairSub_editable"
                                                   id="assetsFurnitureRepairSub_editable">是否可编辑</a>
                                            </div>
                                        </div>
                                        <table id="assetsFurnitureRepairSub" name="ASSETS_FURNITURE_REPAIR_SUB"
                                               class="customform_subtable_bpm_auth"></table>
                                        <pt6:h5resource label="统一编号" name="unifiedId"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="资产编号" name="assetId"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="家具名称" name="furnitureName"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="家具分类" name="furnitureCategoryName"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="家具规格" name="furnitureSpec"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="责任人" name="ownerIdAlias"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="责任人部门" name="ownerDeptAlias"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="使用人" name="userIdAlias"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="使用人部门" name="userDeptAlias"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="生产厂家" name="manufacturerId"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="立卡日期" name="createdDate"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="安装地点ID" name="positionId"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="家具照片" name="furniturePhoto"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="家具状态" name="furnitureStateName"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="原值" name="originalValue"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="净值" name="netValue"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
                                        <pt6:h5resource label="质保截止日期" name="guaranteeDate"
                                                        ref_table="ASSETS_FURNITURE_REPAIR_SUB"></pt6:h5resource>
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
        src="avicit/assets/furniture/assetsfurniturerepairproc/js/AssetsFurnitureRepairProcDetail.js"></script>
<script type="text/javascript"
        src="avicit/assets/furniture/assetsfurniturerepairproc/js/AssetsFurnitureRepairSub.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var furnitureCategoryData = null;
    var furnitureStateData = null;

    //初始化通用代码值
    function initOnceInAdd() {
        avicAjax.ajax({
            url: "platform/assets/furniture/assetsfurniturerepairproc/assetsFurnitureRepairProcController/getLookUpCode",
            type: 'post',
            dataType: 'json',
            async: false,
            success: function (r) {
                if (r.flag == "success") {
                    furnitureCategoryData = JSON.parse(r.furnitureCategoryData);
                    furnitureStateData = JSON.parse(r.furnitureStateData);
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
    var assetsFurnitureRepairSubGridColModel = null;
    $(document).ready(function () {
        var pid = "<%=pid%>";
        var isReload = "true";
        var searchSubNames = "";
        initOnceInAdd(); //初始化通用代码值
        assetsFurnitureRepairSubGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '资产编号', name: 'assetId', width: 150}
            , {label: '家具名称', name: 'furnitureName', width: 150}
            , {label: '家具分类id', name: 'furnitureCategory', width: 75, hidden: true}
            , {
                label: '家具分类',
                name: 'furnitureCategoryName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'furnitureCategory',
                    value: furnitureCategoryData
                }
            }
            , {label: '家具规格', name: 'furnitureSpec', width: 150}
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
            , {
                label: '使用人',
                name: 'userIdAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'userId'}
            }
            , {label: '使用人id', name: 'userId', width: 75, hidden: true}
            , {
                label: '使用人部门',
                name: 'userDeptAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'userDept'}
            }
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
            , {label: '家具照片', name: 'furniturePhoto', width: 150}
            , {label: '家具状态id', name: 'furnitureState', width: 75, hidden: true}
            , {
                label: '家具状态',
                name: 'furnitureStateName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'furnitureState',
                    value: furnitureStateData
                }
            }
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
                label: '质保截止日期',
                name: 'guaranteeDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
        ];
        var surl = "platform/assets/furniture/assetsfurniturerepairproc/assetsFurnitureRepairProcController/operation/sub/";
        var assetsFurnitureRepairSub = new AssetsFurnitureRepairSub('assetsFurnitureRepairSub', surl,
            "formSub",
            assetsFurnitureRepairSubGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsFurnitureRepairSub_keyWord', isReload);
        //创建业务操作JS
        var assetsFurnitureRepairProcDetail = new AssetsFurnitureRepairProcDetail('form', assetsFurnitureRepairSub);
        //创建流程操作JS
        new FlowEditor(assetsFurnitureRepairProcDetail);

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

        //绑定表单验证规则
        assetsFurnitureRepairProcDetail.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=pid%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //添加按钮绑定事件
        $('#assetsFurnitureRepairSub_insert').bind('click', function () {
            assetsFurnitureRepairSub.insert();
        });
        //删除按钮绑定事件
        $('#assetsFurnitureRepairSub_del').bind('click', function () {
            assetsFurnitureRepairSub.del();
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
</script>
</body>
</html>