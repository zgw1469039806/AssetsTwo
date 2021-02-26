<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String checkvalues = request.getParameter("checkvalues");
	String lookupCode = request.getParameter("lookupCode");
	String gridId = request.getParameter("gridId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<script type="text/javascript">
	function JScallBackComboSetValue(){
		var checkboxElements= $("input:checked"); //选中的checkbox值
		var checkboxValues="";
		var checkboxTexts="";
		for(var i = 0;i < checkboxElements.length;i++){
			checkboxValues+=checkboxElements[i].value; //获取checkbox对应值
			checkboxTexts += $("label[for='"+checkboxElements[i].value + "']").html(); //获取checkbox对应文本
			if(i < checkboxElements.length-1){
				checkboxValues+=",";
				checkboxTexts+=",";
			}
		}
		parent.$('#<%=gridId%>').datagrid('options').popWindowCallback({value:checkboxValues,text:checkboxTexts});
	}
	$(document).ready(function(){
		    $("label").after("<br>");
		});
	
</script>
<body>
<c:set var='checkvalues' value='<%=checkvalues%>'></c:set>
<c:set var='lookupCode' value='<%=lookupCode%>'></c:set>
<div id="c_skin" style="padding:0px;">
<pt6:JigsawCheckBox css_class="groupCtrlSpan" name="checkboxplug" title="请选择" canUse="0" lookupCode="${lookupCode}" defaultValue="${checkvalues}"/>
<br><center><a class="easyui-linkbutton" plain="true" style="background-color:#D9E1E9;" onclick="JScallBackComboSetValue();" href="javascript:void(0);">选择</a></center>
</div> 
</body>
</html>