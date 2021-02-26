<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script src="avicit/platform6/eform/formdefine/js/eformUpload.js" type="text/javascript"></script>
</head>
<%
	long timestamp = System.currentTimeMillis();
	String language =SessionHelper.getCurrentUserLanguageCode(request);
	String appId = SessionHelper.getApplicationId();
	String colId = request.getParameter("colId");
	String colName = request.getParameter("colName");
	String id = request.getParameter("id");
%>
<body class="easyui-layout"  fit="true">

<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:45px;">	
		<form action="" method="post" id="uploadForm" enctype="multipart/form-data" style="margin-top: 20px;">
			<table width="100%" border="0">
			 <tr>
			 	<td width="10%" align="right" nowrap="nowrap">选择本地图片文件</td>
			   	<td width="90%" align="left"><input type="file" style='width:90%' id="sysUserPhoto" name="sysUserPhoto"></td>
			  </tr>
			 </table>
			 <input type=hidden id="headerPhoto_sysUserId" name="headerPhoto_sysUserId" value="111"/>
		</form>
		<div id="upLoadPhotoToolbar" class="datagrid-toolbar datagrid-toolbar-extend" style="height:auto;display: block;">
			<table class="tableForm"  width='100%'>
				<tr>	
					<td align="right"><a title="上传" id="upLoadButton"  class="easyui-linkbutton" iconCls="icon-save" plain="false" onclick="upLoadUserPhoto('<%=colId%>','<%=id%>','<%=colName%>');" href="javascript:void(0);">上传</a></td>
					<td><a title="关闭" id="returnButton"  class="easyui-linkbutton" iconCls="icon-undo" plain="false" onclick="parent.closeDialog('eformupload');" href="javascript:void(0);">关闭</a></td>
				</tr>
			</table>
		</div>
</div>

</body>
<script type="text/javascript">

$(function(){
	$('#sysUserPhoto').on('change', function(){
		upLoadUserPhoto('<%=colId%>','<%=id%>','<%=colName%>');
	}); 
})

function clp(){
   return  $("#sysUserPhoto").click();
}
</script>
</html>