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
    String formId = request.getParameter("id");
%>

<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsfrmlossproc/assetsFrmlossProcController/operation/toDetailJsp" -->
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

			<table class="form_commonTable">
				<tr>
					<th width="10%">
						<label for="frmlossNo">报损单编号:</label></th>
					<td width="15%">
						<input class="form-control input-sm" placeholder="系统自动生成" type="text" name="frmlossNo" id="frmlossNo" readonly/>
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
						<label for="unifiedId">统一编号:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="unifiedId" id="unifiedId" readonly onclick="relateAssets()"/>
					</td>

					<th width="10%">
						<label for="deviceName">设备名称:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="deviceName" id="deviceName" readonly onclick="relateAssets()"/>
					</td>

					<th width="10%">
						<label for="deviceModel">设备型号:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="deviceModel" id="deviceModel" readonly/>
					</td>

					<th width="10%">
						<label for="deviceSpec">设备规格:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="deviceSpec" id="deviceSpec" readonly/>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="manufacturerId">生产厂家:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="manufacturerId" id="manufacturerId" readonly/>
					</td>

					<th width="10%">
						<label for="createdDate">立卡日期:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="createdDate" id="createdDate" readonly/>
					</td>

					<th width="10%">
						<label for="positionId">安装地点ID:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="positionId" id="positionId" readonly/>
					</td>

					<th width="10%">
						<label for="ownerIdAlias">责任人:</label></th>
					<td width="15%">
						<input type="hidden" id="ownerId" name="ownerId" readonly>
						<input class="form-control input-sm" placeholder="请选择用户" type="text" id="ownerIdAlias" name="ownerIdAlias" readonly>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="ownerMobile">责任人联系电话:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="ownerMobile" id="ownerMobile"/>
					</td>

					<th width="10%">
						<label for="ownerDeptAlias">责任部门:</label></th>
					<td width="15%">
						<input type="hidden" id="ownerDept" name="ownerDept">
						<input class="form-control input-sm" placeholder="请选择部门" type="text" id="ownerDeptAlias" name="ownerDeptAlias" readonly>
					</td>

					<th width="10%">
						<label for="originalValue">账面原值:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="originalValue" id="originalValue" readonly/>
					</td>

					<th width="10%">
						<label for="totalDepreciation">累计折旧:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="totalDepreciation" id="totalDepreciation" readonly/>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="netValue">账面净值:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="netValue" id="netValue" readonly/>
					</td>

					<th width="10%">
						<label for="netSalvage">预计净残值:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="netSalvage" id="netSalvage" readonly/>
					</td>

					<th width="10%">
						<label for="deviceState">设备状态:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="deviceState" id="deviceState" title="" isNull="true" lookupCode="DEVICE_STATE"/>
					</td>

					<th width="10%">
						<label for="netLossValue">净报损金额:</label></th>
					<td width="15%">
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input  class="form-control"  type="text" name="netLossValue" id="netLossValue" data-min="0.001" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="recycleWarehouse">回收库:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="recycleWarehouse" id="recycleWarehouse" title="" isNull="true" lookupCode="RECOVERY_STORE"/>
					</td>

					<th width="10%">
						<label for="ifRecycle">是否已回收:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="ifRecycle" id="ifRecycle" title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"/>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="frmlossReason">报损原因:</label></th>
					<td width="90%" colspan="7">
						<textarea class="form-control input-sm" rows="3" name="frmlossReason" id="frmlossReason"></textarea>
					</td>
				</tr>

				<tr>
					<th width="10%">
						<label for="riskAnalysis">有关产品的风险分析:</label></th>
					<td width="90%" colspan="7">
						<textarea class="form-control input-sm" rows="3" name="riskAnalysis" id="riskAnalysis"></textarea>
					</td>
				</tr>

				<tr>
					<th><label for="attachment">附件</label></th>
					<td colspan="<%=4 * 2 - 1%>">
						<div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
					</td>
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
	<script type="text/javascript" src="avicit/assets/device/assetsfrmlossproc/js/AssetsFrmlossProcDetail.js"></script>
	<script type="text/javascript" src="static/js/platform/eform/common.js"></script>
	<script type="text/javascript" src="avicit/assets/device/assetsfrmlossproc/js/SelfStyleLayout.js"></script>

	<!-- 自动编码的js -->
	<script src="avicit/platform6/autocode/js/AutoCode.js"></script>

	<script type="text/javascript">
		//注册附件上传完毕后执行的方法
		var afterUploadEvent = null;

		function relateAssets(){
			var param =  '';
			openProductModelLayer ("true", "", "callBackFn", param);
		}

		$(document).ready(function () {
			//自动生成设备报损编号
			var autoCode = new AutoCode("ASSETS_FRMLOSS_PROC", "frmlossNo", false, "autoCodeValue", "123");

			//创建业务操作JS
			var assetsFrmlossProcDetail = new AssetsFrmlossProcDetail('form');

			//创建流程操作JS
			new FlowEditor(assetsFrmlossProcDetail);

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
			//初始化附件上传组件
			$('#attachment').uploaderExt({
				formId: '<%=formId%>',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: function () {
					return afterUploadEvent();
				}
			});
			//绑定表单验证规则
			assetsFrmlossProcDetail.formValidate($('#form'));

			$('#createdByDeptAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
				this.blur();
				nullInput(e);
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
		});
	</script>
</body>
</html>