<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree,table";
%>

<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>WebService服务</title>

    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
    <link rel="stylesheet" href="avicit/platform6/db/dbtabletype/css/style.css"/>
</head>
<style>
	.shownorth .layout-panel-north {
		overflow:visible!important;
	}
	a{
		color: #cccccc;
	}
	.ztree{
		overflow-x:hidden;
	}
</style>
<body>
<div class="easyui-layout" fit=true>
	<div data-options="region:'west',split:true" style="width:255px;">
	    <!-- 数据源分类树 -->
	    <ul id="connectTypeTreeUL" class="ztree">
	    </ul>
	</div>

    <div data-options="region:'center'">
		<table id="eformDatasourceWsjqGrid"></table>
		<div id="jqGridPager"></div>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/db/dbtabletype/js/common.js"></script>
<script src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/webservice/js/webserviceTree.js"></script>
<script src="avicit/platform6/bpmreform/bpmdesigner/editors/js/template/webservice/js/webserviceList.js"></script>

<script type="text/javascript">
	var connectTypeTree;
    var soapwebservice;
    
    $(document).ready(function () {
    	connectTypeTree = new ConnectTypeTree("connectTypeTreeUL");  		
    });

    function getSelectRow(){
        if(soapwebservice==undefined){
        	layer.alert('请选择数据！', {
    			icon : 7,
    			area : [ '400px', '' ], //宽高
    			closeBtn : 0
    		});
    		return null;
         }
    	return soapwebservice.getSelectRow();
    }
</script>
</body>
</html>