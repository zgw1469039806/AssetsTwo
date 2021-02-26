<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@page import="avicit.platform6.api.session.SessionHelper" %>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>

<%
    String importlibs = "common,form,table,fileupload,tree";
    String pid = request.getParameter("id");
%>

<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>

	<%
		String userId = SessionHelper.getLoginSysUserId(request);
		SysUser user = SessionHelper.getLoginSysUser(request);
		String userName = user.getName();
		String userDeptId = SessionHelper.getCurrentDeptId(request);
		String userDeptName = SessionHelper.getCurrentDeptName(request);
	%>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

	<!-- 框架 样式 -->
	<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmbusiness/include2/common/css/style.css">

	<!-- 切换卡 样式 -->
	<link href="avicit/platform6/switch_card/yyui.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include2/buttons.jsp"%>

	<div id="formTab" style="display: none">
		<!-- 业务表单 Start -->
		<form id='form'>
			<input type="hidden" name="id" id="id"/>
			<input type="hidden" name="version" id="version"/>

			<div class="yyui_tab">
				<ul style="text-align:left;">
					<li class="yyui_tab_title_this" style="margin-left:10px;">基础信息</li>
				</ul>
				<div class="yyui_tab_content_this">
					<table class="form_commonTable">
						<tr>
							<th width="10%">
								<label id="acceptanceNoValue"></label>
							</th>
							<td width="90%" colspan="7">
								<input type="hidden" name="acceptanceNo" id="acceptanceNo"/>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="deviceName">设备名称:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="deviceName" id="deviceName"/>
							</td>

							<th width="10%">
								<label for="subscribeNo">申购单号:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="subscribeNo" id="subscribeNo"/>
							</td>

							<th width="10%">
								<label for="unifiedId">统一编号:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" readonly/>
							</td>

							<th width="10%">
								<label for="contractNum">合同编号:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="contractNum" id="contractNum"/>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="deviceCategoryNames">设备类别:</label></th>
							<td width="15%">
								<input type="hidden" id="deviceCategory" name="deviceCategory">
								<input class="form-control input-sm" placeholder="请选择设备类别" type="text" name="deviceCategoryNames" id="deviceCategoryNames" readonly/>
							</td>

							<th width="10%">
								<label for="createdByDeptAlias">申请人部门:</label></th>
							<td width="15%">
								<div class="input-group  input-group-sm">
									<input type="hidden" id="createdByDept" name="createdByDept" value="<%=userDeptId%>" readonly>
									<input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" value="<%=userDeptName%>">
									<span class="input-group-addon">
										<i class="glyphicon glyphicon-equalizer"></i>
									</span>
								</div>
							</td>

							<th width="10%">
								<label for="createdByAlias">申请人:</label></th>
							<td width="15%">
								<div class="input-group  input-group-sm">
									<input type="hidden" id="createdBy" name="createdBy" value="<%=userId%>" readonly>
									<input class="form-control" placeholder="请选择用户" type="text" id="createdByAlias" name="createdByAlias" value="<%=userName%>">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								</div>
							</td>

							<th width="10%">
								<label for="secretLevel">密级:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL"/>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="manufacturerId">生产厂家:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId"/>
							</td>

							<th width="10%">
								<label for="competentChiefEngineerAlias">主管总师:</label></th>
							<td width="15%">
								<div class="input-group  input-group-sm">
									<input type="hidden" id="competentChiefEngineer" name="competentChiefEngineer">
									<input class="form-control" placeholder="请选择用户" type="text" id="competentChiefEngineerAlias" name="competentChiefEngineerAlias">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								</div>
							</td>

							<th width="10%">
								<label for="ownerIdAlias">责任人:</label></th>
							<td width="15%">
								<div class="input-group  input-group-sm">
									<input type="hidden" id="ownerId" name="ownerId">
									<input class="form-control" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias">
									<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
								</div>
							</td>

							<th width="10%">
								<label for="ownerDeptAlias">责任人部门:</label></th>
							<td width="15%">
								<div class="input-group  input-group-sm">
									<input type="hidden" id="ownerDept" name="ownerDept" readonly>
									<input class="form-control" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" readonly>
									<span class="input-group-addon"><i class="glyphicon glyphicon-equalizer"></i></span>
								</div>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="ownerTel">责任人联系方式:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="ownerTel" id="ownerTel"/>
							</td>

							<th width="10%">
								<label for="setsCount">台(套)数:</label></th>
							<td width="15%">
								<div class="input-group input-group-sm spinner" data-trigger="spinner">
									<input class="form-control input-sm" type="text" name="setsCount" id="setsCount" value="1" readonly>
								</div>
							</td>

							<th width="10%">
								<label for="unitPrice">单价(元):</label></th>
							<td width="15%">
								<div class="input-group input-group-sm spinner" data-trigger="spinner">
									<input class="form-control" type="text" name="unitPrice" id="unitPrice" data-min="<%=Math.pow(10,-3)%>" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
									<span class="input-group-addon">
										<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
									</span>
								</div>
							</td>

							<th width="10%">
								<label for="projectDirectorAlias">项目主管:</label></th>
							<td width="15%">
								<div class="input-group  input-group-sm">
									<input type="hidden" id="projectDirector" name="projectDirector">
									<input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias">
									<span class="input-group-addon">
										<i class="glyphicon glyphicon-user"></i>
									</span>
								</div>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="ifRegularCheck">是否定检:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="ifRegularCheck" id="ifRegularCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
							</td>

							<th width="10%">
								<label for="ifSpotCheck">是否点检:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="ifSpotCheck" id="ifSpotCheck" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
							</td>

							<th width="10%">
								<label for="ifPrecisionInspection">是否精度检查:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="ifPrecisionInspection" id="ifPrecisionInspection" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
							</td>

							<th width="10%">
								<label for="ifUpkeep">是否保养:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="ifUpkeep" id="ifUpkeep" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="upkeepCycle">保养周期(天):</label></th>
							<td width="15%">
								<div class="input-group input-group-sm spinner" data-trigger="spinner">
									<input class="form-control" type="text" name="upkeepCycle" id="upkeepCycle" data-min="1" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
									<span class="input-group-addon">
										<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
									</span>
								</div>
							</td>

							<th width="10%">
								<label for="nextUpkeepDate">下次保养时间:</label></th>
							<td width="15%">
								<div class="input-group input-group-sm">
									<input class="form-control date-picker" type="text" name="nextUpkeepDate" id="nextUpkeepDate"/>
									<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
								</div>
							</td>

							<th width="10%">
								<label for="upkeepRequirements">保养要求:</label></th>
							<td width="40%" colspan="3">
								<textarea class="form-control input-sm" rows="3" name="upkeepRequirements" id="upkeepRequirements"></textarea>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="ifMeasure">是否计量:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="ifMeasure" id="ifMeasure" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
							</td>
							<th width="10%">
								<label for="ifInstall">是否需要安装:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="ifInstall" id="ifInstall" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
							</td>
							<th width="10%">
								<label for="ifMeasureOnsite">是否现场计量:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="ifMeasureOnsite" id="ifMeasureOnsite" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
							</td>
							<th width="10%">
								<label for="measureIdentify">计量标识:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="measureIdentify" id="measureIdentify"/>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="measureByAlias">计量人员:</label></th>
							<td width="15%">
								<div class="input-group  input-group-sm">
									<input type="hidden" id="measureBy" name="measureBy">
									<input class="form-control" placeholder="请选择用户" type="text" id="measureByAlias" name="measureByAlias">
									<span class="input-group-addon">
										<i class="glyphicon glyphicon-user"></i>
									</span>
								</div>
							</td>
							<th width="10%">
								<label for="meteringDate">计量时间:</label></th>
							<td width="15%">
								<div class="input-group input-group-sm">
									<input class="form-control date-picker" type="text" name="meteringDate" id="meteringDate"/>
									<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
								</div>
							</td>
							<th width="10%">
								<label for="meteringCycle">计量周期(天):</label></th>
							<td width="15%">
								<div class="input-group input-group-sm spinner" data-trigger="spinner">
									<input class="form-control" type="text" name="meteringCycle" id="meteringCycle" data-min="1" data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
									<span class="input-group-addon">
										<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
									</span>
								</div>
							</td>
							<th width="10%">
								<label for="positionId">安装地点:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="positionId" id="positionId"/>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="ifHasComputer">是否含计算机/无线模板:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="ifHasComputer" id="ifHasComputer" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
							</td>
							<th width="10%">
								<label for="isSafetyProduction">是否涉及安全生产:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="isSafetyProduction" id="isSafetyProduction" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
							</td>
							<th width="10%">
								<label for="financialResources">经费来源:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources" title="" isNull="true" lookupCode="FINANCIAL_RESOURCES"/>
							</td>
							<th width="10%">
								<label for="belongProject">所属项目:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="belongProject" id="belongProject"/>
							</td>
						</tr>
						<tr>
							<th width="10%">
								<label for="projectNo">项目序号:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="projectNo" id="projectNo"/>
							</td>
							<th width="10%">
								<label for="replyName">批复名称:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="replyName" id="replyName"/>
							</td>
							<th width="10%">
								<label for="projectApprovalNo">立项单号:</label></th>
							<td width="15%">
								<input class="form-control input-sm" type="text" name="projectApprovalNo" id="projectApprovalNo"/>
							</td>
							<th width="10%">
								<label for="abcCategory">ABC分类:</label></th>
							<td width="15%">
								<pt6:h5select css_class="form-control input-sm" name="abcCategory" id="abcCategory" title="" isNull="true" lookupCode="ABC_CATEGORY"/>
							</td>
						</tr>
						<tr>
							<th><label for="attachment">附件</label></th>
							<td colspan="<%=4 * 2 - 1%>">
								<div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>

		<div class="yyui_tab" id="largeFieldRegion" style="margin-top:30px;">
			<ul style="text-align:left;">
				<li style="margin-left:10px;" class="yyui_tab_title_this">设备组成附件</li>
			</ul>
			<div class="yyui_tab_content_this">
				<table class="form_commonTable">
					<tr>
						<th width="99%" colspan="<%=4 * 2 %>">
							<div id="toolbar_AcceptanceDeviceComponent" class="toolbar">
								<div class="toolbar-left">
									<sec:accesscontrollist hasPermission="3" domainObject="formdialog_AcceptanceDeviceComponent_button_add" permissionDes="添加">
										<a id="acceptanceDeviceComponent_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button" title="添加">
											<i class="fa fa-plus"></i> 添加
										</a>
									</sec:accesscontrollist>
									<sec:accesscontrollist hasPermission="3" domainObject="formdialog_AcceptanceDeviceComponent_button_delete" permissionDes="删除">
										<a id="acceptanceDeviceComponent_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button" title="删除">
											<i class="fa fa-trash-o"></i> 删除
										</a>
									</sec:accesscontrollist>
								</div>
							</div>
							<table id="acceptanceDeviceComponent" name="ACCEPTANCE_DEVICE_COMPONENT" class="customform_subtable_bpm_auth"></table>
							<pt6:h5resource label="主设备ID" name="deviceId" ref_table="ACCEPTANCE_DEVICE_COMPONENT"></pt6:h5resource>
							<pt6:h5resource label="主设备统一编号" name="parentUnifiedId" ref_table="ACCEPTANCE_DEVICE_COMPONENT"></pt6:h5resource>
							<pt6:h5resource label="组件名称" name="componentName" ref_table="ACCEPTANCE_DEVICE_COMPONENT"></pt6:h5resource>
							<pt6:h5resource label="组件类别" name="componentCategory" ref_table="ACCEPTANCE_DEVICE_COMPONENT"></pt6:h5resource>
							<pt6:h5resource label="组件型号" name="componentModel" ref_table="ACCEPTANCE_DEVICE_COMPONENT"></pt6:h5resource>
						</th>
					</tr>
				</table>

			</div>
		</div>
		<!-- 业务表单 End -->
	</div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<!-- 框架脚本 -->
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/jquery.dragsort-0.5.2.min.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/nav.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include2/common/js/main.js"></script>


	<!-- 流程的js -->
	<script src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/CommonActor.js"></script>
	<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/buttons/BpmActor.js"></script>
	<script src="avicit/platform6/bpmreform/bpmbusiness/include2/src/FlowEditor.js"></script>

	<!-- 业务的js -->
	<script type="text/javascript" src="avicit/assets/device/assetsustdtempacceptance/js/AssetsUstdtempAcceptanceDetail.js"></script>
	<script type="text/javascript" src="avicit/assets/device/assetsustdtempacceptance/js/AcceptanceDeviceComponent.js"></script>
	<script type="text/javascript" src="avicit/assets/device/assetsustdtempacceptance/js/SelfStyleLayout.js"></script>
	<script type="text/javascript" src="static/js/platform/eform/common.js"></script>


	<!-- 切换卡的js -->
	<script src="avicit/platform6/switch_card/yyui.js"></script>

	<!-- 自动编码的js -->
	<script src="avicit/platform6/autocode/js/AutoCode.js"></script>

	<script type="text/javascript">
		//后台获取的通用代码数据
		//初始化通用代码值
		function initOnceInAdd() {
			avicAjax.ajax({
				url: "platform/assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/getLookUpCode",
				type: 'post',
				dataType: 'json',
				async: false,
				success: function (r) {
					if (r.flag == "success") {
					} else {
						layer.alert('获取失败！' + r.error, {
								icon: 7,
								area: ['400px', ''], //宽高
								closeBtn: 0,
								btn: ['关闭'],
								title: "提示"
							}
						);
					}
				}
			});
		};
		var pid;

		var afterUploadEvent = null;
		var acceptanceDeviceComponentGridColModel = null;
		$(document).ready(function () {
			//自动生成非标设备验收单编号
			var autoCode = new AutoCode("ASSETS_USTDTEMP_ACCEPTANCE", "acceptanceNo", false, "autoCodeValue", "123");

			pid = "<%=pid%>";
			var isReload = "true";
			var searchSubNames = "";
			initOnceInAdd(); //初始化通用代码值

			acceptanceDeviceComponentGridColModel = [
				{label: 'id', name: 'id', key: true, width: 75, hidden: true}
				, {label: '主设备ID', name: 'deviceId', width: 150, hidden: true}
				, {label: '主设备统一编号', name: 'parentUnifiedId', width: 150}
				, {label: '组件名称', name: 'componentName', width: 150}
				, {label: '组件类别', name: 'componentCategory', width: 150}
				, {label: '组件型号', name: 'componentModel', width: 150}
			];

			var surl = "platform/assets/device/assetsustdtempacceptance/assetsUstdtempAcceptanceController/operation/sub/";
			var acceptanceDeviceComponent = new AcceptanceDeviceComponent('acceptanceDeviceComponent', surl,
				"formSub", acceptanceDeviceComponentGridColModel, 'searchDialogSub', pid, searchSubNames, 'acceptanceDeviceComponent_keyWord', isReload);

			//创建业务操作JS
			var assetsUstdtempAcceptanceDetail = new AssetsUstdtempAcceptanceDetail('form', acceptanceDeviceComponent);

			//创建流程操作JS
			new FlowEditor(assetsUstdtempAcceptanceDetail);

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
			$('.date-picker').datepicker({yearRange: "c-100:c+10"}); //时间控件增加年度选择

			//绑定表单验证规则
			assetsUstdtempAcceptanceDetail.formValidate($('#form'));

			//初始化附件上传组件
			$('#attachment').uploaderExt({
				formId: '<%=pid%>',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function () {
					return afterUploadEvent();
				}
			});

			$('#acceptanceDeviceComponent_del').bind('click', function () {	//删除按钮绑定事件
				acceptanceDeviceComponent.del();
			});

			$('#competentChiefEngineerAlias').on('focus', function (e) {	//主管总师绑定事件
				new H5CommonSelect({
					type: 'userSelect',
					idFiled: 'competentChiefEngineer',
					textFiled: 'competentChiefEngineerAlias'
				});
				this.blur();
				nullInput(e);
			});

			//弹框选择责任人后，自动补充责任人部门信息
			$('#ownerIdAlias').on('blur', function (e) {
				var userId = document.getElementById('ownerId').value;

				if((userId != null) && (userId != undefined) && (userId != '')){
					$.ajax({
						url: "assets/device/assetstechtransformperson/assetsTechTransformPersonController/operation/userInfo",
						data: userId,
						contentType: 'application/json',
						type: 'post',
						dataType: 'json',
						success: function (r) {
							console.log(r);
							if (r.flag == "success") {
								if((r.userDto.deptName != null) && (r.userDto.deptName != undefined)){
									$("#ownerDeptAlias").val(r.userDto.deptName);   //设置b部门名称
									$("#ownerDept").val(r.userDto.deptId);   //设置部门id
								}
							} else {
								layer.alert('用户信息获取失败,请联系管理员!', {
											icon: 7,
											area: ['400px', ''], //宽高
											closeBtn: 0,
											btn: ['关闭'],
											title: "提示"
										}
								);
							}
						}
					});
				}
			});

			$('#deviceCategoryNames').on('focus', function (e) {	//设备分类绑定事件
				//获取当前已选中的分类
				var defaultLoadCategoryId = $('#deviceCategory').val();

				new H5CommonSelect({type: 'categorySelect', idFiled: 'deviceCategory', textFiled: 'deviceCategoryNames', currentCategory: 'NationalStandard', defaultLoadCategoryId: defaultLoadCategoryId});
				this.blur();
				nullInput(e);
			});

			$('#projectDirectorAlias').on('focus', function (e) {	//项目主管绑定事件
				new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
				this.blur();
				nullInput(e);
			});

			$('#measureByAlias').on('focus', function (e) {		//计量人员绑定事件
				new H5CommonSelect({type: 'userSelect', idFiled: 'measureBy', textFiled: 'measureByAlias'});
				this.blur();
				nullInput(e);
			});

			$('#ownerIdAlias').on('focus', function (e) {	//责任人绑定事件
				new H5CommonSelect({type: 'userSelect', idFiled: 'ownerId', textFiled: 'ownerIdAlias'});
				this.blur();
				nullInput(e);
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
		});

		window.onload = function (ev) {
			//为验收单号标题行赋值
			var acceptanceNoValueEle = document.getElementById('acceptanceNoValue');
			acceptanceNoValueEle.innerHTML = document.getElementById('acceptanceNo').value;
		}
	</script>
</body>
</html>