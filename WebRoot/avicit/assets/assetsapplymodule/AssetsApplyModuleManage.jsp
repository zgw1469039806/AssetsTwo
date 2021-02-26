<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/assetsapplymodule/assetsApplyModuleController/toAssetsApplyModuleManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsApplyModule_button_add"--%>
                               <%--permissionDes="添加">--%>
            <%--<a id="assetsApplyModule_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"--%>
               <%--role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>--%>
        <%--</sec:accesscontrollist>--%>
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsApplyModule_button_del"--%>
                               <%--permissionDes="删除">--%>
            <%--<a id="assetsApplyModule_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"--%>
               <%--role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>--%>
        <%--</sec:accesscontrollist>--%>
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsApplyModule_button_save"--%>
                               <%--permissionDes="保存">--%>
            <%--<a id="assetsApplyModule_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"--%>
               <%--role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>--%>
        <%--</sec:accesscontrollist>--%>
        <%--<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsApplyModule_button_save"--%>
                               <%--permissionDes="保存">--%>
            <%--<a id="assetsApplyModule_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"--%>
               <%--role="button" title="保存"><i class="fa fa-file-text-o"></i> 派生验收单</a>--%>
        <%--</sec:accesscontrollist>--%>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsApplyModule_keyWord" id="assetsApplyModule_keyWord" style="width:240px;"
                   class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsApplyModule_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsApplyModule_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button"
               title="高级查询">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsApplyModulejqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">是否被合同管关联 :</th>
                <td width="15%">
                    <input title="是否被合同关联 " class="form-control input-sm" type="text" name="isContractRelated"
                           id="isContractRelated"/>
                </td>
                <th width="10%">申购类型 :</th>
                <td width="15%">
                    <input title="申购类型 " class="form-control input-sm" type="text" name="applyType" id="applyType"/>
                </td>
                <th width="10%">申购id :</th>
                <td width="15%">
                    <input title="申购id " class="form-control input-sm" type="text" name="applyId" id="applyId"/>
                </td>
                <th width="10%">申购设备名称 :</th>
                <td width="15%">
                    <input title="申购设备名称 " class="form-control input-sm" type="text" name="applyDeviceName"
                           id="applyDeviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">申购数量 :</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="applyNum" id="applyNum"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">申购单价 :</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="applyPrice" id="applyPrice"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">申购设备规格 :</th>
                <td width="15%">
                    <input title="申购设备规格 " class="form-control input-sm" type="text" name="applySpec" id="applySpec"/>
                </td>
                <th width="10%">申购设备型号 :</th>
                <td width="15%">
                    <input title="申购设备型号 " class="form-control input-sm" type="text" name="applyModel" id="applyModel"/>
                </td>
            </tr>
            <tr>
                <th width="10%">申购制造商 :</th>
                <td width="15%">
                    <input title="申购制造商 " class="form-control input-sm" type="text" name="applyManufacturer"
                           id="applyManufacturer"/>
                </td>
                <th width="10%">合同ID :</th>
                <td width="15%">
                    <input title="合同ID " class="form-control input-sm" type="text" name="contractId" id="contractId"/>
                </td>
                <th width="10%">合同编号 :</th>
                <td width="15%">
                    <input title="合同编号 " class="form-control input-sm" type="text" name="contractNum" id="contractNum"/>
                </td>
                <th width="10%">合同名称 :</th>
                <td width="15%">
                    <input title="合同名称 " class="form-control input-sm" type="text" name="contractName"
                           id="contractName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">合同金额 :</th>
                <td width="15%">
                    <input title="合同金额 " class="form-control input-sm" type="text" name="contractTotalPrice"
                           id="contractTotalPrice"/>
                </td>
                <th width="10%">合同供应商 :</th>
                <td width="15%">
                    <input title="合同供应商 " class="form-control input-sm" type="text" name="contractSupplier"
                           id="contractSupplier"/>
                </td>
                <th width="10%">合同经办人 :</th>
                <td width="15%">
                    <input title="合同经办人 " class="form-control input-sm" type="text" name="contractOperator"
                           id="contractOperator"/>
                </td>
                <th width="10%">合同设备名称 :</th>
                <td width="15%">
                    <input title="合同设备名称 " class="form-control input-sm" type="text" name="contractDeviceName"
                           id="contractDeviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">合同设备数量 :</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="contractDeviceNum" id="contractDeviceNum"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-0)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">合同设备单价 :</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="contractDevicePrice" id="contractDevicePrice"
                               data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">合同设备金额 :</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="contractDeviceTotalPrice"
                               id="contractDeviceTotalPrice" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
												    <a href="javascript:;" class="spin-up" data-spin="up"><i
                                                            class="glyphicon glyphicon-triangle-top"></i></a>
												    <a href="javascript:;" class="spin-down" data-spin="down"><i
                                                            class="glyphicon glyphicon-triangle-bottom"></i></a>
												  </span>
                    </div>
                </td>
                <th width="10%">合同设备规格 :</th>
                <td width="15%">
                    <input title="合同设备规格 " class="form-control input-sm" type="text" name="contractSpec"
                           id="contractSpec"/>
                </td>
            </tr>
            <tr>
                <th width="10%">合同设备型号 :</th>
                <td width="15%">
                    <input title="合同设备型号 " class="form-control input-sm" type="text" name="contractModel"
                           id="contractModel"/>
                </td>
                <th width="10%">合同制造商 :</th>
                <td width="15%">
                    <input title="合同制造商 " class="form-control input-sm" type="text" name="contractManufacturer"
                           id="contractManufacturer"/>
                </td>
                <th width="10%">合同执行状态 :</th>
                <td width="15%">
                    <input title="合同执行状态 " class="form-control input-sm" type="text" name="contractState"
                           id="contractState"/>
                </td>
                <th width="10%">是否派生验收:</th>
                <td width="15%">
                    <input title="是否派生验收" class="form-control input-sm" type="text" name="isDerive" id="isDerive"/>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/assetsapplymodule/js/AssetsApplyModule.js" type="text/javascript"></script>
<script type="text/javascript">
    //后台获取的通用代码数据
    var assetsApplyModule;
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '申购类型 ', name: 'applyType', width: 150, editable: true}
            // , {label: '申购id ', name: 'applyId', width: 150, editable: true}
            , {label: '申购设备名称 ', name: 'applyDeviceName', width: 150, editable: true}
            , {
                label: '申购数量 ',
                name: 'applyNum',
                width: 150,
                editable: true,
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
                label: '申购单价 ',
                name: 'applyPrice',
                width: 150,
                editable: true,
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
            , {label: '申购设备规格 ', name: 'applySpec', width: 150, editable: true}
            , {label: '申购设备型号 ', name: 'applyModel', width: 150, editable: true}
            , {label: '申购制造商 ', name: 'applyManufacturer', width: 150, editable: true}
            // , {label: '合同ID ', name: 'contractId', width: 150, editable: true}
            , {label: '合同编号 ', name: 'contractNum', width: 150, editable: true}
            , {label: '合同名称 ', name: 'contractName', width: 150, editable: true}
            , {label: '合同金额 ', name: 'contractTotalPrice', width: 150, editable: true}
            , {label: '合同供应商 ', name: 'contractSupplier', width: 150, editable: true}
            , {label: '合同经办人 ', name: 'contractOperator', width: 150, editable: true}
            , {label: '合同设备名称 ', name: 'contractDeviceName', width: 150, editable: true}
            , {
                label: '合同设备数量 ',
                name: 'contractDeviceNum',
                width: 150,
                editable: true,
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
                label: '合同设备单价 ',
                name: 'contractDevicePrice',
                width: 150,
                editable: true,
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
                label: '合同设备金额 ',
                name: 'contractDeviceTotalPrice',
                width: 150,
                editable: true,
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
            , {label: '合同设备规格 ', name: 'contractSpec', width: 150, editable: true}
            , {label: '合同设备型号 ', name: 'contractModel', width: 150, editable: true}
            , {label: '合同制造商 ', name: 'contractManufacturer', width: 150, editable: true}
            , {label: '合同执行状态 ', name: 'contractState', width: 150, editable: true}
            , {label: '是否派生验收', name: 'isDerive', width: 150, editable: true}
            , {label: '是否被合同关联 ', name: 'isContractRelated', width: 150, editable: true}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("isContractRelated");
        searchTips.push("是否被合同关联 ");
        searchNames.push("applyType");
        searchTips.push("申购类型 ");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsApplyModule_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsApplyModule = new AssetsApplyModule('assetsApplyModulejqGrid', '${url}', 'searchDialog', 'form', 'assetsApplyModule_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsApplyModule_insert').bind('click', function () {
            assetsApplyModule.insert();
        });
        //删除按钮绑定事件
        $('#assetsApplyModule_del').bind('click', function () {
            assetsApplyModule.del();
        });
        //保存按钮绑定事件
        $('#assetsApplyModule_save').bind('click', function () {
            assetsApplyModule.save();
        });
        //查询按钮绑定事件
        $('#assetsApplyModule_searchPart').bind('click', function () {
            assetsApplyModule.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsApplyModule_searchAll').bind('click', function () {
            assetsApplyModule.openSearchForm(this);
        });
        //回车键查询
        $('#assetsApplyModule_keyWord').on('keydown', function (e) {
            if (e.keyCode == 13) {
                assetsApplyModule.searchByKeyWord();
            }
        });

    });
</script>
</html>