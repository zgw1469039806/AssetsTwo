<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common";
	/* url参数 */
	String entryId = request.getParameter("entryId");
	if (entryId == null) {
		entryId = "";
	}
	String type = request.getParameter("type");
	if (type == null) {
		type = "";
	}
	String info = "";
	if(type.equals("doglobaljump")){
		info = "在有多个并发节点的情况下，请您先选择一个流程跳转的起始节点（点击红框标记的节点），然后再选择一个目标节点后执行流程跳转操作";
	}else if(type.equals("doretreattowant")){
		info = "请您选择一个要退回的节点，然后执行退回操作";
	}else if(type.equals("dowithdraw")){
		info = "在有多个并发节点的情况下，请您先选择一个流程拿回的节点（点击红框标记的节点），然后执行流程拿回操作";
	}else if(type.equals("dosupplement")){
		info = "在有多个并发节点的情况下，请您先选择一个流程补发的节点（点击红框标记的节点），然后执行流程补发操作";
	}else if(type.equals("dostepuserdefined")){
		info = "请您选择一个要定义流程审批人的节点，选择审批人然后点击提交";
	}else{
		info = "参数错误";
	}
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>流程图</title>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script>
	//全局变量
	var entryId = '<%=entryId%>';
	var type = '<%=type%>';
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
<style type="text/css" media="screen">
div.base {
	position: absolute;
	overflow: hidden;
}

#graph {
	left: 0px;
	right: 0px;
	top: 15px;
	bottom: 0px;
	overflow: auto;
}
</style>
</head>
<body>
	<p class="bg-info"><%=info %></p>
	<div class="base" id="graph"></div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/picture/FlowPic.js"></script>
	<script type="text/javascript">
		$(function(){
			initFlowPic(entryId, null, function(designerEditor) {
				designerEditor.init(entryId, null, type);
			});
		});
	</script>
</body>
</html>