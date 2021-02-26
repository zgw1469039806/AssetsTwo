<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>业务域查询</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
    <script type="text/javascript">
    	var _bpm_baseurl = "<%=ViewUtil.getRequestPath(request)%>";
    </script>
</head>

<body class="easyui-layout" fit="true" style="overflow:hidden;">
    
    <div data-options="region:'east',split:true,onResize:function(a){$(window).trigger('resize');}" style="width:200px;">
    	<div>
				<ul id="sxylcTree" class="ztree"></ul>
		</div>
    </div>
    <div data-options="region:'west',split:true,width:fixwidth(.3),onResize:function(a){$(window).trigger('resize');}" >
    	<div class="row" style="margin: 5px;">

			<div>
				<ul id="treeDemo" class="ztree"></ul>
			</div>
		</div>
    </div>
    <div data-options="region:'center',split:true,onResize:function(a){$(window).trigger('resize');}" >
    	<div id="centerDiv" style="height:100%;width:100%;overflow:hidden;">
		 <iframe id="iframeCenter" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
		</div>
    </div>
    <div data-options="region:'south',split:false,collapsible:true" >
    	<div id="southDiv" style="height:100%;width:100%;overflow:hidden;">
		 <iframe id="iframeSouth" src="" scrolling="no" frameborder="0" style="width:100%;height:100%; border: 0;"></iframe>
		</div>
    </div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmdomain/js/BpmCatalogTree.js"
	type="text/javascript"></script>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script type="text/javascript">
	var bpmCatalog;
	

    $(document).ready(function () {
    	bpmCatalog = new BpmCatalogTree('treeDemo', 'bpm/monitor/getFlowModelTree', '', '', '',
    			function(nodeId, nodeType,pdId) {
    				loadCenter(nodeId, nodeType,pdId);
    			},
    			function(nodeId, nodeType,pdId) {
    				loadCenter(nodeId, nodeType,pdId);
    			}
    		);    	
    });
    
    function loadCenter(nodeId, nodeType,pdId){
        if(nodeType!='catalog'){
        	var url = "avicit/platform6/bpmreform/bpmdomain/processTab.jsp?nodeId="+nodeId+"&nodeType="+nodeType+"&pdId="+pdId;
    		$("#iframeCenter").attr("src",url);
        }
    	
    }

    function loadEast(id){
    	avicAjax.ajax({
            url: "bpm/bpmdomain/getParentAndSubProcessses",
            data: "procInstId=" + id,
            type: "post",
            dataType: "json",
            success: function (backData) {
				var setting = {
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
								loadSouth(treeNode.id);
							}
						 }
						};
            	var treeObj = $.fn.zTree.init($("#sxylcTree"), setting, backData.result);
            }
        });
    }

    function loadSouth(id){
        var url = "avicit/platform6/bpmreform/bpmdesigner/picture/pic.jsp?entryId="+id;
    	$("#iframeSouth").attr("src",url);
    	
    }

    function loadEastAndSouth(id){
    	loadSouth(id);
    	loadEast(id);
    }
   
</script>

</html>