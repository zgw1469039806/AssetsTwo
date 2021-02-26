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
<!-- ControllerPath = "platform6/mda/mdatask/mdaTaskController/toMdaTaskManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body>
<div id="tableToolbar" class="toolbar">
	<div class="toolbar-left">
	<sec:accesscontrollist hasPermission="3" domainObject="formdialog_mdaTask_button_delete" permissionDes="删除">
	<a id="mdaTask_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="删除"><i class="fa fa-trash-o"></i> 删除</a>
	</sec:accesscontrollist>
		</div>
    <div class="toolbar-right">
	    <div class="input-group form-tool-search">
     		<input type="text" name="keyWord" id="keyWord" style="width:240px;" class="form-control input-sm" placeholder="请输入查询条件">
     		<label id="mdaTask_searchPart" class="icon icon-search form-tool-searchicon"></label>
   		</div>
   		<div class="input-group-btn form-tool-searchbtn">
   			<a id="mdaTask_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button" title="高级查询">高级查询 <span class="caret"></span></a>
   		</div>
    </div>
</div>					
<table id="mdaTaskjqGrid"></table>
<div id="jqGridPager"></div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
	<form id="form" style="padding: 10px;">
    	   <table class="form_commonTable">
			    <tr>
			     <th width="10%">任务名称:</th>
					<td width="39%">
	    				<input title="任务名称" class="form-control input-sm" type="text" name="taskname" id="taskname" />
	    				 </td>
				     <th width="10%">爬取类型:</th>
							<td width="39%">
                                     <pt6:h5select css_class="form-control input-sm" name="crawltype" id="crawltype" title="爬取类型" isNull="true" lookupCode="MDA_ITEMTYPE" />
                                     </td>
                                     																	</tr>
									<tr>
									<th width="10%">采集项:</th>
										    								 <td width="39%">
	    								 <input title="采集项" class="form-control input-sm" type="text" name="crawlconfigid" id="crawlconfigid" />
	    								 </td>
																								 	<th width="10%">超时时间:</th>
																			<td width="39%">
										<div class="input-group input-group-sm spinner" data-trigger="spinner">
										  <input title="" type="text" class="form-control" name="timeoutmillis" id="timeoutmillis"   data-min="0" data-max="999999999999" data-step="1" data-precision="0">
										  <span class="input-group-addon">
										    <a href="javascript:;" class="spin-up" data-spin="up"><i class="glyphicon glyphicon-triangle-top"></i></a>
										    <a href="javascript:;" class="spin-down" data-spin="down"><i class="glyphicon glyphicon-triangle-bottom"></i></a>
										  </span>
										 </div>
										</td>
																										</tr>
									<tr>
															 						   						   						   																							  						   							 									<th width="10%">开始时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="starttimeBegin" id="starttimeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
										    									<th width="10%">开始时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="starttimeEnd" id="starttimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																	  </tr>
									  <tr>
								    													   						   						   																							  						   							 									<th width="10%">结束时间(从):</th>
    								   <td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="finishtimeBegin" id="finishtimeBegin" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
										    									<th width="10%">结束时间(至):</th>
    									<td width="39%">
    									<div class="input-group input-group-sm">
											<input class="form-control date-picker" type="text" name="finishtimeEnd" id="finishtimeEnd" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										</div>
    									</td>
    																	  </tr>
									  <tr>
								    													   						   						   																																																								  						   							 								<th width="10%">输出数据:</th>
										    								 <td width="39%">
	    								 <input title="输出数据" class="form-control input-sm" type="text" name="outputdata" id="outputdata" />
	    								 </td>
																								 						   						   						   																																		  						   							 								<th width="10%">采集结果:</th>
																		 <td width="39%">
                                     <pt6:h5select css_class="form-control input-sm" name="runstatus" id="runstatus" title="采集结果" isNull="true" lookupCode="MDA_RUNSTATUS" />
                                     </td>
                                     																	</tr>
									<tr>
															 						   						   						   																																		  						   							 								<th width="10%">任务优先级:</th>
										    								 <td width="39%">
	    								 <input title="任务优先级" class="form-control input-sm" type="text" name="tasklevel" id="tasklevel" />
	    								 </td>
																								 						   						   						   																							  						   							 								<th width="10%">分类:</th>
										    								 <td width="39%">
	    								 <input title="分类" class="form-control input-sm" type="text" name="classifyids" id="classifyids" />
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
<script src="avicit/platform6/mda/mdatask/js/MdaTask.js" type="text/javascript"></script>
<script type="text/javascript">
var mdaTask;
function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="mdaTask.detail(\''+rowObject.id+'\');">'+cellvalue+'</a>';
 }
function formatDateForHref(cellvalue, options, rowObject){
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="mdaTask.detail(\''+rowObject.id+'\');">'+thisDate+'</a>';
}
		
$(document).ready(function () {
	var dataGridColModel =  [
							{ label: 'id', name: 'id', key: true, width: 75, hidden:true }
							,{ label: '任务名称', name: 'taskname', width: 150}
							,{ label: '任务优先级', name: 'tasklevel', width: 150}
							,{ label: '分类', name: 'classifyids', width: 150}
					        ,{ label: '采集项名称', name: 'crawlconfigid', width: 150}
							,{ label: '采集类型', name: 'crawltype', width: 150}
							,{ label: '采集结果', name: 'runstatus', width: 150}
					 	   // ,{ label: '超时时间', name: 'timeoutmillis', width: 150}
							,{ label: '执行时间', name: 'starttime', width: 150,formatter:format}
							//,{ label: '结束时间', name: 'finishtime', width: 150,formatter:format}
							//,{ label: '输出数据', name: 'outputdata', width: 150}
						];
	var searchNames = new Array();
	var searchTips = new Array();
						  		  									searchNames.push("taskname");
    searchTips.push("任务名称");
		 	 		  							  		  							  		         searchNames.push("crawlconfigid");
    searchTips.push("采集项");
		 	 		  							  							  							  																  		     		  										  		  										 $('#keyWord').attr('placeholder','请输入'+searchTips[0]+'或'+searchTips[1]);
	mdaTask= new MdaTask('mdaTaskjqGrid','${url}','searchDialog','form','keyWord',searchNames,dataGridColModel);
	//添加按钮绑定事件
	$('#mdaTask_insert').bind('click', function(){
		mdaTask.insert();
	});
	//编辑按钮绑定事件
	$('#mdaTask_modify').bind('click', function(){
		mdaTask.modify();
	});
	//删除按钮绑定事件
	$('#mdaTask_del').bind('click', function(){  
		mdaTask.del();
	});
	//查询按钮绑定事件
	$('#mdaTask_searchPart').bind('click', function(){
		mdaTask.searchByKeyWord();
	});
	//打开高级查询框
	$('#mdaTask_searchAll').bind('click', function(){
		mdaTask.openSearchForm(this);
	});
																																																																																																																																																																																																																																																
});

</script>
</html>