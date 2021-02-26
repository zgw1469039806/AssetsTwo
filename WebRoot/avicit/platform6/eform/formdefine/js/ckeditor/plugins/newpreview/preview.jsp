<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预览</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>

<style>
.tt td{padding-top:3px;padding-bottom:3px}
.tt th{padding-top:3px;padding-bottom:3px}
</style>

<script>

//Prevent from DOM clobbering.
if ( typeof parent._previewHtml == 'string' ) {
	var doc = document;
	doc.open();
	doc.write( parent._previewHtml );
	doc.close();

//	delete parent._previewHtml;
}



$(function(){
	
	<c:forEach items="${selectColumns}"   var="item"  >
			var ${item.colName}CommonSelector = new CommonSelector("${item.colRuleName}","${item.colRuleName}SelectCommonDialog","${item.colName}","${item.colName}Name",null,null,null,-1);
			${item.colName}CommonSelector.init();  
	</c:forEach>

});


</script>