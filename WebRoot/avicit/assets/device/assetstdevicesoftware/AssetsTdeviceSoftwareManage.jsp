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
    <!-- ControllerPath = "assets/device/assetstdevicesoftware/assetsTdeviceSoftwareController/toAssetsTdeviceSoftwareManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceSoftware_button_add"
                               permissionDes="添加">
            <a id="assetsTdeviceSoftware_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceSoftware_button_del"
                               permissionDes="删除">
            <a id="assetsTdeviceSoftware_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceSoftware_button_save"
                               permissionDes="保存">
            <a id="assetsTdeviceSoftware_save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="保存"><i class="fa fa-file-text-o"></i> 保存</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTdeviceSoftware_button_edit"
                               permissionDes="编辑">
            <a id="assetsTdeviceSoftware_edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <div class="input-group form-tool-search">
            <input type="text" name="assetsTdeviceSoftware_keyWord" id="assetsTdeviceSoftware_keyWord"
                   style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsTdeviceSoftware_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsTdeviceSoftware_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"
               role="button">高级查询 <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsTdeviceSoftwarejqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
                <th width="10%">软件名称:</th>
                <td width="15%">
                    <input title="软件名称" class="form-control input-sm" type="text" name="softwareName"
                           id="softwareName"/>
                </td>
                <th width="10%">软件简称:</th>
                <td width="15%">
                    <input title="软件简称" class="form-control input-sm" type="text" name="softwareBasicName"
                           id="softwareBasicName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">CSCI标识:</th>
                <td width="15%">
                    <input title="CSCI标识" class="form-control input-sm" type="text" name="softwareId" id="softwareId"/>
                </td>
                <th width="10%">软件代号:</th>
                <td width="15%">
                    <input title="软件代号" class="form-control input-sm" type="text" name="softwareCode"
                           id="softwareCode"/>
                </td>
                <th width="10%">软件版本:</th>
                <td width="15%">
                    <input title="软件版本" class="form-control input-sm" type="text" name="softwareVersion"
                           id="softwareVersion"/>
                </td>
                <th width="10%">软件发布号:</th>
                <td width="15%">
                    <input title="软件发布号" class="form-control input-sm" type="text" name="softwareReleaseNum"
                           id="softwareReleaseNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">研制阶段:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="softwarePeriod" id="softwarePeriod"
                                  title="研制阶段" isNull="true" lookupCode="DEVELOPMENT_PERIOD"/>
                </td>
                <th width="10%">代码规模:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="softwareCodeSize" id="softwareCodeSize"
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
                <th width="10%">软件负责人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="softwareLeader" name="softwareLeader">
                        <input class="form-control" placeholder="请选择用户" type="text" id="softwareLeaderAlias"
                               name="softwareLeaderAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">编码语言:</th>
                <td width="15%">
                    <input title="编码语言" class="form-control input-sm" type="text" name="softwareLanguage"
                           id="softwareLanguage"/>
                </td>
            </tr>
            <tr>
                <th width="10%">运行环境:</th>
                <td width="15%">
                    <input title="运行环境" class="form-control input-sm" type="text" name="softwareRunEnvironment"
                           id="softwareRunEnvironment"/>
                </td>
                <th width="10%">开发环境:</th>
                <td width="15%">
                    <input title="开发环境" class="form-control input-sm" type="text" name="softwareDevEnvironment"
                           id="softwareDevEnvironment"/>
                </td>
                <th width="10%">备注:</th>
                <td width="15%">
                    <input title="备注" class="form-control input-sm" type="text" name="remarks" id="remarks"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/assetstdevicesoftware/js/AssetsTdeviceSoftware.js" type="text/javascript"></script>
<script type="text/javascript">
    //获取后台传递的统一编号
    unifiedId = ${unifiedId};

    //后台获取的通用代码数据
    var softwarePeriodData = ${softwarePeriodData};
    var assetsTdeviceSoftware;
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '<span style="color:red;">*</span>统一编号', name: 'unifiedId', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>设备名称', name: 'deviceName', width: 150, editable: true}
            , {label: '<span style="color:red;">*</span>软件名称', name: 'softwareName', width: 150, editable: true}
            , {label: '软件简称', name: 'softwareBasicName', width: 150, editable: true}
            , {label: 'CSCI标识', name: 'softwareId', width: 150, editable: true}
            , {label: '软件代号', name: 'softwareCode', width: 150, editable: true}
            , {label: '软件版本', name: 'softwareVersion', width: 150, editable: true}
            , {label: '软件发布号', name: 'softwareReleaseNum', width: 150, editable: true}
            , {label: '研制阶段id', name: 'softwarePeriod', width: 75, hidden: true}
            , {
                label: '研制阶段',
                name: 'softwarePeriodName',
                width: 150,
                editable: true,
                edittype: "custom",
                editoptions: {
                    custom_element: selectElem1,
                    custom_value: selectValue1,
                    forId: 'softwarePeriod',
                    value: softwarePeriodData
                }
            }
            , {
                label: '代码规模',
                name: 'softwareCodeSize',
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
                label: '软件负责人',
                name: 'softwareLeaderAlias',
                width: 150,
                editable: true,
                edittype: 'custom',
                editoptions: {custom_element: userElem, custom_value: userValue, forId: 'softwareLeader'}
            }
            , {label: '软件负责人id', name: 'softwareLeader', width: 75, hidden: true, editable: false}
            , {label: '编码语言', name: 'softwareLanguage', width: 150, editable: true}
            , {label: '运行环境', name: 'softwareRunEnvironment', width: 150, editable: true}
            , {label: '开发环境', name: 'softwareDevEnvironment', width: 150, editable: true}
            , {label: '备注', name: 'remarks', width: 150, editable: true}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        searchNames.push("deviceName");
        searchTips.push("设备名称");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsTdeviceSoftware_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsTdeviceSoftware = new AssetsTdeviceSoftware('assetsTdeviceSoftwarejqGrid', '${url}', 'searchDialog', 'form', 'assetsTdeviceSoftware_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsTdeviceSoftware_insert').bind('click', function () {
            assetsTdeviceSoftware.insert();
        });
        //删除按钮绑定事件
        $('#assetsTdeviceSoftware_del').bind('click', function () {
            assetsTdeviceSoftware.del();
        });
        //保存按钮绑定事件
        $('#assetsTdeviceSoftware_save').bind('click', function () {
            assetsTdeviceSoftware.save();
        });
        //编辑按钮绑定事件
        $('#assetsTdeviceSoftware_edit').bind('click', function () {
            assetsTdeviceSoftware.edit();
        });
        //查询按钮绑定事件
        $('#assetsTdeviceSoftware_searchPart').bind('click', function () {
            assetsTdeviceSoftware.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsTdeviceSoftware_searchAll').bind('click', function () {
            assetsTdeviceSoftware.openSearchForm(this);
        });
        //回车键查询
        $('#assetsTdeviceSoftware_keyWord').on('keydown', function (e) {
            if (e.keyCode == 13) {
                assetsTdeviceSoftware.searchByKeyWord();
            }
        });
        $('#softwareLeaderAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'softwareLeader', textFiled: 'softwareLeaderAlias'});
            this.blur();
            nullInput(e);
        });

        //给子表搜索框赋值（统一编号）
        $("#assetsTdeviceSoftware_keyWord").val(unifiedId);

    });
</script>
</html>