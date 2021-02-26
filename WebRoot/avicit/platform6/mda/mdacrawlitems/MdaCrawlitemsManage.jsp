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
<!-- ControllerPath = "platform6/mda/mdacrawlitems/mdaCrawlitemsController/toMdaCrawlitemsManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCrawlitems_button_add" permissionDes="添加">
  	<a id="mdaCrawlitems_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCrawlitems_button_edit" permissionDes="编辑">
	<a id="mdaCrawlitems_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCrawlitems_button_delete" permissionDes="删除">
	<a id="mdaCrawlitems_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaCrawlitems_button_delete" permissionDes="配置">
	<a id="mdaCrawlitems_set" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="配置"><i class="fa fa-trash-o"></i> 配置</a>
	</sec:accesscontrollist>
		</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="mdaCrawlitems_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="mdaCrawlitems_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="mdaCrawlitemsjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
    	   <table class="form_commonTable">
			    <tr>
																						  						   							 							 						   						   						   																																																																																																				  						   							 								<th width="10%">采集项名称:</th>
										    								 <td width="39%">
	    								 <input title="采集项名称" class="form-control input-sm" type="text" name="name" id="name" />
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
    																					   						   						   																							  						   							 									<th width="10%">最后修改时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="lastmodifytimeBegin" id="lastmodifytimeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
																				 </tr>
										 <tr>
									        									<th width="10%">最后修改时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="lastmodifytimeEnd" id="lastmodifytimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   						   						   																							  						   							 									<th width="10%">最后爬取时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="lasttimecrawlBegin" id="lasttimecrawlBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
																				 </tr>
										 <tr>
									        									<th width="10%">最后爬取时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="lasttimecrawlEnd" id="lasttimecrawlEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																					   						   						   																							  						   							 								<th width="10%">最后爬取用户:</th>
																			<td width="39%">
										<div class="input-group  input-group-sm">
										   	  <input type="hidden"  id="lastcrawluserid" name="lastcrawluserid">
										      <input class="form-control" placeholder="请选择用户" type="text" id="lastcrawluseridAlias" name="lastcrawluseridAlias" >
										      <span class="input-group-addon" id="userbtn">
										        <i class="glyphicon glyphicon-user"></i>
										      </span>
								    	</div>
										</td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">采集类型:</th>
																		 <td width="39%">
                                     <pt6:h5select css_class="form-control input-sm" name="itemtype" id="itemtype" title="采集类型" isNull="true" lookupCode="MDA_ITEMTYPE" />
                                     </td>
                                     															 						   						   						   																							  						   							 								<th width="10%">分类:</th>
										    								 <td width="39%">
	    								 <input title="分类" class="form-control input-sm" type="text" name="classifyids" id="classifyids" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">状态:</th>
																		 <td width="39%">
                                     <pt6:h5select css_class="form-control input-sm" name="status" id="status" title="状态" isNull="true" lookupCode="MDA_STATUS" />
                                     </td>
                                     															 						   						   						   														 </tr>
    	</table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdacrawlitems/js/MdaCrawlitems.js" type="text/javascript"></script>
<script type="text/javascript">
var mdaCrawlitems;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mdaCrawlitems.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="mdaCrawlitems.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
		
$(document).ready(function () {
	var dataGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																																							  																		,{ label: '采集项名称', name: 'name', width: 150}
																																  																		,{ label: '创建时间', name: 'createtime', width: 150,formatter:format}
																													  																		,{ label: '最后修改时间', name: 'lastmodifytime', width: 150,formatter:format}
																													  																		,{ label: '最后修改时间', name: 'lasttimecrawl', width: 150,formatter:format}
																													  																		,{ label: '最后爬取用户', name: 'lastcrawluseridAlias', width: 150}
																													  																		,{ label: '采集类型', name: 'itemtype', width: 150}
																													  																		,{ label: '分类', name: 'classifyids', width: 150}
																													  																		,{ label: '状态', name: 'status', width: 150}
																						];
	var searchNames = new Array();
	var searchTips = new Array();
						  		  																												  		         searchNames.push("name");
    searchTips.push("采集项名称");
		 	 		  										  							  							  							  		  							  		  							  		         searchNames.push("classifyids");
    searchTips.push("分类");
		 	 		  							  		  				$('#keyWord').attr('placeholder','请输入'+searchTips[0]+'或'+searchTips[1]);
	mdaCrawlitems= new MdaCrawlitems('mdaCrawlitemsjqGrid','${url}','${id}','searchDialog','form','keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#mdaCrawlitems_insert').bind('click', function(){
		mdaCrawlitems.insert();
	});
	//编辑按钮绑定事件
	$('#mdaCrawlitems_modify').bind('click', function(){
		mdaCrawlitems.modify();
	});
	//删除按钮绑定事件
	$('#mdaCrawlitems_del').bind('click', function(){  
		mdaCrawlitems.del();
	});
	//查询按钮绑定事件
	$('#mdaCrawlitems_searchPart').bind('click', function(){
		mdaCrawlitems.searchByKeyWord();
	});
	//打开高级查询框
	$('#mdaCrawlitems_searchAll').bind('click', function(){
		mdaCrawlitems.openSearchForm(this);
	});
																																																																																																																															$('#lastcrawluseridAlias').on('focus',function(e){
						new H5CommonSelect({type:'userSelect', idFiled:'lastcrawluserid',textFiled:'lastcrawluseridAlias'});
					}); 
																																																																				
});

</script>
</html>