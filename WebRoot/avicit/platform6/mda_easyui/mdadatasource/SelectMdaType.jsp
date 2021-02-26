<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "train/demo/mdaclassify/mdaClassifyController/toMdaClassifyManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script src="avicit/platform6/mda_easyui/mdadatasource/js/SelectMdaType.js" type="text/javascript"></script>
<script type="text/javascript">
	var mdaClassify;
	$(function(){
		mdaClassify = new MdaClassify('tree','platform/platform6/mda/mdaclassify/mdaClassifyEasyUIController','searchWord');
		mdaClassify.setOnLoadSuccess(function(){
		});
		mdaClassify.setOnSelect(function(_tree,node){
		});
		mdaClassify.init();
	});
	
   document.ready = function () {
	document.body.style.visibility = 'visible';
   }
</script>
</head>
<body class="easyui-layout" fit="true" style="visibility:hidden;">

	 <div id="toolbar" class="datagrid-toolbar">
	 	<table width="100%">
	 		<tr>
	 			<td width="100%"><input  type="text"  name="searchWord" id="searchWord"></input></td>
	 		</tr>
	 	</table>
	 </div>
	<ul id="tree">正在加载数据...</ul>
</body>
</html>