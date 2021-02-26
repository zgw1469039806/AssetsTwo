<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree,table,form";
%>

<!DOCTYPE html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>search config</title>

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
	#t_searchModel{
		display:none;
	}
</style>
<body>
<div class="easyui-layout shownorth" fit=true>
    <div data-options="region:'north',split:true" style="height:50px;overflow:visible">
	    	<div class="toolbar">
	    		<div class="toolbar-left">
	    			<div class="dropdown">
	                    <a class="btn btn-primary form-tool-btn btn-sm" role="button" href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu" aria-expanded="false"><i class="icon icon-fenleiguanli"></i>  分类管理<span class="caret"></span></a>
	                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="text-align:left;min-width:120px;">
	                         <li role="presentation"> <a id="addSearchType" href="javascript:void(0);" title="添加分类"><%--<i class="icon icon-add"></i>--%> 添加分类</a></li>
	                         <li role="separator" class="divider"></li>
	                         <li role="presentation"> <a id="editSearchType" href="javascript:void(0);" title="编辑分类"><%--<i class="icon icon-edit"></i> --%>编辑分类</a></li>
	                         <li role="separator" class="divider"></li>
	                         <li role="presentation"> <a id="deleteSearchType" href="javascript:void(0);" title="删除分类"><%--<i class="icon icon-delete"></i>--%> 删除分类</a></li>
	                    </ul>
	                </div>
	                <a id="auth" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="授权"><i class="icon icon-quanxian"></i>授权</a>
	                <a id="addSearch" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="icon icon-add"></i>添加</a>
	                <a id="editSearch" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="icon icon-edit"></i>编辑</a>
	                <a id="deleteSearch" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="icon icon-delete"></i>删除</a>
	                <a id="buildIndex" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="重建索引"><i class="icon icon-quanxian"></i>重建索引</a>
    			</div>
	    	</div>
    	</div>

	<div data-options="region:'west',split:true" style="width:255px;">
	    <!-- 数据源分类树 -->
	    <ul id="searchTypeTreeUL" class="ztree">
	    </ul>
	</div>

    <div data-options="region:'center'" style="width:81%">
		  <table id="searchModel"></table>
		  <div id="jqGridPager"></div>
    </div>
</div>


<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/db/dbtabletype/js/common.js"></script>
<script src="avicit/platform6/modules/system/fulltextsearch/js/SearchTypeTree.js"></script>
<script src="avicit/platform6/modules/system/fulltextsearch/js/SearchType.js"></script>
<script src="avicit/platform6/modules/system/fulltextsearch/js/Search.js"></script>
<script src="avicit/platform6/modules/system/fulltextsearch/js/SearchInfo.js"></script>
<script type="text/javascript">
	var searchTypeTree;
	var searchType;
	var search;
    var searchInfo
    
    function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="sysSearchInfo.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 	}
	function formatDateForHref(cellvalue, options, rowObject){
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysSearchInfo.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
	}
    
    $(document).ready(function () {
				search = new Search();
				searchType = new SearchType();
				searchTypeTree = new SearchTypeTree("searchTypeTreeUL");

				//分类事件
				$("#addSearchType").click(function() {
					searchType.addData();
				});
				$("#editSearchType").click(function() {
					searchType.editData();
				});
				$("#deleteSearchType").click(function() {
					searchType.deleteData();
				});

				//数据源事件
				$("#addSearch").click(function() {
					search.addData();
				});
				$("#editSearch").click(function() {
					search.editData("");
				});
				$("#deleteSearch").click(function() {
					search.deleteData();
				});
				$("#buildIndex").click(function() {
					layer.confirm('重建索引有风险，确认重建吗?', {
						icon : 3,
						title : "提示",
						area : [ '400px', '' ]
					}, function(index) {
						layer.close(index);
						search.buildIndex();
					});
				});
				//授权事件
				$("#auth").click(function() {
					var selectedNode = searchTypeTree.tree.getNodeByParam("id", searchTypeTree.selectedNodeId, null);
				    if (selectedNode.pId == null || selectedNode.pId == "-1"||selectedNode.id.length<20) {
				        layer.msg('请先选择分类，再进行授权！',{icon: 7});
				    }else{
				    	layer.open({
					        type: 2,
					        title: '授权管理',
					        skin: 'bs-modal',
					        area: ['70%', '70%'],
					        maxmin: false,
					        content: "avicit/platform6/modules/system/sysac/SysAcManager.jsp?parentId="+selectedNode.id
					    });
				    }
				});
			});
</script>
</body>
</html>