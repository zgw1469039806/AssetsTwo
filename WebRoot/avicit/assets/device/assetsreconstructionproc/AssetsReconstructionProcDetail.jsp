<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,table,fileupload,tree";
    String formId = request.getParameter("id");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsreconstructionproc/assetsReconstructionProcController/operation/toDetailJsp" -->
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>详细</title>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

	<!-- 框架 样式 -->
	<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmbusiness/include2/common/css/style.css">
</head>
<body>
<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include2/buttons.jsp"%>
<div id="formTab" style="display: none">
	<h2 align="center">设备大修改造申请</h2>
	<!-- 业务表单 Start -->
	<form id='form'>
		<input type="hidden" name="id" id="id"/>
		<input type="hidden" name="version" id="version"/>
		<table class="form_commonTable">
			<tr>
				<th width="10%">
					<label for="reconstructionId">改造申请单号:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="reconstructionId" placeholder="系统自动生成"
						   id="reconstructionId"/>
				</td>
				<th width="10%">
					<label for="createdByDeptAlias">申请人部门:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="createdByDept" name="createdByDept">
						<input class="form-control" placeholder="请选择部门" type="text"
							   id="createdByDeptAlias" name="createdByDeptAlias">
						<span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
					</div>
				</td>
				<th width="10%">
					<label for="formState">单据状态:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="formState"
						   id="formState"/>
				</td>
				<th width="10%">
					<label for="ownerDeptAlias">责任部门:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="ownerDept" name="ownerDept">
						<input class="form-control" placeholder="请选择部门" type="text"
							   id="ownerDeptAlias" name="ownerDeptAlias">
						<span class="input-group-addon">
										        <i class="glyphicon glyphicon-equalizer"></i>
										      </span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%">
					<label for="ownerIdAlias">责任人:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="ownerId" name="ownerId">
						<input class="form-control" placeholder="请选择用户" type="text"
							   id="ownerIdAlias" name="ownerIdAlias">
						<span class="input-group-addon">
										         <i class="glyphicon glyphicon-user"></i>
										      </span>
					</div>
				</td>
				<th width="10%">
					<label for="ownerTel">责任人联系方式:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="ownerTel" id="ownerTel"/>
				</td>
				<th width="10%">
					<label for="deviceName">设备名称:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="deviceName"
						   id="deviceName"/>
				</td>
				<th width="10%">
					<label for="secretLevel">密级:</label></th>
				<td width="15%">
					<pt6:h5select css_class="form-control input-sm" name="secretLevel"
								  id="secretLevel" title="" isNull="true"
								  lookupCode="SECRET_LEVEL"/>
				</td>
			</tr>
			<tr>
				<th width="10%">
					<label for="unifiedId">统一编号:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="unifiedId"
						   id="unifiedId"/>
				</td>
				<th width="10%">
					<label for="deviceModel">设备型号:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="deviceModel"
						   id="deviceModel"/>
				</td>
				<th width="10%">
					<label for="deviceSpec">设备规格:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="deviceSpec"
						   id="deviceSpec"/>
				</td>
				<th width="10%">
					<label for="manufacturerId">生产厂家:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="manufacturerId"
						   id="manufacturerId"/>
				</td>
			</tr>
			<tr>
				<th width="10%">
					<label for="likaDate">立卡时间:</label></th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text" name="likaDate"
							   id="likaDate"/><span class="input-group-addon"><i
							class="glyphicon glyphicon-calendar"></i></span>
					</div>
				</td>
				<th width="10%">
					<label for="originalValue">设备原值:</label></th>
				<td width="15%">
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input class="form-control" type="text" name="originalValue"
							   id="originalValue" data-min="-<%=Math.pow(10,12)-Math.pow(10,-3)%>"
							   data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1"
							   data-precision="3">
						<span class="input-group-addon">
													    <a href="javascript:;" class="spin-up" data-spin="up"><i
																class="glyphicon glyphicon-triangle-top"></i></a>
													    <a href="javascript:;" class="spin-down" data-spin="down"><i
																class="glyphicon glyphicon-triangle-bottom"></i></a>
													  </span>
					</div>
				</td>
				<th width="10%">
					<label for="budget">经费预算:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="budget" id="budget"/>
				</td>


			</tr>
			<tr>
				<th width="10%" >
					<label for="existingPerformance">现有结构性能指标:</label></th>
				<td width="90%" colspan="<%=4 * 2 - 1%>">
                                        <textarea class="form-control input-sm" rows="3" name="existingPerformance"
												  id="existingPerformance"></textarea>
				</td>
			</tr>
			<tr>
				<th width="10%" >
					<label for="reformingReason">改造理由:</label></th>
				<td width="90%" colspan="<%=4 * 2 - 1%>">
                                        <textarea class="form-control input-sm" rows="3" name="reformingReason"
												  id="reformingReason"></textarea>
				</td>
			</tr>
			<tr>
				<th width="10%" >
					<label for="afterPerformance">改造后结构性能指标:</label></th>
				<td width="90%" colspan="<%=4 * 2 - 1%>">
                                        <textarea class="form-control input-sm" rows="3" name="afterPerformance"
												  id="afterPerformance"></textarea>
				</td>
			</tr>
			<tr>

				<th width="10%">
					<label for="transformWay">改造途径:</label></th>
				<td width="90%" colspan="<%=4 * 2 - 1%>" >
                                        <textarea class="form-control input-sm" rows="3" name="transformWay"
												  id="transformWay"></textarea>
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
<script src="avicit/assets/device/assetsreconstructionproc/js/AssetsReconstructionProcDetail.js"></script>
<script src="avicit/assets/device/assetsreconstructionproc/js/SelfStyleLayout.js"></script>
<!-- 自动编码的js -->
<script src="avicit/platform6/autocode/js/AutoCode.js"></script>
<script type="text/javascript">
    //注册附件上传完毕后执行的方法
    var afterUploadEvent = null;
    $(document).ready(function () {
		var autoCode = new AutoCode("ASSETS_RECONSTRUCTION_PROC", "reconstructionId", false, "autoCodeValue", "123");
        //创建业务操作JS
        var assetsReconstructionProcDetail = new AssetsReconstructionProcDetail('form');
        //创建流程操作JS
        new FlowEditor(assetsReconstructionProcDetail);

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
        assetsReconstructionProcDetail.formValidate($('#form'));

        $('#createdByDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'createdByDept', textFiled: 'createdByDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#ownerDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDept', textFiled: 'ownerDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#ownerIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerId', textFiled: 'ownerIdAlias'});
            this.blur();
            nullInput(e);
        });

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>