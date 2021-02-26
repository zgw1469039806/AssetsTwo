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
    <!-- ControllerPath = "assets/device/assetsallotproc/assetsAllotProcController/operation/toDetailJsp" -->
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
</head>

<body>
	<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include2/buttons.jsp"%>

	<div id="formTab" style="display: none">
		<!-- 业务表单 Start -->
		<form id='form'>
			<input type="hidden" name="id" id="id"/>
			<input type="hidden" name="version" id="version"/>
			<input type="hidden" id="attribute09" name="attribute09">

			<table class="form_commonTable">
				<tr>
					<th width="10%">
						<label for="allotNo">调拨单号:</label></th>
					<td width="15%">
						<input class="form-control input-sm" placeholder="系统自动生成" type="text" name="allotNo" id="allotNo"/>
					</td>

					<th width="10%">
						<label for="createdByAlias">申请人:</label></th>
					<td width="15%">
						<input type="hidden" id="createdBy" name="createdBy" value="<%=userId%>" readonly>
						<input class="form-control" placeholder="请选择用户" type="text" id="createdByAlias" name="createdByAlias"  value="<%=userName%>" readonly>
					</td>

					<th width="10%">
						<label for="createdByDeptAlias">申请人部门:</label></th>
					<td width="15%">
						<input type="hidden" id="createdByDept" name="createdByDept" value="<%=userDeptId%>">
						<input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" value="<%=userDeptName%>">
					</td>

					<th width="10%">
						<label for="createdByTel">申请人电话:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel" value="<%=user.getMobile()%>"/>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="callinDeptAlias">调入部门:</label></th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="callinDept" name="callinDept">
							<input class="form-control" placeholder="请选择部门" type="text" id="callinDeptAlias" name="callinDeptAlias">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-equalizer"></i>
							</span>
						</div>
					</td>

					<td></td><td></td>
					<td></td><td></td>
					<td></td><td></td>
					<td></td><td></td>
				</tr>

				<tr>
					<th width="10%">
						<label for="assetsCompose">设备组成:</label></th>
					<td width="90%" colspan="7">
						<textarea class="form-control input-sm" rows="3" name="assetsCompose" id="assetsCompose"></textarea>
					</td>
				</tr>

				<tr>
					<th><label for="attachment">附件</label></th>
					<td colspan="<%=4 * 2 - 1%>">
						<div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
					</td>
				</tr>

				<tr>
					<th width="99%" colspan="<%=4 * 2 %>">
						<div id="toolbar_AllotAssets" class="toolbar">
							<div class="toolbar-left">
								<sec:accesscontrollist hasPermission="3" domainObject="formdialog_AllotAssets_button_add" permissionDes="添加">
									<a id="allotAssets_insert" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button" title="添加">
										<i class="fa fa-plus"></i> 添加
									</a>
								</sec:accesscontrollist>
								<sec:accesscontrollist hasPermission="3" domainObject="formdialog_AllotAssets_button_delete" permissionDes="删除">
									<a id="allotAssets_del" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm bpm_self_class" role="button" title="删除">
										<i class="fa fa-trash-o"></i> 删除
									</a>
								</sec:accesscontrollist>
							</div>
						</div>

						<table id="allotAssets" name="ALLOT_ASSETS" class="customform_subtable_bpm_auth"></table>
						<pt6:h5resource label="统一编号" name="unifiedId" ref_table="ALLOT_ASSETS"></pt6:h5resource>
						<pt6:h5resource label="设备名称" name="deviceName" ref_table="ALLOT_ASSETS"></pt6:h5resource>
						<pt6:h5resource label="设备型号" name="deviceModel" ref_table="ALLOT_ASSETS"></pt6:h5resource>
						<pt6:h5resource label="设备规格" name="deviceSpec" ref_table="ALLOT_ASSETS"></pt6:h5resource>
						<pt6:h5resource label="生产厂家" name="manufacturerId" ref_table="ALLOT_ASSETS"></pt6:h5resource>
						<pt6:h5resource label="密级" name="secretLevelName" ref_table="ALLOT_ASSETS"></pt6:h5resource>
						<pt6:h5resource label="是否涉及安全生产" name="isSafetyProductionName" ref_table="ALLOT_ASSETS"></pt6:h5resource>
					</th>
				</tr>
			</table>
		</form>
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
	<script type="text/javascript" src="avicit/assets/device/assetsallotproc/js/AssetsAllotProcDetail.js"></script>
	<script type="text/javascript" src="avicit/assets/device/assetsallotproc/js/AllotAssets.js"></script>
	<script type="text/javascript" src="static/js/platform/eform/common.js"></script>
	<script type="text/javascript" src="avicit/assets/device/assetsallotproc/js/SelfStyleLayout.js"></script>

	<!-- 自动编码的js -->
	<script src="avicit/platform6/autocode/js/AutoCode.js"></script>


	<script type="text/javascript">
		//后台获取的通用代码数据
		var secretLevelData = null;
		var isSafetyProductionData = null;

		//初始化通用代码值
		function initOnceInAdd() {
			avicAjax.ajax({
				url: "platform/assets/device/assetsallotproc/assetsAllotProcController/getLookUpCode",
				type: 'post',
				dataType: 'json',
				async: false,
				success: function (r) {
					if (r.flag == "success") {
						secretLevelData = JSON.parse(r.secretLevelData);
						isSafetyProductionData = JSON.parse(r.isSafetyProductionData);
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

		var afterUploadEvent = null;
		var allotAssetsGridColModel = null;

		$(document).ready(function () {
			//自动生成设备事故编号
			var autoCode = new AutoCode("ASSETS_ALLOT_PROC", "allotNo", false, "autoCodeValue", "123");

			var pid = "<%=pid%>";
			var isReload = "true";
			var searchSubNames = "";
			initOnceInAdd(); //初始化通用代码值

			allotAssetsGridColModel = [
				  {label: 'id', name: 'id', key: true, width: 75, hidden: true}
				, {label: '统一编号', name: 'unifiedId', width: 150}
				, {label: '设备名称', name: 'deviceName', width: 150}
				, {label: '设备型号', name: 'deviceModel', width: 150}
				, {label: '设备规格', name: 'deviceSpec', width: 150}
				, {label: '生产厂家', name: 'manufacturerId', width: 150}
				, {label: '密级id', name: 'secretLevel', width: 75, hidden: true}
				, {
					label: '密级',
					name: 'secretLevelName',
					width: 150,
					edittype: "custom",
					editoptions: {
						custom_element: selectElem,
						custom_value: selectValue,
						forId: 'secretLevel',
						value: secretLevelData
					}
				}
				, {label: '是否涉及安全生产id', name: 'isSafetyProduction', width: 75, hidden: true}
				, {
					label: '是否涉及安全生产',
					name: 'isSafetyProductionName',
					width: 150,
					edittype: "custom",
					editoptions: {
						custom_element: selectElem,
						custom_value: selectValue,
						forId: 'isSafetyProduction',
						value: isSafetyProductionData
					}
				}
			];

			var surl = "platform/assets/device/assetsallotproc/assetsAllotProcController/operation/sub/";
			var allotAssets = new AllotAssets('allotAssets', surl, "formSub", allotAssetsGridColModel, 'searchDialogSub', pid, searchSubNames, 'allotAssets_keyWord', isReload);

			//创建业务操作JS
			var assetsAllotProcDetail = new AssetsAllotProcDetail('form', allotAssets);

			//创建流程操作JS
			new FlowEditor(assetsAllotProcDetail);

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
			assetsAllotProcDetail.formValidate($('#form'));

			//初始化附件上传组件
			$('#attachment').uploaderExt({
				formId: '<%=pid%>',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function () {
					return afterUploadEvent();
				}
			});

			//添加按钮绑定事件
			$('#allotAssets_insert').bind('click', function () {
				var param =  '';
				openProductModelLayer ("false", "", "callBackFn", param);
			});

			//删除按钮绑定事件
			$('#allotAssets_del').bind('click', function () {
				allotAssets.del();
			});

			$('#createdByDeptAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
				this.blur();
				nullInput(e);
			});

			$('#callinDeptAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'deptSelect', idFiled: 'callinDept', textFiled: 'callinDeptAlias'});
				this.blur();
				nullInput(e);
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
		});
	</script>
</body>
</html>