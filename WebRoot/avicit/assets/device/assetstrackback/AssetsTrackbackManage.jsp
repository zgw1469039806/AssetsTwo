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
    <!-- ControllerPath = "assets/device/assetstrackback/assetsTrackbackController/toAssetsTrackbackManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
    <div class="toolbar-left">
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTrackback_button_add"
                               permissionDes="添加">
            <a id="assetsTrackback_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTrackback_button_edit"
                               permissionDes="编辑">
            <a id="assetsTrackback_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="编辑" style="display:none;"><i class="fa fa-file-text-o"></i> 编辑</a>
        </sec:accesscontrollist>
        <sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsTrackback_button_delete"
                               permissionDes="删除">
            <a id="assetsTrackback_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
               role="button" title="删除" style="display:none;"><i class="fa fa-trash-o"></i> 删除</a>
        </sec:accesscontrollist>
    </div>
    <div class="toolbar-right">
        <select id="workFlowSelect" class="form-control input-sm workflow-select">
            <option value="all" selected="selected">全部</option>
            <option value="start">拟稿中</option>
            <option value="active">流转中</option>
            <option value="ended">已完成</option>
        </select>
        <div class="input-group form-tool-search">
            <input type="text" name="assetsTrackback_keyWord" id="assetsTrackback_keyWord" style="width:240px;"
                   class="form-control input-sm" placeholder="请输入查询条件">
            <label id="assetsTrackback_searchPart" class="icon icon-search form-tool-searchicon"></label>
        </div>
        <div class="input-group-btn form-tool-searchbtn">
            <a id="assetsTrackback_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">高级查询
                <span class="caret"></span></a>
        </div>
    </div>
</div>
<table id="assetsTrackbackjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">关联计量单号:</th>
                <td width="15%">
                    <input title="关联计量单号" class="form-control input-sm" type="text" name="meteringId" id="meteringId"/>
                </td>
                <th width="10%">申请人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applicantId" name="applicantId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="applicantIdAlias"
                               name="applicantIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
                <th width="10%">申请人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applicantDepart" name="applicantDepart">
                        <input class="form-control" placeholder="请选择部门" type="text" id="applicantDepartAlias"
                               name="applicantDepartAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">设备使用人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="deviceUserId" name="deviceUserId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="deviceUserIdAlias"
                               name="deviceUserIdAlias">
                        <span class="input-group-addon">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">设备使用人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="deviceUserDept" name="deviceUserDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="deviceUserDeptAlias"
                               name="deviceUserDeptAlias">
                        <span class="input-group-addon">
									        <i class="glyphicon glyphicon-equalizer"></i>
									      </span>
                    </div>
                </td>
                <th width="10%">表单状态:</th>
                <td width="15%">
                    <input title="表单状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
            </tr>
            <tr>
                <th width="10%">设备类别:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory"
                                  title="设备类别" isNull="true" lookupCode="DEVICE_CATEGORY"/>
                </td>
                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="DEVICE_SPEC" class="form-control input-sm" type="text" name="deviceSpec"
                           id="deviceSpec"/>
                </td>
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="DEVICE_MODEL" class="form-control input-sm" type="text" name="deviceModel"
                           id="deviceModel"/>
                </td>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="MANUFACTURER_ID" class="form-control input-sm" type="text" name="manufacturerId"
                           id="manufacturerId"/>
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
<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<!-- 业务的js -->
<script src="avicit/assets/device/assetstrackback/js/AssetsTrackback.js" type="text/javascript"></script>
<script type="text/javascript">
    var assetsTrackback;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsTrackback.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsTrackback.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsTrackback.reLoad();
    };
    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '超差追溯单编号', name: 'procId', width: 150, formatter: formatValue}
            , {label: '关联计量单号', name: 'meteringId', width: 150}
            , {label: '申请人', name: 'applicantIdAlias', width: 150}
            , {label: '申请人部门', name: 'applicantDepartAlias', width: 150}
            , {label: '设备使用人', name: 'deviceUserIdAlias', width: 150}
            , {label: '设备使用人部门', name: 'deviceUserDeptAlias', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150, formatter: formatValue}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '上次计量时间', name: 'lastMeteringDate', width: 150, formatter: format}
            , {label: '计量员', name: 'meterPersonAlias', width: 150}
            , {label: '计量结论', name: 'meterConclusion', width: 150}
            <sec:accesscontrollist hasPermission="3" domainObject="assetsTrackback_table_activityalias" permissionDes="流程当前步骤">
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="assetsTrackback_table_businessstate" permissionDes="流程状态">
            , {label: '流程状态', name: 'businessstate_', width: 150}
            </sec:accesscontrollist>
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("meteringId");
        searchTips.push("关联计量单号");
        searchNames.push("formState");
        searchTips.push("表单状态");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsTrackback_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsTrackback = new AssetsTrackback('assetsTrackbackjqGrid', '${url}', 'searchDialog', 'form', 'assetsTrackback_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsTrackback_insert').bind('click', function () {
            assetsTrackback.insert();
        });
        //编辑按钮绑定事件
        $('#assetsTrackback_modify').bind('click', function () {
            assetsTrackback.modify();
        });
        //删除按钮绑定事件
        $('#assetsTrackback_del').bind('click', function () {
            assetsTrackback.del();
        });
        //查询按钮绑定事件
        $('#assetsTrackback_searchPart').bind('click', function () {
            assetsTrackback.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsTrackback_searchAll').bind('click', function () {
            assetsTrackback.openSearchForm(this, 800, 400);
        });
        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsTrackback.initWorkFlow($(this).val());
        });
        $('#applicantIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'applicantId', textFiled: 'applicantIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#applicantDepartAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'applicantDepart', textFiled: 'applicantDepartAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deviceUserIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'deviceUserId', textFiled: 'deviceUserIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deviceUserDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'deviceUserDept', textFiled: 'deviceUserDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meterPersonAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meterPerson', textFiled: 'meterPersonAlias'});
            this.blur();
            nullInput(e);
        });

    });

</script>
</html>