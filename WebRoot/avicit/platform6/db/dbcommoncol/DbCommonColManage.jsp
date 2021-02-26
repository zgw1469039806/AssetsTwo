<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form,tree";
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform/avicit/platform6/db/dbCommonColController/toDbCommonColManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
	<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css" />
</head>
<body>
<div class="easyui-layout" fit="true" id="dbCommonCol">
	<div data-options="region:'west',split:true,disabled:false ,width:fixwidth(0.15,e),height:fixheight(1.0,e)"
		 style="background: #ffffff; height: 0px; padding: 0px; overflow: hidden;">
		<div>
			<ul id="dbColClassUL" class="ztree">
			</ul>
		</div>
	</div>
	<div data-options="region:'center',disabled:false ,width:fixwidth(0.85,e),height:fixheight(1.0,e),onResize:function(a){$('#dbCommonColjqGrid').setGridHeight(getJgridTableHeight($('#tableDbCommonCol_div')));$('#dbCommonColjqGrid').jqGrid('resizeGrid');} "
		 style="background: #ffffff; height: 0px; padding: 0px; overflow: hidden;"
		 id="tableDbCommonCol_div">
		<div id="tableToolbar" class="toolbar">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dbCommonCol_button_add" permissionDes="添加">
					<a id="dbCommonCol_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dbCommonCol_button_edit" permissionDes="编辑">
					<a id="dbCommonCol_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dbCommonCol_button_delete" permissionDes="删除">
					<a id="dbCommonCol_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
			</div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search">
					<input type="text" name="dbCommonCol_keyWord" id="dbCommonCol_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
					<label id="dbCommonCol_searchPart" class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="dbCommonCol_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
				</div>
			</div>
		</div>
		<table id="dbCommonColjqGrid"></table>
		<div id="jqGridPager"></div>
	</div>
</div>


</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<input class="form-control input-sm" type="hidden" name="colClass"  id="colClass" />
			<tr>
				<th width="10%">
					<label for="colName">字段名称:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="colName"  id="colName" />
				</td>
				<th width="10%">
					<label for="colComments">字段描述:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="colComments"  id="colComments" />
				</td>
			</tr>
			<tr>
				<th width="10%">
					<label for="colType">数据类型:</label>
				</th>
				<td width="39%">
					<pt6:h5select css_class="form-control input-sm" name="colType" id="colType" title="" isNull="true" lookupCode="PLATFORM_DB_COL_TYPE" />
				</td>

				<th>
					<label for="colDomType">字段类型:</label>
				</th>
				<td>
					<pt6:h5select css_class="form-control input-sm" name="colDomType" id="colDomType" title="" isNull="true" lookupCode="PLATFORM_DB_COL_DOM_TYPE" />
				</td>
			</tr>
    	</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/db/dbcommoncol/js/DbCommonCol.js" type="text/javascript"></script>
<script type="text/javascript">
var dbCommonCol;

function formatcolDomType(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	var domTypeList = dbCommonCol.colTypeList['all'].split(";");
	for(var i = 0; i < domTypeList.length; i++){
		var domTypeStr = domTypeList[i];
		var domType = domTypeStr.split(":");
		if(cellvalue == domType[0]){
			return domType[1]
		}
	}
	return cellvalue;
}

function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="dbCommonCol.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
		
$(document).ready(function () {
	var dataGridColModel =  [
		{
			label : 'id',
			name : 'id',
			key : true,
			width : 75,
			hidden : true
		},
		{
			label : '字段名称',
			name : 'colName',
			width: 150,
			align:"center"
		},
		{
			label : '字段描述',
			name : 'colComments',
			width: 150,
			align:"center"
		},
		{
			label : '数据类型',
			name : 'colType',
			width: 150,
			align:"center"
		},
		{
			label : '字段长度',
			name : 'colLength',
			width: 150,
			align:"right"
		},
		{
			label : '小数位数',
			name : 'colDecimal',
			width: 150,
			align:"right"
		},
		{
			label : '排序',
			name : 'orderBy',
			width: 150,
			align: "center"
		},
		{
			label : '字段类型',
			name : 'colDomType',
			width: 150,
			align:"center",
			formatter: formatcolDomType
		},
		{
			label : '所属分类',
			name : 'colClass',
			width: 150,
			align:"center"
		}
	];
	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("colName");
	searchTips.push("字段名称");
	var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
	$('#dbCommonCol_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	
	dbCommonCol= new DbCommonCol('dbCommonColjqGrid','${url}','searchDialog','form','dbCommonCol_keyWord',searchNames,dataGridColModel);
	dbColClassTree= new DbColClassTree('dbColClassUL');
	//添加按钮绑定事件
	$('#dbCommonCol_insert').bind('click', function(){
		dbCommonCol.insert();
	});
	//编辑按钮绑定事件
	$('#dbCommonCol_modify').bind('click', function(){
		dbCommonCol.modify();
	});
	//删除按钮绑定事件
	$('#dbCommonCol_del').bind('click', function(){  
		dbCommonCol.del();
	});
	//查询按钮绑定事件
	$('#dbCommonCol_searchPart').bind('click', function(){
		dbCommonCol.searchByKeyWord();
	});
	//打开高级查询框
	$('#dbCommonCol_searchAll').bind('click', function(){
		dbCommonCol.openSearchForm(this);
	});			
});

</script>
</html>
