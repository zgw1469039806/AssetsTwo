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
<!-- ControllerPath = "platform6/mda/mdadatabasecrawlconfig/mdaDatabasecrawlconfigController/toMdaDatabasecrawlconfigManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
		<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaDatabasecrawlconfig_button_add" permissionDes="添加">
  	<a id="mdaDatabasecrawlconfig_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="添加"><i class="fa fa-plus"></i> 添加</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaDatabasecrawlconfig_button_edit" permissionDes="编辑">
	<a id="mdaDatabasecrawlconfig_modify" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
	</sec:accesscontrollist>
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaDatabasecrawlconfig_button_delete" permissionDes="删除">
	<a id="mdaDatabasecrawlconfig_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist>
		</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="mdaDatabasecrawlconfig_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="mdaDatabasecrawlconfig_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="mdaDatabasecrawlconfigjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
    	   <table class="form_commonTable">
			    <tr>
																						  						   							 							 						   						   						   																																																																																																				  						   							 								<th width="10%">CRAWLITEMSID:</th>
										    								 <td width="39%">
	    								 <input title="CRAWLITEMSID" class="form-control input-sm" type="text" name="crawlitemsid" id="crawlitemsid" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">TASKNAME:</th>
										    								 <td width="39%">
	    								 <input title="TASKNAME" class="form-control input-sm" type="text" name="taskname" id="taskname" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 									<th width="10%">MODIFYTIME(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="modifytimeBegin" id="modifytimeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
										    									<th width="10%">MODIFYTIME(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="modifytimeEnd" id="modifytimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																	  </tr>
									  <tr>
								    													   						   						   																							  						   							 									<th width="10%">LASTTIMECRAWL(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="lasttimecrawlBegin" id="lasttimecrawlBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
										    									<th width="10%">LASTTIMECRAWL(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="lasttimecrawlEnd" id="lasttimecrawlEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																	  </tr>
									  <tr>
								    													   						   						   																							  						   							 								<th width="10%">UPDATEMODE:</th>
										    								 <td width="39%">
	    								 <input title="UPDATEMODE" class="form-control input-sm" type="text" name="updatemode" id="updatemode" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">SERVERIP:</th>
										    								 <td width="39%">
	    								 <input title="SERVERIP" class="form-control input-sm" type="text" name="serverip" id="serverip" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">SERVERPORT:</th>
																			<td width="39%">
										<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input title="" type="text" class="form-control" name="serverport" id="serverport"   data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										 </div>
										</td>
																								 						   						   						   																							  						   							 								<th width="10%">LOGINUSER:</th>
										    								 <td width="39%">
	    								 <input title="LOGINUSER" class="form-control input-sm" type="text" name="loginuser" id="loginuser" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">LOGINPASSWORD:</th>
										    								 <td width="39%">
	    								 <input title="LOGINPASSWORD" class="form-control input-sm" type="text" name="loginpassword" id="loginpassword" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">DATABASENAME:</th>
										    								 <td width="39%">
	    								 <input title="DATABASENAME" class="form-control input-sm" type="text" name="databasename" id="databasename" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">DATABASETYPE:</th>
										    								 <td width="39%">
	    								 <input title="DATABASETYPE" class="form-control input-sm" type="text" name="databasetype" id="databasetype" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">SELECTSQL:</th>
										    								 <td width="39%">
	    								 <input title="SELECTSQL" class="form-control input-sm" type="text" name="selectsql" id="selectsql" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">CRAWLRATE:</th>
																			<td width="39%">
										<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input title="" type="text" class="form-control" name="crawlrate" id="crawlrate"   data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										 </div>
										</td>
																								 						   						   						   																							  						   							 								<th width="10%">INDEXCOLUMNS:</th>
										    								 <td width="39%">
	    								 <input title="INDEXCOLUMNS" class="form-control input-sm" type="text" name="indexcolumns" id="indexcolumns" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">STOREMETHOD:</th>
										    								 <td width="39%">
	    								 <input title="STOREMETHOD" class="form-control input-sm" type="text" name="storemethod" id="storemethod" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">DATABASEIP:</th>
										    								 <td width="39%">
	    								 <input title="DATABASEIP" class="form-control input-sm" type="text" name="databaseip" id="databaseip" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">DATABASEPORT:</th>
																			<td width="39%">
										<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input title="" type="text" class="form-control" name="databaseport" id="databaseport"   data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										 </div>
										</td>
																								 						   						   						   																							  						   							 								<th width="10%">USERNAME:</th>
										    								 <td width="39%">
	    								 <input title="USERNAME" class="form-control input-sm" type="text" name="username" id="username" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">PASSWORD:</th>
										    								 <td width="39%">
	    								 <input title="PASSWORD" class="form-control input-sm" type="text" name="password" id="password" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">SERVERNAME:</th>
										    								 <td width="39%">
	    								 <input title="SERVERNAME" class="form-control input-sm" type="text" name="servername" id="servername" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">TABLENAME:</th>
										    								 <td width="39%">
	    								 <input title="TABLENAME" class="form-control input-sm" type="text" name="tablename" id="tablename" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">DOCNAME:</th>
										    								 <td width="39%">
	    								 <input title="DOCNAME" class="form-control input-sm" type="text" name="docname" id="docname" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">COLLECTIONS:</th>
										    								 <td width="39%">
	    								 <input title="COLLECTIONS" class="form-control input-sm" type="text" name="collections" id="collections" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">STATUS:</th>
										    								 <td width="39%">
	    								 <input title="STATUS" class="form-control input-sm" type="text" name="status" id="status" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">ITEMID:</th>
										    								 <td width="39%">
	    								 <input title="ITEMID" class="form-control input-sm" type="text" name="itemid" id="itemid" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">中间数据数据库类型:</th>
										    								 <td width="39%">
	    								 <input title="中间数据数据库类型" class="form-control input-sm" type="text" name="dbtype" id="dbtype" />
	    								 </td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 								<th width="10%">数据库配置URL:</th>
										    								 <td width="39%">
	    								 <input title="数据库配置URL" class="form-control input-sm" type="text" name="dburl" id="dburl" />
	    								 </td>
																								 						   						   						   														 </tr>
    	</table>
    </form>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdadatabasecrawlconfig/js/MdaDatabasecrawlconfig.js" type="text/javascript"></script>
<script type="text/javascript">
var mdaDatabasecrawlconfig;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mdaDatabasecrawlconfig.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="mdaDatabasecrawlconfig.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
		
$(document).ready(function () {
	var dataGridColModel =  [
																{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
																																							  																		,{ label: 'CRAWLITEMSID', name: 'crawlitemsid', width: 150}
																													  																		,{ label: 'TASKNAME', name: 'taskname', width: 150}
																													  																		,{ label: 'MODIFYTIME', name: 'modifytime', width: 150,formatter:format}
																													  																		,{ label: 'LASTTIMECRAWL', name: 'lasttimecrawl', width: 150,formatter:format}
																													  																		,{ label: 'UPDATEMODE', name: 'updatemode', width: 150}
																													  																		,{ label: 'SERVERIP', name: 'serverip', width: 150}
																													  																		,{ label: 'SERVERPORT', name: 'serverport', width: 150}
																													  																		,{ label: 'LOGINUSER', name: 'loginuser', width: 150}
																													  																		,{ label: 'LOGINPASSWORD', name: 'loginpassword', width: 150}
																													  																		,{ label: 'DATABASENAME', name: 'databasename', width: 150}
																													  																		,{ label: 'DATABASETYPE', name: 'databasetype', width: 150}
																													  																		,{ label: 'SELECTSQL', name: 'selectsql', width: 150}
																													  																		,{ label: 'CRAWLRATE', name: 'crawlrate', width: 150}
																													  																		,{ label: 'INDEXCOLUMNS', name: 'indexcolumns', width: 150}
																													  																		,{ label: 'STOREMETHOD', name: 'storemethod', width: 150}
																													  																		,{ label: 'DATABASEIP', name: 'databaseip', width: 150}
																													  																		,{ label: 'DATABASEPORT', name: 'databaseport', width: 150}
																													  																		,{ label: 'USERNAME', name: 'username', width: 150}
																													  																		,{ label: 'PASSWORD', name: 'password', width: 150}
																													  																		,{ label: 'SERVERNAME', name: 'servername', width: 150}
																													  																		,{ label: 'TABLENAME', name: 'tablename', width: 150}
																													  																		,{ label: 'DOCNAME', name: 'docname', width: 150}
																													  																		,{ label: 'COLLECTIONS', name: 'collections', width: 150}
																													  																		,{ label: 'STATUS', name: 'status', width: 150}
																													  																		,{ label: 'ITEMID', name: 'itemid', width: 150}
																													  																		,{ label: '中间数据数据库类型', name: 'dbtype', width: 150}
																													  																		,{ label: '数据库配置URL', name: 'dburl', width: 150}
																						];
	var searchNames = new Array();
	var searchTips = new Array();
						  		  																												  		         searchNames.push("crawlitemsid");
    searchTips.push("CRAWLITEMSID");
		 	 		  							  		         searchNames.push("taskname");
    searchTips.push("TASKNAME");
		 	 		  							  							  							  		     		  							  		     		  							  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  							  		     		  							  		     		  							  		     		  							  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  							  		     		  				$('#keyWord').attr('placeholder','请输入'+searchTips[0]+'或'+searchTips[1]);
	mdaDatabasecrawlconfig= new MdaDatabasecrawlconfig('mdaDatabasecrawlconfigjqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#mdaDatabasecrawlconfig_insert').bind('click', function(){
		mdaDatabasecrawlconfig.insert();
	});
	//编辑按钮绑定事件
	$('#mdaDatabasecrawlconfig_modify').bind('click', function(){
		mdaDatabasecrawlconfig.modify();
	});
	//删除按钮绑定事件
	$('#mdaDatabasecrawlconfig_del').bind('click', function(){  
		mdaDatabasecrawlconfig.del();
	});
	//查询按钮绑定事件
	$('#mdaDatabasecrawlconfig_searchPart').bind('click', function(){
		mdaDatabasecrawlconfig.searchByKeyWord();
	});
	//打开高级查询框
	$('#mdaDatabasecrawlconfig_searchAll').bind('click', function(){
		mdaDatabasecrawlconfig.openSearchForm(this);
	});
																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																				
});

</script>
</html>