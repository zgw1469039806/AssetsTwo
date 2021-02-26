<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择部门</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
</head>

<body class="easyui-layout" fit="true">
 <div data-options="region:'north',split:false"  style="height:35px;padding:0px;overflow:hidden;">
 	 <div id="toolbar" class="datagrid-toolbar">
	 	<table width="100%">
	 		<tr>
	 			<td width="100%"><input  type="text"  name="search" id="search"></input></td>
	 		</tr>
	 	</table>
	 </div>
 </div>  
<div data-options="region:'center',split:true">
	
	<ul id="tree">正在加载数据...</ul>
</div>
<div data-options="region:'south',border:false" style="height:40px;">
	<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" border="0" cellspacing="1" width='100%'>
               <tr>
                   <td align="right">
                       <a title="确定" id="saveButton" class="easyui-linkbutton primary-btn" onclick="MoveDept.saveMove();" href="javascript:void(0);">确定</a>
                       <a title="取消" id="returnButton" class="easyui-linkbutton" onclick="MoveDept.closeForm();" href="javascript:void(0);">取消</a>
                   </td>
               </tr>
        </table>
     </div>
</div>
<script src="avicit/platform6/modules/system/sysdept/js/movedept.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	MoveDept.init('${o}','${s}');
});
</script>
</body>
</html>