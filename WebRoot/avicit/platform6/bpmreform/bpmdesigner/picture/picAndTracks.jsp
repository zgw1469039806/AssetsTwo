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
<title>流程跟踪</title>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<!-- 当前页 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/editForm.css">
<!-- 定制tab标签样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/avictabs.css">
<!-- 流程标签 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/workflow.css">
<!-- 时间轴 样式 -->
<link rel="stylesheet" type="text/css" href="static/h5/timeliner/css/timeliner.css">
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
	var _showBpmOpenFormBut = true;
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
<script>
	//全局变量
	var entryId = '<%=entryId%>';
	var deploymentId = '<%=deploymentId%>';
</script>
</head>
<body>
	<div class="main noright">
		<!-- 正文内容 Start -->
		<div class="content">
			<!-- 简单tab Start -->
			<div class="avic-tab">
				<div class="tab-panel">
					<div class="panel-body on">
						<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/tracks.jsp"%>
					</div>
				</div>
			</div>
			<!-- 简单tab End -->
		</div>
		<!-- 正文内容 End -->
	</div>

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<!-- 页面脚本 avictabs.js-->
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/avictabs.js"></script>
	<!-- 时间轴组件 timeliner.js-->
	<script type="text/javascript" src="static/h5/timeliner/js/timeliner.js"></script>
	<!-- 页面脚本 editForm.js-->
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/editForm.js"></script>
	
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/picture/FlowPic.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmdesigner/picture/FlowTracks.js"></script>
	<script type="text/javascript">
		$(function(){
			initFlowPic(entryId, deploymentId, function(designerEditor) {
				designerEditor.init(entryId, deploymentId);
				if(mxClient.IS_IE8){
					$("#graph").parent().height(500);
				}
			});
			if(entryId != ""){
				bpm_RefreshTracks(entryId);
			}
		});
	</script>
</body>
</html>