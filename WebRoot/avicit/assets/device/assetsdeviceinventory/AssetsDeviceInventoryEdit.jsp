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
                           value="<c:out  value='${assetsDeviceInventoryDTO.inventoryName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="inventoryId">盘点单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="inventoryId" id="inventoryId"
                           value="<c:out  value='${assetsDeviceInventoryDTO.inventoryId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByPersonAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPerson" name="createdByPerson"
                               value="<c:out  value='${assetsDeviceInventoryDTO.createdByPerson}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias"
                               name="createdByPersonAlias"
                               value="<c:out  value='${assetsDeviceInventoryDTO.createdByPersonAlias}'/>"
                               readonly="readonly">
                        <span class="input-group-addon" id="userbtn">
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
                               name="createdByDeptAlias"
                               value="<c:out  value='${assetsDeviceInventoryDTO.createdByDeptAlias}'/>"
                               readonly="readonly">
                        <span class="input-group-addon" id="deptbtn">
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
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceInventoryDTO.createDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="beginDate">基准日:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDate" id="beginDate"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceInventoryDTO.beginDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <div id="toolbar_assetsDeviceInventorySub" class="toolbar">
                        <div class="toolbar-left">
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_assetsDeviceInventorySub_button_add"
                                                   permissionDes="添加">
                                <a id="assetsDeviceInventorySub_insert" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button"
                                   title="添加"><i class="fa fa-plus"></i> 添加</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_assetsDeviceInventorySub_button_delete"
                                                   permissionDes="删除">
                                <a id="assetsDeviceInventorySub_del" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button"
                                   title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3" domainObject="assetsDeviceInventorySub_button_exp"
                                                   permissionDes="导出">
                                <a id="assetsDeviceInventorySub_exp" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button" title="导出"><i
                                        class="fa fa-plus"></i>
                                    导出</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3" domainObject="assetsDeviceInventorySub_button_imp"
                                                   permissionDes="导入">
                                <a id="assetsDeviceInventorySub_imp" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button" title="导入"><i
                                        class="fa fa-file-text-o"></i> 导入</a>
                            </sec:accesscontrollist>
                        </div>
                        <div class="toolbar-right">
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="assetsDeviceInventorySub_button_creatInventoryResult"
                                                   permissionDes="生成盘点结果">
                                <a id="assetsDeviceInventorySub_creatInventoryResult" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button" title="生成盘点结果"><i
                                        class="fa fa-file-text-o"></i> 生成盘点结果</a>
                            </sec:accesscontrollist>
                        </div>
                    </div>
                    <table id="assetsDeviceInventorySub"></table>
                    <div id="assetsDeviceInventorySubPager"></div>
                </th>
            </tr>
            <%--            <tr>--%>
            <%--                <th><label for="attachment">附件</label></th>--%>
            <%--                <td colspan="<%=4 * 2 - 1%>">--%>
            <%--                    <div id="attachment" class="attachment_div eform_mutiattach_auth"></div>--%>
            <%--                </td>--%>
            <%--            </tr>--%>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                       title="保存" id="assetsDeviceInventory_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsDeviceInventory_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/assets/device/assetsdeviceinventory/js/AssetsDeviceInventorySub.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdeviceinventory/js/AssetsDeviceInventoryDetail.js"></script>
<script type="text/javascript" src="avicit/assets/device/assetsdeviceinventory/js/AssetsDeviceInventory.js"></script>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var deviceStateData = ${deviceStateData};
    var inventoryStateData = ${inventoryStateData};
    var inventoryResultData = ${inventoryResultData};
    var afterUploadEvent = null;
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
        , {label: '标志位', name: 'flag', width: 150, editable: true, hidden: true}
        , {label: '盘点状态id', name: 'inventoryState', width: 75, hidden: true}
        , {
            label: '盘点状态',
            name: 'inventoryStateName',
            width: 150,
            editable: true,
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

    function closeForm() {
        parent.assetsDeviceInventory.closeDialog(window.name);
    }

    function saveForm() {
        //主表表单校验
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        // //子表校验
        // var msg = assetsDeviceInventorySub.valid();
        // if (msg && msg != "") {
        //     layer.alert(msg, {
        //         icon: 7,
        //         area: ['400px', ''], //宽高
        //         closeBtn: 0,
        //         btn: ['关闭'],
        //         title: "提示"
        //     });
        //     return false;
        // }

        //子表数据
        $(assetsDeviceInventorySub._datagridId).jqGrid('endEditCell');
        var dataSubVo = $(assetsDeviceInventorySub._datagridId).jqGrid('getRowData');
        var dataSub = JSON.stringify(dataSubVo);

        //验证附件密级
        // var files = $('#attachment').uploaderExt('getUploadFiles');
        // for (var i = 0; i < files.length; i++) {
        //     var name = files[i].name;
        //     var secretLevel = files[i].secretLevel;
        //     //这里验证密级
        // }
        //限制保存按钮多次点击
        $('#assetsDeviceInventory_saveForm').addClass('disabled').unbind("click");
        parent.assetsDeviceInventory.save($('#form'), window.name, dataSub);
    }

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
            beforeShow: function (selectedDate) {
                if ($('#' + selectedDate.id).val() == "") {
                    $(this).datetimepicker("setDate", new Date());
                    $('#' + selectedDate.id).val('');
                }
            }
        });

        parent.assetsDeviceInventory.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsDeviceInventoryDTO.id}',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //保存按钮绑定事件
        $('#assetsDeviceInventory_saveForm').bind('click', function () {
            saveForm();
            // assetsDeviceInventoryDetail.save();
        });
        //返回按钮绑定事件
        $('#assetsDeviceInventory_closeForm').bind('click', function () {
            closeForm();
        });
        // //添加按钮绑定事件
        // $('#assetsDeviceInventorySub_insert').bind('click', function () {
        //     assetsDeviceInventorySub.insert();
        // });
        //添加按钮绑定事件
        $('#assetsDeviceInventorySub_insert').bind('click', function () {
            // assetsTransferprocDevice.insert();
            var param = JSON.stringify({unifiedId: "Z555555"});
            openProductModelLayer_DeviceInventory("false", "", "callBackFn", "");
        });
        //删除按钮绑定事件
        $('#assetsDeviceInventorySub_del').bind('click', function () {
            assetsDeviceInventorySub.del();
        });

        // $('#createdByPersonAlias').on('focus', function (e) {
        //     new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPerson', textFiled: 'createdByPersonAlias'});
        //     this.blur();
        //     nullInput(e);
        // });
        //
        // $('#createdByDeptAlias').on('focus', function (e) {
        //     new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
        //     this.blur();
        //     nullInput(e);
        // });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);

        //excel文件导出事件
        $("#assetsDeviceInventorySub_exp").bind("click", function () {
            layer.confirm("是否确认导出Excel文件?", {
                btn: ['确定', '取消']
            }, function () {
                // layer.close(confirm);
                debugger;
                //封装参数
                // var rowsParent=$("#dynReconMsg").jqGrid("getRowData");//修改参数，主表单id
                var rows = $("#assetsDeviceInventorySub").jqGrid("getRowData");//修改参数，子表单id
                var rownum = $("#assetsDeviceInventorySub").jqGrid('getGridParam', 'colModel')//修改参数，子表单id
                // varcolumnFieldsOptions = getGridColumnFieldsOptions('dgUser');
                // vardataGridFields = JSON.stringify(columnFieldsOptions[0]);
                var dataGridFields = JSON.stringify(rownum);
                var expSearchParams = {};
                expSearchParams = expSearchParams ? expSearchParams : {};
                //以下参数为服务器端导出所需要的数据
                expSearchParams.dataGridFields = dataGridFields;//设置导出表头
                expSearchParams.hasRowNum = true;//是否有行号
                expSearchParams.sheetName = 'sheet1';//导出的sheet名称
                expSearchParams.unContainFields = 'id';//不需要导出的列
                expSearchParams.fileName = '设备盘点导出数据';//导出文件名
                // expSearchParams.fileName='设备盘点导出数据'+ new Date().format("yyyy-MM-dd");//导出文件名
                // expSearchParams.pid = rowsParent[0].id;
                // if(dynReconMsg.getSearchDate()){
                //     expSearchParams.param = dynReconMsg.getSearchDate();
                // }else{
                //
                // }
                expSearchParams.appid = '1';
                var url = "platform/assets/device/dynreconmsg/dynReconMsgController/operation/excel/exp";//服务器请求地址
                var ep = new exportData("xlsExport", "xlsExport", expSearchParams, url);
                ep.excuteExport();
                layer.closeAll();
            });

        });

        //生成盘点结果
        $("#assetsDeviceInventorySub_creatInventoryResult").bind("click", function () {
            debugger;
            var data = $("#assetsDeviceInventorySub").jqGrid('getRowData');
            // alert(data.length);
            for (var i = 0; i < data.length; i++) {
                switch (data[i].inventoryStateName) {
                    case "已盘点":
                    case "已盘点旧标签":
                        data[i].inventoryResultName = "盘点正常";
                        $("#assetsDeviceInventorySub").jqGrid("setCell", data[i].id, "inventoryResultName", "盘点正常");
                        $("#assetsDeviceInventorySub").jqGrid("setCell", data[i].id, "inventoryResult", "1");
                        break;
                    case "待盘盈":
                        data[i].inventoryResultName = "盘盈";
                        $("#assetsDeviceInventorySub").jqGrid("setCell", data[i].id, "inventoryResultName", "盘盈");
                        $("#assetsDeviceInventorySub").jqGrid("setCell", data[i].id, "inventoryResult", "3");
                        break;
                    case "未盘点":
                        data[i].inventoryResultName = "暂未找到";
                        $("#assetsDeviceInventorySub").jqGrid("setCell", data[i].id, "inventoryResultName", "暂未找到");
                        $("#assetsDeviceInventorySub").jqGrid("setCell", data[i].id, "inventoryResult", "2");
                        break;
                    // default:
                    //     data[i].inventoryResultName="暂未找到";
                    //     $("#assetsDeviceInventorySub").jqGrid("setCell",data[i].id,"inventoryResultName","暂未找到");
                    //     $("#assetsDeviceInventorySub").jqGrid("setCell",data[i].id,"inventoryResult","3 ");
                    //     break;
                }
            }
        })


    });
</script>
</body>
</html>