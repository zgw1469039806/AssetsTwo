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
<title>消息详细</title>
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
					<th width="10%"><label for="title">标题:</label></th>
					<td width="88%" colspan="3"><input class="form-control input-sm"
						type="text" name="title" id="title" readonly="readonly"
						value='<c:out  value='${sysMsgDTO.title}'/>' /></td>
				</tr>
				<tr>
					<th width="10%" ><label for="content">内容:</label></th>
					<td width="88%" colspan="3"><textarea class="form-control input-sm"
							rows="3" readonly="readonly" name="content" id="content"><c:out value='${sysMsgDTO.content}'/></textarea></td>
				</tr>
				<tr>
					<th width="10%"><label for="sendUserAlias">发送人:</label></th>
					<td width="40%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="sendUser" name="sendUser"
								value='<c:out  value='${sysMsgDTO.sendUser}'/>'> <input
								class="form-control" placeholder="请选择用户" type="text"
								id="sendUserAlias" name="sendUserAlias" readonly="readonly"
								value='<c:out  value='${sysMsgDTO.sendUserAlias}'/>'>
							<span class="input-group-addon" id="userbtn"> <i
								class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
					<th width="10%"><label for="sendDeptidAlias">发送部门:</label></th>
					<td width="40%">
						<div class="input-group  input-group-sm">
							<input type="hidden" id="sendDeptid" name="sendDeptid"
								value='<c:out  value='${sysMsgDTO.sendDeptid}'/>'> <input
								class="form-control" placeholder="请选择部门" type="text"
								id="sendDeptidAlias" name="sendDeptidAlias" readonly="readonly"
								value='<c:out  value='${sysMsgDTO.sendDeptidAlias}'/>'>
							<span class="input-group-addon" id="deptbtn"> <i
								class="glyphicon glyphicon-equalizer"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="recvUserAlias">接收人:</label></th>
					<td width="88%" colspan="3">
						<div class="input-group  input-group-sm" style="width: 100%">
							<input type="hidden" id="recvUser" name="recvUser"
								value='<c:out  value='${sysMsgDTO.recvUser}'/>'> <input
								class="form-control" placeholder="请选择用户" type="text"
								id="recvUserAlias" name="recvUserAlias" readonly="readonly"
								value='<c:out  value='${sysMsgDTO.recvUserAlias}'/>'>
							<span class="input-group-addon" id="userbtn"> <i
								class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="sendDate">发送时间:</label></th>
					<td width="40%">
						<div class="input-group input-group-sm" >
							<input class="form-control date-picker" type="text"
								name="sendDate" id="sendDate" readonly="readonly" 
								value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value='${sysMsgDTO.sendDate}'/>' /><span
								class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<th width="10%"><label for="disappearDate">到期时间:</label></th>
					<td width="40%">
						<div class="input-group input-group-sm">
							<input class="form-control date-picker" type="text"
								name="disappearDate" id="disappearDate" readonly="readonly"
								value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value='${sysMsgDTO.disappearDate}'/>' /><span
								class="input-group-addon"><i
								class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
				</tr>
				
			</table>
		</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript">

		document.ready = function() {
			parent.sysMessage.formValidate($('#form'));
		};
		//form控件禁用
		setFormDisabled();
		//移除内容区域设置的disabled，解决IE8下没有滚动条
		$('#content').removeAttr("disabled");
		$(document).keydown(function(event) {
			event.returnValue = false;
			return false;
		});
	</script>
</body>
</html>