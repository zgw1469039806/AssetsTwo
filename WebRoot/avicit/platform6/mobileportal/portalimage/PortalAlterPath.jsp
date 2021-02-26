<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.core.properties.PlatformProperties"%>
<% 
String importlibs = "common,form,fileupload";
	// 移动文件路径
String mobileFilesPath = PlatformProperties.getProperty("mobileFiles.path");
String doccenterPath = PlatformProperties.getProperty("doccenter.path");
%>
<!DOCTYPE html>
<HTML>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<HEAD>
<title>详细</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- ControllerPath = "ims/portal/stat/portalimage/portalImageController/operation/Detail/id" -->
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout">
	<div data-options="region:'center',split:true,border:false">
		<h3>此操作会修改移动项目下数据控中文件地址以及上传控件对应表中的文件地址</h3>
			<table class="form_commonTable">
				<tr>
					<th width="10%">
						<label for="imagePath">旧磁盘地址:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="oldPath" id="oldPath"
							   value="<%=doccenterPath%>"/>
					</td>
					<th width="10%">
						<label for="imagePath">旧映射地址:</label></th>
					<td width="39%">
						<input class="form-control input-sm" type="text" name="contextPath" id="contextPath"
							   value="mobileFiles"/>
					</td>
				</tr>
				<tr>
				<th width="10%">
					<label for="imagePath">新地址:</label></th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="newPath" id="newPath"
						   readonly="readonly" value="<%=mobileFilesPath%>"/>
				</td>
				</tr>
			</table>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
//关闭Dialog
function closeForm(){
	parent.portalImage.closeDialog();
}
function save(){
    if($('#oldPath').val()==''||$('#contextPath').val()==''){
        layer.msg('替换地址不得为空！');
        return false;
	}else{
        return parent.portalImage.alterPath($('#oldPath').val(),$('#contextPath').val());
	}
}
//加载完后初始化
$(document).ready(function () {
});
</script>
</body>
</html>