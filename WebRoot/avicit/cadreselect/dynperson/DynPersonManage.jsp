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
<!-- ControllerPath = "platform/avicit/cadreselect/dynPerson/dynPersonController/toDynPersonManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynPerson_button_add" permissionDes="添加">
	  		<a id="dynPerson_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynPerson_button_edit" permissionDes="编辑">
			<a id="dynPerson_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynPerson_button_delete" permissionDes="删除">
			<a id="dynPerson_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
		</sec:accesscontrollist>
	</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="dynPerson_keyWord" id="dynPerson_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="dynPerson_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="dynPerson_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="dynPersonjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">
					<label for="perName">姓名:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="perName"  id="perName" />
				</td>
				<th width="10%">
					<label for="perDept">部门:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="perDept"  id="perDept" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="perSex">性别:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="perSex" id="perSex" data-min="-9999999999999999999999" data-max="9999999999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="perBirth">出生年月:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="perBirth"  id="perBirth" />
				</td>
			</tr>
    	</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/cadreselect/dynperson/js/DynPerson.js?v=${jsversion}" type="text/javascript"></script>
<script type="text/javascript">
var dynPerson;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="dynPerson.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="dynPerson.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//清空日期值
function clearCommonSelectValue(element) {
	$(element).siblings("input").val("");
}
		
$(document).ready(function () {
	var dataGridColModel =  [
		{ label : 'id', name : 'id', key : true, width : 75, hidden : true},
		{ label : '姓名', name : 'perName',formatter:formatValue,width: 150},
		{ label : '部门', name : 'perDept',width: 150},
		{ label : '性别', name : 'perSex',width: 150},
		{ label : '出生年月', name : 'perBirth', width: 150}
	];

	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("perName");
	searchTips.push("姓名");
	searchNames.push("perDept");
	searchTips.push("部门");
	var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
	$('#dynPerson_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	
	dynPerson= new DynPerson('dynPersonjqGrid','${url}','searchDialog','form','dynPerson_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#dynPerson_insert').bind('click', function(){
		dynPerson.insert();
	});
	//编辑按钮绑定事件
	$('#dynPerson_modify').bind('click', function(){
		dynPerson.modify();
	});
	//删除按钮绑定事件
	$('#dynPerson_del').bind('click', function(){  
		dynPerson.del();
	});
	//查询按钮绑定事件
	$('#dynPerson_searchPart').bind('click', function(){
		dynPerson.searchByKeyWord();
	});
	//打开高级查询框
	$('#dynPerson_searchAll').bind('click', function(){
		dynPerson.openSearchForm(this);
	});			
});

</script>
</html>
