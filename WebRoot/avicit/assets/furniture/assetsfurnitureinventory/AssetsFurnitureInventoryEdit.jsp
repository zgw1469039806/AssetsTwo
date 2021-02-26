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
                           value="<c:out  value='${assetsFurnitureInventoryDTO.inventoryName}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="inventoryId">盘点单号:</label></th>
                <td width="15%">
                    <input class="form-control input-sm" type="text" name="inventoryId" id="inventoryId"
                           value="<c:out  value='${assetsFurnitureInventoryDTO.inventoryId}'/>"/>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="createdByPersonAlias">申请人:</label></th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByPerson" name="createdByPerson"
                               value="<c:out  value='${assetsFurnitureInventoryDTO.createdByPerson}'/>">
                        <input class="form-control" placeholder="请选择用户" type="text" id="createdByPersonAlias"
                               name="createdByPersonAlias"
                               value="<c:out  value='${assetsFurnitureInventoryDTO.createdByPersonAlias}'/>">
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
                               value="<c:out  value='${assetsFurnitureInventoryDTO.createdByDept}'/>">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias"
                               name="createdByDeptAlias"
                               value="<c:out  value='${assetsFurnitureInventoryDTO.createdByDeptAlias}'/>">
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
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsFurnitureInventoryDTO.createDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%" style="word-break:break-all;word-warp:break-word;">
                    <label for="beginDate">基准日:</label></th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="beginDate" id="beginDate"
                               value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsFurnitureInventoryDTO.beginDate}'/>"/><span
                            class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="99%" colspan="<%=4 * 2 %>">
                    <div id="toolbar_assetsFurnitureInventorySub" class="toolbar">
                        <div class="toolbar-left">
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_assetsFurnitureInventorySub_button_add"
                                                   permissionDes="添加">
                                <a id="assetsFurnitureInventorySub_insert" href="javascript:void(0)"
                                   class="btn btn-default form-tool-btn btn-sm" role="button"
                                   title="添加"><i class="fa fa-plus"></i> 添加</a>
                            </sec:accesscontrollist>
                            <sec:accesscontrollist hasPermission="3"
                                                   domainObject="formdialog_assetsFurnitureInventorySub_button_delete"
                                                   permissionDes="删除">
                                <a id="assetsFurnitureInventorySub_del" href="javascript:void(0)"
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
												   domainObject="assetsFurnitureInventorySub_button_creatInventoryResult"
												   permissionDes="生成盘点结果">
								<a id="assetsFurnitureInventorySub_creatInventoryResult" href="javascript:void(0)"
								   class="btn btn-default form-tool-btn btn-sm" role="button" title="生成盘点结果"><i
										class="fa fa-file-text-o"></i> 生成盘点结果</a>
							</sec:accesscontrollist>
						</div>
                    </div>
                    <table id="assetsFurnitureInventorySub"></table>
					<div id="assetsFurnitureInventorySubPager"></div>
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
                       title="保存" id="assetsFurnitureInventory_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回"
                       id="assetsFurnitureInventory_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript" src="avicit/assets/furniture/assetsfurnitureinventory/js/AssetsFurnitureInventorySub.js"></script>
<script type="text/javascript" src="avicit/assets/furniture/assetsfurnitureinventory/js/AssetsFurnitureInventoryDetail.js"></script>
<script type="text/javascript" src="avicit/assets/furniture/assetsfurnitureinventory/js/AssetsFurnitureInventory.js"></script>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var furnitureCategoryData = ${furnitureCategoryData};
    var furnitureStateData = ${furnitureStateData};
    var inventoryStateData = ${inventoryStateData};
    var inventoryResultData = ${inventoryResultData};
    var afterUploadEvent = null;
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
        // , {label: '标志位', name: 'flag', width: 150, editable: true}
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
        parent.assetsFurnitureInventory.closeDialog(window.name);
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
        // var msg = assetsFurnitureInventorySub.valid();
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
        $(assetsFurnitureInventorySub._datagridId).jqGrid('endEditCell');
        var dataSubVo = $(assetsFurnitureInventorySub._datagridId).jqGrid('getRowData');
        var dataSub = JSON.stringify(dataSubVo);
        // //验证附件密级
        // var files = $('#attachment').uploaderExt('getUploadFiles');
        // for (var i = 0; i < files.length; i++) {
        //     var name = files[i].name;
        //     var secretLevel = files[i].secretLevel;
        //     //这里验证密级
        // }
        //限制保存按钮多次点击
        $('#assetsFurnitureInventory_saveForm').addClass('disabled').unbind("click");
        parent.assetsFurnitureInventory.save($('#form'), window.name, dataSub);
    }

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
            beforeShow: function (selectedDate) {
                if ($('#' + selectedDate.id).val() == "") {
                    $(this).datetimepicker("setDate", new Date());
                    $('#' + selectedDate.id).val('');
                }
            }
        });

        parent.assetsFurnitureInventory.formValidate($('#form'));
        //初始化附件上传组件
        $('#attachment').uploaderExt({
            formId: '${assetsFurnitureInventoryDTO.id}',
            secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
            afterUpload: function () {
                return afterUploadEvent();
            }
        });
        //保存按钮绑定事件
        $('#assetsFurnitureInventory_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#assetsFurnitureInventory_closeForm').bind('click', function () {
            closeForm();
        });
        // //添加按钮绑定事件
        // $('#assetsFurnitureInventorySub_insert').bind('click', function () {
        //     assetsFurnitureInventorySub.insert();
        // });
		$('#assetsFurnitureInventorySub_insert').bind('click', function () {
			// assetsTransferprocDevice.insert();
			var param = JSON.stringify({unifiedId: "Z555555"});
			openProductModelLayer_FurnitureInventory("false", "", "callBackFn", "");
		});
        //删除按钮绑定事件
        $('#assetsFurnitureInventorySub_del').bind('click', function () {
            assetsFurnitureInventorySub.del();
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


        //生成盘点结果
        $("#assetsFurnitureInventorySub_creatInventoryResult").bind("click", function () {
            debugger;
            var data = $("#assetsFurnitureInventorySub").jqGrid('getRowData');
            // alert(data.length);
            for (var i = 0; i < data.length; i++) {
                switch (data[i].inventoryStateName) {
                    case "已盘点":
                    case "已盘点旧标签":
                        data[i].inventoryResultName = "盘点正常";
                        $("#assetsFurnitureInventorySub").jqGrid("setCell", data[i].id, "inventoryResultName", "盘点正常");
                        $("#assetsFurnitureInventorySub").jqGrid("setCell", data[i].id, "inventoryResult", "1");
                        break;
                    case "待盘盈":
                        data[i].inventoryResultName = "盘盈";
                        $("#assetsFurnitureInventorySub").jqGrid("setCell", data[i].id, "inventoryResultName", "盘盈");
                        $("#assetsFurnitureInventorySub").jqGrid("setCell", data[i].id, "inventoryResult", "3");
                        break;
                    case "未盘点":
                        data[i].inventoryResultName = "暂未找到";
                        $("#assetsFurnitureInventorySub").jqGrid("setCell", data[i].id, "inventoryResultName", "暂未找到");
                        $("#assetsFurnitureInventorySub").jqGrid("setCell", data[i].id, "inventoryResult", "2");
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