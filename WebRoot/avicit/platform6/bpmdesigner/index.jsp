<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
	String skin = "skyblue";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>web流程设计器</title>
<link rel="stylesheet" href="<%=basePath%>static/js/platform/designer/dhtmlx/codebase/dhtmlx.css">
<script>
	//全局变量
	var _basePath = "<%=basePath%>";
	var _controlPath = _basePath + "platform/bpm/bpmdesigner/bpmWebDesigner/";
	var _skin = "<%=skin%>";
	var mxBasePath = _basePath + "static/js/platform/designer/";
	var _designerPath = _basePath + "static/js/platform/designer/";
	var _iconPath = _designerPath + "images/";
	var _imgPath = _designerPath + "dhtmlx/codebase/imgs/";
	var _formCode = "${formCode}";
	var _refreshFlg = '<%=request.getParameter("refreshFlg")%>';
	if(navigator.userAgent.indexOf('MSIE 7') >= 0 || navigator.userAgent.indexOf('MSIE 6') >= 0){
		window.location = "<%=basePath%>avicit/platform6/bpmdesigner/nosupport.jsp";
	}
</script>
<script src="<%=basePath%>static/js/platform/designer/dhtmlx/codebase/dhtmlx.js"></script>
<script src="<%=basePath%>static/js/platform/designer/jquery-1.11.3.min.js"></script>
<script src="<%=basePath%>static/js/platform/component/common/mxClient.js"></script>
<script src="<%=basePath%>static/js/platform/designer/myExtend.js"></script>
<script src="<%=basePath%>static/js/platform/designer/ComUtils.js"></script>
<script src="<%=basePath%>static/js/platform/designer/indexPanel.js"></script>
<script src="<%=basePath%>static/js/platform/component/common/exportData.js"></script>
<script src="<%=basePath%>static/js/platform/component/jQuery/jquery-easyui-1.3.5/jquery.easyui.min.js"></script>
<style> /* it's important to set width/height to 100% for full-screen init */
html,body {
	width: 100%;
	height: 100%;
	margin: 0px;
	overflow: hidden;
}
.showWin{
	width: 100%;
	height: 100%;
}

.pc6{overflow:auto;}
.pc6 table{border-collapse:collapse;}
.pc6 table{width:100%;}
.pc6 td{height:32px;}
.pc6 th{font-weight:normal;background:#ebeadb;}
.pc6 th,.pc6 td{border:1px solid #d0d0bf;text-align:left;padding-left:5px;height:16px;}
.tr_on{background:#00f;color:#fff;}
</style>
</head>
<body>
	<div id="myWindows" style="width:100%;height:100%;"></div>
	<!-- 新增的功能，导入流程时上传jpdl文件 -->
	<!-- <form id="uploadForm" action="" enctype="multipart/form-data" method="post" style="display:none;">
		<input type="file" name="jpdl" id="jpdl" accept=".jpdl"/>
		<input type="hidden" name="id" id="jpdlId" />
		<input type="hidden" name="type" id="jpdlType" />
	</form> -->
</body>
</html>
