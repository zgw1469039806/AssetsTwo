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
<!-- ControllerPath = "platform6/mda/mdasearchconfig/mdaSearchconfigController/toMdaSearchconfigManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaSearchconfig_button_add" permissionDes="添加">
  	<a id="mdaSearchconfig_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaSearchconfig_button_edit" permissionDes="编辑">
	<a id="mdaSearchconfig_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaSearchconfig_button_delete" permissionDes="删除">
	<a id="mdaSearchconfig_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist>
		</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="mdaSearchconfig_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="mdaSearchconfig_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="mdaSearchconfigjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
    	   <table class="form_commonTable">
			    <tr>
									<th width="10%">配置名称:</th>
										    								 <td width="39%">
	    								 <input title="配置名称" class="form-control input-sm" type="text" name="name" id="name" />
	    								 </td>
									<th width="10%">过滤级别:</th>
																			<td width="39%">
										<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input title="" type="text" class="form-control" name="numbers" id="numbers"   data-min="0" data-max="5" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										 </div>
										</td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">过滤内容:</th>
										    								 <td width="39%">
	    								 <input title="过滤内容" class="form-control input-sm" type="text" name="filtercontent" id="filtercontent" />
	    								 </td>
																								 						   						   						   																							  						   							 									<th width="10%">创建时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="createtimeBegin" id="createtimeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
																				 </tr>
										 <tr>
									        									<th width="10%">创建时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="createtimeEnd" id="createtimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   						   						   																							  						   							 								<th width="10%">状态:</th>
																		 <td width="39%">
                                     <pt6:h5select css_class="form-control input-sm" name="status" id="status" title="状态" isNull="true" lookupCode="MDA_STATUS" />
                                     </td>
                                     																	</tr>
									<tr>
															 						   						   						   														 </tr>
    	</table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdasearchconfig/js/MdaSearchconfig.js" type="text/javascript"></script>
<script type="text/javascript">
var mdaSearchconfig;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mdaSearchconfig.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="mdaSearchconfig.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
		
$(document).ready(function () {
	var dataGridColModel =  [
							{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
							,{ label: '配置名称', name: 'name', width: 150}
							,{ label: '过滤级别', name: 'numbers', width: 150}
						    ,{ label: '过滤内容', name: 'filtercontent', width: 150}
							,{ label: '创建时间', name: 'createtime', width: 150,formatter:format}
							<sec:accesscontrollist hasPermission="3" domainObject="mdaSearchconfig_table_status" permissionDes="状态">
							,{ label: '状态', name: 'status', width: 150}
						</sec:accesscontrollist>
																						];
	var searchNames = new Array();
	var searchTips = new Array();
						  		  																												  		         searchNames.push("name");
    searchTips.push("检所名称");
		 	 		  							  							  		         searchNames.push("filtercontent");
    searchTips.push("过滤内容");
		 	 		  							  							  		  				$('#keyWord').attr('placeholder','请输入'+searchTips[0]+'或'+searchTips[1]);
	mdaSearchconfig= new MdaSearchconfig('mdaSearchconfigjqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#mdaSearchconfig_insert').bind('click', function(){
		mdaSearchconfig.insert();
	});
	//编辑按钮绑定事件
	$('#mdaSearchconfig_modify').bind('click', function(){
		mdaSearchconfig.modify();
	});
	//删除按钮绑定事件
	$('#mdaSearchconfig_del').bind('click', function(){  
		mdaSearchconfig.del();
	});
	//查询按钮绑定事件
	$('#mdaSearchconfig_searchPart').bind('click', function(){
		mdaSearchconfig.searchByKeyWord();
	});
	//打开高级查询框
	$('#mdaSearchconfig_searchAll').bind('click', function(){
		mdaSearchconfig.openSearchForm(this);
	});
																																																																																																																																		
});

</script>
</html>