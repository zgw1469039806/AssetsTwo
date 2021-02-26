<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

</head>
<body class="easyui-layout" fit="true" style="visibility: hidden;">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="version" value='${sysMsgDTO.version}' /> <input
				type="hidden" name="id" value='${sysMsgDTO.id}' />
			<table class="form_commonTable">
				<tr>
					<th align="right" width="10%"
						style="word-break: break-all; word-warp: break-word;"><span
						style="color: red;">*</span> 标题:</th>
					<td class="disabled" width="39%" colspan="3"><input title="姓名"
						class="easyui-validatebox" data-options="required:true"
						style="width: 99%;" type="text" name="title" id="title"
						readonly="readonly" value='<c:out  value='${sysMsgDTO.title}'/>' />
					</td>
				</tr>
				<tr>
					<th align="right" width="10%"
						style="word-break: break-all; word-warp: break-word;"><span
						style="color: red;">*</span> 内容:</th>
					<td class="disabled" width="39%" colspan="3"><textarea title="用户名" class="textareabox " name="content" id="content" readonly="readonly" rows="6" >${sysMsgDTO.content}</textarea></td>
				</tr>
				<tr>
					<th align="right" width="10%"
						style="word-break: break-all; word-warp: break-word;"><span
						style="color: red;">*</span><label for="sendUserAlias"> 发送人:</label></th>
					<td class="disabled" width="39%">
					<div class="ext-selector-div" style="width: 100%;"  id='recvUsesrAlias_div'>
							<input  type="hidden" name="sendUser" id="sendUser" value='<c:out  value='${sysMsgDTO.sendUser}'/>'>
							<input class="easyui-validatebox ext-selector-input" 
								title="消息接收人" placeholder="请选择用户" title="请选择用户"
								name="sendUserAlias" id="sendUserAlias" readonly="readonly"
								value='<c:out  value='${sysMsgDTO.sendUserAlias}'/>'>
					</div>
					</td>
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><label for="sendDeptidAlias"> 发送部门:</label></th>
					<td class="disabled" width="39%"><div class="ext-selector-div" style="width: 100%;"  id='recvUsesrAlias_div'>
							<input  type="hidden" name="sendDeptid" id="sendDeptid" value='<c:out  value='${sysMsgDTO.sendDeptid}'/>'>
							<input class="easyui-validatebox ext-selector-input" 
								title="请选择部门" placeholder="请选择部门" 
								name="sendDeptidAlias" id="sendDeptidAlias" readonly="readonly" value='<c:out  value='${sysMsgDTO.sendDeptidAlias}'/>'>
					</div>
					</td>
				</tr>
				<tr>
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span id='recvUsesrAlias_span'><span
						style="color: red;">*</span><label for="recvUsesrAlias">接收人:</label></span></th>
					<td class="disabled" width="37%" colspan="3">
					<div class="ext-selector-div" style="width: 100%;"  id='recvUsesrAlias_div'>
							<input class="easyui-validatebox ext-selector-input" 
								title="消息接收人" placeholder="请选择用户" title="请选择用户"
								name="recvUsersAlias" id="recvUsersAlias" readonly="readonly" value='<c:out  value='${sysMsgDTO.recvUserAlias}'/>'>
							<input  type="hidden" name="recvUser" id="recvUser" value='<c:out value='${sysMsgDTO.recvUser}'/>'>
					</div>
					</td>
				</tr>
				<tr>
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span
						class="remind">*</span>发送日期:</th>
					<td class="disabled" width="37%">
					<input title="发送日期" class="easyui-datetimebox" data-options="required:true"
						editable="false" style="width: 99%;" type="text" name="sendDate"
						id="sendDate" readonly="readonly"
					    value='<fmt:formatDate pattern="yyyy-MM-dd hh:mm" value='${sysMsgDTO.sendDate}'/>'/></td>
				    <th width="12%"
						style="word-break: break-all; word-warp: break-word;">到期时间:</th>
					<td class="disabled" width="37%"><input title="到期时间" class="easyui-datetimebox"
						editable="false" style="width: 99%;" type="text" name="disappearDate"
						id="disappearDate" readonly="readonly"
						value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value='${sysMsgDTO.disappearDate}'/>'/></td>
				
				</tr>
			</table>
		</form>
	</div>
</body>
<jsp:include
	page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<script type="text/javascript">
	 $(document).ready(function () {       
		 document.body.style.visibility = 'visible';
	    });
</script>
</html>