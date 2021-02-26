<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String importlibs = "common,table,form";
%>

<!DOCTYPE html>
<html>

<head>
    <!-- ControllerPath = "assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/toAssetsUstdtempAcceptanceManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
	<%--主表--%>
	<div id="panelnorth" data-options="region:'north',height:fixheight(.5),onResize:function(a){$('#assetsUstdtempAcceptance').setGridWidth(a);$('#assetsUstdtempAcceptance').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
		<%--主表表头上方操作、查询栏--%>
		<div id="toolbar_assetsUstdtempAcceptance" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempAcceptance_button_add" permissionDes="添加">
					<a id="assetsUstdtempAcceptance_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="添加">
						<i class="fa fa-plus"></i>添加
					</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempAcceptance_button_edit" permissionDes="编辑">
					<a id="assetsUstdtempAcceptance_modify" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="编辑">
						<i class="fa fa-file-text-o"></i> 编辑
					</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_assetsUstdtempAcceptance_button_delete" permissionDes="删除">
					<a id="assetsUstdtempAcceptance_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" style="display:none;" role="button" title="删除">
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
				<div class="input-group form-tool-search" style="width:125px">
					<input type="text" name="assetsUstdtempAcceptance_keyWord" id="assetsUstdtempAcceptance_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
					<label id="assetsUstdtempAcceptance_searchPart" class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="assetsUstdtempAcceptance_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
						高级查询 <span class="caret"></span>
					</a>
				</div>
                <!-- 页面右上角视图切换框——开始 -->
                <div class="input-group form-tool-search" style="width:130px;">
                    <input type="text" name="tableViewSelect" id="tableViewSelect" style="width:120px;" class="form-control input-sm" readonly value="${viewList.get(0)}">
                </div>
                <!-- 页面右上角视图切换框——结束 -->
			</div>
		</div>

		<%--主表--%>
		<table id="assetsUstdtempAcceptance"></table>
		<div id="assetsUstdtempAcceptancePager"></div>
	</div>

	<%--子表--%>
	<div id="centerpanel" data-options="region:'center',split:true,onResize:function(a){$('#acceptanceDeviceComponent').setGridWidth(a); $('#acceptanceDeviceComponent').setGridHeight(getJgridTableHeight($('#centerpanel')));$(window).trigger('resize');}">
		<%--子表表头上方操作、查询栏--%>
		<div id="toolbar_acceptanceDeviceComponent" class="toolbar">
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width:125px">
					<input type="text" name="acceptanceDeviceComponent_keyWord" id="acceptanceDeviceComponent_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
					<label id="acceptanceDeviceComponent_searchPart" class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="acceptanceDeviceComponent_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
						高级查询 <span class="caret"></span>
					</a>
				</div>
			</div>
		</div>

		<%--子表列表--%>
		<table id="acceptanceDeviceComponent"></table>
		<div id="acceptanceDeviceComponentPager"></div>
	</div>
</body>

<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">验收单号:</th>
                <td width="15%">
                    <input title="验收单号" class="form-control input-sm" type="text" name="acceptanceNo" id="acceptanceNo"/>
                </td>
				<th width="10%">申请人:</th>
				<td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applyBy" name="applyBy">
                        <input class="form-control" placeholder="请选择用户" type="text" id="applyByAlias" name="applyByAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
				</td>
                <th width="10%">申请人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="applyByDept" name="applyByDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="applyByDeptAlias" name="applyByDeptAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
                    </div>
                </td>
                <th width="10%">申购单号:</th>
                <td width="15%">
                    <input title="申购单号" class="form-control input-sm" type="text" name="subscribeNo" id="subscribeNo"/>
                </td>
            </tr>
            <tr>
				<th width="10%">单据状态:</th>
				<td width="15%">
					<input title="单据状态" class="form-control input-sm" type="text" name="formState" id="formState"/>
				</td>
                <th width="10%">合同编号:</th>
                <td width="15%">
                    <input title="合同编号" class="form-control input-sm" type="text" name="contractNum" id="contractNum"/>
                </td>
                <th width="10%">设备名称:</th>
                <td width="15%">
                    <input title="设备名称" class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
                </td>
                <th width="10%">统一编号:</th>
                <td width="15%">
                    <input title="统一编号" class="form-control input-sm" type="text" name="unifiedId" id="unifiedId"/>
                </td>
            </tr>
            <tr>
				<th width="10%">密级:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="secretLevel" name="secretLevel" types="selectLookup">
						<input class="form-control" placeholder="密级" type="text" id="secretLevelNames" name="secretLevelNames" types="selectLookup" lookupCode="SECRET_LEVEL" readonly>
					</div>
				</td>
                <th width="10%">生产厂家:</th>
                <td width="15%">
                    <input title="生产厂家" class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId"/>
                </td>
                <th width="10%">主管总师:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="competentChiefEngineer" name="competentChiefEngineer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="competentChiefEngineerAlias" name="competentChiefEngineerAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
                </td>
                <th width="10%">责任人部门:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="ownerDept" name="ownerDept">
                        <input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-equalizer"></i>
						</span>
                    </div>
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
                <th width="10%">责任人联系方式:</th>
                <td width="15%">
                    <input title="责任人联系方式" class="form-control input-sm" type="text" name="ownerTel" id="ownerTel"/>
                </td>
                <th width="10%">台(套)数:</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="setsCount" id="setsCount" data-min="1" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
                <th width="10%">单价(元):</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="unitPrice" id="unitPrice" data-min="0" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
            </tr>
            <tr>
				<th width="10%">项目主管:</th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="projectDirector" name="projectDirector">
						<input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias">
						<span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
					</div>
				</td>
                <th width="10%">设备类别:</th>
                <td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden"  id="deviceCategory" name="deviceCategory" types="selectCategory">
						<input class="form-control" placeholder="请选择设备类别" type="text" id="deviceCategoryNames" name="deviceCategoryNames" types="selectCategory" lookupCode="NationalStandard" readonly>
					</div>
                </td>
                <th width="10%">是否定检:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="ifRegularCheck" name="ifRegularCheck" types="selectLookup">
						<input class="form-control" placeholder="是否定检" type="text" id="ifRegularCheckNames" name="ifRegularCheckNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
                <th width="10%">是否点检:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="ifSpotCheck" name="ifSpotCheck" types="selectLookup">
						<input class="form-control" placeholder="是否点检" type="text" id="ifSpotCheckNames" name="ifSpotCheckNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
            </tr>
            <tr>
				<th width="10%">是否精度检查:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="ifPrecisionInspection" name="ifPrecisionInspection" types="selectLookup">
						<input class="form-control" placeholder="是否精度检查" type="text" id="ifPrecisionInspectionNames" name="ifPrecisionInspectionNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
                <th width="10%">是否保养:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="ifUpkeep" name="ifUpkeep" types="selectLookup">
						<input class="form-control" placeholder="是否保养" type="text" id="ifUpkeepNames" name="ifUpkeepNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
                <th width="10%">保养周期(天):</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="upkeepCycle" id="upkeepCycle" data-min="1" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
                <th width="10%">保养要求:</th>
                <td width="15%">
                    <textarea class="form-control input-sm" rows="3" title="保养要求" name="upkeepRequirements" id="upkeepRequirements"></textarea>
                </td>
            </tr>
            <tr>
				<th width="10%">下次保养时间(从):</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text" name="nextUpkeepDateBegin" id="nextUpkeepDateBegin"/>
						<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
                <th width="10%">下次保养时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="nextUpkeepDateEnd" id="nextUpkeepDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">是否计量:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="ifMeasure" name="ifMeasure" types="selectLookup">
						<input class="form-control" placeholder="是否计量" type="text" id="ifMeasureNames" name="ifMeasureNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
                <th width="10%">是否现场计量:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="ifMeasureOnsite" name="ifMeasureOnsite" types="selectLookup">
						<input class="form-control" placeholder="是否现场计量" type="text" id="ifMeasureOnsiteNames" name="ifMeasureOnsiteNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
            </tr>
            <tr>
                <th width="10%">计量标识:</th>
                <td width="15%">
                    <input title="计量标识" class="form-control input-sm" type="text" name="measureIdentify" id="measureIdentify"/>
                </td>
                <th width="10%">计量人员:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="measureBy" name="measureBy">
                        <input class="form-control" placeholder="请选择用户" type="text" id="measureByAlias" name="measureByAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
                </td>
                <th width="10%">计量时间(从):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="meteringDateBegin" id="meteringDateBegin"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <th width="10%">计量时间(至):</th>
                <td width="15%">
                    <div class="input-group input-group-sm">
                        <input class="form-control date-picker" type="text" name="meteringDateEnd" id="meteringDateEnd"/>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th width="10%">计量周期(天):</th>
                <td width="15%">
                    <div class="input-group input-group-sm spinner" data-trigger="spinner">
                        <input class="form-control" type="text" name="meteringCycle" id="meteringCycle" data-min="1" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
                        <span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
                    </div>
                </td>
				<th width="10%">是否需要安装:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="ifInstall" name="ifInstall" types="selectLookup">
						<input class="form-control" placeholder="是否需要安装" type="text" id="ifInstallNames" name="ifInstallNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
                <th width="10%">安装地点:</th>
                <td width="15%">
                    <input title="安装地点" class="form-control input-sm" type="text" name="positionId" id="positionId"/>
                </td>
                <th width="10%">是否含计算机/无线模板:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="ifHasComputer" name="ifHasComputer" types="selectLookup">
						<input class="form-control" placeholder="是否含计算机/无线模板" type="text" id="ifHasComputerNames" name="ifHasComputerNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
                </td>
            </tr>
            <tr>
				<th width="10%">是否涉及安全生产:</th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="isSafetyProduction" name="isSafetyProduction" types="selectLookup">
						<input class="form-control" placeholder="是否涉及安全生产" type="text" id="isSafetyProductionNames" name="isSafetyProductionNames" types="selectLookup" lookupCode="PLATFORM_YES_NO_FLAG" readonly>
					</div>
				</td>
                <th width="10%">经费来源:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="financialResources" name="financialResources" types="selectLookup">
						<input class="form-control" placeholder="请选择ABC分类" type="text" id="financialResourcesNames" name="financialResourcesNames" types="selectLookup" lookupCode="FINANCIAL_RESOURCES" readonly>
					</div>
				</td>
                <th width="10%">所属项目:</th>
                <td width="15%">
                    <input title="所属项目" class="form-control input-sm" type="text" name="belongProject" id="belongProject"/>
                </td>
                <th width="10%">项目序号:</th>
                <td width="15%">
                    <input title="项目序号" class="form-control input-sm" type="text" name="projectNo" id="projectNo"/>
                </td>
            </tr>
            <tr>
				<th width="10%">批复名称:</th>
				<td width="15%">
					<input title="批复名称" class="form-control input-sm" type="text" name="replyName" id="replyName"/>
				</td>
                <th width="10%">立项单号:</th>
                <td width="15%">
                    <input title="立项单号" class="form-control input-sm" type="text" name="projectApprovalNo" id="projectApprovalNo"/>
                </td>
                <th width="10%">ABC分类:</th>
                <td width="15%">
					<div class="input-group input-group-sm">
						<input type="hidden" id="abcCategory" name="abcCategory" types="selectLookup">
						<input class="form-control" placeholder="请选择ABC分类" type="text" id="abcCategoryNames" name="abcCategoryNames" types="selectLookup" lookupCode="ABC_CATEGORY" readonly>
					</div>
				</td>
            </tr>
        </table>
    </form>
</div>

<!-- 子表高级查询 -->
<div id="searchDialogSub" style="overflow: auto;display: none">
    <form id="formSub">
        <table class="form_commonTable">
            <tr>
                <th width="10%">主设备统一编号:</th>
                <td width="15%">
                    <input title="主设备统一编号" class="form-control input-sm" type="text" name="parentUnifiedId" id="parentUnifiedId"/>
                </td>
                <th width="10%">组件名称:</th>
                <td width="15%">
                    <input title="组件名称" class="form-control input-sm" type="text" name="componentName" id="componentName"/>
                </td>
                <th width="10%">组件类别:</th>
                <td width="15%">
                    <input title="组件类别" class="form-control input-sm" type="text" name="componentCategory" id="componentCategory"/>
                </td>
            </tr>
            <tr>
                <th width="10%">组件型号:</th>
                <td width="15%">
                    <input title="组件型号" class="form-control input-sm" type="text" name="componentModel" id="componentModel"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 视图选择弹框——开始 -->
<div id="selectViewDialog" style="overflow: auto;display:none;">
    <table class="ui-jqgrid-btable ui-common-table table table-bordered" style="width: 140px;">
        <tbody id="selectViewTbody">
        <c:forEach var="index" begin="0" end="${viewList.size()-1}" step="1">
            <c:if test="${viewList.get(index) != '系统默认视图'}">
                <tr>
                    <td role="gridcell" onclick="switchView('${viewList.get(index)}')" title="${viewList.get(index)}">
                            ${viewList.get(index)}
                    </td>
                    <td>
                        <i class="fa fa-file-text-o" onclick="editView('${viewList.get(index)}')" title="编辑视图"></i>
                        <i class="fa fa-trash-o" onclick="delView('${viewList.get(index)}')" title="删除视图"></i>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
        <tr>
            <td role="gridcell" onclick="addView()" title="创建新视图">
                创建新视图
            </td>
            <td>
                <i class="fa fa-plus" onclick="addView()" title="创建视图"></i>
            </td>
        </tr>
        <tr>
            <td colspan="2" role="gridcell" onclick="switchView('系统默认视图')" title="系统默认视图">
                系统默认视图
            </td>
        </tr>
        </tbody>
    </table>
</div>
<!-- 视图选择弹框——结束 -->

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<!-- 流程的js -->
<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowListEditor.js"></script>
<script src="avicit/assets/device/assetsustdtempacceptance/js/AssetsUstdtempAcceptance.js" type="text/javascript"></script>
<script src="avicit/assets/device/assetsustdtempacceptance/js/AcceptanceDeviceComponent.js" type="text/javascript"></script>

<!-- 业务的js -->
<script src="avicit/assets/device/usertablemodel/js/UserTableModel.js" type="text/javascript"></script>

<script type="text/javascript">
	var assetsUstdtempAcceptance;
	var assetsUstdtempAcceptanceGridColModel;
	var acceptanceToolBar = document.getElementById('toolbar_assetsUstdtempAcceptance');
	var searchMainNames = new Array();
	var searchMainTips = new Array();

    var userTableModel = new UserTableModel();

	var acceptanceDeviceComponent;
	var acceptanceDeviceComponentGridColModel;
	var componentToolBar = document.getElementById('toolbar_acceptanceDeviceComponent');
	var searchSubNames = new Array();
	var searchSubTips = new Array();

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsUstdtempAcceptance.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsUstdtempAcceptance.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //切换列表视图
    function switchView(viewName){
        var paramList = [];
        paramList.push('AssetsUstdtempAcceptance');
        paramList.push(viewName);

        $.ajax({
            url : "assets/device/usertablemodel/userTableModelController/operation/get",
            data : JSON.stringify(paramList),
            contentType : 'application/json',
            type : 'post',
            dataType : 'json',
            success : function(r){
                if (result.flag == "success"){
                    assetsUstdtempAcceptanceGridColModel = result.dataGridColModelJson;
                    assetsUstdtempAcceptanceGridColModel = JSON.parse(assetsUstdtempAcceptanceGridColModel);

                    for(i=0; i<assetsUstdtempAcceptanceGridColModel.length; i++){
                        if(assetsUstdtempAcceptanceGridColModel[i].formatter != undefined){
                            assetsUstdtempAcceptanceGridColModel[i].formatter = formatValue;
                        }
                    }

                    //清除列表后刷新
                    $.jgrid.gridUnload('assetsUstdtempAcceptance');
                    assetsUstdtempAcceptance = new AssetsUstdtempAcceptance('assetsUstdtempAcceptance', '${url}', 'form', assetsUstdtempAcceptanceGridColModel, 'searchDialog',
                        function () {
                        },
                        function () {
                        },
                        searchMainNames, "assetsUstdtempAcceptance_keyWord");

                    AddHeaderSearch(assetsUstdtempAcceptanceGridColModel, 'assetsUstdtempAcceptance', assetsUstdtempAcceptance);	//添加表头搜索
                    BuildDrag('assetsUstdtempAcceptance', '${url}', 'form', assetsUstdtempAcceptanceGridColModel, 'searchDialog', searchMainNames, 'assetsUstdtempAcceptance_keyWord', assetsUstdtempAcceptance, acceptanceToolBar)//添加表头拖拽
                    document.getElementById('tableViewSelect').value = viewName;
                }else{
                    layer.alert('视图切换失败,请联系管理员：'+result.message, {
                            icon: 7,
                            area: ['400px', ''], //宽高
                            closeBtn: 0,
                            btn: ['关闭'],
                            title:"提示"
                        }
                    );
                }
            }
        });
    }

    //编辑视图
    function editView(viewName) {
        userTableModel.modify('AssetsUstdtempAcceptance', viewName);
    }

    //删除视图
    function delView(viewName) {
        var trEle = event.target.parentNode.parentNode;
        userTableModel.del('AssetsUstdtempAcceptance', viewName, trEle);
    }

    //创建新视图
    function addView(){
        userTableModel.insert('AssetsUstdtempAcceptance');
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsUstdtempAcceptance.reLoad();
    };

    $(document).ready(function () {
		/*主表参数配置——开始*/
        searchMainNames.push("createdByTel");
        searchMainTips.push("申请人电话");

        searchMainNames.push("formState");
        searchMainTips.push("单据状态");

        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsUstdtempAcceptance_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#assetsUstdtempAcceptance_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);

		assetsUstdtempAcceptanceGridColModel = ${assetsUstdtempAcceptanceGridColModel};
		for(i=0; i<assetsUstdtempAcceptanceGridColModel.length; i++){
		    if(assetsUstdtempAcceptanceGridColModel[i].formatter != undefined){
                assetsUstdtempAcceptanceGridColModel[i].formatter = formatValue;
            }
        }
		/*主表参数配置——结束*/

		/*子表参数配置——开始*/
        searchSubNames.push("deviceId");
        searchSubTips.push("主设备ID");

        searchSubNames.push("parentUnifiedId");
        searchSubTips.push("主设备统一编号");

        var searchSubC = searchSubTips.length == 2 ? '或' + searchSubTips[1] : "";
        $('#acceptanceDeviceComponent_keyWord').attr('placeholder', '请输入' + searchSubTips[0] + searchSubC);
        $('#acceptanceDeviceComponent_keyWord').attr('title', '请输入' + searchSubTips[0] + searchSubC);

        acceptanceDeviceComponentGridColModel = ${acceptanceDeviceComponentGridColModel};
		/*子表参数配置——开始*/

        /*构建主子表*/
        assetsUstdtempAcceptance = new AssetsUstdtempAcceptance('assetsUstdtempAcceptance', '${url}', 'form', assetsUstdtempAcceptanceGridColModel, 'searchDialog',
            function (pid) {
                acceptanceDeviceComponent = new AcceptanceDeviceComponent('acceptanceDeviceComponent', '${surl}', "formSub", acceptanceDeviceComponentGridColModel, 'searchDialogSub', pid, searchSubNames, "acceptanceDeviceComponent_keyWord");
				SubAddHeaderSearch(acceptanceDeviceComponentGridColModel, 'acceptanceDeviceComponent', acceptanceDeviceComponent);	//添加表头搜索
                SubBuildDrag('acceptanceDeviceComponent', '${surl}', 'formSub', acceptanceDeviceComponentGridColModel, 'searchDialogSub', pid, searchSubNames, 'acceptanceDeviceComponent_keyWord', acceptanceDeviceComponent, componentToolBar);
            },
            function (pid) {
                acceptanceDeviceComponent.reLoad(pid);
            },
            searchMainNames, "assetsUstdtempAcceptance_keyWord");

        /*主表操作——开始*/
        $('#assetsUstdtempAcceptance_insert').bind('click', function () {	//添加按钮绑定事件
            assetsUstdtempAcceptance.insert();
        });

        $('#assetsUstdtempAcceptance_modify').bind('click', function () {	//编辑按钮绑定事件
            assetsUstdtempAcceptance.modify();
        });

        $('#assetsUstdtempAcceptance_del').bind('click', function () {	//删除按钮绑定事件
            assetsUstdtempAcceptance.del();
        });

        $('#assetsUstdtempAcceptance_searchAll').bind('click', function () {	//打开高级查询框
            assetsUstdtempAcceptance.openSearchForm(this, $('#assetsUstdtempAcceptance'));
        });

        $('#assetsUstdtempAcceptance_searchPart').bind('click', function () {	//关键字段查询按钮绑定事件
            assetsUstdtempAcceptance.searchByKeyWord();
        });

        $('#workFlowSelect').bind('change', function () {	//根据流程状态加载数据
            assetsUstdtempAcceptance.initWorkFlow($(this).val());
        });

        //视图切换弹框绑定事件
        $('#tableViewSelect').bind('click', function(){
            assetsUstdtempAcceptance.openSelectView(this,140,200);
        });

        AddHeaderSearch(assetsUstdtempAcceptanceGridColModel, 'assetsUstdtempAcceptance', assetsUstdtempAcceptance);	//添加表头搜索

        BuildDrag('assetsUstdtempAcceptance', '${url}', 'form', assetsUstdtempAcceptanceGridColModel, 'searchDialog', searchMainNames, 'assetsUstdtempAcceptance_keyWord', assetsUstdtempAcceptance, acceptanceToolBar)//添加表头拖拽
        /*主表操作——结束*/

		/*子表操作——开始*/
        $('#acceptanceDeviceComponent_searchAll').bind('click', function () {	//打开高级查询
            acceptanceDeviceComponent.openSearchForm(this, $('#acceptanceDeviceComponent'));
        });

        $('#acceptanceDeviceComponent_searchPart').bind('click', function () {	//关键字段查询按钮绑定事件
            acceptanceDeviceComponent.searchByKeyWord();
        });

        $('#createdByDeptAlias').on('focus', function (e) {	//创建人部门绑定事件
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });

        $('#competentChiefEngineerAlias').on('focus', function (e) {	//主管总师绑定事件
            new H5CommonSelect({type: 'userSelect', idFiled: 'competentChiefEngineer', textFiled: 'competentChiefEngineerAlias'});
            this.blur();
            nullInput(e);
        });

        $('#ownerDeptAlias').on('focus', function (e) {	//责任人部门绑定事件
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDept', textFiled: 'ownerDeptAlias'});
            this.blur();
            nullInput(e);
        });

        $('#ownerIdAlias').on('focus', function (e) {	//责任人绑定事件
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerId', textFiled: 'ownerIdAlias'});
            this.blur();
            nullInput(e);
        });

        $('#projectDirectorAlias').on('focus', function (e) {	//项目主管绑定事件
            new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
            this.blur();
            nullInput(e);
        });

        $('#measureByAlias').on('focus', function (e) {	 //计量人员绑定事件
            new H5CommonSelect({type: 'userSelect', idFiled: 'measureBy', textFiled: 'measureByAlias'});
            this.blur();
            nullInput(e);
        });
		/*子表操作——结束*/
    });
</script>
</html>