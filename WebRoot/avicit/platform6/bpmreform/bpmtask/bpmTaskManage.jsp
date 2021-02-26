<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>我的任务</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
    <script type="text/javascript">
    	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
    </script>
</head>

<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,width:250,onResize:function(a){$(window).trigger('resize');}">
		<div class="row" style="margin: 5px;">

			<div>
				<ul id="treeDemo" class="ztree"></ul>
			</div>
		</div>
	</div>
	<div data-options="region:'center',onResize:function(a){$(window).trigger('resize');}">
		<div id="taskTab" style="height:100%;width:100%;overflow:hidden;">
		 <iframe id="iframeTask" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
		</div>
	</div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmtask/js/BpmCatalogTree.js"
	type="text/javascript"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
	var bpmCatalog;


    $(document).ready(function () {
    	bpmCatalog = new BpmCatalogTree('treeDemo', 'bpm/monitor/getFlowModelTree', '', '', '',
    			function(nodeId, nodeType,pdId) {
    				loadTab(nodeId, nodeType,pdId);
    			},
    			function(nodeId, nodeType,pdId) {
    				loadTab(nodeId, nodeType,pdId);
    			}
    		);
    });

    function loadTab(nodeId, nodeType,pdId){
    	var url = "avicit/platform6/bpmreform/bpmtask/taskTab.jsp?nodeId="+nodeId+"&nodeType="+nodeType+"&pdId="+pdId;
		$("#iframeTask").attr("src",url);
    }

</script>

</html>
