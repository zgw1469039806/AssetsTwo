<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
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
if ( typeof parent._printHtml == 'string' ) {
	var doc = document;
	doc.open();
	doc.write( parent._printHtml);
	doc.close();
 
//	delete parent._previewHtml;
}

doflag = 0;

$(function(){
	var len = $ ("td").length;
	try{
		$('#fmedit').form('load', parent._printHtmlData);
	}catch(err){
		
	}
	$("td").each(function(i,dom){
		$(this).find(".combo").eq(1).remove();
		if (i === len - 1)
        {
			doflag = 1;
        }
	});
	setInterval(function() {
		 handlePrint()
	}, 500);
});

function handlePrint(){
	if (doflag){
		doflag = 0;
		window.print();
		setTimeout("parent.closeDlg('printDlg');",500);
	}
}
</script>