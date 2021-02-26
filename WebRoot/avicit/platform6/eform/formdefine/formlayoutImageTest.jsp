<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/BpmJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script src="avicit/platform6/eform/formdefine/js/ckeditor/ckeditor.js"></script>
<script src="avicit/platform6/eform/formdefine/js/ckeditor/config.js"></script>
<script src="avicit/platform6/eform/formdefine/js/eformValidate.js"></script>
<script src="avicit/platform6/eform/formdefine/js/eformCustomDialog.js"></script>
<script src="avicit/platform6/eform/formdefine/js/eformUpload.js" type="text/javascript"></script>

<style type="text/css">
.inputstyle{
    height: 100%;
    width:100%;
    cursor: pointer;
    font-size: 30px;
    outline: medium none;
    position: absolute;
    filter:alpha(opacity=0);
    -moz-opacity:0;
    opacity:0; 
    z-index:999;
    top:0;
    left:0;
}
</style>
</head>
<body class="easyui-layout"  fit="true">
<div data-options="region:'center',split:true,border:false">
	
<table>
<tr>
<td>
<div style="position:relative;display:block;width:120px">
<img height="120px" id="SBTP" name="SBTP" src="platform/eform/image/upload/getphoto?colId=8a58cd5b55287f6c0155289969a60214&id=" title="上传个人头像文件" class="" style="cursor:pointer;">
	<form action="" method="post" id="uploadForm" enctype="multipart/form-data" >
		<input class="inputstyle" type="file"  id="sysUserPhoto" name="sysUserPhoto" onchange="upLoadUserPhoto('8a58cd5b55287f6c0155289969a60214','111','SBTP')">
	</form>

</div>
</td>
<td>
</td>
</tr>
</table>
</div>

<script>

var baseurl = '<%=request.getContextPath()%>';
var url;



function choosePhoto(colId,id,colName){
	id = "1111";
	$('#sysUserPhoto').off('change').on('change', function(){
		upLoadUserPhoto(colId,id,colName);
	});
	clp();
}

function clp(){
	return  $("#sysUserPhoto").click();
}



$(function(){
	
	
	

});

	
</script>

    
    
</body>
</html>