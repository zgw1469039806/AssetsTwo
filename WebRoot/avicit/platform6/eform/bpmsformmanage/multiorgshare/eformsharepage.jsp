<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,tree";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
     <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
    <link rel="stylesheet" href="avicit/platform6/bpmreform/bpmdeploy/css/style.css"/>
    <script type="text/javascript">
    	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
    </script>
    <style>
		.shownorth .layout-panel-north {
			overflow:visible!important;
		}
		
		.cicon{
			color: #cccccc;
		}		
		.icon_active{
			color:#337ab7;
		}
	</style>
</head>

<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true" style="width: 236px;border-top-style: hidden;">
        <ul id="orgTree" class="ztree"></ul>
    </div>
  <div data-options="region:'center'">
        <ul id="flowTypeTreeUL" class="ztree"></ul>
    </div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/EformShareTypeTree.js"></script>

<script type="text/javascript">
	var shareTypeTree;
	
	var zTreeObj;
	var setting = {
			view: {
				selectedMulti: false,
				showIcon: true
			},
			callback: {
				onClick: zTreeOnClick
			}
	};
	var zNodes;

	
	function zTreeOnClick(event, treeId, treeNode) {
        shareTypeTree = new EformShareTypeTree("flowTypeTreeUL",treeNode.id);
	};
	
	$(document).ready(function () {
	        $.post('eform/bpmsManageController/getOrgTree',
					function(r) {
						$.each(r,function(i,item) {
							 zNodes =r;
							 zTreeObj = $.fn.zTree.init($("#orgTree"), setting, zNodes);
							 
							 var treeObj = $.fn.zTree.getZTreeObj("orgTree");
							 var nodes = treeObj.getNodes();
							 if (nodes.length>0) {
								 treeObj.selectNode(nodes[0]);
								 treeObj.setting.callback.onClick(null, nodes[0].id, nodes[0]);
								 treeObj.expandNode(nodes[0]);
							 }
						});
				});
	});
	
</script>
</body>
</html>
