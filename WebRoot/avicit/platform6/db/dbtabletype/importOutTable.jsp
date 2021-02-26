<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,tree,table";
%>

<html>
<head>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <title>电子表单管理</title>

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
</style>
<body>
<div class="easyui-layout shownorth" fit=true>
	<div data-options="region:'west',split:true" style="width:270px;">
	    <!-- 数据源分类树 -->
	    <ul id="dataSourceTypeTreeUL" class="ztree">
	    </ul>
	</div>

    <div data-options="region:'center',onResize:function(a){$('#dataSourceTableModel').setGridHeight(fixheight(1)-120);$(window).trigger('resize');}" style="overflow:hidden">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="overflow:hidden">
				<div id="tableToolbar" class="toolbar">
				    <div class="toolbar-right">
					    <div class="input-group form-tool-search">
				     		<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入数据库表名">
				     		<label id="demoSingle_searchPart" class="icon icon-search form-tool-searchicon"></label>
				   		</div>
				    </div>
				</div>
			</div>
			<div data-options="region:'center'" style="overflow:hidden">
				<table id="dataSourceTableModel"></table>
			</div>
		</div>
    </div>
    <div data-options="region:'south',border:false" style="height: 40px;">
	    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
	        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
	            <tr>
	                <td width="50%" align="right">
	                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn typeb btn-sm" role="button" title="确定" id="saveForm">确定</a>
	                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm">取消</a>
	                </td>
	            </tr>
	        </table>
	    </div>
	</div>
</div>

<div id="searchDialogSub" style="overflow: auto;display: none">
	<form id="formSub">
		<table class="form_commonTable" >
		</table>
	</form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/db/dbtabletype/js/common.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/OutDataSourceTree.js"></script>
<!-- <script src="avicit/platform6/modules/system/connectcenter/database/js/DataBaseType.js"></script> -->
<script src="avicit/platform6/db/dbtabletype/js/OutDataSource.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/OutDataSourceTableModel.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/DbTableSearch.js"></script>
<script src="avicit/platform6/db/dbtabletype/js/DbTableImportOut.js"></script>

<script type="text/javascript">
	var showType = "2";
	var moduleType = "1";
	var dataSourceTypeTree;
	var dataSourceType;
	var dataSource;
    var dataSourceTableModel;
    
    $(document).ready(function () {
    	
    	dataSource = new OutDataSource("dataSourceArea","DataSourceDiv");
    	//dataSourceType = new DataBaseType();
    	dataSourceTypeTree = new OutDataSourceTree("dataSourceTypeTreeUL");
    	
    	$('#keyWord').on('keyup',function(e){
    		if(e.keyCode == 13){
    			searchByKeyWord();
    		}
    	});
    	$("#demoSingle_searchPart").click(function () {
    		searchByKeyWord();
        });

        $("#saveForm").on("click",function(){
        	//alert(dataSourceTypeTree.selectedNodeId);
        	importOutTable();
   		});
        $("#closeForm").on("click",function(){
    		parent.dbTableType.closeDialog("importOut");
    	});
    });
</script>
</body>
</html>