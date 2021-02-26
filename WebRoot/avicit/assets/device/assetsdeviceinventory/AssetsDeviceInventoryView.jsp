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
    <!-- ControllerPath = "assets/device/assetsdeviceinventory/assetsDeviceInventoryController/operation/Edit/id" -->
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style type="text/css">
        #t_assetsDeviceInventorySub {
            display: none;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsDeviceInventoryDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsDeviceInventoryDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="inventoryName">盘点名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="inventoryName" id="inventoryName"
                           readonly="readonly" value="<c:out  value='${assetsDeviceInventoryDTO.inventoryName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="inventoryId">盘点单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="inventoryId" id="inventoryId"
                           readonly="readonly" value="<c:out  value='${assetsDeviceInventoryDTO.inventoryId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByPersonAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPerson" name="createdByPerson"
                               value="<c:out  value='${assetsDeviceInventoryDTO.createdByPerson}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias"
                               readonly="readonly" name="createdByPersonAlias"
                               value="<c:out  value='${assetsDeviceInventoryDTO.createdByPersonAlias}'/>">
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
                               value="<c:out  value='${assetsDeviceInventoryDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               readonly="readonly" name="createdByDeptAlias"
                               value="<c:out  value='${assetsDeviceInventoryDTO.createdByDeptAlias}'/>">
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
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceInventoryDTO.createDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="beginDate">基准日:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDate" id="beginDate"
                               readonly="readonly"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceInventoryDTO.beginDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <table id="assetsDeviceInventorySub"></table>
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
<script type="text/javascript" src="avicit/assets/device/assetsdeviceinventory/js/AssetsDeviceInventorySub.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var deviceStateData = ${deviceStateData};
    var inventoryStateData = ${inventoryStateData};
    var inventoryResultData = ${inventoryResultData};
    var assetsDeviceInventorySub;
    var assetsDeviceInventorySubGridColModel = [
        {label: 'id', name: 'id', key: true, width: 75, hidden: true}
        , {label: '统一编号', name: 'unifiedId', width: 150, editable: false}
        , {label: '设备ID', name: 'deviceId', width: 150, editable: false}
        , {label: '资产编号', name: 'assetId', width: 150, editable: false}
        , {label: '设备名称', name: 'deviceName', width: 150, editable: false}
        , {label: '设备型号', name: 'deviceModel', width: 150, editable: false}
        , {label: '设备规格', name: 'deviceSpec', width: 150, editable: false}
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
        , {label: '生产厂家', name: 'manufacturerId', width: 150, editable: false}
        , {label: '供应商', name: 'supplier', width: 150, editable: false}
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
        , {label: '设备状态id', name: 'deviceState', width: 75, hidden: true}
        , {
            label: '设备状态',
            name: 'deviceStateName',
            width: 150,
            editable: false,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'deviceState',
                value: deviceStateData
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
        var pid = "${assetsDeviceInventoryDTO.id}";
        var isReload = "edit";
        var searchSubNames = "";
        var surl = "platform/assets/device/assetsdeviceinventory/assetsDeviceInventoryController/operation/sub/";
        assetsDeviceInventorySub = new AssetsDeviceInventorySub('assetsDeviceInventorySub', surl,
            "formSub",
            assetsDeviceInventorySubGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsDeviceInventorySub_keyWord', isReload);
        $('.date-picker').datepicker();
        $('.time-picker').datetimepicker({
            oneLine: true,//单行显示时分秒
            closeText: '确定',//关闭按钮文案
            showButtonPanel: true,//是否展示功能按钮面板
            showSecond: false,//是否可以选择秒，默认否
        });

        parent.assetsDeviceInventory.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsDeviceInventoryDTO.id}',
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