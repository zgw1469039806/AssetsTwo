<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String importlibs = "common,form,fileupload";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetsustdregisterproc/assetsUstdregisterProcController/operation/Edit/id" -->
    <title>编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version" value="<c:out  value='${assetsUstdregisterProcDTO.version}'/>"/>
			<input type="hidden" name="id" value="<c:out  value='${assetsUstdregisterProcDTO.id}'/>"/>
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="registerNo">非标立项编号:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="registerNo" id="registerNo" value="<c:out  value='${assetsUstdregisterProcDTO.registerNo}'/>"/>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="createdByAlias">申请人:</label></th>
					<td width="15%">
						<input type="hidden" id="createdBy" name="createdBy" value="<c:out value='${assetsUstdregisterProcDTO.createdBy}'/>" readonly>
						<input class="form-control" placeholder="请选择用户" type="text" id="createdByAlias" name="createdByAlias" value="<c:out value='${assetsUstdregisterProcDTO.createdByAlias}'/>" readonly>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="createdByDeptAlias">申请人部门:</label></th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="createdByDept" name="createdByDept" value="<c:out value='${assetsUstdregisterProcDTO.createdByDept}'/>">
							<input class="form-control" placeholder="请选择部门" type="text" id="createdByDeptAlias" name="createdByDeptAlias" value="<c:out value='${assetsUstdregisterProcDTO.createdByDeptAlias}'/>" readonly>
						</div>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="createdByTel">申请人电话:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="createdByTel" id="createdByTel" value="<c:out  value='${assetsUstdregisterProcDTO.createdByTel}'/>"/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="formState">单据状态:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="formState" id="formState" value="<c:out  value='${assetsUstdregisterProcDTO.formState}'/>"/>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="deviceName">设备名称:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="deviceName" id="deviceName" value="<c:out  value='${assetsUstdregisterProcDTO.deviceName}'/>"/>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="deviceCategory">设备类别:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="deviceCategory" id="deviceCategory" title="" isNull="true" lookupCode="DEVICE_CATEGORY" defaultValue='${assetsUstdregisterProcDTO.deviceCategory}'/>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="techInchargeAlias">技术负责人:</label></th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="techIncharge" name="techIncharge" value="<c:out  value='${assetsUstdregisterProcDTO.techIncharge}'/>">
							<input class="form-control" placeholder="请选择用户" type="text" id="techInchargeAlias" name="techInchargeAlias" value="<c:out  value='${assetsUstdregisterProcDTO.techInchargeAlias}'/>">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="projectDirectorAlias">项目主管:</label></th>
					<td width="15%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="projectDirector" name="projectDirector" value="<c:out  value='${assetsUstdregisterProcDTO.projectDirector}'/>">
							<input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias" value="<c:out  value='${assetsUstdregisterProcDTO.projectDirectorAlias}'/>">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="singleOrSet">台/套:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="singleOrSet" id="singleOrSet" title="" isNull="true" lookupCode="SINGLE_OR_SET" defaultValue='${assetsUstdregisterProcDTO.singleOrSet}'/>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="setCount">台(套)数:</label></th>
					<td width="15%">
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input class="form-control" type="text" name="setCount" id="setCount" value="<c:out  value='${assetsUstdregisterProcDTO.setCount}'/>" data-min="1"  data-max="<%=Math.pow(10,12)-Math.pow(10,-0)%>" data-step="1" data-precision="0">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="budgetPrice">预算单价:</label></th>
					<td width="15%">
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input class="form-control" type="text" name="budgetPrice" id="budgetPrice" value="<c:out  value='${assetsUstdregisterProcDTO.budgetPrice}'/>" data-min="0.001" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="financialEstimate">经费概算:</label></th>
					<td width="15%">
						<div class="input-group input-group-sm spinner" data-trigger="spinner">
							<input class="form-control" type="text" name="financialEstimate" id="financialEstimate" value="<c:out  value='${assetsUstdregisterProcDTO.financialEstimate}'/>" data-min="0.001" data-max="<%=Math.pow(10,12)-Math.pow(10,-3)%>" data-step="1" data-precision="3">
							<span class="input-group-addon">
								<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
							</span>
						</div>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="financialResources">经费来源:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="financialResources" id="financialResources" title="" isNull="true" lookupCode="FINANCIAL_RESOURCES" defaultValue='${assetsUstdregisterProcDTO.financialResources}'/>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="belongProject">所属项目:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="belongProject" id="belongProject" value="<c:out  value='${assetsUstdregisterProcDTO.belongProject}'/>"/>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="projectNo">项目序号:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="projectNo" id="projectNo" value="<c:out  value='${assetsUstdregisterProcDTO.projectNo}'/>"/>
					</td>

					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="simpleOrLarge">简易/大型设备:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="simpleOrLarge" id="simpleOrLarge" title="" isNull="true" lookupCode="SIMPLE_LARGE_SCALE" defaultValue='${assetsUstdregisterProcDTO.simpleOrLarge}'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="installPosition">安装地点:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="installPosition" id="installPosition"
							   value="<c:out  value='${assetsUstdregisterProcDTO.installPosition}'/>"/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="isSatisfyBearing">安装设备楼层承重能否满足:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="isSatisfyBearing" id="isSatisfyBearing"
									  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.isSatisfyBearing}'/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="hasOutdoorUnit">设备是否有室外机:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="hasOutdoorUnit" id="hasOutdoorUnit" title=""
									  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.hasOutdoorUnit}'/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="isAllowOutdoorunit">所安装位置是否允许安装室外机:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="isAllowOutdoorunit" id="isAllowOutdoorunit"
									  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.isAllowOutdoorunit}'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="hasFoundation">所安装位置是否具备设置地基条件:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="hasFoundation" id="hasFoundation" title=""
									  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.hasFoundation}'/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="useVoltage">使用电压:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="useVoltage" id="useVoltage"
							   value="<c:out  value='${assetsUstdregisterProcDTO.useVoltage}'/>"/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="hasVoltageCondition">安装位置是否具备电压条件:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="hasVoltageCondition" id="hasVoltageCondition"
									  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.hasVoltageCondition}'/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="hasHumidityNeed">是否有温湿度要求:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="hasHumidityNeed" id="hasHumidityNeed" title=""
									  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.hasHumidityNeed}'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="humidityNeed">温湿度要求:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="humidityNeed" id="humidityNeed"
							   value="<c:out  value='${assetsUstdregisterProcDTO.humidityNeed}'/>"/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="hasCleanlinessNeed">是否有洁净度要求:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="hasCleanlinessNeed" id="hasCleanlinessNeed"
									  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.hasCleanlinessNeed}'/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="cleanlinessNeed">净度要求:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="cleanlinessNeed" id="cleanlinessNeed"
							   value="<c:out  value='${assetsUstdregisterProcDTO.cleanlinessNeed}'/>"/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="hasWaterNeed">是否有用水要求:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="hasWaterNeed" id="hasWaterNeed" title=""
									  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.hasWaterNeed}'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="waterNeed">用水要求:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="waterNeed" id="waterNeed"
							   value="<c:out  value='${assetsUstdregisterProcDTO.waterNeed}'/>"/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="hasGasNeed">是否有用气要求:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="hasGasNeed" id="hasGasNeed" title=""
									  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.hasGasNeed}'/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="gasNeed">用气要求:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="gasNeed" id="gasNeed"
							   value="<c:out  value='${assetsUstdregisterProcDTO.gasNeed}'/>"/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="hasLetNeed">是否有气体排放要求:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="hasLetNeed" id="hasLetNeed" title=""
									  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.hasLetNeed}'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="letNeed">气体排放要求:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="letNeed" id="letNeed"
							   value="<c:out  value='${assetsUstdregisterProcDTO.letNeed}'/>"/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="hasOtherNeed">是否有其他特殊要求:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="hasOtherNeed" id="hasOtherNeed" title=""
									  isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.hasOtherNeed}'/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="otherNeed">其他特殊要求:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="otherNeed" id="otherNeed"
							   value="<c:out  value='${assetsUstdregisterProcDTO.otherNeed}'/>"/>
					</td>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="hasAboveConditions">以上需求条件在拟安装地点是否都已具备:</label></th>
					<td width="15%">
						<pt6:h5select css_class="form-control input-sm" name="hasAboveConditions" id="hasAboveConditions"
									  title="" isNull="true" lookupCode="PLATFORM_YES_NO_FLAG"
									  defaultValue='${assetsUstdregisterProcDTO.hasAboveConditions}'/>
					</td>
				</tr>
				<tr>
					<th width="10%" style="word-break:break-all;word-warp:break-word;">
						<label for="supplementaryNotes">条件不具备补充说明:</label></th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="supplementaryNotes" id="supplementaryNotes"
							   value="<c:out  value='${assetsUstdregisterProcDTO.supplementaryNotes}'/>"/>
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
	</div>
	<div data-options="region:'south',border:false" style="height: 60px;">
		<div id="toolbar"
			 class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="assetsUstdregisterProc_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="assetsUstdregisterProc_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<script type="text/javascript">
		function closeForm() {
			parent.assetsUstdregisterProc.closeDialog(window.name);
		}

		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				$(isValidate.errorList[0].element).focus();
				return false;
			}
			//验证附件密级
			var files = $('#attachment').uploaderExt('getUploadFiles');
			for (var i = 0; i < files.length; i++) {
				var name = files[i].name;
				var secretLevel = files[i].secretLevel;
				//这里验证密级
			}
			//限制保存按钮多次点击
			$('#assetsUstdregisterProc_saveForm').addClass('disabled').unbind("click");
			parent.assetsUstdregisterProc.save($('#form'), window.name, callback);
		}

		//附件操作
		function callback(id) {
			var files = $('#attachment').uploaderExt('getUploadFiles');
			if (files == 0) {
				closeForm();
			} else {
				$("#id").val(id);
				$('#attachment').uploaderExt('doUpload', id);
			}
		}//上传附件完成后操作
		function afterUploadEvent() {
			closeForm();
		}

		/**
		 * 加载完后初始化
		 */
		$(document).ready(function () {
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

			$('#attachment').uploaderExt({	//初始化附件上传组件
				formId: '${assetsUstdregisterProcDTO.id}',
				secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
				afterUpload: afterUploadEvent
			});

			parent.assetsUstdregisterProc.formValidate($('#form'));	//绑定表单验证规则

			$('#assetsUstdregisterProc_saveForm').bind('click', function () {	//保存按钮绑定事件
				saveForm();
			});

			$('#assetsUstdregisterProc_closeForm').bind('click', function () {	//返回按钮绑定事件
				closeForm();
			});

			$('#techInchargeAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'userSelect', idFiled: 'techIncharge', textFiled: 'techInchargeAlias'});
				this.blur();
				nullInput(e);
			});
			$('#projectDirectorAlias').on('focus', function (e) {
				new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
				this.blur();
				nullInput(e);
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
		});
	</script>
</body>
</html>