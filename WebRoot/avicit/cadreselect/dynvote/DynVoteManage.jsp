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
<!-- ControllerPath = "platform/avicit/cadreselect/dynVote/dynVoteController/toDynVoteManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynVote_button_add" permissionDes="添加">
	  		<a id="dynVote_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynVote_button_edit" permissionDes="编辑">
			<a id="dynVote_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
		</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_dynVote_button_delete" permissionDes="删除">
			<a id="dynVote_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
		</sec:accesscontrollist>
	</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="dynVote_keyWord" id="dynVote_keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="dynVote_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="dynVote_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" >高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="dynVotejqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">
					<label for="dynItId">模板ITEM ID:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="dynItId"  id="dynItId" />
				</td>
				<th width="10%">
					<label for="dynVoteOpinion">意见:</label>
				</th>
				<td width="39%">
					<input class="form-control input-sm" type="text" name="dynVoteOpinion"  id="dynVoteOpinion" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="dynVoteId">标识:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="dynVoteId"  id="dynVoteId" />
				</td>
				<th>
					<label for="dynVoteIp">投票人IP:</label>
				</th>
				<td>
					<input class="form-control input-sm" type="text" name="dynVoteIp"  id="dynVoteIp" />
				</td>
			</tr>
			<tr>
				<th>
					<label for="dynVoteLog">是否登录:</label>
				</th>
				<td>
					<div class="input-group input-group-sm spinner" data-trigger="spinner">
						<input  class="form-control"  type="text" name="dynVoteLog" id="dynVoteLog" data-min="-9999999999999999999999" data-max="9999999999999999999999" data-step="1" data-precision="0">
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
<script src="avicit/cadreselect/dynvote/js/DynVote.js?v=${jsversion}" type="text/javascript"></script>
<script type="text/javascript">
var dynVote;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="dynVote.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="dynVote.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
//清空日期值
function clearCommonSelectValue(element) {
	$(element).siblings("input").val("");
}
		
$(document).ready(function () {
	var dataGridColModel =  [
		{ label : 'id', name : 'id', key : true, width : 75, hidden : true},
		{ label : '模板ITEM ID', name : 'dynItId',formatter:formatValue,width: 150},
		{ label : '意见', name : 'dynVoteOpinion',width: 150},
		{ label : '标识', name : 'dynVoteId',width: 150},
		{ label : '投票人IP', name : 'dynVoteIp',width: 150},
		{ label : '是否登录', name : 'dynVoteLog', width: 150}
	];

	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("dynItId");
	searchTips.push("模板ITEM ID");
	searchNames.push("dynVoteOpinion");
	searchTips.push("意见");
	var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
	$('#dynVote_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
	
	dynVote= new DynVote('dynVotejqGrid','${url}','searchDialog','form','dynVote_keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#dynVote_insert').bind('click', function(){
		dynVote.insert();
	});
	//编辑按钮绑定事件
	$('#dynVote_modify').bind('click', function(){
		dynVote.modify();
	});
	//删除按钮绑定事件
	$('#dynVote_del').bind('click', function(){  
		dynVote.del();
	});
	//查询按钮绑定事件
	$('#dynVote_searchPart').bind('click', function(){
		dynVote.searchByKeyWord();
	});
	//打开高级查询框
	$('#dynVote_searchAll').bind('click', function(){
		dynVote.openSearchForm(this);
	});			
});

</script>
</html>
