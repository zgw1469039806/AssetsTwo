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
<!-- ControllerPath = "platform/avicit/cadreselect/dynTemplate/dynTemplateController/toDynTemplateManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynTemplate_button_add" permissionDes="添加">
	  		<a id="dynTemplate_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynTemplate_button_edit" permissionDes="编辑">
			<a id="dynTemplate_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynTemplate_button_delete" permissionDes="删除">
			<a id="dynTemplate_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
		</sec:accesscontrollist>
	</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="dynTemplate_keyWord" id="dynTemplate_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="dynTemplate_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="dynTemplate_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="dynTemplatejqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">
					<label for="temTitle">模板名称:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="temTitle"  id="temTitle" />
				</td>
				<th width="10%">
					<label for="temNotice">投票须知:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="temNotice"  id="temNotice" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="temText">表格JSON:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="temText"  id="temText" />
				</td>
				<th>
					<label for="temShouldInvestNum">应投数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="temShouldInvestNum" id="temShouldInvestNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="temActualInvestNum">实投数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="temActualInvestNum" id="temActualInvestNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="temLoginNum">登陆数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="temLoginNum" id="temLoginNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="temSceneNum">实到数:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="temSceneNum" id="temSceneNum" data-min="-9999999999999999" data-max="9999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
				<th>
					<label for="temType">投票类型:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="temType" id="temType" data-min="-9999999999999999999999" data-max="9999999999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>
					<label for="temState">0-使用中 1-暂停 2-删除:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="temState" id="temState" data-min="-9999999999999999999999" data-max="9999999999999999999999" data-step="1" data-precision="0">
						<span class="input-group-addon">
							<a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
							<a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
						</span>
					</div>
				</td>
    	</table>
	</form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/cadreselect/dyntemplate/js/DynTemplate.js?v=${jsversion}" type="text/javascript"></script>
<script type="text/javascript">
var dynTemplate;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="dynTemplate.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="dynTemplate.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//清空日期值
function clearCommonSelectValue(element) {
	$(element).siblings("input").val("");
}
		
$(document).ready(function () {
	var dataGridColModel =  [
		{ label : 'id', name : 'id', key : true, width : 75, hidden : true},
		{ label : '模板名称', name : 'temTitle',formatter:formatValue,width: 150},
		{ label : '投票须知', name : 'temNotice',width: 150},
		{ label : '表格JSON', name : 'temText',width: 150},
		{ label : '应投数', name : 'temShouldInvestNum',width: 150},
		{ label : '实投数', name : 'temActualInvestNum',width: 150},
		{ label : '登陆数', name : 'temLoginNum',width: 150},
		{ label : '实到数', name : 'temSceneNum',width: 150},
		{ label : '投票类型', name : 'temType',width: 150},
		{ label : '0-使用中 1-暂停 2-删除', name : 'temState', width: 150}
	];

	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("temTitle");
	searchTips.push("模板名称");
	searchNames.push("temNotice");
	searchTips.push("投票须知");
	var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
	$('#dynTemplate_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	
	dynTemplate= new DynTemplate('dynTemplatejqGrid','${url}','searchDialog','form','dynTemplate_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#dynTemplate_insert').bind('click', function(){
		dynTemplate.insert();
	});
	//编辑按钮绑定事件
	$('#dynTemplate_modify').bind('click', function(){
		dynTemplate.modify();
	});
	//删除按钮绑定事件
	$('#dynTemplate_del').bind('click', function(){  
		dynTemplate.del();
	});
	//查询按钮绑定事件
	$('#dynTemplate_searchPart').bind('click', function(){
		dynTemplate.searchByKeyWord();
	});
	//打开高级查询框
	$('#dynTemplate_searchAll').bind('click', function(){
		dynTemplate.openSearchForm(this);
	});			
});

</script>
</html>
