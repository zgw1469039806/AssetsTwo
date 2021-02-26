<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
	String importlibs = "common,tree";
	/* url参数 */
	String entryId = request.getParameter("entryId");
	if (entryId == null) {
		entryId = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>关联流程</title>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<!-- 当前页 样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/editForm.css">
<!-- 定制tab标签样式 -->
<link rel="stylesheet" type="text/css" href="avicit/platform6/bpmreform/bpmcommon/css/avictabs.css">
<script type="text/javascript">
	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
</script>
<script>
	//全局变量
	var entryId = '<%=entryId%>';
</script>
</head>
<body>
	<div class="main noright">
		<!-- 正文内容 Start -->
		<div class="content">
			<!-- 简单tab Start -->
			<div class="avic-tab">
				<div class="tab-panel" style="padding-top:0px;">
					<div class="panel-body on">
						<%@ include file="/avicit/platform6/bpmreform/bpmbusiness/include/processlevel.jsp"%>
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
	<!-- 页面脚本 editForm.js-->
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/js/editForm.js"></script>
	
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript">
		function getFont(treeId, node) {
			if(node.fontCss=="Y"){
				return {color:'#BA55D3'};
			}
		}
		$(function(){
			avicAjax.ajax({
				url: "bpm/bpmdomain/getParentAndSubProcessses",
				data: "procInstId=" + entryId,
				type: "post",
				dataType: "json",
				success: function (backData) {
					var setting = {
						view: {
							fontCss: getFont
						},
						data: {
							key: {
								id: "id",
								name: "name",
								children: "children"
							},
							simpleData: {
								enable: true,
								idKey: "id",
								pIdKey: "parentId",
								rootPId: "-1"
							}
						},
						callback:{
							onClick: function(event, treeId, treeNode){
								if(treeNode.id == "-1" || treeNode.id == "-2"){
									return;
								}
								var url = "avicit/platform6/bpmreform/bpmdesigner/picture/pic.jsp?entryId="+treeNode.id.replace("relation_","");
								$("#iframeCenter_processlevel_graph").attr("src",url);
							}
						}
					};
					var treeObj = $.fn.zTree.init($("#processLevelTree"), setting, backData.result);
					setTimeout(function () {
						$("#processLevelLayout").layout('resize');
					}, 500)
				}
			});
		});
	</script>
</body>
</html>
