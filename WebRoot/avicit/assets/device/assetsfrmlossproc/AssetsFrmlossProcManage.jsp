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
    <!-- ControllerPath = "assets/device/assetsfrmlossproc/assetsFrmlossProcController/toAssetsFrmlossProcManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

</head>

<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFrmlossProc_button_add" permissionDes="添加">
				<a id="assetsFrmlossProc_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加">
					<i class="fa fa-plus"></i> 添加
				</a>
			</sec:accesscontrollist>

			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFrmlossProc_button_edit" permissionDes="编辑">
				<a id="assetsFrmlossProc_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑" style="display:none;">
					<i class="fa fa-file-text-o"></i> 编辑
				</a>
			</sec:accesscontrollist>

			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsFrmlossProc_button_delete" permissionDes="删除">
				<a id="assetsFrmlossProc_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除" style="display:none;">
					<i class="fa fa-trash-o"></i> 删除
				</a>
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
				<input type="text" name="assetsFrmlossProc_keyWord" id="assetsFrmlossProc_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
				<label id="assetsFrmlossProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="assetsFrmlossProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
					高级查询<span class="caret"></span>
				</a>
			</div>
		</div>
	</div>
	<table id="assetsFrmlossProcjqGrid"></table>
	<div id="jqGridPager"></div>
</body>

<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">报损编号:</th>
                <td width="15%">
                    <input title="报损编号" class="form-control input-sm" type="text" name="frmlossNo" id="frmlossNo"/>
                </td>

                <th width="10%">申请人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="createdByDept" name="createdByDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
                    </div>
                </td>

                <th width="10%">申请人电话:</th>
                <td width="15%">
                    <input title="申请人电话" class="form-control input-sm" type="text" name="createdByTel" id="createdByTel"/>
                </td>

                <th width="10%">单据状态:</th>
                <td width="15%">
                    <input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
                </td>
            </tr>

            <tr>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>

                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>

                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>

                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>
            </tr>

            <tr>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId"/>
                </td>

                <th width="10%">立卡日期(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateBegin" id="createdDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

                <th width="10%">立卡日期(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="createdDateEnd" id="createdDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

                <th width="10%">安装地点ID:</th>
                <td width="15%">
                    <input title="安装地点ID" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
            </tr>

            <tr>
                <th width="10%">责任人:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerId" name="ownerId">
                        <input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
                </td>

                <th width="10%">责任人联系电话:</th>
                <td width="15%">
                    <input title="责任人联系电话" class="form-control input-sm" type="text" name="ownerMobile" id="ownerMobile"/>
                </td>

                <th width="10%">责任部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
                    </div>
                </td>

                <th width="10%">账面原值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="originalValue" id="originalValue" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
            </tr>

            <tr>
                <th width="10%">预计净残值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netSalvage" id="netSalvage" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>

                <th width="10%">报损原因:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="报损原因" name="frmlossReason" id="frmlossReason"></textarea>
                </td>

                <th width="10%">有关产品的风险分析:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="有关产品的风险分析" name="riskAnalysis" id="riskAnalysis"></textarea>
                </td>

                <th width="10%">回收库:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="recycleWarehouse" id="recycleWarehouse" title="回收库" isNull="true" lookupCode="RECOVERY_STORE"/>
                </td>
            </tr>

            <tr>
                <th width="10%">是否已回收:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="ifRecycle" id="ifRecycle" title="是否已回收" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">设备状态:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="deviceState" id="deviceState" title="设备状态" isNull="true" lookupCode="DEVICE_STATE"/>
                </td>

                <th width="10%">账面净值:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="netValue" id="netValue" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
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
<script src="avicit/assets/device/assetsfrmlossproc/js/AssetsFrmlossProc.js" type="text/javascript"></script>




<script type="text/javascript">
    var assetsFrmlossProc;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsFrmlossProc.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsFrmlossProc.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsFrmlossProc.reLoad();
    };

    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '报损编号', name: 'frmlossNo', width: 150, formatter: formatValue}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            , {label: '单据状态', name: 'formState', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '立卡日期', name: 'createdDate', width: 150, formatter: format}
            , {label: '安装地点ID', name: 'positionId', width: 150}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            , {label: '责任人联系电话', name: 'ownerMobile', width: 150}
            , {label: '责任部门', name: 'ownerDeptAlias', width: 150}
            , {label: '账面原值', name: 'originalValue', width: 150}
            , {label: '累计折旧', name: 'totalDepreciation', width: 150}
            , {label: '账面净值', name: 'netValue', width: 150}
            , {label: '预计净残值', name: 'netSalvage', width: 150}
            , {label: '净报损金额', name: 'netLossValue', width: 150}
            , {label: '报损原因', name: 'frmlossReason', width: 150}
            , {label: '有关产品的风险分析', name: 'riskAnalysis', width: 150}
            , {label: '回收库', name: 'recycleWarehouse', width: 150}
            , {label: '是否已回收', name: 'ifRecycle', width: 150}
            , {label: '设备状态', name: 'deviceState', width: 150}
            <sec:accesscontrollist hasPermission="3" domainObject="assetsFrmlossProc_table_activityalias" permissionDes="流程当前步骤">
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="assetsFrmlossProc_table_businessstate" permissionDes="流程状态">
            , {label: '流程状态', name: 'businessstate_', width: 150}
            </sec:accesscontrollist>
        ];

        var searchNames = new Array();
        var searchTips = new Array();

        searchNames.push("frmlossNo");
        searchTips.push("报损编号");

        searchNames.push("createdByTel");
        searchTips.push("申请人电话");

        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsFrmlossProc_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);

        assetsFrmlossProc = new AssetsFrmlossProc('assetsFrmlossProcjqGrid', '${url}', 'searchDialog', 'form', 'assetsFrmlossProc_keyWord', searchNames, dataGridColModel);

        //添加按钮绑定事件
        $('#assetsFrmlossProc_insert').bind('click', function () {
            assetsFrmlossProc.insert();
        });

        //编辑按钮绑定事件
        $('#assetsFrmlossProc_modify').bind('click', function () {
            assetsFrmlossProc.modify();
        });

        //删除按钮绑定事件
        $('#assetsFrmlossProc_del').bind('click', function () {
            assetsFrmlossProc.del();
        });

        //查询按钮绑定事件
        $('#assetsFrmlossProc_searchPart').bind('click', function () {
            assetsFrmlossProc.searchByKeyWord();
        });

        //打开高级查询框
        $('#assetsFrmlossProc_searchAll').bind('click', function () {
            assetsFrmlossProc.openSearchForm(this, 800, 400);
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsFrmlossProc.initWorkFlow($(this).val());
        });

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
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
    });
</script>
<%@include file="/static/js/assets/ContextMenu.jsp"%>
<script  src="static/js/assets/ContextMenu_jquery.js" type="text/javascript"></script>
<script  src="static/js/assets/ContextMenu.js" type="text/javascript"></script>
</html>