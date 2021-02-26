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
    <!-- ControllerPath = "assets/furniture/assetsfurnitureinventory/assetsFurnitureInventoryController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <%--    <!-- 当前页 样式 -->--%>
    <%--    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/editForm.css">--%>
    <%--    <!-- 定制tab标签样式 -->--%>
    <%--    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/avictabs.css">--%>
    <%--    <!-- 流程标签 样式 -->--%>
    <%--    <link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/workflow.css">--%>
    <%--    <!-- 时间轴 样式 -->--%>
    <%--    <link rel="stylesheet" type="text/css" href="static/h5/timeliner/css/timeliner.css">--%>
    <style type="text/css">
        #t_assetsFurnitureInventorySub {
            display: none;
        }
    </style>
</head>
<body>
<%--<div class="main">--%>
<%--    <!-- 右侧工具栏 Start -->--%>
<%--    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttons.jsp" %>--%>
<%--    <!-- 右侧工具栏 End -->--%>
<%--    <!-- 正文内容 Start -->--%>
<%--    <div class="content">--%>
<%--        <!-- 简单tab Start -->--%>
<%--        <div class="avic-tab">--%>
<%--            <div class="tab-bar">--%>
<%--                <ul>--%>
<%--                    <li class="on">表单信息</li>--%>
<%--                    <li>流程跟踪</li>--%>
<%--                    <li>引用文档</li>--%>
<%--                    <li>关联流程</li>--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--            <div class="btn-bar on">--%>
<%--                <!-- 暂存 关注 正文 等流程代理的按钮 -->--%>
<%--                <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/buttonBar.jsp" %>--%>
<%--            </div>--%>
<%--            <div class="tab-panel">--%>
<%--                <div class="panel-body on">--%>
<%--                    <div class="panel-main">--%>
<div data-options="region:'center',split:true,border:false">
    <!-- 业务表单 Start -->
    <form id='form'>
        <input type="hidden" name="id" id="id"/>
        <input type="hidden" name="version" id="version"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%">
                    <label for="inventoryName">盘点名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="inventoryName"
                           id="inventoryName"/>
                </td>
                <th width="10%">
                    <label for="inventoryId">盘点单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="inventoryId"
                           id="inventoryId"/>
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
            </tr>
            <tr>
                <th width="10%">
                    <label for="createDate">创建日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createDate"
                               id="createDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">
                    <label for="beginDate">基准日:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDate"
                               id="beginDate"/><span class="input-group-addon"><i
                            class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <div id="toolbar_AssetsFurnitureInventorySub" class="toolbar">
                        <div class="toolbar-left">
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_AssetsFurnitureInventorySub_button_add"
                                                   permissionDes="添加">
                                <a id="assetsFurnitureInventorySub_insert" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                   role="button"
                                   title="添加"><i class="fa fa-plus"></i> 添加</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_AssetsFurnitureInventorySub_button_delete"
                                                   permissionDes="删除">
                                <a id="assetsFurnitureInventorySub_del" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                                   role="button"
                                   title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                            </sec:accesscontrollist>
                            <a class="btn btn-default form-tool-btn btn-sm bpm_self_class"
                               style="display:none" title="子表数据是否可编辑"
                               name="assetsFurnitureInventorySub_editable"
                               id="assetsFurnitureInventorySub_editable">是否可编辑</a>
                        </div>
                    </div>
                    <table id="assetsFurnitureInventorySub" name="ASSETS_FURNITURE_INVENTORY_SUB"
                           class="customform_subtable_bpm_auth"></table>
                    <pt6:h5resource label="家具ID" name="furnitureId"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="统一编号" name="unifiedId"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="资产编号" name="assetId"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="家具名称" name="furnitureName"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="家具分类" name="furnitureCategoryName"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="责任人" name="ownerIdAlias"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="责任人部门" name="ownerDeptAlias"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="立卡日期" name="createdDate"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="安装地点ID" name="positionId"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="生产厂家" name="manufacturerId"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="原值" name="originalValue"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="净值" name="netValue"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="家具状态" name="furnitureStateName"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="盘点人" name="inventoryPersonAlias"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="盘点人部门" name="inventoryDeptAlias"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="盘点时间" name="inventoryDate"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="备注" name="remarks"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="标志位" name="flag"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="盘点状态" name="inventoryStateName"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
                    <pt6:h5resource label="盘点结果" name="inventoryResultName"
                                    ref_table="ASSETS_FURNITURE_INVENTORY_SUB"></pt6:h5resource>
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
<div data-options="region:'south',border:false" style="height: 60px;">
	<div id="toolbar"
		 class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
		<table class="tableForm" style="border:0;cellspacing:1;width:100%">
			<tr>
				<td width="50%" style="padding-right:4%;" align="right">
					<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
					   title="保存" id="assetsFurnitureInventory_saveForm">保存</a>
					<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
					   id="assetsFurnitureInventory_closeForm">返回</a>
				</td>
			</tr>
		</table>
	</div>
</div>
<%--                </div>--%>
<%--                <div class="panel-body">--%>
<%--                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/tracks.jsp" %>--%>
<%--                </div>--%>
<%--                <div class="panel-body">--%>
<%--                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/files.jsp" %>--%>
<%--                </div>--%>
<%--                <div class="panel-body">--%>
<%--                    <%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/processlevel.jsp" %>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <!-- 简单tab End -->--%>
<%--    </div>--%>
<%--    <!-- 正文内容 End -->--%>
<%--</div>--%>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<%--<!-- 页面脚本 avictabs.js-->--%>
<%--<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/avictabs.js"></script>--%>
<%--<!-- 时间轴组件 timeliner.js-->--%>
<%--<script type="text/javascript" src="static/h5/timeliner/js/timeliner.js"></script>--%>
<%--<!-- 页面脚本 editForm.js-->--%>
<%--<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/editForm.js"></script>--%>
<%--<!-- 流程的js -->--%>
<%--<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>--%>
<%--<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowEditor.js"></script>--%>
<!-- 业务的js -->
<script type="text/javascript" src="avicit/assets/furniture/assetsfurnitureinventory/js/AssetsFurnitureInventoryDetail.js"></script>
<script type="text/javascript" src="avicit/assets/furniture/assetsfurnitureinventory/js/AssetsFurnitureInventorySub.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var furnitureCategoryData = null;
    var furnitureStateData = null;
    var inventoryStateData = null;
    var inventoryResultData = null;

    //初始化通用代码值
    function initOnceInAdd() {
        avicAjax.ajax({
            url: "platform/assets/furniture/assetsfurnitureinventory/assetsFurnitureInventoryController/getLookUpCode",
            type: 'post',
            dataType: 'json',
            async: false,
            success: function (r) {
                if (r.flag == "success") {
                    // furnitureCategoryData = JSON.parse(r.furnitureCategoryData);
                    furnitureStateData = JSON.parse(r.furnitureStateData);
                    inventoryStateData = JSON.parse(r.inventoryStateData);
                    inventoryResultData = JSON.parse(r.inventoryResultData);
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
    var assetsFurnitureInventorySubGridColModel = null;
    $(document).ready(function () {
        var pid = "<%=pid%>";
        var isReload = "true";
        var searchSubNames = "";
        initOnceInAdd(); //初始化通用代码值
        assetsFurnitureInventorySubGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '家具ID', name: 'furnitureId', width: 150}
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
                label: '立卡日期',
                name: 'createdDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
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
                label: '盘点人',
                name: 'inventoryPersonAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'inventoryPerson'}
            }
            , {label: '盘点人id', name: 'inventoryPerson', width: 75, hidden: true}
            , {
                label: '盘点人部门',
                name: 'inventoryDeptAlias',
                width: 150,
                edittype: 'custom',
                editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'inventoryDept'}
            }
            , {label: '盘点人部门id', name: 'inventoryDept', width: 75, hidden: true}
            , {
                label: '盘点时间',
                name: 'inventoryDate',
                width: 150,
                edittype: 'custom',
                formatter: format,
                editoptions: {custom_element: dateElem, custom_value: dateValue}
            }
            , {
                label: '备注',
                name: 'remarks',
                width: 150,
                edittype: "textarea",
                editoptions: {rows: '1', maxlength: "1024"}
            }
            , {label: '标志位', name: 'flag', width: 150}
            , {label: '盘点状态id', name: 'inventoryState', width: 75, hidden: true}
            , {
                label: '盘点状态',
                name: 'inventoryStateName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'inventoryState',
                    value: inventoryStateData
                }
            }
            , {label: '盘点结果id', name: 'inventoryResult', width: 75, hidden: true}
            , {
                label: '盘点结果',
                name: 'inventoryResultName',
                width: 150,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem,
                    custom_value: selectValue,
                    forId: 'inventoryResult',
                    value: inventoryResultData
                }
            }
        ];
        var surl = "platform/assets/furniture/assetsfurnitureinventory/assetsFurnitureInventoryController/operation/sub/";
        var assetsFurnitureInventorySub = new AssetsFurnitureInventorySub('assetsFurnitureInventorySub', surl,
            "formSub",
            assetsFurnitureInventorySubGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsFurnitureInventorySub_keyWord', isReload);
        //创建业务操作JS
        var assetsFurnitureInventoryDetail = new AssetsFurnitureInventoryDetail('form', assetsFurnitureInventorySub);
        //创建流程操作JS
        new FlowEditor(assetsFurnitureInventoryDetail);

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
        assetsFurnitureInventoryDetail.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '<%=pid%>',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //添加按钮绑定事件
        $('#assetsFurnitureInventorySub_insert').bind('click', function () {
            assetsFurnitureInventorySub.insert();
        });
        //删除按钮绑定事件
        $('#assetsFurnitureInventorySub_del').bind('click', function () {
            assetsFurnitureInventorySub.del();
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

    /* 关闭弹窗 */
    function closeDialog() {
        var index = parent.layer.getFrameIndex(window.name);    //获取窗口索引
        parent.layer.close(index);  // 关闭layer
    }
</script>
</body>
</html>