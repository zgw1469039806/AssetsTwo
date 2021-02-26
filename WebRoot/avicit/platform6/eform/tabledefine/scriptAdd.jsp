<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>脚步管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>

<body class="easyui-layout" fit="true">
    <div data-options="region:'center',split:true,border:false">
		<form id="fm" method="post" novalidate>
		<input type="hidden"  name="tableId"  value="${entity.tableId}" />
		<input type="hidden"  name="id"  value="${entity.id}" />
		<table class="form_commonTable">
		<c:if test="${entity.isDefault == 'Y'}">
			<tr>
				<th  width="15%">
					事件类路径:
				</th> 
				<td colspan="3">
					<input name="eventClass" class="easyui-validatebox"  value="${entity.eventClass}"  />
				</td>
			</tr>
		</c:if>
		<tr>
			<th  width="15%">
				前置js脚本:
			</th>
			<td>
			<textarea class="textareabox" rows="5" name="preJs" >${entity.preJs}</textarea>
			</td>
		</tr>
		<tr>
			<th  width="15%">
				后置js脚本:</th> 
			<td>
			<textarea class="textareabox" rows="5" name="postJs" >${entity.postJs}</textarea>
			</td>
		</tr>
		
		</table>
		</form>
		</div>
		<div data-options="region:'south',border:false" style="height:40px;">
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                <td align="right">
				<a href="javascript:void(0)" class="easyui-linkbutton primary-btn"   onclick="saveUser()" >保存</a>
				<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:parent.dlg_close_only('script')" >返回</a>
				</td>
			</tr>
			</table>
		</div>
</div>
	
<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';
var url;

function saveUser() {
	url = 'platform/eform/custom/saveScript.json';
	if($('#fm').form('validate')){
	
		$.post(url, {
			str : JSON.stringify(serializeObject($('#fm')))
			}, function(result){
				if (result.success) {
					parent.dg_reload('dg');
					parent.dlg_close('script');
				} else {
					parent.alertSuccess('错误',result.msg);
				}
			}, 'json');
	
	}
}

</script>
</body>
</html>