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
    <!-- ControllerPath = "assets/device/assetsaccidentproc/assetsAccidentProcController/toAssetsAccidentProcManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsAccidentProc_button_add" permissionDes="添加">
				<a id="assetsAccidentProc_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加">
					<i class="fa fa-plus"></i> 添加
				</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsAccidentProc_button_edit" permissionDes="编辑">
				<a id="assetsAccidentProc_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑" style="display:none;">
					<i class="fa fa-file-text-o"></i> 编辑
				</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsAccidentProc_button_delete" permissionDes="删除">
				<a id="assetsAccidentProc_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除" style="display:none;">
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
				<input type="text" name="assetsAccidentProc_keyWord" id="assetsAccidentProc_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
				<label id="assetsAccidentProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="assetsAccidentProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
					高级查询<span class="caret"></span>
				</a>
			</div>
		</div>
	</div>
	<table id="assetsAccidentProcjqGrid"></table>
	<div id="jqGridPager"></div>
</body>

<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">事故编号:</th>
                <td width="15%">
                    <input title="事故编号" class="form-control input-sm" type="text" name="accidentNo" id="accidentNo"/>
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
                <th width="10%">设备操作者:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="assetsOperator" name="assetsOperator">
                        <input class="form-control" placeholder="请选择用户" type="text" id="assetsOperatorAlias" name="assetsOperatorAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
                </td>

                <th width="10%">操作者单位:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="operatorDept" name="operatorDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="operatorDeptAlias" name="operatorDeptAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
                    </div>
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
                <th width="10%">设备型号:</th>
                <td width="15%">
                    <input title="设备型号" class="form-control input-sm" type="text" name="deviceModel" id="deviceModel"/>
                </td>

                <th width="10%">设备规格:</th>
                <td width="15%">
                    <input title="设备规格" class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec"/>
                </td>

                <th width="10%">事故发生时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control time-picker" type="text" name="occurTimeBegin" id="occurTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

                <th width="10%">事故发生时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control time-picker" type="text" name="occurTimeEnd" id="occurTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>

            <tr>
                <th width="10%">报告单位领导时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control time-picker" type="text" name="reportLeaderTimeBegin" id="reportLeaderTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

                <th width="10%">报告单位领导时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control time-picker" type="text" name="reportLeaderTimeEnd" id="reportLeaderTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

                <th width="10%">报告时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control time-picker" type="text" name="reportTimeBegin"
                               id="reportTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

                <th width="10%">报告时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control time-picker" type="text" name="reportTimeEnd" id="reportTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>

            <tr>
                <th width="10%">事故发生经过:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="事故发生经过" name="accidentProcess" id="accidentProcess"></textarea>
                </td>

                <th width="10%">事故后果:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="事故后果" name="accidentConsequence" id="accidentConsequence"></textarea>
                </td>

                <th width="10%">事故原因分析:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="事故原因分析" name="reasonAnalysis" id="reasonAnalysis"></textarea>
                </td>

                <th width="10%">防止事故措施:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="防止事故措施" name="preventionMeasures" id="preventionMeasures"></textarea>
                </td>
            </tr>

            <tr>
                <th width="10%">修复时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control time-picker" type="text" name="repairTimeBegin" id="repairTimeBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

                <th width="10%">修复时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control time-picker" type="text" name="repairTimeEnd" id="repairTimeEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>

                <th width="10%">停工天数:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="stopWorkDays" id="stopWorkDays" data-min="0" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>

                <th width="10%">直接经济损失:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="directEconomicLoss" id="directEconomicLoss"
                               data-min="0" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
            </tr>

            <tr>
                <th width="10%">事故性质:</th>
                <td width="15%">
                    <input title="事故性质" class="form-control input-sm" type="text" name="accidentProperty" id="accidentProperty"/>
                </td>

                <th width="10%">设备员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="assetsMan" name="assetsMan">
                        <input class="form-control" placeholder="请选择用户" type="text" id="assetsManAlias" name="assetsManAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
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
<script src="avicit/assets/device/assetsaccidentproc/js/AssetsAccidentProc.js" type="text/javascript"></script>

<script type="text/javascript">
    var assetsAccidentProc;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsAccidentProc.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsAccidentProc.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsAccidentProc.reLoad();
    };

    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '事故编号', name: 'accidentNo', width: 150, formatter: formatValue}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            , {label: '单据状态', name: 'formState', width: 150}
            , {label: '设备操作者', name: 'assetsOperatorAlias', width: 150}
            , {label: '操作人单位', name: 'operatorDeptAlias', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '事故发生时间', name: 'occurTime', width: 150, formatter: format}
            , {label: '报告单位领导时间', name: 'reportLeaderTime', width: 150, formatter: format}
            , {label: '报告时间', name: 'reportTime', width: 150, formatter: format}
            , {label: '事故发生经过', name: 'accidentProcess', width: 150}
            , {label: '事故后果', name: 'accidentConsequence', width: 150}
            , {label: '事故原因分析', name: 'reasonAnalysis', width: 150}
            , {label: '防止事故措施', name: 'preventionMeasures', width: 150}
            , {label: '修复时间', name: 'repairTime', width: 150, formatter: format}
            , {label: '停工天数', name: 'stopWorkDays', width: 150}
            , {label: '直接经济损失', name: 'directEconomicLoss', width: 150}
            , {label: '事故性质', name: 'accidentProperty', width: 150}
            , {label: '设备员', name: 'assetsManAlias', width: 150}
            <sec:accesscontrollist hasPermission="3" domainObject="assetsAccidentProc_table_activityalias" permissionDes="流程当前步骤">
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="assetsAccidentProc_table_businessstate" permissionDes="流程状态">
            , {label: '流程状态', name: 'businessstate_', width: 150}
            </sec:accesscontrollist>
        ];

        var searchNames = new Array();
        var searchTips = new Array();

        searchNames.push("accidentNo");
        searchTips.push("事故编号");

        searchNames.push("createdByTel");
        searchTips.push("申请人电话");

        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsAccidentProc_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);

        assetsAccidentProc = new AssetsAccidentProc('assetsAccidentProcjqGrid', '${url}', 'searchDialog', 'form', 'assetsAccidentProc_keyWord', searchNames, dataGridColModel);

        //添加按钮绑定事件
        $('#assetsAccidentProc_insert').bind('click', function () {
            assetsAccidentProc.insert();
        });

        //编辑按钮绑定事件
        $('#assetsAccidentProc_modify').bind('click', function () {
            assetsAccidentProc.modify();
        });

        //删除按钮绑定事件
        $('#assetsAccidentProc_del').bind('click', function () {
            assetsAccidentProc.del();
        });

        //查询按钮绑定事件
        $('#assetsAccidentProc_searchPart').bind('click', function () {
            assetsAccidentProc.searchByKeyWord();
        });

        //打开高级查询框
        $('#assetsAccidentProc_searchAll').bind('click', function () {
            assetsAccidentProc.openSearchForm(this, 800, 400);
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsAccidentProc.initWorkFlow($(this).val());
        });

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });

        $('#assetsOperatorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'assetsOperator', textFiled: 'assetsOperatorAlias'});
            this.blur();
            nullInput(e);
        });

        $('#operatorDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'operatorDept', textFiled: 'operatorDeptAlias'});
            this.blur();
            nullInput(e);
        });

        $('#assetsManAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'assetsMan', textFiled: 'assetsManAlias'});
            this.blur();
            nullInput(e);
        });
    });
</script>
</html>