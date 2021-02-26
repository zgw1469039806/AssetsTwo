<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,table";
	/* url参数 */
	String entryId = request.getParameter("entryId");
	String deploymentId = request.getParameter("deploymentId");
	if (entryId == null) {
		entryId = "";
	}
	if (deploymentId == null) {
		deploymentId = "";
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
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
	var _showBpmOpenFormBut = true;
</script>
<script>
	//全局变量
	var entryId = '<%=entryId%>';
	var deploymentId = '<%=deploymentId%>';
</script>
<style type="text/css">
.p1{
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
}
</style>
<style type="text/css" media="screen">
div.base {
	position: absolute;
	overflow: hidden;
}

#graph {
	left: 0px;
	right: 0px;
	top: 50px;
	bottom: 0px;
	overflow: auto;
}
</style>
</head>
<body>
	<div class="btn-group" role="group" style="padding:10px;">
	  <button type="button" class="btn btn-default" id="toParentPic" style="display:none;">父流程</button>
	  <button type="button" class="btn btn-default" id="relationprocess" style="display:none;">相关流程</button>
	  <button type="button" class="btn btn-default" id="openForm" style="display:none;">打开表单</button>
	</div>
	<div class="base" id="graph"></div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmbusiness/include/src/FlowButtons.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/picture/FlowPic.js"></script>
	<script type="text/javascript">
		$(function(){
			initFlowPic(entryId, deploymentId, function(designerEditor) {
				designerEditor.init(entryId, deploymentId);
				designerEditor.picJsp = "avicit/platform6/bpmreform/bpmdesigner/picture/pic.jsp";
			});
			
			if(flowUtils.notNull(entryId)){
				$.ajax({
					type : "POST",
					data : {
						entryId : entryId
					},
					url : "platform/bpm/business/getParentprocess",
					dataType : "text",
					success : function(result) {
						if(flowUtils.notNull(result)){
							$("#toParentPic").show();
							$("#toParentPic").on("click", function(){
								var dialog = layer.open({
									type : 2,
									title: "父流程",
									area : [ "800px", "450px" ],
									content : "avicit/platform6/bpmreform/bpmdesigner/picture/pic.jsp?entryId=" + result
								});
								layer.full(dialog);
							});
						}
					}
				});
				
				$("#openForm").show();
				$("#openForm").on("click", function(){
					flowUtils.detail(entryId, "2");
				});
				$.ajax({
					type : "POST",
					data : {
						entryId : entryId
					},
					url : "platform/bpm/business/isrelationprocess",
					dataType : "text",
					success : function(result) {
						if(result == "true"){
							$("#relationprocess").show();
							$("#relationprocess").on("click", function(){
								new FlowButtons().dorelationprocess(entryId);
							});
						}
					}
				});
			}
		});
	</script>
</body>
</html>