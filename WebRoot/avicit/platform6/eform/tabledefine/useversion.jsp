<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>菜单管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>


<%
String tableId=(String)request.getParameter("tableId");
%>

<script>

$(document).ready(function(){ 

	$.extend($.fn.validatebox.defaults.rules, {
            isBlank: {
                validator: function (value, param) { return $.trim(value) != '' },
                message: '不能为空，全空格也不行'
            }
     });
	
})

</script>

</head>

<body class="easyui-layout" fit="true">
    <div data-options="region:'center',split:true,border:false">

		<form id="fm" method="post" novalidate>
		<table class="form_commonTable">
		<tr>
		<th width="10%">
		<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
		</span>
		版本号:</th>
		<td  width="40%">
		<select name="attribute08" class="easyui-combobox" data-options="editable:false,panelHeight:'60',onShowPanel:comboboxOnShowPanel">
				<c:forEach items="${list}"   var="item"  >
						<option value="${item.attribute08}">${item.attribute08}</option>
				</c:forEach>
		</select>
		</td>
		</tr>
		</table>
		</form>
	<div data-options="region:'south',border:false" style="height:40px;">
	<div id="dlg-buttons1" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
	<table class="tableForm" border="0" cellspacing="1" width='100%'>
			<tr>	
				<td width="50%" align="right">
					<a href="javascript:void(0)" class="easyui-linkbutton primary-btn"  onclick="saveCol()" >保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:parent.dlg_close_only('useversion')" >返回</a>
				</td>
			</tr>
	</table>
	</div>
</div>
	
<script type="text/javascript">

var baseurl = '<%=request.getContextPath()%>';
var url;


$(function(){
	
	$.extend($.fn.validatebox.defaults.rules, {
        isBlank: {
            validator: function (value, param) { return $.trim(value) != '' },
            message: '不能为空，全空格也不行'
        }
 	});
	
});


function saveCol() {
	url = 'platform/eform/tabledefine/useversion.json?tableId=${tableId}';
	if($('#fm').form('validate')){
	$.post(url, {
		str : JSON.stringify(serializeObject($('#fm')))
		}, function(result){
			parent.reloaddg();
			parent.dlg_close('useversion');
		}, 'json');
	}
}


</script>



</body>
</html>