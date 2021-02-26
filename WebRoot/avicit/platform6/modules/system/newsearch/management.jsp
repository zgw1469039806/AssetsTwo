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
<body class="easyui-layout" fit="true">
	 <div id="north1" data-options="region:'north',split:true,title:''" style="height:300px;overflow-x:hidden;">
	 	<div id="toolbar_searchIndex" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_searchIndex_button_dataSourceConf" permissionDes="数据源配置">
					<a id="searchIndex_dataSourceConf" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="数据源配置"><i class="glyphicon glyphicon-cog"></i> 数据源配置</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
				domainObject="formdialog_searchIndex_button_add" permissionDes="添加数据库数据源">
				<a id="searchIndex_insertDb" href="javascript:void(0)"
					class="btn btn-primary form-tool-btn btn-sm" role="button"
					title="添加数据库数据源"><i class="icon icon-add"></i> 添加数据库数据源</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_searchIndex_button_add" permissionDes="添加文档数据源">
					<a id="searchIndex_insertDoc" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="添加文档数据源"><i class="icon icon-add"></i> 添加文档数据源</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" 
					domainObject="formdialog_searchIndex_button_edit" permissionDes="编辑">
					<a id="searchIndex_modify" href="javascript:void(0)" 
						class="btn btn-primary form-tool-btn btn-sm" role="button" 
						title="编辑"><i class="icon icon-edit"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_searchIndex_button_del" permissionDes="删除">
					<a id="searchIndex_del" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="删除"><i class="icon icon-delete"></i> 删除</a>
				</sec:accesscontrollist>
				
				<div class="dropdown">
					<a class="btn btn-primary form-tool-btn btn-sm" role="button"  href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu"><i class="icon icon-setting"></i>工具<span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
					
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_searchIndex_button_edit" permissionDes="设置为有效">
							<li role="presentation"><a id="searchIndex_setOk" href="javascript:void(0)"  title="设置为有效">设置为有效</a></li>
							<li role="separator" class="divider"></li>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_searchIndex_button_edit" permissionDes="设置为无效">
							<li role="presentation"><a id="searchIndex_setCancel" href="javascript:void(0)"  title="设置为无效"> 设置为无效</a></li>
							<li role="separator" class="divider"></li>
						</sec:accesscontrollist>
						<sec:accesscontrollist hasPermission="3" domainObject="formdialog_searchIndex_button_add" permissionDes="重建索引">
							<li role="presentation"><a id="searchIndex_buildIndex" href="javascript:void(0)"  title="重建索引">重建索引</a></li>
						</sec:accesscontrollist>
					</ul>
				</div>
			</div>
		</div>
		<table id="searchIndex"></table>
		<div id="searchIndexPager"></div>
	</div>
	 <div id= "north2" data-options="region:'center',split:true,title:'字段设置'" style="padding:0px;">
		<div class="easyui-layout" fit="true">
			<div data-options="region:'center',split:true" style="height:272px;overflow-x:hidden;">
				<table id="searchCol"></table>
			</div>
			<div data-options="region:'east',split:true" style="width:700px;height:272px;overflow-x:hidden;">
				<div id="toolbar_colDetail" class="toolbar">
					<div class="toolbar-left">
						<sec:accesscontrollist hasPermission="3" 
							domainObject="formdialog_searchIndex_button_save" permissionDes="编辑">
							<a id="searchIndex_save" href="javascript:void(0)" 
								class="btn btn-primary form-tool-btn btn-sm" role="button" 
								title="保存"><i class="icon icon-save"></i>保存</a>
						</sec:accesscontrollist>
					</div>
				</div>
				<table id="colDetail"></table>
			</div>
		</div>
	</div>
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/modules/system/newsearch/js/management.js" type="text/javascript"></script> 
<script src="avicit/platform6/modules/system/newsearch/js/searchCol.js" type="text/javascript"></script> 
<script src="avicit/platform6/modules/system/newsearch/js/colDetail.js" type="text/javascript"></script>
<script type="text/javascript">
var searchIndex;
var searchCol;
var colDetail;
function formatType(cellvalue, options, rowObject) {
	 if (cellvalue ==1){    
	     return '数据库数据源';    
	 } else {    
	     return '文档数据源';    
	 }  
}
function formatStatus(cellvalue, options, rowObject) {
	if (cellvalue ==1){    
        return '有效';    
    } else {    
        return '无效';    
    }  
}
function formatIndexed(cellvalue, options, rowObject) {
	if (cellvalue ==1){    
        return '是';    
    } else {    
        return '否';    
    }  
}
function formatBelong(cellvalue, options, rowObject) {
	if (cellvalue ==0){    
        return '无';    
    } else if(cellvalue ==1) {    
        return '标题';    
    } else{
        return '正文'; 
    } 
}
function formatAction(cellvalue, options, rowObject) {
	return '     '+'<a href="javascript:void(0);" onclick="colDetail.del(\''+options.rowId+'\');">删除</a>';
}
$(document).ready(function () {
	var dataGridDgModel =  [
      { label: 'id', name: 'id', key: true, width: 75, hidden:true }
 	  ,{ label: '数据源名称', name: 'datasourceName', width: 150}
      ,{ label: '显示名称', name: 'displayName', width: 150 }
      ,{ label: '数据源类型', name: 'type', width: 150,formatter:formatType }
      ,{ label: '文档路径', name: 'docPath', width: 150}
      ,{ label: 'SQL', name: 'sqlStatement', width: 150}
      ,{ label: '是否有效', name: 'status', width: 150,formatter:formatStatus }
	];
	var dataGridDgUserModel =  [
         { label: 'id', name: 'id', key: true, width: 75, hidden:true }
    	 ,{ label: '字段名', name: 'columnName', width: 150}
         ,{ label: '字段类型', name: 'columnType', width: 150 }
   	];
	var dataGridDetailModel =  [
      { label: 'id', name: 'id', key: true, width: 75, hidden:true }
 	  ,{ label: '字段名', name: 'columnName', width: 150}
      ,{ label: '字段类型', name: 'columnType', width: 150,hidden:true }
      ,{ label: '是否索引', name: 'indexed', width: 150,formatter:formatIndexed,editable : true,edittype : 'select',
    	  editoptions :{value : {1:'是',0:'否'}}}
      ,{ label: '是否存储', name: 'stored', width: 150,formatter:formatIndexed,editable : true,edittype : 'select',
    	  editoptions :{value : {1:'是',0:'否'}}}
      ,{ label: '是否密级', name: 'secreted', width: 150,formatter:formatIndexed,editable : true,edittype : 'select',
    	  editoptions :{value : {1:'是',0:'否'}}}
      ,{ label: '归属', name: 'belong', width: 150,formatter:formatBelong,editable : true,edittype : 'select',
    	  editoptions :{value : {2:'正文',1:'标题',0:'无'}} }
      ,{ label: '操作', name: 'action', width: 150,formatter:formatAction }
   	];
	
	searchIndex = new SearchIndex('searchIndex','', "form", dataGridDgModel, '', 
		function(pid){
			searchCol = new SearchCol('searchCol','', "formSub", dataGridDgUserModel, '', pid, null, function(id){
				var searchColRowData = $("#searchCol").jqGrid('getRowData',id);
				var colDetailRowDatas = $("#colDetail").jqGrid('getRowData');
				var flag=true;
				for(var i=0;i<colDetailRowDatas.length;i++){
					if(colDetailRowDatas[i].columnName==searchColRowData.columnName){
    					alert(searchColRowData.columnName+'已存在!');
    					flag=false;
    				}
				}
				if(flag){
					colDetail.insert(searchColRowData.columnName);	
				}
			});
			colDetail = new ColDetail('searchIndex','colDetail','', "formSub", dataGridDetailModel, '', pid, null, "");
		},
		function(pid){
			searchCol.reLoad(pid);
			colDetail.reLoad(pid);
		},
		null,
		""
	);
	
	
	//主表
	//添加数据库按钮绑定事件
	$('#searchIndex_insertDb').bind('click', function() {
		searchIndex.insertDb();
	});
	//添加文档按钮绑定事件
	$('#searchIndex_insertDoc').bind('click', function() {
		searchIndex.insertDoc();
	});
	//编辑按钮绑定事件
	$('#searchIndex_modify').bind('click', function(){
		searchIndex.modify();
	});
	//设置有效按钮绑定事件
	$('#searchIndex_setOk').bind('click', function(){
		searchIndex.setOk();
	});
	//设置无效按钮绑定事件
	$('#searchIndex_setCancel').bind('click', function(){
		searchIndex.setCancel();
	});
	//重建索引按钮绑定事件
	$('#searchIndex_buildIndex').bind('click', function() {
		searchIndex.buildIndex();
	});
	//删除按钮绑定事件
	$('#searchIndex_del').bind('click', function() {
		searchIndex.del();
	});
	//添加数据源配置按钮绑定事件
	$('#searchIndex_dataSourceConf').bind('click', function() {
		searchIndex.addDataSourceConf();
	});
	//保存字段按钮绑定事件
	$('#searchIndex_save').bind('click', function() {
		colDetail.save();
	});
});
</script>