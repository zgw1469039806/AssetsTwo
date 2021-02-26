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
    <!-- ControllerPath = "assets/device/assetsdevicetransfer/assetsDeviceTransferController/operation/Edit/id" -->
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style type="text/css">
        #t_assetsTransferprocDevice {
            display: none;
        }
    </style>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="version" value="<c:out  value='${assetsDeviceTransferDTO.version}'/>"/>
        <input type="hidden" name="id" value="<c:out  value='${assetsDeviceTransferDTO.id}'/>"/>
        <table class="form_commonTable">
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByDeptAlias">申请人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept"
                               value="<c:out  value='${assetsDeviceTransferDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias"
                               value="<c:out  value='${assetsDeviceTransferDTO.createdByDeptAlias}'/>">
                        <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByTel">申请人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"
                           value="<c:out  value='${assetsDeviceTransferDTO.createdByTel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="formState">单据状态:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="formState" id="formState"
                           value="<c:out  value='${assetsDeviceTransferDTO.formState}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="procName">流程名称:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="procName" id="procName"
                           value="<c:out  value='${assetsDeviceTransferDTO.procName}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="receiverAlias">接收人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="receiver" name="receiver"
                               value="<c:out  value='${assetsDeviceTransferDTO.receiver}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="receiverAlias"
                               name="receiverAlias" value="<c:out  value='${assetsDeviceTransferDTO.receiverAlias}'/>">
                        <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="receiverDeptAlias">接收人部门:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="receiverDept" name="receiverDept"
                               value="<c:out  value='${assetsDeviceTransferDTO.receiverDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="receiverDeptAlias"
                               name="receiverDeptAlias"
                               value="<c:out  value='${assetsDeviceTransferDTO.receiverDeptAlias}'/>">
                        <span class="input-group-addon" id="deptbtn">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="receiverTel">接收人电话:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="receiverTel" id="receiverTel"
                           value="<c:out  value='${assetsDeviceTransferDTO.receiverTel}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="receivePositionId">接收安装地点ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="receivePositionId" id="receivePositionId"
                           value="<c:out  value='${assetsDeviceTransferDTO.receivePositionId}'/>"/>
                </td>
            </tr>
            <tr>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="transferReason">移交原因:</label></th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" name="transferReason" id="transferReason"><c:out
                            value='${assetsDeviceTransferDTO.transferReason}'/></textarea>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="procId">流程ID:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="procId" id="procId"
                           value="<c:out  value='${assetsDeviceTransferDTO.procId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByPersonAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPerson" name="createdByPerson"
                               value="<c:out  value='${assetsDeviceTransferDTO.createdByPerson}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias"
                               name="createdByPersonAlias"
                               value="<c:out  value='${assetsDeviceTransferDTO.createdByPersonAlias}'/>">
                        <span class="input-group-addon" id="userbtn">
							                     <i class="glyphicon glyphicon-user"></i>
							                   </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <div id="toolbar_assetsTransferprocDevice" class="toolbar">
                        <div class="toolbar-left">
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_assetsTransferprocDevice_button_add"
                                                   permissionDes="添加">
                                <a id="assetsTransferprocDevice_insert" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button"
                                   title="添加"><i class="fa fa-plus"></i> 添加</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_assetsTransferprocDevice_button_delete"
                                                   permissionDes="删除">
                                <a id="assetsTransferprocDevice_del" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button"
                                   title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                            </sec:accesscontrollist>
                        </div>
                    </div>
                    <table id="assetsTransferprocDevice"></table>
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
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button"
                       title="保存" id="assetsDeviceTransfer_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsDeviceTransfer_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/assets/device/assetsdevicetransfer/js/AssetsTransferprocDevice.js"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var secretLevelData = ${secretLevelData};
    var afterUploadEvent = null;
    var assetsTransferprocDevice;
    var assetsTransferprocDeviceGridColModel = [
        {label: 'id', name: 'id', key: true, width: 75, hidden: true}
        , {label: '资产编号', name: 'assetId', width: 150, editable: true}
        , {label: '设备类别', name: 'deviceCategory', width: 150, editable: true}
        , {label: '设备名称', name: 'deviceName', width: 150, editable: true}
        , {label: '设备型号', name: 'deviceModel', width: 150, editable: true}
        , {label: '设备规格', name: 'deviceSpec', width: 150, editable: true}
        , {
            label: '责任人',
            name: 'ownerIdAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'ownerId'}
        }
        , {label: '责任人id', name: 'ownerId', width: 75, hidden: true, editable: true}
        , {
            label: '责任人部门',
            name: 'ownerDeptAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'ownerDept'}
        }
        , {label: '责任人部门id', name: 'ownerDept', width: 75, hidden: true, editable: true}
        , {
            label: '使用人',
            name: 'userIdAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: userElem, custom_value: userValue, forId: 'userId'}
        }
        , {label: '使用人id', name: 'userId', width: 75, hidden: true, editable: true}
        , {
            label: '使用人部门',
            name: 'userDeptAlias',
            width: 150,
            editable: true,
            edittype: 'custom',
            editoptions: {custom_element: deptElem, custom_value: deptValue, forId: 'userDept'}
        }
        , {label: '使用人部门id', name: 'userDept', width: 75, hidden: true, editable: true}
        , {label: '生产厂家', name: 'manufacturerId', width: 150, editable: true}
        , {
            label: '立卡日期',
            name: 'createdDate',
            width: 150,
            editable: true,
            edittype: 'custom',
            formatter: format,
            editoptions: {custom_element: dateElem, custom_value: dateValue}
        }
        , {label: '安装地点ID', name: 'positionId', width: 150, editable: true}
        , {label: '密级id', name: 'secretLevel', width: 75, hidden: true}
        , {
            label: '密级',
            name: 'secretLevelName',
            width: 150,
            editable: true,
            edittype: "custom",
            editoptions: {
                custom_element: selectElem,
                custom_value: selectValue,
                forId: 'secretLevel',
                value: secretLevelData
            }
        }
        , {label: '是否统管设备', name: 'isManage', width: 150, editable: true}
        , {label: '是否在流程中', name: 'isInWorkflow', width: 150, editable: true}
        , {label: '统一编号', name: 'unifiedId', width: 150, editable: true}
    ];

    function closeForm() {
        parent.assetsDeviceTransfer.closeDialog(window.name);
    }

    function saveForm() {
        //主表表单校验
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        //子表校验
        var msg = assetsTransferprocDevice.valid();
        if (msg && msg != "") {
            layer.alert(msg, {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            });
            return false;
        }
        //子表数据
        $(assetsTransferprocDevice._datagridId).jqGrid('endEditCell');
        var dataSubVo = $(assetsTransferprocDevice._datagridId).jqGrid('getRowData');
        var dataSub = JSON.stringify(dataSubVo);
        //验证附件密级
        var files = $('#attachment').uploaderExt('getUploadFiles');
        for (var i = 0; i < files.length; i++) {
            var name = files[i].name;
            var secretLevel = files[i].secretLevel;
            //这里验证密级
        }
        //限制保存按钮多次点击
        $('#assetsDeviceTransfer_saveForm').addClass('disabled').unbind("click");
        parent.assetsDeviceTransfer.save($('#form'), window.name, dataSub);
    }

    $(document).ready(function () {
        var pid = "${assetsDeviceTransferDTO.id}";
        var isReload = "edit";
        var searchSubNames = "";
        var surl = "platform/assets/device/assetsdevicetransfer/assetsDeviceTransferController/operation/sub/";
        assetsTransferprocDevice = new AssetsTransferprocDevice('assetsTransferprocDevice', surl,
            "formSub",
            assetsTransferprocDeviceGridColModel,
            'searchDialogSub', pid, searchSubNames, 'assetsTransferprocDevice_keyWord', isReload);
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

        parent.assetsDeviceTransfer.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsDeviceTransferDTO.id}',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //保存按钮绑定事件
        $('#assetsDeviceTransfer_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsDeviceTransfer_closeForm').bind('click', function () {
            closeForm();
        });
        //添加按钮绑定事件
        $('#assetsTransferprocDevice_insert').bind('click', function () {
            assetsTransferprocDevice.insert();
        });
        //删除按钮绑定事件
        $('#assetsTransferprocDevice_del').bind('click', function () {
            assetsTransferprocDevice.del();
        });

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#receiverAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'receiver', textFiled: 'receiverAlias'});
            this.blur();
            nullInput(e);
        });

        $('#receiverDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'receiverDept', textFiled: 'receiverDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#createdByPersonAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'createdByPerson', textFiled: 'createdByPersonAlias'});
            this.blur();
            nullInput(e);
        });


        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>