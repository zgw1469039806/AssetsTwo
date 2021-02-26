<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div class="easyui-layout shownorth" fit=true>
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
		<table id="jqGrid"></table>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
	    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
	        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
	            <tr>
	                <td width="50%" align="right">
	                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn typeb btn-sm" role="button" title="导入" id="importTable">导入</a>
	                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm">取消</a>
	                </td>
	            </tr>
	        </table>
	    </div>
	</div>
</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/db/dbtabletype/js/DbTableImport.js"></script>
<script type="text/javascript">

$(document).ready(function () {
	var dataGridColModel = [ {
		label : 'id',
		name : 'id',
		key : true,
		width : 75,
		hidden : true
	},  {
		label : 'pk',
		name : 'pk',
		width : 150,
		editable : false,
		hidden : true
	},{
		label : '数据库表名',
		name : 'tableName',
		width : 150,
		editable : false,
		sortable:false
	},{
		label : '数据库表描述',
		name : 'tableComment',
		width : 150,
		editable : false,
		sortable:false
	},{
		label : 'dataSourceId',
		name : 'dataSourceId',
		width : 75,
		editable : false,
		hidden : true
	}];
	
	$("#jqGrid").jqGrid({
		url : 'platform/db/import/getImportTable',
		mtype : 'POST',
		datatype : "json",
		colModel : dataGridColModel,//表格列的属性
		height : $(window).height() - 100-20,//初始化表格高度
		scrollOffset : 20, //设置垂直滚动条宽度
		altRows : true,//斑马线
		loadComplete : function() {
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		styleUI : 'Bootstrap', //Bootstrap风格
		viewrecords : true, //是否要显示总记录数
		multiselect : true,//可多选
		autowidth : true,//列宽度自适应
		rowNum: 'all',//每页条数
		responsive:true,//开启自适应
		cellEdit : false,
		cellsubmit : 'clientArray'
	});

	$('#keyWord').on('keyup',function(e){
		if(e.keyCode == 13){
			searchByKeyWord();
		}
	});
	$("#demoSingle_searchPart").click(function () {
		searchByKeyWord();
    });
	
	$("#importTable").on("click",function(){
		 copyTable();
	});
	$("#closeForm").on("click",function(){
		parent.dbTableCol.closeDialog("copy");
	});
});

</script>
</html>