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
    <!-- ControllerPath = "assets/device/assetsshiftproc/assetsShiftProcController/toAssetsShiftProcManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body>
	<div id="tableToolbar" class="toolbar">
		<div class="toolbar-left">
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsShiftProc_button_add" permissionDes="添加">
				<a id="assetsShiftProc_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加">
					<i class="fa fa-plus"></i> 添加
				</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsShiftProc_button_edit" permissionDes="编辑">
				<a id="assetsShiftProc_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑" style="display:none;">
					<i class="fa fa-file-text-o"></i> 编辑
				</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsShiftProc_button_delete" permissionDes="删除">
				<a id="assetsShiftProc_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除" style="display:none;">
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
				<input type="text" name="assetsShiftProc_keyWord" id="assetsShiftProc_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
				<label id="assetsShiftProc_searchPart" class="icon icon-search form-tool-searchicon"></label>
			</div>
			<div class="input-group-btn form-tool-searchbtn">
				<a id="assetsShiftProc_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
					高级查询<span class="caret"></span>
				</a>
			</div>
		</div>
	</div>
	<table id="assetsShiftProcjqGrid"></table>
	<div id="jqGridPager"></div>
</body>

<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form" style="padding: 10px;">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">移位编号:</th>
                <td width="15%">
                    <input title="移位编号" class="form-control input-sm" type="text" name="shiftNo" id="shiftNo"/>
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
                <th width="10%">现安装地点:</th>
                <td width="15%">
                    <input title="现安装地点" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>

                <th width="10%">新安装位置:</th>
                <td width="15%">
                    <input title="新安装位置" class="form-control input-sm" type="text" name="shiftPosition" id="shiftPosition"/>
                </td>

                <th width="10%">移位费用:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="shiftCost" id="shiftCost" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
                               data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>

                <th width="10%">设备移位理由:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="设备移位理由" name="shiftReason" id="shiftReason"></textarea>
                </td>
            </tr>

            <tr>
                <th width="10%">简易/大型设备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="simpleOrLarge" id="simpleOrLarge" title="简易/大型设备" isNull="true" lookupCode="SIMPLE_LARGE_SCALE"/>
                </td>

                <th width="10%">安装设备楼层承重是否满足:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isSatisfyBearing" id="isSatisfyBearing" title="安装设备楼层承重是否满足" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">设备是否有室外机:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasOutdoorUnit" id="hasOutdoorUnit" title="设备是否有室外机" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">所安装位置是否允许安装室外机:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="isAllowOutdoorunit" id="isAllowOutdoorunit" title="所安装位置是否允许安装室外机" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>

            <tr>
                <th width="10%">设备是否需要地基基础:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasFoundation" id="hasFoundation" title="设备是否需要地基基础" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">使用电压:</th>
                <td width="15%">
                    <input title="使用电压" class="form-control input-sm" type="text" name="useVoltage" id="useVoltage"/>
                </td>

                <th width="10%">安装位置是否具备电压条件:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasVoltageCondition" id="hasVoltageCondition" title="安装位置是否具备电压条件" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">是否有温湿度要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasHumidityNeed" id="hasHumidityNeed" title="是否有温湿度要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>

            <tr>
                <th width="10%">温湿度要求:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="温湿度要求" name="humidityNeed" id="humidityNeed"></textarea>
                </td>

                <th width="10%">是否有洁净度要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasCleanlinessNeed" id="hasCleanlinessNeed" title="是否有洁净度要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">洁净度要求:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="洁净度要求" name="cleanlinessNeed" id="cleanlinessNeed"></textarea>
                </td>

                <th width="10%">是否有用水要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasWaterNeed" id="hasWaterNeed" title="是否有用水要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>

            <tr>
                <th width="10%">用水要求:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="用水要求" name="waterNeed" id="waterNeed"></textarea>
                </td>

                <th width="10%">是否有用气要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasGasNeed" id="hasGasNeed" title="是否有用气要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">用气要求:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="用气要求" name="gasNeed" id="gasNeed"></textarea>
                </td>

                <th width="10%">是否有气体、污水排放:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasLetNeed" id="hasLetNeed" title="是否有气体、污水排放" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>

            <tr>
                <th width="10%">气体、污水排放要求:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="气体、污水排放要求" name="letNeed" id="letNeed"></textarea>
                </td>

                <th width="10%">是否有其他特殊要求:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasOtherNeed" id="hasOtherNeed" title="是否有其他特殊要求" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">其他特殊要求:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="其他特殊要求" name="otherNeed" id="otherNeed"></textarea>
                </td>

                <th width="10%">以上需求条件在拟安装地点是否都已具备:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasAboveConditions" id="hasAboveConditions" title="以上需求条件在拟安装地点是否都已具备" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>
            </tr>

            <tr>
                <th width="10%">是否有噪音:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="hasNoise" id="hasNoise" title="是否有噪音" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
                </td>

                <th width="10%">噪音是否影响安装地工作办公:</th>
                <td width="15%">
                    <pt6:h5select css_class="form-control input-sm" name="noiseInfluence" id="noiseInfluence" title="噪音是否影响安装地工作办公" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
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
<script src="avicit/assets/device/assetsshiftproc/js/AssetsShiftProc.js" type="text/javascript"></script>

<script type="text/javascript">
    var assetsShiftProc;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsShiftProc.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsShiftProc.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsShiftProc.reLoad();
    };

    $(document).ready(function () {
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '移位编号', name: 'shiftNo', width: 150, formatter: formatValue}
            , {label: '申请人部门', name: 'createdByDeptAlias', width: 150}
            , {label: '申请人电话', name: 'createdByTel', width: 150}
            , {label: '单据状态', name: 'formState', width: 150}
            , {label: '统一编号', name: 'unifiedId', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '现安装地点', name: 'positionId', width: 150}
            , {label: '新安装位置', name: 'shiftPosition', width: 150}
            , {label: '移位费用', name: 'shiftCost', width: 150}
            , {label: '设备移位理由', name: 'shiftReason', width: 150}
            , {label: '简易/大型设备', name: 'simpleOrLarge', width: 150}
            , {label: '安装设备楼层承重是否满足', name: 'isSatisfyBearing', width: 150}
            , {label: '设备是否有室外机', name: 'hasOutdoorUnit', width: 150}
            , {label: '所安装位置是否允许安装室外机', name: 'isAllowOutdoorunit', width: 150}
            , {label: '设备是否需要地基基础', name: 'hasFoundation', width: 150}
            , {label: '使用电压', name: 'useVoltage', width: 150}
            , {label: '安装位置是否具备电压条件', name: 'hasVoltageCondition', width: 150}
            , {label: '是否有温湿度要求', name: 'hasHumidityNeed', width: 150}
            <sec:accesscontrollist hasPermission="3" domainObject="assetsShiftProc_table_humidityNeed" permissionDes="温湿度要求">
            , {label: '温湿度要求', name: 'humidityNeed', width: 150}
            </sec:accesscontrollist>
            , {label: '是否有洁净度要求', name: 'hasCleanlinessNeed', width: 150}
            , {label: '洁净度要求', name: 'cleanlinessNeed', width: 150}
            , {label: '是否有用水要求', name: 'hasWaterNeed', width: 150}
            , {label: '用水要求', name: 'waterNeed', width: 150}
            , {label: '是否有用气要求', name: 'hasGasNeed', width: 150}
            , {label: '用气要求', name: 'gasNeed', width: 150}
            , {label: '是否有气体、污水排放', name: 'hasLetNeed', width: 150}
            , {label: '气体、污水排放要求', name: 'letNeed', width: 150}
            , {label: '是否有其他特殊要求', name: 'hasOtherNeed', width: 150}
            , {label: '其他特殊要求', name: 'otherNeed', width: 150}
            , {label: '以上需求条件在拟安装地点是否都已具备', name: 'hasAboveConditions', width: 150}
            , {label: '是否有噪音', name: 'hasNoise', width: 150}
            , {label: '噪音是否影响安装地工作办公', name: 'noiseInfluence', width: 150}
            <sec:accesscontrollist hasPermission="3" domainObject="assetsShiftProc_table_activityalias" permissionDes="流程当前步骤">
            , {label: '流程当前步骤', name: 'activityalias_', width: 150}
            </sec:accesscontrollist>
            <sec:accesscontrollist hasPermission="3" domainObject="assetsShiftProc_table_businessstate" permissionDes="流程状态">
            , {label: '流程状态', name: 'businessstate_', width: 150}
            </sec:accesscontrollist>
        ];

        var searchNames = new Array();
        var searchTips = new Array();

        searchNames.push("shiftNo");
        searchTips.push("移位编号");

        searchNames.push("createdByTel");
        searchTips.push("申请人电话");

        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsShiftProc_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);

        assetsShiftProc = new AssetsShiftProc('assetsShiftProcjqGrid', '${url}', 'searchDialog', 'form', 'assetsShiftProc_keyWord', searchNames, dataGridColModel);

        //添加按钮绑定事件
        $('#assetsShiftProc_insert').bind('click', function () {
            assetsShiftProc.insert();
        });

        //编辑按钮绑定事件
        $('#assetsShiftProc_modify').bind('click', function () {
            assetsShiftProc.modify();
        });

        //删除按钮绑定事件
        $('#assetsShiftProc_del').bind('click', function () {
            assetsShiftProc.del();
        });

        //查询按钮绑定事件
        $('#assetsShiftProc_searchPart').bind('click', function () {
            assetsShiftProc.searchByKeyWord();
        });

        //打开高级查询框
        $('#assetsShiftProc_searchAll').bind('click', function () {
            assetsShiftProc.openSearchForm(this, 800, 400);
        });

        //根据流程状态加载数据
        $('#workFlowSelect').bind('change', function () {
            assetsShiftProc.initWorkFlow($(this).val());
        });

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
    });
</script>
</html>