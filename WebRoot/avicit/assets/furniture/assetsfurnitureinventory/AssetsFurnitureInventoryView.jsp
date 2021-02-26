<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form,fileupload";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/furniture/assetsfurnitureinventory/assetsFurnitureInventoryController/operation/Edit/id" -->
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style type="text/css">
        #t_assetsFurnitureInventorySub {
            display: none;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsFurnitureInventoryDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsFurnitureInventoryDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="inventoryName">盘点名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="inventoryName" id="inventoryName"
                           readonly="readonly" value="<c:out  value='${assetsFurnitureInventoryDTO.inventoryName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="inventoryId">盘点单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="inventoryId" id="inventoryId"
                           readonly="readonly" value="<c:out  value='${assetsFurnitureInventoryDTO.inventoryId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByPersonAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPerson" name="createdByPerson"
                               value="<c:out  value='${assetsFurnitureInventoryDTO.createdByPerson}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias"
                               readonly="readonly" name="createdByPersonAlias"
                               value="<c:out  value='${assetsFurnitureInventoryDTO.createdByPersonAlias}'/>">
                        <span class="input-group-addon">
												 <i class="glyphicon glyphicon-user"></i>
											  </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsFurnitureInventoryDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               readonly="readonly" name="createdByDeptAlias"
                               value="<c:out  value='${assetsFurnitureInventoryDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
								          </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createDate">创建日期:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createDate" id="createDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsFurnitureInventoryDTO.createDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="beginDate">基准日:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDate" id="beginDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsFurnitureInventoryDTO.beginDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <table id="assetsFurnitureInventorySub"></table>
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
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript"
        src="avicit/assets/furniture/assetsfurnitureinventory/js/AssetsFurnitureInventorySub.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var furnitureCategoryData = ${furnitureCategoryData};
    var furnitureStateData = ${furnitureStateData};
    var inventoryStateData = ${inventoryStateData};
    var inventoryResultData = ${inventoryResultData};
    var assetsFurnitureInventorySub;
    var assetsFurnitureInventorySubGridColModel = [
        {label: 'id', name: 'id', key: true, width: 75, hidden: true}
        , {label: '<span style="color:red;">*</span>家具ID', name: 'furnitureId', width: 150, editable: false}
        , {label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150, editable: false}
        , {label: '资产编号', name: 'assetId', width: 150, editable: false}
        , {label: '家具名称', name: 'furnitureName', width: 150, editable: false}
        , {label: '家具分类id', name: 'furnitureCategory', width: 75, hidden: true}
        , {
            label: '家具分类',
            name: 'furnitureCategoryName',
            width: 150,
            editable: false,
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
            editable: false,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'ownerId'}
        }
        , {label: '责任人id', name: 'ownerId', width: 75, hidden: true, editable: false}
        , {
            label: '责任人部门',
            name: 'ownerDeptAlias',
            width: 150,
            editable: false,
            edittype: 'custom',
            editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'ownerDept'}
        }
        , {label: '责任人部门id', name: 'ownerDept', width: 75, hidden: true, editable: false}
        , {
            label: '立卡日期',
            name: 'createdDate',
            width: 150,
            editable: false,
            edittype: 'custom',
            formatter: format,
            editoptions: {custom_element: dateElem, custom_value: dateValue}
        }
        , {label: '安装地点ID', name: 'positionId', width: 150, editable: false}
        , {label: '生产厂家', name: 'manufacturerId', width: 150, editable: false}
        , {
            label: '原值',
            name: 'originalValue',
            width: 150,
            editable: false,
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
            editable: false,
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
            editable: false,
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
            editable: false,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'inventoryPerson'}
        }
        , {label: '盘点人id', name: 'inventoryPerson', width: 75, hidden: true, editable: false}
        , {
            label: '盘点人部门',
            name: 'inventoryDeptAlias',
            width: 150,
            editable: false,
            edittype: 'custom',
            editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'inventoryDept'}
        }
        , {label: '盘点人部门id', name: 'inventoryDept', width: 75, hidden: true, editable: false}
        , {
            label: '盘点时间',
            name: 'inventoryDate',
            width: 150,
            editable: false,
            edittype: 'custom',
            formatter: format,
            editoptions: {custom_element: dateElem, custom_value: dateValue}
        }
        , {
            label: '备注',
            name: 'remarks',
            width: 150,
            editable: false,
            edittype: "textarea",
            editoptions: {rows: '1', maxlength: "1024"}
        }
        , {label: '标志位', name: 'flag', width: 150, editable: false}
        , {label: '盘点状态id', name: 'inventoryState', width: 75, hidden: true}
        , {
            label: '盘点状态',
            name: 'inventoryStateName',
            width: 150,
            editable: false,
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
            editable: false,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'inventoryResult',
                value: inventoryResultData
            }
        }
    ];
    $(document).ready(function () {
        var pid = "${assetsFurnitureInventoryDTO.id}";
        var isReload = "edit";
        var searchSubNames = "";
        var surl = "platform/assets/furniture/assetsfurnitureinventory/assetsFurnitureInventoryController/operation/sub/";
        assetsFurnitureInventorySub = new AssetsFurnitureInventorySub('assetsFurnitureInventorySub', surl,
            "formSub",
            assetsFurnitureInventorySubGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsFurnitureInventorySub_keyWord', isReload);
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
        });

        parent.assetsFurnitureInventory.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsFurnitureInventoryDTO.id}',
            allowAdd: false,
            allowDelete: false
        });
    });
    //form控件禁用
    setFormDisabled();
    $(document).keydown(function (event) {
        event.returnValue = false;
        return false;
    });
</script>
</body>
</html>