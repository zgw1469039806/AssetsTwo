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
<!-- ControllerPath = "platform6/mda/mdakeywords/mdaKeywordsController/toMdaKeywordsManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaKeywords_button_add" permissionDes="昨天">
  	<a id="mdaSearchByYestady" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="昨天"><i class="fa fa-plus"></i> 昨天</a>
	</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaKeywords_button_add" permissionDes="今天">
  	<a id="<!-- mdaKeywords_insert -->" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="今天"><i class="fa fa-plus"></i> 今天</a>
	</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaKeywords_button_add" permissionDes="最近7天">
  	<a id="<!-- mdaKeywords_insert -->" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="最近7天"><i class="fa fa-plus"></i> 最近7天</a>
	</sec:accesscontrollist>
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaKeywords_button_add" permissionDes="最近30天">
  	<a id=" " href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="最近30天"><i class="fa fa-plus"></i> 最近30天</a>
	</sec:accesscontrollist>
		<%-- <sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaKeywords_button_add" permissionDes="添加">
  	<a id="mdaKeywords_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaKeywords_button_edit" permissionDes="编辑">
	<a id="mdaKeywords_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaKeywords_button_delete" permissionDes="删除">
	<a id="mdaKeywords_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist> --%>
		</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="mdaKeywords_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="mdaKeywords_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="mdaKeywordsjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
    	   <table class="form_commonTable">
			    <tr>
					<th width="10%">关键词:</th>
						<td width="39%">
	    					<input title="关键词" class="form-control input-sm" type="text" name="name" id="name" />
	    				</td>
					<th width="10%">频率:</th>
							<td width="39%">
								<div class="input-group input-group-sm spinner" data-trigger="spinner">
									<input title="" type="text" class="form-control" name="rate" id="rate"   data-min="0" data-max="999999999999" data-step="1" data-precision="0">
								<span class="input-group-addon">
								    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
								    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
								  </span>
										 </div>
										</td>
									</tr>
									<tr>
									<th width="10%">类型:</th>
																			<td width="39%">
										<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input title="" type="text" class="form-control" name="type" id="type"   data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										 </div>
										</td>
																								 						   						   						   																							  						   							 									<th width="10%">时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="timeBegin" id="timeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
																				 </tr>
										 <tr>
									        									<th width="10%">时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="timeEnd" id="timeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
                </tr>
    	</table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdakeywords/js/MdaKeywords.js" type="text/javascript"></script>
<script type="text/javascript">
var mdaKeywords;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mdaKeywords.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="mdaKeywords.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
		
$(document).ready(function () {
	var dataGridColModel =  [
	{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
	,{ label: '关键词', name: 'name', width: 150}
	,{ label: '频率', name: 'rate', width: 150}
	,{ label: '类型', name: 'type', width: 150}
	,{ label: '时间', name: 'time', width: 150,formatter:format}
	];
	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("name");
    searchTips.push("关键词");
	$('#keyWord').attr('placeholder','请输入'+searchTips[0]+'或'+searchTips[1]);
	mdaKeywords= new MdaKeywords('mdaKeywordsjqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#mdaKeywords_insert').bind('click', function(){
		mdaKeywords.insert();
	});
	//编辑按钮绑定事件
	$('#mdaKeywords_modify').bind('click', function(){
		mdaKeywords.modify();
	});
	//删除按钮绑定事件
	$('#mdaKeywords_del').bind('click', function(){  
		mdaKeywords.del();
	});
	//查询按钮绑定事件
	$('#mdaKeywords_searchPart').bind('click', function(){
		mdaKeywords.searchByKeyWord();
	});
	//搜索统计      查询昨天
	$('#mdaSearchByYestady').bind('click', function(){
		mdaKeywords.searchByYestaddy();
	});
	//打开高级查询框
	$('#mdaKeywords_searchAll').bind('click', function(){
		mdaKeywords.openSearchForm(this);
	});
																																																																																																															
});

</script>
</html>