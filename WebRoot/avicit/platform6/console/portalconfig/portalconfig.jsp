<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common";	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div class="easyui-layout" fit="true" >
		<div data-options="region:'west',split:true" style="width:300px;padding:0px;overflow:auto;">
			${previews}
		</div>
		<div data-options="region:'center'">
			<iframe id='mainFra' src='' frameborder='0'  width="100%"></iframe>
		</div>
	</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 模块js -->
<script type="text/javascript">
	$(function(){
		$('#mainFra').css("height",document.documentElement.clientHeight-20);
	});
	$(window).resize(function(){
		$('#mainFra').css("height",document.documentElement.clientHeight-20);
	});
	var defaultTypeKey = '${defaultTypeKey}';
	function changeClick(obj){
		$("input[type='radio']").removeAttr("checked");
		var checkedValue = $(obj).data('for');
		setRadioChecked(checkedValue);
		document.getElementById('mainFra').src = 'platform/console/portal/toPortalConfigInfo?typeKey=' + checkedValue + '&appId=${appId}';
	}
	$(document).ready(function(){
		document.getElementById('mainFra').src = 'platform/console/portal/toPortalConfigInfo?typeKey=' + defaultTypeKey + '&appId=${appId}';
	});
	function radioClick(obj){
		var checkedValue = obj.value;
		setTimeout(function(){
			$("input[type='radio']").removeAttr("checked");
			setRadioChecked(checkedValue);
		},100);
		document.getElementById('mainFra').src = 'platform/console/portal/toPortalConfigInfo?typeKey=' + checkedValue + '&appId=${appId}';
	}
	function setRadioChecked(val){
		var robj = document.getElementsByName('typeKey');
		for(i = 0 ; i < robj.length;i++){
			if(robj[i].value == val){
			 	robj[i].checked = true;
			} else {
				robj[i].checked = false;
			}
		}
	}
	
</script>

</body>
</html>