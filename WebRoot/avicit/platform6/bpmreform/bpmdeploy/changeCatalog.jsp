<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>切换目录</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
</head>

<body>
<div class="easyui-layout" fit=true>
	<div data-options="region:'center',split:true,border:false">
		<ul id="catalogTree" class="ztree">
    	</ul>
	</div>
    
    <div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="取消" id="closeForm"><span
                            class="glyphicon glyphicon-share-alt" aria-hidden="true">取消</span></a>
                </td>
            </tr>
        </table>
    </div>
</div>
</div>


<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/bpmreform/bpmdeploy/js/CatalogTree.js"></script>

<script type="text/javascript">
    var catalogTree;
    var processDefId = "<%=request.getParameter("processDefId")%>";
    var nodeId = "<%=request.getParameter("nodeId")%>";
    
    document.ready = function () {
    	catalogTree = new CatalogTree("catalogTree");
    	//返回按钮绑定事件
		$('#closeForm').bind('click', function() {
			parent.deployedFlow.closeDialog("changeCatalog");
		});
    };
</script>
</body>
</html>
