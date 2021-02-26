<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/msystem/sysmsg/sysMsgController/operation/Edit/id" -->
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version"
				value='<c:out  value='${sysMsgDTO.version}'/>' /> <input
				type="hidden" name="id"
				value='<c:out  value='${sysMsgDTO.id}'/>' />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="title">消息的标题:</label></th>
					<td width="88%"><input class="form-control input-sm"
						type="text" name="title" id="title"
						value='<c:out  value='${sysMsgDTO.title}'/>' /></td>
				</tr>
				<tr>
					<th width="10%"><label for="content">消息的内容，可以含有HTML标签:</label></th>
					<td width="88%"><textarea class="form-control input-sm"
							rows="3" name="content" id="content">
							<c:out value='${sysMsgDTO.content}' />
						</textarea></td>
				</tr>
				<tr>
					<th width="10%"><label for="sendUserAlias">消息发送人:</label></th>
					<td width="88%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="sendUser" name="sendUser"
								value='<c:out  value='${sysMsgDTO.sendUser}'/>'> <input
								class="form-control" placeholder="请选择用户" type="text"
								id="sendUserAlias" name="sendUserAlias"
								value='<c:out  value='${sysMsgDTO.sendUserAlias}'/>'>
							<span class="input-group-addon" id="userbtn"> <i
								class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="sendDate">发送日期:</label></th>
					<td width="88%">
						<div class="input-group input-group-sm">
							<input class="form-control date-picker" type="text"
								name="sendDate" id="sendDate"
								value='<fmt:formatDate pattern="yyyy-MM-dd" value='${sysMsgDTO.sendDate}'/>' /><span
								class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="recvUserAlias">消息接收人:</label></th>
					<td width="88%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="recvUser" name="recvUser"
								value='<c:out  value='${sysMsgDTO.recvUser}'/>'> <input
								class="form-control" placeholder="请选择用户" type="text"
								id="recvUserAlias" name="recvUserAlias"
								value='<c:out  value='${sysMsgDTO.recvUserAlias}'/>'>
							<span class="input-group-addon" id="userbtn"> <i
								class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="autoDisappear">是否自动消失:</label></th>
					<td width="88%"><pt6:h5radio css_class="radio-inline"
							name="autoDisappear" title="" canUse="0"
							lookupCode="PLATFORM_SYSTEM_FLAG"
							defaultValue='${sysMsgDTO.autoDisappear}' /></td>
				</tr>
				<tr>
					<th width="10%"><label for="disappearDate">到期时间:</label></th>
					<td width="88%">
						<div class="input-group input-group-sm">
							<input class="form-control date-picker" type="text"
								name="disappearDate" id="disappearDate"
								value='<fmt:formatDate pattern="yyyy-MM-dd" value='${sysMsgDTO.disappearDate}'/>' /><span
								class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="sendDeptidAlias">发送人部门ID:</label></th>
					<td width="88%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="sendDeptid" name="sendDeptid"
								value='<c:out  value='${sysMsgDTO.sendDeptid}'/>'> <input
								class="form-control" placeholder="请选择部门" type="text"
								id="sendDeptidAlias" name="sendDeptidAlias"
								value='<c:out  value='${sysMsgDTO.sendDeptidAlias}'/>'>
							<span class="input-group-addon" id="deptbtn"> <i
								class="glyphicon glyphicon-equalizer"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="sysApplicationId">所属应用ID:</label></th>
					<td width="88%"><input class="form-control input-sm"
						type="text" name="sysApplicationId" id="sysApplicationId"
						value='<c:out  value='${sysMsgDTO.sysApplicationId}'/>' /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="sysMessage_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="sysMessage_closeForm">返回</a>
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
			parent.sysMessage.closeDialog("edit");
		}
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			parent.sysMessage.save($('#form'), "eidt");
		}

		$(document).ready(function() {
			$('.date-picker').datepicker();
			$('.time-picker').datetimepicker({
				oneLine : true,//单行显示时分秒
				closeText : '确定',//关闭按钮文案
				showButtonPanel : true,//是否展示功能按钮面板
				showSecond : false,//是否可以选择秒，默认否
			});

			parent.sysMessage.formValidate($('#form'));
			//保存按钮绑定事件
			$('#sysMessage_saveForm').bind('click', function() {
				saveForm();
			});
			//返回按钮绑定事件
			$('#sysMessage_closeForm').bind('click', function() {
				closeForm();
			});

			$('#sendUserAlias').on('focus', function(e) {
				new H5CommonSelect({
					type : 'userSelect',
					idFiled : 'sendUser',
					textFiled : 'sendUserAlias'
				});
			});

			$('#recvUserAlias').on('focus', function(e) {
				new H5CommonSelect({
					type : 'userSelect',
					idFiled : 'recvUser',
					textFiled : 'recvUserAlias'
				});
			});

			$('#sendDeptidAlias').on('focus', function(e) {
				new H5CommonSelect({
					type : 'deptSelect',
					idFiled : 'sendDeptid',
					textFiled : 'sendDeptidAlias'
				});
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
		});
	</script>
</body>
</html>