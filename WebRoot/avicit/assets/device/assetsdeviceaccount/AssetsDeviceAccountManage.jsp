<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsdeviceaccount/assetsDeviceAccountController/toAssetsDeviceAccountManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

    <!-- 切换卡 样式 -->
    <%--<link rel="stylesheet" type="text/css" href="avicit/platform6/console/monitor/css/font-awesome.min.css">--%>
    <%--<link href="avicit/platform6/switch_card/yyui.css" rel="stylesheet" type="text/css">--%>
</head>
<style>
    /*.ui-jqgrid .ui-jqgrid-bdiv {*/
    /*height: 500px!important;*/
    /*}*/

    .ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td {
        text-align: center;
    }

    .ui-jqgrid .ui-jqgrid-btable {
        text-align: center;
    }

    .ui-jqgrid .ui-jqgrid-hbox {
        padding-right: 0px!important;
    }
</style>
<body>
<div style='height:965px;'>
        <div id="tableToolbar" class="toolbar">
            <div class="toolbar-left">
                <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceAccount_button_add"
                                       permissionDes="添加">
                    <a id="assetsDeviceAccount_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
                       role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
                </sec:accesscontrollist>
                <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceAccount_button_edit"
                                       permissionDes="编辑">
                    <a id="assetsDeviceAccount_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
                       role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
                </sec:accesscontrollist>
                <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsDeviceAccount_button_delete"
                                       permissionDes="删除">
                    <a id="assetsDeviceAccount_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
                       role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
                </sec:accesscontrollist>
            </div>
            <div class="toolbar-right">
                <div class="input-group form-tool-search">
                    <input type="text" name="assetsDeviceAccount_keyWord" id="assetsDeviceAccount_keyWord" style="width:240px;"
                           class="form-control input-sm" placeholder="请输入查询条件">
                    <label id="assetsDeviceAccount_searchPart" class="icon icon-search form-tool-searchicon"></label>
                </div>
                <div class="input-group-btn form-tool-searchbtn">
                    <a id="assetsDeviceAccount_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                        <span class="caret"></span></a>
                </div>
            </div>
        </div>
        <table id="assetsDeviceAccountjqGrid"></table>
        <div id="jqGridPager"></div>
    <div id="main_frame" style='width:1680px; height:40%; background-color:#FFFFFF; float:left; margin-left:5px; margin-top:5px;'>
        <!-- 列表页下方Tab页begin -->
        <div class="eform-tab"  style="margin-left: 0%; height: 100%; margin-top: 10px;" contenteditable="false">
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation active"
                    contenteditable="false"><a href="#BasicInfo" aria-controls="BasicInfo" role="tab" data-toggle="tab">基本信息</a>
                </li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#FinanceInfo" aria-controls="FinanceInfo" role="tab" data-toggle="tab">财务信息</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#ComputerInfo" aria-controls="ComputerInfo" role="tab" data-toggle="tab">计算机信息</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#MeteringInfo" aria-controls="MeteringInfo" role="tab" data-toggle="tab">计量信息</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#SafeInfoTab" aria-controls="SafeInfoTab" role="tab" data-toggle="tab">安全信息</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#Attachment" aria-controls="Attachment" role="tab" data-toggle="tab">设备附表</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#ComponentInfo" aria-controls="ComponentInfo" role="tab" data-toggle="tab">随机附件</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#MaintainInfo" aria-controls="MaintainInfo" role="tab" data-toggle="tab">年度保养</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#RegularCheckInfo" aria-controls="RegularCheckInfo" role="tab" data-toggle="tab">定期检验</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#SpotCheckInfo" aria-controls="SpotCheckInfo" role="tab" data-toggle="tab">点检信息</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#ACCCheckInfo" aria-controls="ACCCheckInfo" role="tab" data-toggle="tab">精度检查信息</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#TDeviceComponentInfo" aria-controls="TDeviceComponentInfo" role="tab" data-toggle="tab">测试设备组件</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#TDeviceSoftwareInfo" aria-controls="TDeviceSoftwareInfo" role="tab" data-toggle="tab">测试设备软件</a></li>
                <li role="presentation" onclick="$(window).trigger('resize');" class="presentation" contenteditable="false"><a
                        href="#TDeviceAppProductInfo" aria-controls="TDeviceAppProductInfo" role="tab" data-toggle="tab">测试设备适用产品</a></li>
            </ul>
            <div class="tab-content" style="height: 100%; min-height: 20px; margin-left: 0px;">
                <div role="tabpanel" class="tab-pane active" contenteditable="false" id="BasicInfo"
                     style="height: 100%; min-height: 40px; width: 85%"></div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="FinanceInfo"
                     style="height: 100%; min-height: 40px; width: 85%;">
                    <%--<table class="form_commonTable">--%>
                        <%--<tr>--%>
                            <%--<!-- 资产财务类别 -->--%>
                            <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                                <%--<label for="assetsFinanceType">资产财务类别:</label></th>--%>
                            <%--<td width="15%">--%>
                                <%--<pt6:h5select css_class="form-control input-sm" name="assetsFinanceType" id="assetsFinanceType"--%>
                                              <%--title="" isNull="true" lookupCode="ASSETS_FINANCE_TYPE"--%>
                                              <%--defaultValue='${assetsDeviceAccountDTO.assetsFinanceType}'/>--%>
                            <%--</td>--%>
                            <%--<!-- 资产来源 -->--%>
                            <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                                <%--<label for="assetsSource">资产来源:</label></th>--%>
                            <%--<td width="15%">--%>
                                <%--<pt6:h5select css_class="form-control input-sm" name="assetsSource" id="assetsSource" title=""--%>
                                              <%--isNull="true" lookupCode="ASSETS_SOURCE"--%>
                                              <%--defaultValue='${assetsDeviceAccountDTO.assetsSource}'/>--%>
                            <%--</td>--%>
                            <%--<!-- 资产财务状态 -->--%>
                            <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                                <%--<label for="assetsFinanceState">资产财务状态:</label></th>--%>
                            <%--<td width="15%">--%>
                                <%--<pt6:h5select css_class="form-control input-sm" name="assetsFinanceState"--%>
                                              <%--id="assetsFinanceState"--%>
                                              <%--title="" isNull="true" lookupCode="ASSETS_FINANCE_STATE"--%>
                                              <%--defaultValue='${assetsDeviceAccountDTO.assetsFinanceState}'/>--%>
                            <%--</td>--%>
                            <%--<!-- 财务入账时间 -->--%>
                            <%--<th width="10%" style="word-break:break-all;word-warp:break-word;">--%>
                                <%--<label for="financeEntryDate">财务入账时间:</label></th>--%>
                            <%--<td width="15%">--%>
                                <%--<div class="input-group input-group-sm">--%>
                                    <%--<input class="form-control date-picker" type="text" name="financeEntryDate"--%>
                                           <%--id="financeEntryDate" readonly="readonly"--%>
                                           <%--value="<fmt:formatDate pattern="yyyy-MM-dd" value='${assetsDeviceAccountDTO.financeEntryDate}'/>"/><span--%>
                                        <%--class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>--%>
                                <%--</div>--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                    <%--</table>--%>
                </div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="ComputerInfo"
                     style="height: 100%; min-height: 40px; width: 85%"></div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="MeteringInfo"
                     style="height: 100%; min-height: 40px; width: 85%"></div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="SafeInfoTab"
                     style="height: 100%; min-height: 40px; width: 85%"></div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="Attachment"
                     style="height: 100%; min-height: 40px;">
                    <div class="ui-jqgrid " id="gbox_DYN_SUB" dir="ltr" style="width: 85%;">
                        <div class="jqgrid-overlay ui-overlay" id="lui_DYN_SUB"></div>
                        <div class="loading row" id="load_DYN_SUB" style="display: none;">读取中...</div>
                        <div class="ui-jqgrid-view table-responsive" role="grid" id="gview_DYN_SUB" style="width: 100%;">
                            <div class="ui-jqgrid-titlebar ui-jqgrid-caption" style="display: none;"><a role="link"
                                                                                                        class="ui-jqgrid-titlebar-close HeaderButton "
                                                                                                        title="切换 展开 折叠 表格"
                                                                                                        style="right: 0px;"><span
                                    class="ui-jqgrid-headlink glyphicon glyphicon-circle-arrow-up"></span></a><span
                                    class="ui-jqgrid-title"></span></div>

                            <%--<div class="ui-userdata ui-userdata-top" id="t_DYN_SUB" style="width: 100%;">--%>
                            <%--<div id="DYN_SUBToolbar" class="toolbar">--%>
                            <%--&lt;%&ndash;<div class="toolbar-left">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<a id="DYN_SUB_insertBtn" href="javascript:void(0)"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;class="btn btn-primary form-tool-btn btn-sm eform_subtable_bpm_button_auth"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;role="button" title="添加"><i class="icon icon-add"></i> 添加</a>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<a id="DYN_SUB_deleteBtn" href="javascript:void(0)"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;class="btn btn-primary form-tool-btn btn-sm eform_subtable_bpm_button_auth"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;role="button" title="删除"><i class="icon icon-delete"></i> 删除</a>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<div class="toolbar-right">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<div class="input-group form-tool-search">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<input type="text" name="DYN_SUB_keyWord" id="DYN_SUB_keyWord" style="width: 240px;"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;class="form-control input-sm" placeholder="请输入统一编号或附件名称">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<label id="DYN_SUB_searchPart" class="icon icon-search form-tool-searchicon"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;style="top: 7px;right: 5px;"></label>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<div class="input-group-btn form-tool-searchbtn" style="right: 5px;">&ndash;%&gt;--%>
                            <%--&lt;%&ndash;<a id="DYN_SUB_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm"&ndash;%&gt;--%>
                            <%--&lt;%&ndash;role="button" title="高级查询">高级查询 <span class="caret"></span></a>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                            <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                            <%--</div>--%>
                            <%--</div>--%>

                            <div class="ui-jqgrid-hdiv" style="width: 100%;">
                                <div class="ui-jqgrid-hbox">
                                    <table class="ui-jqgrid-htable ui-common-table table table-bordered" style="width: 100%;"
                                           role="presentation" aria-labelledby="gbox_DYN_SUB">
                                        <thead>
                                        <tr class="ui-jqgrid-labels" role="row">
                                            <%--<th id="DYN_SUB_cb" role="columnheader" class="ui-th-column ui-th-ltr"--%>
                                            <%--style="text-align: left; width: 35px;">--%>
                                            <%--<div class="ui-th-div" id="jqgh_DYN_SUB_cb"><input role="checkbox"--%>
                                            <%--id="cb_DYN_SUB" class="cbox"--%>
                                            <%--type="checkbox"><span--%>
                                            <%--class="s-ico" style="display:none"><span sort="asc"--%>
                                            <%--class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span--%>
                                            <%--sort="desc"--%>
                                            <%--class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>--%>
                                            <%--</div>--%>
                                            </th>
                                            <th id="DYN_SUB_ID" role="columnheader" class="ui-th-column ui-th-ltr "
                                                style=" display: none;"><span
                                                    class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                                <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_ID">ID<span
                                                        class="s-ico" style="display:none"><span sort="asc"
                                                                                                 class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                        sort="desc"
                                                        class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                                </div>
                                            </th>
                                            <th id="DYN_SUB_DATA_1" role="columnheader" class="ui-th-column ui-th-ltr"
                                                style="width: 4%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                         style="cursor: col-resize;">&nbsp;</span>
                                                <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DATA_1">序号<span
                                                        class="s-ico" style="display:none"><span sort="asc"
                                                                                                 class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                        sort="desc"
                                                        class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                                </div>
                                            </th>
                                            <th id="DYN_SUB_UNIFIED_ID" role="columnheader" class="ui-th-column ui-th-ltr"
                                                style="width: 16%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                          style="cursor: col-resize;">&nbsp;</span>
                                                <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_UNIFIED_ID"><font
                                                        color="red">*</font>统一编号<span class="s-ico" style="display:none"><span
                                                        sort="asc"
                                                        class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                        sort="desc"
                                                        class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                                </div>
                                            </th>

                                            <%--<th id="DYN_SUB_DEVICE_CATEGORYName" role="columnheader"--%>
                                            <%--class="ui-th-column ui-th-ltr" style="width: 275px;"><span--%>
                                            <%--class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>--%>
                                            <%--<div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DEVICE_CATEGORYName">--%>
                                            <%--附件类别<span class="s-ico" style="display:none"><span sort="asc"--%>
                                            <%--class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span--%>
                                            <%--sort="desc"--%>
                                            <%--class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>--%>
                                            <%--</div>--%>
                                            <%--</th>--%>
                                            <th id="DYN_SUB_DEVICE_NAME" role="columnheader" class="ui-th-column ui-th-ltr "
                                                style="width: 16%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                          style="cursor: col-resize;">&nbsp;</span>
                                                <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DEVICE_NAME">
                                                    附件名称<span class="s-ico" style="display:none"><span sort="asc"
                                                                                                       class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                        sort="desc"
                                                        class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                                </div>
                                            </th>
                                            <th id="DYN_SUB_DEVICE_MODEl" role="columnheader" class="ui-th-column ui-th-ltr "
                                                style="width: 16%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                          style="cursor: col-resize;">&nbsp;</span>
                                                <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DEVICE_MODEl">
                                                    附件型号<span class="s-ico" style="display:none"><span sort="asc"
                                                                                                       class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                        sort="desc"
                                                        class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                                </div>
                                            </th>
                                            <th id="DYN_SUB_DEVICE_SPEC" role="columnheader" class="ui-th-column ui-th-ltr"
                                                style="width: 16%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                          style="cursor: col-resize;">&nbsp;</span>
                                                <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DEVICE_SPEC">
                                                    附件规格<span class="s-ico" style="display:none"><span sort="asc"
                                                                                                       class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                        sort="desc"
                                                        class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                                </div>
                                            </th>
                                            <th id="DYN_SUB_OWNER_ID" role="columnheader" class="ui-th-column ui-th-ltr "
                                                style=" display: none;"><span
                                                    class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                                <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_OWNER_ID">责任人Id<span
                                                        class="s-ico" style="display:none"><span sort="asc"
                                                                                                 class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                        sort="desc"
                                                        class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                                </div>
                                            </th>
                                            <th id="DYN_SUB_OWNER_IDName" role="columnheader" class="ui-th-column ui-th-ltr"
                                                style="width: 16%;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
                                                                          style="cursor: col-resize;">&nbsp;</span>
                                                <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_OWNER_IDName">
                                                    责任人
                                                </div>
                                            </th>
                                            <th id="DYN_SUB_DEVICE_POSITION" role="columnheader" class="ui-th-column ui-th-ltr "
                                                style="width: 16%;"><span
                                                    class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                                <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_DEVICE_POSITION">
                                                    安装地点
                                                </div>
                                            </th>
                                            <th id="DYN_SUB_FK_SUB_COL_ID" role="columnheader" class="ui-th-column ui-th-ltr "
                                                style="display: none;"><span
                                                    class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span>
                                                <div class="ui-th-div ui-jqgrid-sortable" id="jqgh_DYN_SUB_FK_SUB_COL_ID">
                                                    外键<span class="s-ico" style="display:none"><span sort="asc"
                                                                                                     class="ui-grid-ico-sort ui-icon-asc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-top"></span><span
                                                        sort="desc"
                                                        class="ui-grid-ico-sort ui-icon-desc ui-sort-ltr ui-disabled glyphicon glyphicon-triangle-bottom"></span></span>
                                                </div>
                                            </th>
                                        </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                            <div class="ui-jqgrid-bdiv" style="height: 125px; width: 100%; max-height: 150px;">
                                <div style="position:relative;">
                                    <div></div>
                                    <table id="DYN_SUB" class="datatable ui-jqgrid-btable ui-common-table table table-bordered"
                                           datapermission="eform_data_DYN_SUB" tabindex="0" role="presentation"
                                           aria-multiselectable="true" aria-labelledby="gbox_DYN_SUB" style="width: 100%;">
                                        <tbody>
                                        <tr class="jqgfirstrow ui-priority-secondary" role="row">
                                            <%--<td role="gridcell" style="height:0px;width:35px;"></td>--%>
                                            <td role="gridcell" style="height:0px;width: 4%;display:none;"></td>
                                            <td role="gridcell" style="height: 0px; width: 4%;"></td>
                                            <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                            <td role="gridcell" style="height:0px;width:16%;display:none;"></td>
                                            <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                            <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                            <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                            <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                            <td role="gridcell" style="height:0px;width:16%;display:none;"></td>
                                            <td role="gridcell" style="height: 0px; width: 16%;"></td>
                                            <td role="gridcell" style="height:0px;width:16%;display:none;"></td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="ui-jqgrid-resize-mark" id="rs_mDYN_SUB">&nbsp;</div>

                        <%--<div id="DYN_SUBPager" class="ui-jqgrid-pager" dir="ltr" style="width: 100%;">--%>
                        <%--<div id="pg_DYN_SUBPager" class="ui-pager-control" role="group">--%>
                        <%--<table class="ui-pg-table ui-common-table ui-pager-table table">--%>
                        <%--<tbody>--%>
                        <%--<tr>--%>
                        <%--<td id="DYN_SUBPager_left" align="left" style="width: 396px;">--%>
                        <%--<table class="ui-pg-table ui-common-table ui-paging-pager">--%>
                        <%--<tbody>--%>
                        <%--<tr>--%>
                        <%--<td class="ui-pg-button ui-disabled"><span class="ui-separator"></span></td>--%>
                        <%--<td id="first_DYN_SUBPager" class="ui-pg-button ui-disabled" title="第一页"--%>
                        <%--style="cursor: default;"><span--%>
                        <%--class="glyphicon glyphicon-step-backward"></span></td>--%>
                        <%--<td id="prev_DYN_SUBPager" class="ui-pg-button ui-disabled" title="上一页">--%>
                        <%--<span class="glyphicon glyphicon-backward"></span></td>--%>
                        <%--<td class="ui-pg-button ui-disabled" style="cursor: default;"><span--%>
                        <%--class="ui-separator"></span></td>--%>
                        <%--<td id="input_DYN_SUBPager" dir="ltr">第<input--%>
                        <%--class="ui-pg-input form-control" type="text" size="2" value="0"--%>
                        <%--role="textbox">页　共<span id="sp_1_DYN_SUBPager">0</span>页--%>
                        <%--</td>--%>
                        <%--<td class="ui-pg-button ui-disabled" style="cursor: default;"><span--%>
                        <%--class="ui-separator"></span></td>--%>
                        <%--<td id="next_DYN_SUBPager" class="ui-pg-button" title="下一页"><span--%>
                        <%--class="glyphicon glyphicon-forward"></span></td>--%>
                        <%--<td id="last_DYN_SUBPager" class="ui-pg-button" title="最后一页"--%>
                        <%--style="cursor: default;"><span--%>
                        <%--class="glyphicon glyphicon-step-forward"></span></td>--%>
                        <%--<td dir="ltr"><select class="ui-pg-selbox form-control" role="listbox"--%>
                        <%--title="每页记录数">--%>
                        <%--<option role="option" value="5">5</option>--%>
                        <%--<option role="option" value="10" selected="selected">10</option>--%>
                        <%--<option role="option" value="20">20</option>--%>
                        <%--<option role="option" value="50">50</option>--%>
                        <%--<option role="option" value="100">100</option>--%>
                        <%--<option role="option" value="500">500</option>--%>
                        <%--</select></td>--%>
                        <%--</tr>--%>
                        <%--</tbody>--%>
                        <%--</table>--%>
                        <%--</td>--%>
                        <%--<td id="DYN_SUBPager_center" align="center" style="white-space:pre;display:none;"></td>--%>
                        <%--<td id="DYN_SUBPager_right" align="right">--%>
                        <%--<div dir="ltr" style="text-align:right" class="ui-paging-info">第1到第1条　共 1 条</div>--%>
                        <%--</td>--%>
                        <%--</tr>--%>
                        <%--</tbody>--%>
                        <%--</table>--%>
                        <%--</div>--%>
                        <%--</div>--%>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="ComponentInfo" style="height: 100%;">
                    <iframe name="componentIframe" id="componentIframe" src="assets/device/assetsdevicecomponent/assetsDeviceComponentController/toAssetsDeviceComponentManage" frameborder="0" align="left" width="85%" height="100%" scrolling="auto">
                    </iframe>
                </div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="MaintainInfo" style="height: 100%;">
                    <iframe name="maintainIframe" id="maintainIframe" src="assets/device/assetsdevicemaintain/assetsDeviceMaintainController/toAssetsDeviceMaintainManage" frameborder="0" align="left" width="85%" height="100%" scrolling="auto">
                    </iframe>
                </div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="RegularCheckInfo" style="height: 100%;">
                    <iframe name="regularCheckIframe" id="regularCheckIframe" src="assets/device/assetsdeviceregularcheck/assetsDeviceRegularCheckController/toAssetsDeviceRegularCheckManage" frameborder="0" align="left" width="85%" height="100%" scrolling="auto">
                    </iframe>
                </div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="SpotCheckInfo" style="height: 100%;">
                    <iframe name="spotCheckIframe" id="spotCheckIframe" src="assets/device/assetsdevicespotcheck/assetsDeviceSpotCheckController/toAssetsDeviceSpotCheckManage" frameborder="0" align="left" width="85%" height="100%" scrolling="auto">
                    </iframe>
                </div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="ACCCheckInfo" style="height: 100%;">
                    <iframe name="accCheckIframe" id="accCheckIframe" src="assets/device/assetsdeviceacccheck/assetsDeviceAccCheckController/toAssetsDeviceAccCheckManage" frameborder="0" align="left" width="85%" height="100%" scrolling="auto">
                    </iframe>
                </div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="TDeviceComponentInfo" style="height: 100%;">
                    <iframe name="tDeviceComponentIframe" id="tDeviceComponentIframe" src="assets/device/assetstdevicecomponent/assetsTdeviceComponentController/toAssetsTdeviceComponentManage" frameborder="0" align="left" width="85%" height="100%" scrolling="auto">
                    </iframe>
                </div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="TDeviceSoftwareInfo" style="height: 100%;">
                    <iframe name="tDeviceSoftwareIframe" id="tDeviceSoftwareIframe" src="assets/device/assetstdevicesoftware/assetsTdeviceSoftwareController/toAssetsTdeviceSoftwareManage" frameborder="0" align="left" width="85%" height="100%" scrolling="auto">
                    </iframe>
                </div>
                <div role="tabpanel" class="tab-pane" contenteditable="false" id="TDeviceAppProductInfo" style="height: 100%;">
                    <iframe name="tDeviceAppProductIframe" id="tDeviceAppProductIframe" src="assets/device/assetstdeviceappproduct/assetsTdeviceAppproductController/toAssetsTdeviceAppproductManage" frameborder="0" align="left" width="85%" height="100%" scrolling="auto">
                    </iframe>
                </div>

            </div>
        </div>

        <!-- 列表页下方Tab页end -->
    </div>
</div>

</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <table class="form_commonTable">
            <tr>
                <th width="10%">资产编号:</th>
                <td width="15%">
                    <input title="资产编号" class="form-control input-sm" type="text" name="assetId" id="assetId"/>
                </td>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">设备类别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory"
                                  title="设备类别" isNull="true" lookupCode="DEVICE_CATEGORY" defaultValue= "${deviceCategory}"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>
                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
                <th width="10%">责任人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias"
                               name="ownerIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">责任人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias"
                               name="ownerDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">使用人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userId" name="userId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="userIdAlias" name="userIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">使用人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="userDept" name="userDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="userDeptAlias"
                               name="userDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId"
                           id="manufacturerId"/>
                </td>
                <th width="10%">立卡日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateBegin"
                               id="createdDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">立卡日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateEnd" id="createdDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">是否统管设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isManage" id="isManage" title="是否统管设备"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否在流程中:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isInWorkflow" id="isInWorkflow" title="是否在流程中"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">统管设备状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="manageState" id="manageState" title="统管设备状态"
                                  isNull="true" lookupCode="MANAGE_STATE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceState" id="deviceState" title="设备状态"
                                  isNull="true" lookupCode="DEVICE_STATE"/>
                </td>
                <th width="10%">父级设备ID:</th>
                <td width="15%">
                    <input title="父级设备ID" class="form-control input-sm" type="text" name="parentId" id="parentId"/>
                </td>
                <th width="10%">父级设备名称:</th>
                <td width="15%">
                    <input title="父级设备名称" class="form-control input-sm" type="text" name="parentName" id="parentName"/>
                </td>
                <th width="10%">常用名:</th>
                <td width="15%">
                    <input title="常用名" class="form-control input-sm" type="text" name="commonName" id="commonName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">安装地点ID:</th>
                <td width="15%">
                    <input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">ABC分类:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="abcCategory" id="abcCategory" title="ABC分类"
                                  isNull="true" lookupCode="ABC_CATEGORY"/>
                </td>
                <th width="10%">是否军工关键设备设施:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isKeyDevice" id="isKeyDevice"
                                  title="是否军工关键设备设施" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否科研生产设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isResearch" id="isResearch" title="是否科研生产设备"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">生产国家和地区:</th>
                <td width="15%">
                    <input title="生产国家和地区" class="form-control input-sm" type="text" name="productCountry"
                           id="productCountry"/>
                </td>
                <th width="10%">制造厂:</th>
                <td width="15%">
                    <input title="制造厂" class="form-control input-sm" type="text" name="productFactory"
                           id="productFactory"/>
                </td>
                <th width="10%">供应商:</th>
                <td width="15%">
                    <input title="供应商" class="form-control input-sm" type="text" name="supplier" id="supplier"/>
                </td>
                <th width="10%">出厂日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="productDateBegin"
                               id="productDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">出厂日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="productDateEnd" id="productDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">出厂编号:</th>
                <td width="15%">
                    <input title="出厂编号" class="form-control input-sm" type="text" name="productNum" id="productNum"/>
                </td>
                <th width="10%">功率(单位：千瓦):</th>
                <td width="15%">
                    <input title="功率(单位：千瓦)" class="form-control input-sm" type="text" name="devicePower"
                           id="devicePower"/>
                </td>
                <th width="10%">重量(单位：公斤):</th>
                <td width="15%">
                    <input title="重量(单位：公斤)" class="form-control input-sm" type="text" name="deviceWeight"
                           id="deviceWeight"/>
                </td>
            </tr>
            <tr>
                <th width="10%">外形尺寸:</th>
                <td width="15%">
                    <input title="外形尺寸" class="form-control input-sm" type="text" name="deviceSize" id="deviceSize"/>
                </td>
                <th width="10%">验收时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="checkDateBegin" id="checkDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">验收时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="checkDateEnd" id="checkDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">技改项目:</th>
                <td width="15%">
                    <input title="技改项目" class="form-control input-sm" type="text" name="improveProject"
                           id="improveProject"/>
                </td>
            </tr>
            <tr>
                <th width="10%">单价(单位：元):</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice"
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
                <th width="10%">合同号:</th>
                <td width="15%">
                    <input title="合同号" class="form-control input-sm" type="text" name="contractNum" id="contractNum"/>
                </td>
                <th width="10%">申购单号:</th>
                <td width="15%">
                    <input title="申购单号" class="form-control input-sm" type="text" name="applyNum" id="applyNum"/>
                </td>
                <th width="10%">验收单号:</th>
                <td width="15%">
                    <input title="验收单号" class="form-control input-sm" type="text" name="checkNum" id="checkNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">车架号:</th>
                <td width="15%">
                    <input title="车架号" class="form-control input-sm" type="text" name="carFrameNum" id="carFrameNum"/>
                </td>
                <th width="10%">发动机号:</th>
                <td width="15%">
                    <input title="发动机号" class="form-control input-sm" type="text" name="engineNum" id="engineNum"/>
                </td>
                <th width="10%">车牌号:</th>
                <td width="15%">
                    <input title="车牌号" class="form-control input-sm" type="text" name="carNum" id="carNum"/>
                </td>
                <th width="10%">密级:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="密级"
                                  isNull="true" lookupCode="SECRET_LEVEL"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否计量:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMetering" id="isMetering" title="是否计量"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否保养:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isMaintain" id="isMaintain" title="是否保养"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否精度检查:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAccuracyCheck" id="isAccuracyCheck"
                                  title="是否精度检查" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否定检:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isRegularCheck" id="isRegularCheck"
                                  title="是否定检" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否点检:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpotCheck" id="isSpotCheck" title="是否点检"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否特种设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSpecialDevice" id="isSpecialDevice"
                                  title="是否特种设备" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否涉及安全生产:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction"
                                  title="是否涉及安全生产" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否安装:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedInstall" id="isNeedInstall" title="是否安装"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">是否计算机:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isPc" id="isPc" title="是否计算机" isNull="true"
                                  lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">设备类型:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceType" id="deviceType" title="设备类型"
                                  isNull="true" lookupCode="DEVICE_TYPE"/>
                </td>
                <th width="10%">设备启用年月(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="enableDateBegin"
                               id="enableDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">设备启用年月(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="enableDateEnd" id="enableDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">运行时间:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="runningTime" id="runningTime"
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
                <th width="10%">IP地址:</th>
                <td width="15%">
                    <input title="IP地址" class="form-control input-sm" type="text" name="ip" id="ip"/>
                </td>
                <th width="10%">MAC地址:</th>
                <td width="15%">
                    <input title="MAC地址" class="form-control input-sm" type="text" name="mac" id="mac"/>
                </td>
                <th width="10%">硬盘序列号:</th>
                <td width="15%">
                    <input title="硬盘序列号" class="form-control input-sm" type="text" name="diskNum" id="diskNum"/>
                </td>
            </tr>
            <tr>
                <th width="10%">操作系统:</th>
                <td width="15%">
                    <input title="操作系统" class="form-control input-sm" type="text" name="os" id="os"/>
                </td>
                <th width="10%">操作系统安装时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="osInstallDateBegin"
                               id="osInstallDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">操作系统安装时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="osInstallDateEnd"
                               id="osInstallDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计量文件受控号:</th>
                <td width="15%">
                    <input title="计量文件受控号" class="form-control input-sm" type="text" name="meteringId" id="meteringId"/>
                </td>
            </tr>
            <tr>
                <th width="10%">计量人员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meterman" name="meterman">
                        <input class="form-control" placeholder="请选择用户" type="text" id="metermanAlias"
                               name="metermanAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">计量时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="meteringDateBegin"
                               id="meteringDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计量时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="meteringDateEnd"
                               id="meteringDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计量周期:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="meteringCycle" id="meteringCycle"
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
            </tr>
            <tr>
                <th width="10%">上次计量日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMeteringDateBegin"
                               id="lastMeteringDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上次计量日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMeteringDateEnd"
                               id="lastMeteringDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">下次计量日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMeteringDateBegin"
                               id="nextMeteringDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">下次计量日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextMeteringDateEnd"
                               id="nextMeteringDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">计量计划员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="planMeterman" name="planMeterman">
                        <input class="form-control" placeholder="请选择用户" type="text" id="planMetermanAlias"
                               name="planMetermanAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">计量单位:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meteringDept" name="meteringDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="meteringDeptAlias"
                               name="meteringDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">计量方式:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSceneMetering" id="isSceneMetering"
                                  title="计量方式" isNull="true" lookupCode="METERING_MODE"/>
                </td>
                <th width="10%">上次保养日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMaintainDateBegin"
                               id="lastMaintainDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">上次保养日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastMaintainDateEnd"
                               id="lastMaintainDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上次精度检查日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastAccuracyCheckDateBegin"
                               id="lastAccuracyCheckDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">上次精度检查日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="lastAccuracyCheckDateEnd"
                               id="lastAccuracyCheckDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计量结论:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="meteringConclution" id="meteringConclution"
                                  title="计量结论" isNull="true" lookupCode="METERING_CONCLUTION"/>
                </td>
            </tr>
            <tr>
                <th width="10%">累计借用天数:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalBorrow" id="totalBorrow"
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
                <th width="10%">安全信息:</th>
                <td width="15%">
                    <input title="安全信息" class="form-control input-sm" type="text" name="safeInfo" id="safeInfo"/>
                </td>
                <th width="10%">设备使用费:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="useCost" id="useCost"
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
                <th width="10%">维修部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="repairDept" name="repairDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="repairDeptAlias"
                               name="repairDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">状态变动日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="stateChangeDateBegin"
                               id="stateChangeDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">状态变动日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="stateChangeDateEnd"
                               id="stateChangeDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">设备系统名称:</th>
                <td width="15%">
                    <input title="设备系统名称" class="form-control input-sm" type="text" name="deviceSysName"
                           id="deviceSysName"/>
                </td>
                <th width="10%">设备关联人员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="deviceRelatedMan" name="deviceRelatedMan">
                        <input class="form-control" placeholder="请选择用户" type="text" id="deviceRelatedManAlias"
                               name="deviceRelatedManAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">是否实验室设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isLabDevice" id="isLabDevice" title="是否实验室设备"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否固定资产:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isFixedAssets" id="isFixedAssets"
                                  title="是否固定资产" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">资产财务类别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="assetsFinanceType" id="assetsFinanceType"
                                  title="资产财务类别" isNull="true" lookupCode="ASSETS_FINANCE_TYPE"/>
                </td>
                <th width="10%">资产来源:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="assetsSource" id="assetsSource" title="资产来源"
                                  isNull="true" lookupCode="ASSETS_SOURCE"/>
                </td>
            </tr>
            <tr>
                <th width="10%">资产财务状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="assetsFinanceState" id="assetsFinanceState"
                                  title="资产财务状态" isNull="true" lookupCode="ASSETS_FINANCE_STATE"/>
                </td>
                <th width="10%">财务入账时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="financeEntryDateBegin"
                               id="financeEntryDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">财务入账时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="financeEntryDateEnd"
                               id="financeEntryDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">原值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="originalValue" id="originalValue"
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
            </tr>
            <tr>
                <th width="10%">累计折旧:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="totalDepreciation" id="totalDepreciation"
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
                <th width="10%">折旧方法:</th>
                <td width="15%">
                    <input title="折旧方法" class="form-control input-sm" type="text" name="depreciationMethod"
                           id="depreciationMethod"/>
                </td>
                <th width="10%">折旧年限:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="depreciationYear" id="depreciationYear"
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
                <th width="10%">净残值率:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netSalvageRate" id="netSalvageRate"
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
            </tr>
            <tr>
                <th width="10%">净残值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netSalvage" id="netSalvage"
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
                <th width="10%">月折旧率:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthDepreciationRate" id="monthDepreciationRate"
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
                <th width="10%">月折旧额:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthDepreciation" id="monthDepreciation"
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
                <th width="10%">年折旧率:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="yearDepreciationRate" id="yearDepreciationRate"
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
            </tr>
            <tr>
                <th width="10%">年折旧额:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="yearDepreciation" id="yearDepreciation"
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
                <th width="10%">净值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netValue" id="netValue"
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
                <th width="10%">已提月份:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthCount" id="monthCount"
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
                <th width="10%">未计提月份:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="monthRemain" id="monthRemain"
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
            </tr>
            <tr>
                <th width="10%">研究所/公司:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="instituteOrCompany" id="instituteOrCompany"
                                  title="研究所/公司" isNull="true" lookupCode="INSTITUTE_OR_COMPANY"/>
                </td>
                <th width="10%">指标信息:</th>
                <td width="15%">
                    <input title="指标信息" class="form-control input-sm" type="text" name="indexInfo" id="indexInfo"/>
                </td>
                <th width="10%">凭证编号:</th>
                <td width="15%">
                    <input title="凭证编号" class="form-control input-sm" type="text" name="proofNum" id="proofNum"/>
                </td>
                <th width="10%">是否转固:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTransFixed" id="isTransFixed" title="是否转固"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>
            <tr>
                <th width="10%">计量外送员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="meteringOuter" name="meteringOuter">
                        <input class="form-control" placeholder="请选择用户" type="text" id="meteringOuterAlias"
                               name="meteringOuterAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">适用机型:</th>
                <td width="15%">
                    <input title="适用机型" class="form-control input-sm" type="text" name="applyModel" id="applyModel"/>
                </td>
                <th width="10%">适用产品:</th>
                <td width="15%">
                    <input title="适用产品" class="form-control input-sm" type="text" name="applyProduct"
                           id="applyProduct"/>
                </td>
                <th width="10%">受测对象:</th>
                <td width="15%">
                    <input title="受测对象" class="form-control input-sm" type="text" name="testedObject"
                           id="testedObject"/>
                </td>
            </tr>
            <tr>
                <th width="10%">专业类别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="majorType" id="majorType" title="专业类别"
                                  isNull="true" lookupCode="MAJOR_TYPE"/>
                </td>
                <th width="10%">设备性质:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceNature" id="deviceNature" title="设备性质"
                                  isNull="true" lookupCode="DEVICE_NATURE"/>
                </td>
                <th width="10%">软件标识号:</th>
                <td width="15%">
                    <input title="软件标识号" class="form-control input-sm" type="text" name="softwareNum" id="softwareNum"/>
                </td>
                <th width="10%">软件设计人员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="softwareDesigner" name="softwareDesigner">
                        <input class="form-control" placeholder="请选择用户" type="text" id="softwareDesignerAlias"
                               name="softwareDesignerAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">硬件设计人员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="hardwareDesigner" name="hardwareDesigner">
                        <input class="form-control" placeholder="请选择用户" type="text" id="hardwareDesignerAlias"
                               name="hardwareDesignerAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">是否测试设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isTestDevice" id="isTestDevice" title="是否测试设备"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <th width="10%">是否需要操作证:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isNeedCertificate" id="isNeedCertificate"
                                  title="是否需要操作证"
                                  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
                <%--子表查询框--%>
                <th width="10%">测试设备组件名称:</th>
                <td width="15%">
                    <input title="测试设备组件名称" class="form-control input-sm" type="text" name="tComponentName" id="tComponentName"/>
                </td>
            </tr>
            <tr>
                <%--子表查询框--%>
                <th width="10%">测试设备软件名称:</th>
                <td width="15%">
                    <input title="测试设备软件名称" class="form-control input-sm" type="text" name="tSoftwareName" id="tSoftwareName"/>
                </td>


                <th width="10%">质保期:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="guaranteePeriod" id="guaranteePeriod"
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
                <th width="10%">质保截止日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="guaranteeDateBegin" id="guaranteeDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">质保截止日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="guaranteeDateEnd" id="guaranteeDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/assets/device/assetsdeviceaccount/js/AssetsDeviceAccount.js" type="text/javascript"></script>

<!-- 切换卡的js -->
<%--<script src="avicit/platform6/switch_card/yyui.js"></script>--%>


<script type="text/javascript">

    var assetsDeviceAccount;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsDeviceAccount.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsDeviceAccount.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    $(document).ready(function () {

        var winheight = $(window).height()*2/5;
        // $(".eform-tab").css("height",winheight);
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '序号', name: 'attribute01', width: 150}
            , {label: '资产编号', name: 'assetId', width: 150, formatter: formatValue}
            , {label: '统一编号', name: 'unifiedId', width: 150, formatter: formatValue}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150, formatter: formatValue}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            , {label: '责任人部门', name: 'ownerDeptAlias', width: 150}
            , {label: '使用人', name: 'userIdAlias', width: 150}
            , {label: '使用人部门', name: 'userDeptAlias', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '立卡日期', name: 'createdDate', width: 150, formatter: format}
            , {label: '是否统管设备', name: 'isManage', width: 150}
            , {label: '是否在流程中', name: 'isInWorkflow', width: 150}
            , {label: '统管设备状态', name: 'manageState', width: 150}
            , {label: '设备状态', name: 'deviceState', width: 150}
            // , {label: '父级设备ID', name: 'parentId', width: 150}
            // , {label: '父级设备名称', name: 'parentName', width: 150}
            // , {label: '常用名', name: 'commonName', width: 150}
            // , {label: '安装地点ID', name: 'positionId', width: 150}
            // , {label: 'ABC分类', name: 'abcCategory', width: 150}
            // , {label: '是否军工关键设备设施', name: 'isKeyDevice', width: 150}
            // , {label: '是否科研生产设备', name: 'isResearch', width: 150}
            // , {label: '生产国家和地区', name: 'productCountry', width: 150}
            // , {label: '制造厂', name: 'productFactory', width: 150}
            // , {label: '供应商', name: 'supplier', width: 150}
            // , {label: '出厂日期', name: 'productDate', width: 150, formatter: format}
            // , {label: '出厂编号', name: 'productNum', width: 150}
            // , {label: '功率(单位：千瓦)', name: 'devicePower', width: 150}
            // , {label: '重量(单位：公斤)', name: 'deviceWeight', width: 150}
            // , {label: '外形尺寸', name: 'deviceSize', width: 150}
            // , {label: '验收时间', name: 'checkDate', width: 150, formatter: format}
            // , {label: '技改项目', name: 'improveProject', width: 150}
            // , {label: '单价(单位：元)', name: 'unitPrice', width: 150}
            // , {label: '合同号', name: 'contractNum', width: 150}
            // , {label: '申购单号', name: 'applyNum', width: 150}
            // , {label: '验收单号', name: 'checkNum', width: 150}
            // , {label: '车架号', name: 'carFrameNum', width: 150}
            // , {label: '发动机号', name: 'engineNum', width: 150}
            // , {label: '车牌号', name: 'carNum', width: 150}
            // , {label: '密级', name: 'secretLevel', width: 150}
            // , {label: '是否计量', name: 'isMetering', width: 150}
            // , {label: '是否保养', name: 'isMaintain', width: 150}
            // , {label: '是否精度检查', name: 'isAccuracyCheck', width: 150}
            // , {label: '是否定检', name: 'isRegularCheck', width: 150}
            // , {label: '是否点检', name: 'isSpotCheck', width: 150}
            // , {label: '是否特种设备', name: 'isSpecialDevice', width: 150}
            // , {label: '是否涉及安全生产', name: 'isSafetyProduction', width: 150}
            // , {label: '是否安装', name: 'isNeedInstall', width: 150}
            // , {label: '是否计算机', name: 'isPc', width: 150}
            // , {label: '设备类型', name: 'deviceType', width: 150}
            // , {label: '设备启用年月', name: 'enableDate', width: 150, formatter: format}
            // , {label: '运行时间', name: 'runningTime', width: 150}
            // , {label: 'IP地址', name: 'ip', width: 150}
            // , {label: 'MAC地址', name: 'mac', width: 150}
            // , {label: '硬盘序列号', name: 'diskNum', width: 150}
            // , {label: '操作系统', name: 'os', width: 150}
            // , {label: '操作系统安装时间', name: 'osInstallDate', width: 150, formatter: format}
            // , {label: '计量文件受控号', name: 'meteringId', width: 150}
            // , {label: '计量人员', name: 'metermanAlias', width: 150}
            // , {label: '计量时间', name: 'meteringDate', width: 150, formatter: format}
            // , {label: '计量周期', name: 'meteringCycle', width: 150}
            // , {label: '上次计量日期', name: 'lastMeteringDate', width: 150, formatter: format}
            // , {label: '下次计量日期', name: 'nextMeteringDate', width: 150, formatter: format}
            // , {label: '计量计划员', name: 'planMetermanAlias', width: 150}
            // , {label: '计量单位', name: 'meteringDeptAlias', width: 150}
            // , {label: '是否现场计量', name: 'isSceneMetering', width: 150}
            // , {label: '上次保养日期', name: 'lastMaintainDate', width: 150, formatter: format}
            // , {label: '上次精度检查日期', name: 'lastAccuracyCheckDate', width: 150, formatter: format}
            // , {label: '计量结论', name: 'meteringConclution', width: 150}
            // , {label: '累计借用天数', name: 'totalBorrow', width: 150}
            // , {label: '安全信息', name: 'safeInfo', width: 150}
            // , {label: '设备使用费', name: 'useCost', width: 150}
            // , {label: '维修部门', name: 'repairDeptAlias', width: 150}
            // , {label: '状态变动日期', name: 'stateChangeDate', width: 150, formatter: format}
            // , {label: '设备系统名称', name: 'deviceSysName', width: 150}
            // , {label: '设备关联人员', name: 'deviceRelatedManAlias', width: 150}
            // , {label: '是否实验室设备', name: 'isLabDevice', width: 150}
            // , {label: '是否固定资产', name: 'isFixedAssets', width: 150}
            // , {label: '资产财务类别', name: 'assetsFinanceType', width: 150}
            // , {label: '资产来源', name: 'assetsSource', width: 150}
            // , {label: '资产财务状态', name: 'assetsFinanceState', width: 150}
            // , {label: '财务入账时间', name: 'financeEntryDate', width: 150, formatter: format}
            // , {label: '原值', name: 'originalValue', width: 150}
            // , {label: '累计折旧', name: 'totalDepreciation', width: 150}
            // , {label: '折旧方法', name: 'depreciationMethod', width: 150}
            // , {label: '折旧年限', name: 'depreciationYear', width: 150}
            // , {label: '净残值率', name: 'netSalvageRate', width: 150}
            // , {label: '净残值', name: 'netSalvage', width: 150}
            // , {label: '月折旧率', name: 'monthDepreciationRate', width: 150}
            // , {label: '月折旧额', name: 'monthDepreciation', width: 150}
            // , {label: '年折旧率', name: 'yearDepreciationRate', width: 150}
            // , {label: '年折旧额', name: 'yearDepreciation', width: 150}
            // , {label: '净值', name: 'netValue', width: 150}
            // , {label: '已提月份', name: 'monthCount', width: 150}
            // , {label: '未计提月份', name: 'monthRemain', width: 150}
            // , {label: '研究所/公司', name: 'instituteOrCompany', width: 150}
            // , {label: '凭证编号', name: 'proofNum', width: 150}
            // , {label: '指标信息', name: 'indexInfo', width: 150}
            // , {label: '是否转固', name: 'isTransFixed', width: 150}
            // , {label: '计量外送员', name: 'meteringOuterAlias', width: 150}
            // , {label: '适用机型', name: 'applyModel', width: 150}
            // , {label: '适用产品', name: 'applyProduct', width: 150}
            // , {label: '受测对象', name: 'testedObject', width: 150}
            // , {label: '专业类别', name: 'majorType', width: 150}
            // , {label: '设备性质', name: 'deviceNature', width: 150}
            // , {label: '软件标识号', name: 'softwareNum', width: 150}
            // , {label: '软件设计人员', name: 'softwareDesignerAlias', width: 150}
            // , {label: '硬件设计人员', name: 'hardwareDesignerAlias', width: 150}
            // , {label: '是否测试设备', name: 'isTestDevice', width: 150}
            // , {label: '是否需要操作证', name: 'isNeedCertificate', width: 150}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("assetId");
        searchTips.push("资产编号");
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsDeviceAccount_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsDeviceAccount = new AssetsDeviceAccount('assetsDeviceAccountjqGrid', '${url}', 'searchDialog', 'form', 'assetsDeviceAccount_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsDeviceAccount_insert').bind('click', function () {
            assetsDeviceAccount.insert();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceAccount_modify').bind('click', function () {
            assetsDeviceAccount.modify();
        });
        //删除按钮绑定事件
        $('#assetsDeviceAccount_del').bind('click', function () {
            assetsDeviceAccount.del();
        });
        //查询按钮绑定事件
        $('#assetsDeviceAccount_searchPart').bind('click', function () {
            assetsDeviceAccount.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsDeviceAccount_searchAll').bind('click', function () {
            assetsDeviceAccount.openSearchForm(this);
        });
        $('#ownerIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerId', textFiled: 'ownerIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#ownerDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDept', textFiled: 'ownerDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#userIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'userId', textFiled: 'userIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#userDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'userDept', textFiled: 'userDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#metermanAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meterman', textFiled: 'metermanAlias'});
            this.blur();
            nullInput(e);
        });
        $('#planMetermanAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'planMeterman', textFiled: 'planMetermanAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meteringDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'meteringDept', textFiled: 'meteringDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#repairDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'repairDept', textFiled: 'repairDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deviceRelatedManAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'deviceRelatedMan', textFiled: 'deviceRelatedManAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meteringOuterAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meteringOuter', textFiled: 'meteringOuterAlias'});
            this.blur();
            nullInput(e);
        });
        $('#softwareDesignerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'softwareDesigner', textFiled: 'softwareDesignerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#hardwareDesignerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'hardwareDesigner', textFiled: 'hardwareDesignerAlias'});
            this.blur();
            nullInput(e);
        });
        //设备附表操作
        //添加按钮绑定事件
        $('#DYN_SUB_insertBtn').bind('click', function () {
            assetsDeviceAccount.insertSUB();
        });

    });
</script>
</html>