<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/msystem/sysmsg/sysMsgController/operation/PubAdd/null" -->
<title>发送消息</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<input type="hidden" id="sourceCode" value="personal" name="sourceCode"/>
			<table class="form_commonTable" border="0">
				<tr>
					<th width="10%"><label for="title">标题:</label></th>
					<td width="88%" colspan="3"><input class="form-control input-sm"
						type="text" name="title" id="title" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="content">内容:</label></th>
					<td width="88%" colspan="3"><textarea class="form-control input-sm"
							rows="3" name="content" id="content" style="resize:none;"></textarea></td>
				</tr>
				
				<tr>
					<th width="10%"><label for="msgType">所有人:</label></th>
					<td width="40"  id="msgType_radio">
						<pt6:h5radio  css_class="radio-inline"
							name="msgType" title="msgType" canUse="0"
							defaultValue="0" id="msgType"
							lookupCode="PLATFORM_SYSTEM_FLAG" />
					</td>
					<th width="15%"><span id='recvUsesrAlias_remind'
							class="remind">*</span><span id='recvUsesrAlias_span'><label for="recvUsesrAlias">消息接收人:</label></span></th>
					<td width="40%" >
						<div class="input-group  input-group-sm" id='recvUsesrAlias_div'>
							<input type="hidden" id="recvUser" name="recvUser"> <input
								class="form-control" placeholder="请选择用户" type="text"
								id="recvUsersAlias" name="recvUsersAlias"> 
								<span class="input-group-addon" id="userbtn"> <i
								class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
				</tr>

				
				<tr id="recvUsersAlias_div">
					
				</tr>
			
				<tr>
					<th width="10%"><label for="sendDate">发送日期:</label></th>
					<td width="40%">
						<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text" name="sendDate" id="sendDate" />
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<th width="10%"><label for="disappearDate">到期时间:</label></th>
					<td width="40%">
						<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text" name="disappearDate" id="disappearDate" />
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
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
					<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="发送" id="sysMessage_saveForm">发送</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="sysMessage_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script src="avicit/platform6/portal/message/js/SysMsgPubAdd.js" type="text/javascript"></script>
	<script src="avicit/platform6/portal/message/js/moment.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	var recvUserStr ='${sysMsgDTO.recvUser}';
	var recvUserAlStr='${sysMsgDTO.recvUserAlias}';
		$(document).ready(function() {
			$('#form').sysMsgPubAdd();
		});
	</script>
</body>
</html>